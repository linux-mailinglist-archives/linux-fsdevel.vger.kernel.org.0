Return-Path: <linux-fsdevel+bounces-58517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C66B2EA34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFCB1CC48C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFDD1F78E6;
	Thu, 21 Aug 2025 01:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7ns1de9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107C55FEE6;
	Thu, 21 Aug 2025 01:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738739; cv=none; b=k4IhtBpJH0qq1kHy7QzlqdGqP75fwCI0rutarXoTY6kVn2Ohy29tVK70NumejshN9bwqWLvrru2sK8b0B9pJpmRF3yy/+VF8+Lls/6DVdzUH3egYyJzjVkPHH6jTWKzIYBm/+101tbLjnQqswhmajznscRTkT67XNqL4AC5pBFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738739; c=relaxed/simple;
	bh=0SGWTpy5xTWX3Zmq8jfPyszjV38dEnguVkjYljXc0TQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4U5lHYeSEH7qKWj5u5F4L0/oS4iLAFDoJaKBnveh7yAd8vpNBIm5w7rP6lgGDi8mB5MPejiF4p8B300qE2Ir2W4hl0svyIXjXxOLCl5u6/uUGQ33rK8sgOYG4sfF/JdR1EUuqi7vw23gZJECukiU4Kr0QNPY9kdcoNcPaAtolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7ns1de9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7630C4CEE7;
	Thu, 21 Aug 2025 01:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738738;
	bh=0SGWTpy5xTWX3Zmq8jfPyszjV38dEnguVkjYljXc0TQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=m7ns1de9H6T0bcFjOBnkZlnHQvNPDoNcLcpcLDyfP9Zf3kjtsPowldcO5p2G6ceZQ
	 O8oyUrxOXc0FAZ1aSy5fY7VueFL8JPWfWWRgcK4n3S1q78+zU4h+NgJEi+PTs74TIO
	 r0a6GRyzmTHhJ9V0ysXobwVoT3AZ/PUQPVqRbLtoi0BbBvOzS/1stqW+EZwm3vYl4y
	 kcB4kxF7tU+f2thRiDzpNaxMbDYERYUzY8sgKd3PCvk46KsiWYSiM6BJgBz+5xtEcY
	 kQnh9GOGXewDLqK1XfGLyyREVBW/CTOdgLEvDsHmLmHfxPNtXMfbLB171oE+93/0jA
	 OvtEUxElS4SVA==
Date: Wed, 20 Aug 2025 18:12:18 -0700
Subject: [PATCH 17/20] fuse4fs: add cache to track open files
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573713113.20753.7749823783069387792.stgit@frogsfrogsfrogs>
In-Reply-To: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
References: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add our own inode cache so that we can track open files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |    7 +++
 misc/Makefile.in    |    3 +
 misc/fuse4fs.c      |  132 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 1 deletion(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index cd738b6cd3a460..f482948a3b6331 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -6,6 +6,13 @@
 #ifndef __CACHE_H__
 #define __CACHE_H__
 
+/*  2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1 */
+#define GOLDEN_RATIO_PRIME	0x9e37fffffffc0001UL
+#ifndef CACHE_LINE_SIZE
+/* if the system didn't tell us, guess something reasonable */
+#define CACHE_LINE_SIZE		64
+#endif
+
 /*
  * initialisation flags
  */
diff --git a/misc/Makefile.in b/misc/Makefile.in
index edf7f356f6d0e8..36694d682d3b59 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -900,7 +900,8 @@ fuse4fs.o: $(srcdir)/fuse4fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/ext2fsP.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
- $(top_srcdir)/lib/e2p/e2p.h
+ $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h
 e2fuzz.o: $(srcdir)/e2fuzz.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 0dd47dcf18d77a..e2a9e7bfe54b00 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -27,6 +27,7 @@
 #include <unistd.h>
 #include <ctype.h>
 #include <stdbool.h>
+#include <assert.h>
 #define FUSE_DARWIN_ENABLE_EXTENSIONS 0
 #ifdef __SET_FOB_FOR_FUSE
 # error Do not set magic value __SET_FOB_FOR_FUSE!!!!
@@ -49,6 +50,8 @@
 #include "ext2fs/ext2fs.h"
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fsP.h"
+#include "support/list.h"
+#include "support/cache.h"
 
 #include "../version.h"
 #include "uuid/uuid.h"
@@ -205,6 +208,7 @@ int journal_enable_debug = -1;
 #define FUSE4FS_FILE_MAGIC	(0xEF53DEAFUL)
 struct fuse4fs_file_handle {
 	unsigned long magic;
+	struct fuse4fs_inode *fi;
 	ext2_ino_t ino;
 	int open_flags;
 };
@@ -252,6 +256,7 @@ struct fuse4fs {
 	uint8_t timing;
 #endif
 	struct fuse_session *fuse;
+	struct cache inodes;
 };
 
 #define FUSE4FS_CHECK_HANDLE(req, fh) \
@@ -346,6 +351,115 @@ static inline int u_log2(unsigned int arg)
 	return l;
 }
 
