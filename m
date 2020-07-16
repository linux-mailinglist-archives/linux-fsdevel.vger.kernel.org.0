Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34872221EAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGPIms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGPImq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52B8C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so6176158wrw.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dDy7ABfa4zJAwsOa+qQ/a/9U+UuUwp99kzTAOxVYBTs=;
        b=dZqBkAzIavPMlnyLPBhKu0YCe+sLS3TtFgKQ6k/Y/VtS0lKv9Y3ohDnVrP9fEz/nvX
         xdmyRPB1mUqWQksAwgUWIXq073N3YgkREwE4/t2AQf3wKirrM5eOP8vVpPzTQwblZQhe
         u6tTWcZT7kw7mrewpRe4/4gMNCxqpEXme3ZEpS4aMA9yeq4cVypkLjJiXXS3Ed6LFm6u
         ME/WQtkG4BqiIhdV3v1yrbmo2NJPKxdpCymsPWhoFG4ECaoLqvmQJmPSdrVhYTB2Hzpv
         rgXgpgO1lFud6Pf6ChXkvTLL/QatGZUTF34/eX01cZKQRcBw/xj6lvU8pyanoFajii56
         AeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dDy7ABfa4zJAwsOa+qQ/a/9U+UuUwp99kzTAOxVYBTs=;
        b=VZznoLRBz2aPuIUaN9s0KD6VLqU1L+izXrEXXdrGlKXTj8Nk7tFsozHo1mT1sVQQAA
         yOHUdbwX0/7p+0+sHUYeIbDg/OGGDi7vRSEbNc03/sR68asFbY0rzPPFxdQL2xTxOgaZ
         hgpeUMjVe2iFdL4TMmhLDYyUgR7XeIdzh5aT7330YKjMXjFKYCGGw2TepuzWJ67nPdQW
         UIINHCPpRUXGw7eMk9QGjmJ4fJK1+LW4pgbEI3nIztr2HpMdVo3R8CMXiuvVQj+fBWCV
         OxQD3h91x6qiqBWZ3nbyWXooMLJHYuA8ovUUbxZ2uID8lrFMDbByMi76rHU2M9DPnevG
         9bZQ==
X-Gm-Message-State: AOAM530dk8gGwcAFsmrwPHH/8D54iCS8iEaN1KIHb4hLVMUuLA/d0iaQ
        z6XD9iZuDJ4BJAjBj38Zp64=
X-Google-Smtp-Source: ABdhPJx+/aQzB5MsL/jNZ+BpQZ37JERz2XUpeqRzR0a/JX3/1hvUAkd+yFLTrgTBe4zOc2eHJAn11g==
X-Received: by 2002:adf:b312:: with SMTP id j18mr3718937wrd.195.1594888964656;
        Thu, 16 Jul 2020 01:42:44 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:44 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 06/22] fanotify: prepare for implicit event flags in mark mask
Date:   Thu, 16 Jul 2020 11:42:14 +0300
Message-Id: <20200716084230.30611-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
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
index 6d30beb320f3..ab974cd234f7 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -656,12 +656,13 @@ static int fanotify_find_path(int dfd, const char __user *filename,
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
@@ -669,7 +670,13 @@ static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
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
@@ -677,7 +684,7 @@ static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
 
 static int fanotify_remove_mark(struct fsnotify_group *group,
 				fsnotify_connp_t *connp, __u32 mask,
-				unsigned int flags)
+				unsigned int flags, __u32 umask)
 {
 	struct fsnotify_mark *fsn_mark = NULL;
 	__u32 removed;
@@ -691,7 +698,7 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 	}
 
 	removed = fanotify_mark_remove_from_mask(fsn_mark, mask, flags,
-						 &destroy_mark);
+						 umask, &destroy_mark);
 	if (removed & fsnotify_conn_mask(fsn_mark->connector))
 		fsnotify_recalc_mask(fsn_mark->connector);
 	if (destroy_mark)
@@ -707,25 +714,26 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 
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
@@ -1175,13 +1183,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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

