Return-Path: <linux-fsdevel+bounces-60410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AC9B46928
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 07:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0F618905E5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 05:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FBA1A0711;
	Sat,  6 Sep 2025 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="XoFOKlXf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RLfRexv+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB24261B9B
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757134874; cv=none; b=rnQ7HC2FMdQqWAHW5AdHdTvR1xqQ+ObxXgd4ABGOgQZPWSfcSiIlshEhVFpUMt+OUkKVH3Ymkqj0eHZwuEdJpNC9FXwJRxik/8IczpEsIj21dQTsMItD1TXLH0OeRwZta18qP5GRDD5RGuUijZKglEHpnB9UD6KDnlWBAEC7dRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757134874; c=relaxed/simple;
	bh=t/82eS4hx2jpRoLNad/aerT5Nnfvvbb5czmImY9jgyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMxfrrY/MYx8xZhmHHsa31ef+ppw2EgIVOhBsQ3NM0KoEqfFGENw7hYQ8Va0U4PPvFLzsQjRJTg8K8y1pq8Yh34qLJ8/D6icHalaqItAer7h5hVcw+pMVYgM86QGbeZLxBsHI7LzuzX6vemxz8XFn0Eb4nKuxVd7gY3cbZ51wLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=XoFOKlXf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RLfRexv+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EDC8C7A0048;
	Sat,  6 Sep 2025 01:01:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 06 Sep 2025 01:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757134871; x=
	1757221271; bh=e1vDeVJRpgBqSCka6wKZSzpRt8YVIjpU4nUKUa913Tg=; b=X
	oFOKlXf8xCFvSHaSeUFk5UKjid/TYPWSU/80UtGot9Ndv5EFFtyXkfQpuKTpbOem
	LxBty3sHPlnmYwdRvKhOgR+qEB5aTbdWsWJGgjhCfBLbQ6IV15G8Uo975gLSH++C
	xyNUUoplHNGcE73xVjdIvPfPjNAPw+/SkC5LNE34W3DeqdQ2ku6nhhmHtqBgntqz
	CE6EriuoqSYFa0h9i62HHT3CkcGu5aKt5wYvORgTqF4HUCeghDOTVn3h+2iuGdcv
	diPW1wBY78/+Mow2tTFbDdFH3VO9lBAX+pxklLGIMEUDlJfyAh9I9xIMV/kmE5BT
	z0PF6GqF00NvpPBEH8NEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757134871; x=1757221271; bh=e
	1vDeVJRpgBqSCka6wKZSzpRt8YVIjpU4nUKUa913Tg=; b=RLfRexv+i9fRJpHxg
	zenuHbEkzoNstV4DfcXEHcX7EmgWuKZHP3WUWkVZRYzdVM4f9ZE+xYXxcqfWC5FT
	fH+OkmbvWPuFwte1v8hfs6T9kUnZTvi8Q1raYYMlvKGRJqDqUB2JF3q+Avwzw9WC
	WfmOLS3GynNwNQ0FeW9TQXxx1maiXE7j1b0skA6RgUVO8k1PvSwwCaeM6RN8tuBl
	4tY1THF2Sr/TqWKa8fUgjhJ0sEa8JsbRrcevG8CmanR1zrvp9wt6KumEz8vILCF8
	4Ug4kipHa5Us97EyRZn5gE9W39nAzDA9Gy7Jn8+mLFYE+uowg7+kr2CrN5Mv5e5u
	iDh9g==
X-ME-Sender: <xms:F8C7aEoz34IQHrehLEIvSsMTqk7IgSjzxpDfDPw6nOhaDwA3t0aLMA>
    <xme:F8C7aImajgsfxgCXAiUAc6kK4AMdyhugRZaKSFoAWmBBpgiTHAKU80gfQWnIKDdpA
    GRRDq8-NAs9Gw>
X-ME-Received: <xmr:F8C7aLgjTEZ_u4CJU7aS1xC3C3VFBW5gHRlRIYe2jmme_DmJamIwgOcXfnkuyQ3dxA-aTY09cy24NDTfOlaypLFAEYinrjVQcU7M2V6frA0P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepue
    ekvdehhfegtddufffhjeehfeeiueffgeeltdeuhefhtdffteejtdejtedvjeetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:F8C7aAfg5RzkKvFRTNhzlQGn_dse4cAnOohfXn6SVl-kibMz2HG4DQ>
    <xmx:F8C7aLgciFGUMi2S6SmFM-95_nO2z1aKjtKb3JVOIlmKY_ESqlrV-g>
    <xmx:F8C7aIxZ13Ar9LRgl4oIM4lw9Ju7FpFUPns0ZkVTDf0t7OrXNBjy7w>
    <xmx:F8C7aHMHZQrnZcujoE_SCHx-IxSr6hW_7EDdzVwvKXipZ-136F5dqA>
    <xmx:F8C7aADl09WXZHOKzvNPPn5BQzgF3dSvpvNCAl860DkfZJqcpWIh7epk>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 01:01:09 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/6] VFS/audit: introduce kern_path_parent() for audit
