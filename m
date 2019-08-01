Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF4A7DD3C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 16:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbfHAOCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 10:02:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54443 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbfHAOCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:02:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so64758819wme.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2019 07:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVoAsHIZkuqGu1B9h4zcpi2CkI6wnGm5HImJow5hag0=;
        b=PUmq0Tw5c6kXv+OjM7ZSk6W6BgsCGcF8rg4sxy4v4QECkhEEiDF+faKJN8EcqgCE6w
         6VRNmpRLAN7tPCapx3/M/x/9RnEKDbwAUj8QBJTyHbxxsi/dPyirwiFsaxtddBagD1sz
         njhs5Pv0njL5oJd5wrHxZ5LZKrq5MQqHiKQvlGwuiYUVQkqv+TZNXr95FYj4NFjTUxWx
         R33MF/lE+r6cYuAbv4MS0Gu/MmzcmWSSMgP8SevLT4VxWDOA5q/1VX0rOoEA5sGu0FDW
         wCQDLtmRCkZxoxakJTXRfl0vnZDJzuf9+t/6CwoA+FSEs9A4InGE/HvTnv10mUzKIf8o
         klIQ==
X-Gm-Message-State: APjAAAVuz1PK9eHUQ8kakiw6dpJ/Q7Cai2HsI/UHMaY9N+djuy2DFF1I
        JA5fQcCXXiNVRfwkHXwJSb4uJg==
X-Google-Smtp-Source: APXvYqyq38Dtjc6r/Z1L3RuAkckNyKmI3TkmfNNClGNXNgfmgTm6XN9lLApcFKx8KcKrOj64CmAWRA==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr17907918wma.78.1564668168090;
        Thu, 01 Aug 2019 07:02:48 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z7sm69909162wrh.67.2019.08.01.07.02.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 07:02:47 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/4] d_walk: add leave callback
Date:   Thu,  1 Aug 2019 16:02:41 +0200
Message-Id: <20190801140243.24080-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801140243.24080-1-omosnace@redhat.com>
References: <20190801140243.24080-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an optional callback that gets called when d_walk is *leaving* a
dentry. This will be used in a later patch to provide a function to
safely perform d_genocide on live trees.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/dcache.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9ed4c0f99e57..70afcb6e6892 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1260,13 +1260,15 @@ enum d_walk_ret {
  * d_walk - walk the dentry tree
  * @parent:	start of walk
  * @lock_inode	whether to lock also parent inode
- * @data:	data passed to @enter() and @finish()
+ * @data:	data passed to @enter() and @leave()
  * @enter:	callback when first entering the dentry
+ * @leave:	callback when leaving the dentry
  *
  * The @enter() callbacks are called with d_lock held.
  */
 static void d_walk(struct dentry *parent, bool lock_inode, void *data,
-		   enum d_walk_ret (*enter)(void *, struct dentry *))
+		   enum d_walk_ret (*enter)(void *, struct dentry *),
+		   void (*leave)(void *, struct dentry *))
 {
 	struct dentry *this_parent;
 	struct list_head *next;
@@ -1339,6 +1341,8 @@ resume:
 			}
 			goto repeat;
 		}
+		if (leave)
+			leave(data, dentry);
 		spin_unlock(&dentry->d_lock);
 	}
 	/*
@@ -1350,6 +1354,8 @@ ascend:
 		struct dentry *child = this_parent;
 		this_parent = child->d_parent;
 
+		if (leave)
+			leave(data, child);
 		spin_unlock(&child->d_lock);
 		if (lock_inode) {
 			inode_unlock(child->d_inode);
@@ -1370,6 +1376,8 @@ ascend:
 		rcu_read_unlock();
 		goto resume;
 	}
+	if (leave)
+		leave(data, parent);
 	if (need_seqretry(&rename_lock, seq))
 		goto rename_retry;
 	rcu_read_unlock();
@@ -1425,7 +1433,7 @@ int path_has_submounts(const struct path *parent)
 	struct check_mount data = { .mnt = parent->mnt, .mounted = 0 };
 
 	read_seqlock_excl(&mount_lock);
-	d_walk(parent->dentry, false, &data, path_check_mount);
+	d_walk(parent->dentry, false, &data, path_check_mount, NULL);
 	read_sequnlock_excl(&mount_lock);
 
 	return data.mounted;
@@ -1564,7 +1572,7 @@ void shrink_dcache_parent(struct dentry *parent)
 		struct select_data data = {.start = parent};
 
 		INIT_LIST_HEAD(&data.dispose);
-		d_walk(parent, false, &data, select_collect);
+		d_walk(parent, false, &data, select_collect, NULL);
 
 		if (!list_empty(&data.dispose)) {
 			shrink_dentry_list(&data.dispose);
@@ -1575,7 +1583,7 @@ void shrink_dcache_parent(struct dentry *parent)
 		if (!data.found)
 			break;
 		data.victim = NULL;
-		d_walk(parent, false, &data, select_collect2);
+		d_walk(parent, false, &data, select_collect2, NULL);
 		if (data.victim) {
 			struct dentry *parent;
 			spin_lock(&data.victim->d_lock);
@@ -1622,7 +1630,7 @@ static enum d_walk_ret umount_check(void *_data, struct dentry *dentry)
 static void do_one_tree(struct dentry *dentry)
 {
 	shrink_dcache_parent(dentry);
-	d_walk(dentry, false, dentry, umount_check);
+	d_walk(dentry, false, dentry, umount_check, NULL);
 	d_drop(dentry);
 	dput(dentry);
 }
@@ -1679,7 +1687,7 @@ void d_invalidate(struct dentry *dentry)
 	shrink_dcache_parent(dentry);
 	for (;;) {
 		struct dentry *victim = NULL;
-		d_walk(dentry, false, &victim, find_submount);
+		d_walk(dentry, false, &victim, find_submount, NULL);
 		if (!victim) {
 			if (had_submounts)
 				shrink_dcache_parent(dentry);
@@ -3129,7 +3137,7 @@ static enum d_walk_ret d_genocide_kill(void *data, struct dentry *dentry)
 
 void d_genocide(struct dentry *parent)
 {
-	d_walk(parent, false, parent, d_genocide_kill);
+	d_walk(parent, false, parent, d_genocide_kill, NULL);
 }
 
 EXPORT_SYMBOL(d_genocide);
-- 
2.21.0

