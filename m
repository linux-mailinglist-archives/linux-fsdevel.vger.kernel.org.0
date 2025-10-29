Return-Path: <linux-fsdevel+bounces-66191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 365CDC18A48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C443353E38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A183128BA;
	Wed, 29 Oct 2025 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="muQJMkz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5416130F939;
	Wed, 29 Oct 2025 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722163; cv=none; b=dBL9SCj9Vfc0ubvlOVQ1/HYjgDkbcsqKkwi6RIhiWXjeLkopJo7QbMc7CSdjMzWy37DD0cIdcDT42j3urymdj2o2twfXOfEBnSlZ45qUJAbDRbalUJs6RJ2klVXOZbc6JKcFfCae+feTV4paijAOJArkYNEzZmLL6fXK0KbJG+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722163; c=relaxed/simple;
	bh=GOd3ui4Sf9Ms7Ml5Zi1YKzu0XpP9PoFd0kbwMQWteB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atd6BuW1Imtwcz6X5Xqj3rjNBHLXFc5oZS1cg5Vycj6vPYSBj8WGC86Ig85ptKoio/Lt8/12n5UkzT08NA6mjeUFO2PGuuzUuXVY6+oDarxZ6JZZ8Kup84u2SZanFvrJE6nr5bRC/v3yo8OHZuvfdh6BNQP/R1lQdgemwsdQwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=muQJMkz2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WAeYAW13Gs4vIYQTjlchZDoChHw1dWJHa2N+94ZGEls=; b=muQJMkz2qngF5q7T3tuhioPi+n
	M/kn6Nev2tt73F/FBlwgZfI+acxoUnpZ/U3zpUoVJpsllluH5+jbJTVfVUYgs0EWrE7i/jSVV9/jO
	dukGvAcBqE95rwG/6JgJ4/FmXvQTpxVkLuoiWN7AkgiKTdQvqbxfPSPJzY/eWOZJFOZGL6xzIiCv1
	YpdGcU6lIcfF+7uxHEaq5vtJCinza4QMhygS0aldydjvhRdOM0W+pt6GNPi96TZrsl8tYbfR6vZND
	62iEeStfsyuU5tblDNYULrwCkxI0dN6zwR6sqd03VIG8Eh6CocdiT2DOCT/5z5nM7c10Gg3GvwE4t
	37rJQApQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE0PY-000000002fV-1w9R;
	Wed, 29 Oct 2025 07:16:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when stable writes are required
Date: Wed, 29 Oct 2025 08:15:05 +0100
Message-ID: <20251029071537.1127397-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029071537.1127397-1-hch@lst.de>
References: <20251029071537.1127397-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Inodes can be marked as requiring stable writes, which is a setting
usually inherited from block devices that require stable writes.  Block
devices require stable writes when the drivers have to sample the data
more than once, e.g. to calculate a checksum or parity in one pass, and
then send the data on to a hardware device, and modifying the data
in-flight can lead to inconsistent checksums or parity.

For buffered I/O, the writeback code implements this by not allowing
modifications while folios are marked as under writeback, but for
direct I/O, the kernel currently does not have any way to prevent the
user application from modifying the in-flight memory, so modifications
can easily corrupt data despite the block driver setting the stable
write flag.  Even worse, corruption can happen on reads as well,
where concurrent modifications can cause checksum mismatches, or
failures to rebuild parity.  One application known to trigger this
behavior is Qemu when running Windows VMs, but there might be many
others as well.  xfstests can also hit this behavior, not only in the
specifically crafted patch for this (generic/761), but also in
various other tests that mostly stress races between different I/O
modes, which generic/095 being the most trivial and easy to hit
one.

