Return-Path: <linux-fsdevel+bounces-59723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56082B3D4D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 21:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF901891FA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 19:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEC427466A;
	Sun, 31 Aug 2025 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="jPpdwwJT";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="hTbUsUv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAD81AF0A7
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Aug 2025 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756667888; cv=none; b=QRxRKg/MZLRL0VAlbUO0wHk/+MvRYhYP0AVEbAtj6T2camHNI3IapIuNRd/Vwb0CshFdIYBbdo4vAEa4sNXbvJ5zYa2cEfTuJ+17FdJMGcvJoFxTwEoYHjTrfIhEHrFWPsl4yH3wdK6rB8ZPHEgOkohZJkqAATt3S16cHNFBGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756667888; c=relaxed/simple;
	bh=7Y5KqttihI+r+eIyOPXHXseKUiV7iTVerANDkbrxnys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHHuWA1+oSwnwLW+/3RDpnlikeToucznhhn/MSPyvdwb/U5+ba8ff/drZBBf0qDxJoRsdCta3UlDghH8XL+HDeO2KO4lVNHX1X8dwmvCqxdATpaRS/kQKfKJQ5oveyhDSxJeCwI037n18lJuZIQs3olS67NErrAXcPcxcNmgSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=jPpdwwJT reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=hTbUsUv/; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756668786; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=+gS5MCHjHXroUzVHejQaS9odp4wq+hOBaBf9jbC5Dyw=; b=jPpdwwJTJEQdJhE6WrlNU3qgQE
	xSuTiji1aWcQoElLzFhSpXTFp2lYDt9zRaIb8/cG+dxnndmcj9EOwQBX4z7a3YldYHEOIrPaXyw51
	JP/ipgeAQcvXv75F0UBFBuaifXyuck6lZYwi8xJxfEhD4Jz+8tLSsk4KdKsyhY+xNl/h7Ed6oFhb2
	H3kBgwvdy0LQsiqIjk/dHjUiPGnGcIoWbBa6gSre2rrINPCoBsppM2kMmlx7z+2OKmPL6F7yWyvJf
	6cbGKEaOETSoRCvDeBqr7OBqiuWmNn5pAOQrP6uQ0rPTgKNsWIolMA7RL7iGM5zcBABJYgTGfmiIc
	TC9NuhKw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756667886; h=from : subject
 : to : message-id : date;
 bh=+gS5MCHjHXroUzVHejQaS9odp4wq+hOBaBf9jbC5Dyw=;
 b=hTbUsUv/6EFPOkPvsNcdyVwBegqIYm7FIn+cIWD18nySe2zYwy+Iy5881Ba4Z/aNQhS5C
 Jd98sVnbK2aM0Le8/E6aZyEh33hWETGyRqRP8hhw7eePzBluN7OfnX1J5lEY1qnC62UXAYE
 54CBTAzVG+zhrxJxOb10Sm8gnE27sX19fJxMOmYnSd+l53xsHRTwkfihIEw4evEbShfHv+E
 JSmq00bP5HLxl358EGv7lhgfyEUt5DPPcwk6WBTUeO8HKt3RgobpmfQ6owDW31IAxBGGzXX
 E/K3AHqR3aG8YVLDmwBHKzSNcrk5jPK17GvKJ2/cKzehNYPhbIWD3q5SCDeA==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYq-TRk4FT-AD; Sun, 31 Aug 2025 19:17:56 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYq-4o5NDgrhYf4-kAZD; Sun, 31 Aug 2025 19:17:56 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 1/5] 9p: Cache negative dentries for lookup performance
Date: Sun, 31 Aug 2025 21:03:39 +0200
Message-ID: <0bd395b21e556734ce242d55e1fbf5b4bc0936ac.1756635044.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756635044.git.repk@triplefau.lt>
References: <cover.1756635044.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: Jdn-URaw_dA5.GOPXDorO5IKU.0AqDigqXPQS
Feedback-ID: 510616m:510616apGKSTK:510616sgLZ4k01cp
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Not caching negative dentries can result in poor performance for
workloads that repeatedly look up non-existent paths. Each such
lookup triggers a full 9P transaction with the server, adding
unnecessary overhead.

A typical example is source compilation, where multiple cc1 processes
are spawned and repeatedly search for the same missing header files
over and over again.

This change enables caching of negative dentries, so that lookups for
known non-existent paths do not require a full 9P transaction. The
cached negative dentries are retained for a configurable duration
(expressed in milliseconds), as specified by the ndentry_timeout
field in struct v9fs_session_info. If set to -1, negative dentries
are cached indefinitely.

