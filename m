Return-Path: <linux-fsdevel+bounces-40477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17186A23AAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 09:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E6D16122C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 08:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41060175D47;
	Fri, 31 Jan 2025 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jd2c71Iv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01788156F4A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312326; cv=none; b=maxnsM1XO75AK/mDYzCu1Ztk+0ioNgJVsAN1uD4qgz3JNdL/XgQEA/y5TCzcP7J2S2a1tHkNDXcsRpn78wNXcuww+WzgZkEWk7r2LVwo7UOhci6/fghVqMvBp9sWKNWY0DSVPmuF6aCuE6zUfRKeHUKROnG+MSL2pJHfyL+M8D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312326; c=relaxed/simple;
	bh=UW1zjzg2YPbjnF479AmdYdZPh+fEZ5hScTteyavV/C8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SHTPx816fMdIo62Iwx7D/QhZWXY+W5w+2fyxvmfsd+EKFJJrIE0FU6iKXQrIJhOF4dVSQ31wshxaq329DWgg8e4XiYKszX1LleLGlYLtXLJgmQNSBCf/4BqXk/V7jwcpX5POtxvC5LE1Q2MjNMeV+U1oaCotCp+dlv2ZXYoIx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jd2c71Iv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=q8jbhfFbtRj2uZz8XTwG6+lJXtiJ43wtLaPHHw8jI+w=; b=jd2c71Ivus4WSmoeHqM0ZfDg3s
	PKkh/vv7w9pxJJfgSuVuMgHSEDXyPhedNzXOVYPakeopVRCq5P3x+ZD+VZ7k1WcKdiDW1gVBVa4aK
	kszDUImyPI7aYNoivwAFytmHNKedTM2MZG/PqvQrOu05ZN/64tPzb9dpDRnZCfOFhWddaNSWLUT/G
	0H1Sncaah86FnbilMjJqMI55hgxYslLeAE4S9+b2cnV5w/SVhLo5ATn2/kkVl4Dg/2es9xmh6qorA
	a/5R8mB07UHJ7gSZjNA1Q7RJaQAkHdgIZGZhGve8K0JPiGoXwtf8UkNtX9FGmFcQHaw8uNcuaJKpg
	/gueYxdQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdmRV-0000000Gm35-3oNy;
	Fri, 31 Jan 2025 08:32:01 +0000
