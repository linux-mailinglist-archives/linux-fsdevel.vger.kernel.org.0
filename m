Return-Path: <linux-fsdevel+bounces-14645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D25F87DF45
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 19:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC37A1F210D4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 18:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E611EB3E;
	Sun, 17 Mar 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djiLL19Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE71DDF6
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700928; cv=none; b=dW9MMDRjNWLRraL3IPVb+nvuvWFTEo9jx52q/TSk8c4z1LNT7Hw1vBkUEf6ttcXxqiGwC3CxZA3wrnmTbK+v6V4DtyBISfO6H6AvTLNSm2DVcJpBI0YYHtmiy99sk/ZS8LTwrYRhv3Uax89Qc2lyxVPkGnZ4SvG3JetFiIkttiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700928; c=relaxed/simple;
	bh=ISiG0maE5LELtMeVgiAJ9f3SHCBj45lIDzX/OlUiQXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mtzwg7d1pSqTTRL2rznOGmZZeEIhZTBKEFAhBbecM8fsQCI0Q5lIBz1V7yP/GqMU95eo6VSsDq5EnLR/OHocMl75F9b1zpadpeRS8Oc9aars6rjTVaOfZ9IpusLzPpYaKUkoBQLgB/N02fpWPsIEDx8W46wlxQ3QPYgoZYYeS7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djiLL19Q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4141088f1c3so1202005e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710700925; x=1711305725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKuN5izu3Xbqu52NNd0QS+H/RJvfydSayF4yJoc407E=;
        b=djiLL19QPPjXpk67ammq4QeHuQtRkIadwtWfOzjp6hgE6idOwbsU8awHehXE+VYs26
         9dlwgppcAQwLIaFAR7/vSV0ML0OLO2b/WXg7sZeL1nEDUuQuiBneptOi5m4ykhU5lvll
         z7+vmeSYZeJfj3yTDtPBP39GSJjY4qwcv1KelenEmYcrAZNz1pvk2AkijSsr1GjtYYiV
         CpUAffRpKeQHQmVnYPl4Luu3FcGnH7UCb7TogvNxsUS9bnqMyUWx7ITg6GU82uHA70ok
         aSG/HxEEq7E7MckP6JH7nTLK61Ow+cEQcqch989xBzFrE3pouikS0HvQaoi/Ap8kawhE
         y96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700925; x=1711305725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKuN5izu3Xbqu52NNd0QS+H/RJvfydSayF4yJoc407E=;
        b=bQ8sx6I1lVSpcVjxgOvBeS+BAJar4PGj1sg5QVvbbCM8IXCK2hriLhB6P5FyeNGkvv
         JQqAQ1JPI4kz7hq6ww28ofCQtX54q5JSia8c1t6eHFcRvthdV0S2Prey0I8HIsbvMLiO
         NqK2YiYG4/wdzFIrGwNCe3DRfwVEpb5G631IQaU9k2GIloPTapQFWRYrGJj0LD9Wq8YJ
         t1E1RoXBuWgwRNS/okaRfEd8ixv58nEaaxWbKlxAY1Cu8nzRMXvc2n1vY9gyRp0ngNrx
         dDbfanh4wAID4XXQbythoeoqEOIAhsKUTzcvxIZeGjar8l1BRKn57mjf/TJncxTZMGeg
         Ohdw==
X-Forwarded-Encrypted: i=1; AJvYcCWdpO/1dkIf9upPwlPkrtqLtd1KU6KLELYlZyoVPU1WiJ6uSE1H1D8Fwqfp5Z1ttLjYpH3XBQEgZHApe89NrGtpTWtlXKwRcNdEGrZhYA==
X-Gm-Message-State: AOJu0YxHzypdLt+/brj1CfPrQCdRI6mYhpTfzWlesT/7j0gkZuiPWl6u
	1JGeNKixPTc+4ejMDp3pqAwxRWlXCHw1r9GCNy7psfhUn8geaWrL
X-Google-Smtp-Source: AGHT+IHI//aWRzp7X0SJNBwDYvWlXn0BygIHaXae6qazITpgqxEy9Nkzf0Sp2thHjABfRjDMOfhq3g==
X-Received: by 2002:a05:600c:4f50:b0:413:1622:4d04 with SMTP id m16-20020a05600c4f5000b0041316224d04mr8029766wmq.12.1710700924941;
        Sun, 17 Mar 2024 11:42:04 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033e22a7b3f8sm3070716wrb.75.2024.03.17.11.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:42:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/10] fsnotify: create a wrapper fsnotify_find_inode_mark()
