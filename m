Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE08043FB8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhJ2LnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 07:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbhJ2LnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:43:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25864C061766
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso6278320wmc.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eDdVEl7RYwzPP059buZk/UmFoXcITSgcfDQMfWHjV34=;
        b=VEkRPbmbY8pWjFjg+SM/PMX952Exy9zoRkcaNw/CmeHWrinHNFUkDjtl6yFRkB898V
         6D2locRES6EQ67BGrTSEzVJ5PtEc9ZfcsdoFM3Soy4RsV6tm3RfktCJaPupdM20OPaRQ
         bwCWyb19Wv2ZbSS5jGeZAZitNA5ukha93c9o48gTWwfrMyeRhIP2fyQ2awPL9QY0qiHU
         1XgEW9DRY9G3n3P145LTehRFqlzZN6IyOcigGL64R3VaroyA/LoPst9IV6Q5Nwm4QEG3
         /ENaIzS0bUc3XynRhyIXZTv22Ay4jwu2aEzKSuEAiTXaGegA1Ou33rehCGt9uT2mEfan
         lxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDdVEl7RYwzPP059buZk/UmFoXcITSgcfDQMfWHjV34=;
        b=Vs5bTCeBpegjG1dt1SLIuBemQtbWLBGKRY6rb0lKy1H96aUMZojhgzGvWkdqA5U3yJ
         vezDePZnTYd+0MyfG7IB6IUFKlCMKkmT8S1wb4AjuYMMadOWNP/geqNg0EpdJC2ux7h1
         W1QiOpX5vSYnxbA2U3kPI31pXECGCR44SeXTKnbCxwhcn/maLctrb3p/665sLEh1WmVA
         9wXeH1OnDpJz6dTGsFaGEkzfo8HwtqVrNyUc64LPaO4lM9kKH+iokxUHuEFAT0RI8R7t
         FUpSy6WiGdaGJPwOkewRxie9gzA7eQATBz7TiK0pBBxEL/yeAFnztEKYg0N3Crq43eBP
         aHUw==
X-Gm-Message-State: AOAM531v9XF3GLntK4tcuOyg0Sx46amT62MB/o4lbDjzXpdsrg4WB2dT
        GJTDpLF+WH9IUa15uL6+EWRgWk+fCJs=
X-Google-Smtp-Source: ABdhPJxDlnkTTUBBIPnoHkRxZwD11CGBGXy4+u+t4DeYbcfupZNJp+98/+u0FQq6002CyC2cchOwLA==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr6808166wmk.92.1635507633662;
        Fri, 29 Oct 2021 04:40:33 -0700 (PDT)
Received: from localhost.localdomain ([82.114.46.186])
        by smtp.gmail.com with ESMTPSA id t3sm8178643wma.38.2021.10.29.04.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 04:40:33 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/7] fanotify: introduce group flag FAN_REPORT_TARGET_FID
Date:   Fri, 29 Oct 2021 14:40:23 +0300
Message-Id: <20211029114028.569755-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211029114028.569755-1-amir73il@gmail.com>
References: <20211029114028.569755-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_REPORT_FID is ambiguous in that it reports the fid of the child for
some events and the fid of the parent for create/delete/move events.

The new FAN_REPORT_TARGET_FID flag is an implicit request to report
the fid of the target object of the operation (a.k.a the child inode)
also in create/delete/move events in addition to the fid of the parent
and the name of the child.

To reduce the test matrix for uninteresting use cases, the new
FAN_REPORT_TARGET_FID flag requires both FAN_REPORT_NAME and
FAN_REPORT_FID.  The convenience macro FAN_REPORT_ALL_FIDS combines
FAN_REPORT_TARGET_FID with all the required flags.

