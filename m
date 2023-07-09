Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1032C74C156
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 08:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGIGzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 02:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGIGzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 02:55:09 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D76194;
        Sat,  8 Jul 2023 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688885698;
        bh=RYnRkhoiWyoPGBS8qvwcJycA+ytn5C6WTnj7Eo5dpTU=;
        h=From:To:Cc:Subject:Date;
        b=sMqGuhMbvQghEJKme7cguoZfCY5k3AZxQX4EByRz1cbztENQOhWfFDLrqHJuyCqTP
         gpDAat4+mRTBsjD7wWa8L69F+Fy8zPGBT4Zs/cnrxM6y12/6Gqo1UNcfFF9Ywl5M1v
         lALrfd1tSK7PGHgQUdPf08GiXWxY5a8LgO9vdKzM=
Received: from localhost.localdomain ([101.204.11.166])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id DB52CCC2; Sun, 09 Jul 2023 14:54:53 +0800
X-QQ-mid: xmsmtpt1688885693tz3hyo0pa
Message-ID: <tencent_7588DFD1F365950A757310D764517A14B306@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTCJvJTNp4omwklKlrOQIfCb8xnUYbHI7xHSo18zpysdANv1MuoS
         8ynPsLYwvLhHBy59rNSftYnoq8OrtdHIm4a1FWeoKhw1abB22J43xobsIlmtooTlUwfqV6B6/9kH
         WGI5BUNQfYK0Y8iRpVQTjXqSL2Hh4NmanTIZcWxvJ5b785rr5PHekI287zrH2qvDG4AnwaMYCi7M
         +fUBDMsG6BsEGikYW6pVpH/ZTwzChOrc7u94vI7KqCKHN6VynnB+FZi15PIlWpp8FUivo2N+0ksm
         ZtWKuhVJN+x1+9EBCsY81ns+nfMUVCrBgPOTDK0sNv32zbY00TTJErM0VNt+LWxcZNjqbG6zzXYI
         q02xcu6DsNGQIYtjbTWkOfcR+LRu+pB7m8aGeAXQeB/ixe9D2x4flG8c7uqwNQ3wouSo73fW8Ok+
         ENIkuT1fXyPO6Lt9ncRHTqTSSIH50u4cRVKMc4/+TSPlS9ODI5n3KUrUr8y/3DbChHgz69ocmyqD
         rdfEb+EUwXKjblf3p5rid+vrEPDOjyPGO6RDr0FiH9CCy8ERFC4zFvTG4j0AmAtBlffj1NlSZ6o6
         YTgS80I/YzOpsZK839xESjexl46KUL5sIgqfo7c2ZrhRtgP++ApS8fyqkjtAZyRZwiGWDqIz+Rem
         2xwGaVYExi/Z07gxlaAx1hc8G7pWvRbS7Ez8dkeO+tCsxMSwSsd0nQ88gREHjytEKvhBedNj4YgG
         YP2hkwaKwKBexZpTU3dg3TX8w7rTPWNrbTcAt6F01Gcj/Fu5mjSdwxEoXVZ2YiutQLNixRGfu3i4
         l1YWGJersjNDMgAjsaAnVONQZl4vNxAsI194qZabDIOLSNJBpTuScEKcxLQ4OyNUxiGxk+LmFe5T
         HsR4jFLwv++hAYQysNNrI0HQ9AGC+xHXDJnPhwdAeda/3zB8uBFJH+7qRkwPXDwQHzbAD/y8FP86
         A++qR9cmquuO1H5+7qKMotx7MeRSu3EdV9cm0OwFgtX/JzW3hVDdSMwrwcR9z4
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] eventfd: avoid overflow to ULLONG_MAX when ctx->count is 0
Date:   Sun,  9 Jul 2023 14:54:51 +0800
X-OQ-MSGID: <20230709065451.107710-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

For eventfd with flag EFD_SEMAPHORE, when its ctx->count is 0, calling
eventfd_ctx_do_read will cause ctx->count to overflow to ULLONG_MAX.

Fixes: cb289d6244a3 ("eventfd - allow atomic read and waitqueue remove")
Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventfd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 8aa36cd37351..10a101df19cd 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -189,7 +189,7 @@ void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
 {
 	lockdep_assert_held(&ctx->wqh.lock);
 
-	*cnt = (ctx->flags & EFD_SEMAPHORE) ? 1 : ctx->count;
+	*cnt = ((ctx->flags & EFD_SEMAPHORE) && ctx->count) ? 1 : ctx->count;
 	ctx->count -= *cnt;
 }
 EXPORT_SYMBOL_GPL(eventfd_ctx_do_read);
@@ -269,6 +269,8 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 		return -EFAULT;
 	if (ucnt == ULLONG_MAX)
 		return -EINVAL;
+	if ((ctx->flags & EFD_SEMAPHORE) && !ucnt)
+		return -EINVAL;
 	spin_lock_irq(&ctx->wqh.lock);
 	res = -EAGAIN;
 	if (ULLONG_MAX - ctx->count > ucnt)
-- 
2.25.1

