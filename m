Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33132298CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 14:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbgGVM7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 08:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732295AbgGVM7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:59:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF76C0619DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so1794038wrw.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2wYA7mBMODKNUAV9pBdhQQeD4kLfNGRYjkDwVOQ8Szk=;
        b=rt/gYXBIk9/WuQevRfq2WyEg62A1Zr991uzj1t5kaUXVuF5sRomFPEm7fkxjo0HIn3
         jP2Kgy0BLWtdoZvM3ZA4MbXu8wJuIIyU/8C+Og2dwQhyaITW5HPWkNJI5A3h5TxnvMa8
         FcwNrVHEAn5oOBPX9iLkEmz9MOfZsYDSDe46RUk//7+fBAJgP8Yi/jW6Kh7u0VHndrxL
         g4e9zO49ZDCHcELzRKKObltF9Y1eKFaNVee2DSIETpv+Vu08sxE4Shfca3lpAbBbS6K9
         Ju3ewSiFhcXt2r/fbLik4nSHT+ZzXxqn6e70uYKAYcvYDKOH39FboGBU1c4H8WjsQFio
         F5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2wYA7mBMODKNUAV9pBdhQQeD4kLfNGRYjkDwVOQ8Szk=;
        b=JNiklPGM+Yr407QYdvQWMJV5JUBzDOyE6IkPJpTILPdH6/BnDS5NAJsErsZwwVuqbE
         AA0TbrXRgd1O99GjmFgZbtUGPxGR3dCxOZCBZMuuyp8yIRBlhoh1oEQ7LiKNmDtJY7WA
         jbeYiC2fxfuVEz8ml/ryU69cljkTjZCf/jAQKBOp+7RMVysYnQqOaOQwOMtEZA/A/lfv
         PBHF+Tcz9FJASCj+LCtyYDI8tqepBU3Qgn4ZETH/kFaKhAyMjGPl0VGY0blyrVu81cJr
         +P3+hD6FM+oD2+foWirgW3fAJEqTPyozh3fPmotjQlB7CSsy7FsnUlu2X9V5jh0lsnLC
         K5EQ==
X-Gm-Message-State: AOAM531thzX16/aMBPlRit6yKipLUeu7liWpjcLL5I9d/3nKgKHZkPY4
        SYl92tVO+fDa1DF0Npk0xms=
X-Google-Smtp-Source: ABdhPJxlxVymyMVaRm8XZw23Bx6d8HKu2NrmYngw4IEdVLi9F1CdE7p3MJbyCE1TYACHXtR7lGGTKw==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr31011034wrn.52.1595422748954;
        Wed, 22 Jul 2020 05:59:08 -0700 (PDT)
Received: from localhost.localdomain ([31.210.180.214])
        by smtp.gmail.com with ESMTPSA id s4sm35487744wre.53.2020.07.22.05.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:59:08 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/9] fsnotify: simplify dir argument to handle_event()
Date:   Wed, 22 Jul 2020 15:58:45 +0300
Message-Id: <20200722125849.17418-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722125849.17418-1-amir73il@gmail.com>
References: <20200722125849.17418-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The meaning of dir argument could be simplified a lot to just the base
of file_name it we let the only backends that care about it (fanotify and
dnotify) cope with the case of NULL file_name themselves, which is easy.

This will make dir argument meaning generic enough so we can use the
same argument for fsnotify() without causing confusion.

Fixes: e2c9d9039c3f ("fsnotify: pass dir argument to handle_event() callback")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/dnotify/dnotify.c      | 2 +-
 fs/notify/fanotify/fanotify.c    | 7 ++++---
 fs/notify/fsnotify.c             | 2 +-
 include/linux/fsnotify_backend.h | 4 +---
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 305e5559560a..ca78d3f78da8 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -112,7 +112,7 @@ static int dnotify_handle_event(struct fsnotify_group *group, u32 mask,
 	struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
 
 	/* not a dir, dnotify doesn't care */
-	if (!dir)
+	if (!dir && !(mask & FS_ISDIR))
 		return 0;
 
 	if (WARN_ON(fsnotify_iter_vfsmount_mark(iter_info)))
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 36ea0cd6387e..03e3dce2a97c 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -245,7 +245,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 			return 0;
 	} else if (!(fid_mode & FAN_REPORT_FID)) {
 		/* Do we have a directory inode to report? */
-		if (!dir)
+		if (!dir && !(event_mask & FS_ISDIR))
 			return 0;
 	}
 
@@ -525,12 +525,13 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct fanotify_event *event = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir);
+	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct inode *child = NULL;
 	bool name_event = false;
 
-	if ((fid_mode & FAN_REPORT_DIR_FID) && dir) {
+	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
 		/*
 		 * With both flags FAN_REPORT_DIR_FID and FAN_REPORT_FID, we
 		 * report the child fid for events reported on a non-dir child
@@ -540,7 +541,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		    (mask & FAN_EVENT_ON_CHILD) && !(mask & FAN_ONDIR))
 			child = id;
 
-		id = fanotify_dfid_inode(mask, data, data_type, dir);
+		id = dirid;
 
 		/*
 		 * We record file name only in a group with FAN_REPORT_NAME
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 277af3d5efce..834775f61f6b 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -365,7 +365,7 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct fsnotify_iter_info iter_info = {};
 	struct super_block *sb = to_tell->i_sb;
-	struct inode *dir = S_ISDIR(to_tell->i_mode) ? to_tell : NULL;
+	struct inode *dir = file_name ? to_tell : NULL;
 	struct mount *mnt = NULL;
 	struct inode *child = NULL;
 	int ret = 0;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 9bd75d0582b4..d94a50e0445a 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -123,9 +123,7 @@ struct mem_cgroup;
  * @data_type:	type of object for fanotify_data_XXX() accessors
  * @dir:	optional directory associated with event -
  *		if @file_name is not NULL, this is the directory that
- *		@file_name is relative to. Otherwise, @dir is the object
- *		inode if event happened on directory and NULL if event
- *		happenned on a non-directory.
+ *		@file_name is relative to
  * @file_name:	optional file name associated with event
  * @cookie:	inotify rename cookie
  * @iter_info:	array of marks from this group that are interested in the event
-- 
2.17.1

