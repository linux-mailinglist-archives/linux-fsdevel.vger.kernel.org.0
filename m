Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05EE1079F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 13:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEALwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 07:52:25 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:59018 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfEALwZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 07:52:25 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id B1CF5C02FF6;
        Wed,  1 May 2019 11:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556711543;
        bh=PUQr4P3BXfyj0hMJDjsWKhw3mSXtqoOIYJmU+5Cyki8=;
        h=From:To:Subject:Date:From;
        b=AbWPICHKqUfIC/lFM/7a4ZJM/XVNMCgQBVJ2bM7P/K79hNPqohove4haG2NESP4/8
         EgwOjh8unm+jMnCFAwdwEDmIQ0MbESXirme+kO8SHF7nd2LduhpNRCv57fHZw36WxZ
         NNdLZCJv/mrbQe3vNR6SYIMOf+bTe2e/5qcQaJqA=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 1/1] [io_uring] require RWF_HIPRI for iopoll reads and writes
Date:   Wed,  1 May 2019 13:52:23 +0200
Message-Id: <20190501115223.13296-1-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This makes the mapping RWF_HIPRI <-> IOCB_HIPRI <-> iopoll more
consistent; it also allows supporting iopoll operations without
IORING_SETUP_IOPOLL in the future.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 17eae94a54fc..6a480f04b0f3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -881,14 +881,16 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 		kiocb->ki_flags |= IOCB_NOWAIT;
 
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
+		/* require O_DIRECT (or DAX) and RWF_HIPRI */
 		if (!(kiocb->ki_flags & IOCB_DIRECT) ||
+		    !(kiocb->ki_flags & IOCB_HIPRI) ||
 		    !kiocb->ki_filp->f_op->iopoll)
 			return -EOPNOTSUPP;
 
 		req->error = 0;
-		kiocb->ki_flags |= IOCB_HIPRI;
 		kiocb->ki_complete = io_complete_rw_iopoll;
 	} else {
+		/* RWF_HIPRI not allowed */
 		if (kiocb->ki_flags & IOCB_HIPRI)
 			return -EINVAL;
 		kiocb->ki_complete = io_complete_rw;
-- 
2.20.1

