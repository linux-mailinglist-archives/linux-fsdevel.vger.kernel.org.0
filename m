Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A1D6E355B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 08:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDPGHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 02:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPGHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 02:07:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662F592;
        Sat, 15 Apr 2023 23:07:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay3-20020a05600c1e0300b003f17289710aso194326wmb.5;
        Sat, 15 Apr 2023 23:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681625250; x=1684217250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MHs2OiyNeB77oMswLRgDQBmhCcd/eNcX257LXblooYc=;
        b=WKjCtK8z93Pzp6QZObVw0XiEZjRujhmwtGBr3Ga8L3xZp3z98LSDjxnGaA9/xsMZVT
         NmA54T5ovJ6CD4IF940k1fAn1AQHG/Af5PsxbXbxLmb7rr81gpuniBWZhGrO9baB+EH2
         hDIEFSI1B1eEGYChTiUznNEYGznWUQMnIjAAcC6U7sgu7yoUw/XNydDc49+Nkw3RLP18
         b+89yy9gwzmz5iHEwvSkkuMs7MWs5EHA+aDtuV0Xdal76zCvmNetYiAIBgo7F5uUx3o5
         hG+kB8C7VnBWd31zbM0l/cLxYkrX7SOWvnQnsn3dC5VPsk4U+2VZaVO4ofBKQitoPblG
         39bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681625250; x=1684217250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHs2OiyNeB77oMswLRgDQBmhCcd/eNcX257LXblooYc=;
        b=ZUahnpk3kcqpDk3+xgdMonoi4IeW6BjqmB0ZZoY7VowM5eAYm5uO8Y5moXmlxVM2Jb
         cTjrWcNj7tcDN8V7LCfsyOUCAAM4iMAUDpx55PIGEac3cUuj1w/w317DCngDykW88CiC
         0y4b6WajOp237ZI7T6HA/waYSDkmgBlFCmepmDA6kUFSb3GebWYxqQC8MNe+wUTsH0O7
         RsgDNuR/ujaoHQ+zEcIj9pxMdx2OQ8GDXPIPVv/rkVmaf/9H8IEjC6G8/hHL8wD41jUW
         mhB/ubdz5hm+FzlvpENrzRInRzE8FleMIchs2AZh1j0yP/vUEbPWVWvwiR1Af9HkT24a
         sSrA==
X-Gm-Message-State: AAQBX9e/m12yslGBRsAXLARK95uRReFv1T2R/Ke10xe7mEMd07f5EP7S
        1ua9hYDFlP1PfhrD724azrw=
X-Google-Smtp-Source: AKy350Z6ZwzZ9y/JWy83erY60BYODJRQSJzsY0uLR26z+X+f3BOOkeXJIMIhfoWcPHO4ZRQjwnWpfg==
X-Received: by 2002:a7b:ca45:0:b0:3ee:9c0e:c78f with SMTP id m5-20020a7bca45000000b003ee9c0ec78fmr7817335wml.5.1681625249711;
        Sat, 15 Apr 2023 23:07:29 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c160900b003f0b1c4f229sm5316500wmn.28.2023.04.15.23.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 23:07:29 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [RFC][PATCH] fanotify: support watching filesystems and mounts inside userns
Date:   Sun, 16 Apr 2023 09:07:22 +0300
Message-Id: <20230416060722.1912831-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An unprivileged user is allowed to create an fanotify group and add
inode marks, but not filesystem and mount marks.

Add limited support for setting up filesystem and mount marks by an
unprivileged user under the following conditions:

1.   User has CAP_SYS_ADMIN in the user ns where the group was created
2.a. User has CAP_SYS_ADMIN in the user ns where the filesystem was
     mounted (implies FS_USERNS_MOUNT)
  OR (in case setting up a mark mount)
2.b. User has CAP_SYS_ADMIN in the user ns attached to an idmapped mount

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

This patch is from a WIP followup to unpriv fanotify two years ago [1].

I realize that I never posted it, partly because we wanted to let the
dust settle on upriv fanotify first.

Reading back the thread, it mostly revolved around trying to leverage
idmapped mounts to implement subtree watches, which didn't converge to
a workable solution.

Besides that there was the minor detail that userns admin cannot use
open_by_file_handle() to resolve the path from fids, but that's not
realy a show stopper from using fanotify sb/mount marks within userns.

If there were any other concerns regarding this patch, I did not find
them in the thread.

A recent request from Christian to watch (within user ns) when a mount
is being unmounted brought this patch back to mind, but note that this
patch is complementary to FAN_UNMOUNT patches [2] and would be useful
regardless on FAN_UNMOUNT patches.

I've only tested it manually, because LTP does not (yet) have good
helpers to setup userns with its own mount ns nor idmapped mounts.

Christian,

