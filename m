Return-Path: <linux-fsdevel+bounces-34099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA819C26AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 21:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFCA1F22A65
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 20:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3651D63DC;
	Fri,  8 Nov 2024 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="BhSqeXCd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A11AA1D5;
	Fri,  8 Nov 2024 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098475; cv=none; b=Bm0YiKdnvNXsMuuUcJ1M8mXqYrr5w7TnzU+M30vH1WE3l1+JZeJaK3lgt2nnNBenrlygvguKtYB41/bLKA/QKbSk2qdDCGlfYStP1791DeyqOiNBCA0hupg0yTy9SAxNpfrjqJRExtxSgxCEDiJYNpZZ7HRNX6x9xHA4QiQhPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098475; c=relaxed/simple;
	bh=KN+DAgw3yPEAr0lmHvMkZ8ddR7N5YRcpEEyXFhe3HPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYc4Xv4bUF+YfYavMt0PIVz23uW6iVSx4kJRfoSMn2CYFsLMr0n+LVueHJZOeQgZvNMeAaeiw0V43tLsA+l0bEyyY/ZbTrcs3ZhXn/n3bXoQp60ak9sGkAdtxEiBlA6A89xIHiVsE+S4UpKunKROQXOPIlrNMyPsSbYJclRsJbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=BhSqeXCd; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:694e:0:640:b187:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id DEC9A608E0;
	Fri,  8 Nov 2024 23:41:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3fq42PTi7Gk0-kU9IviQ6;
	Fri, 08 Nov 2024 23:41:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731098467; bh=oIH0ITV/juR4ktdD1koDmGfI5V9YIyLOoPbBPf790JA=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=BhSqeXCdpg/E+sWnIG54mDTxenGnZukZJSPVgDvwsfw2tUxSkAZdkFwPw5v1+1wTR
	 ylyVrVPmYQCNduOgNk+Cj86OAS/9rxdHN5LyUDnAcSpoH/Q1axNULFKHiNlqvDMqrs
	 TcYcouKkdM4ZyDVfqfF6jZpV9ax/JFE3x/XYjr7E=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Eric Biederman <ebiederm@xmission.com>,
	Andy Lutomirski <luto@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Jens Axboe <axboe@kernel.dk>,
	Oleg Nesterov <oleg@redhat.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v3 1/2] procfs: avoid some usages of seq_file private data
Date: Fri,  8 Nov 2024 23:41:01 +0300
Message-ID: <20241108204102.1752206-2-stsp2@yandex.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108204102.1752206-1-stsp2@yandex.ru>
References: <20241108204102.1752206-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

seq_file private data carries the inode pointer here.
Replace
`struct inode *inode = m->private;`
with:
`struct inode *inode = file_inode(m->file);`
to avoid the reliance on private data.

This is needed so that `proc_single_show()` can be used by
custom fops that utilize seq_file private data for other things.
This is used in the next patch.

