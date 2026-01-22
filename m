Return-Path: <linux-fsdevel+bounces-74986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKiNAZLfcWk+MgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:28:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70501630BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 514777A872C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514803A783F;
	Thu, 22 Jan 2026 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JTUIP6Nv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F52E62A4;
	Thu, 22 Jan 2026 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070164; cv=none; b=iXyW5W51NSyO9V1JhHbZAOpjXbHgKJAK6BHTZZzueRn6Rbq1U3ru3T8jrCZi5DqtIklgk4RPCRn8T2EtXIopL8cnJ2BXFa23DYoeqk8uRBGaSFLF6x4ZPUDjyCzwBRAtsM48RjnSx2n7azSOKmU8AHH1SHnSwzDdoSmljPpJi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070164; c=relaxed/simple;
	bh=kDITSgEEIPWpQ71hPWjePv38ErelhFnUMuQSTq+Rg5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqXE89iNmrYX/pfmtnYhUYLHrIO0axBUKGff6fRuimZhl8TZvq0K3UP9IHI/y8mOWV4Oq72JH3sHvu9i9Sqy5FT1C/TuACky4um6QApW8EHbdL/JLA4M0z3lQXQ23X4DmEvISGin6GaXLdKbx4WAgr6rAO+u596lr+b8+RcDZfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JTUIP6Nv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hAdCas95cj/I7ncOjpN0dsifccMn9iRm7c/Zz9k4sHY=; b=JTUIP6NvgUQQq/H4TkuH36i7U2
	BjGvHHZGwEub6I68mXheK183MCOuhWmcA68rEL7cZh5CMkTS3FVvcl3d2efx85v5UsqrdHJ3L8tKi
	CB4WdStYKD56Jec/MXHzfuEzIVkLptkfJOxPj3gBdO9wqxb0755pj7Wqv+CWXbHBiWDf+2gXwEOWv
	wpQFtCiUSetCMpU+2qj8qzUAfNj8WY32GsvevNfoxHAEyNDfyG1VVMlmnjRxeqPcGE7E4dTGehIGl
	tjd122hTkiVzkatQQkzSuZxayUJK41TNq2G+hNRLjFrpBHI1oe176BDcrc19bk5MYtZBrh5PY6Jzl
	0NABE7FQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vipxg-00000006dto-0wgM;
	Thu, 22 Jan 2026 08:22:40 +0000
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
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: [PATCH 03/11] fsverity: pass struct file to ->write_merkle_tree_block
Date: Thu, 22 Jan 2026 09:21:59 +0100
Message-ID: <20260122082214.452153-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122082214.452153-1-hch@lst.de>
References: <20260122082214.452153-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-74986-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 70501630BE
X-Rspamd-Action: no action

This will make an iomap implementation of the method easier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/verity.c        | 5 +++--
 fs/ext4/verity.c         | 6 +++---
 fs/f2fs/verity.c         | 6 +++---
 fs/verity/enable.c       | 9 +++++----
 include/linux/fsverity.h | 4 ++--
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index a2ac3fb68bc8..e7643c22a6bf 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -774,16 +774,17 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 /*
  * fsverity op that writes a Merkle tree block into the btree.
  *
- * @inode:	inode to write a Merkle tree block for
+ * @file:	file to write a Merkle tree block for
  * @buf:	Merkle tree block to write
  * @pos:	the position of the block in the Merkle tree (in bytes)
  * @size:	the Merkle tree block size (in bytes)
  *
  * Returns 0 on success or negative error code on failure
  */
-static int btrfs_write_merkle_tree_block(struct inode *inode, const void *buf,
+static int btrfs_write_merkle_tree_block(struct file *file, const void *buf,
 					 u64 pos, unsigned int size)
 {
+	struct inode *inode = file_inode(file);
 	loff_t merkle_pos = merkle_file_pos(inode);
 
 	if (merkle_pos < 0)
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 415d9c4d8a32..2ce4cf8a1e31 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -380,12 +380,12 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 	return folio_file_page(folio, index);
 }
 
-static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
+static int ext4_write_merkle_tree_block(struct file *file, const void *buf,
 					u64 pos, unsigned int size)
 {
-	pos += ext4_verity_metadata_pos(inode);
+	pos += ext4_verity_metadata_pos(file_inode(file));
 
-	return pagecache_write(inode, buf, size, pos);
+	return pagecache_write(file_inode(file), buf, size, pos);
 }
 
 const struct fsverity_operations ext4_verityops = {
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 05b935b55216..c1c4d8044681 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -278,12 +278,12 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 	return folio_file_page(folio, index);
 }
 
-static int f2fs_write_merkle_tree_block(struct inode *inode, const void *buf,
+static int f2fs_write_merkle_tree_block(struct file *file, const void *buf,
 					u64 pos, unsigned int size)
 {
-	pos += f2fs_verity_metadata_pos(inode);
+	pos += f2fs_verity_metadata_pos(file_inode(file));
 
-	return pagecache_write(inode, buf, size, pos);
+	return pagecache_write(file_inode(file), buf, size, pos);
 }
 
 const struct fsverity_operations f2fs_verityops = {
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 95ec42b84797..c56c18e2605b 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -41,14 +41,15 @@ static int hash_one_block(const struct merkle_tree_params *params,
 	return 0;
 }
 
-static int write_merkle_tree_block(struct inode *inode, const u8 *buf,
+static int write_merkle_tree_block(struct file *file, const u8 *buf,
 				   unsigned long index,
 				   const struct merkle_tree_params *params)
 {
+	struct inode *inode = file_inode(file);
 	u64 pos = (u64)index << params->log_blocksize;
 	int err;
 
-	err = inode->i_sb->s_vop->write_merkle_tree_block(inode, buf, pos,
+	err = inode->i_sb->s_vop->write_merkle_tree_block(file, buf, pos,
 							  params->block_size);
 	if (err)
 		fsverity_err(inode, "Error %d writing Merkle tree block %lu",
@@ -135,7 +136,7 @@ static int build_merkle_tree(struct file *filp,
 			err = hash_one_block(params, &buffers[level]);
 			if (err)
 				goto out;
-			err = write_merkle_tree_block(inode,
+			err = write_merkle_tree_block(filp,
 						      buffers[level].data,
 						      level_offset[level],
 						      params);
@@ -155,7 +156,7 @@ static int build_merkle_tree(struct file *filp,
 			err = hash_one_block(params, &buffers[level]);
 			if (err)
 				goto out;
-			err = write_merkle_tree_block(inode,
+			err = write_merkle_tree_block(filp,
 						      buffers[level].data,
 						      level_offset[level],
 						      params);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index ea1ed2e6c2f9..e22cf84fe83a 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -116,7 +116,7 @@ struct fsverity_operations {
 	/**
 	 * Write a Merkle tree block to the given inode.
 	 *
-	 * @inode: the inode for which the Merkle tree is being built
+	 * @file: the file for which the Merkle tree is being built
 	 * @buf: the Merkle tree block to write
 	 * @pos: the position of the block in the Merkle tree (in bytes)
 	 * @size: the Merkle tree block size (in bytes)
@@ -126,7 +126,7 @@ struct fsverity_operations {
 	 *
 	 * Return: 0 on success, -errno on failure
 	 */
-	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
+	int (*write_merkle_tree_block)(struct file *file, const void *buf,
 				       u64 pos, unsigned int size);
 };
 
-- 
2.47.3


