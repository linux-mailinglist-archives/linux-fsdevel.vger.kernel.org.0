Return-Path: <linux-fsdevel+bounces-75730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IM0MAksemnd3gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:32:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C909A3EB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 204C730D4399
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4466336BCE8;
	Wed, 28 Jan 2026 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kzgMYl6o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5DA3612F7;
	Wed, 28 Jan 2026 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614024; cv=none; b=OPhsC/JdNgThkIJwreaRz8ycYQQiNvNBzlhsjIkq0ecDGbxUK1LRcP1QHDK+QkQkJJXwqDpefackEnZ4v3v5CiiZqfN6qmv1IDTYcNU5TopVdZ5mzyhlQHXN+pSY6iJg55LQo7YhA0QFExRbYsAfJeE2nteGNlQ/XH6sKIDNTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614024; c=relaxed/simple;
	bh=MbdGEmevTBJb0vS/gZUueE/OHoHj7gpwXbP5a70MZWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNEWTBLCt0Mp5EmVPBcK7MTitqgaqbwvN0HS3VpgDI9Aib/tpErh2paEWZYDhgPJdNSrejqhT8G+k7bgQSb4RoeQkQZ3X85MP2SnphzsEiMFaathAD5V6hcJjfxW6UkrN0oaW9XzcHVPB0uERBIM0R+cJxhpbN1pv+J3AjJD9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kzgMYl6o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tiEhYLJfu/bJWzWAGoEqv1JQK/ldnE8nfYaqsxqRmME=; b=kzgMYl6o9NHxllN67/sciOLY1Y
	LlrqnDRKa+Nwz81j1IqrrPxrKviT7Q0tv2Txf4rmVPZka4jyL8dk/tjgAdi5oRg/ZdvmbqcAg7Lk/
	F6NlQWcP1PP+iQ8lt99Q87x4/ZDc64tBmjIaNlppX4jwDAwZIOw5I54vwXDZKT8YOAFcqTRI+zp6F
	4YxkuZqkWcCYgcdkVFMSY1QAFwInrcMq9o6gGDeQrrbwtjhjDgeCW0MWscxGlXvzNQ3tBg2c36BR2
	Qxvu00ftUz3FUm/n13nXII4HaD/z7yOAGJqDln/hW+GAQTl3PtbCk9ASvcoHJXUUFL01ULWiRE3Rk
	B+W/zIKA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl7RW-0000000GHHP-01bL;
	Wed, 28 Jan 2026 15:26:56 +0000
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
	fsverity@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 02/15] fs,fsverity: clear out fsverity_info from common code
Date: Wed, 28 Jan 2026 16:26:14 +0100
Message-ID: <20260128152630.627409-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128152630.627409-1-hch@lst.de>
References: <20260128152630.627409-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-75730-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,suse.cz:email,suse.com:email]
X-Rspamd-Queue-Id: 6C909A3EB0
X-Rspamd-Action: no action

Directly remove the fsverity_info from the hash and free it from
clear_inode instead of requiring file systems to handle it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Acked-by: David Sterba <dsterba@suse.com> [btrfs]
---
 fs/btrfs/inode.c         | 10 +++-------
 fs/ext4/super.c          |  1 -
 fs/f2fs/inode.c          |  1 -
 fs/inode.c               |  9 +++++++++
 fs/verity/open.c         |  3 +--
 include/linux/fsverity.h | 26 ++------------------------
 6 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a2b5b440637e..67c64efc5099 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -34,7 +34,6 @@
 #include <linux/sched/mm.h>
 #include <linux/iomap.h>
 #include <linux/unaligned.h>
-#include <linux/fsverity.h>
 #include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
@@ -5571,11 +5570,8 @@ void btrfs_evict_inode(struct inode *inode)
 
 	trace_btrfs_inode_evict(inode);
 
-	if (!root) {
-		fsverity_cleanup_inode(inode);
-		clear_inode(inode);
-		return;
-	}
+	if (!root)
+		goto clear_inode;
 
 	fs_info = inode_to_fs_info(inode);
 	evict_inode_truncate_pages(inode);
@@ -5675,7 +5671,7 @@ void btrfs_evict_inode(struct inode *inode)
 	 * to retry these periodically in the future.
 	 */
 	btrfs_remove_delayed_node(BTRFS_I(inode));
