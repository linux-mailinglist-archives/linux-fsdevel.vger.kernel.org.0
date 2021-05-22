Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC25B38D4B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 11:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhEVJUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 May 2021 05:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhEVJUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 May 2021 05:20:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BCEC061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 May 2021 02:19:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z17so23259731wrq.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 May 2021 02:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ibOaEvEtIp3f+K5FRQwhVr4TFvq4KD2j90XlRyTxk+8=;
        b=EXzzhQ16WhmfY0i1q6SdjcQdKgM6VATc/kdTaqJBlbCSr0dItkDT1Lnp2t9O5Lk3iR
         92cUJJhkfsnkhGXyXie8WpxKm30G9LDWSmDH5JRz4RajBSMzzqKhOo5Fj6CKb09CWF3B
         MmhoxDZdI2ojT2q858HPSkiqD3If6vlhRu+IVczGRBL75sMtKz7b73xpkWTBtHDNjiqf
         EqCZHyBssi2ZcV5ry4SpMEo3DedukKrrq/PH4EvtQ5Vk/O0dV6DQILsVGfC2CV030dmD
         PAZC/CoPj6L+JREhIkN/cdyGWrKhsByxZYgyig1w00of2muIbCS9fgDlK5Vsf2ZXgaVv
         bi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ibOaEvEtIp3f+K5FRQwhVr4TFvq4KD2j90XlRyTxk+8=;
        b=GbEPImTdMzrcgbZ3P6bECMTEdYslI3FaGyTGH75MIO+G5mN1x9gfTZ6+kJ3rujUvbO
         foTp1MBV3rGesspwDxXzLRZdmOJHydOznYXkipHOuFWdr3NNZP9n8b46DPl9YMKE8j1v
         iEpBJcVdQSsEa1rGRAfMN6AAV7/YsJiiRuZZ43Cer9ap0NoqkrpHZCP10nAH20QCD3VG
         VMc6CiNViJpIR+WPRrARlaz6mNmAv1Dt5GmCBVzoz2zFrXdQIfzlB6Y27WfPlXxbTr59
         Z47uom9fkeEK1koi2K9KlEe6wQW2MaDi3xopLpywnyWWbFetqqwxnxu7XI9Y93zoHKKc
         umfg==
X-Gm-Message-State: AOAM533RZZGHhWyMuyi5JuV3i0C9lzOrhyNyCprze7R/CU+NXt5UZU1Y
        gEVtrzL4cyeEczIoHPSCeFs=
X-Google-Smtp-Source: ABdhPJxtoHMAolnF3MvL/3i0kKQC6z05+fXzLUMtwydRHV1xtFmto5nrZE5dWz0YOshCM3V3cXzYbQ==
X-Received: by 2002:adf:a519:: with SMTP id i25mr13440933wrb.312.1621675158693;
        Sat, 22 May 2021 02:19:18 -0700 (PDT)
Received: from localhost.localdomain ([82.114.45.171])
        by smtp.gmail.com with ESMTPSA id f12sm4779247wre.88.2021.05.22.02.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 02:19:18 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: fix permission model of unprivileged group
Date:   Sat, 22 May 2021 12:19:16 +0300
Message-Id: <20210522091916.196741-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reporting event->pid should depend on the privileges of the user that
initialized the group, not the privileges of the user reading the
events.

Use an internal group flag FANOTIFY_UNPRIV to record the fact the the
group was initialized by an unprivileged user.

To be on the safe side, the premissions to setup filesystem and mount
marks now require that both the user that initialized the group and
the user setting up the mark have CAP_SYS_ADMIN.

Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivileged users")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

The original RFC [1] used the internal flag to check permissions for:
1. Reporting event->pid
2. Reporting event->fd
3. Setting up sb/mount marks

Although we discussed only adding the check for #1, I left all those
checks.

The check for #2 is redundant, but it feels safer to be
defensive to protect against leaked fds.

The check for #3 was added in addition to the existing permission checks
because it feels right. Let me know if you disagree.

I've adjusted Matthew's LTP test [2] to check case #1.

Thanks,
Amir.


[1] https://lore.kernel.org/linux-fsdevel/20210124184204.899729-3-amir73il@gmail.com/
[1] https://github.com/amir73il/ltp/commits/fanotify_unpriv

 fs/notify/fanotify/fanotify_user.c | 30 ++++++++++++++++++++++++------
 fs/notify/fdinfo.c                 |  2 +-
 include/linux/fanotify.h           |  4 ++++
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 71fefb30e015..7df6cba4a06d 100644
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
+	 * For now, we require fid mode for unprivileged listener, which does
+	 * record path events, but keep this check for safety in case we want
+	 * to allow unprivileged listener to get events with no fd and no fid
+	 * in the future.
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
+		 * We set the internal flag FANOTIFY_UNPRIV on the group, so we
+		 * know that we need to limit setting mount/filesystem marks on
+		 * this group and avoid providing pid and open fd in the event.
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
+	 * An unprivileged user is not allowed to setup mount point nor
+	 * filesystem marks. It is not allowed to setup those marks for
+	 * a group that was initialized by an unprivileged user.
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
 
+	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_FLAGS);
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
index bad41bcb25df..f277d1c4e6b8 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -51,6 +51,10 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_ADMIN_INIT_FLAGS | \
 				 FANOTIFY_USER_INIT_FLAGS)
 
+/* Internal flags */
+#define FANOTIFY_UNPRIV		0x80000000
+#define FANOTIFY_INTERNAL_FLAGS	(FANOTIFY_UNPRIV)
+
 #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
 				 FAN_MARK_FILESYSTEM)
 
-- 
2.31.1

