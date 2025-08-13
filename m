Return-Path: <linux-fsdevel+bounces-57664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF97B2458D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 11:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56C31BC0330
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA12F28F1;
	Wed, 13 Aug 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Pm1JO9j8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31452ED143
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077912; cv=none; b=k1n7eMj1qITMkGAxnWqCwvtu35QtyjXHqcuF/PKEBVvNaTI2Fe7QF7gnk9N1YLCZe1XpiI62jdoi5IeK3iVGhlWZNPI1CLqUQXyFP8AU/Wh6MFdSeKH9NBYM65XO2S9XwyaegI2+d33MhEGUGtP7LP0/vCvaQZ6KqDALo0eSs3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077912; c=relaxed/simple;
	bh=wakWn5DXV5mgDstjVv3uC6pZk3xB+A5pcDwqY+8jiC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z2aFqmHJSh07oarCElPcYgsXnXfv6iYPyRFbh9/FYazWOa+/QUX7jKXICvotD5Jkofon2oPcB7lPWU26ecmgH8yMrSjVFi3J6kMW1k3krkA6TJNMRua4Ck1RxdpqE75bH+Pm8K0UYlIPNAvQQEnopdYNvQMdAyFDxJ2dD0SzM+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Pm1JO9j8; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=QX
	1yHOS3iNusdtYkEEgfT0ZrvEnWSBmajEEebMi+mQI=; b=Pm1JO9j8lkI5tGFuVP
	48Dyu+FeD9eBZTOWnrVMa3iPyVwBbLhiN/tjiHm4mEbOwrRpFXGrzJYjjgAs1Tfv
	n1P5qxtW4vFEwNbfMW5KHB6nhiVBFHmUFRtC/PghyIKGDQxdYOXetbr7CvjApGCy
	flRL51StJcrvYeLWzIwVQ58Gc=
Received: from YLLaptop.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDn_9odWZxo91unBg--.63865S3;
	Wed, 13 Aug 2025 17:21:41 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Yi Zhang <yi.zhang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Nanzhe Zhao <nzzhao@126.com>
Subject: [RFC PATCH 1/9] f2fs: Introduce f2fs_iomap_folio_state
Date: Wed, 13 Aug 2025 17:21:23 +0800
Message-Id: <20250813092131.44762-2-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813092131.44762-1-nzzhao@126.com>
References: <20250813092131.44762-1-nzzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn_9odWZxo91unBg--.63865S3
X-Coremail-Antispam: 1Uf129KBjvAXoW3Kr17Xr1DJFy3ZFW5ArWfuFg_yoW8JF1kGo
	WSgw4jqw48KrWUArWjkr17WFy7ua98Ca47JF4fCrs8uFnrXa4q9rW7KrsxJa4I9rn5JF12
	939xJF47GFWfX3Wxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RLNVkUUUUU
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiEx6oz2icVjspmwABsA

Add f2fs's own per-folio structure to track
per-block dirty state of a folio.

The reason for introducing this structure is that f2fs's private flag
would conflict with iomap_folio_state's use of the folio->private field.
Thanks to Mr. Matthew for providing the idea. See for details:
[https://lore.kernel.org/linux-f2fs-devel/Z-oPTUrF7kkhzJg_
@casper.infradead.org/]

The memory layout of this structure is the same as iomap_folio_state,
except that we set read_bytes_pending to a magic number. This is because
we need to be able to distinguish it from the original iomap_folio_state.
We additionally allocate an unsigned long at the end of the state array
to store f2fs-specific flags.

This implementation is compatible with high-order folios, order-0 folios,
and metadata folios.
However, it does not support compressed data folios.

Introduction to related functions:

- f2fs_ifs_alloc: Allocates f2fs's own f2fs_iomap_folio_state. If it
  detects that folio->private already has a value, we distinguish
  whether it is f2fs's own flag value or an iomap_folio_state. If it is
  the latter, we will copy its content to our f2fs_iomap_folio_state
  and then free it.

- folio_detach_f2fs_private: Serves as a unified interface to release
  f2fs's private resources, no matter what it is.

- f2fs_ifs_clear_range_uptodate && f2fs_ifs_set_range_dirty: Helper
  functions copied and slightly modified from fs/iomap.