You can find this patch, along with FAN_UNMOUNT patches on my github [3].
Please confirm that this meets your needs for watching container mounts.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20230414182903.1852019-1-amir73il@gmail.com/
[3] https://github.com/amir73il/linux/commits/fan_unmount

 fs/notify/fanotify/fanotify.c      |  1 +
 fs/notify/fanotify/fanotify_user.c | 58 +++++++++++++++++-------------
 include/linux/fsnotify_backend.h   |  1 +
 3 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index c204259be6cc..55f45f22b25f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -1040,6 +1040,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 
 static void fanotify_free_group_priv(struct fsnotify_group *group)
 {
+	put_user_ns(group->user_ns);
 	kfree(group->fanotify_data.merge_hash);
 	if (group->fanotify_data.ucounts)
 		dec_ucount(group->fanotify_data.ucounts,
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index db3b79b8e901..2c3e123aee14 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1238,6 +1238,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	 * A group with FAN_UNLIMITED_MARKS does not contribute to mark count
 	 * in the limited groups account.
 	 */
+	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_MARKS));
 	if (!FAN_GROUP_FLAG(group, FAN_UNLIMITED_MARKS) &&
 	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
 		return ERR_PTR(-ENOSPC);
@@ -1423,6 +1424,7 @@ static struct hlist_head *fanotify_alloc_merge_hash(void)
 /* fanotify syscalls */
 SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 {
+	struct user_namespace *user_ns = current_user_ns();
 	struct fsnotify_group *group;
 	int f_flags, fd;
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
@@ -1514,8 +1516,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	}
 
 	/* Enforce groups limits per user in all containing user ns */
-	group->fanotify_data.ucounts = inc_ucount(current_user_ns(),
-						  current_euid(),
+	group->fanotify_data.ucounts = inc_ucount(user_ns, current_euid(),
 						  UCOUNT_FANOTIFY_GROUPS);
 	if (!group->fanotify_data.ucounts) {
 		fd = -EMFILE;
@@ -1524,6 +1525,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 
 	group->fanotify_data.flags = flags | internal_flags;
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
+	group->user_ns = get_user_ns(user_ns);
 
 	group->fanotify_data.merge_hash = fanotify_alloc_merge_hash();
 	if (!group->fanotify_data.merge_hash) {
@@ -1557,21 +1559,13 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		goto out_destroy_group;
 	}
 
+	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
 	if (flags & FAN_UNLIMITED_QUEUE) {
-		fd = -EPERM;
-		if (!capable(CAP_SYS_ADMIN))
-			goto out_destroy_group;
 		group->max_events = UINT_MAX;
 	} else {
 		group->max_events = fanotify_max_queued_events;
 	}
 
-	if (flags & FAN_UNLIMITED_MARKS) {
-		fd = -EPERM;
-		if (!capable(CAP_SYS_ADMIN))
-			goto out_destroy_group;
-	}
-
 	if (flags & FAN_ENABLE_AUDIT) {
 		fd = -EPERM;
 		if (!capable(CAP_AUDIT_WRITE))
@@ -1758,17 +1752,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 	group = f.file->private_data;
 
-	/*
-	 * An unprivileged user is not allowed to setup mount nor filesystem
-	 * marks.  This also includes setting up such marks by a group that
-	 * was initialized by an unprivileged user.
-	 */
-	ret = -EPERM;
-	if ((!capable(CAP_SYS_ADMIN) ||
-	     FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
-	    mark_type != FAN_MARK_INODE)
-		goto fput_and_out;
-
 	/*
 	 * group->priority == FS_PRIO_0 == FAN_CLASS_NOTIF.  These are not
 	 * allowed to set permissions events.
@@ -1821,6 +1804,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 
 	if (mark_cmd == FAN_MARK_FLUSH) {
+		/*
+		 * A user is not allowed to flush sb/mount marks unless the
+		 * user is capable in the user ns where the group was created.
+		 */
+		ret = -EPERM;
+		if (!ns_capable(group->user_ns, CAP_SYS_ADMIN) &&
+		    mark_type != FAN_MARK_INODE)
+			goto fput_and_out;
+
 		ret = 0;
 		if (mark_type == FAN_MARK_MOUNT)
 			fsnotify_clear_vfsmount_marks_by_group(group);
@@ -1861,10 +1853,28 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	/* inode held in place by reference to path; group by fget on fd */
-	if (mark_type == FAN_MARK_INODE)
+	if (mark_type == FAN_MARK_INODE) {
 		inode = path.dentry->d_inode;
-	else
+	} else {
+		/*
+		 * A user is not allowed to setup sb/mount marks unless the
+		 * user is capable in the user ns where the group was created.
+		 * The user also needs to be capable either in the user ns
+		 * associated with the marked filesystem or in the user ns
+		 * associated with an idmapped mount (when marking a mount).
+		 */
+		ret = -EPERM;
+		if (!ns_capable(group->user_ns, CAP_SYS_ADMIN))
+			goto path_put_and_out;
+
 		mnt = path.mnt;
+		if (!ns_capable(mnt->mnt_sb->s_user_ns, CAP_SYS_ADMIN)) {
+			if (mark_type == FAN_MARK_FILESYSTEM ||
+			    !ns_capable(real_mount(mnt)->mnt_ns->user_ns,
+					CAP_SYS_ADMIN))
+				goto path_put_and_out;
+		}
+	}
 
 	ret = mnt ? -EINVAL : -EISDIR;
 	/* FAN_MARK_IGNORE requires SURV_MODIFY for sb/mount/dir marks */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index f942b1d6326c..70df7eace7e5 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -230,6 +230,7 @@ struct fsnotify_group {
 						 * full */
 
 	struct mem_cgroup *memcg;	/* memcg to charge allocations */
+	struct user_namespace *user_ns;	/* user ns where group was created */
 
 	/* groups can define private fields here or use the void *private */
 	union {
-- 
2.34.1