Date: Fri, 31 Jan 2025 08:32:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH][RFC] add a string-to-qstr constructor
Message-ID: <20250131083201.GX1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[that thing sat in -next for a while, but hadn't been posted yet;
mea culpa.  Some followups for the next cycle are using it, and
it would be more convenient to get it before the next merge
window; if it gets any objections, I'll drop it from pull request
for #work.next, but it would be nice to have it in -rc1]

Quite a few places want to build a struct qstr by given string;
it would be convenient to have a primitive doing that, rather
than open-coding it via QSTR_INIT().

The closest approximation was in bcachefs, but that expands to
initializer list - {.len = strlen(string), .name = string}.
It would be more useful to have it as compound literal -
(struct qstr){.len = strlen(string), .name = string}.

Unlike initializer list it's a valid expression.  What's more,
it's a valid lvalue - it's an equivalent of anonymous local
variable with such initializer, so the things like
	path->dentry = d_alloc_pseudo(mnt->mnt_sb, &QSTR(name));
are valid.  It can also be used as initializer, with identical
effect -
	struct qstr x = (struct qstr){.name = s, .len = strlen(s)};
is equivalent to
	struct qstr anon_variable = {.name = s, .len = strlen(s)};
	struct qstr x = anon_variable;
	// anon_variable is never used after that point
and any even remotely sane compiler will manage to collapse that
into
	struct qstr x = {.name = s, .len = strlen(s)};

What compound literals can't be used for is initialization of
global variables, but those are covered by QSTR_INIT().

This commit lifts definition(s) of QSTR() into linux/dcache.h,
converts it to compound literal (all bcachefs users are fine
with that) and converts assorted open-coded instances to using
that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 42bd1cb7c9cd..583ac81669c2 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -60,14 +60,14 @@ static struct inode *anon_inode_make_secure_inode(
 	const struct inode *context_inode)
 {
 	struct inode *inode;
-	const struct qstr qname = QSTR_INIT(name, strlen(name));
 	int error;
 
 	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
 	if (IS_ERR(inode))
 		return inode;
 	inode->i_flags &= ~S_PRIVATE;
-	error =	security_inode_init_security_anon(inode, &qname, context_inode);
+	error =	security_inode_init_security_anon(inode, &QSTR(name),
+						  context_inode);
 	if (error) {
 		iput(inode);
 		return ERR_PTR(error);
diff --git a/fs/bcachefs/fsck.c b/fs/bcachefs/fsck.c
index 75c8a97a6954..7b3b63ed747c 100644
--- a/fs/bcachefs/fsck.c
+++ b/fs/bcachefs/fsck.c
@@ -405,7 +405,7 @@ static int reattach_inode(struct btree_trans *trans, struct bch_inode_unpacked *
 		return ret;
 
 	struct bch_hash_info dir_hash = bch2_hash_info_init(c, &lostfound);
-	struct qstr name = (struct qstr) QSTR(name_buf);
+	struct qstr name = QSTR(name_buf);
 
 	inode->bi_dir = lostfound.bi_inum;
 
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index 3c7f941dde39..ebabba296882 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -32,8 +32,6 @@
 #include <linux/sort.h>
 #include <linux/stat.h>
 
-#define QSTR(n) { { { .len = strlen(n) } }, .name = n }
-
 void bch2_btree_lost_data(struct bch_fs *c, enum btree_id btree)
 {
 	if (btree >= BTREE_ID_NR_MAX)
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index fb02c1c36004..a27f4b84fe77 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -647,8 +647,6 @@ static inline int cmp_le32(__le32 l, __le32 r)
 
 #include <linux/uuid.h>
 
-#define QSTR(n) { { { .len = strlen(n) } }, .name = n }
-
 static inline bool qstr_eq(const struct qstr l, const struct qstr r)
 {
 	return l.len == r.len && !memcmp(l.name, r.name, l.len);
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index a90d7d649739..60d2cf26e837 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -407,7 +407,7 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 	}
 
 	it.index = index;
-	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
+	it.name = QSTR(name);
 	if (it.name.len > EROFS_NAME_LEN)
 		return -ERANGE;
 
diff --git a/fs/file_table.c b/fs/file_table.c
index 976736be47cb..a329623d0b42 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -351,9 +351,7 @@ static struct file *alloc_file(const struct path *path, int flags,
 static inline int alloc_path_pseudo(const char *name, struct inode *inode,
 				    struct vfsmount *mnt, struct path *path)
 {
-	struct qstr this = QSTR_INIT(name, strlen(name));
-
-	path->dentry = d_alloc_pseudo(mnt->mnt_sb, &this);
+	path->dentry = d_alloc_pseudo(mnt->mnt_sb, &QSTR(name));
 	if (!path->dentry)
 		return -ENOMEM;
 	path->mnt = mntget(mnt);
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b..0eb320617d7b 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -927,7 +927,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		if (!inode)
 			continue;
 
-		name = (struct qstr)QSTR_INIT(kn->name, strlen(kn->name));
+		name = QSTR(kn->name);
 		parent = kernfs_get_parent(kn);
 		if (parent) {
 			p_inode = ilookup(info->sb, kernfs_ino(parent));
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index bff956f7b2b9..3d53a6014591 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -57,6 +57,7 @@ struct qstr {
 };
 
 #define QSTR_INIT(n,l) { { { .len = l } }, .name = n }
+#define QSTR(n) (struct qstr)QSTR_INIT(n, strlen(n))
 
 extern const struct qstr empty_name;
 extern const struct qstr slash_name;
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 399552814fd0..1b0a214ee558 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -195,14 +195,13 @@ static struct file *secretmem_file_create(unsigned long flags)
 	struct file *file;
 	struct inode *inode;
 	const char *anon_name = "[secretmem]";
-	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
 	int err;
 
 	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	err = security_inode_init_security_anon(inode, &qname, NULL);
+	err = security_inode_init_security_anon(inode, &QSTR(anon_name), NULL);
 	if (err) {
 		file = ERR_PTR(err);
 		goto err_free_inode;
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 7ce3721c06ca..eadc00410ebc 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -630,7 +630,7 @@ static int __rpc_rmpipe(struct inode *dir, struct dentry *dentry)
 static struct dentry *__rpc_lookup_create_exclusive(struct dentry *parent,
 					  const char *name)
 {
-	struct qstr q = QSTR_INIT(name, strlen(name));
+	struct qstr q = QSTR(name);
 	struct dentry *dentry = d_hash_and_lookup(parent, &q);
 	if (!dentry) {
 		dentry = d_alloc(parent, &q);
@@ -1190,8 +1190,7 @@ static const struct rpc_filelist files[] = {
 struct dentry *rpc_d_lookup_sb(const struct super_block *sb,
 			       const unsigned char *dir_name)
 {
-	struct qstr dir = QSTR_INIT(dir_name, strlen(dir_name));
-	return d_hash_and_lookup(sb->s_root, &dir);
+	return d_hash_and_lookup(sb->s_root, &QSTR(dir_name));
 }
 EXPORT_SYMBOL_GPL(rpc_d_lookup_sb);
 
@@ -1300,11 +1299,9 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 	struct dentry *gssd_dentry;
 	struct dentry *clnt_dentry = NULL;
 	struct dentry *pipe_dentry = NULL;
-	struct qstr q = QSTR_INIT(files[RPCAUTH_gssd].name,
-				  strlen(files[RPCAUTH_gssd].name));
 
 	/* We should never get this far if "gssd" doesn't exist */
-	gssd_dentry = d_hash_and_lookup(root, &q);
+	gssd_dentry = d_hash_and_lookup(root, &QSTR(files[RPCAUTH_gssd].name));
 	if (!gssd_dentry)
 		return ERR_PTR(-ENOENT);
 
@@ -1314,9 +1311,8 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 		goto out;
 	}
 
-	q.name = gssd_dummy_clnt_dir[0].name;
-	q.len = strlen(gssd_dummy_clnt_dir[0].name);
-	clnt_dentry = d_hash_and_lookup(gssd_dentry, &q);
+	clnt_dentry = d_hash_and_lookup(gssd_dentry,
+					&QSTR(gssd_dummy_clnt_dir[0].name));
 	if (!clnt_dentry) {
 		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
 		pipe_dentry = ERR_PTR(-ENOENT);

