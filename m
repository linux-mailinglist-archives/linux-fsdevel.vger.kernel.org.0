Return-Path: <linux-fsdevel+bounces-19006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39538BF654
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896D928375A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BAF1863E;
	Wed,  8 May 2024 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iOF+OasO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC260171B6
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150128; cv=none; b=LYdI1yQx8PsskztfOEtCMTa5MpKVm6LQB5FvOMFWbGnC9Uf8O3l9snJyTxWx53NsSpt1stMLxR/Oh4Gqc2Cpa9Gk6iJFB0TyZPq0tOIAy4eGpmJ808CQh8Tc/OqwfUxhxn+EKFUleB3e9MA2dD/LHaq65cSF8MNF4bv/LJSLaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150128; c=relaxed/simple;
	bh=AkbmZIH/gcn/gXiOF+0B8Rs+6oj5hYJ+6cepBGhOYq8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=npoeqLP/+NYdN5qfeOFhwOSXD0B8sq8UESX6C5lJC+zGGrcQWFjjAPeyNb8yckDGWVE6oj7LhkjF6uA4LGRMjfLZnwklKv7t3VqhuaC0LFhpNOHSQ0bjNzDaxiTPB0l38pIWBBEPlPMDFKlIsHTXHtLl16hFcsR2IY+9YSZiiSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iOF+OasO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=m+l346SihEYM3jzUpoUE9NiJFBiM9bSEuIxxTsDBnTU=; b=iOF+OasO5stQEatqzHFPfWfMeD
	3uhTavZefOy4YXyv7xOfidG74jZhhdYyMHH8uCFS+kLanHYILXndYp/ZB5a1nP3n5vgZZRxpuGSIl
	dNygVnKwKQ0DUz6TNpiu9EKfPeLRNvWx0PqLt/5mvu1DPKL8wmp8/hoVJFxkdZgLdv6XvaXWmZpTn
	ZOXvTMNOBnyx1XuhUx7BiPJLic3Zjw07T3+n9tbsbbJxdJPjU84na/aJfhhbB6Ual6hyb8b+nWEeV
	qFkFIB5SXIXGy1NguoavJ6oDH1MJV6MyMbX3eS4D9ywbR6Gjx2PMW2tOYEBL+OK7gkXNbBegdu8S0
	hSWo09Tg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4ate-00FvG8-0G;
	Wed, 08 May 2024 06:35:22 +0000
Date: Wed, 8 May 2024 07:35:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCHES] ->bd_inode elimination
Message-ID: <20240508063522.GO2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

There'd been several issues around struct block_device::bd_inode.

It points to coallocated inode and it's unpleasant in several respects.
We definitely need stuff that sits in that sucker, but we need a sane
set of primitives for accessing those.

I've a branch that does, among other things, have ->bd_inode eliminated;
see #bd_inode or #bdev (identical resulting trees) in viro/vfs.git for
the current state of that thing.  The problem is to do it with sane
topology, though.

First, a summary of ->bd_inode users:
	* most of them want the address_space of block device, which is
currently found as ->bd_inode->i_mapping, either directly or with minor
massage.  I've added ->bd_mapping for that.
	* there are several places where gendisk and partition code
wants to unhash or drop the coallocated inode.  Exposure is similar to
add_bdev(); I went for a couple of extra primitives with the same
visibility (bdev_unhash() and bdev_drop()).
	* there are users in block/bdev.c, where we know how block_device
and associated inode are allocated; there we can easily get ->bd_inode
value via container_of().  A couple of existing inline helpers can simply
move there (disk_live() and block_size(); neither is used on hot paths,
so the cost of call is not an issue).
	* there are places that implemented an equivalent of bdev_nr_bytes()
by reading ->i_size of associated inode.  Might as well use bdev_nr_bytes()
and be done with that.
	* 2 oddballs - nilfs_attach_log_writer() and dasd_format().  Both
want the associated inode.  I'm somewhat suspicious about the former
(looks like it might be a layering violation) and there's definitely
quite a few things wrong about the latter.  Neither is on the fast
path; I went for ->bd_mapping->host, admittedly unidiomatic there.
	* there's some outright dead code.

And that's it.  The main problem is keeping topology sane.  A part of
that had been in vfs/vfs.git#vfs.super, and the things would be easier
if we could replace that pile.

#work.bd_inode is the variant keeping vfs.super as-is; identical tree
with saner topology is in #work.bdev and IMO it makes a lot more sense.

#work.bdev starts at #work.set_blocksize (as posted); what follows is
	* cleanups, dead code elimination and adding missing primitives
7 commits, all but the last one reordered from current vfs.super;
some of that from me, some from Yu Kuai.  The tip of that is #work.bd_inode-0
	* merge-in of invariant branch with 2 erofs patches (#misc.erofs,
as posted and acked by erofs maintainer)
	* After that merge we have ->bd_mapping introduction and conversions,
handling of ->bd_inode users in block/bdev.c, followed by nilfs and s390
oddballs handling and finally removal of now-unused ->bd_inode.
That's #work.bd_inode-1.  Several of those are close to ones currently
in vfs.super.
	* merge with #work.bd_flags-2 (as posted).

Please, review.  Individual patches (on #work.bd_inode-{0,1}; #misc.erofs
and work.{set_blocksize,bd_flags-2} had been already posted) in followups.

I think the series makes more sense in this form; the downside is that
it replaces the current vfs/vfs.git#vfs.super, but AFAICS nothings other
than vfs.all pulls from that, so it's not too drastic.

