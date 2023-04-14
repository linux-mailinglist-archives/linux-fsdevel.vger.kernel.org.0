Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB46E2A10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 20:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDNS3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 14:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDNS3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:29:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817CF10F1;
        Fri, 14 Apr 2023 11:29:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id eo6-20020a05600c82c600b003ee5157346cso12423007wmb.1;
        Fri, 14 Apr 2023 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681496958; x=1684088958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9s+rpraNSI3eXbX0Rzmr5a6x0B/L2n/FAZA7DdeBdA=;
        b=VAXkvBpPSsZI16pPEPMnkfCzzgbUZCna04FjlrIUllpvZDV/YuW5ku3N/ArgjYTI4X
         S75Xm4Gt9fgsK4wD2Ru94NhILae+NUYBfHXqQyE6Tbj9wXlCZncP+o8b7u2YTmOH66A3
         fZx6m06oyHbm5Lbk6M+3zL2AFstEXvq5xWQ8oyAfUt1GvMhFosW5htzrit9kXRQaSvuR
         L/AktZpCFty7Fz9Bycm5QIORFmUkDeyE8ETKI//b7CrMV5Cd2FSzV98sBzCV61sElcox
         Fr44++cwXxjkYAuJlLzPANnrI2JbJUWXonGDp1A//gyVkOs7vOMTs5IQL4JA8g9mPeFT
         b9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681496958; x=1684088958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9s+rpraNSI3eXbX0Rzmr5a6x0B/L2n/FAZA7DdeBdA=;
        b=Zu5PEIz1nGI4G7ww9Wcp/WCkW4Z1FzXpXl7YWcQVEPskyad5BrTqj8fKv+ZvrzQQMd
         kVm8s79XJJewnsBDGsQkekRn3Rshi8eKEtk6TKlatXDSyyLeboXuW7+wlp21ZRemgYSU
         fJ/WwvhIORgT1+Bepb4zr5BF3lcuJxRSfwQZ31ZtYYefHSB0iZu4Rd+S+H1zGl32hI3+
         u93ejx1ZYkak1i9mRA23JWwY03crndmozqoimum6BVup/mK/sJ/oa4HCDOFQKr+XJCtr
         6yYlXmTwjOoPDG1KZcoW7sQpzjGm0kgtS7S7NrWcmCiautohchaKxy5yDOS2Q142CPAw
         /7zw==
X-Gm-Message-State: AAQBX9dEUHtVNrzZSUrwDvHkYtoQBkN1XlUowY58qfi6yu5feY9ckvmS
        tmnLtbmGJp+xUDe6KoCfRt0=
X-Google-Smtp-Source: AKy350ZIJBAv2slgIIliOvLQNJ/qPKakhSXho4Q48KiwMZdiDgfgVdK4gqn9KYJJWhZVMpZ5culpgg==
X-Received: by 2002:a05:600c:2183:b0:3f0:3ce2:1e3d with SMTP id e3-20020a05600c218300b003f03ce21e3dmr4985296wme.12.1681496957790;
        Fri, 14 Apr 2023 11:29:17 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c160900b003f0b1c4f229sm1780487wmn.28.2023.04.14.11.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:29:17 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [RFC][PATCH 1/2] fanotify: add support for FAN_UNMOUNT event
Date:   Fri, 14 Apr 2023 21:29:02 +0300
Message-Id: <20230414182903.1852019-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414182903.1852019-1-amir73il@gmail.com>
References: <20230414182903.1852019-1-amir73il@gmail.com>
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

inotify generates unsolicited IN_UNMOUNT events for every inode
mark before the filesystem containing the inode is shutdown.

Unlike IN_UNMOUNT, FAN_UNMOUNT is an opt-in event that can only be
set on a mount mark and is generated when the mount is unmounted.

