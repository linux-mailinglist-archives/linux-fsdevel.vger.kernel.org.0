Return-Path: <linux-fsdevel+bounces-61609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EEFB58A41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF7D2A59F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1371C5F23;
	Tue, 16 Sep 2025 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWhXC2hU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E0FC1D;
	Tue, 16 Sep 2025 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984121; cv=none; b=QxVJVddQmRTuQtSbH/BLQnHMrikquGLryL9y2FjzqDpZtu9iYLdjbO/HQ4nw0Tfk6lYKEOynZpEZGTnJL3JtNVR2/6cIe4QprDgom2k80k77OTeVUlNKUkJSDzhzjd8iGoQ6gGqHR/TTt7To29Vh3xs7nOQnLbentnL1nDN6FiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984121; c=relaxed/simple;
	bh=02Up2PVyGLG44tXXm4hwcj6Zn0wX82pSHiJsZhlkF8E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inELOoMllFYfBluQF4pMpNgPJs6MIJo+WrqQLH85hKbH2xDGxxMgO0LbdFa6ieGYyyL0R5rSorSo0aHbwh/IGLFSD2HteZJdQ5lBgEUSrHx6YTLq+/Ajd8n924IGU+vwFs/s1o3rrryvde92pIvJTTYo5zraQpi9PSmXPutWjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWhXC2hU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC737C4CEF1;
	Tue, 16 Sep 2025 00:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984120;
	bh=02Up2PVyGLG44tXXm4hwcj6Zn0wX82pSHiJsZhlkF8E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AWhXC2hUxw/nV/J16Kkl+PeuxdZP0t/kLmIG7nl7Jo0nINXVDfXafqMkQ1vod2QDs
	 zB9mpG1lCa10c8RRNCOXtl8OrbVx9/ux6DVhsEO8KZxK42+L+CBhWgDhFph2jIQ2qQ
	 cb9YukksNsLwleovxXgnHrE1+aEw75bYQudHir55Ow6qXdnO8UnVx+o7ZpZat0diCI
	 oI2pafOW7AGaylimyZsrPiyTpISdpy24hHIAcsdkWWh8+eEqarHL672K6zVHJ6FYlq
	 mWtOUPv0zwCLk0tCxurKTrLLSRXRPZB7h+BCkW9MKIk3maWf6K3ncDlYV7CJYAvLnr
	 yk1dUCUIXrxvg==
Date: Mon, 15 Sep 2025 17:55:20 -0700
Subject: [PATCH 18/21] fuse4fs: add cache to track open files
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798161099.389252.789807659344261604.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
References: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
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
 fuse4fs/Makefile.in |    3 +
 fuse4fs/fuse4fs.c   |  132 +++++++++++++++++++++++++++++++++++++++++++++++++++
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
diff --git a/fuse4fs/Makefile.in b/fuse4fs/Makefile.in
index 6b41d1dd5ffe8d..9f3547c271638f 100644
--- a/fuse4fs/Makefile.in
+++ b/fuse4fs/Makefile.in
@@ -146,7 +146,8 @@ fuse4fs.o: $(srcdir)/fuse4fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/ext2fsP.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
- $(top_srcdir)/lib/e2p/e2p.h
+ $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h
 journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/../debugfs/journal.h \
  $(top_srcdir)/e2fsck/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 8b65dd1b419eaa..5b06e5a5b9668e 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
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
 	int check_flags;
@@ -257,6 +261,7 @@ struct fuse4fs {
 	int timing;
 #endif
 	struct fuse_session *fuse;
+	struct cache inodes;
 };
 
 #define FUSE4FS_CHECK_HANDLE(req, fh) \
@@ -351,6 +356,115 @@ static inline int u_log2(unsigned int arg)
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
@@ -954,6 +1068,11 @@ static void fuse4fs_unmount(struct fuse4fs *ff)
 	if (!ff->fs)
 		return;
 
+	if (cache_initialized(&ff->inodes)) {
+		cache_purge(&ff->inodes);
+		cache_destroy(&ff->inodes);
+	}
+
 	err = ext2fs_close(ff->fs);
 	if (err) {
 		err_printf(ff, "%s: %s\n", _("while closing fs"),
@@ -1002,6 +1121,10 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff, int libext2_flags)
 		return err;
 	}
 
+	err = cache_init(CACHE_CAN_SHRINK, 1U << 10, &icache_ops, &ff->inodes);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
 	ff->fs->priv_data = ff;
 	ff->blocklog = u_log2(ff->fs->blocksize);
 	ff->blockmask = ff->fs->blocksize - 1;
@@ -2071,6 +2194,7 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 	if (inode.i_links_count)
 		goto write_out;
 
+
 	if (ext2fs_has_feature_ea_inode(fs->super)) {
 		ret = fuse4fs_remove_ea_inodes(ff, ino, &inode);
 		if (ret)
@@ -2987,6 +3111,13 @@ static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 			goto out;
 	}
 
+	err = fuse4fs_iget(ff, file->ino, &file->fi);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+	file->fi->i_open_count++;
+
 	file->check_flags = check;
 	fuse4fs_set_handle(fp, file);
 
@@ -3175,6 +3306,7 @@ static void op_release(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 			ret = translate_error(fs, fh->ino, err);
 	}
 
+	fuse4fs_iput(ff, fh->fi);
 	fp->fh = 0;
 	fuse4fs_finish(ff, ret);
 


