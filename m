Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16614560384
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 16:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiF2Om0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiF2OmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:42:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AE938190;
        Wed, 29 Jun 2022 07:42:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v14so22804262wra.5;
        Wed, 29 Jun 2022 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBmdR31lITbnXi4dWozOL9aFFSNyRKsnIRTUmH6suRw=;
        b=Y1pxYvGuFwE6EUVKxTuNXSRxIQ5i/fnHcSK6Vsgd55pVHLE7n5oyUuO2qRgqy2vcAo
         E0rjz0CTqqXdBZTtXYMwkRhSl5tT30t03KFaPcQf63nQdUzUOZoEaqUOGoDyQ8yC5WpH
         cqOffZwrXIe8SnmR1O3juePtqP+nFdIwPG0cSsg3+X0jfFlxWy0/1FvX+a49Ggk7NFFO
         ub+7oDv+0HoeFCgi+Th36Fm8nL+JA8sbR36TsrS/Ajk0RyBwuiGNHllbUkKSLCnGY68R
         pWXRHqtffpuV7Y7VRFTYMP6PtULkZSi2PHGK484CHnu7Y32Lp2X7oDwMjej3YwGctix1
         8yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBmdR31lITbnXi4dWozOL9aFFSNyRKsnIRTUmH6suRw=;
        b=cKrfMfWk0dFbpiWXd3V1lzOwzUrHqQCJeh/aINcpFMPyfr+Y/28JhtXW6gP1SAr2yJ
         jZ+RQd5Gl+x76naE5WN5QsLjmnoWXw1BZ1700W7fOB4q9mTxZSX7ar1hYAyus8WY/S15
         jrobjiUVozVubCu4usS+emFx1XKxLDw778s6GgFhAE7boRZzpNKkCfiV+8HanVyuu+3I
         nriX72zqRTkdV5cvRWB/5LKJWjd3mKxtTXKTY6Pny61KN008+Vz8rGpzElqxWiOtkp8N
         RRTdZy2ro3tbEq11gaRCzqT0KO3brRZSTWe7x36wrXoBh+ulO/sZCpuF0HnkUDyhuyFy
         8IeA==
X-Gm-Message-State: AJIora/Se+tgofraMWF9aidzB8X97wgEQ4wmbOg16tRbB1XB55MEZRPz
        kkvezESVbcjxPwAQqqLEfAFzxQuFRyo=
X-Google-Smtp-Source: AGRyM1tNSWfoZpNJi+mVopZQZ1xRSUqXRRHXRJtD1JRE7e8i6OoQDjY7uYvzVAwcJVJzLtUNTqfSkw==
X-Received: by 2002:a05:6000:1a8b:b0:219:af0c:ddf8 with SMTP id f11-20020a0560001a8b00b00219af0cddf8mr3356324wry.142.1656513737193;
        Wed, 29 Jun 2022 07:42:17 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4e5100b0039c747a1e8fsm3562085wmq.7.2022.06.29.07.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:42:16 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 1/3] fanotify: prepare for setting event flags in ignore mask
Date:   Wed, 29 Jun 2022 17:42:08 +0300
Message-Id: <20220629144210.2983229-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629144210.2983229-1-amir73il@gmail.com>
References: <20220629144210.2983229-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Setting flags FAN_ONDIR FAN_EVENT_ON_CHILD in ignore mask has no effect.
The FAN_EVENT_ON_CHILD flag in mask implicitly applies to ignore mask and
ignore mask is always implicitly applied to events on directories.

Define a mark flag that replaces this legacy behavior with logic of
applying the ignore mask according to event flags in ignore mask.

Implement the new logic to prepare for supporting an ignore mask that
ignores events on children and ignore mask that does not ignore events
on directories.

To emphasize the change in terminology, also rename ignored_mask mark
member to ignore_mask and use accessors to get only the effective
ignored events or the ignored events and flags.

This change in terminology finally aligns with the "ignore mask"
language in man pages and in most of the comments.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 19 ++++---
 fs/notify/fanotify/fanotify_user.c | 21 ++++---
 fs/notify/fdinfo.c                 |  6 +-
 fs/notify/fsnotify.c               | 21 ++++---
 include/linux/fsnotify_backend.h   | 89 ++++++++++++++++++++++++++++--
 5 files changed, 121 insertions(+), 35 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 4f897e109547..cd7d09a569ff 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -295,12 +295,13 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     const void *data, int data_type,
 				     struct inode *dir)
 {
-	__u32 marks_mask = 0, marks_ignored_mask = 0;
+	__u32 marks_mask = 0, marks_ignore_mask = 0;
 	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
 				     FANOTIFY_EVENT_FLAGS;
 	const struct path *path = fsnotify_data_path(data, data_type);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct fsnotify_mark *mark;
+	bool ondir = event_mask & FAN_ONDIR;
 	int type;
 
 	pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
@@ -315,19 +316,21 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 			return 0;
 	} else if (!(fid_mode & FAN_REPORT_FID)) {
 		/* Do we have a directory inode to report? */
-		if (!dir && !(event_mask & FS_ISDIR))
+		if (!dir && !ondir)
 			return 0;
 	}
 
 	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