+struct fuse4fs_inode {
+	struct cache_node	i_cnode;
+	ext2_ino_t		i_ino;
+	unsigned int		i_open_count;
+};
+
+struct fuse4fs_ikey {
+	ext2_ino_t		i_ino;
+};
+
+#define ICKEY(key)	((struct fuse4fs_ikey *)(key))
+#define ICNODE(node)	(container_of((node), struct fuse4fs_inode, i_cnode))
+
+static unsigned int
+icache_hash(cache_key_t key, unsigned int hashsize, unsigned int hashshift)
+{
+	uint64_t	hashval = ICKEY(key)->i_ino;
+	uint64_t	tmp;
+
+	tmp = hashval ^ (GOLDEN_RATIO_PRIME + hashval) / CACHE_LINE_SIZE;
+	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> hashshift);
+	return tmp % hashsize;
+}
+
+static int icache_compare(struct cache_node *node, cache_key_t key)
+{
+	struct fuse4fs_inode *fi = ICNODE(node);
+	struct fuse4fs_ikey *ikey = ICKEY(key);
+
+	if (fi->i_ino == ikey->i_ino)
+		return CACHE_HIT;
+
+	return CACHE_MISS;
+}
+
+static struct cache_node *icache_alloc(struct cache *c, cache_key_t key)
+{
+	struct fuse4fs_ikey *ikey = ICKEY(key);
+	struct fuse4fs_inode *fi;
+
+	fi = calloc(1, sizeof(struct fuse4fs_inode));
+	if (!fi)
+		return NULL;
+
+	fi->i_ino = ikey->i_ino;
+	return &fi->i_cnode;
+}
+
+static bool icache_flush(struct cache *c, struct cache_node *node)
+{
+	return false;
+}
+
+static void icache_relse(struct cache *c, struct cache_node *node)
+{
+	struct fuse4fs_inode *fi = ICNODE(node);
+
+	assert(fi->i_open_count == 0);
+	free(fi);
+}
+
+static unsigned int icache_bulkrelse(struct cache *cache,
+				     struct list_head *list)
+{
+	struct cache_node *cn, *n;
+	int count = 0;
+
+	if (list_empty(list))
+		return 0;
+
+	list_for_each_entry_safe(cn, n, list, cn_mru) {
+		icache_relse(cache, cn);
+		count++;
+	}
+
+	return count;
+}
+
+static const struct cache_operations icache_ops = {
+	.hash		= icache_hash,
+	.alloc		= icache_alloc,
+	.flush		= icache_flush,
+	.relse		= icache_relse,
+	.compare	= icache_compare,
+	.bulkrelse	= icache_bulkrelse,
+	.resize		= cache_gradual_resize,
+};
+
+static errcode_t fuse4fs_iget(struct fuse4fs *ff, ext2_ino_t ino,
+			      struct fuse4fs_inode **fip)
+{
+	struct fuse4fs_ikey ikey = {
+		.i_ino = ino,
+	};
+	struct cache_node *node = NULL;
+
+	cache_node_get(&ff->inodes, &ikey, 0, &node);
+	if (!node)
+		return ENOMEM;
+
+	*fip = ICNODE(node);
+	return 0;
+}
+
+static void fuse4fs_iput(struct fuse4fs *ff, struct fuse4fs_inode *fi)
+{
+	cache_node_put(&ff->inodes, &fi->i_cnode);
+}
+
 static inline blk64_t FUSE4FS_B_TO_FSBT(const struct fuse4fs *ff, off_t pos)
 {
 	return pos >> ff->blocklog;
@@ -949,6 +1063,11 @@ static void fuse4fs_unmount(struct fuse4fs *ff)
 	if (!ff->fs)
 		return;
 
+	if (cache_initialized(&ff->inodes)) {
+		cache_purge(&ff->inodes);
+		cache_destroy(&ff->inodes);
+	}
+
 	err = ext2fs_close(ff->fs);
 	if (err)
 		err_printf(ff, "%s\n", error_message(err));
@@ -995,6 +1114,10 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff, int libext2_flags)
 		return err;
 	}
 
+	err = cache_init(CACHE_CAN_SHRINK, 1U << 10, &icache_ops, &ff->inodes);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
 	ff->fs->priv_data = ff;
 	ff->blocklog = u_log2(ff->fs->blocksize);
 	ff->blockmask = ff->fs->blocksize - 1;
@@ -2049,6 +2172,7 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 	if (inode.i_links_count)
 		goto write_out;
 
+
 	if (ext2fs_has_feature_ea_inode(fs->super)) {
 		ret = fuse4fs_remove_ea_inodes(ff, ino, &inode);
 		if (ret)
@@ -2957,6 +3081,13 @@ static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 			goto out;
 	}
 
+	err = fuse4fs_iget(ff, file->ino, &file->fi);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+	file->fi->i_open_count++;
+
 	fuse4fs_set_handle(fp, file);
 
 out:
@@ -3144,6 +3275,7 @@ static void op_release(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 			ret = translate_error(fs, fh->ino, err);
 	}
 
+	fuse4fs_iput(ff, fh->fi);
 	fp->fh = 0;
 	fuse4fs_finish(ff, ret);
 


