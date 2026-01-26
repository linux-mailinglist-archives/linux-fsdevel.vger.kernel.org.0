Return-Path: <linux-fsdevel+bounces-75420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLjPDYr0dmmRZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:58:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2E884188
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DFE53068252
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 04:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477730E827;
	Mon, 26 Jan 2026 04:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kMIpJuTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8648813AA2F;
	Mon, 26 Jan 2026 04:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769403238; cv=none; b=tdiVgDOrFawMZIb0mzWEhxslk2aDZ/bdTSOpnqxkjUM5akvP8gSOrVnp+v9qDgwFiaOwsL8qcEFWreFthU1Zqm5ROtcR3pVTNCAQtqsi+uTftfhh4Crg20OJ/weWCgg1UlJgE2M1Jm6Us7T33pRsticwVnwsFrXTshw1l5SRLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769403238; c=relaxed/simple;
	bh=zaFEwUYNdEzppkBci1H95VsOoLqhqhKVurtYikKOr/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHh+VVrehgPKFJ3e9zQIef/6LpF31Mk5Uxua/A1wxr9Nsu29qM9/csHbNoiBQCXSH2LeTTo8HrBbiHlw/nYilVvGheTATXU46qYpf6FY4c9Ro8ZYoykIMlsjO8wgllkZYMtT3qtOd0EhwrsSIxxCfOHBcEMBXwn/hoYXcp+KV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kMIpJuTm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YQnSjepDKXW70OJxXp2ImkT3oZg0EF+gECmDnN8GcBM=; b=kMIpJuTm09C33lc4Duq/q9Cv7H
	DBCVPmtkcue89UAwaI9OsokNrPPj66TAIAZQ4yQPmqkxf0THS0o4G+rPYdSZ8FveiLT/nDx0GF8GK
	Vf1hk8+uq7jEE9tFcgA26gwUojkxxPQpPk3TYQ8lxLMTIrEmhKNEmTQX8iqNJQJ/ESMBIcpw3J3BP
	871TIkQuI1jNQ6rzEDyUzu5c6+95cM7YR2KeoAkqzBe91hFWSdevtlITVOulfeIakTyg/rsMaeLdF
	7N4gJ0c6twKMAtNxnlf+Jo3UrkFrbOFIJzqHmtCyD/sAQAsEmb5D1xse4x6jv60QBfBjUydr1i4IL
	oArt1iXw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkEbp-0000000BuW4-28zu;
	Mon, 26 Jan 2026 04:53:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: [PATCH 16/16] fsverity: use a hashtable to find the fsverity_info
Date: Mon, 26 Jan 2026 05:51:02 +0100
Message-ID: <20260126045212.1381843-17-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126045212.1381843-1-hch@lst.de>
References: <20260126045212.1381843-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-75420-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email,infradead.org:dkim]
X-Rspamd-Queue-Id: CD2E884188
X-Rspamd-Action: no action

Use the kernel's resizable hash table (rhashtable) to find the
fsverity_info.  This way file systems that want to support fsverity don't
have to bloat every inode in the system with an extra pointer.  The
trade-off is that looking up the fsverity_info is a bit more expensive
now, but the main operations are still dominated by I/O and hashing
overhead.

The rhashtable implementations requires no external synchronization, and
the _fast versions of the APIs provide the RCU critical sections required
by the implementation.  Because struct fsverity_info is only removed on
inode eviction and does not contain a reference count, there is no need
for an extended critical section to grab a reference or validate the
object state.  The file open path uses rhashtable_lookup_get_insert_fast,
which can either find an existing object for the hash key or insert a
new one in a single atomic operation, so that concurrent opens never
allocate duplicate fsverity_info structure.  FS_IOC_ENABLE_VERITY must
already be synchronized by a combination of i_rwsem and file system flags
and uses rhashtable_lookup_insert_fast, which errors out on an existing
object for the hash key as an additional safety check.