-		/* Apply ignore mask regardless of mark's ISDIR flag */
-		marks_ignored_mask |= mark->ignored_mask;
+		/*
+		 * Apply ignore mask depending on event flags in ignore mask.
+		 */
+		marks_ignore_mask |=
+			fsnotify_effective_ignore_mask(mark, ondir, type);
 
 		/*
-		 * If the event is on dir and this mark doesn't care about
-		 * events on dir, don't send it!
+		 * Send the event depending on event flags in mark mask.
 		 */
-		if (event_mask & FS_ISDIR && !(mark->mask & FS_ISDIR))
+		if (!fsnotify_mask_applicable(mark->mask, ondir, type))
 			continue;
 
 		marks_mask |= mark->mask;
@@ -336,7 +339,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		*match_mask |= 1U << type;
 	}
 
-	test_mask = event_mask & marks_mask & ~marks_ignored_mask;
+	test_mask = event_mask & marks_mask & ~marks_ignore_mask;
 
 	/*
 	 * For dirent modification events (create/delete/move) that do not carry
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index b08ce0d821a7..a9eea037fee9 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1012,7 +1012,7 @@ static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
 	if (!(flags & FAN_MARK_IGNORED_MASK)) {
 		fsn_mark->mask &= ~mask;
 	} else {
-		fsn_mark->ignored_mask &= ~mask;
+		fsn_mark->ignore_mask &= ~mask;
 	}
 	newmask = fsnotify_calc_mask(fsn_mark);
 	/*
@@ -1021,7 +1021,7 @@ static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
 	 * changes to the mask.
 	 * Destroy mark when only umask bits remain.
 	 */
-	*destroy = !((fsn_mark->mask | fsn_mark->ignored_mask) & ~umask);
+	*destroy = !((fsn_mark->mask | fsn_mark->ignore_mask) & ~umask);
 	spin_unlock(&fsn_mark->lock);
 
 	return oldmask & ~newmask;
@@ -1090,7 +1090,7 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 	/*
 	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
 	 * the removal of the FS_MODIFY bit in calculated mask if it was set
-	 * because of an ignored mask that is now going to survive FS_MODIFY.
+	 * because of an ignore mask that is now going to survive FS_MODIFY.
 	 */
 	if ((fan_flags & FAN_MARK_IGNORED_MASK) &&
 	    (fan_flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
@@ -1123,7 +1123,7 @@ static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 	if (!(fan_flags & FAN_MARK_IGNORED_MASK))
 		fsn_mark->mask |= mask;
 	else
-		fsn_mark->ignored_mask |= mask;
+		fsn_mark->ignore_mask |= mask;
 
 	recalc = fsnotify_calc_mask(fsn_mark) &
 		~fsnotify_conn_mask(fsn_mark->connector);
@@ -1261,7 +1261,7 @@ static int fanotify_add_inode_mark(struct fsnotify_group *group,
 
 	/*
 	 * If some other task has this inode open for write we should not add
-	 * an ignored mark, unless that ignored mark is supposed to survive
+	 * an ignore mask, unless that ignore mask is supposed to survive
 	 * modification changes anyway.
 	 */
 	if ((flags & FAN_MARK_IGNORED_MASK) &&
@@ -1557,7 +1557,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	__kernel_fsid_t __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
-	bool ignored = flags & FAN_MARK_IGNORED_MASK;
+	bool ignore = flags & FAN_MARK_IGNORED_MASK;
 	unsigned int obj_type, fid_mode;
 	u32 umask = 0;
 	int ret;
@@ -1606,8 +1606,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (mask & ~valid_mask)
 		return -EINVAL;
 
-	/* Event flags (ONDIR, ON_CHILD) are meaningless in ignored mask */
-	if (ignored)
+	/*
+	 * Event flags (FAN_ONDIR, FAN_EVENT_ON_CHILD) have no effect with
+	 * FAN_MARK_IGNORED_MASK.
+	 */
+	if (ignore)
 		mask &= ~FANOTIFY_EVENT_FLAGS;
 
 	f = fdget(fanotify_fd);
@@ -1721,7 +1724,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		 * events with parent/name info for non-directory.
 		 */
 		if ((fid_mode & FAN_REPORT_DIR_FID) &&
-		    (flags & FAN_MARK_ADD) && !ignored)
+		    (flags & FAN_MARK_ADD) && !ignore)
 			mask |= FAN_EVENT_ON_CHILD;
 	}
 
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 59fb40abe33d..55081ae3a6ec 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -113,7 +113,7 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 			return;
 		seq_printf(m, "fanotify ino:%lx sdev:%x mflags:%x mask:%x ignored_mask:%x ",
 			   inode->i_ino, inode->i_sb->s_dev,
-			   mflags, mark->mask, mark->ignored_mask);
+			   mflags, mark->mask, mark->ignore_mask);
 		show_mark_fhandle(m, inode);
 		seq_putc(m, '\n');
 		iput(inode);
@@ -121,12 +121,12 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 		struct mount *mnt = fsnotify_conn_mount(mark->connector);
 
 		seq_printf(m, "fanotify mnt_id:%x mflags:%x mask:%x ignored_mask:%x\n",
-			   mnt->mnt_id, mflags, mark->mask, mark->ignored_mask);
+			   mnt->mnt_id, mflags, mark->mask, mark->ignore_mask);
 	} else if (mark->connector->type == FSNOTIFY_OBJ_TYPE_SB) {
 		struct super_block *sb = fsnotify_conn_sb(mark->connector);
 
 		seq_printf(m, "fanotify sdev:%x mflags:%x mask:%x ignored_mask:%x\n",
-			   sb->s_dev, mflags, mark->mask, mark->ignored_mask);
+			   sb->s_dev, mflags, mark->mask, mark->ignore_mask);
 	}
 }
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 0b3e74935cb4..8687562df2e3 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -324,7 +324,8 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 	struct fsnotify_group *group = NULL;
 	__u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
 	__u32 marks_mask = 0;
