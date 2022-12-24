Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ED7655A55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Dec 2022 15:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiLXOhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Dec 2022 09:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiLXOhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Dec 2022 09:37:50 -0500
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFC8DED3;
        Sat, 24 Dec 2022 06:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1671892663;
        bh=ndxiOKIjgMog/hMr4F9xvx2c1YwIDASPYXvZJKXmyfg=;
        h=From:To:Cc:Subject:Date;
        b=SCuDBnExk7b7BS04kV39QCy3kKTfzm0VndGq2NvOeBEJALLOVboaUmWQ1S61sNHUy
         /RonQVL+TvV+hYZLsCJkYhHG7gS+klSh+wsHTgrfFFJ5Da2yYt9k2v9MbAI9+BFYB7
         VQ1MD9sRQiiO1hWqDi1B4OElQOLle3fq+J56u7A0=
Received: from wen-VirtualBox.lan ([106.92.97.248])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 9168AC9D; Sat, 24 Dec 2022 22:36:22 +0800
X-QQ-mid: xmsmtpt1671892582tzroy2enk
Message-ID: <tencent_1D2E4866B2223D9A19DF4FFB79AFAA955A05@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtEqSkamGclXpsr5mdCAOd3/7zThJvvJFcLwebVgQs6TEb40Rgt2
         7iE8J1mnejCAkUAStz+WCywanuMB2mW7Zg6BwWV/o6aatTxznK4bPQJKmDWnaevtBL2LU4Qs+a0L
         QlR9QKTK/R3rA6Tmdo95XBi29SKtTs8f4isWFDBOs56XX/1/KAA9HfoXvRenEKV+qMMFIrl5OohY
         HDjmZmlSotbOwI+XV11mytv1bA3JSHR45cCnn84aKOmOoZ1cnZx+fz1xn4jJdcOsZDEN70Y3f3mA
         Yn67xTAkWr/6BWNzDTbYRvPDX6Jk3fJXGE7qk+zzoIiKUxV6P5b5ydxm5M9PQgHDmlSGCr1G6k7P
         ptTMUs6LkZHVEE3ZyE4dd1vqNUb8vmATMkY/sZLqbtwyydti1NQ1M1Qv4Nuo9PE0ND23H1I0WNO6
         VDqIxxoeTtAbB8WSxnUmiHdsvqxkDcOuit86cnPe03jganSP0H/Mj56qgAbup/HgfygJT+8hoYHh
         I478iKp+YU8Gwwtx0S708r93AQdUAWoyj8icc191G58q148omXV+aU4dkMP0MbekdXOzg+FcTcUz
         848nPMw93wUEoEFEKW6SpdwibiRyTcpt+81mqAiOANh1Be44Yikaw9ra9wryCET7VInlFuVlwiQ6
         ITI/deqK257MvK9DKkQ22cQtQfuGti+sANKUbcL4deLNX6vapUYP2cpU2aXPNnPB/2EqqeXc8vx0
         EFO8UDrq7DqFx0jms9aKW2xb2ltfXwz6pbCpSQlzz3DVLayVPi3+5Q3wQMsN0MsmuaoEek85AOlf
         ZGgEGCJN/oVCrVB74KYlv++pkpoZFLB1a2L8iqvt7u8Vy6X1VO2mQNWYOHs22wOXLZ+rb1Zc0j4I
         aYQ+j7ZRDSUR8V3+sYNUwEUmDgxDQflO9pwdnEW/jRRLtOvTltZaa9yWORm7NFadcPi5Y67NuonF
         kAa2FOP0z2OsM8oylejWJtD8H06BIqeUFpI0I3XylPjNFTlW/SDq35bop2lVZPmluei5hiNqY=
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] eventfd: use a generic helper instead of an open coded wait_event
Date:   Sat, 24 Dec 2022 22:36:20 +0800
X-OQ-MSGID: <20221224143620.218512-1-wenyang.linux@foxmail.com>
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