- folio_get_f2fs_ifs: Specifically used to get f2fs_iomap_folio_state.
  It cannot be used to get f2fs's own fields used on compressed folios.
  For the former, we return a null pointer to indicate that the current
  folio does not hold an f2fs_iomap_folio_state. For the latter, we
  directly BUG_ON.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/Kconfig    |  10 ++
 fs/f2fs/Makefile   |   1 +
 fs/f2fs/f2fs_ifs.c | 221 +++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs_ifs.h |  79 ++++++++++++++++
 4 files changed, 311 insertions(+)
 create mode 100644 fs/f2fs/f2fs_ifs.c
 create mode 100644 fs/f2fs/f2fs_ifs.h

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 5916a02fb46d..480b8536fa39 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -150,3 +150,13 @@ config F2FS_UNFAIR_RWSEM
 	help
 	  Use unfair rw_semaphore, if system configured IO priority by block
 	  cgroup.
+
+config F2FS_IOMAP_FOLIO_STATE
+	bool "F2FS folio per-block I/O state tracking"
+	depends on F2FS_FS && FS_IOMAP
+	help
+	  Enable a custom F2FS structure for tracking the I/O state
+	  (up-to-date, dirty) on a per-block basis within a memory folio.
+	  This structure stores F2FS private flag in its state flexible
+	  array while keeping compatibility with generic iomap_folio_state.
+	  Must be enabled if using iomap large folios support in F2FS.
\ No newline at end of file
diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index 8a7322d229e4..3b9270d774e8 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -10,3 +10,4 @@ f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
 f2fs-$(CONFIG_FS_VERITY) += verity.o
 f2fs-$(CONFIG_F2FS_FS_COMPRESSION) += compress.o
 f2fs-$(CONFIG_F2FS_IOSTAT) += iostat.o
