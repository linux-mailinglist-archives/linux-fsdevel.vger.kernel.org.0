Return-Path: <linux-fsdevel+bounces-34006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA499C1A3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 11:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3DA1C2061A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 10:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D219B1E2838;
	Fri,  8 Nov 2024 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="M340/A4u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4141E2615;
	Fri,  8 Nov 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060840; cv=none; b=aeESSlbBJfkNsj271LLGh5tUxEQoeDB/Ou1v31PmCqD6yFlzvwPpyTKCQgXIoX3+4GgBRjEA7h/19u8bzVa8z9dLAEtdZgLtunvE5dfbFNliJc+V3h80auVTQeb2o8F1lWIKrqn8GpCqZIg2roCvA7yS7XcCahUxsYRxFUHO1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060840; c=relaxed/simple;
	bh=iQzP0TX3a/WZJXZxq5v8ZIb+hxr559EhG43UXEuESZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ry1ES/CX3oKHsIHf9tueqEDBWAR9PgD3Kf19S+M2cFhncKqcelEdnFxGDVVEhc8WZvRR0t4OP8NgLFrfuAfcM78HQn72ncEXRiY2xwkZTdaWUYiICk28UVzgCoOL6aue85Z7gqS3bKr394+6GqdGCGnfPObf4cteJdAy6oL1eag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=M340/A4u; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3a8d:0:640:b3b5:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 0F11660B22;
	Fri,  8 Nov 2024 13:13:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id fDgEj2Kl8a60-qQXjSOBB;
	Fri, 08 Nov 2024 13:13:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731060827; bh=wIcq5vtQWru+MuAdF1psgc+mHc7K6oOTLj5vjZzW1nw=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=M340/A4u8VqGT/80UtgHP8Q2BpfwJ/tJkhB17Wlq4ye76XlmdNe1l1aVxtfLu4hO9
	 FRuVaSIEZW/extFot4Nvgtnps3MxM0b5451n3IW2qP04F7R/KgvywTVAd+kY8HkQfe
	 sSy6R/AxS1RQglgmVGhb5wm1lfpZNNmL+yRTJttA=
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] procfs: implement PROCFS_SET_GROUPS ioctl
Date: Fri,  8 Nov 2024 13:13:39 +0300
Message-ID: <20241108101339.1560116-3-stsp2@yandex.ru>
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

This patch implements PROCFS_SET_GROUPS ioctl for /proc/self/status
files. The fd must be transferred with SCM_RIGHTS to another process
in order for this ioctl to work. Below the process that opened the
file, is referred to as "opener" and the process that calls this ioctl(),
is called "setter".

The following checks are performed about the opener:
- Opener opened his own status, not someone else's.
- Opener process still exist, so his proc entry is still valid.
- The groups weren't changed since opening the file.
- Opener was capable of CAP_SYS_ADMIN when opening the file.

The following checks are performed about the setter:
- Setter is a different process (thread) than an opener.
- PFA_NO_NEW_PRIVS not set.
- Either the process must be setgid-capable, or all the below must be
  true:
- euid==uid==suid i.e. no possibility to switch uid
- egid==gid==sgid i.e. no possibility to switch gid
- euid/egid of current process matches uid/gid of an opener process
  had at the time of opening the file.

The setter can read from an fd to find out what group list is there
to decide whether or not he wants to use it. The opener can't trick
that by changing the groups in between, as then ioctl() detects that
the group list was ever changed and fails with -EPERM.
This is also the reason why the opener is required to "exist" (and
not exit) for the duration of entire operation: otherwise his status
file may not be readable by setter.

Why /proc/self/status?
Because this file carries the group list and other credentials
already. Its quite natural to add an ioctl to apply whatever is
already there. Client is therefore able to read the needed information
and validate it in any way he wants, before applying. It is guaranteed
that the information ever read, would match the one applied, because
any change of the group info after the file was opened, disables the
ioctl.

What problem does this solve?
Currently there is no way to change the group list if the process
uses suid/sgid bits to switch to a less-privileged user to restrict
the access to the original user's files. So such restriction itself
requires CAP_SETGID to work. I.e. you need cap to drop the rights.
This ioctl allows to move CAP_SETGID from the main process to the
helper (server) process, keeping the main process cap-less.
This particular implementation also requires CAP_SYS_ADMIN on helper
side, but there may be a finer-grained approaches.

