Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C402185AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgGHLMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgGHLMI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF7AC08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so37192343wrl.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oubne8wXWrj/bFxoGmKp7Zl07250gESHqIsh+1rMSPc=;
        b=WaxYHoS1h814+a8heXRRdVHAmgD7KB2BPU2JGpFcV3e3Owp15qkwFXP/kHaYbbP9zZ
         qAgHiCXn9adFArh5cmTt1rSAN0j3jSqwC6bNv9zGxKXnHXFGeBCaMSFLLqVG4Si91GSV
         rP5pM96oij3zMeJjxigCiPR63RDMbFDTkAswBTJm/e9clLcpS1OLwd3PJb+b4znvnbd+
         bxEisXJ1N91w8vRfP8qAKOv/U327nrLji9uOBXrrbzlFxE7qi1S0p0jFnA9H+ClxZgJg
         d7L6FnUu2fxv4xf55f/usjPFun2S9SMRfIQMlTztRkKxTkVCFzp2lNBZHCiQSEl14fYH
         XtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oubne8wXWrj/bFxoGmKp7Zl07250gESHqIsh+1rMSPc=;
        b=aiQghzNvTfJkNbVbPMBmoEzG/dTjwVK8cSPer40xOtMH32kkG20Tv0FlLvjuWYA1ne
         2ApaADv88K0GOX3HpHwlz4/DvlUE484emLY8dCv/OQrKHtXV+0808mPIGmz2U7HYW4WP
         Pklt72qHI0MBKFeJGarpM0DnqZ/iZjRdSGb3eg/gz3/7iSKaY0VgExqgVjQYxBP4zie5
         bNNBlevp5wBEe+FpmAD0Djj7IJ8mOcaSan6HwpxE3QZeJoPNHG9DNcoU82ECI1mNDk50
         6zlLtoLISlXswkqhmijnMk9gp/kfiHOuz/kbYuTNq9YVwb/pzQBxtbIGOMWhUh5GVZls
         AJWA==
X-Gm-Message-State: AOAM531f/za84bcLrzJBHg9D2sGGPS+UP4FsPIQYdKAUuEiYJ4bv8X8o
        EWfAS3QyoRK8UnZ1VDLEhEeEvLcA
X-Google-Smtp-Source: ABdhPJydbZAuJh/Yjsf0V4xDSyj1oGg6xBUFZ9RNBXfijQUEN600RINqh/OSP3W32ZvKojRpQIDN+A==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr58431508wru.341.1594206726890;
        Wed, 08 Jul 2020 04:12:06 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:06 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v3 01/20] fsnotify: Rearrange fast path to minimise overhead when there is no watcher
Date:   Wed,  8 Jul 2020 14:11:36 +0300
Message-Id: <20200708111156.24659-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mel Gorman <mgorman@techsingularity.net>

The fsnotify paths are trivial to hit even when there are no watchers and
they are surprisingly expensive. For example, every successful vfs_write()
hits fsnotify_modify which calls both fsnotify_parent and fsnotify unless
FMODE_NONOTIFY is set which is an internal flag invisible to userspace.
As it stands, fsnotify_parent is a guaranteed functional call even if there
are no watchers and fsnotify() does a substantial amount of unnecessary
work before it checks if there are any watchers. A perf profile showed
that applying mnt->mnt_fsnotify_mask in fnotify() was almost half of the
total samples taken in that function during a test. This patch rearranges
the fast paths to reduce the amount of work done when there are no
watchers.

The test motivating this was "perf bench sched messaging --pipe". Despite
the fact the pipes are anonymous, fsnotify is still called a lot and
the overhead is noticeable even though it's completely pointless. It's
likely the overhead is negligible for real IO so this is an extreme
example. This is a comparison of hackbench using processes and pipes on
a 1-socket machine with 8 CPU threads without fanotify watchers.

                              5.7.0                  5.7.0
                            vanilla      fastfsnotify-v1r1
Amean     1       0.4837 (   0.00%)      0.4630 *   4.27%*
Amean     3       1.5447 (   0.00%)      1.4557 (   5.76%)
Amean     5       2.6037 (   0.00%)      2.4363 (   6.43%)
Amean     7       3.5987 (   0.00%)      3.4757 (   3.42%)
Amean     12      5.8267 (   0.00%)      5.6983 (   2.20%)
Amean     18      8.4400 (   0.00%)      8.1327 (   3.64%)
Amean     24     11.0187 (   0.00%)     10.0290 *   8.98%*
Amean     30     13.1013 (   0.00%)     12.8510 (   1.91%)
Amean     32     13.9190 (   0.00%)     13.2410 (   4.87%)

                       5.7.0       5.7.0
                     vanilla fastfsnotify-v1r1