Fix XFS to fall back to uncached buffered I/O when the block device
requires stable writes to fix these races.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c | 54 +++++++++++++++++++++++++++++++++++++++--------
 fs/xfs/xfs_iops.c |  6 ++++++
 2 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e09ae86e118e..0668af07966a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -230,6 +230,12 @@ xfs_file_dio_read(
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
 	ssize_t			ret;
 
+	if (mapping_stable_writes(iocb->ki_filp->f_mapping)) {
+		xfs_info_once(ip->i_mount,
+			"falling back from direct to buffered I/O for read");
+		return -ENOTBLK;
+	}
+
 	trace_xfs_file_direct_read(iocb, to);
 
 	if (!iov_iter_count(to))
@@ -302,13 +308,22 @@ xfs_file_read_iter(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
-	if (IS_DAX(inode))
+	if (IS_DAX(inode)) {
 		ret = xfs_file_dax_read(iocb, to);
-	else if (iocb->ki_flags & IOCB_DIRECT)
+		goto done;
+	}
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = xfs_file_dio_read(iocb, to);
-	else
-		ret = xfs_file_buffered_read(iocb, to);
+		if (ret != -ENOTBLK)
+			goto done;
+
+		iocb->ki_flags &= ~IOCB_DIRECT;
+		iocb->ki_flags |= IOCB_DONTCACHE;
+	}
 
+	ret = xfs_file_buffered_read(iocb, to);
+done:
 	if (ret > 0)
 		XFS_STATS_ADD(mp, xs_read_bytes, ret);
 	return ret;
@@ -883,6 +898,7 @@ xfs_file_dio_write(
 	struct iov_iter		*from)
 {
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
+	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
 	size_t			count = iov_iter_count(from);
 
@@ -890,15 +906,21 @@ xfs_file_dio_write(
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
 		return -EINVAL;
 
+	if (mapping_stable_writes(iocb->ki_filp->f_mapping)) {
+		xfs_info_once(mp,
+			"falling back from direct to buffered I/O for write");
+		return -ENOTBLK;
+	}
+
 	/*
 	 * For always COW inodes we also must check the alignment of each
 	 * individual iovec segment, as they could end up with different
 	 * I/Os due to the way bio_iov_iter_get_pages works, and we'd
 	 * then overwrite an already written block.
 	 */
-	if (((iocb->ki_pos | count) & ip->i_mount->m_blockmask) ||
+	if (((iocb->ki_pos | count) & mp->m_blockmask) ||
 	    (xfs_is_always_cow_inode(ip) &&
-	     (iov_iter_alignment(from) & ip->i_mount->m_blockmask)))
+	     (iov_iter_alignment(from) & mp->m_blockmask)))
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
 	if (xfs_is_zoned_inode(ip))
 		return xfs_file_dio_write_zoned(ip, iocb, from);
@@ -1555,10 +1577,24 @@ xfs_file_open(
 {
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
+
+	/*
+	 * If the underlying devices requires stable writes, we have to fall
+	 * back to (uncached) buffered I/O for direct I/O reads and writes, as
+	 * the kernel can't prevent applications from modifying the memory under
+	 * I/O.  We still claim to support O_DIRECT as we want opens for that to
+	 * succeed and fall back.
+	 *
+	 * As atomic writes are only supported for direct I/O, they can't be
+	 * supported either in this case.
+	 */
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	file->f_mode |= FMODE_DIO_PARALLEL_WRITE;
-	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
-		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+	if (!mapping_stable_writes(file->f_mapping)) {
+		file->f_mode |= FMODE_DIO_PARALLEL_WRITE;
+		if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
+			file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+	}
+
 	return generic_file_open(inode, file);
 }
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index caff0125faea..bd49ac6b31de 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -672,6 +672,12 @@ xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
+	/*
+	 * If the stable writes flag is set, we have to fall back to buffered
+	 * I/O, which doesn't support atomic writes.
+	 */
+	if (mapping_stable_writes(VFS_I(ip)->i_mapping))
+		return;
 	generic_fill_statx_atomic_writes(stat,
 			xfs_get_atomic_write_min(ip),
 			xfs_get_atomic_write_max(ip),
-- 
2.47.3