Usage scenario:
Main process connects to the helper via the AF_UNIX socket. Helper
uses SO_PEERCRED to retrieve client's uid/gid and then does initgroups()
with client's uid/gid to set the desired group list. Then it sets
uid/gid to match client's. It should keep his euid/egid untouched
or keep caps, as CAP_SYS_ADMIN check is performed by this ioctl.
Then it opens /proc/self/status and sends it to client with SCM_RIGHTS.
Client then reads from fd to validate the info in any way he wants,
and uses ioctl(PROCFS_SET_GROUPS) on that fd to actually set up the
received group list. It then replies to the server with the operation
status, or just closes the connection. At that point server is allowed
to exit.

Security considerations:
As explained above, the server process, when opening the status file,
must have uid/gid matching those of client (getting them via
SO_PEERCRED), or ioctl() fails. This may mean either of the below:
1. The server is setuid/setgid-capable. In this case we trust it does
   the right thing, namely, calls initgroups() with client's creds.
2. The server was capable but dropped the caps after changing creds.
   Same as above.
3. The server got the appropriate creds via login process. In this
   case it can transfer only the proper group list, as he doesn't
   have anything else and can't switch anything.
4. The server used suid/sgid bits to adjust the uid/gid. In this
   case he doesn't have the right group list to share.
5. The server was spawned by someone else capable, like
   `sudo setpriv --clear-groups --ruid=$RUID --rgid=$RGID ./server`
   and has the appropriate uid/gid but wrong group list (or empty
   group list, in case of --clear-groups).

Cases 4 and 5 have a malicious potential and are difficult to
distinguish from 2 and 3 on kernel level.
While it may be possible to come up with the more fine-grained
strategy, in this patch I took the simple approach: check the server
for CAP_SYS_ADMIN. In that case he definitely has the right to send
the needed groups to anyone. Server explicitly expresses his will to
do so by changing uid/gid to client's before opening the file. Sending
/proc/self/status via SCM_RIGHTS probably never happened "in a wild"
before, and for sure in any pre-existing practice CAP_SYS_ADMIN-capable
server won't change his uid/gid to client's before opening that file.
So I figured these steps are explicit enough to not add a new open()
flag or another ioctl() to allow the group info sharing in a yet more
explicit way. That check is not performed if the client is setgid-capable,
as in this case it could set the similar group list by other means
anyway.

It may be useful to inherit such fds via exec(), so O_CLOEXEC is
not required in this patch.

PFA_NO_NEW_PRIVS disables this ioctl.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Eric Biederman <ebiederm@xmission.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Aleksa Sarai <cyphar@cyphar.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Jeff Layton <jlayton@kernel.org>
CC: John Johansen <john.johansen@canonical.com>
CC: Chengming Zhou <chengming.zhou@linux.dev>
CC: Casey Schaufler <casey@schaufler-ca.com>
CC: Adrian Ratiu <adrian.ratiu@collabora.com>
CC: Felix Moessbauer <felix.moessbauer@siemens.com>
CC: Jens Axboe <axboe@kernel.dk>
CC: Oleg Nesterov <oleg@redhat.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
CC: linux-kernel@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
---
 fs/proc/base.c          | 137 +++++++++++++++++++++++++++++++++++++++-
 include/linux/cred.h    |   8 +++
 include/uapi/linux/fs.h |   2 +
 3 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 015db8752a99..67fae857372f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -98,6 +98,7 @@
 #include <linux/resctrl.h>
 #include <linux/cn_proc.h>
 #include <linux/ksm.h>
+#include <linux/cred.h>
 #include <uapi/linux/lsm.h>
 #include <trace/events/oom.h>
 #include "internal.h"
@@ -829,6 +830,138 @@ static const struct file_operations proc_single_file_operations = {
 };
 
 