The private data argument of corresponding single_open() calls
is NULLified.
Note that timens_offsets_show() already had `file_inode(m->file)`
so the NULLification in `timens_offsets_open()` is unpaired.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Eric Biederman <ebiederm@xmission.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Aleksa Sarai <cyphar@cyphar.com>
CC: Christian Brauner <brauner@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Jeff Layton <jlayton@kernel.org>
CC: Kees Cook <kees@kernel.org>
CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC: Al Viro <viro@zeniv.linux.org.uk>
CC: Felix Moessbauer <felix.moessbauer@siemens.com>
CC: Adrian Ratiu <adrian.ratiu@collabora.com>
CC: Casey Schaufler <casey@schaufler-ca.com>
CC: linux-kernel@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
CC: Jan Kara <jack@suse.cz>
CC: Chengming Zhou <chengming.zhou@linux.dev>
CC: Jens Axboe <axboe@kernel.dk>
CC: Oleg Nesterov <oleg@redhat.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 fs/proc/base.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b31283d81c52..e7c8554ec95a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -528,7 +528,7 @@ static int proc_pid_schedstat(struct seq_file *m, struct pid_namespace *ns,
 static int lstats_show_proc(struct seq_file *m, void *v)
 {
 	int i;
-	struct inode *inode = m->private;
+	struct inode *inode = file_inode(m->file);
 	struct task_struct *task = get_proc_task(inode);
 
 	if (!task)
@@ -557,7 +557,7 @@ static int lstats_show_proc(struct seq_file *m, void *v)
 
 static int lstats_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, lstats_show_proc, inode);
+	return single_open(file, lstats_show_proc, NULL);
 }
 
 static ssize_t lstats_write(struct file *file, const char __user *buf,
@@ -800,7 +800,7 @@ static const struct inode_operations proc_def_inode_operations = {
 
 static int proc_single_show(struct seq_file *m, void *v)
 {
-	struct inode *inode = m->private;
+	struct inode *inode = file_inode(m->file);
 	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
 	struct pid *pid = proc_pid(inode);
 	struct task_struct *task;
@@ -818,7 +818,7 @@ static int proc_single_show(struct seq_file *m, void *v)
 
 static int proc_single_open(struct inode *inode, struct file *filp)
 {
-	return single_open(filp, proc_single_show, inode);
+	return single_open(filp, proc_single_show, NULL);
 }
 
 static const struct file_operations proc_single_file_operations = {
@@ -1494,7 +1494,7 @@ static const struct file_operations proc_fail_nth_operations = {
  */
 static int sched_show(struct seq_file *m, void *v)
 {
-	struct inode *inode = m->private;
+	struct inode *inode = file_inode(m->file);
 	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
 	struct task_struct *p;
 
@@ -1527,7 +1527,7 @@ sched_write(struct file *file, const char __user *buf,
 
 static int sched_open(struct inode *inode, struct file *filp)
 {
-	return single_open(filp, sched_show, inode);
+	return single_open(filp, sched_show, NULL);
 }
 
 static const struct file_operations proc_pid_sched_operations = {
@@ -1546,7 +1546,7 @@ static const struct file_operations proc_pid_sched_operations = {
  */
 static int sched_autogroup_show(struct seq_file *m, void *v)
 {
-	struct inode *inode = m->private;
+	struct inode *inode = file_inode(m->file);
 	struct task_struct *p;
 
 	p = get_proc_task(inode);
@@ -1593,15 +1593,7 @@ sched_autogroup_write(struct file *file, const char __user *buf,
 
 static int sched_autogroup_open(struct inode *inode, struct file *filp)
 {
-	int ret;
-
-	ret = single_open(filp, sched_autogroup_show, NULL);
-	if (!ret) {
-		struct seq_file *m = filp->private_data;
-
-		m->private = inode;
-	}
-	return ret;
+	return single_open(filp, sched_autogroup_show, NULL);
 }
 
 static const struct file_operations proc_pid_sched_autogroup_operations = {
@@ -1704,7 +1696,7 @@ static ssize_t timens_offsets_write(struct file *file, const char __user *buf,
 
 static int timens_offsets_open(struct inode *inode, struct file *filp)
 {
-	return single_open(filp, timens_offsets_show, inode);
+	return single_open(filp, timens_offsets_show, NULL);
 }
 
 static const struct file_operations proc_timens_offsets_operations = {
@@ -1745,7 +1737,7 @@ static ssize_t comm_write(struct file *file, const char __user *buf,
 
 static int comm_show(struct seq_file *m, void *v)
 {
-	struct inode *inode = m->private;
+	struct inode *inode = file_inode(m->file);
 	struct task_struct *p;
 
 	p = get_proc_task(inode);
@@ -1762,7 +1754,7 @@ static int comm_show(struct seq_file *m, void *v)
 
 static int comm_open(struct inode *inode, struct file *filp)
 {
-	return single_open(filp, comm_show, inode);
+	return single_open(filp, comm_show, NULL);
 }
 
 static const struct file_operations proc_pid_set_comm_operations = {
@@ -2641,7 +2633,7 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
 
 static int timerslack_ns_show(struct seq_file *m, void *v)
 {
-	struct inode *inode = m->private;
+	struct inode *inode = file_inode(m->file);
 	struct task_struct *p;
 	int err = 0;
 
@@ -2675,7 +2667,7 @@ static int timerslack_ns_show(struct seq_file *m, void *v)
 
 static int timerslack_ns_open(struct inode *inode, struct file *filp)
 {
-	return single_open(filp, timerslack_ns_show, inode);
+	return single_open(filp, timerslack_ns_show, NULL);
 }
 
 static const struct file_operations proc_pid_set_timerslack_ns_operations = {
-- 
2.47.0


