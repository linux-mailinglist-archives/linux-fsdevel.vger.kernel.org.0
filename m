Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85035398E5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhFBPUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 11:20:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36244 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhFBPUY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:24 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 207B121D3A;
        Wed,  2 Jun 2021 15:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622647120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XhdBo6ggf9woXDOWTaM5FKPvnRt3y+Hnl57dZNPmifc=;
        b=JrpgxiIwT3O62tpvCyZ/9n6ODqVdjkUxm5lI7UrItnF0WDIxA/UfZ6yY4TxruyLCUebAV9
        jPhVTxuNKJXmJgfde8ZIvJm1XLfMGB/elFFT4qJrkesK2esJzqaqwjU93+e3HXmoHOjZDJ
        tK8iVjgV8NZJpQp9igw49omCRYr2DM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622647120;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XhdBo6ggf9woXDOWTaM5FKPvnRt3y+Hnl57dZNPmifc=;
        b=RGcizxSdz8Y8a3v1USs6yKD4CFZXnBs9rXOlraOBGZX0khAwWIXrcdIb2gblgkUdL+B5j5
        g3WKA9vgaTY8SuBg==
Received: by relay2.suse.de (Postfix, from userid 51)
        id 0D1EEA3D35; Wed,  2 Jun 2021 15:25:59 +0000 (UTC)
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 5367BA8178;
        Wed,  2 Jun 2021 15:15:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 324861E0CB7; Wed,  2 Jun 2021 17:15:59 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, brauner@suse.cz,
        <linux-api@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] quota: Change quotactl_path() systcall to an fd-based one
Date:   Wed,  2 Jun 2021 17:15:52 +0200
Message-Id: <20210602151553.30090-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210602151553.30090-1-jack@suse.cz>
References: <20210602151553.30090-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4360; h=from:subject; bh=gFdh3KL4BGWwBt/3w4JjG75x7J1bzMTbp1+z7w9rV5c=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgt6CdXLp6Gr1gjRvPar1NbBYNXJM7tg81weGNA/Re hRLGRiKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYLegnQAKCRCcnaoHP2RA2ZP8CA CLAn0H9wrHRo8uucbIzFUYL+pdj6fXsh3rR8zoL9os1/chA8AlagxbYN0W4KsvwLhcGbsjiNGyudeI OaNnsSxp6Zh0YyT0yhVwdMiPjEYp9aQeowagtPndNhDaaoOZlvRXapU8ffBvhRpgCdBqj2jibupofD NYTFWEFHTIoTCivJTSBPYTg9dAFRTJNgffXeJNnSABzMRxzvGhxEfzEyl6ZqIZ1fXrRx83j6UEsRbL 9r5FlF2JGsYm3Oi4PpzQjiwaegzQ9dEg9bohLnSKOHT1s5739b473sjplkGuLs/QKSm6xgg6gy5m6x +9K9VtuHCO8eGFxPjYYLsvpzunutQ/
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some users have pointed out that path-based syscalls are problematic in
some environments and at least directory fd argument and possibly also
resolve flags are desirable for such syscalls. Rather than
reimplementing all details of pathname lookup and following where it may
eventually evolve, let's go for full file descriptor based syscall
similar to how ioctl(2) works since the beginning. Managing of quotas
isn't performance sensitive so the extra overhead of open does not
matter and we are able to consume O_PATH descriptors as well which makes
open cheap anyway. Also for frequent operations (such as retrieving
usage information for all users) we can reuse single fd and in fact get
even better performance as well as avoiding races with possible remounts
etc.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/quota.c                  | 27 ++++++++++++---------------
 include/linux/syscalls.h          |  4 ++--
 include/uapi/asm-generic/unistd.h |  4 ++--
 kernel/sys_ni.c                   |  2 +-
 4 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 05e4bd9ab6d6..8450bb6186f4 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -968,31 +968,29 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
 	return ret;
 }
 
-SYSCALL_DEFINE4(quotactl_path, unsigned int, cmd, const char __user *,
-		mountpoint, qid_t, id, void __user *, addr)
+SYSCALL_DEFINE4(quotactl_fd, unsigned int, fd, unsigned int, cmd,
+		qid_t, id, void __user *, addr)
 {
 	struct super_block *sb;
-	struct path mountpath;
 	unsigned int cmds = cmd >> SUBCMDSHIFT;
 	unsigned int type = cmd & SUBCMDMASK;
+	struct fd f = fdget_raw(fd);
 	int ret;
 
-	if (type >= MAXQUOTAS)
-		return -EINVAL;
+	if (!f.file)
+		return -EBADF;
 
-	ret = user_path_at(AT_FDCWD, mountpoint,
-			     LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &mountpath);
-	if (ret)
-		return ret;
-
-	sb = mountpath.mnt->mnt_sb;
+	ret = -EINVAL;
+	if (type >= MAXQUOTAS)
+		goto out;
 
 	if (quotactl_cmd_write(cmds)) {
-		ret = mnt_want_write(mountpath.mnt);
+		ret = mnt_want_write(f.file->f_path.mnt);
 		if (ret)
 			goto out;
 	}
 
+	sb = f.file->f_path.mnt->mnt_sb;
 	if (quotactl_cmd_onoff(cmds))
 		down_write(&sb->s_umount);
 	else
@@ -1006,9 +1004,8 @@ SYSCALL_DEFINE4(quotactl_path, unsigned int, cmd, const char __user *,
 		up_read(&sb->s_umount);
 
 	if (quotactl_cmd_write(cmds))
-		mnt_drop_write(mountpath.mnt);
+		mnt_drop_write(f.file->f_path.mnt);
 out:
-	path_put(&mountpath);
-
+	fdput(f);
 	return ret;
 }
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 050511e8f1f8..586128d5c3b8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -485,8 +485,8 @@ asmlinkage long sys_pipe2(int __user *fildes, int flags);
 /* fs/quota.c */
 asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special,
 				qid_t id, void __user *addr);
-asmlinkage long sys_quotactl_path(unsigned int cmd, const char __user *mountpoint,
-				  qid_t id, void __user *addr);
+asmlinkage long sys_quotactl_fd(unsigned int fd, unsigned int cmd, qid_t id,
+				void __user *addr);
 
 /* fs/readdir.c */
 asmlinkage long sys_getdents64(unsigned int fd,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 6de5a7fc066b..f211961ce1da 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -863,8 +863,8 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
 __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
 #define __NR_mount_setattr 442
 __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
-#define __NR_quotactl_path 443
-__SYSCALL(__NR_quotactl_path, sys_quotactl_path)
+#define __NR_quotactl_fd 443
+__SYSCALL(__NR_quotactl_fd, sys_quotactl_fd)
 
 #define __NR_landlock_create_ruleset 444
 __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 0ea8128468c3..dad4d994641e 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -99,7 +99,7 @@ COND_SYSCALL(flock);
 
 /* fs/quota.c */
 COND_SYSCALL(quotactl);
-COND_SYSCALL(quotactl_path);
+COND_SYSCALL(quotactl_fd);
 
 /* fs/readdir.c */
 
-- 
2.26.2

