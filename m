Return-Path: <linux-fsdevel+bounces-43991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D0BA60823
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 05:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23557178927
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 04:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533B515199B;
	Fri, 14 Mar 2025 04:57:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C522F4A;
	Fri, 14 Mar 2025 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741928232; cv=none; b=MSuwj4j2KuQVWG1J3lJynoPlA6mdfwbQw2YGXQ7/5OPuW1lxsvcUDWpDNkKd64xXAodMohsHTazFe6AX2oNj245f3B1l/orxbEi6F4ZWxE3k0KBM6/R2iZb3o3fQtn14aBXlbZQjgWbrb5fzA6VAlxyAFrm+ExT/7+qH12Me3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741928232; c=relaxed/simple;
	bh=eHbtHUb3kGJx/y1SzBRJaZfmnTOd8qT4RhDO0gFksWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLu1VIrNUYFUTopaViGpKsDrVXe/hcedaEg9UHx4/qE42K1yItv4g48KbWr4GfjaWf8flMshOSCHKcX6V45JkRPIKDO9kY2VWAlyiJ5hCv+DvMBT9hOqiarsVHLcix9BpGYA1zBEKBBpYQZpqxLjUye1wogquQMSOCdxeAul0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tsx6Y-00E3vp-LW;
	Fri, 14 Mar 2025 04:57:06 +0000
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
Subject: [PATCH 4/8] cachefiles: Use lookup_one() rather than lookup_one_len()
Date: Fri, 14 Mar 2025 11:34:10 +1100
Message-ID: <20250314045655.603377-5-neil@brown.name>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314045655.603377-1-neil@brown.name>
References: <20250314045655.603377-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lookup_one_len() does not support idmapped mounts and does permission
checking on the non-mapped uids.  This means that cachefiles cannot
correctly use idmapped mounts as a backing store.

This patch changes to use lookup_one() and lookup_one_positive_unlocked(),
passing the relevant vfsmount so idmapping can be honoured.

This requires passing the name in a qstr.  This is easily done with
QSTR() as the name is always nul terminated, and often strlen is used
anyway.  ->d_name_len is removed as no longer useful.

Note that there are still many places where cachefiles uses
nop_mnt_idmap so more work is needed to properly support idmapped
mounts.

Signed-off-by: NeilBrown <neil@brown.name>
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
index 83a60126de0f..a440a2ff5d41 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -98,7 +98,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 retry:
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
-		subdir = lookup_one_len(dirname, dir, strlen(dirname));
+		subdir = lookup_one(cache->mnt, QSTR(dirname), dir);
 	else
 		subdir = ERR_PTR(ret);
 	trace_cachefiles_lookup(NULL, dir, subdir);
@@ -337,7 +337,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		return -EIO;
 	}
 
-	grave = lookup_one_len(nbuffer, cache->graveyard, strlen(nbuffer));
+	grave = lookup_one(cache->mnt, QSTR(nbuffer), cache->graveyard);
 	if (IS_ERR(grave)) {
 		unlock_rename(cache->graveyard, dir);
 		trace_cachefiles_vfs_error(object, d_inode(cache->graveyard),
@@ -629,8 +629,8 @@ bool cachefiles_look_up_object(struct cachefiles_object *object)
 	/* Look up path "cache/vol/fanout/file". */
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
-		dentry = lookup_positive_unlocked(object->d_name, fan,
-						  object->d_name_len);
+		dentry = lookup_one_positive_unlocked(volume->cache->mnt,
+						      QSTR(object->d_name), fan);
 	else
 		dentry = ERR_PTR(ret);
 	trace_cachefiles_lookup(object, fan, dentry);
@@ -682,7 +682,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
-		dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+		dentry = lookup_one(cache->mnt, QSTR(object->d_name), fan);
 	else
 		dentry = ERR_PTR(ret);
 	if (IS_ERR(dentry)) {
@@ -701,7 +701,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 		dput(dentry);
 		ret = cachefiles_inject_read_error();
 		if (ret == 0)
-			dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+			dentry = lookup_one(cache->mnt, QSTR(object->d_name), fan);
 		else
 			dentry = ERR_PTR(ret);
 		if (IS_ERR(dentry)) {
@@ -750,7 +750,7 @@ static struct dentry *cachefiles_lookup_for_cull(struct cachefiles_cache *cache,
 
 	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
 
-	victim = lookup_one_len(filename, dir, strlen(filename));
+	victim = lookup_one(cache->mnt, QSTR(filename), dir);
 	if (IS_ERR(victim))
 		goto lookup_error;
 	if (d_is_negative(victim))
-- 
2.48.1