+static int proc_status_open(struct inode *inode, struct file *filp)
+{
+	struct proc_inode *pi = PROC_I(inode);
+	struct pid *opener = get_task_pid(current, PIDTYPE_PID);
+
+	pi->op.proc_show = proc_pid_status;
+	return single_open(filp, proc_single_show, opener);
+}
+
+static int proc_status_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct pid *opener = seq->private;
+
+	put_pid(opener);
+	return single_release(inode, file);
+}
+
+static bool can_borrow_groups(const struct cred *cur_cred,
+			      const struct cred *f_cred)
+{
+	if (may_setgroups())
+		return 1;
+	/* Make sure the process can't switch uid/gid. */
+	if (!uid_eq(cur_cred->euid, cur_cred->uid) ||
+			!uid_eq(cur_cred->suid, cur_cred->uid))
+		return 0;
+	if (!gid_eq(cur_cred->egid, cur_cred->gid) ||
+			!gid_eq(cur_cred->sgid, cur_cred->gid))
+		return 0;
+	/* Make sure the euid/egid of current processes are equal
+	 * to uid/gid of an opener at file open time.
+	 */
+	if (!uid_eq(f_cred->uid, cur_cred->euid) ||
+			!gid_eq(f_cred->gid, cur_cred->egid))
+		return 0;
+	return 1;
+}
+
+static int do_proc_setgroups(const struct cred *task_cred,
+			     const struct cred *cur_cred,
+			     const struct cred *f_cred)
+{
+	struct group_info *cgi = get_group_info(cur_cred->group_info);
+	struct group_info *gi = get_group_info(task_cred->group_info);
+	int err;
+
+	/* Make sure groups didn't change since file open. */
+	err = -EPERM;
+	if (f_cred->group_info != gi)
+		goto out_gi;
+	/* Don't error if the process is setting the same list again. */
+	err = 0;
+	if (cgi == gi)
+		goto out_gi;
+
+	err = -EPERM;
+	if (!can_borrow_groups(cur_cred, f_cred))
+		goto out_gi;
+	err = set_current_groups(gi);
+
+out_gi:
+	put_group_info(gi);
+	put_group_info(cgi);
+	return err;
+}
+
+static int do_status_ioctl(struct task_struct *task, struct file *file,
+			    unsigned int cmd, unsigned long arg)
+{
+	const struct cred *task_cred;
+	const struct cred *cur_cred;
+	int err = -EINVAL;
+
+	switch (cmd) {
+	case PROCFS_SET_GROUPS:
+		if (arg)
+			break;
+		/* Disallow opener process to set his own groups. */
+		err = -EPERM;
+		if (task == current)
+			break;
+		/* Don't change anything if current has NO_NEW_PRIVS. */
+		if (task_no_new_privs(current))
+			break;
+		/* Opener must be capable of granting his groups. */
+		if (!file_ns_capable(file, &init_user_ns, CAP_SYS_ADMIN))
+			break;
+		task_cred = get_task_cred(task);
+		cur_cred = get_current_cred();
+		err = do_proc_setgroups(task_cred, cur_cred, file->f_cred);
+		put_cred(cur_cred);
+		put_cred(task_cred);
+		break;
+	}
+	return err;
+}
+
+static long proc_status_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	struct pid *pid = proc_pid(inode);
+	struct seq_file *seq = file->private_data;
+	struct pid *opener = seq->private;
+	struct task_struct *task;
+	long err;
+
+	/* Make sure opener opened his own proc entry. */
+	if (pid != opener)
+		return -EPERM;
+
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task)
+		return -ESRCH;
+
+	err = do_status_ioctl(task, file, cmd, arg);
+
+	put_task_struct(task);
+	return err;
+}
+
+static const struct file_operations proc_status_operations = {
+	.open		= proc_status_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= proc_status_release,
+	.unlocked_ioctl	= proc_status_ioctl,
+	.compat_ioctl	= proc_status_ioctl,
+};
+
+
 struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 {
 	struct task_struct *task = get_proc_task(inode);
@@ -3314,7 +3447,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 	REG("environ",    S_IRUSR, proc_environ_operations),
 	REG("auxv",       S_IRUSR, proc_auxv_operations),
-	ONE("status",     S_IRUGO, proc_pid_status),
+	REG("status",     S_IRUGO, proc_status_operations),
 	ONE("personality", S_IRUSR, proc_pid_personality),
 	ONE("limits",	  S_IRUGO, proc_pid_limits),
 #ifdef CONFIG_SCHED_DEBUG
@@ -3665,7 +3798,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 	REG("environ",   S_IRUSR, proc_environ_operations),
 	REG("auxv",      S_IRUSR, proc_auxv_operations),
-	ONE("status",    S_IRUGO, proc_pid_status),
+	REG("status",    S_IRUGO, proc_status_operations),
 	ONE("personality", S_IRUSR, proc_pid_personality),
 	ONE("limits",	 S_IRUGO, proc_pid_limits),
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 2976f534a7a3..962a9d59847b 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -83,6 +83,14 @@ static inline int groups_search(const struct group_info *group_info, kgid_t grp)
 {
 	return 1;
 }
+static inline bool may_setgroups(void)
+{
+	return 1;
+}
+static inline int set_current_groups(struct group_info *group_info)
+{
+	return 0;
+}
 #endif
 
 /*
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..d4b3fbfdac79 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -552,4 +552,6 @@ struct procmap_query {
 	__u64 build_id_addr;		/* in */
 };
 
+#define PROCFS_SET_GROUPS	_IO(PROCFS_IOCTL_MAGIC, 18)
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.47.0


