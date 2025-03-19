Return-Path: <linux-fsdevel+bounces-44406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42222A6839A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 04:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F1E7ABCE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 03:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DD424E010;
	Wed, 19 Mar 2025 03:16:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F227B20CCD6;
	Wed, 19 Mar 2025 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742354170; cv=none; b=fz2eTWEf1GNTK/zL6zNTC5Vow1XdHwLq+zq+Q12Zl1tdl3FUXvVpTJx0yFeiTZ9X8kyFkZ2BUPwXsJBIlJ0hsO2CO5ndJjQ1x5aXUGcL1ya+foDv18reNVuWPSfBIbK1nf0fWZDyU2htBZ0f1MTCBWlvSXkvyukQgwKNI6P7n7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742354170; c=relaxed/simple;
	bh=3x7wDQfm5TEXpoA1bSFNwJuCTn7lEwpUWFhzLb2+vt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJgBQt1yTimJk7sdGhLr7FN0PTlQOnSr2eGbR1i8rj7gaYg2IbA+JPjORy29gj+JtQa7JwJ31KOLn4+dqiuGlmWCJFC/UdevJU5DYnGNBWnGQz3SMlDMoXr45jTnfJhPpOwhpTqoBbbE3GndQjA9hUzrnj4m9LejZgIdsgZBoeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tujuO-00G6om-LT;
	Wed, 19 Mar 2025 03:15:56 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/6] cachefiles: Use lookup_one() rather than lookup_one_len()
Date: Wed, 19 Mar 2025 14:01:34 +1100
Message-ID: <20250319031545.2999807-4-neil@brown.name>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319031545.2999807-1-neil@brown.name>
References: <20250319031545.2999807-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

cachefiles uses some VFS interfaces (such as vfs_mkdir) which take an
explicit mnt_idmap, and it passes &nop_mnt_idmap as cachefiles doesn't
yet support idmapped mounts.

It also uses the lookup_one_len() family of functions which implicitly
use &nop_mnt_idmap.  This mixture of implicit and explicit could be
confusing.  When we eventually update cachefiles to support idmap mounts it
would be best if all places which need an idmap determined from the
mount point were similar and easily found.

So this patch changes cachefiles to use lookup_one(), lookup_one_unlocked(),
and lookup_one_positive_unlocked(), passing &nop_mnt_idmap.

This has the benefit of removing the remaining user of the
lookup_one_len functions where permission checking is actually needed.
Other callers don't care about permission checking and using these
function only where permission checking is needed is a valuable
simplification.

This requires passing the name in a qstr.  This is easily done with
QSTR() as the name is always nul terminated, and often strlen is used
anyway.  ->d_name_len is removed as no longer useful.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/cachefiles/internal.h |  1 -
 fs/cachefiles/key.c      |  1 -
 fs/cachefiles/namei.c    | 14 +++++++-------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 38c236e38cef..b62cd3e9a18e 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -71,7 +71,6 @@ struct cachefiles_object {
 	int				debug_id;
 	spinlock_t			lock;
 	refcount_t			ref;
-	u8				d_name_len;	/* Length of filename */
 	enum cachefiles_content		content_info:8;	/* Info about content presence */
 	unsigned long			flags;
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
index bf935e25bdbe..4927b533b9ae 100644
--- a/fs/cachefiles/key.c
+++ b/fs/cachefiles/key.c
@@ -132,7 +132,6 @@ bool cachefiles_cook_key(struct cachefiles_object *object)
 success:
 	name[len] = 0;
 	object->d_name = name;
-	object->d_name_len = len;
 	_leave(" = %s", object->d_name);
 	return true;
 }
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 83a60126de0f..4fc6f3efd3d9 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -98,7 +98,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 retry:
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
-		subdir = lookup_one_len(dirname, dir, strlen(dirname));
+		subdir = lookup_one(&nop_mnt_idmap, QSTR(dirname), dir);
 	else
 		subdir = ERR_PTR(ret);
 	trace_cachefiles_lookup(NULL, dir, subdir);
@@ -337,7 +337,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		return -EIO;
 	}
 
-	grave = lookup_one_len(nbuffer, cache->graveyard, strlen(nbuffer));
+	grave = lookup_one(&nop_mnt_idmap, QSTR(nbuffer), cache->graveyard);
 	if (IS_ERR(grave)) {
 		unlock_rename(cache->graveyard, dir);
 		trace_cachefiles_vfs_error(object, d_inode(cache->graveyard),
@@ -629,8 +629,8 @@ bool cachefiles_look_up_object(struct cachefiles_object *object)
 	/* Look up path "cache/vol/fanout/file". */
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
-		dentry = lookup_positive_unlocked(object->d_name, fan,
-						  object->d_name_len);
+		dentry = lookup_one_positive_unlocked(&nop_mnt_idmap,
+						      QSTR(object->d_name), fan);
 	else
 		dentry = ERR_PTR(ret);
 	trace_cachefiles_lookup(object, fan, dentry);
@@ -682,7 +682,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
-		dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+		dentry = lookup_one(&nop_mnt_idmap, QSTR(object->d_name), fan);
 	else
 		dentry = ERR_PTR(ret);
 	if (IS_ERR(dentry)) {
@@ -701,7 +701,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 		dput(dentry);
 		ret = cachefiles_inject_read_error();
 		if (ret == 0)
-			dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+			dentry = lookup_one(&nop_mnt_idmap, QSTR(object->d_name), fan);
 		else
 			dentry = ERR_PTR(ret);
 		if (IS_ERR(dentry)) {
@@ -750,7 +750,7 @@ static struct dentry *cachefiles_lookup_for_cull(struct cachefiles_cache *cache,
 
 	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
 
-	victim = lookup_one_len(filename, dir, strlen(filename));
+	victim = lookup_one(&nop_mnt_idmap, QSTR(filename), dir);
 	if (IS_ERR(victim))
 		goto lookup_error;
 	if (d_is_negative(victim))
-- 
2.48.1


