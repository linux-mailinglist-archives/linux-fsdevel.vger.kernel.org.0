Return-Path: <linux-fsdevel+bounces-34005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBF09C1A3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 11:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E6F1F2618A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 10:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD051E2312;
	Fri,  8 Nov 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="vipUjggg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA01D3625;
	Fri,  8 Nov 2024 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060833; cv=none; b=HagXu9Va5WdsgmwU1a4cDo7izoXCjhlT/YkE5yIA4Fvz6CvnsBRbEEUDoEUM76B7TxYbennAzIEQQY0kXqxfl+djcy7Z3wt3/QbwuhALmvT6oW81hGMeNFpLJ2AQAIcPFT1Xm0APIYkIaP8/XZTgLw1uS7eHAZBy5Sa6TBivvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060833; c=relaxed/simple;
	bh=3gAyTEqxFtmMpZPi1zPqaPR2NeXUoPDziLupWC3mfZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXPo1fc0yFT+H8jK1Vjk8lsG2gC+wSZhrfxKnLP1FcVkExUBqv4qUS+fvUPlMSDBEiK06Bx3GaxvrblQyqvQ6alsS6TVShYY964FaiQyZocyf3CrqB5IQM66/BiKX+v1S3OnVI5lbhUmy7/IZTBFHLc/BwlMNbmHFmPRiza6xIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=vipUjggg; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3a8d:0:640:b3b5:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 5C590608F4;
	Fri,  8 Nov 2024 13:13:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id fDgEj2Kl8a60-potzNlrO;
	Fri, 08 Nov 2024 13:13:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731060826; bh=VDkWedm9Sk/c5U5QFEEE0SHcMCmiwfWy8Tyea+SoOlc=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=vipUjggg9tep36GgHkiGZLxsnDX6iSQbLB0bzNXuW8AIYw71R2G7p5o8zjSIjzg2B
	 QVoIVoCUQ+aEwPHutZNTQ9VPrdIaGqQ8Aq3O3yjfAb8MyVAaQd2jdp1rbre7htl5uk
	 UhHvY1BbJqhMctHJLJgcZnjgfetdqU5nnRZT7QDI=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
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
Subject: [PATCH v2 1/2] procfs: avoid some usages of seq_file private data
Date: Fri,  8 Nov 2024 13:13:38 +0300
Message-ID: <20241108101339.1560116-2-stsp2@yandex.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108101339.1560116-1-stsp2@yandex.ru>
References: <20241108101339.1560116-1-stsp2@yandex.ru>
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


