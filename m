Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B01F66B1A5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jan 2023 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjAOOtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Jan 2023 09:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjAOOtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Jan 2023 09:49:12 -0500
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6304F10401;
        Sun, 15 Jan 2023 06:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673794143;
        bh=ndxiOKIjgMog/hMr4F9xvx2c1YwIDASPYXvZJKXmyfg=;
        h=From:To:Cc:Subject:Date;
        b=MjZRB76581YOWXPquSibalgaepyv0r2leB0d7VhYYoeFMwA2uS6oRWR3Us4KZAErm
         8l/b53y95jRNe1v2J1+1C7qeAuVQ0Emn4OGdc9omJePDkp1MY9c+aO/QLVUALiECsT
         dyxvHllwuPv5kYhyo2G3XjhR2/k4Dih37QlUf7eE=
Received: from localhost.localdomain ([119.4.52.193])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id C41B8881; Sun, 15 Jan 2023 22:49:01 +0800
X-QQ-mid: xmsmtpt1673794141t4gkux1a8
Message-ID: <tencent_B0E8F40B6620BFE2E79CAA06EAADA085C907@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeJ98xPC2ML3gxFdU9GLYGLIJpFY6vbaR9HG+2YTSlQeNnZX6DLb
         ypj1mQKa+3bunvAFHycNbTWFcJb0vtW3ODdtiQM0ThhY7UrnEJzPbdQkilLP8AElJnRcVvc51Xvf
         qgeSoeX0ICRgnlTSRHWovj/9Tjx8gCPWaXWEaWGOmzDSlzmPD7uj2TaZ9uvFdcJwZJV8UBauT916
         i7o2j3OKzl179IDiXs2eAZc53Zs3oUt56uURkOcb3Wlo1kMDW11UndPJ2tbhEijNuSmPV/LB5mpx
         XFmZI5xNGGu+jLOLL2m1yckbBVXcFvJhcqbZxbQqwXqDnUPxo4p5f20oEBBA9R/giO3ZIjjKHiCT
         afbES7PnVCXwnhfFdJdRVgOpQ8cCRh5bSkZUwqP/oGlo/xwzI4vCUB9bWM3QSaxtph+M1LwSIjr8
         tLTNNICrMXgNr1U78uIrn14M2oCczfigG2QReV7tlIv3KqDQTV7eKxVyP5CjZRqSTRnYEkiiCgJG
         TPwOw33K3gw95A1LnJ54SwH2apzf/vTgFX9jVjMIbV3ESw8WLj9Nx+aAwb2eY3/MNL0kLjzn/csr
         iykufJr1GFnA0OkaQ9kaUJFNz1EYS7xCVvoh421urNAH2kTuD9O0Q+Nu9x2t7B/0r1AX/82900ik
         Yr7ebZgOfdsSkloGnYl8EF6gnxhGEpwr59/+IZkFtylaChozbV+WoeTYumL/dbcnSxGcqRmECM/5
         QfYhWthFXTNSf3XETAAR2n2TXBrOPulGyFoOchhhf4rzMIqH6dcpOV5TdG+hTzOLFqAzGLHslKN5
         m8jOVLlHr7lENggsYUgkxVDcLiCRP6m9vt0kw1Lrl4CdZUmGAFeQaYagmEvXOG5SCsL22D6bUFmP
         IjSWAwK3BJbsK6C+dJsWybDE1Bh+lGLKmFSWL4KjREkX7wEsfBTQXoRoIYobRb4gG8U1UDt55XYA
         1OPwcawgSUdmE23hA7Q2R2vw3scoq7
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] eventfd: use a generic helper instead of an open coded wait_event
Date:   Sun, 15 Jan 2023 22:48:29 +0800
X-OQ-MSGID: <20230115144829.9786-1-wenyang.linux@foxmail.com>
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
Cc: kernel test robot <lkp@intel.com>
Cc: Dan Carpenter <error27@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
v2:
- fix smatch warnings: eventfd_read() warn: inconsistent returns '&ctx->wqh.lock'.

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
2.25.1

