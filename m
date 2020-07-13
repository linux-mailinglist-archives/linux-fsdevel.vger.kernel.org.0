Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F132185BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgGHLMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgGHLM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EEBC08E6DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so2489175wmi.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ATp/RTsI7zK8EGtjqOjVBnrsgD4PvuAHbXIa5Nq+0TQ=;
        b=YTsySCspQR9f1SgUwVeT7rV3fuJNjef0Gsm4zb8dhXEXTy+COUOXWTmM3s6/+FxeAj
         p9FAX2ju672xDRUDQ7HCEGc9XtoFIo0rWf2llPMxaXeJiJtnUfpS2+gAnG4pPrdIaipr
         4md1KdzCHwgHjK/WpOlGrh/UcB9+NDcmxvNwHLuv8o2ttSOKbm6hc0R0ZIeF7KzzBBcS
         bmVrle0863qRkIt//QKXlj1r7kb+O6w/jPkrq1tywgkf3KbC0RrxQYErZsp4PYPyFhGH
         F4WaeZAJHICOL7QvlYbTtqPZE0Wy+URJKh36Pf1nGtLdCfOPdjba4Z947TSZdarYNJd6
         tCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ATp/RTsI7zK8EGtjqOjVBnrsgD4PvuAHbXIa5Nq+0TQ=;
        b=g8a0COrxY/Unj7bCiYxcz3v7yJ0D2htODdjwmp9vQma8UT2UXhDNfsN8iC2uEXVr9t
         rC+RDVL1rwSnyNuyMDNImbr5czETyXlUHL8hOz/vz6ajXK5BPUXL7dv5WqiczgOnO2q9
         iEBcQ9PrergrKDTE8JK/vNGxzdHFEhc60BKiqKCV7A53yrrbeYB5GKaN+iIkPY1rQujS
         VDiTMmbbuYarcsPePknzqBLCQwBv4jzUwYzYhyoRVm/icoInkbkVKkG/tH8v3X6lCdlG
         rKR20WT7A4kSCCL+s8GM+JoL/4qdJg5Q/JogPk2uPobnbgZnv1aNHQutLP6h+iAozcg4
         MeyA==
X-Gm-Message-State: AOAM533sybUIU9e5xzq+sJDaxgZxm3Cy1VgBBrK2Zs8KIFjTe+uVGW9s
        4Q8ggnw/2KY6ngyhPcow+IE=
X-Google-Smtp-Source: ABdhPJwXNpzmf0+u0b+it/ovPRokUTAi6OKGgqrO31nFwNdcUW105VjePezaNvBc21+p0MT9OlkpDw==
X-Received: by 2002:a1c:e088:: with SMTP id x130mr8446989wmg.14.1594206747726;
        Wed, 08 Jul 2020 04:12:27 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:26 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 15/20] fanotify: prepare for implicit event flags in mark mask
Date:   Wed,  8 Jul 2020 14:11:50 +0300
Message-Id: <20200708111156.24659-15-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So far, all flags that can be set in an fanotify mark mask can be set
explicitly by a call to fanotify_mark(2).

Prepare for defining implicit event flags that cannot be set by user with
fanotify_mark(2), similar to how inotify/dnotify implicitly set the
FS_EVENT_ON_CHILD flag.

Implicit event flags cannot be removed by user and mark gets destroyed
when only implicit event flags remain in the mask.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 40 ++++++++++++++++++------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 27bbd67270d8..66d663baa4a6 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -651,12 +651,13 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 }
 
 static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
-					    __u32 mask,
-					    unsigned int flags,
-					    int *destroy)
+					    __u32 mask, unsigned int flags,
+					    __u32 umask, int *destroy)
 {
 	__u32 oldmask = 0;
 
+	/* umask bits cannot be removed by user */
+	mask &= ~umask;
 	spin_lock(&fsn_mark->lock);
 	if (!(flags & FAN_MARK_IGNORED_MASK)) {
 		oldmask = fsn_mark->mask;
@@ -664,7 +665,13 @@ static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
 	} else {
 		fsn_mark->ignored_mask &= ~mask;
 	}
-	*destroy = !(fsn_mark->mask | fsn_mark->ignored_mask);
+	/*
+	 * We need to keep the mark around even if remaining mask cannot
+	 * result in any events (e.g. mask == FAN_ONDIR) to support incremenal
+	 * changes to the mask.
+	 * Destroy mark when only umask bits remain.
+	 */
+	*destroy = !((fsn_mark->mask | fsn_mark->ignored_mask) & ~umask);
 	spin_unlock(&fsn_mark->lock);
 
 	return mask & oldmask;
@@ -672,7 +679,7 @@ static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
 
 static int fanotify_remove_mark(struct fsnotify_group *group,
 				fsnotify_connp_t *connp, __u32 mask,
-				unsigned int flags)
+				unsigned int flags, __u32 umask)
 {
 	struct fsnotify_mark *fsn_mark = NULL;
 	__u32 removed;
@@ -686,7 +693,7 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 	}
 
 	removed = fanotify_mark_remove_from_mask(fsn_mark, mask, flags,
-						 &destroy_mark);
+						 umask, &destroy_mark);
 	if (removed & fsnotify_conn_mask(fsn_mark->connector))
 		fsnotify_recalc_mask(fsn_mark->connector);
 	if (destroy_mark)
@@ -702,25 +709,26 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 
 static int fanotify_remove_vfsmount_mark(struct fsnotify_group *group,
 					 struct vfsmount *mnt, __u32 mask,
-					 unsigned int flags)
+					 unsigned int flags, __u32 umask)
 {
 	return fanotify_remove_mark(group, &real_mount(mnt)->mnt_fsnotify_marks,
-				    mask, flags);
+				    mask, flags, umask);
 }
 
 static int fanotify_remove_sb_mark(struct fsnotify_group *group,
-				      struct super_block *sb, __u32 mask,
-				      unsigned int flags)
+				   struct super_block *sb, __u32 mask,
+				   unsigned int flags, __u32 umask)
 {
-	return fanotify_remove_mark(group, &sb->s_fsnotify_marks, mask, flags);
+	return fanotify_remove_mark(group, &sb->s_fsnotify_marks, mask,
+				    flags, umask);
 }
 
 static int fanotify_remove_inode_mark(struct fsnotify_group *group,
 				      struct inode *inode, __u32 mask,
-				      unsigned int flags)
+				      unsigned int flags, __u32 umask)
 {
 	return fanotify_remove_mark(group, &inode->i_fsnotify_marks, mask,
-				    flags);
+				    flags, umask);
 }
 
 static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
@@ -1170,13 +1178,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	case FAN_MARK_REMOVE:
 		if (mark_type == FAN_MARK_MOUNT)
 			ret = fanotify_remove_vfsmount_mark(group, mnt, mask,
-							    flags);
+							    flags, 0);
 		else if (mark_type == FAN_MARK_FILESYSTEM)
 			ret = fanotify_remove_sb_mark(group, mnt->mnt_sb, mask,
-						      flags);
+						      flags, 0);
 		else
 			ret = fanotify_remove_inode_mark(group, inode, mask,
-							 flags);
+							 flags, 0);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.17.1

