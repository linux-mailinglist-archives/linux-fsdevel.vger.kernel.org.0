Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F514624AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhK2WYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhK2WV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:21:59 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C871CC06FD4C
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so13242433wmc.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4MuUTrcp9uEtj/1loNI85dOLH7rxn1nQJenDRjxzKOM=;
        b=BnTQQYl/jaG+r99t8IRyc83C8X8Db5CkLpN2JmwYq4W26jSewFQxEhNIeyyaO67AJM
         Gntu3f8q54XoducTnrPO/aYSaE0aS9XunD9woa0CvUy4FSv+0l7m1oDxaP8Dt9Vfh3WP
         3cZe0EOP7YXjzN237Kx3Kvw1eJjZHwLV9AbHYJUztz2Ig4XX1tLZpvgxegGdQfaXKuKi
         1+tnVX9zylUlM9xoEUn9xMQLNSQXmAAhzReW5VdtO8HPrlQuO3AAu8kkkuTreQaopxdD
         ricGxpQhwtxXSBSUJTmzCaNBmLcYtM2UiGtuNxNwgVbkHlB/SQxqOsjGDcUkDa5sq02o
         tW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4MuUTrcp9uEtj/1loNI85dOLH7rxn1nQJenDRjxzKOM=;
        b=wydR7pj8XxPeg8M7/MuUhi8ghe4l+AxnMomJnuVrU8n3+/BLyvSIRWEN49aYhCCKd+
         oroTc452L+PRCXspVMZdpb+yhOKNWn8pALI1npHkEoMOC0ZHI3yZ5QOPYPEwkMwmwWoY
         81xZ7UCUnZDAb6oDyeOKbzm/Lnpji05Tnj1wjk9tzWEufr/19BPWLCv+pBPORVDQ49aa
         yp4Z0QbWtBLk8UR+Iz+INvPtkSMP/FxNWXYGrynatyEMv7PsRom2S9jH1t5Q3kZWEBAS
         VDvEIQnrctFBuIaRXbPLa0YyAbQj92jK5vUYYRwBdlkwEBy0/ybUVFIbmNOJtAlWaSme
         RV5Q==
X-Gm-Message-State: AOAM533T2Zs5x97ZHhUh5RI4yOhVmKprQFT2+WfIG3dg6wbggkBC39Ah
        l+ZA895HRadPJoVvRWw/6qA=
X-Google-Smtp-Source: ABdhPJyyqWysIsW9JimrsBy/RzCXdhbDaUGa9Jag1QVY9KH5vGF4CW/U4E+KKwWjL+yqYy0Z6/nCAQ==
X-Received: by 2002:a1c:9d48:: with SMTP id g69mr249361wme.188.1638216949342;
        Mon, 29 Nov 2021 12:15:49 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id m14sm19791830wrp.28.2021.11.29.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:15:48 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 08/11] fanotify: record old and new parent and name in FAN_RENAME event
Date:   Mon, 29 Nov 2021 22:15:34 +0200
Message-Id: <20211129201537.1932819-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129201537.1932819-1-amir73il@gmail.com>
References: <20211129201537.1932819-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the special case of FAN_RENAME event, we record both the old
and new parent and name.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 42 +++++++++++++++++++++++++++++++----
 include/uapi/linux/fanotify.h |  2 ++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 5f184b2d6ea7..db81eab90544 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -592,21 +592,28 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 							__kernel_fsid_t *fsid,
 							const struct qstr *name,
 							struct inode *child,