Because insertion into the hash table now happens before S_VERITY is set,
fsverity just becomes a barrier and a flag check and doesn't have to look
up the fsverity_info at all, so there is only a single lookup per
->read_folio or ->readahead invocation.  For btrfs there is an additional
one for each bio completion, while for ext4 and f2fs the fsverity_info
is stored in the per-I/O context and reused for the completion workqueue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h       |  4 --
 fs/btrfs/inode.c             |  3 --
 fs/btrfs/verity.c            |  2 -
 fs/ext4/ext4.h               |  4 --
 fs/ext4/super.c              |  3 --
 fs/ext4/verity.c             |  2 -
 fs/f2fs/f2fs.h               |  3 --
 fs/f2fs/super.c              |  3 --
 fs/f2fs/verity.c             |  2 -
 fs/verity/enable.c           | 30 +++++++-----
 fs/verity/fsverity_private.h | 17 +++----
 fs/verity/open.c             | 75 +++++++++++++++++++-----------
 fs/verity/verify.c           |  2 +-
 include/linux/fsverity.h     | 90 ++++++++++++------------------------
 14 files changed, 104 insertions(+), 136 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 73602ee8de3f..55c272fe5d92 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -339,10 +339,6 @@ struct btrfs_inode {
 
 	struct rw_semaphore i_mmap_lock;
 
-#ifdef CONFIG_FS_VERITY
-	struct fsverity_info *i_verity_info;
-#endif
-
 	struct inode vfs_inode;
 };
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 67c64efc5099..93b2ce75fb06 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8097,9 +8097,6 @@ static void init_once(void *foo)
 	struct btrfs_inode *ei = foo;
 
 	inode_init_once(&ei->vfs_inode);
