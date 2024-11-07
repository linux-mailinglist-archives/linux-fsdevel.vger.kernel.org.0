Return-Path: <linux-fsdevel+bounces-33975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2208C9C1180
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 23:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12A01F2313F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DDB21894F;
	Thu,  7 Nov 2024 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="dVl8EWm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward203d.mail.yandex.net (forward203d.mail.yandex.net [178.154.239.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A22185A4;
	Thu,  7 Nov 2024 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017252; cv=none; b=Vx2FE8e4A9QNfwjMsHUnE57/uJh5uZaKRZGOCnd4QVHT5varz6kK42+WW855wLHK8BKb0LFKEHyfUwGkTssiGyAUQk/4prW2xpy28LGaVBAbs+I+FAgZrQvkKmWNTPAFEOGMtXKbRU8K50nz0hRr0FB/5Z5R+7lzcDZj29CYuG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017252; c=relaxed/simple;
	bh=3gAyTEqxFtmMpZPi1zPqaPR2NeXUoPDziLupWC3mfZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjDJnH9E8XYJWlGppEDnr9u4i6uf65Mn0Qz5uYYlMZ3AskTpczxiYPlpFvPpOMMrlUCxVhh+N3QFEbFoF5Eyn1QtWjDL/lwTuMIGXII1wxRiMUP87tnXVgqWewUgf8WZ3fEM/wau1lk7rBFb+VhW1hdG/SWh5wvYdu4NMWYzxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=dVl8EWm5; arc=none smtp.client-ip=178.154.239.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward203d.mail.yandex.net (Yandex) with ESMTPS id AFAB564172;
	Fri,  8 Nov 2024 00:59:20 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:716:0:640:819a:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id F2C7260970;
	Fri,  8 Nov 2024 00:59:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7xqTJcE2G4Y0-mB20fefE;
	Fri, 08 Nov 2024 00:59:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731016750; bh=VDkWedm9Sk/c5U5QFEEE0SHcMCmiwfWy8Tyea+SoOlc=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=dVl8EWm59d+Mcg6z6Oo42XVJQeqdNYxdTn2lJjZ+udQJm2yG8IJoyxOBAN5hEaB5Q
	 e+MiIJO8Ioexl4Ks8VTb7MhZjh4dUwDIBLjeUhGcIpmRmr4l1NPMQurfjAw5Gs3NwS
	 kWk38vmvPSzhqOxtBcNiFIvPbWH9R9JVU5dHIlQQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
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
	linux-fsdevel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 1/2] procfs: avoid some usages of seq_file private data
Date: Fri,  8 Nov 2024 00:58:20 +0300
Message-ID: <20241107215821.1514623-2-stsp2@yandex.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107215821.1514623-1-stsp2@yandex.ru>
References: <20241107215821.1514623-1-stsp2@yandex.ru>
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
 fs/proc/base.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b31283d81c52..015db8752a99 100644
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
@@ -800,7 +800,7 @@ static const struct inode_operations proc_def_inode_operations = {
 
 static int proc_single_show(struct seq_file *m, void *v)
 {
-	struct inode *inode = m->private;
+	struct inode *inode = file_inode(m->file);
 	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
 	struct pid *pid = proc_pid(inode);
 	struct task_struct *task;
@@ -1494,7 +1494,7 @@ static const struct file_operations proc_fail_nth_operations = {
  */
 static int sched_show(struct seq_file *m, void *v)
 {
-	struct inode *inode = m->private;
+	struct inode *inode = file_inode(m->file);
 	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
 	struct task_struct *p;
 
@@ -1546,7 +1546,7 @@ static const struct file_operations proc_pid_sched_operations = {
  */
 static int sched_autogroup_show(struct seq_file *m, void *v)
 {
-	struct inode *inode = m->private;
+	struct inode *inode = file_inode(m->file);
 	struct task_struct *p;
 
 	p = get_proc_task(inode);
@@ -1745,7 +1745,7 @@ static ssize_t comm_write(struct file *file, const char __user *buf,
 
 static int comm_show(struct seq_file *m, void *v)
 {
-	struct inode *inode = m->private;
+	struct inode *inode = file_inode(m->file);
 	struct task_struct *p;
 
 	p = get_proc_task(inode);
@@ -2641,7 +2641,7 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
 
 static int timerslack_ns_show(struct seq_file *m, void *v)
 {
-	struct inode *inode = m->private;
+	struct inode *inode = file_inode(m->file);
 	struct task_struct *p;
 	int err = 0;
 
-- 
2.47.0


