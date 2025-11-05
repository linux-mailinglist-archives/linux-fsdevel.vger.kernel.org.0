Return-Path: <linux-fsdevel+bounces-67030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE70C33854
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1424918C3609
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7464623BCF7;
	Wed,  5 Nov 2025 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaaO//N3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1CA34D396;
	Wed,  5 Nov 2025 00:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303815; cv=none; b=tkb7ak4o3XRfy3Jj9I8JvHyuy+2wecnO6p/iZdrguV/i/fHOSMuJVJRXo3+pCOeUdi1HLYYlhk/ZJ0uIXb5Z8pf/9WtQxv+NMeY6gWPjuZPgxx+yISfeYR1vfZa6CCy+evJBl4luQ5Z6CV1xg29ojGrFMnagfCIzUYkj/F74NDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303815; c=relaxed/simple;
	bh=6DncLSGp9FYy4eA+9OMTbCFX6CazlG0NAiyT+8EIOVE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GT+6+v5dqYhCJh5OWUFua+IpLNVUD+zufDfBxWW/brRA1nd9hoG1Y8TeHlPSJrSLjikIj74BbPdkvFzTuylsI+/wU9W8aVdpYyOG8zuPQHp0H36BxLAD4iMI8wRql9roRNJy7uiuh123qrTSugRSpHL9ALZ6ivTCK4xaV6Iehmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaaO//N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602C4C116B1;
	Wed,  5 Nov 2025 00:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303815;
	bh=6DncLSGp9FYy4eA+9OMTbCFX6CazlG0NAiyT+8EIOVE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XaaO//N3QDZmK3AtWSKsgZDT8tXxbZIXpBnsEsFaB+Y4ROVXylYq+TB2Ww1MTfMxM
	 w6rL8NUyb0dCt45y0nhsmQ+E9SoBV+XFKqBwW2OP/EO4IqYeHaLu8hD/D9hli64fYD
	 RrWcM2zxqWm3wOeoKdHePhRY0KpysDAvZjMWStPSaAmMdYBgVE+a3yInM1I5lQUCAm
	 e3NJ2iIcMX3SdOGe50AMd8tp3q3yiy42qlcAIgK1cdJ30+PpM/H0iJsqrVHABU0ytn
	 GVP8yi2RFIkduHHKTWZtPLimz2WG6KjVfPqaeJzObYxDERnbE2wd8sJ59WvytXc+GX
	 p2ah5RDozNt0g==
Date: Tue, 04 Nov 2025 16:50:14 -0800
Subject: [PATCH 07/22] iomap: report buffered read and write io errors to the
 filesystem
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230365840.1647136.14433927681931674562.stgit@frogsfrogsfrogs>
In-Reply-To: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
References: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Provide a callback so that iomap can report read and write IO errors to
the caller filesystem.  For now this is only wired up for iomap as a
testbed for XFS.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/internal.h               |    2 ++
 include/linux/fs.h                |    4 ++++
 Documentation/filesystems/vfs.rst |    7 +++++++
 fs/iomap/buffered-io.c            |   27 +++++++++++++++++++++++++--
 fs/iomap/ioend.c                  |    4 ++++
 5 files changed, 42 insertions(+), 2 deletions(-)


diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index d05cb3aed96e79..06d9145b6be4fa 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -5,5 +5,7 @@
 #define IOEND_BATCH_SIZE	4096
 
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
+void iomap_mapping_ioerror(struct address_space *mapping, int direction,
+		loff_t pos, u64 len, int error);
 
 #endif /* _IOMAP_INTERNAL_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444be..5e4b3a4b24823f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -477,6 +477,10 @@ struct address_space_operations {
 				sector_t *span);
 	void (*swap_deactivate)(struct file *file);
 	int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
+
+	/* Callback for dealing with IO errors during readahead or writeback */
+	void (*ioerror)(struct address_space *mapping, int direction,
+			loff_t pos, u64 len, int error);
 };
 
 extern const struct address_space_operations empty_aops;
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 4f13b01e42eb5e..9e70006bf99a63 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -822,6 +822,8 @@ cache in your filesystem.  The following members are defined:
 		int (*swap_activate)(struct swap_info_struct *sis, struct file *f, sector_t *span)
 		int (*swap_deactivate)(struct file *);
 		int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
+		void (*ioerror)(struct address_space *mapping, int direction,
+				loff_t pos, u64 len, int error);
 	};
 
 ``read_folio``
@@ -1032,6 +1034,11 @@ cache in your filesystem.  The following members are defined:
 ``swap_rw``
 	Called to read or write swap pages when SWP_FS_OPS is set.
 
+``ioerror``
+        Called to deal with IO errors during readahead or writeback.
+        This may be called from interrupt context, and without any
+        locks necessarily being held.
+
 The File Object
 ===============
 
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8b847a1e27f13e..8dd5421cb910b5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -288,6 +288,14 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 		pos >= i_size_read(iter->inode);
 }
 
+inline void iomap_mapping_ioerror(struct address_space *mapping, int direction,
+		loff_t pos, u64 len, int error)
+{
+	if (mapping && mapping->a_ops->ioerror)
+		mapping->a_ops->ioerror(mapping, direction, pos, len,
+				error);
+}
+
 /**
  * iomap_read_inline_data - copy inline data into the page cache
  * @iter: iteration structure
@@ -310,8 +318,11 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (folio_test_uptodate(folio))
 		return 0;
 
-	if (WARN_ON_ONCE(size > iomap->length))
+	if (WARN_ON_ONCE(size > iomap->length)) {
+		iomap_mapping_ioerror(folio->mapping, READ, iomap->offset,
+				size, -EIO);
 		return -EIO;
+	}
 	if (offset > 0)
 		ifs_alloc(iter->inode, folio, iter->flags);
 
@@ -339,6 +350,10 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
+	if (error)
+		iomap_mapping_ioerror(folio->mapping, READ,
+				folio_pos(folio) + off, len, error);
+
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
@@ -558,11 +573,15 @@ static int iomap_read_folio_range(const struct iomap_iter *iter,
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct bio_vec bvec;
 	struct bio bio;
+	int ret;
 
 	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
 	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
-	return submit_bio_wait(&bio);
+	ret = submit_bio_wait(&bio);
+	if (ret)
+		iomap_mapping_ioerror(folio->mapping, READ, pos, len, ret);
+	return ret;
 }
 #else
 static int iomap_read_folio_range(const struct iomap_iter *iter,
@@ -1674,6 +1693,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
+	loff_t orig_pos = pos;
 	bool wb_pending = false;
 	int error = 0;
 	u32 rlen;
@@ -1724,6 +1744,9 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 
 	if (wb_pending)
 		wpc->nr_folios++;
+	if (error && pos > orig_pos)
+		iomap_mapping_ioerror(inode->i_mapping, WRITE, orig_pos, 0,
+				error);
 
 	/*
 	 * We can have dirty bits set past end of file in page_mkwrite path
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index b49fa75eab260a..56e654f2d36fe9 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -55,6 +55,10 @@ static u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
 
 	/* walk all folios in bio, ending page IO on them */
 	bio_for_each_folio_all(fi, bio) {
+		if (ioend->io_error)
+			iomap_mapping_ioerror(inode->i_mapping, WRITE,
+					folio_pos(fi.folio) + fi.offset,
+					fi.length, ioend->io_error);
 		iomap_finish_folio_write(inode, fi.folio, fi.length);
 		folio_count++;
 	}


