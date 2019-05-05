Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCCD142A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 00:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfEEWBZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 May 2019 18:01:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56926 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfEEWBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 May 2019 18:01:25 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hNPCE-00019B-T5; Sun, 05 May 2019 22:01:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: fix shadowed variable ret return code being not checked
Date:   Sun,  5 May 2019 23:01:22 +0100
Message-Id: <20190505220122.5024-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently variable ret is declared in a while-loop code block that
shadows another variable ret. When an error occurs in the while-loop
the error return in ret is not being set in the outer code block and
so the error check on ret is always going to be checking on the wrong
ret variable resulting in check that is always going to be true and
a premature return occurs.

Fix this by removing the declaration of the inner while-loop variable
ret so that shadowing does not occur.

Addresses-Coverity: ("'Constant' variable guards dead code")
Fixes: 6b06314c47e1 ("io_uring: add file set registration")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/io_uring.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 452e35357865..50f965060ef1 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2363,7 +2363,6 @@ static int io_sqe_files_scm(struct io_ring_ctx *ctx)
 	left = ctx->nr_user_files;
 	while (left) {
 		unsigned this_files = min_t(unsigned, left, SCM_MAX_FD);
-		int ret;
 
 		ret = __io_sqe_files_scm(ctx, this_files, total);
 		if (ret)
-- 
2.20.1

