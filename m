Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 934B47DD3B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 16:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbfHAOCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 10:02:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39999 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731334AbfHAOCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:02:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so63342437wmj.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2019 07:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAQOsSW3PZlCOOlV7G41FboY5NO3JDvgIsqYW8MdaEk=;
        b=pJbADqE6F+VfeX7hvi2dugmmHutowjKhzjE6+Q7BXUDl/wCOW968LjGSI8/sx95hSR
         vc/aipa7agLZvHHj5mJbuDQ+8jg2lWdo7wkau1fFuYiKSp8/q5wMx9o+o7s793r4tYOL
         XwOFyRcdf4IZ7cbR4MBMNGZyjhla7r26l3coSDEpvsHkZAhyMoGUDgH1jz3+0vxe+WGY
         9pGI9SbubYXLaV6rrIw3IfwtM6X6iRndBR2OgPQ25desrL3v0nAW7OdNDJHdhhni0JMg
         tCglSl1ntYmrH/nnaskWz/9HYTpX5gQmb3eOSSR7BQd9kpnrhIgUwjvtrzgMi7lvnxWV
         mbZA==
X-Gm-Message-State: APjAAAU6rYpIzUYYIl2IwTYozejaB0rmxDpwSMvkU5w5BflNu+cXZfYx
        2KSG7awXH0B7DgrASetKDggWCA==
X-Google-Smtp-Source: APXvYqwOoyiVZsMYZ8cQ5e9OGb1IvlPrdHbwXo+5ZDiPo/qYsmcC1ojfeFMhV57U40LtD/r6DkjFEg==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr53608258wml.124.1564668167154;
        Thu, 01 Aug 2019 07:02:47 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z7sm69909162wrh.67.2019.08.01.07.02.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 07:02:46 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/4] d_walk: optionally lock also parent inode
Date:   Thu,  1 Aug 2019 16:02:40 +0200
Message-Id: <20190801140243.24080-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801140243.24080-1-omosnace@redhat.com>
References: <20190801140243.24080-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will be used in a later patch to provide a function to safely
perform d_genocide on live trees.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/dcache.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index e88cf0554e65..9ed4c0f99e57 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1259,12 +1259,13 @@ enum d_walk_ret {
 /**
  * d_walk - walk the dentry tree
  * @parent:	start of walk
+ * @lock_inode	whether to lock also parent inode
  * @data:	data passed to @enter() and @finish()
  * @enter:	callback when first entering the dentry
  *
  * The @enter() callbacks are called with d_lock held.
  */
-static void d_walk(struct dentry *parent, void *data,
+static void d_walk(struct dentry *parent, bool lock_inode, void *data,
 		   enum d_walk_ret (*enter)(void *, struct dentry *))
 {
 	struct dentry *this_parent;
@@ -1276,6 +1277,8 @@ static void d_walk(struct dentry *parent, void *data,
 again:
 	read_seqbegin_or_lock(&rename_lock, &seq);
 	this_parent = parent;
+	if (lock_inode)
+		inode_lock(this_parent->d_inode);
 	spin_lock(&this_parent->d_lock);
 
 	ret = enter(data, this_parent);
@@ -1319,9 +1322,21 @@ resume:
 
 		if (!list_empty(&dentry->d_subdirs)) {
 			spin_unlock(&this_parent->d_lock);
-			spin_release(&dentry->d_lock.dep_map, 1, _RET_IP_);
+			if (lock_inode) {
+				spin_unlock(&dentry->d_lock);
+				inode_unlock(this_parent->d_inode);
+			} else {
+				spin_release(&dentry->d_lock.dep_map,
+					     1, _RET_IP_);
+			}
 			this_parent = dentry;
-			spin_acquire(&this_parent->d_lock.dep_map, 0, 1, _RET_IP_);
+			if (lock_inode) {
+				inode_lock(this_parent->d_inode);
+				spin_lock(&this_parent->d_lock);
+			} else {
+				spin_acquire(&this_parent->d_lock.dep_map,
+					     0, 1, _RET_IP_);
+			}
 			goto repeat;
 		}
 		spin_unlock(&dentry->d_lock);
@@ -1336,6 +1351,10 @@ ascend:
 		this_parent = child->d_parent;
 
 		spin_unlock(&child->d_lock);
+		if (lock_inode) {
+			inode_unlock(child->d_inode);
+			inode_lock(this_parent->d_inode);
+		}
 		spin_lock(&this_parent->d_lock);
 
 		/* might go back up the wrong parent if we have had a rename. */
@@ -1357,12 +1376,16 @@ ascend:
 
 out_unlock:
 	spin_unlock(&this_parent->d_lock);
+	if (lock_inode)
+		inode_unlock(this_parent->d_inode);
 	done_seqretry(&rename_lock, seq);
 	return;
 
 rename_retry:
-	spin_unlock(&this_parent->d_lock);
 	rcu_read_unlock();
+	spin_unlock(&this_parent->d_lock);
+	if (lock_inode)
+		inode_unlock(this_parent->d_inode);
 	BUG_ON(seq & 1);
 	if (!retry)
 		return;
@@ -1402,7 +1425,7 @@ int path_has_submounts(const struct path *parent)
 	struct check_mount data = { .mnt = parent->mnt, .mounted = 0 };
 
 	read_seqlock_excl(&mount_lock);
-	d_walk(parent->dentry, &data, path_check_mount);
+	d_walk(parent->dentry, false, &data, path_check_mount);
 	read_sequnlock_excl(&mount_lock);
 
 	return data.mounted;
@@ -1541,7 +1564,7 @@ void shrink_dcache_parent(struct dentry *parent)
 		struct select_data data = {.start = parent};
 
 		INIT_LIST_HEAD(&data.dispose);
-		d_walk(parent, &data, select_collect);
+		d_walk(parent, false, &data, select_collect);
 
 		if (!list_empty(&data.dispose)) {
 			shrink_dentry_list(&data.dispose);
@@ -1552,7 +1575,7 @@ void shrink_dcache_parent(struct dentry *parent)
 		if (!data.found)
 			break;
 		data.victim = NULL;
-		d_walk(parent, &data, select_collect2);
+		d_walk(parent, false, &data, select_collect2);
 		if (data.victim) {
 			struct dentry *parent;
 			spin_lock(&data.victim->d_lock);
@@ -1599,7 +1622,7 @@ static enum d_walk_ret umount_check(void *_data, struct dentry *dentry)
 static void do_one_tree(struct dentry *dentry)
 {
 	shrink_dcache_parent(dentry);
-	d_walk(dentry, dentry, umount_check);
+	d_walk(dentry, false, dentry, umount_check);
 	d_drop(dentry);
 	dput(dentry);
 }
@@ -1656,7 +1679,7 @@ void d_invalidate(struct dentry *dentry)
 	shrink_dcache_parent(dentry);
 	for (;;) {
 		struct dentry *victim = NULL;
-		d_walk(dentry, &victim, find_submount);
+		d_walk(dentry, false, &victim, find_submount);
 		if (!victim) {
 			if (had_submounts)
 				shrink_dcache_parent(dentry);
@@ -3106,7 +3129,7 @@ static enum d_walk_ret d_genocide_kill(void *data, struct dentry *dentry)
 
 void d_genocide(struct dentry *parent)
 {
-	d_walk(parent, parent, d_genocide_kill);
+	d_walk(parent, false, parent, d_genocide_kill);
 }
 
 EXPORT_SYMBOL(d_genocide);
-- 
2.21.0

