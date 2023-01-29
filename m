Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04CE680090
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jan 2023 18:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjA2RtV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 12:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjA2RtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 12:49:17 -0500
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D361B550;
        Sun, 29 Jan 2023 09:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1675014549;
        bh=F9PpH+TDLDlueIEXS+EiVubPXgY46d3dQ43D7ug3jE8=;
        h=From:To:Cc:Subject:Date;
        b=WmbLuGKWL/ixF0BYP4TumTOK5+e/dIZVXaFi0kKy6q2YOXe7oH54e8+szXQELM0zY
         H+kmihUKPX6Zo1tWOPlb9bb0YEqO24W4iDNYgfP81/OGYViMRe5WG7EraCJ8HXl0dp
         aHJy6p5kKEhnVX1c5PrR8WWR9l1F82yZqEF1Y9Bo=
Received: from wen-VirtualBox.lan ([222.182.118.145])
        by newxmesmtplogicsvrsza2-0.qq.com (NewEsmtp) with SMTP
        id BEC84CF4; Mon, 30 Jan 2023 01:47:44 +0800
X-QQ-mid: xmsmtpt1675014464tep5mnyr1
Message-ID: <tencent_426EBA1E33855FC0B362550EB554D0E6E406@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnQL0jg3ka8wyk0jP5cKGE5x+J+DMIQTBlifB/YGNiy8IeMneMZk
         +rRQLtzqkEqOrCpMGl6Sv5L2xDt6FxI5DE+pbf53+sUCqtbLfptuEl/NQmEknS35USI5/p6OWZ6u
         LxyEHMJj69v86PjMMdCDGRIi2SUTxjPbhjO6JRfGXMiHL03BmGB9TlcbdJZNDWxAlDoQQVJdfcWE
         /o/7Gnfp9bOzVmzm+Aub9HGnatGwynzB4+XEQ1FJ4FAuhWjxxXBjeBt2QV9e+1ANVQFUGphYfyvY
         lNhRjZZJSm5PNr9tVood+q4CRW8GKRMwwYcWvpineeTn4X/+FBHhsuNv+5HRqp17fz5K+yE90JCz
         /ntY8GO3GU8XslkL3LnAvmZtiVXXuHaSfGkfrLTXCmsNZg30Bk6FYMbuU2OoIK3lrVSQxZ47/mys
         16nIRXrjN4kc4aO8avJaKDq9v/+dGYU1OIIngrj4ZKt8tIoufoYfKhTlFA8fhR5jsFIHmhwPUIHs
         uJNr4NdXvO6NaxHx/d3M+O42rig21D+z6I8x4zWNzu+AXz4A6bOuKR8ZgTaUB59Fufdsd+1Uc9rk
         ZduaQzC3O6rag0gBCwasoPgzjkC/WT+VNht8DhRgbabCC13HDwpuxuS6finJJWjvk5SVIbpq+4Cg
         PjXU5awG6R5AfVBHuMV7fj/d6AGXYqr0EqZCiJh/CgSE3VmAgXHf4fl+lRCXRhkiArjOrGnga7+V
         QoHLOxzcfQ1EGzb4jtSr3AXa8CmgOBO0gcU8oSgr+JiCueEN2vHKZuermOcVgIsnMlqLi7+pBRkh
         3FxfiPymSyhCd9VyjG9GT8R4ffSKZWvTEWwVnbz0io6CsvFJZKvBj5DPusbBGtJMIVY7Cmw0tcsH
         WFyCjvZsdEP4mD3kC2gxJRKVa1dYin45Zr2qVFghagVTfMPAB7EoWTUZpMg6bqrAvFdb4bLuqvkQ
         ZoC5rp0HLAP0E+XlfvdYpmISk1bLARhZ2aQxk95ssw2PPKHzS4y4yak7rOVeWx
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] eventfd: use wait_event_interruptible_locked_irq() helper
Date:   Mon, 30 Jan 2023 01:47:20 +0800
X-OQ-MSGID: <20230129174721.18155-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.37.2
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
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kernel test robot <lkp@intel.com>
Cc: Dan Carpenter <error27@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventfd.c | 41 +++++++----------------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 249ca6c0b784..c5bda3df4a28 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -228,7 +228,6 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct eventfd_ctx *ctx = file->private_data;
 	__u64 ucnt = 0;
-	DECLARE_WAITQUEUE(wait, current);
 
 	if (iov_iter_count(to) < sizeof(ucnt))
 		return -EINVAL;
@@ -239,23 +238,11 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
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
+
+		if (wait_event_interruptible_locked_irq(ctx->wqh, ctx->count)) {
 			spin_unlock_irq(&ctx->wqh.lock);
-			schedule();
-			spin_lock_irq(&ctx->wqh.lock);
+			return -ERESTARTSYS;
 		}
-		__remove_wait_queue(&ctx->wqh, &wait);
-		__set_current_state(TASK_RUNNING);
 	}
 	eventfd_ctx_do_read(ctx, &ucnt);
 	current->in_eventfd = 1;
@@ -275,7 +262,6 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	struct eventfd_ctx *ctx = file->private_data;
 	ssize_t res;
 	__u64 ucnt;
-	DECLARE_WAITQUEUE(wait, current);
 
 	if (count < sizeof(ucnt))
 		return -EINVAL;
@@ -288,23 +274,10 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
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
+			res = sizeof(ucnt);
 	}
 	if (likely(res > 0)) {
 		ctx->count += ucnt;
-- 
2.37.2