Duration User         157.05      152.79
Duration System      1279.98     1219.32
Duration Elapsed      182.81      174.52

This is showing that the latencies are improved by roughly 2-9%. The
variability is not shown but some of these results are within the noise
as this workload heavily overloads the machine. That said, the system CPU
usage is reduced by quite a bit so it makes sense to avoid the overhead
even if it is a bit tricky to detect at times. A perf profile of just 1
group of tasks showed that 5.14% of samples taken were in either fsnotify()
or fsnotify_parent(). With the patch, 2.8% of samples were in fsnotify,
mostly function entry and the initial check for watchers.  The check for
watchers is complicated enough that inlining it may be controversial.

[Amir] Slightly simplify with mnt_or_sb_mask => marks_mask

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             | 27 +++++++++++++++------------
 include/linux/fsnotify.h         | 10 ++++++++++
 include/linux/fsnotify_backend.h |  4 ++--
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 72d332ce8e12..d59a58d10b84 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -143,7 +143,7 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 }
 
 /* Notify this dentry's parent about a child's events. */
-int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
+int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 		    int data_type)
 {
 	struct dentry *parent;
@@ -174,7 +174,7 @@ int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(fsnotify_parent);
+EXPORT_SYMBOL_GPL(__fsnotify_parent);
 
 static int send_to_group(struct inode *to_tell,
 			 __u32 mask, const void *data,
@@ -315,17 +315,11 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
 	struct fsnotify_iter_info iter_info = {};
 	struct super_block *sb = to_tell->i_sb;
 	struct mount *mnt = NULL;
-	__u32 mnt_or_sb_mask = sb->s_fsnotify_mask;
 	int ret = 0;
-	__u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
+	__u32 test_mask, marks_mask;
 
-	if (path) {
+	if (path)
 		mnt = real_mount(path->mnt);
-		mnt_or_sb_mask |= mnt->mnt_fsnotify_mask;
-	}
-	/* An event "on child" is not intended for a mount/sb mark */
-	if (mask & FS_EVENT_ON_CHILD)
-		mnt_or_sb_mask = 0;
 
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
@@ -337,13 +331,22 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
 	if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
 	    (!mnt || !mnt->mnt_fsnotify_marks))
 		return 0;
+
+	/* An event "on child" is not intended for a mount/sb mark */
+	marks_mask = to_tell->i_fsnotify_mask;
+	if (!(mask & FS_EVENT_ON_CHILD)) {
+		marks_mask |= sb->s_fsnotify_mask;
+		if (mnt)
+			marks_mask |= mnt->mnt_fsnotify_mask;
+	}
+
 	/*
 	 * if this is a modify event we may need to clear the ignored masks
 	 * otherwise return if neither the inode nor the vfsmount/sb care about
 	 * this type of event.
 	 */
-	if (!(mask & FS_MODIFY) &&
-	    !(test_mask & (to_tell->i_fsnotify_mask | mnt_or_sb_mask)))
+	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
+	if (!(mask & FS_MODIFY) && !(test_mask & marks_mask))
 		return 0;
 
 	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 5ab28f6c7d26..508f6bb0b06b 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -44,6 +44,16 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
 	fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0);
 }
 
+/* Notify this dentry's parent about a child's events. */
+static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
+				  const void *data, int data_type)
+{
+	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
+		return 0;
+
+	return __fsnotify_parent(dentry, mask, data, data_type);
+}
+
 /*
  * Simple wrappers to consolidate calls fsnotify_parent()/fsnotify() when
  * an event is on a file/dentry.
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index f0c506405b54..1626fa7d10ff 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -379,7 +379,7 @@ struct fsnotify_mark {
 /* main fsnotify call to send events */
 extern int fsnotify(struct inode *to_tell, __u32 mask, const void *data,
 		    int data_type, const struct qstr *name, u32 cookie);
-extern int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
+extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 			   int data_type);
 extern void __fsnotify_inode_delete(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
@@ -541,7 +541,7 @@ static inline int fsnotify(struct inode *to_tell, __u32 mask, const void *data,
 	return 0;
 }
 
-static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
+static inline int __fsnotify_parent(struct dentry *dentry, __u32 mask,
 				  const void *data, int data_type)
 {
 	return 0;
-- 
2.17.1

