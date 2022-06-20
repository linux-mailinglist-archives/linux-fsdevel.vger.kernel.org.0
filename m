Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A072551EF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243063AbiFTObg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243015AbiFTObZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:31:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFDE4D60A;
        Mon, 20 Jun 2022 06:45:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v14so14771743wra.5;
        Mon, 20 Jun 2022 06:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0L96qnS8PqF2s8hYHejlTR6/XRmPUhX5qzXhMkKFgDA=;
        b=RYKloQtsCihTWS5knWkkYAtDW7XLBnxir7RxfXqYooBUkLBMIj69JvAQwXC3l2SqPu
         t7eOpLFIv7ZYk8xvyD9SJx8xFV9MIUSwGAPE61jjES+n6tjshhILD4e7H9qYuOENkZ2g
         3ZzR45UXgyyF0NWK0XG2apuiKC9H+B+jhCBluFI7mCygVYlrYPbuBZ6I0KiWqlwn15oE
         RrMRAURl+XejrUoJ9LZDEJ/PJR6qJ7Ao3hg5D4hJmRQdgGL1l8MpE5D+3KAvOw1YswmP
         0aETDEojD2JozdXTz09dR+LkML4kxBcaysV3O2TzXPJ9VtLcqZ82tfrZR/Edc6Z9FNpu
         La3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0L96qnS8PqF2s8hYHejlTR6/XRmPUhX5qzXhMkKFgDA=;
        b=wDQhpcjdjbzm9Rhc86ZtlZXj0RAXtZxUP8QEMbmLZNUX/uoCEbcX4oxQ6x/j7fS4w5
         LNnYFtw39GdpgU44yrhLntGxFkaF95ZOV/BONKMEdh/xZgpKsTmLfcCbvIjllo7l9jqc
         E8Bn6aV/l6IFgTiKmhkRDWTc/CiP+syAIM2ETSoQDTjpYfFh5dsrCrOqoUZAFgqz/ZEa
         q7jHFMQ2I0EuFHRcnCYcDuPyq+fPHefBAgP/kvQTt5wKV7I+nu5z8jTv8kCDLa0IcdOX
         gJiBMPk6ZO95Vh0hD78ePUYLz8i3oVIA3MT8NeRldjh2ArwSVbASwesSwnirKGCNd5ip
         Q16A==
X-Gm-Message-State: AJIora9tJnWTAO1UOfX7S5aDaHQI8nbp7O+erdFWc47CrfNGRRiCEc1Q
        4Todfdlp0l3HaAncl0AcNQ9OB5G9WUIWjQ==
X-Google-Smtp-Source: AGRyM1tG5W/enqyCUoAxcIFkh9mNFJfKUfg+zKPM+quz9g3kWdxg4p5ZKBHKAnUfHiEFy8zxDwHaVA==
X-Received: by 2002:adf:eecd:0:b0:21b:7f2d:47bd with SMTP id a13-20020adfeecd000000b0021b7f2d47bdmr15913759wrp.26.1655732757077;
        Mon, 20 Jun 2022 06:45:57 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id y16-20020a5d6150000000b0021b932de5d6sm1634355wrt.39.2022.06.20.06.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 06:45:56 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 1/2] fanotify: prepare for setting event flags in ignore mask
Date:   Mon, 20 Jun 2022 16:45:50 +0300
Message-Id: <20220620134551.2066847-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620134551.2066847-1-amir73il@gmail.com>
References: <20220620134551.2066847-1-amir73il@gmail.com>
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
member to ignore_mask and use accessor to get only ignored events or
events and flags.

This change in terminology finally aligns with the "ignore mask"
language in man pages and in most of the comments.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 17 +++++++----
 fs/notify/fanotify/fanotify_user.c | 21 ++++++++------
 fs/notify/fdinfo.c                 |  6 ++--
 fs/notify/fsnotify.c               | 21 ++++++++------
 include/linux/fsnotify_backend.h   | 46 ++++++++++++++++++++++++++----
 5 files changed, 78 insertions(+), 33 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 4f897e109547..a641e597b11c 100644
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
@@ -315,19 +316,23 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
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
+		 * Apply ignore mask depending on whether FAN_ONDIR flag in
+		 * ignore mask should be checked to ignore events on dirs.
+		 */
+		if (!ondir || fsnotify_ignore_mask(mark) & FAN_ONDIR)
+			marks_ignore_mask |= mark->ignore_mask;
 
 		/*
 		 * If the event is on dir and this mark doesn't care about
 		 * events on dir, don't send it!
 		 */
