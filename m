Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D485938E819
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 15:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhEXNy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhEXNyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 09:54:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46469C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 06:53:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q5so28620861wrs.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tF+Oz6NE7CQnoJvm87rkk3FG6j74rBfoJmjO2qhKjp8=;
        b=kmLn9IgiA1+aTHBUomV5fWJkcBZgmECGkWq/QGOWwTOBEr0o19dC6w1mIAWBwixYXB
         w+ZyyulPm0NemzTfjShAx0RFTnpQ4kJG02p7dpLgDRE5mtAk1LwctKM8j19rbNCAOFnI
         Rgaj15q9KB5w+y5bvckbta7Jif0AfK0sB4T42EXsX04I/k5lJWUOUFO626Nv7+XYUbpe
         y9PUskHTSG0/roLgc/ffu5av8QzovFDis4X4MHNzPZoxurYjGpC24DK+xwgaif0pkPzF
         YWiSsrP3yiw8/QFp+bxKJ/TYlN057YPJleKlmFXRfOA3w4BwgWGop8bFEWuFHwGowW2e
         9BQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tF+Oz6NE7CQnoJvm87rkk3FG6j74rBfoJmjO2qhKjp8=;
        b=HYM9+0L08M2Rmuyre2sSpanUnFE/GEyah5et2mpr+xbQAEG8+BxfiYaNcmpvLzTNyY
         fhgucxnMRNg2BQNrXP76SHEUzteF3MRx7LUFZr/87eVFGXE9tJ7xDaS3OzmYWhCZnJOe
         vOKdsZXIoN3Z2tFAA/qXrBNeeJztYA7lH3kBEfF64rkf6SfYcz+WzjdPz71S4OavjtE7
         pXdupfwslNzs+SOOxwu7GLNsHVFnPEZNvo+2bWmtXlYTgn2n5nFC5r+WawJa0x7H9E1N
         9xxc7vbymqa8/nT7gKS+bFBsGM6TZritLG6t1ozR2ZDAD/cQc5xfOd7zHe7qVd9ml7mg
         EYug==
X-Gm-Message-State: AOAM531/n1w4t7ieCzccNDBuQj3bo2TLDbfyp70eFJkCpB8K/OC2+MWO
        98Q/42e70XN0pz7BY8Qvp/Wij40yet4=
X-Google-Smtp-Source: ABdhPJzl1Ie35/sjZvFycxCA9J2NUGPF4nltGWYLPCRi0f8/2xXCPYP70JvTR4wV04eIvxZPIUCpLw==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr22983122wrv.164.1621864405826;
        Mon, 24 May 2021 06:53:25 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id v15sm8093767wmj.39.2021.05.24.06.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 06:53:25 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH][v2] fanotify: fix permission model of unprivileged group
Date:   Mon, 24 May 2021 16:53:21 +0300
Message-Id: <20210524135321.2190062-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reporting event->pid should depend on the privileges of the user that
initialized the group, not the privileges of the user reading the
events.

Use an internal group flag FANOTIFY_UNPRIV to record the fact that the
group was initialized by an unprivileged user.

To be on the safe side, the premissions to setup filesystem and mount
marks now require that both the user that initialized the group and
the user setting up the mark have CAP_SYS_ADMIN.

Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiA77_P5vtv7e83g0+9d7B5W9ZTE4GfQEYbWmfT1rA=VA@mail.gmail.com/
Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivileged users")
Cc: <Stable@vger.kernel.org> # v5.12+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Changes since v1:
- Address Matthew's editorial review comments
- Rename macro FANOTIFY_INTERNAL_GROUP_FLAGS

 fs/notify/fanotify/fanotify_user.c | 30 ++++++++++++++++++++++++------
 fs/notify/fdinfo.c                 |  2 +-
 include/linux/fanotify.h           |  4 ++++
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 71fefb30e015..be5b6d2c01e7 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -424,11 +424,18 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	 * events generated by the listener process itself, without disclosing
 	 * the pids of other processes.
 	 */
-	if (!capable(CAP_SYS_ADMIN) &&
+	if (FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
 	    task_tgid(current) != event->pid)
 		metadata.pid = 0;
 
-	if (path && path->mnt && path->dentry) {
+	/*
+	 * For now, fid mode is required for an unprivileged listener and
+	 * fid mode does not report fd in events.  Keep this check anyway
+	 * for safety in case fid mode requirement is relaxed in the future
+	 * to allow unprivileged listener to get events with no fd and no fid.
+	 */
+	if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
+	    path && path->mnt && path->dentry) {
 		fd = create_fd(group, path, &f);
 		if (fd < 0)
 			return fd;
@@ -1040,6 +1047,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	int f_flags, fd;
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
 	unsigned int class = flags & FANOTIFY_CLASS_BITS;
+	unsigned int internal_flags = 0;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
@@ -1053,6 +1061,13 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		 */
 		if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) || !fid_mode)
 			return -EPERM;
+
+		/*
+		 * Setting the internal flag FANOTIFY_UNPRIV on the group
+		 * prevents setting mount/filesystem marks on this group and
+		 * prevents reporting pid and open fd in events.
+		 */
+		internal_flags |= FANOTIFY_UNPRIV;
 	}
 
 #ifdef CONFIG_AUDITSYSCALL
@@ -1105,7 +1120,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		goto out_destroy_group;
 	}
 
-	group->fanotify_data.flags = flags;
+	group->fanotify_data.flags = flags | internal_flags;
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
 
 	group->fanotify_data.merge_hash = fanotify_alloc_merge_hash();
@@ -1305,11 +1320,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	group = f.file->private_data;
 
 	/*
-	 * An unprivileged user is not allowed to watch a mount point nor
-	 * a filesystem.
+	 * An unprivileged user is not allowed to setup mount nor filesystem
+	 * marks.  This also includes setting up such marks by a group that
+	 * was initialized by an unprivileged user.
 	 */
 	ret = -EPERM;
-	if (!capable(CAP_SYS_ADMIN) &&
+	if ((!capable(CAP_SYS_ADMIN) ||
+	     FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
 	    mark_type != FAN_MARK_INODE)
 		goto fput_and_out;
 
@@ -1460,6 +1477,7 @@ static int __init fanotify_user_setup(void)
 	max_marks = clamp(max_marks, FANOTIFY_OLD_DEFAULT_MAX_MARKS,
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
+	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index a712b2aaa9ac..57f0d5d9f934 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -144,7 +144,7 @@ void fanotify_show_fdinfo(struct seq_file *m, struct file *f)
 	struct fsnotify_group *group = f->private_data;
 
 	seq_printf(m, "fanotify flags:%x event-flags:%x\n",
-		   group->fanotify_data.flags,
+		   group->fanotify_data.flags & FANOTIFY_INIT_FLAGS,
 		   group->fanotify_data.f_flags);
 
 	show_fdinfo(m, f, fanotify_fdinfo);
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index bad41bcb25df..a16dbeced152 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -51,6 +51,10 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_ADMIN_INIT_FLAGS | \
 				 FANOTIFY_USER_INIT_FLAGS)
 
+/* Internal group flags */
+#define FANOTIFY_UNPRIV		0x80000000
+#define FANOTIFY_INTERNAL_GROUP_FLAGS	(FANOTIFY_UNPRIV)
+
 #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
 				 FAN_MARK_FILESYSTEM)
 
-- 
2.25.1

