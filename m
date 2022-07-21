Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D8457C5FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 10:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiGUIQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiGUIQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:16:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DF17D781
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 01:16:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so795834pjf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vcjP/TTiCJtollpq0IPhYOJ7clDYhyVICdNwHyD3LrE=;
        b=zSgKsABZNHCGDGlRauoWxpAH/o/0gRVuIgQ9ktno6Af3XPNaeY7ZIkQbIP1dODyyW6
         SyK/9cq3DiYyhrwSAOBIgFy9YhGgH3oPglY56gT28qdvQij5J8IbvF1G3UAurRqRaLY8
         VlNnceYzSRQ59u17FNBweM260mhdf51ls1OGj1DTrVpwjr2ukZ/l+p1ccJvzkhaULMDC
         VOSTkOS1+lFNpaMcgUJHwvvZ5HSZckSRvTuQrpsQL/Xig2HvGDgJeOkGGVwf8/ezcr07
         YEdk1nTyI82qUMYsFB3Rxl6jpyYHSc3z0T6MfwpB33NJWKdp90G2ueFhHfAEMcyEitg8
         FkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vcjP/TTiCJtollpq0IPhYOJ7clDYhyVICdNwHyD3LrE=;
        b=SN4w/smnnVQ/gE0uf4NNvqA7umv0A5mzx1U2G6OJ3Df5YgwZwcQ232JzCJ8o1uYG2j
         DCk/MBtH2Ljwkik+oCWMZk0p6wlrsUOKkfuLzIj+r9w5aHkRVCRaAMx1/zeVRNYtM/ie
         42gaOG/+ZvGV9esywC5Fy9/YKrdzwDFqKir+3i3Lv4gfy5wirO7AaWftWt2dWQM8of2y
         f+jDMP7v0kY5B1//Z8qnqlju1Nh5Nb1mjV+oapyol52zvYzTU+RguX5d9K9tJ7fK4V1h
         DKDekpqZlShiAaMZTkY9gxL6MV+cDtFnjzFa+WJg4Uo6gm47TtswskBIx8xADCCo2YI4
         xYZA==
X-Gm-Message-State: AJIora8PrQQ6CQLxf29Uea39UhQx/+D45igGD0ETDr/KakfQsdJR67ul
        h4s1AEujqxF7isG3gs8rqHbgBA==
X-Google-Smtp-Source: AGRyM1uXK++DxHvIzgYiDg8vMrV8xv2FtMAqJSlSdEaG5dKsvrlGScwbEADljdYPFp4BHWGJk22qlA==
X-Received: by 2002:a17:90a:9409:b0:1f0:e171:f2bd with SMTP id r9-20020a17090a940900b001f0e171f2bdmr9758963pjo.245.1658391386081;
        Thu, 21 Jul 2022 01:16:26 -0700 (PDT)
Received: from C02GF2LXMD6R.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a694200b001f204399045sm837995pjm.17.2022.07.21.01.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:16:25 -0700 (PDT)
From:   Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        songmuchun@bytedance.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Subject: [RFC] proc: fix create timestamp of files in proc
Date:   Thu, 21 Jul 2022 16:16:17 +0800
Message-Id: <20220721081617.36103-1-zhangyuchen.lcr@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A user has reported a problem that the /proc/{pid} directory
creation timestamp is incorrect.
He believes that the directory was created when the process was
started, so the timestamp of the directory creation should also
be when the process was created.

The file timestamp in procfs is the timestamp when the inode was
created. If the inode of a file in procfs is reclaimed, the inode
will be recreated when it is opened again, and the timestamp will
be changed to the time when it was recreated.
In other file systems, this timestamp is typically recorded in
the file system and assigned to the inode when the inode is created.

This mechanism can be confusing to users who are not familiar with
it.
For users who know this mechanism, they will choose not to trust
this time.
So the timestamp now has no meaning other than to confuse the user.
It needs fixing.

There are three solutions. We don't have to make the timestamp
meaningful, as long as the user doesn't trust the timestamp.

1. Add to the kernel documentation that the timestamp in PROC is
   not reliable and do not use this timestamp.
   The problem with this solution is that most users don't read
   the kernel documentation and it can still be misleading.