The new flag is not yet enabled in this change.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 48 ++++++++++++++++++++++--------
 fs/notify/fanotify/fanotify_user.c |  9 ++++++
 include/uapi/linux/fanotify.h      |  4 +++
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index b6091775aa6e..9b1641ecfe97 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -458,17 +458,41 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 }
 
 /*
- * The inode to use as identifier when reporting fid depends on the event.
- * Report the modified directory inode on dirent modification events.
- * Report the "victim" inode otherwise.
+ * FAN_REPORT_FID is ambiguous in that it reports the fid of the child for
+ * some events and the fid of the parent for create/delete/move events.
+ *
+ * With the FAN_REPORT_TARGET_FID flag, the fid of the child is reported
+ * also in create/delete/move events in addition to the fid of the parent
+ * and the name of the child.
+ */
+static inline bool fanotify_report_child_fid(unsigned int fid_mode, u32 mask)
+{
+	if (mask & ALL_FSNOTIFY_DIRENT_EVENTS)
+		return (fid_mode & FAN_REPORT_TARGET_FID);
+
+	return (fid_mode & FAN_REPORT_FID) && !(mask & FAN_ONDIR);
+}
+
+/*
+ * The inode to use as identifier when reporting fid depends on the event
+ * and the group flags.
+ *
+ * With the group flag FAN_REPORT_TARGET_FID, always report the child fid.
+ *
+ * Without the group flag FAN_REPORT_TARGET_FID, report the modified directory
+ * fid on dirent events and the child fid otherwise.
+ *
  * For example:
- * FS_ATTRIB reports the child inode even if reported on a watched parent.
- * FS_CREATE reports the modified dir inode and not the created inode.
+ * FS_ATTRIB reports the child fid even if reported on a watched parent.
+ * FS_CREATE reports the modified dir fid without FAN_REPORT_TARGET_FID.
+ *       and reports the created child fid with FAN_REPORT_TARGET_FID.
  */
 static struct inode *fanotify_fid_inode(u32 event_mask, const void *data,
-					int data_type, struct inode *dir)
+					int data_type, struct inode *dir,
+					unsigned int fid_mode)
 {
-	if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
+	if ((event_mask & ALL_FSNOTIFY_DIRENT_EVENTS) &&
+	    !(fid_mode & FAN_REPORT_TARGET_FID))
 		return dir;
 
 	return fsnotify_data_inode(data, data_type);
@@ -647,10 +671,11 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 {
 	struct fanotify_event *event = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
-	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir);
+	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
+	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir,
+					      fid_mode);
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
-	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct mem_cgroup *old_memcg;
 	struct inode *child = NULL;
 	bool name_event = false;
@@ -660,11 +685,10 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 
 	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
 		/*
-		 * With both flags FAN_REPORT_DIR_FID and FAN_REPORT_FID, we
-		 * report the child fid for events reported on a non-dir child
+		 * For certain events and group flags, report the child fid
 		 * in addition to reporting the parent fid and maybe child name.
 		 */
-		if ((fid_mode & FAN_REPORT_FID) && id != dirid && !ondir)
+		if (fanotify_report_child_fid(fid_mode, mask) && id != dirid)
 			child = id;
 
 		id = dirid;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 559bc1e9926d..6ec26b124041 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1275,6 +1275,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if ((fid_mode & FAN_REPORT_NAME) && !(fid_mode & FAN_REPORT_DIR_FID))
 		return -EINVAL;
 
+	/*
+	 * FAN_REPORT_TARGET_FID requires FAN_REPORT_NAME and FAN_REPORT_FID
+	 * and is used as an indication to report both dir and child fid on all
+	 * dirent events.
+	 */
+	if ((fid_mode & FAN_REPORT_TARGET_FID) &&
+	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
+		return -EINVAL;
+
 	f_flags = O_RDWR | FMODE_NONOTIFY;
 	if (flags & FAN_CLOEXEC)
 		f_flags |= O_CLOEXEC;
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index bd1932c2074d..f9202ce31b0d 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -57,9 +57,13 @@
 #define FAN_REPORT_FID		0x00000200	/* Report unique file id */
 #define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
 #define FAN_REPORT_NAME		0x00000800	/* Report events with name */
+#define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
+/* Convenience macro - FAN_REPORT_TARGET_FID requires all other FID flags */
+#define FAN_REPORT_ALL_FIDS	(FAN_REPORT_DFID_NAME | FAN_REPORT_FID | \
+				 FAN_REPORT_TARGET_FID)
 
 /* Deprecated - do not use this in programs and do not add new flags here! */
 #define FAN_ALL_INIT_FLAGS	(FAN_CLOEXEC | FAN_NONBLOCK | \
-- 
2.33.1