This optimization reduces lookup overhead and improves performance for
workloads involving frequent access to non-existent paths.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/fid.c        |  11 ++---
 fs/9p/v9fs.c       |   1 +
 fs/9p/v9fs.h       |   2 +
 fs/9p/v9fs_vfs.h   |  15 +++++++
 fs/9p/vfs_dentry.c | 109 +++++++++++++++++++++++++++++++++++++++------
 fs/9p/vfs_inode.c  |   7 +--
 6 files changed, 123 insertions(+), 22 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index f84412290a30..76242d450aa7 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -20,7 +20,9 @@
 
 static inline void __add_fid(struct dentry *dentry, struct p9_fid *fid)
 {
-	hlist_add_head(&fid->dlist, (struct hlist_head *)&dentry->d_fsdata);
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
+
+	hlist_add_head(&fid->dlist, &v9fs_dentry->head);
 }
 
 
@@ -112,6 +114,7 @@ void v9fs_open_fid_add(struct inode *inode, struct p9_fid **pfid)
 
 static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 {
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
 	struct p9_fid *fid, *ret;
 
 	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p) uid %d any %d\n",
@@ -119,11 +122,9 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 		 any);
 	ret = NULL;
 	/* we'll recheck under lock if there's anything to look in */
-	if (dentry->d_fsdata) {
-		struct hlist_head *h = (struct hlist_head *)&dentry->d_fsdata;
-
+	if (!hlist_empty(&v9fs_dentry->head)) {
 		spin_lock(&dentry->d_lock);
-		hlist_for_each_entry(fid, h, dlist) {
+		hlist_for_each_entry(fid, &v9fs_dentry->head, dlist) {
 			if (any || uid_eq(fid->uid, uid)) {
 				ret = fid;
 				p9_fid_get(ret);
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 77e9c4387c1d..422bd720d165 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -171,6 +171,7 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 
 	/* setup defaults */
 	v9ses->afid = ~0;
+	v9ses->ndentry_timeout = 0;
 	v9ses->debug = 0;
 	v9ses->cache = CACHE_NONE;
 #ifdef CONFIG_9P_FSCACHE
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index f28bc763847a..8c5fa0f7ba71 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -88,6 +88,7 @@ enum p9_cache_bits {
  * @debug: debug level
  * @afid: authentication handle
  * @cache: cache mode of type &p9_cache_bits
+ * @ndentry_timeout: Negative dentry lookup cache retention time in ms
  * @cachetag: the tag of the cache associated with this session
  * @fscache: session cookie associated with FS-Cache
  * @uname: string user name to mount hierarchy as
@@ -113,6 +114,7 @@ struct v9fs_session_info {
 	unsigned short debug;
 	unsigned int afid;
 	unsigned int cache;
+	unsigned int ndentry_timeout;
 #ifdef CONFIG_9P_FSCACHE
 	char *cachetag;
 	struct fscache_volume *fscache;
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index d3aefbec4de6..7e6e8881081c 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -28,6 +28,19 @@
 /* flags for v9fs_stat2inode() & v9fs_stat2inode_dotl() */
 #define V9FS_STAT2INODE_KEEP_ISIZE 1
 
+/**
+ * struct v9fs_dentry - v9fs specific dentry data
+ * @head: List of fid associated with this dentry
+ * @expire_time: Lookup cache expiration time for negative dentries
+ * @rcu: used by kfree_rcu to schedule clean up job
+ */
+struct v9fs_dentry {
+	struct hlist_head head;
+	u64 expire_time;
+	struct rcu_head rcu;
+};
+#define to_v9fs_dentry(d) ((struct v9fs_dentry *)((d)->d_fsdata))
+
 extern struct file_system_type v9fs_fs_type;
 extern const struct address_space_operations v9fs_addr_operations;
 extern const struct file_operations v9fs_file_operations;
@@ -35,6 +48,8 @@ extern const struct file_operations v9fs_file_operations_dotl;
 extern const struct file_operations v9fs_dir_operations;
 extern const struct file_operations v9fs_dir_operations_dotl;
 extern const struct dentry_operations v9fs_dentry_operations;
+extern void v9fs_dentry_refresh(struct dentry *dentry);
+extern void v9fs_dentry_fid_remove(struct dentry *dentry);
 extern const struct dentry_operations v9fs_cached_dentry_operations;
 extern struct kmem_cache *v9fs_inode_cache;
 
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 04795508a795..5035b8c749e2 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -23,6 +23,46 @@
 #include "v9fs_vfs.h"
 #include "fid.h"
 
+/**
+ * v9fs_dentry_is_expired - Check if dentry lookup has expired
+ *
+ * This should be called to know if a negative dentry should be removed from
+ * cache.
+ *
+ * @dentry: dentry in question
+ *
+ */
+static bool v9fs_dentry_is_expired(struct dentry const *dentry)
+{
+	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
+
+	if (v9ses->ndentry_timeout == -1)
+		return false;
+
+	return time_before_eq64(v9fs_dentry->expire_time, get_jiffies_64());
+}
+
+/**
+ * v9fs_dentry_refresh - Refresh dentry lookup cache timeout
+ *
+ * This should be called when a look up yields a negative entry.
+ *
+ * @dentry: dentry in question
+ *
+ */
+void v9fs_dentry_refresh(struct dentry *dentry)
+{
+	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
+
+	if (v9ses->ndentry_timeout == -1)
+		return;
+
+	v9fs_dentry->expire_time = get_jiffies_64() +
+				   msecs_to_jiffies(v9ses->ndentry_timeout);
+}
+
 /**
  * v9fs_cached_dentry_delete - called when dentry refcount equals 0
  * @dentry:  dentry in question
@@ -33,20 +73,15 @@ static int v9fs_cached_dentry_delete(const struct dentry *dentry)
 	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p)\n",
 		 dentry, dentry);
 
-	/* Don't cache negative dentries */
-	if (d_really_is_negative(dentry))
-		return 1;
-	return 0;
-}
+	if (!d_really_is_negative(dentry))
+		return 0;
 
-/**
- * v9fs_dentry_release - called when dentry is going to be freed
- * @dentry:  dentry that is being release
- *
- */
+	return v9fs_dentry_is_expired(dentry);
+}
 
-static void v9fs_dentry_release(struct dentry *dentry)
+static void __v9fs_dentry_fid_remove(struct dentry *dentry)
 {
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
 	struct hlist_node *p, *n;
 	struct hlist_head head;
 
@@ -54,15 +89,57 @@ static void v9fs_dentry_release(struct dentry *dentry)
 		 dentry, dentry);
 
 	spin_lock(&dentry->d_lock);
-	hlist_move_list((struct hlist_head *)&dentry->d_fsdata, &head);
+	hlist_move_list(&v9fs_dentry->head, &head);
 	spin_unlock(&dentry->d_lock);
 
 	hlist_for_each_safe(p, n, &head)
 		p9_fid_put(hlist_entry(p, struct p9_fid, dlist));
 }
 
+/**
+ * v9fs_dentry_fid_remove - Release all dentry's fid
+ * @dentry: dentry in question
+ *
+ */
+void v9fs_dentry_fid_remove(struct dentry *dentry)
+{
+	__v9fs_dentry_fid_remove(dentry);
+}
+
+/**
+ * v9fs_dentry_init - Initialize v9fs dentry data
+ * @dentry: dentry in question
+ *
+ */
+static int v9fs_dentry_init(struct dentry *dentry)
+{
+	struct v9fs_dentry *v9fs_dentry = kzalloc(sizeof(*v9fs_dentry),
+						  GFP_KERNEL);
+
+	if (!v9fs_dentry)
+		return -ENOMEM;
+
+	INIT_HLIST_HEAD(&v9fs_dentry->head);
+	dentry->d_fsdata = (void *)v9fs_dentry;
+	return 0;
+}
+
+/**
+ * v9fs_dentry_release - called when dentry is going to be freed
+ * @dentry:  dentry that is being release
+ *
+ */
+static void v9fs_dentry_release(struct dentry *dentry)
+{
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
+
+	__v9fs_dentry_fid_remove(dentry);
+	kfree_rcu(v9fs_dentry, rcu);
+}
+
 static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 {
+	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid;
 	struct inode *inode;
 	struct v9fs_inode *v9inode;
@@ -70,9 +147,11 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
+	v9ses = v9fs_dentry2v9ses(dentry);
+
 	inode = d_inode(dentry);
 	if (!inode)
-		goto out_valid;
+		return !v9fs_dentry_is_expired(dentry);
 
 	v9inode = V9FS_I(inode);
 	if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
@@ -95,7 +174,7 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 		if (retval < 0)
 			return retval;
 	}
-out_valid:
+
 	return 1;
 }
 
@@ -121,12 +200,14 @@ const struct dentry_operations v9fs_cached_dentry_operations = {
 	.d_revalidate = v9fs_lookup_revalidate,
 	.d_weak_revalidate = __v9fs_lookup_revalidate,
 	.d_delete = v9fs_cached_dentry_delete,
+	.d_init = v9fs_dentry_init,
 	.d_release = v9fs_dentry_release,
 	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
 	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
 };
 
 const struct dentry_operations v9fs_dentry_operations = {
+	.d_init = v9fs_dentry_init,
 	.d_release = v9fs_dentry_release,
 	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
 	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 399d455d50d6..89eeb2b3ba43 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -549,7 +549,7 @@ static int v9fs_remove(struct inode *dir, struct dentry *dentry, int flags)
 
 		/* invalidate all fids associated with dentry */
 		/* NOTE: This will not include open fids */
-		dentry->d_op->d_release(dentry);
+		v9fs_dentry_fid_remove(dentry);
 	}
 	return retval;
 }
@@ -732,9 +732,10 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 	name = dentry->d_name.name;
 	fid = p9_client_walk(dfid, 1, &name, 1);
 	p9_fid_put(dfid);
-	if (fid == ERR_PTR(-ENOENT))
+	if (fid == ERR_PTR(-ENOENT)) {
 		inode = NULL;
-	else if (IS_ERR(fid))
+		v9fs_dentry_refresh(dentry);
+	} else if (IS_ERR(fid))
 		inode = ERR_CAST(fid);
 	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
 		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
-- 
2.50.1