-		if (event_mask & FS_ISDIR && !(mark->mask & FS_ISDIR))
+		if (ondir && !(mark->mask & FAN_ONDIR))
 			continue;
 
 		marks_mask |= mark->mask;
@@ -336,7 +341,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		*match_mask |= 1U << type;
 	}
 
-	test_mask = event_mask & marks_mask & ~marks_ignored_mask;
+	test_mask = event_mask & marks_mask & ~marks_ignore_mask;
 
 	/*
 	 * For dirent modification events (create/delete/move) that do not carry
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index c2255b440df9..b718df84bd56 100644
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
@@ -1540,7 +1540,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	__kernel_fsid_t __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
-	bool ignored = flags & FAN_MARK_IGNORED_MASK;
+	bool ignore = flags & FAN_MARK_IGNORED_MASK;
 	unsigned int obj_type, fid_mode;
 	u32 umask = 0;
 	int ret;
@@ -1589,8 +1589,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
@@ -1717,7 +1720,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
index 0b3e74935cb4..b5b61f94cec1 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -324,7 +324,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 	struct fsnotify_group *group = NULL;
 	__u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
 	__u32 marks_mask = 0;
-	__u32 marks_ignored_mask = 0;
+	__u32 marks_ignore_mask = 0;
 	struct fsnotify_mark *mark;
 	int type;
 
@@ -336,7 +336,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 		fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
 			if (!(mark->flags &
 			      FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
-				mark->ignored_mask = 0;
+				mark->ignore_mask = 0;
 		}
 	}
 
@@ -344,14 +344,16 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
 		group = mark->group;
 		marks_mask |= mark->mask;
-		marks_ignored_mask |= mark->ignored_mask;
+		if (!(mask & FS_ISDIR) ||
+		    (fsnotify_ignore_mask(mark) & FS_ISDIR))
+			marks_ignore_mask |= mark->ignore_mask;
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
index 9560734759fa..894e1b1c18bd 100644
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
 
@@ -655,15 +656,48 @@ extern void fsnotify_remove_queued_event(struct fsnotify_group *group,
 
 /* functions used to manipulate the marks attached to inodes */
 
-/* Get mask for calculating object interest taking ignored mask into account */
+/*
+ * Canonical "ignore mask" including event flags.
+ * Note the subtle semantic difference from the legacy term "ignored_mask" -
+ * ignored_mask traditionally only meant which events should be ignored,
+ * while ignore_mask also includes flags regarding the type of objects on
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
+	return ignore_mask;
+}
+
+/* Legacy ignored_mask - only event types to ignore */
+static inline __u32 fsnotify_ignored_events(struct fsnotify_mark *mark)
+{
+	return mark->ignore_mask & ALL_FSNOTIFY_EVENTS;
+}
+
+/* Get mask for calculating object interest taking ignore mask into account */
 static inline __u32 fsnotify_calc_mask(struct fsnotify_mark *mark)
 {
 	__u32 mask = mark->mask;
+	__u32 ignored_events = fsnotify_ignored_events(mark);
 
-	if (!mark->ignored_mask)
+	if (!ignored_events)
 		return mask;
 
-	/* Interest in FS_MODIFY may be needed for clearing ignored mask */
+	/* Interest in FS_MODIFY may be needed for clearing ignore mask */
 	if (!(mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
 		mask |= FS_MODIFY;
 
@@ -671,7 +705,7 @@ static inline __u32 fsnotify_calc_mask(struct fsnotify_mark *mark)
 	 * If mark is interested in ignoring events on children, the object must
 	 * show interest in those events for fsnotify_parent() to notice it.
 	 */
-	return mask | (mark->ignored_mask & ALL_FSNOTIFY_EVENTS);
+	return mask | mark->ignore_mask;
 }
 
 /* Get mask of events for a list of marks */
-- 
2.25.1

