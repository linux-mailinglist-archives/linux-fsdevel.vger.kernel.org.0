Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8FB53A5D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 15:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353193AbiFANU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353169AbiFANUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:20:54 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F329C175A3
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 06:20:52 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-W5A1QcP2OjSmyMrvEcSVfQ-1; Wed, 01 Jun 2022 09:20:48 -0400
X-MC-Unique: W5A1QcP2OjSmyMrvEcSVfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD470811E81;
        Wed,  1 Jun 2022 13:20:47 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C17D0414A7E7;
        Wed,  1 Jun 2022 13:20:45 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux.dev>,
        linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: [RFC PATCH 1/4] sysctl: API extension for handling sysctl
Date:   Wed,  1 Jun 2022 15:20:29 +0200
Message-Id: <5ec6759ab3b617f9c12449a9606b6f0b5a7582d0.1654086665.git.legion@kernel.org>
In-Reply-To: <cover.1654086665.git.legion@kernel.org>
References: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>  <cover.1654086665.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds additional optional functions for handling open, read, and
write operations that can be customized for each sysctl file. It also
creates ctl_context that persists from opening to closing the file in
the /proc/sys.

The context allows us to store dynamic information at the time the file
is opened. This eliminates the need to duplicate ctl_table in order to
dynamically change .data, .extra1 or .extra2.

This API extends the existing one and does not require any changes to
already existing sysctl handlers.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/proc/proc_sysctl.c  | 71 +++++++++++++++++++++++++++++++++++-------
 include/linux/sysctl.h | 20 ++++++++++--
 2 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 7d9cfc730bd4..d3d43e738f01 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -560,6 +560,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct ctl_table_header *head = grab_header(inode);
 	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	struct ctl_fops *fops = table->ctl_fops;
 	size_t count = iov_iter_count(iter);
 	char *kbuf;
 	ssize_t error;
@@ -577,7 +578,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 
 	/* if that can happen at all, it should be -EINVAL, not -EISDIR */
 	error = -EINVAL;
-	if (!table->proc_handler)
+	if (!table->proc_handler && !fops)
 		goto out;
 
 	/* don't even try if the size is too large */
@@ -600,8 +601,20 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	if (error)
 		goto out_free_buf;
 
-	/* careful: calling conventions are nasty here */
-	error = table->proc_handler(table, write, kbuf, &count, &iocb->ki_pos);
+	if (fops) {
+		struct ctl_context *ctx = iocb->ki_filp->private_data;
+
+		if (write && fops->write)
+			error = fops->write(ctx, iocb->ki_filp, kbuf, &count, &iocb->ki_pos);
+		else if (!write && fops->read)
+			error = fops->read(ctx, iocb->ki_filp, kbuf, &count, &iocb->ki_pos);
+		else
+			error = -EINVAL;
+	} else {
+		/* careful: calling conventions are nasty here */
+		error = table->proc_handler(table, write, kbuf, &count, &iocb->ki_pos);
+	}
+
 	if (error)
 		goto out_free_buf;
 
@@ -634,17 +647,50 @@ static int proc_sys_open(struct inode *inode, struct file *filp)
 {
 	struct ctl_table_header *head = grab_header(inode);
 	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	struct ctl_context *ctx;
+	int ret = 0;
 
 	/* sysctl was unregistered */
 	if (IS_ERR(head))
 		return PTR_ERR(head);
 
-	if (table->poll)
-		filp->private_data = proc_sys_poll_event(table->poll);
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->table = table;
+	filp->private_data = ctx;
+
+	if (table->ctl_fops && table->ctl_fops->open)
+		ret = table->ctl_fops->open(ctx, inode, filp);
+
+	if (!ret && table->poll)
+		ctx->poll_event = proc_sys_poll_event(table->poll);
 
 	sysctl_head_finish(head);
 
-	return 0;
+	return ret;
+}
+
+static int proc_sys_release(struct inode *inode, struct file *filp)
+{
+	struct ctl_table_header *head = grab_header(inode);
+	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	struct ctl_context *ctx = filp->private_data;
+	int ret = 0;
+
+	if (IS_ERR(head))
+		return PTR_ERR(head);
+
+	if (table->ctl_fops && table->ctl_fops->release)
+		ret = table->ctl_fops->release(ctx, inode, filp);
+
+	sysctl_head_finish(head);
+
+	kfree(ctx);
+	filp->private_data =  NULL;
+
+	return ret;
 }
 
 static __poll_t proc_sys_poll(struct file *filp, poll_table *wait)