+f2fs-$(CONFIG_F2FS_IOMAP_FOLIO_STATE) += f2fs_ifs.o
diff --git a/fs/f2fs/f2fs_ifs.c b/fs/f2fs/f2fs_ifs.c
new file mode 100644
index 000000000000..6b7503474580
--- /dev/null
+++ b/fs/f2fs/f2fs_ifs.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fs.h>
+#include <linux/f2fs_fs.h>
+
+#include "f2fs.h"
+#include "f2fs_ifs.h"
+
+/*
+ * Have to set parameter ifs's type to void*
+ * and have to interpret ifs as f2fs_ifs to access its fields because
+ * we cannot see iomap_folio_state definition
+ */
+static void ifs_to_f2fs_ifs(void *ifs, struct f2fs_iomap_folio_state *fifs,
+			    struct folio *folio)
+{
+	struct f2fs_iomap_folio_state *src_ifs =
+		(struct f2fs_iomap_folio_state *)ifs;
+	size_t iomap_longs = f2fs_ifs_iomap_longs(folio);
+
+	fifs->read_bytes_pending = READ_ONCE(src_ifs->read_bytes_pending);
+	atomic_set(&fifs->write_bytes_pending,
+		   atomic_read(&src_ifs->write_bytes_pending));
+	memcpy(fifs->state, src_ifs->state,
+	       iomap_longs * sizeof(unsigned long));
+}
+
+static inline bool is_f2fs_ifs(struct folio *folio)
+{
+	struct f2fs_iomap_folio_state *fifs;
+
+	if (!folio_test_private(folio))
+		return false;
+
+	// first directly test no pointer flag is set or not
+	if (test_bit(PAGE_PRIVATE_NOT_POINTER,
+		     (unsigned long *)&folio->private))
+		return false;
+
+	fifs = (struct f2fs_iomap_folio_state *)folio->private;
+	if (!fifs)
+		return false;
+
+	if (READ_ONCE(fifs->read_bytes_pending) == F2FS_IFS_MAGIC)
+		return true;
+
+	return false;
+}
+
+struct f2fs_iomap_folio_state *f2fs_ifs_alloc(struct folio *folio, gfp_t gfp,
+					      bool force_alloc)
+{
+	struct inode *inode = folio->mapping->host;
+	size_t alloc_size = 0;
+
+	if (!folio_test_large(folio)) {
+		if (!force_alloc) {
+			WARN_ON_ONCE(1);
+			return NULL;
+		}
+		/*
+		 * GC can store private flag in 0 order folio's folio->private
+		 * causes iomap buffered write mistakenly interpret as a pointer
+		 * we add a bool force_alloc to deal with this case
+		 */
+		struct f2fs_iomap_folio_state *fifs;
+
+		alloc_size = sizeof(*fifs) + 2 * sizeof(unsigned long);
+		fifs = kmalloc(alloc_size, gfp);
+		if (!fifs)
+			return NULL;
+		spin_lock_init(&fifs->state_lock);
+		WRITE_ONCE(fifs->read_bytes_pending, F2FS_IFS_MAGIC);
+		atomic_set(&fifs->write_bytes_pending, 0);
+		unsigned int nr_blocks =
+			i_blocks_per_folio(inode, folio);
+		if (folio_test_uptodate(folio))
+			bitmap_set(fifs->state, 0, nr_blocks);
+		if (folio_test_dirty(folio))
+			bitmap_set(fifs->state, nr_blocks, nr_blocks);
+		*f2fs_ifs_private_flags_ptr(fifs, folio) = 0;
+		folio_attach_private(folio, fifs);
+		return fifs;
+	}
+
+	struct f2fs_iomap_folio_state *fifs;
+	void *old_private;
+	size_t iomap_longs;
+	size_t total_longs;
+
+	WARN_ON_ONCE(!inode); // Should have an inode
+
+	old_private = folio_get_private(folio);
+
+	if (old_private) {
+		// Check if it's already our type using the magic number directly
+		if (READ_ONCE(((struct f2fs_iomap_folio_state *)old_private)
+				      ->read_bytes_pending) == F2FS_IFS_MAGIC) {
+			return (struct f2fs_iomap_folio_state *)
+				old_private; // Already ours
+		}
+		// Non-NULL, not ours -> Allocate, Copy, Replace path
+		total_longs = f2fs_ifs_total_longs(folio);
+		alloc_size = sizeof(*fifs) +
+				total_longs * sizeof(unsigned long);
+
+		fifs = kmalloc(alloc_size, gfp);
+		if (!fifs)
+			return NULL;
+
+		spin_lock_init(&fifs->state_lock);
+		*f2fs_ifs_private_flags_ptr(fifs, folio) = 0;
+		// Copy data from the presumed iomap_folio_state (old_private)
+		ifs_to_f2fs_ifs(old_private, fifs, folio);
+		WRITE_ONCE(fifs->read_bytes_pending, F2FS_IFS_MAGIC);
+		folio_change_private(folio, fifs);
+		kfree(old_private);
+		return fifs;
+	}
+
+	iomap_longs = f2fs_ifs_iomap_longs(folio);
+	total_longs = iomap_longs + 1;
+	alloc_size =
+		sizeof(*fifs) + total_longs * sizeof(unsigned long);
+
+	fifs = kzalloc(alloc_size, gfp);
+	if (!fifs)
+		return NULL;
+
+	spin_lock_init(&fifs->state_lock);
+
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
+
+	if (folio_test_uptodate(folio))
+		bitmap_set(fifs->state, 0, nr_blocks);
+	if (folio_test_dirty(folio))
+		bitmap_set(fifs->state, nr_blocks, nr_blocks);
+	WRITE_ONCE(fifs->read_bytes_pending, F2FS_IFS_MAGIC);
+	atomic_set(&fifs->write_bytes_pending, 0);
+	folio_attach_private(folio, fifs);
+	return fifs;
+}
+
+void folio_detach_f2fs_private(struct folio *folio)
+{
+	struct f2fs_iomap_folio_state *fifs;
+
+	if (!folio_test_private(folio))
+		return;
+
+	// Check if it's using direct flags
+	if (test_bit(PAGE_PRIVATE_NOT_POINTER,
+		     (unsigned long *)&folio->private)) {
+		folio_detach_private(folio);
+		return;
+	}
+
+	fifs = folio_detach_private(folio);
+	if (!fifs)
+		return;
+
+	if (is_f2fs_ifs(folio)) {
+		WARN_ON_ONCE(READ_ONCE(fifs->read_bytes_pending) !=
+			     F2FS_IFS_MAGIC);
+		WARN_ON_ONCE(atomic_read(&fifs->write_bytes_pending));
+	} else {
+		WARN_ON_ONCE(READ_ONCE(fifs->read_bytes_pending) != 0);
+		WARN_ON_ONCE(atomic_read(&fifs->write_bytes_pending));
+	}
+
+	kfree(fifs);
+}
+
+struct f2fs_iomap_folio_state *folio_get_f2fs_ifs(struct folio *folio)
+{
+	if (!folio_test_private(folio))
+		return NULL;
+
+	if (test_bit(PAGE_PRIVATE_NOT_POINTER,
+		     (unsigned long *)&folio->private))
+		return NULL;
+	/*
+	 * Note we assume folio->private can be either ifs or f2fs_ifs here.
+	 * Compresssed folios should not call this function
+	 */
+	f2fs_bug_on(F2FS_F_SB(folio),
+		    *((u32 *)folio->private) == F2FS_COMPRESSED_PAGE_MAGIC);
+	return folio->private;
+}
+
+void f2fs_ifs_clear_range_uptodate(struct folio *folio,
+				   struct f2fs_iomap_folio_state *fifs,
+				   size_t off, size_t len)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int first_blk = (off >> inode->i_blkbits);
+	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
+	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fifs->state_lock, flags);
+	bitmap_clear(fifs->state, first_blk, nr_blks);
+	spin_unlock_irqrestore(&fifs->state_lock, flags);
+}
+
+void f2fs_iomap_set_range_dirty(struct folio *folio, size_t off, size_t len)
+{
+	struct f2fs_iomap_folio_state *fifs = folio_get_f2fs_ifs(folio);
+
+	if (fifs) {
+		struct inode *inode = folio->mapping->host;
+		unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+		unsigned int first_blk = (off >> inode->i_blkbits);
+		unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
+		unsigned int nr_blks = last_blk - first_blk + 1;
+		unsigned long flags;
+
+		spin_lock_irqsave(&fifs->state_lock, flags);
+		bitmap_set(fifs->state, first_blk + blks_per_folio, nr_blks);
+		spin_unlock_irqrestore(&fifs->state_lock, flags);
+	}
+}
diff --git a/fs/f2fs/f2fs_ifs.h b/fs/f2fs/f2fs_ifs.h
new file mode 100644
index 000000000000..3b16deda8a1e
--- /dev/null
+++ b/fs/f2fs/f2fs_ifs.h
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef F2FS_IFS_H
+#define F2FS_IFS_H
+
+#include <linux/fs.h>
+#include <linux/bug.h>
+#include <linux/f2fs_fs.h>
+#include <linux/mm.h>
+#include <linux/iomap.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/atomic.h>
+
+#include "f2fs.h"
+
+#define F2FS_IFS_MAGIC 0xf2f5
+#define F2FS_IFS_PRIVATE_LONGS 1
+
+/*
+ * F2FS structure for folio private data, mimicking iomap_folio_state layout.
+ * F2FS private flags/data are stored in extra space allocated at the end
+ */
+struct f2fs_iomap_folio_state {
+	spinlock_t state_lock;
+	unsigned int read_bytes_pending;
+	atomic_t write_bytes_pending;
+	/*
+	 * Flexible array member.
+	 * Holds [0...iomap_longs-1] for iomap uptodate/dirty bits.
+	 * Holds [iomap_longs] for F2FS private flags/data (unsigned long).
+	 */
+	unsigned long state[];
+};
+
+static inline bool
+f2fs_ifs_block_is_uptodate(struct f2fs_iomap_folio_state *ifs,
+			   unsigned int block)
+{
+	return test_bit(block, ifs->state);
+}
+
+static inline size_t f2fs_ifs_iomap_longs(const struct folio *folio)
+{
+	struct inode *inode = folio->mapping->host;
+
+	WARN_ON_ONCE(!inode);
+	unsigned int nr_blocks =
+		i_blocks_per_folio(inode, (struct folio *)folio);
+	return BITS_TO_LONGS(2 * nr_blocks);
+}
+
+static inline size_t f2fs_ifs_total_longs(struct folio *folio)
+{
+	return f2fs_ifs_iomap_longs(folio) + F2FS_IFS_PRIVATE_LONGS;
+}
+
+static inline unsigned long *
+f2fs_ifs_private_flags_ptr(struct f2fs_iomap_folio_state *fifs,
+			   const struct folio *folio)
+{
+	return &fifs->state[f2fs_ifs_iomap_longs(folio)];
+}
+
+struct f2fs_iomap_folio_state *f2fs_ifs_alloc(struct folio *folio, gfp_t gfp,
+					      bool force_alloc);
+void folio_detach_f2fs_private(struct folio *folio);
+struct f2fs_iomap_folio_state *folio_get_f2fs_ifs(struct folio *folio);
+
+/*
+ * 0-order and fully dirty folio has no fifs
+ * they store private flag directly in their folio->private field
+ * as original f2fs page private behaviour
+ */
+void f2fs_ifs_clear_range_uptodate(struct folio *folio,
+				   struct f2fs_iomap_folio_state *fifs,
+				   size_t off, size_t len);
+void f2fs_iomap_set_range_dirty(struct folio *folio, size_t off, size_t len);
+
+#endif /* F2FS_IFS_H */
-- 
2.34.1


