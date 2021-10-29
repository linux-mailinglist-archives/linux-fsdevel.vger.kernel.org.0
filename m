Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7A143FB90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 13:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhJ2LnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 07:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhJ2LnH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:43:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3069C061570
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso4154262wmd.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nh4M5doDETZWPsDs2yDOOfeG8GPsy197cicy5UH9BXs=;
        b=nivWkd7DctgIJf6R0o8GnDqZgqlhvnRloUtDVPmnOLjpFIuJoncm7swcnCjwLzQdpH
         Pavny5ZT+k8Vdo/T+ZA1jzV8i9YpiiVtwi83cPRsIBSPge4BNXWI1wjPETSQ5jw/1W2w
         uWiD66bmmvCFKE+DDUs+sPWTctyjGIwAoPapnJaqIMZ5fHYnyBPx/ZUiyilj0tFGe4CZ
         9byYS0gHa4nGFxmU0qya6A51938LYDngjff8pnpA9Lt8a6p3H2ds4xMpbfE5xiDOVGnN
         aBE2pK29fyqWyXQMhk42OZUZUF7ra1Po0LuC6OMB1UZo1M4Wkw5giqwajOenJCTqCeuD
         8GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nh4M5doDETZWPsDs2yDOOfeG8GPsy197cicy5UH9BXs=;
        b=sGHc/uJeGOPfbeMProCG1NR6VIlAgegALXYkdViMkut61LIg7L8HJRSOsnol1rUDOz
         +xs4axFxdgDoVwnU18tWZnJD+98Dh7IoRGx9xPqRloMXU8sZpHBT85hsxs9igt+8hVqd
         ZdxcTB2V4Rqs7lZZeVstnbIUGuYE3GoDNInmH/bQphLhrC7ZkXbawTMoAuPzmC4nGVnX
         mTi0R+Hjz7umfnOskBqOS5vxbQJa1KiJX0EiEtC9tdvh5bodJjO8NhNgo4rjT2vBZxWq
         kHiPzTtgfXE/M2o6cWBANeSNdrCg6H5wx8+yEurKf0MHelDpRcMv3h8NQRU7+91YMu31
         8JSw==
X-Gm-Message-State: AOAM533nQP0FKUiOaXIS4oybgpExACUwq7mKD3hUUzWrpGAxj8EVhnY7
        bHCyIiNj3ALqykg0fFML3ns=
X-Google-Smtp-Source: ABdhPJxZTvc3SV1/fPC5oiKnNa07Oz2SjaojRSGcsH4GaK/8d7rTBCiL7vMp02LXg0EslPZ6sK4VeA==
X-Received: by 2002:a05:600c:5117:: with SMTP id o23mr10789101wms.81.1635507637315;
        Fri, 29 Oct 2021 04:40:37 -0700 (PDT)
Received: from localhost.localdomain ([82.114.46.186])
        by smtp.gmail.com with ESMTPSA id t3sm8178643wma.38.2021.10.29.04.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 04:40:36 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/7] fanotify: record new parent and name in MOVED_FROM event
Date:   Fri, 29 Oct 2021 14:40:26 +0300
Message-Id: <20211029114028.569755-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211029114028.569755-1-amir73il@gmail.com>
References: <20211029114028.569755-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the special case of MOVED_FROM event, if we are recording the child
fid due to FAN_REPORT_TARGET_FID init flag, we also record the new
parent and name.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 40 ++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 795bedcb6f9b..d1adcb3437c5 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -592,21 +592,30 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
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
 	unsigned int dir_fh_len = fanotify_encode_fh_len(id);
+	unsigned int dir2_fh_len = fanotify_encode_fh_len(dir2);
 	unsigned int child_fh_len = fanotify_encode_fh_len(child);
 	unsigned int size;
 
 	size = sizeof(*fne) + FANOTIFY_FH_HDR_LEN + dir_fh_len;
+	if (dir2_fh_len)
+		size += FANOTIFY_FH_HDR_LEN + dir2_fh_len;
 	if (child_fh_len)
 		size += FANOTIFY_FH_HDR_LEN + child_fh_len;
-	if (name)
+	if (name) {
 		size += name->len + 1;
+		if (name2)
+			size += name2->len + 1;
+	}
 	fne = kmalloc(size, gfp);
 	if (!fne)
 		return NULL;
@@ -618,6 +627,11 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	fanotify_info_init(info);
 	dfh = fanotify_info_dir_fh(info);
 	info->dir_fh_totlen = fanotify_encode_fh(dfh, id, dir_fh_len, hash, 0);
+	if (dir2_fh_len) {
+		dfh = fanotify_info_dir2_fh(info);
+		info->dir2_fh_totlen = fanotify_encode_fh(dfh, dir2,
+							  dir2_fh_len, hash, 0);
+	}
 	if (child_fh_len) {
 		ffh = fanotify_info_file_fh(info);
 		info->file_fh_totlen = fanotify_encode_fh(ffh, child,
@@ -628,12 +642,26 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 
 		fanotify_info_copy_name(info, name);
 		*hash ^= full_name_hash((void *)salt, name->name, name->len);
+
+		/* name2 can only be stored after valid name1 */
+		if (name2) {
+			salt = name2->len;
+			fanotify_info_copy_name2(info, name2);
+			*hash ^= full_name_hash((void *)salt, name2->name,
+						name2->len);
+		}
 	}
 
 	pr_debug("%s: ino=%lu size=%u dir_fh_len=%u child_fh_len=%u name_len=%u name='%.*s'\n",
 		 __func__, id->i_ino, size, dir_fh_len, child_fh_len,
 		 info->name_len, info->name_len, fanotify_info_name(info));
 
+	if (dir2_fh_len) {
+		pr_debug("%s: dir2_fh_len=%u name2_len=%u name2='%.*s'\n",
+			 __func__, dir2_fh_len, info->name2_len,
+			 info->name2_len, fanotify_info_name2(info));
+	}
+
 	return &fne->fae;
 }
 
@@ -689,6 +717,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct mem_cgroup *old_memcg;
+	struct dentry *moved = NULL;
 	struct inode *child = NULL;
 	bool name_event = false;
 	unsigned int hash = 0;
@@ -699,9 +728,14 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		/*
 		 * For certain events and group flags, report the child fid
 		 * in addition to reporting the parent fid and maybe child name.
+		 * In the special case of MOVED_FROM event, if we are reporting
+		 * the child fid we are also reporting the new parent and name.
 		 */
-		if (fanotify_report_child_fid(fid_mode, mask) && id != dirid)
+		if (fanotify_report_child_fid(fid_mode, mask) && id != dirid) {
 			child = id;
+			if (mask & FAN_MOVED_FROM)
+				moved = fsnotify_data_dentry(data, data_type);
+		}
 
 		id = dirid;
 
@@ -747,7 +781,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 						   data_type, &hash);
 	} else if (name_event && (file_name || child)) {
 		event = fanotify_alloc_name_event(id, fsid, file_name, child,
-						  &hash, gfp);
+						  moved, &hash, gfp);
 	} else if (fid_mode) {
 		event = fanotify_alloc_fid_event(id, fsid, &hash, gfp);
 	} else {
-- 
2.33.1

