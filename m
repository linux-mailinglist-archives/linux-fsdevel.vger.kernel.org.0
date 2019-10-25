Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B030E4B66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 14:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409058AbfJYMnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 08:43:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44118 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407216AbfJYMnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:43:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iNyvz-0008LJ-IN; Fri, 25 Oct 2019 12:43:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] io-wq: fix unintentional integer overflow on left shift
Date:   Fri, 25 Oct 2019 13:43:15 +0100
Message-Id: <20191025124315.21742-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Shifting the integer value 1U is evaluated with type unsigned int
using 32-bit arithmetic and then used in an expression that expects
a 64-bit value, so there is potentially an integer overflow. Fix this
by using the BIT_ULL macro to perform the shift and avoid the overflow.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: 46134db8fdc5 ("io-wq: small threadpool implementation for io_uring")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/io-wq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 35e94792d47c..ea5d37193f31 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -228,8 +228,8 @@ static struct io_wq_work *io_get_next_work(struct io_wqe *wqe, unsigned *hash)
 
 		/* hashed, can run if not already running */
 		*hash = work->flags >> IO_WQ_HASH_SHIFT;
-		if (!(wqe->hash_map & (1U << *hash))) {
-			wqe->hash_map |= (1U << *hash);
+		if (!(wqe->hash_map & BIT_ULL(*hash))) {
+			wqe->hash_map |= BIT_ULL(*hash);
 			list_del(&work->list);
 			return work;
 		}
-- 
2.20.1