Overall shortlog:
Al Viro (34):
      erofs: switch erofs_bread() to passing offset instead of block number
      erofs_buf: store address_space instead of inode
      bcache_register(): don't bother with set_blocksize()
      pktcdvd: sort set_blocksize() calls out
      swapon(2)/swapoff(2): don't bother with block size
      swapon(2): open swap with O_EXCL
      zram: don't bother with reopening - just use O_EXCL for open
      swsusp: don't bother with setting block size
      btrfs_get_bdev_and_sb(): call set_blocksize() only for exclusive opens
      set_blocksize(): switch to passing struct file *
      make set_blocksize() fail unless block device is opened exclusive
      Use bdev_is_paritition() instead of open-coding it
      wrapper for access to ->bd_partno
      bdev: infrastructure for flags
      bdev: move ->bd_read_only to ->__bd_flags
      bdev: move ->bd_write_holder into ->__bd_flags
      bdev: move ->bd_has_subit_bio to ->__bd_flags
      bdev: move ->bd_ro_warned to ->__bd_flags
      bdev: move ->bd_make_it_fail to ->__bd_flags
      blkdev_write_iter(): saner way to get inode and bdev
      dm-vdo: use bdev_nr_bytes(bdev) instead of i_size_read(bdev->bd_inode)
      missing helpers: bdev_unhash(), bdev_drop()
      Merge branch 'misc.erofs' into work.bdev
      block_device: add a pointer to struct address_space (page cache of bdev)
      use ->bd_mapping instead of ->bd_inode->i_mapping
      grow_dev_folio(): we only want ->bd_inode->i_mapping there
      blk_ioctl_{discard,zeroout}(): we only want ->bd_inode->i_mapping here...
      fs/buffer.c: massage the remaining users of ->bd_inode to ->bd_mapping
      gfs2: more obvious initializations of mapping->host
      block/bdev.c: use the knowledge of inode/bdev coallocation
      nilfs_attach_log_writer(): use ->bd_mapping->host instead of ->bd_inode
      dasd_format(): killing the last remaining user of ->bd_inode
      RIP ->bd_inode
      Merge branch 'work.bd_flags-2' into work.bdev

Yu Kuai (4):
      ext4: remove block_device_ejected()
      bcachefs: remove dead function bdev_sectors()
      block2mtd: prevent direct access of bd_inode
      block: move two helpers into bdev.c

Diffstat:

 Documentation/filesystems/porting.rst  |  7 +++
 block/bdev.c                           | 97 +++++++++++++++++++++++-----------
 block/blk-core.c                       | 17 +++---
 block/blk-mq.c                         |  2 +-
 block/blk-zoned.c                      |  4 +-
 block/blk.h                            |  2 +
 block/early-lookup.c                   |  2 +-
 block/fops.c                           |  4 +-
 block/genhd.c                          | 23 ++++----
 block/ioctl.c                          | 40 +++++++-------
 block/partitions/core.c                | 20 +++----
 drivers/block/pktcdvd.c                |  7 +--
 drivers/block/zram/zram_drv.c          | 29 +++-------
 drivers/block/zram/zram_drv.h          |  2 +-
 drivers/md/bcache/super.c              |  6 +--
 drivers/md/dm-vdo/dm-vdo-target.c      |  4 +-
 drivers/md/dm-vdo/indexer/io-factory.c |  2 +-
 drivers/mtd/devices/block2mtd.c        |  6 ++-
 drivers/s390/block/dasd_ioctl.c        |  2 +-
 drivers/scsi/scsicam.c                 |  2 +-
 fs/bcachefs/util.h                     |  5 --
 fs/btrfs/dev-replace.c                 |  2 +-
 fs/btrfs/disk-io.c                     |  6 +--
 fs/btrfs/volumes.c                     | 15 +++---
 fs/btrfs/zoned.c                       |  2 +-
 fs/buffer.c                            | 26 ++++-----
 fs/cramfs/inode.c                      |  2 +-
 fs/erofs/data.c                        | 12 ++---
 fs/erofs/dir.c                         |  4 +-
 fs/erofs/internal.h                    |  4 +-
 fs/erofs/namei.c                       |  6 +--
 fs/erofs/super.c                       |  8 +--
 fs/erofs/xattr.c                       | 37 +++++--------
 fs/erofs/zdata.c                       |  6 +--
 fs/ext4/dir.c                          |  2 +-
 fs/ext4/ext4_jbd2.c                    |  2 +-
 fs/ext4/super.c                        | 26 ++-------
 fs/gfs2/glock.c                        |  2 +-
 fs/gfs2/ops_fstype.c                   |  2 +-
 fs/jbd2/journal.c                      |  2 +-
 fs/nilfs2/segment.c                    |  2 +-
 fs/reiserfs/journal.c                  |  5 +-
 fs/xfs/xfs_buf.c                       |  2 +-
 include/linux/blk_types.h              | 19 +++----
 include/linux/blkdev.h                 | 40 +++++++++-----
 include/linux/buffer_head.h            |  4 +-
 include/linux/jbd2.h                   |  4 +-
 include/linux/part_stat.h              |  2 +-
 include/linux/swap.h                   |  2 -
 kernel/power/swap.c                    |  7 +--
 lib/vsprintf.c                         |  4 +-
 mm/swapfile.c                          | 29 +---------
 52 files changed, 275 insertions(+), 294 deletions(-)