-#ifdef CONFIG_FS_VERITY
-	ei->i_verity_info = NULL;
-#endif
 }
 
 void __cold btrfs_destroy_cachep(void)
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index c152bef71e8b..cd96fac4739f 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -795,8 +795,6 @@ static int btrfs_write_merkle_tree_block(struct file *file, const void *buf,
 }
 
 const struct fsverity_operations btrfs_verityops = {
-	.inode_info_offs         = (int)offsetof(struct btrfs_inode, i_verity_info) -
-				   (int)offsetof(struct btrfs_inode, vfs_inode),
 	.begin_enable_verity     = btrfs_begin_enable_verity,
 	.end_enable_verity       = btrfs_end_enable_verity,
 	.get_verity_descriptor   = btrfs_get_verity_descriptor,
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 56112f201cac..60c549bc894e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1205,10 +1205,6 @@ struct ext4_inode_info {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct fscrypt_inode_info *i_crypt_info;
 #endif
-
-#ifdef CONFIG_FS_VERITY
-	struct fsverity_info *i_verity_info;
-#endif
 };
 
 /*
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 86131f4d8718..1fb0c90c7a4b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1484,9 +1484,6 @@ static void init_once(void *foo)
 #ifdef CONFIG_FS_ENCRYPTION
 	ei->i_crypt_info = NULL;
 #endif
-#ifdef CONFIG_FS_VERITY
-	ei->i_verity_info = NULL;
-#endif
 }
 
 static int __init init_inodecache(void)
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 54ae4d4a176c..e3ab3ba8799b 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -380,8 +380,6 @@ static int ext4_write_merkle_tree_block(struct file *file, const void *buf,
 }
 
 const struct fsverity_operations ext4_verityops = {
-	.inode_info_offs	= (int)offsetof(struct ext4_inode_info, i_verity_info) -
-				  (int)offsetof(struct ext4_inode_info, vfs_inode),
 	.begin_enable_verity	= ext4_begin_enable_verity,
 	.end_enable_verity	= ext4_end_enable_verity,
 	.get_verity_descriptor	= ext4_get_verity_descriptor,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f2fcadc7a6fe..8ee8a7bc012c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -974,9 +974,6 @@ struct f2fs_inode_info {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct fscrypt_inode_info *i_crypt_info; /* filesystem encryption info */
 #endif
-#ifdef CONFIG_FS_VERITY
-	struct fsverity_info *i_verity_info; /* filesystem verity info */
-#endif
 };
 
 static inline void get_read_extent_info(struct extent_info *ext,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c4c225e09dc4..cd00d030edda 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -504,9 +504,6 @@ static void init_once(void *foo)
 #ifdef CONFIG_FS_ENCRYPTION
 	fi->i_crypt_info = NULL;
 #endif
-#ifdef CONFIG_FS_VERITY
-	fi->i_verity_info = NULL;
-#endif
 }
 
 #ifdef CONFIG_QUOTA
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 628e8eafa96a..4f5230d871f7 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -278,8 +278,6 @@ static int f2fs_write_merkle_tree_block(struct file *file, const void *buf,
 }
 
 const struct fsverity_operations f2fs_verityops = {
-	.inode_info_offs	= (int)offsetof(struct f2fs_inode_info, i_verity_info) -
-				  (int)offsetof(struct f2fs_inode_info, vfs_inode),
 	.begin_enable_verity	= f2fs_begin_enable_verity,
 	.end_enable_verity	= f2fs_end_enable_verity,
 	.get_verity_descriptor	= f2fs_get_verity_descriptor,
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index c56c18e2605b..94c88c419054 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -265,9 +265,24 @@ static int enable_verity(struct file *filp,
 		goto rollback;
 	}
 
+	/*
+	 * Add the fsverity_info into the hash table before finishing the
+	 * initialization so that we don't have to undo the enabling when memory
+	 * allocation for the hash table fails.  This is safe because looking up
+	 * the fsverity_info always first checks the S_VERITY flag on the inode,
+	 * which will only be set at the very end of the ->end_enable_verity
+	 * method.
+	 */
+	err = fsverity_set_info(vi);
+	if (err)
+		goto rollback;
+
 	/*
 	 * Tell the filesystem to finish enabling verity on the file.
-	 * Serialized with ->begin_enable_verity() by the inode lock.
+	 * Serialized with ->begin_enable_verity() by the inode lock.  The file
+	 * system needs to set the S_VERITY flag on the inode at the very end of
+	 * the method, at which point the fsverity information can be accessed
+	 * by other threads.
 	 */
 	inode_lock(inode);
 	err = vops->end_enable_verity(filp, desc, desc_size, params.tree_size);
@@ -275,19 +290,10 @@ static int enable_verity(struct file *filp,
 	if (err) {
 		fsverity_err(inode, "%ps() failed with err %d",
 			     vops->end_enable_verity, err);
-		fsverity_free_info(vi);
+		fsverity_remove_info(vi);
 	} else if (WARN_ON_ONCE(!IS_VERITY(inode))) {
+		fsverity_remove_info(vi);
 		err = -EINVAL;
-		fsverity_free_info(vi);
-	} else {
-		/* Successfully enabled verity */
-
-		/*
-		 * Readers can start using the inode's verity info immediately,
-		 * so it can't be rolled back once set.  So don't set it until
-		 * just after the filesystem has successfully enabled verity.
-		 */
-		fsverity_set_info(inode, vi);
 	}
 out:
 	kfree(params.hashstate);
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index f9f3936b0a89..4d4a0a560562 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) "fs-verity: " fmt
 
 #include <linux/fsverity.h>
+#include <linux/rhashtable.h>
 
 /*
  * Implementation limit: maximum depth of the Merkle tree.  For now 8 is plenty;
@@ -63,13 +64,14 @@ struct merkle_tree_params {
  * fsverity_info - cached verity metadata for an inode
  *
  * When a verity file is first opened, an instance of this struct is allocated
- * and a pointer to it is stored in the file's in-memory inode.  It remains
- * until the inode is evicted.  It caches information about the Merkle tree
- * that's needed to efficiently verify data read from the file.  It also caches
- * the file digest.  The Merkle tree pages themselves are not cached here, but
- * the filesystem may cache them.
+ * and a pointer to it is stored in the global hash table, indexed by the inode
+ * pointer value.  It remains alive until the inode is evicted.  It caches
+ * information about the Merkle tree that's needed to efficiently verify data
+ * read from the file.  It also caches the file digest.  The Merkle tree pages
+ * themselves are not cached here, but the filesystem may cache them.
  */
 struct fsverity_info {
+	struct rhash_head rhash_head;
 	struct merkle_tree_params tree_params;
 	u8 root_hash[FS_VERITY_MAX_DIGEST_SIZE];
 	u8 file_digest[FS_VERITY_MAX_DIGEST_SIZE];
@@ -127,9 +129,8 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 struct fsverity_info *fsverity_create_info(struct inode *inode,
 					   struct fsverity_descriptor *desc);
 
-void fsverity_set_info(struct inode *inode, struct fsverity_info *vi);
-
-void fsverity_free_info(struct fsverity_info *vi);
+int fsverity_set_info(struct fsverity_info *vi);
+void fsverity_remove_info(struct fsverity_info *vi);
 
 int fsverity_get_descriptor(struct inode *inode,
 			    struct fsverity_descriptor **desc_ret);
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 128502cf0a23..1bde8fe79b3f 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -12,6 +12,14 @@
 #include <linux/slab.h>
 
 static struct kmem_cache *fsverity_info_cachep;
+static struct rhashtable fsverity_info_hash;
+
+static const struct rhashtable_params fsverity_info_hash_params = {
+	.key_len		= sizeof_field(struct fsverity_info, inode),
+	.key_offset		= offsetof(struct fsverity_info, inode),
+	.head_offset		= offsetof(struct fsverity_info, rhash_head),
+	.automatic_shrinking	= true,
+};
 
 /**
  * fsverity_init_merkle_tree_params() - initialize Merkle tree parameters
@@ -170,6 +178,13 @@ static void compute_file_digest(const struct fsverity_hash_alg *hash_alg,
 	desc->sig_size = sig_size;
 }
 
+static void fsverity_free_info(struct fsverity_info *vi)
+{
+	kfree(vi->tree_params.hashstate);
+	kvfree(vi->hash_block_verified);
+	kmem_cache_free(fsverity_info_cachep, vi);
+}
+
 /*
  * Create a new fsverity_info from the given fsverity_descriptor (with optional
  * appended builtin signature), and check the signature if present.  The
@@ -241,33 +256,18 @@ struct fsverity_info *fsverity_create_info(struct inode *inode,
 	return ERR_PTR(err);
 }
 
-void fsverity_set_info(struct inode *inode, struct fsverity_info *vi)
+int fsverity_set_info(struct fsverity_info *vi)
 {
-	/*
-	 * Multiple tasks may race to set the inode's verity info pointer, so
-	 * use cmpxchg_release().  This pairs with the smp_load_acquire() in
-	 * fsverity_get_info().  I.e., publish the pointer with a RELEASE
-	 * barrier so that other tasks can ACQUIRE it.
-	 */
-	if (cmpxchg_release(fsverity_info_addr(inode), NULL, vi) != NULL) {
-		/* Lost the race, so free the verity info we allocated. */
-		fsverity_free_info(vi);
-		/*
-		 * Afterwards, the caller may access the inode's verity info
-		 * directly, so make sure to ACQUIRE the winning verity info.
-		 */
-		(void)fsverity_get_info(inode);
-	}
+	return rhashtable_lookup_insert_fast(&fsverity_info_hash,
+			&vi->rhash_head, fsverity_info_hash_params);
 }
 
-void fsverity_free_info(struct fsverity_info *vi)
+struct fsverity_info *__fsverity_get_info(const struct inode *inode)
 {
-	if (!vi)
-		return;
-	kfree(vi->tree_params.hashstate);
-	kvfree(vi->hash_block_verified);
-	kmem_cache_free(fsverity_info_cachep, vi);
+	return rhashtable_lookup_fast(&fsverity_info_hash, &inode,
+			fsverity_info_hash_params);
 }
+EXPORT_SYMBOL_GPL(__fsverity_get_info);
 
 static bool validate_fsverity_descriptor(struct inode *inode,
 					 const struct fsverity_descriptor *desc,
@@ -352,7 +352,7 @@ int fsverity_get_descriptor(struct inode *inode,
 
 static int ensure_verity_info(struct inode *inode)
 {
-	struct fsverity_info *vi = fsverity_get_info(inode);
+	struct fsverity_info *vi = fsverity_get_info(inode), *found;
 	struct fsverity_descriptor *desc;
 	int err;
 
@@ -369,8 +369,18 @@ static int ensure_verity_info(struct inode *inode)
 		goto out_free_desc;
 	}
 
-	fsverity_set_info(inode, vi);
-	err = 0;
+	/*
+	 * Multiple tasks may race to set the inode's verity info, in which case
+	 * we might find an existing fsverity_info in the hash table.
+	 */
+	found = rhashtable_lookup_get_insert_fast(&fsverity_info_hash,
+			&vi->rhash_head, fsverity_info_hash_params);
+	if (found) {
+		fsverity_free_info(vi);
+		if (IS_ERR(found))
+			err = PTR_ERR(found);
+	}
+
 out_free_desc:
 	kfree(desc);
 	return err;
@@ -384,16 +394,25 @@ int __fsverity_file_open(struct inode *inode, struct file *filp)
 }
 EXPORT_SYMBOL_GPL(__fsverity_file_open);
 
+void fsverity_remove_info(struct fsverity_info *vi)
+{
+	rhashtable_remove_fast(&fsverity_info_hash, &vi->rhash_head,
+			fsverity_info_hash_params);
+	fsverity_free_info(vi);
+}
+
 void fsverity_cleanup_inode(struct inode *inode)
 {
-	struct fsverity_info **vi_addr = fsverity_info_addr(inode);
+	struct fsverity_info *vi = fsverity_get_info(inode);
 
-	fsverity_free_info(*vi_addr);
-	*vi_addr = NULL;
+	if (vi)
+		fsverity_remove_info(vi);
 }
 
 void __init fsverity_init_info_cache(void)
 {
+	if (rhashtable_init(&fsverity_info_hash, &fsverity_info_hash_params))
+		panic("failed to initialize fsverity hash\n");
 	fsverity_info_cachep = KMEM_CACHE_USERCOPY(
 					fsverity_info,
 					SLAB_RECLAIM_ACCOUNT | SLAB_PANIC,
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 57aea5a2a0ee..75b997a936c7 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -320,7 +320,7 @@ fsverity_init_verification_context(struct fsverity_verification_context *ctx,
 	ctx->inode = vi->inode;
 	ctx->vi = vi;
 	ctx->num_pending = 0;
-	if (vi->tree_params.hash_alg->algo_id == HASH_ALGO_SHA256 &&
+	if (ctx->vi->tree_params.hash_alg->algo_id == HASH_ALGO_SHA256 &&
 	    sha256_finup_2x_is_optimized())
 		ctx->max_pending = 2;
 	else
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 1d70b270e90a..c8958971f65a 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -30,13 +30,6 @@ struct fsverity_info;
 
 /* Verity operations for filesystems */
 struct fsverity_operations {
-	/**
-	 * The offset of the pointer to struct fsverity_info in the
-	 * filesystem-specific part of the inode, relative to the beginning of
-	 * the common part of the inode (the 'struct inode').
-	 */
-	ptrdiff_t inode_info_offs;
-
 	/**
 	 * Begin enabling verity on the given file.
 	 *
@@ -142,40 +135,6 @@ struct fsverity_operations {
 };
 
 #ifdef CONFIG_FS_VERITY
-
-/*
- * Returns the address of the verity info pointer within the filesystem-specific
- * part of the inode.  (To save memory on filesystems that don't support
- * fsverity, a field in 'struct inode' itself is no longer used.)
- */
-static inline struct fsverity_info **
-fsverity_info_addr(const struct inode *inode)
-{
-	VFS_WARN_ON_ONCE(inode->i_sb->s_vop->inode_info_offs == 0);
-	return (void *)inode + inode->i_sb->s_vop->inode_info_offs;
-}
-
-static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
-{
-	/*
-	 * Since this function can be called on inodes belonging to filesystems
-	 * that don't support fsverity at all, and fsverity_info_addr() doesn't
-	 * work on such filesystems, we have to start with an IS_VERITY() check.
-	 * Checking IS_VERITY() here is also useful to minimize the overhead of
-	 * fsverity_active() on non-verity files.
-	 */
-	if (!IS_VERITY(inode))
-		return NULL;
-
-	/*
-	 * Pairs with the cmpxchg_release() in fsverity_set_info().  I.e.,
-	 * another task may publish the inode's verity info concurrently,
-	 * executing a RELEASE barrier.  Use smp_load_acquire() here to safely
-	 * ACQUIRE the memory the other task published.
-	 */
-	return smp_load_acquire(fsverity_info_addr(inode));
-}
-
 /* enable.c */
 
 int fsverity_ioctl_enable(struct file *filp, const void __user *arg);
@@ -204,18 +163,6 @@ void fsverity_enqueue_verify_work(struct work_struct *work);
 
 #else /* !CONFIG_FS_VERITY */
 
-/*
- * Provide a stub to allow code using this to compile.  All callsites should be
- * guarded by compiler dead code elimination, and this forces a link error if
- * not.
- */
-struct fsverity_info **fsverity_info_addr(const struct inode *inode);
-
-static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
-{
-	return NULL;
-}
-
 /* enable.c */
 
 static inline int fsverity_ioctl_enable(struct file *filp,
@@ -296,18 +243,39 @@ static inline bool fsverity_verify_page(struct fsverity_info *vi,
  * fsverity_active() - do reads from the inode need to go through fs-verity?
  * @inode: inode to check
  *
- * This checks whether the inode's verity info has been set.
- *
- * Filesystems call this from ->readahead() to check whether the pages need to
- * be verified or not.  Don't use IS_VERITY() for this purpose; it's subject to
- * a race condition where the file is being read concurrently with
- * FS_IOC_ENABLE_VERITY completing.  (S_VERITY is set before the verity info.)
+ * This checks whether the inode's verity info has been set, and reads need
+ * to verify the verity information.
  *
  * Return: true if reads need to go through fs-verity, otherwise false
  */
-static inline bool fsverity_active(const struct inode *inode)
+static __always_inline bool fsverity_active(const struct inode *inode)
+{
+	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode)) {
+		/*
+		 * This pairs with the try_cmpxchg in set_mask_bits()
+		 * used to set the S_VERITY bit in i_flags.
+		 */
+		smp_mb();
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * fsverity_get_info - get fsverity information for an inode
+ * @inode: inode to operate on.
+ *
+ * This gets the fsverity_info for @inode if it exists.  Safe to call without
+ * knowin that a fsverity_info exist for @inode, including on file systems that
+ * do not support fsverity.
+ */
+struct fsverity_info *__fsverity_get_info(const struct inode *inode);
+static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 {
-	return fsverity_get_info(inode) != NULL;
+	if (!fsverity_active(inode))
+		return NULL;
+	return __fsverity_get_info(inode);
 }
 
 /**
-- 
2.47.3


