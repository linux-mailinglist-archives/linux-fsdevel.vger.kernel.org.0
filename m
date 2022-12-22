Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D160E6543CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 16:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiLVPGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 10:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbiLVPGR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:06:17 -0500
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6EC2253A;
        Thu, 22 Dec 2022 07:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1671721564;
        bh=qWvhPFkxHOCw18z6l8gnbRxNK5NNo+0WZuA+FGjUVJo=;
        h=From:To:Cc:Subject:Date;
        b=iCHCuIlDGueNA+LavRIq2LscZn8zHFg/Ondq1gq6K+4Azaasqq+HUCqkFaDz7z7VJ
         Vtv4/2wBT8kUg6EGO3DLAv9IPA4C8khelfxoCJSt85bog9mY7IZmolPIA9sssr934T
         Hn49yo4S6rjQsG0LUnqVhK/cePBKSg7tprVMxUGQ=
Received: from wen-VirtualBox.lan ([222.182.118.246])
        by newxmesmtplogicsvrsza2-0.qq.com (NewEsmtp) with SMTP
        id 180A06B2; Thu, 22 Dec 2022 23:06:00 +0800
X-QQ-mid: xmsmtpt1671721560txq9dgjgs
Message-ID: <tencent_B38979DE0FF3B9B3EA887A37487B123BBD05@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieZhEVUGBRfdeskQHM+wLLc6O0DDT56u6OXEDqKbv/OCJieHhgG+
         R4ZP76y2PVchPdP70r94/V8Bm6jfLZdrwuV2mlJW3EFWWNYaVEyXeTc0RKkEyTAXl304mB8wD+hx
         zSnOhqPfHmRGLMS+9QE1Ind8z+XXyw97XtHY6ieqSzFRZIm9mFPYrC8ACxA9dU45SVoIALUP/tHR
         Rry7avhQoB3G3s7yar3cI3IDnbLNCkUaf3maEfFAGsNbT38BvXkgbN2fbhFR6TPMiaKJ922vW84/
         2Gwtcl63xzc/QlUqCj6ymr9wam+vpFvU97CwmkFI5E9ZorlQvouR1UGbM2BvhLG/SPw7pQthRoKY
         hiz5zMWpc+DrG5QdU1jSwH5YjejNqMZvpquo6X73fUxtzIGi/c6/B57tmW1jRMp7LyhkE1cismsw
         A7985Gl54dAqpBkm4Gj7t9/v5g4tdm0hRoPrTZUzaMfHZMLcs3Um0iIzL0jPxCOQGW1AXgYWv/zm
         92O1xosZ0zWJYIJ0FFr5MTOlVB0HO27cZsbhEgutFr0+DgPbhDK9I6uIXsizlzgCWplc1cjR4Kov
         398cPUsMVdx6OYpaMJrTz6S8/pmHuH3gegIw4duOMLYjYyXlXfnzIQXXVhhfH6PGh0L4P/0qHbTn
         wbyjbtngAY3WVb00D0YLTyvnJyMZhm/pNEpuGmtMshlGo1ZI2xCEhyB6OfsNX8jdkwY+H0DWBLyE
         nEywgkmbnhmOKklXKl6Ox9yaZe3kcYhHsQHqvujXYR6YQdTVdIT30upQrXxlBtIEMuYssaNgSs0h
         ELRM0izRcYyuW80X/P/EE6OQx/Tli46BWHiC6LWiOaHt5GjBSjnUlJoJI46ieWqX7/Rx0T022qij
         qRpA9JfZM8iYxGYOcaaWMp4ERBGw0h5r96nezi1TvLz7CzIBgFpQoAFLFNF/CAmT7FxbVybbMQiX
         cib1tQ0vY37DU/mJIMR7C9o2ODJcHDQeG/JcWXBW2lGYjvDGwX3CmbkPQqCZ0XSP8ePWJJmM1vZ5
         hjRCHPFgCPhFWcCmRsTR9cKlUsj2q112qBUNfplA==
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] eventfd: use a generic helper instead of an open coded wait_event
Date:   Thu, 22 Dec 2022 23:05:52 +0800
X-OQ-MSGID: <20221222150552.190999-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

Use wait_event_interruptible_locked_irq() in the eventfd_{write,read} to
avoid the longer, open coded equivalent.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventfd.c | 43 +++++++------------------------------------
 1 file changed, 7 insertions(+), 36 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 249ca6c0b784..5ff944a17d6d 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -228,7 +228,6 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct eventfd_ctx *ctx = file->private_data;
 	__u64 ucnt = 0;
-	DECLARE_WAITQUEUE(wait, current);
 
 	if (iov_iter_count(to) < sizeof(ucnt))
 		return -EINVAL;
@@ -239,23 +238,9 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 			spin_unlock_irq(&ctx->wqh.lock);
 			return -EAGAIN;
 		}
-		__add_wait_queue(&ctx->wqh, &wait);
-		for (;;) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			if (ctx->count)
-				break;
-			if (signal_pending(current)) {
-				__remove_wait_queue(&ctx->wqh, &wait);
-				__set_current_state(TASK_RUNNING);
-				spin_unlock_irq(&ctx->wqh.lock);
-				return -ERESTARTSYS;
-			}
-			spin_unlock_irq(&ctx->wqh.lock);
-			schedule();
-			spin_lock_irq(&ctx->wqh.lock);
-		}
-		__remove_wait_queue(&ctx->wqh, &wait);
-		__set_current_state(TASK_RUNNING);
+
+		if (wait_event_interruptible_locked_irq(ctx->wqh, ctx->count))
+			return -ERESTARTSYS;
 	}
 	eventfd_ctx_do_read(ctx, &ucnt);
 	current->in_eventfd = 1;
@@ -275,7 +260,6 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	struct eventfd_ctx *ctx = file->private_data;
 	ssize_t res;
 	__u64 ucnt;
-	DECLARE_WAITQUEUE(wait, current);
 
 	if (count < sizeof(ucnt))
 		return -EINVAL;
@@ -288,23 +272,10 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	if (ULLONG_MAX - ctx->count > ucnt)
 		res = sizeof(ucnt);
 	else if (!(file->f_flags & O_NONBLOCK)) {
-		__add_wait_queue(&ctx->wqh, &wait);
-		for (res = 0;;) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			if (ULLONG_MAX - ctx->count > ucnt) {
-				res = sizeof(ucnt);
-				break;
-			}
-			if (signal_pending(current)) {
-				res = -ERESTARTSYS;
-				break;
-			}
-			spin_unlock_irq(&ctx->wqh.lock);
-			schedule();
-			spin_lock_irq(&ctx->wqh.lock);
-		}
-		__remove_wait_queue(&ctx->wqh, &wait);
-		__set_current_state(TASK_RUNNING);
+		res = wait_event_interruptible_locked_irq(ctx->wqh,
+							  ULLONG_MAX - ctx->count > ucnt);
+		if (!res)
+			res =  sizeof(ucnt);
 	}
 	if (likely(res > 0)) {
 		ctx->count += ucnt;
-- 
2.25.1

