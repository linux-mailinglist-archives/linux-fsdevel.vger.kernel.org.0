Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBF01F7614
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgFLJeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFLJeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:22 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D1AC08C5C3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:22 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id mb16so9447816ejb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ATp/RTsI7zK8EGtjqOjVBnrsgD4PvuAHbXIa5Nq+0TQ=;
        b=sAe4xcUDVXdgDacqIpq8zjDMufAyUvIPeTxRDf3ifErFt/r1UXd1ev+MmAcmZ/XVyW
         NRVxAKWjkiniC7uTwn5cji3M6w00oRy1rQa/8Rz6LDlVWo7R8NjwD8OHYRQMJG0XYtL8
         B2wScN5M8sL2ncEpkc0lGuSfwlXVpfrstvXhZmPDMq7nyVCo7CEQFyzz4GHyul++c11k
         Zx8kX7TPKhS4KP5h38ggZyvcGWrRwsmzT5tW+GJrbB/7tov7/5jB4Mi2ta8q8gxAQlfL
         zG9a4XRQPQOzmXb/ixP64pdCIj5vkpszutMm2TVj2l/5ZBL+FPCAHg649XEk5wHQk/Mq
         QTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ATp/RTsI7zK8EGtjqOjVBnrsgD4PvuAHbXIa5Nq+0TQ=;
        b=lNURvQgP9UOAtJCyhJl23N+jZyTdVFeEhOllQYXwaYCHgSrSrbtqUuyAjox+UIT2yQ
         nIXvhC9aAjgAObIwH0ws7TPCnjuupD1mCQgrLtQYoLq9+lr7SuT5H/NIUIXE9O4vOFyR
         TDOgZa8boA7H6hDjwZHv8XNBnDkVhQ8JP6NiUwl/YIoh0PUwuSf5xGyPp+EY5kNmREmb
         cqMlUARCqOEApAx+IeP42r2UfDYS8mrbeA3f57nFiDZWI20k7lItRHMK2QGFH7dEF5iF
         iFFv8Sg+JdUcAgxpTm8QmLG590Wdz595cW1rdAFDD+d7JCIxkO/I9PyNs7BD7AEQd2Pp
         5fAw==
X-Gm-Message-State: AOAM533cwWex/739AEOdmoosiwW1UGi+Hc0742K9WblWig4toQe+dtiE
        lesmpem/QiUHQRSAz3USEGE=
X-Google-Smtp-Source: ABdhPJy9D+3+3OMht+nzCzdQFRpqFHtVHJ0qqQ45jbB9RUcKboMZbkuo+/qVmwdSgh3m0mq2eoGf1g==
X-Received: by 2002:a17:906:d043:: with SMTP id bo3mr11815824ejb.409.1591954460769;
        Fri, 12 Jun 2020 02:34:20 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:20 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/20] fanotify: prepare for implicit event flags in mark mask
Date:   Fri, 12 Jun 2020 12:33:38 +0300
Message-Id: <20200612093343.5669-16-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
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