+							struct dentry *moved,
 							unsigned int *hash,
 							gfp_t gfp)
 {
 	struct fanotify_name_event *fne;
 	struct fanotify_info *info;
 	struct fanotify_fh *dfh, *ffh;
+	struct inode *dir2 = moved ? d_inode(moved->d_parent) : NULL;
+	const struct qstr *name2 = moved ? &moved->d_name : NULL;
 	unsigned int dir_fh_len = fanotify_encode_fh_len(dir);
+	unsigned int dir2_fh_len = fanotify_encode_fh_len(dir2);
 	unsigned int child_fh_len = fanotify_encode_fh_len(child);
 	unsigned long name_len = name ? name->len : 0;
+	unsigned long name2_len = name2 ? name2->len : 0;
 	unsigned int len, size;
 
 	/* Reserve terminating null byte even for empty name */
-	size = sizeof(*fne) + name_len + 1;
+	size = sizeof(*fne) + name_len + name2_len + 2;
 	if (dir_fh_len)
 		size += FANOTIFY_FH_HDR_LEN + dir_fh_len;
+	if (dir2_fh_len)
+		size += FANOTIFY_FH_HDR_LEN + dir2_fh_len;
 	if (child_fh_len)
 		size += FANOTIFY_FH_HDR_LEN + child_fh_len;
 	fne = kmalloc(size, gfp);
@@ -623,6 +630,11 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 		len = fanotify_encode_fh(dfh, dir, dir_fh_len, hash, 0);
 		fanotify_info_set_dir_fh(info, len);
 	}
+	if (dir2_fh_len) {
+		dfh = fanotify_info_dir2_fh(info);
+		len = fanotify_encode_fh(dfh, dir2, dir2_fh_len, hash, 0);
+		fanotify_info_set_dir2_fh(info, len);
+	}
 	if (child_fh_len) {
 		ffh = fanotify_info_file_fh(info);
 		len = fanotify_encode_fh(ffh, child, child_fh_len, hash, 0);
@@ -632,11 +644,22 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 		fanotify_info_copy_name(info, name);
 		*hash ^= full_name_hash((void *)name_len, name->name, name_len);
 	}
+	if (name2_len) {
+		fanotify_info_copy_name2(info, name2);
+		*hash ^= full_name_hash((void *)name2_len, name2->name,
+					name2_len);
+	}
 
 	pr_debug("%s: size=%u dir_fh_len=%u child_fh_len=%u name_len=%u name='%.*s'\n",
 		 __func__, size, dir_fh_len, child_fh_len,
 		 info->name_len, info->name_len, fanotify_info_name(info));
 
+	if (dir2_fh_len) {
+		pr_debug("%s: dir2_fh_len=%u name2_len=%u name2='%.*s'\n",
+			 __func__, dir2_fh_len, info->name2_len,
+			 info->name2_len, fanotify_info_name2(info));
+	}
+
 	return &fne->fae;
 }
 
@@ -692,6 +715,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct mem_cgroup *old_memcg;
+	struct dentry *moved = NULL;
 	struct inode *child = NULL;
 	bool name_event = false;
 	unsigned int hash = 0;
@@ -727,6 +751,15 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		} else if ((mask & ALL_FSNOTIFY_DIRENT_EVENTS) || !ondir) {
 			name_event = true;
 		}
+
+		/*
+		 * In the special case of FAN_RENAME event, we record both
+		 * old and new parent+name.
+		 * 'dirid' and 'file_name' are the old parent+name and
+		 * 'moved' has the new parent+name.
+		 */
+		if (mask & FAN_RENAME)
+			moved = fsnotify_data_dentry(data, data_type);
 	}
 
 	/*
@@ -748,9 +781,9 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	} else if (fanotify_is_error_event(mask)) {
 		event = fanotify_alloc_error_event(group, fsid, data,
 						   data_type, &hash);
-	} else if (name_event && (file_name || child)) {
-		event = fanotify_alloc_name_event(id, fsid, file_name, child,
-						  &hash, gfp);
+	} else if (name_event && (file_name || moved || child)) {
+		event = fanotify_alloc_name_event(dirid, fsid, file_name, child,
+						  moved, &hash, gfp);
 	} else if (fid_mode) {
 		event = fanotify_alloc_fid_event(id, fsid, &hash, gfp);
 	} else {
@@ -860,6 +893,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
+	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 
 	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 60f73639a896..9d0e2dc5767b 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -28,6 +28,8 @@
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
+#define FAN_RENAME		0x10000000	/* File was renamed */
+
 #define FAN_ONDIR		0x40000000	/* Event occurred against dir */
 
 /* helper events */
-- 
2.33.1