FAN_UNMOUNT requires FAN_REPORT_FID and reports an fid info record
with fsid of the filesystem and an empty file handle.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 10 +++++++---
 fs/notify/fanotify/fanotify.h      |  6 ++++--
 fs/notify/fanotify/fanotify_user.c | 10 ++++++++++
 include/linux/fanotify.h           |  3 ++-
 include/linux/fsnotify.h           | 16 ++++++++++++++++
 include/uapi/linux/fanotify.h      |  1 +
 6 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 90d9210dc0d2..384d2b2e55e7 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -713,7 +713,7 @@ static struct fanotify_event *fanotify_alloc_error_event(
 	inode = report->inode;
 	fh_len = fanotify_encode_fh_len(inode);
 
-	/* Bad fh_len. Fallback to using an invalid fh. Should never happen. */
+	/* Record empty fh for errors not associated with specific inode */
 	if (!fh_len && inode)
 		inode = NULL;
 
@@ -745,7 +745,10 @@ static struct fanotify_event *fanotify_alloc_event(
 	bool ondir = mask & FAN_ONDIR;
 	struct pid *pid;
 
-	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
+	if (mask & FAN_UNMOUNT && !WARN_ON_ONCE(!path || !fid_mode)) {
+		/* Record fid event with fsid and empty fh */
+		id = NULL;
+	} else if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
 		/*
 		 * For certain events and group flags, report the child fid
 		 * in addition to reporting the parent fid and maybe child name.
@@ -951,10 +954,11 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_ONDIR != FS_ISDIR);
 	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
+	BUILD_BUG_ON(FAN_UNMOUNT != FS_UNMOUNT);
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 7f0bf00a90f0..f98dcf5b7a19 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -382,10 +382,12 @@ static inline int fanotify_event_dir2_fh_len(struct fanotify_event *event)
 	return info ? fanotify_info_dir2_fh_len(info) : 0;
 }
 
+/* For error and unmount events, fsid with empty fh are reported. */
+#define FANOTIFY_EMPTY_FH_EVENTS (FAN_FS_ERROR | FAN_UNMOUNT)
+
 static inline bool fanotify_event_has_object_fh(struct fanotify_event *event)
 {
-	/* For error events, even zeroed fh are reported. */
-	if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
+	if (event->mask & FANOTIFY_EMPTY_FH_EVENTS)
 		return true;
 	return fanotify_event_object_fh_len(event) > 0;
 }
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 554b335b1733..0b3de6218c56 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1766,6 +1766,16 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
 		goto fput_and_out;
 
+	/*
+	 * inotify sends unsoliciled IN_UNMOUNT per marked inode on sb shutdown.
+	 * FAN_UNMOUNT event is about unmount of a mount, not about sb shutdown,
+	 * so allow setting it only in mount mark mask.
+	 * FAN_UNMOUNT requires FAN_REPORT_FID to report fsid with empty fh.
+	 */
+	if (mask & FAN_UNMOUNT &&
+	    (!(fid_mode & FAN_REPORT_FID) || mark_type != FAN_MARK_MOUNT))
+		goto fput_and_out;
+
 	/*
 	 * FAN_RENAME uses special info type records to report the old and
 	 * new parent+name.  Reporting only old and new parent id is less
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 4c6f40a701c2..a64c26d9626f 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -80,7 +80,8 @@
  * FSNOTIFY_EVENT_INODE.
  */
 #define FANOTIFY_PATH_EVENTS	(FAN_ACCESS | FAN_MODIFY | \
-				 FAN_CLOSE | FAN_OPEN | FAN_OPEN_EXEC)
+				 FAN_CLOSE | FAN_OPEN | FAN_OPEN_EXEC | \
+				 FAN_UNMOUNT)
 
 /*
  * Directory entry modification events - reported only to directory
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index bb8467cd11ae..3898bf858407 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -176,11 +176,27 @@ static inline void fsnotify_inode_delete(struct inode *inode)
 	__fsnotify_inode_delete(inode);
 }
 
+/*
+ * fsnotify_unmount - mount was unmounted.
+ */
+static inline int fsnotify_unmount(struct vfsmount *mnt)
+{
+	struct path path = { .mnt = mnt, .dentry = mnt->mnt_root };
+
+	if (atomic_long_read(&mnt->mnt_sb->s_fsnotify_connectors) == 0)
+		return 0;
+
+	return fsnotify(FS_UNMOUNT, &path, FSNOTIFY_EVENT_PATH, NULL, NULL,
+			d_inode(path.dentry), 0);
+}
+
 /*
  * fsnotify_vfsmount_delete - a vfsmount is being destroyed, clean up is needed
  */
 static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
 {
+	/* Send FS_UNMOUNT to groups and then clear mount marks */
+	fsnotify_unmount(mnt);
 	__fsnotify_vfsmount_delete(mnt);
 }
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 014e9682bd76..70f2d43e8ba4 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -19,6 +19,7 @@
 #define FAN_MOVE_SELF		0x00000800	/* Self was moved */
 #define FAN_OPEN_EXEC		0x00001000	/* File was opened for exec */
 
+#define FAN_UNMOUNT		0x00002000	/* Filesystem unmounted */
 #define FAN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
 #define FAN_FS_ERROR		0x00008000	/* Filesystem error */
 
-- 
2.34.1

