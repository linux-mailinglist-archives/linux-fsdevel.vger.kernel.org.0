Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C072AAAA0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 11:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgKHK7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 05:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbgKHK7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 05:59:15 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF08C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 02:59:15 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id x7so5778307wrl.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 02:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hu6e1RKhHSsNkj7ZrTBDQoXVFO2+fGB1U71evkbCi7k=;
        b=KGL0cscKWbfQ0eS1dOqWL6yfJdOmrD1rTdLizdNFMdPpqW/QG2DstmDSxjXi5zBJPu
         zvkaxVpTs0GIDsjAaA0trdRusYIKFKVf6Mvi9+5EJGa5CHMSPbYBs1pOwpTd48w9JJa8
         AAFFQrJ9O0gJvoMvPsg+UZwuP2jY2jTl/NLANaCkcWNrWL/UjWF315YMh+H1VQydaUeO
         fke1Kqcsb97dSMWFRWTygPY3YCsZtlf+DURTYDzkSWnlDpMMFnCufzBPrAadr3z+6l2P
         jrfBiTAMnZUX/7tnHU9wcjcD1fUbltOX2yOU0zwEC+UDQhG4HPy7ExIwGWhhSLZSlI8W
         hzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hu6e1RKhHSsNkj7ZrTBDQoXVFO2+fGB1U71evkbCi7k=;
        b=Bz39uBjYLX3W8/kS2Clsz1Lz763PoipAnAuNdZn0PGZHnhzbMbwdYsTS+JU8zUKpNO
         jQ/UoLzNmeqGyUNKi2pYAx2uLJxHi942OLcRjnTrAkHqt/pWcLQra7puYzTVSuI7HsAi
         v7M44G8HW/wihHBb/TeBcoM4caHWupzxRd6e6/Xc2WwiBXNICD/iNWEhnW+6Oh8orx22
         hhJMgSH4/TdOMZI+McKcn7WkjGndoqg2+MqvB88ZgGTJx797qjAZ1I7nDVXcXX17mh5R
         xBT07XexKqLrRizERn96/RGKBidXtIEKg7PAOi1Zm3wJ4LQKVQv8U2rX+DpbognPLPCc
         N6Hg==
X-Gm-Message-State: AOAM531jh+8JiEv3rRmM5vm8XlejKVr+D8sLVKBl9TF+CAkRtyvlWQJ+
        /fjgx0/e0boTry4SI2GaWOD2BMbP2Ck=
X-Google-Smtp-Source: ABdhPJw36HQ89Oy3nSVqD8w/lg7kdRqDD7TbzAg108RiczHTy5joh05Yer4moY93d/f5jJGrQZOKqg==
X-Received: by 2002:adf:df86:: with SMTP id z6mr8596288wrl.57.1604833154034;
        Sun, 08 Nov 2020 02:59:14 -0800 (PST)
Received: from localhost.localdomain ([141.226.8.56])
        by smtp.gmail.com with ESMTPSA id b14sm9343908wrx.35.2020.11.08.02.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 02:59:13 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: fix logic of reporting name info with watched parent
Date:   Sun,  8 Nov 2020 12:59:06 +0200
Message-Id: <20201108105906.8493-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The victim inode's parent and name info is required when an event
needs to be delivered to a group interested in filename info OR
when the inode's parent is interested in an event on its children.

Let us call the first condition 'parent_needed' and the second
condition 'parent_interested'.

In fsnotify_parent(), the condition where the inode's parent is
interested in some events on its children, but not necessarily
interested the specific event is called 'parent_watched'.

fsnotify_parent() tests the condition (!parent_watched && !parent_needed)
for sending the event without parent and name info, which is correct.

It then wrongly assumes that parent_watched implies !parent_needed
and tests the condition (parent_watched && !parent_interested)
for sending the event without parent and name info, which is wrong,
because parent may still be needed by some group.

For example, after initializing a group with FAN_REPORT_DFID_NAME and
adding a FAN_MARK_MOUNT with FAN_OPEN mask, open events on non-directory
children of "testdir" are delivered with file name info.

After adding another mark to the same group on the parent "testdir"
with FAN_CLOSE|FAN_EVENT_ON_CHILD mask, open events on non-directory
children of "testdir" are no longer delivered with file name info.

Fix the logic and use auxiliary variables to clarify the conditions.

Fixes: 9b93f33105f5 ("fsnotify: send event with parent/name info to sb/mount/non-dir marks")
Cc: stable@vger.kernel.org#v5.9
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

There is an LTP test for this bug at [1].

Thanks,
Amir.

[1] https://github.com/amir73il/ltp/commits/fsnotify-fixes

 fs/notify/fsnotify.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index a960ec3a569a..8d3ad5ef2925 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -178,6 +178,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	struct inode *inode = d_inode(dentry);
 	struct dentry *parent;
 	bool parent_watched = dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED;
+	bool parent_needed, parent_interested;
 	__u32 p_mask;
 	struct inode *p_inode = NULL;
 	struct name_snapshot name;
@@ -193,7 +194,8 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 		return 0;
 
 	parent = NULL;
-	if (!parent_watched && !fsnotify_event_needs_parent(inode, mnt, mask))
+	parent_needed = fsnotify_event_needs_parent(inode, mnt, mask);
+	if (!parent_watched && !parent_needed)
 		goto notify;
 
 	/* Does parent inode care about events on children? */
@@ -205,17 +207,17 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 
 	/*
 	 * Include parent/name in notification either if some notification
-	 * groups require parent info (!parent_watched case) or the parent is
-	 * interested in this event.
+	 * groups require parent info or the parent is interested in this event.
 	 */
-	if (!parent_watched || (mask & p_mask & ALL_FSNOTIFY_EVENTS)) {
+	parent_interested = mask & p_mask & ALL_FSNOTIFY_EVENTS;
+	if (parent_needed || parent_interested) {
 		/* When notifying parent, child should be passed as data */
 		WARN_ON_ONCE(inode != fsnotify_data_inode(data, data_type));
 
 		/* Notify both parent and child with child name info */
 		take_dentry_name_snapshot(&name, dentry);
 		file_name = &name.name;
-		if (parent_watched)
+		if (parent_interested)
 			mask |= FS_EVENT_ON_CHILD;
 	}
 
-- 
2.17.1