@@ -653,23 +699,23 @@ static __poll_t proc_sys_poll(struct file *filp, poll_table *wait)
 	struct ctl_table_header *head = grab_header(inode);
 	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
 	__poll_t ret = DEFAULT_POLLMASK;
-	unsigned long event;
+	struct ctl_context *ctx;
 
 	/* sysctl was unregistered */
 	if (IS_ERR(head))
 		return EPOLLERR | EPOLLHUP;
 
-	if (!table->proc_handler)
+	if (!table->proc_handler && !table->ctl_fops)
 		goto out;
 
 	if (!table->poll)
 		goto out;
 
-	event = (unsigned long)filp->private_data;
+	ctx = filp->private_data;
 	poll_wait(filp, &table->poll->wait, wait);
 
-	if (event != atomic_read(&table->poll->event)) {
-		filp->private_data = proc_sys_poll_event(table->poll);
+	if (ctx->poll_event != atomic_read(&table->poll->event)) {
+		ctx->poll_event = proc_sys_poll_event(table->poll);
 		ret = EPOLLIN | EPOLLRDNORM | EPOLLERR | EPOLLPRI;
 	}
 
@@ -866,6 +912,7 @@ static int proc_sys_getattr(struct user_namespace *mnt_userns,
 
 static const struct file_operations proc_sys_file_operations = {
 	.open		= proc_sys_open,
+	.release	= proc_sys_release,
 	.poll		= proc_sys_poll,
 	.read_iter	= proc_sys_read,
 	.write_iter	= proc_sys_write,
@@ -1153,7 +1200,7 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
 			else
 				err |= sysctl_check_table_array(path, table);
 		}
-		if (!table->proc_handler)
+		if (!table->proc_handler && !table->ctl_fops)
 			err |= sysctl_err(path, table, "No proc_handler");
 
 		if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 6353d6db69b2..ca5657c9fcb2 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -116,9 +116,9 @@ struct ctl_table_poll {
 	wait_queue_head_t wait;
 };
 
-static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
+static inline unsigned long proc_sys_poll_event(struct ctl_table_poll *poll)
 {
-	return (void *)(unsigned long)atomic_read(&poll->event);
+	return (unsigned long)atomic_read(&poll->event);
 }
 
 #define __CTL_TABLE_POLL_INITIALIZER(name) {				\
@@ -128,6 +128,21 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
 #define DEFINE_CTL_TABLE_POLL(name)					\
 	struct ctl_table_poll name = __CTL_TABLE_POLL_INITIALIZER(name)
 
+struct ctl_context {
+	struct ctl_table *table;
+	unsigned long poll_event;
+	void *ctl_data;
+};
+
+struct inode;
+
+struct ctl_fops {
+	int (*open) (struct ctl_context *, struct inode *, struct file *);
+	int (*release) (struct ctl_context *, struct inode *, struct file *);
+	ssize_t (*read) (struct ctl_context *, struct file *, char *, size_t *, loff_t *);
+	ssize_t (*write) (struct ctl_context *, struct file *, char *, size_t *, loff_t *);
+};
+
 /* A sysctl table is an array of struct ctl_table: */
 struct ctl_table {
 	const char *procname;		/* Text ID for /proc/sys, or zero */
@@ -139,6 +154,7 @@ struct ctl_table {
 	struct ctl_table_poll *poll;
 	void *extra1;
 	void *extra2;
+	struct ctl_fops *ctl_fops;
 } __randomize_layout;
 
 struct ctl_node {
-- 
2.33.3

