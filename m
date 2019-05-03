Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E391512AEF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 11:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfECJrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 05:47:18 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:42212 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfECJrS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 05:47:18 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 58E06C03032;
        Fri,  3 May 2019 09:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556876836;
        bh=8+kXuY98+W8tyqbYrsTP9FqwRaPVAvdHgIM7oSTEc+w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b6Cwoxfbz8qLTiBDRTt0VpKv/TnA/4mAqEBepvwfLoCeY447RwJ12pNOp/X4h6yua
         /oiVh+k1ZiQIslWBb7evQj81lgguXJ85HdEtJvknt6IhlOZnOYZW5+12WkRJ2ptnJi
         TChVIcgwEJCHvgE5FxctvPLNiGkk0Rqsf7jVf62M=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] io_uring: punt to workers if file doesn't support async
Date:   Fri,  3 May 2019 11:47:15 +0200
Message-Id: <20190503094715.2381-2-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503094715.2381-1-source@stbuehler.de>
References: <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
 <20190503094715.2381-1-source@stbuehler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If force_nonblock is set we must not try io operations that don't
support async (i.e. are missing the IOCB_NOWAIT flag).

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 52e435a72b6f..1be7fdb65c3f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1064,6 +1064,11 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 		return ret;
 	iov_count = iov_iter_count(&iter);
 
+	/* async punt if file doesn't support non-blocking */
+	ret = -EAGAIN;
+	if (force_nonblock && !(kiocb->ki_flags & IOCB_NOWAIT))
+		goto out_free;
+
 	ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_count);
 	if (ret)
 		goto out_free;
@@ -1109,6 +1114,11 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 		return ret;
 	iov_count = iov_iter_count(&iter);
 
+	/* async punt if file doesn't support non-blocking */
+	ret = -EAGAIN;
+	if (force_nonblock && !(kiocb->ki_flags & IOCB_NOWAIT))
+		goto out_free;
+
 	ret = -EAGAIN;
 	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT))
 		goto out_free;
-- 
2.20.1

