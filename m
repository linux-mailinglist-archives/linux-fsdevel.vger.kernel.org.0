Return-Path: <linux-fsdevel+bounces-33500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FE19B9982
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 21:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48281C21CF7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3681D9A78;
	Fri,  1 Nov 2024 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="QL4ptvxF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E61CC8A7;
	Fri,  1 Nov 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493281; cv=none; b=HUw1/bLiG3TGNH9gX8IWBgFZ/Us/REX6i7U77+AD//n/Zt5qCbdS6OoY6f+ipX7TVdgsGtfuoVVPs7+bEZzG6FW+M3tdRP+Jhu5TKl22xsAmvX3RaI2fnCysGLA1BrV/IRThWZqIriiE1Welm41WWGXr0x+MsNqNvlypZ+wj/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493281; c=relaxed/simple;
	bh=Xh53WnxbzrLpeFD4qA+ULQsuht3m/R0vILxRTS86S1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fz6ycGMBFHBfFqLTP0etRlHSe+cHg5rsVQY523KK7utYx/JqAjYeEzsIF6OcTTkX39UZWRFXQDlKYmon+WsWlrKi17iPMZbbITwDdO8AfKOJR3LROb5QGTqlhTir5nbjInZZL7UANpvZ/xiFt5Tmns3D19mOcWff7dB+4w8WA/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=QL4ptvxF; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id 751DF67CBD;
	Fri,  1 Nov 2024 23:27:24 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c16:179d:0:640:38f5:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 91345609A4;
	Fri,  1 Nov 2024 23:27:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id DRjrc0hXoCg0-ppQ2TVzM;
	Fri, 01 Nov 2024 23:27:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1730492834; bh=jirBRe0Gzm5qlc+JfJ2U0mcnBLShKzZR40RQrJHImeU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=QL4ptvxFS+5PAsUIYEmAFYlQ+mcbh7KgSuA7ydmWcBGPXCzqlct6hUYDPxs3nKLSw
	 268z/n6LDK5zePAtsTVNFZ/fvkAMTqbseWiLN4vFZnIL94NyZI8AWJQhjAG+O3hhKV
	 XaEQBmSyK4/v5gjXmWWAe/0Gl5A/+0O4D5cUpWQ0=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Kees Cook <kees@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>
Subject: [POC, RFC] scheme for transferring group_list between processes
Date: Fri,  1 Nov 2024 23:26:57 +0300
Message-ID: <20241101202657.468595-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note: this patch is a POC and RFC. It "parasites" on pidfd code
just for the sake of a demo. It has nothing to do with pidfd.

The problem:
If you use suid/sgid bits to switch to a less-privileged (home-less)
user, then the group list can't be changed, effectively nullifying
any supposed restrictions. As such, suid/sgid to non-root creds is
currently practically useless.

Previous solutions:
https://www.spinics.net/lists/kernel/msg5383847.html
This solution allows to restrict the groups from group list.
It failed to get any attention for probably being too ad-hoc.
https://lore.kernel.org/all/0895c1f268bc0b01cc6c8ed4607d7c3953f49728.1416041823.git.josh@xxxxxxxxxxxxxxxx/
This solution from Josh Tripplett was considered insecure.

New proposal:
This proposal was inspired by the credfd proposal of Andy Lutomirski:
https://lkml2.uits.iu.edu/hypermail/linux/kernel/1403.3/01528.html
When we send an fd with SCM_RIGHTS, is has entire creds of the sender,
captured at a moment of opening the file.
Now if we have a "capable" server process, it can do SO_PEERCRED to
retrieve client's uid/gid. Then it does getgrouplist() and setgroups()
with client's uid/gid to set the group list desired for that client.
Then it sets euid/egid to match client's. Then it opens some file
(pidfd file in this POC, but should be credfd) and sends it to client.
Client then does a special ioctl() on that fd to actually set up the
received group list.
Such ioctl() must ensure that the change is safe:
- If process has CAP_SETGID - ok
- Otherwise we need to make sure the server process explicitly permitted
  the change (not in this POC), make sure that uid==euid==suid
  (i.e. the process won't change its creds after setting group list)
  and make sure that euid/egid match those of the server.
After doing these checks, the group list is applied.

Simply put, this proposal allows to move CAP_SETGID from the main
process to the helper (server) process, keeping the main process
cap-less. Its advantage over the previous proposals is that you
end up with the _correct_ group list that _naturally_ belongs to
that UID. Previous proposals either ended up with an empty group
list or "restricted" group list, but never with the right one.

I put the user-space usage example here:
https://github.com/stsp/cred_test

Would be good to hear if something like this can be considered.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>
CC: Jens Axboe <axboe@kernel.dk>
CC: Kees Cook <kees@kernel.org>
CC: Oleg Nesterov <oleg@redhat.com>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Eric Biederman <ebiederm@xmission.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Josh Triplett <josh@joshtriplett.org>
---
 fs/pidfs.c                 | 31 +++++++++++++++++++++++++++++++
 include/linux/cred.h       |  4 ++++
 include/uapi/linux/pidfd.h |  1 +
 3 files changed, 36 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 80675b6bf884..06209d3b5e61 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -114,6 +114,28 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	return poll_flags;
 }
 
+static bool can_borrow_groups(const struct cred *cred)
+{
+	kuid_t uid = current_uid();
+	kgid_t gid = current_gid();
+	kuid_t euid = current_euid();
+	kgid_t egid = current_egid();
+
+	if (may_setgroups())
+		return 1;
+	/* TODO: make sure peer actually allowed to borrow his groups. */
+
+	/* Make sure the process can't switch uid/gid. */
+	if (!uid_eq(euid, uid) || !uid_eq(current_suid(), uid))
+		return 0;
+	if (!gid_eq(egid, gid) || !gid_eq(current_sgid(), gid))
+		return 0;
+	/* Make sure the euid/egid of 2 processes are equal. */
+	if (!uid_eq(cred->euid, euid) || !gid_eq(cred->egid, egid))
+		return 0;
+	return 1;
+}
+
 static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct task_struct *task __free(put_task) = NULL;
@@ -141,8 +163,10 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	 * We're trying to open a file descriptor to the namespace so perform a
 	 * filesystem cred ptrace check. Also, we mirror nsfs behavior.
 	 */
+/*
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
 		return -EACCES;
+*/
 
 	switch (cmd) {
 	/* Namespaces that hang of nsproxy. */
@@ -209,6 +233,13 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			rcu_read_unlock();
 		}
 		break;
+	case PIDFD_BORROW_GROUPS:
+		if (task == current)
+			return 0;
+		if (!can_borrow_groups(file->f_cred))
+			return -EPERM;
+		set_current_groups(file->f_cred->group_info);
+		return 0;
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 2976f534a7a3..cfdeebbd7db6 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -83,6 +83,10 @@ static inline int groups_search(const struct group_info *group_info, kgid_t grp)
 {
 	return 1;
 }
+static inline bool may_setgroups(void)
+{
+	return 1;
+}
 #endif
 
 /*
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 565fc0629fff..1ef8e31fefed 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -28,5 +28,6 @@
 #define PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE _IO(PIDFS_IOCTL_MAGIC, 8)
 #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
 #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
+#define PIDFD_BORROW_GROUPS                   _IO(PIDFS_IOCTL_MAGIC, 11)
 
 #endif /* _UAPI_LINUX_PIDFD_H */
-- 
2.47.0