2. Fix it, change the timestamp of /proc/pid to the timestamp of
   process creation.

   This raises new questions.

   a. Users don't know which kernel version is correct.

   b. This problem exists not only in the pid directory, but also
      in other directories under procfs. It would take a lot of
      extra work to fix them all. There are also easier ways for
      users to get the creation time information better than this.

   c. We need to describe the specific meaning of each file under
      proc in the kernel documentation for the creation time.
      Because the creation time of various directories has different
      meanings. For example, PID directory is the process creation
      time, FD directory is the FD creation time and so on.

   d. Some files have no associated entity, such as iomem.
      Unable to give a meaningful time.

3. Instead of fixing it, set the timestamp in all procfs to 0.
   Users will see it as an error and will not use it.

I think 3 is better. Any other suggestions?

Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
---
 fs/proc/base.c        | 4 +++-
 fs/proc/inode.c       | 3 ++-
 fs/proc/proc_sysctl.c | 3 ++-
 fs/proc/self.c        | 3 ++-
 fs/proc/thread_self.c | 3 ++-
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 0b72a6d8aac3..af440ef13091 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1892,6 +1892,8 @@ struct inode *proc_pid_make_inode(struct super_block *sb,
 	struct proc_inode *ei;
 	struct pid *pid;
 
+	struct timespec64 ts_zero = {0, 0};
+
 	/* We need a new inode */
 
 	inode = new_inode(sb);
@@ -1902,7 +1904,7 @@ struct inode *proc_pid_make_inode(struct super_block *sb,
 	ei = PROC_I(inode);
 	inode->i_mode = mode;
 	inode->i_ino = get_next_ino();
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
 	inode->i_op = &proc_def_inode_operations;
 
 	/*
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index fd40d60169b5..efb1c935fa8d 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -642,6 +642,7 @@ const struct inode_operations proc_link_inode_operations = {
 struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 {
 	struct inode *inode = new_inode(sb);
+	struct timespec64 ts_zero = {0, 0};
 
 	if (!inode) {
 		pde_put(de);
@@ -650,7 +651,7 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 
 	inode->i_private = de->data;
 	inode->i_ino = de->low_ino;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
 	PROC_I(inode)->pde = de;
 	if (is_empty_pde(de)) {
 		make_empty_dir_inode(inode);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 021e83fe831f..c670f9d3b871 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -455,6 +455,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 	struct ctl_table_root *root = head->root;
 	struct inode *inode;
 	struct proc_inode *ei;
+	struct timespec64 ts_zero = {0, 0};
 
 	inode = new_inode(sb);
 	if (!inode)
@@ -476,7 +477,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 	head->count++;
 	spin_unlock(&sysctl_lock);
 
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
 	inode->i_mode = table->mode;
 	if (!S_ISDIR(table->mode)) {
 		inode->i_mode |= S_IFREG;
diff --git a/fs/proc/self.c b/fs/proc/self.c
index 72cd69bcaf4a..b9e572fdc27c 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -44,9 +44,10 @@ int proc_setup_self(struct super_block *s)
 	self = d_alloc_name(s->s_root, "self");
 	if (self) {
 		struct inode *inode = new_inode(s);
+		struct timespec64 ts_zero = {0, 0};
 		if (inode) {
 			inode->i_ino = self_inum;
-			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
 			inode->i_mode = S_IFLNK | S_IRWXUGO;
 			inode->i_uid = GLOBAL_ROOT_UID;
 			inode->i_gid = GLOBAL_ROOT_GID;
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index a553273fbd41..964966387da2 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -44,9 +44,10 @@ int proc_setup_thread_self(struct super_block *s)
 	thread_self = d_alloc_name(s->s_root, "thread-self");
 	if (thread_self) {
 		struct inode *inode = new_inode(s);
+		struct timespec64 ts_zero = {0, 0};
 		if (inode) {
 			inode->i_ino = thread_self_inum;
-			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
 			inode->i_mode = S_IFLNK | S_IRWXUGO;
 			inode->i_uid = GLOBAL_ROOT_UID;
 			inode->i_gid = GLOBAL_ROOT_GID;
-- 
2.30.2

