Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2652115EB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 10:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEGIAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 04:00:41 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:37337 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfEGIAk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 04:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1557216030;
        bh=5P86jqYLNxP7dBuvAXYQSd5hJWVKbDW1Nl9wv7F3f5Y=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=XX7LmFfwVXXP2rdZDOW+bRu42xI5f1Z2Mi1Q6WlXJhT4sJvvd5n4TVxPPyx27xQMP
         d3SUXcaRaBbgm/txYCTPIA4TG3GSWhdWBnNlj089HYm5ccFSfXjfrALMkJS8EmW73e
         v0IvVwCv9CS2gjl7MqhFmpt4dBg+Vwwb0ZFr47g0=
X-QQ-mid: esmtp2t1557216028t07wo0fkg
Received: from localhost.localdomain (unknown [61.48.57.6])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 07 May 2019 16:00:16 +0800 (CST)
X-QQ-SSF: 01000000000000F0FH4000000000000
X-QQ-FEAT: EUGmOqWjSYKFaqy0ZsdOePIZwnO1LXWVJQU3r7Ml5YtZCnQ2S0khXurvWCaru
        Tkod1/s/HN268J3aFlsQHkqqaygXlidW1rjfOzRZgXmouVO0kwd3UxvNmX+3mpTS3ScdiDs
        tKEzu6WeWtI1BMUrTWRjJhd2yOMyuFdswKRerV46uhKTDlJH3L467MMWLumVUDksncfY6Tx
        Quk66nBOWG1y7qBIzkhJXmAo5/FduI7ohdN+/NqElHlF5AqdnsVXvYJ7OFY4Mn3S5EAfZu8
        Zb9fyhAKWG8DZasrvgI3OpaokUMaVzen8ZXg==
X-QQ-GoodBg: 0
From:   Shenghui Wang <shhuiw@foxmail.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     jmoyer@redhat.com
Subject: [PATCH] io_uring: use cpu_online() to check p->sq_thread_cpu instead of cpu_possible()
Date:   Tue,  7 May 2019 16:00:16 +0800
Message-Id: <20190507080016.1945-1-shhuiw@foxmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This issue is found by running liburing/test/io_uring_setup test.

When test run, the testcase "attempt to bind to invalid cpu" would not
pass with messages like:
   io_uring_setup(1, 0xbfc2f7c8), \
flags: IORING_SETUP_SQPOLL|IORING_SETUP_SQ_AFF, \
resv: 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000, \
sq_thread_cpu: 2
   expected -1, got 3
   FAIL

On my system, there is:
   CPU(s) possible : 0-3
   CPU(s) online   : 0-1
   CPU(s) offline  : 2-3
   CPU(s) present  : 0-1

The sq_thread_cpu 2 is offline on my system, so the bind should fail.
But cpu_possible() will pass the check. We shouldn't be able to bind
to an offline cpu. Use cpu_online() to do the check.

After the change, the testcase run as expected: EINVAL will be returned
for cpu offlined.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d91cbd53d3ca..718d7b873f4a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2472,7 +2472,7 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 							nr_cpu_ids);
 
 			ret = -EINVAL;
-			if (!cpu_possible(cpu))
+			if (!cpu_online(cpu))
 				goto err;
 
 			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
-- 
2.20.1