Date: Sun, 17 Mar 2024 20:41:47 +0200
Message-Id: <20240317184154.1200192-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317184154.1200192-1-amir73il@gmail.com>
References: <20240317184154.1200192-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to passing an object pointer to fsnotify_find_mark(), add
a wrapper fsnotify_find_inode_mark() and use it where possible.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/filecache.c              | 4 ++--
 fs/notify/dnotify/dnotify.c      | 4 ++--
 fs/notify/inotify/inotify_user.c | 2 +-
 include/linux/fsnotify_backend.h | 7 +++++++
 kernel/audit_tree.c              | 2 +-
 kernel/audit_watch.c             | 2 +-
 6 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ddd3e0d9cfa6..ad9083ca144b 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -159,8 +159,8 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf, struct inode *inode)
 
 	do {
 		fsnotify_group_lock(nfsd_file_fsnotify_group);
-		mark = fsnotify_find_mark(&inode->i_fsnotify_marks,
-					  nfsd_file_fsnotify_group);
+		mark = fsnotify_find_inode_mark(inode,
+						nfsd_file_fsnotify_group);
 		if (mark) {
 			nfm = nfsd_file_mark_get(container_of(mark,
 						 struct nfsd_file_mark,
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 3464fa7e8538..f3669403fabf 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -162,7 +162,7 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
 	if (!S_ISDIR(inode->i_mode))
 		return;
 
-	fsn_mark = fsnotify_find_mark(&inode->i_fsnotify_marks, dnotify_group);
+	fsn_mark = fsnotify_find_inode_mark(inode, dnotify_group);
 	if (!fsn_mark)
 		return;
 	dn_mark = container_of(fsn_mark, struct dnotify_mark, fsn_mark);
@@ -326,7 +326,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 	fsnotify_group_lock(dnotify_group);
 
 	/* add the new_fsn_mark or find an old one. */
-	fsn_mark = fsnotify_find_mark(&inode->i_fsnotify_marks, dnotify_group);
+	fsn_mark = fsnotify_find_inode_mark(inode, dnotify_group);
 	if (fsn_mark) {
 		dn_mark = container_of(fsn_mark, struct dnotify_mark, fsn_mark);
 		spin_lock(&fsn_mark->lock);
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 85d8fdd55329..4ffc30606e0b 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -544,7 +544,7 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 	int create = (arg & IN_MASK_CREATE);
 	int ret;
 
-	fsn_mark = fsnotify_find_mark(&inode->i_fsnotify_marks, group);
+	fsn_mark = fsnotify_find_inode_mark(inode, group);
 	if (!fsn_mark)
 		return -ENOENT;
 	else if (create) {
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d4e3bc55d174..992b57a7e95f 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -789,6 +789,13 @@ static inline int fsnotify_add_inode_mark_locked(struct fsnotify_mark *mark,
 					FSNOTIFY_OBJ_TYPE_INODE, add_flags);
 }
 
+static inline struct fsnotify_mark *fsnotify_find_inode_mark(
+						struct inode *inode,
+						struct fsnotify_group *group)
+{
+	return fsnotify_find_mark(&inode->i_fsnotify_marks, group);
+}
+
 /* given a group and a mark, flag mark to be freed when all references are dropped */
 extern void fsnotify_destroy_mark(struct fsnotify_mark *mark,
 				  struct fsnotify_group *group);
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 1b07e6f12a07..f2f38903b2fe 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -463,7 +463,7 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
 	int n;
 
 	fsnotify_group_lock(audit_tree_group);
-	mark = fsnotify_find_mark(&inode->i_fsnotify_marks, audit_tree_group);
+	mark = fsnotify_find_inode_mark(inode, audit_tree_group);
 	if (!mark)
 		return create_chunk(inode, tree);
 
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 7a98cd176a12..7f358740e958 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -90,7 +90,7 @@ static inline struct audit_parent *audit_find_parent(struct inode *inode)
 	struct audit_parent *parent = NULL;
 	struct fsnotify_mark *entry;
 
-	entry = fsnotify_find_mark(&inode->i_fsnotify_marks, audit_watch_group);
+	entry = fsnotify_find_inode_mark(inode, audit_watch_group);
 	if (entry)
 		parent = container_of(entry, struct audit_parent, mark);
 
-- 
2.34.1