-	__u32 marks_ignored_mask = 0;
+	__u32 marks_ignore_mask = 0;
+	bool is_dir = mask & FS_ISDIR;
 	struct fsnotify_mark *mark;
 	int type;
 
@@ -336,7 +337,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 		fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
 			if (!(mark->flags &
 			      FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
-				mark->ignored_mask = 0;
+				mark->ignore_mask = 0;
 		}
 	}
 
@@ -344,14 +345,15 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
 		group = mark->group;
 		marks_mask |= mark->mask;
-		marks_ignored_mask |= mark->ignored_mask;
+		marks_ignore_mask |=
+			fsnotify_effective_ignore_mask(mark, is_dir, type);
 	}
 
-	pr_debug("%s: group=%p mask=%x marks_mask=%x marks_ignored_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
-		 __func__, group, mask, marks_mask, marks_ignored_mask,
+	pr_debug("%s: group=%p mask=%x marks_mask=%x marks_ignore_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
+		 __func__, group, mask, marks_mask, marks_ignore_mask,
 		 data, data_type, dir, cookie);
 
-	if (!(test_mask & marks_mask & ~marks_ignored_mask))
+	if (!(test_mask & marks_mask & ~marks_ignore_mask))
 		return 0;
 
 	if (group->ops->handle_event) {
@@ -423,7 +425,8 @@ static bool fsnotify_iter_select_report_types(
 			 * But is *this mark* watching children?
 			 */
 			if (type == FSNOTIFY_ITER_TYPE_PARENT &&
-			    !(mark->mask & FS_EVENT_ON_CHILD))
+			    !(mark->mask & FS_EVENT_ON_CHILD) &&
+			    !(fsnotify_ignore_mask(mark) & FS_EVENT_ON_CHILD))
 				continue;
 
 			fsnotify_iter_set_report_type(iter_info, type);
@@ -532,8 +535,8 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 
 
 	/*
-	 * If this is a modify event we may need to clear some ignored masks.
-	 * In that case, the object with ignored masks will have the FS_MODIFY
+	 * If this is a modify event we may need to clear some ignore masks.
+	 * In that case, the object with ignore masks will have the FS_MODIFY
 	 * event in its mask.
 	 * Otherwise, return if none of the marks care about this type of event.
 	 */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 9560734759fa..a7d605d49a84 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -518,8 +518,8 @@ struct fsnotify_mark {
 	struct hlist_node obj_list;
 	/* Head of list of marks for an object [mark ref] */
 	struct fsnotify_mark_connector *connector;
-	/* Events types to ignore [mark->lock, group->mark_mutex] */
-	__u32 ignored_mask;
+	/* Events types and flags to ignore [mark->lock, group->mark_mutex] */
+	__u32 ignore_mask;
 	/* General fsnotify mark flags */
 #define FSNOTIFY_MARK_FLAG_ALIVE		0x0001
 #define FSNOTIFY_MARK_FLAG_ATTACHED		0x0002
@@ -529,6 +529,7 @@ struct fsnotify_mark {
 	/* fanotify mark flags */
 #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
 #define FSNOTIFY_MARK_FLAG_NO_IREF		0x0200
+#define FSNOTIFY_MARK_FLAG_IGNORE_FLAGS		0x0400
 	unsigned int flags;		/* flags [mark->lock] */
 };
 
@@ -655,15 +656,91 @@ extern void fsnotify_remove_queued_event(struct fsnotify_group *group,
 
 /* functions used to manipulate the marks attached to inodes */
 
-/* Get mask for calculating object interest taking ignored mask into account */
+/*
+ * Canonical "ignore mask" including event flags.
+ *
+ * Note the subtle semantic difference from the legacy ->ignored_mask.
+ * ->ignored_mask traditionally only meant which events should be ignored,
+ * while ->ignore_mask also includes flags regarding the type of objects on
+ * which events should be ignored.
+ */
+static inline __u32 fsnotify_ignore_mask(struct fsnotify_mark *mark)
+{
+	__u32 ignore_mask = mark->ignore_mask;
+
+	/* The event flags in ignore mask take effect */
+	if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORE_FLAGS)
+		return ignore_mask;
+
+	/*
+	 * Legacy behavior:
+	 * - Always ignore events on dir
+	 * - Ignore events on child if parent is watching children
+	 */
+	ignore_mask |= FS_ISDIR;
+	ignore_mask &= ~FS_EVENT_ON_CHILD;
+	ignore_mask |= mark->mask & FS_EVENT_ON_CHILD;
+
+	return ignore_mask;
+}
+
+/* Legacy ignored_mask - only event types to ignore */
+static inline __u32 fsnotify_ignored_events(struct fsnotify_mark *mark)
+{
+	return mark->ignore_mask & ALL_FSNOTIFY_EVENTS;
+}
+
+/*
+ * Check if mask (or ignore mask) should be applied depending if victim is a
+ * directory and whether it is reported to a watching parent.
+ */
+static inline bool fsnotify_mask_applicable(__u32 mask, bool is_dir,
+					    int iter_type)
+{
+	/* Should mask be applied to a directory? */
+	if (is_dir && !(mask & FS_ISDIR))
+		return false;
+
+	/* Should mask be applied to a child? */
+	if (iter_type == FSNOTIFY_ITER_TYPE_PARENT &&
+	    !(mask & FS_EVENT_ON_CHILD))
+		return false;
+
+	return true;
+}
+
+/*
+ * Effective ignore mask taking into account if event victim is a
+ * directory and whether it is reported to a watching parent.
+ */
+static inline __u32 fsnotify_effective_ignore_mask(struct fsnotify_mark *mark,
+						   bool is_dir, int iter_type)
+{
+	__u32 ignore_mask = fsnotify_ignored_events(mark);
+
+	if (!ignore_mask)
+		return 0;
+
+	/* For non-dir and non-child, no need to consult the event flags */
+	if (!is_dir && iter_type != FSNOTIFY_ITER_TYPE_PARENT)
+		return ignore_mask;
+
+	ignore_mask = fsnotify_ignore_mask(mark);
+	if (!fsnotify_mask_applicable(ignore_mask, is_dir, iter_type))
+		return 0;
+
+	return ignore_mask & ALL_FSNOTIFY_EVENTS;
+}
+
+/* Get mask for calculating object interest taking ignore mask into account */
 static inline __u32 fsnotify_calc_mask(struct fsnotify_mark *mark)
 {
 	__u32 mask = mark->mask;
 
-	if (!mark->ignored_mask)
+	if (!fsnotify_ignored_events(mark))
 		return mask;
 
-	/* Interest in FS_MODIFY may be needed for clearing ignored mask */
+	/* Interest in FS_MODIFY may be needed for clearing ignore mask */
 	if (!(mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
 		mask |= FS_MODIFY;
 
@@ -671,7 +748,7 @@ static inline __u32 fsnotify_calc_mask(struct fsnotify_mark *mark)
 	 * If mark is interested in ignoring events on children, the object must
 	 * show interest in those events for fsnotify_parent() to notice it.
 	 */
-	return mask | (mark->ignored_mask & ALL_FSNOTIFY_EVENTS);
+	return mask | mark->ignore_mask;
 }
 
 /* Get mask of events for a list of marks */
-- 
2.25.1