-	fsverity_cleanup_inode(inode);
+clear_inode:
 	clear_inode(inode);
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d0..86131f4d8718 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1527,7 +1527,6 @@ void ext4_clear_inode(struct inode *inode)
 		EXT4_I(inode)->jinode = NULL;
 	}
 	fscrypt_put_encryption_info(inode);
-	fsverity_cleanup_inode(inode);
 }
 
 static struct inode *ext4_nfs_get_inode(struct super_block *sb,
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 38b8994bc1b2..ee332b994348 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -1000,7 +1000,6 @@ void f2fs_evict_inode(struct inode *inode)
 	}
 out_clear:
 	fscrypt_put_encryption_info(inode);
-	fsverity_cleanup_inode(inode);
 	clear_inode(inode);
 }
 
diff --git a/fs/inode.c b/fs/inode.c
index 379f4c19845c..38dbdfbb09ba 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -14,6 +14,7 @@
 #include <linux/cdev.h>
 #include <linux/memblock.h>
 #include <linux/fsnotify.h>
+#include <linux/fsverity.h>
 #include <linux/mount.h>
 #include <linux/posix_acl.h>
 #include <linux/buffer_head.h> /* for inode_has_buffers */
@@ -773,6 +774,14 @@ void dump_mapping(const struct address_space *mapping)
 
 void clear_inode(struct inode *inode)
 {
+	/*
+	 * Only IS_VERITY() inodes can have verity info, so start by checking
+	 * for IS_VERITY() (which is faster than retrieving the pointer to the
+	 * verity info).  This minimizes overhead for non-verity inodes.
+	 */
+	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
+		fsverity_cleanup_inode(inode);
+
 	/*
 	 * We have to cycle the i_pages lock here because reclaim can be in the
 	 * process of removing the last page (in __filemap_remove_folio())
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 2aa5eae5a540..090cb77326ee 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -384,14 +384,13 @@ int __fsverity_file_open(struct inode *inode, struct file *filp)
 }
 EXPORT_SYMBOL_GPL(__fsverity_file_open);
 
-void __fsverity_cleanup_inode(struct inode *inode)
+void fsverity_cleanup_inode(struct inode *inode)
 {
 	struct fsverity_info **vi_addr = fsverity_info_addr(inode);
 
 	fsverity_free_info(*vi_addr);
 	*vi_addr = NULL;
 }
-EXPORT_SYMBOL_GPL(__fsverity_cleanup_inode);
 
 void __init fsverity_init_info_cache(void)
 {
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 86fb1708676b..ea1ed2e6c2f9 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -179,26 +179,6 @@ int fsverity_get_digest(struct inode *inode,
 /* open.c */
 
 int __fsverity_file_open(struct inode *inode, struct file *filp);
-void __fsverity_cleanup_inode(struct inode *inode);
-
-/**
- * fsverity_cleanup_inode() - free the inode's verity info, if present
- * @inode: an inode being evicted
- *
- * Filesystems must call this on inode eviction to free the inode's verity info.
- */
-static inline void fsverity_cleanup_inode(struct inode *inode)
-{
-	/*
-	 * Only IS_VERITY() inodes can have verity info, so start by checking
-	 * for IS_VERITY() (which is faster than retrieving the pointer to the
-	 * verity info).  This minimizes overhead for non-verity inodes.
-	 */
-	if (IS_VERITY(inode))
-		__fsverity_cleanup_inode(inode);
-	else
-		VFS_WARN_ON_ONCE(*fsverity_info_addr(inode) != NULL);
-}
 
 /* read_metadata.c */
 
@@ -250,10 +230,6 @@ static inline int __fsverity_file_open(struct inode *inode, struct file *filp)
 	return -EOPNOTSUPP;
 }
 
-static inline void fsverity_cleanup_inode(struct inode *inode)
-{
-}
-
 /* read_metadata.c */
 
 static inline int fsverity_ioctl_read_metadata(struct file *filp,
@@ -331,4 +307,6 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+void fsverity_cleanup_inode(struct inode *inode);
+
 #endif	/* _LINUX_FSVERITY_H */
-- 
2.47.3