Date: Sat,  6 Sep 2025 14:57:09 +1000
Message-ID: <20250906050015.3158851-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250906050015.3158851-1-neilb@ownmail.net>
References: <20250906050015.3158851-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

audit_alloc_mark() and audit_get_nd() both need to perform a path
lookup getting the parent dentry (which must exist) and the final
target (following a LAST_NORM name) which sometimes doesn't need to
exist.

They don't need the parent to be locked, but use kern_path_locked() or
kern_path_locked_negative() anyway.  This is somewhat misleading to the
casual reader.

This patch introduces a more targeted function, kern_path_parent(),
which returns not holding locks.  On success the "path" will
be set to the parent, which must be found, and the return value is the
dentry of the target, which might be negative.

This will clear the way to rename kern_path_locked() which is
otherwise only used to prepare for removing something.

It also allows us to remove kern_path_locked_negative(), which is
transformed into the new kern_path_parent().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c              | 23 +++++++++++++++++------
 include/linux/namei.h   |  2 +-
 kernel/audit_fsnotify.c | 11 ++++++-----
 kernel/audit_watch.c    |  3 +--
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 8b065dbca2ab..104015f302a7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2780,7 +2780,20 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 	return d;
 }
 
-struct dentry *kern_path_locked_negative(const char *name, struct path *path)
+/**
+ * kern_path_parent: lookup path returning parent and target
+ * @name: path name
+ * @parent: path to store parent in
+ *
+ * The path @name should end with a normal component, not "." or ".." or "/".
+ * A lookup is performed and if successful the parent information
+ * is store in @parent and the dentry is returned.
+ *
+ * The dentry maybe negative, the parent will be positive.
+ *
+ * Returns:  dentry or error.
+ */
+struct dentry *kern_path_parent(const char *name, struct path *path)
 {
 	struct path parent_path __free(path_put) = {};
 	struct filename *filename __free(putname) = getname_kernel(name);
@@ -2793,12 +2806,10 @@ struct dentry *kern_path_locked_negative(const char *name, struct path *path)
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM))
 		return ERR_PTR(-EINVAL);
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, LOOKUP_CREATE);
-	if (IS_ERR(d)) {
-		inode_unlock(parent_path.dentry->d_inode);
+
+	d = lookup_noperm_unlocked(&last, parent_path.dentry);
+	if (IS_ERR(d))
 		return d;
-	}
 	path->dentry = no_free_ptr(parent_path.dentry);
 	path->mnt = no_free_ptr(parent_path.mnt);
 	return d;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 551a1a01e5e7..1d5038c21c20 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -57,12 +57,12 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 				    struct dentry *base,
 				    unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
+struct dentry *kern_path_parent(const char *name, struct path *parent);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
-extern struct dentry *kern_path_locked_negative(const char *, struct path *);
 extern struct dentry *user_path_locked_at(int , const char __user *, struct path *);
 int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
 			   struct path *parent, struct qstr *last, int *type,
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index c565fbf66ac8..a58c72ae0bb4 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -76,17 +76,18 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	struct audit_fsnotify_mark *audit_mark;
 	struct path path;
 	struct dentry *dentry;
-	struct inode *inode;
 	int ret;
 
 	if (pathname[0] != '/' || pathname[len-1] == '/')
 		return ERR_PTR(-EINVAL);
 
-	dentry = kern_path_locked(pathname, &path);
+	dentry = kern_path_parent(pathname, &path);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry); /* returning an error */
-	inode = path.dentry->d_inode;
-	inode_unlock(inode);
+	if (d_is_negative(dentry)) {
+		audit_mark = ERR_PTR(-ENOENT);
+		goto out;
+	}
 
 	audit_mark = kzalloc(sizeof(*audit_mark), GFP_KERNEL);
 	if (unlikely(!audit_mark)) {
@@ -100,7 +101,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	audit_update_mark(audit_mark, dentry->d_inode);
 	audit_mark->rule = krule;
 
-	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
+	ret = fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d_inode, 0);
 	if (ret < 0) {
 		audit_mark->path = NULL;
 		fsnotify_put_mark(&audit_mark->mark);
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 0ebbbe37a60f..a700e3c8925f 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -349,7 +349,7 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 {
 	struct dentry *d;
 
-	d = kern_path_locked_negative(watch->path, parent);
+	d = kern_path_parent(watch->path, parent);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
 
@@ -359,7 +359,6 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 		watch->ino = d_backing_inode(d)->i_ino;
 	}
 
-	inode_unlock(d_backing_inode(parent->dentry));
 	dput(d);
 	return 0;
 }
-- 
2.50.0.107.gf914562f5916.dirty


