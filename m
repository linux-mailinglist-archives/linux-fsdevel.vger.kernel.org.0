Return-Path: <linux-fsdevel+bounces-19916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0049C8CB251
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C366B231B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6C2143C58;
	Tue, 21 May 2024 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mjucqTj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA971CA80
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309540; cv=none; b=gl28+9VZ4SYp4O2GrbcZLuMEIhdL8IXbTbYNapz+XSc2nWrWZfVrEVKXX2BJ4puqGY5td3423xcvTPjm3MgB5QRNAysifFGcQnyEqfcl42zc4QqiYsiIKxBtzJtBs/LOZOU7PEMg5LsT6x+zcT8A9KUnLkyMRjtF1gZXle5mTC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309540; c=relaxed/simple;
	bh=CPzs/UP40xecf1/Pw6WdEcDH3AKdnRjE1l6QOHONDog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dSgk/lTIPXcEiboUg9eGCoOKxyP63ILEYFwPblSBDtsOWmW92rpwGVTy6FyGdgSz0TOJN+4UUjgIi5oY0rAbTB9UnVFSczYr/tUIcjiIKMU595IJx6X0D/wpX4bUsII+gly7ygLI3iuU+6b5aKzVsqay0cCfLQ+CpMljUr8wdcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mjucqTj0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=n7ntk0ibPCFtVLjBSGJKbSJejjqBa1HuQN7ITTwCc/I=; b=mjucqTj0+DI4M2BIHQjHFhA63q
	3c4vsbA/BjAcRFTd2IeZfpmlZ8/hvwoEUqesGzjnEBpQcO9D6G/fYVTvNTilnb5Nf1gDtUE3vLn+s
	6suLshQoy63/Mp35l4/I5W7aYl+CsGONAPariExEB6Hi0aR6jeB/px7GMO2ZL8uqhyvNnqa7gXMw3
	m2z/h0vHguW7B0gHhXdK7ab3WQl1JDEySSwDw/X1JdX7fnSpEPs+xiqTJfY32AQBpeH9m6QVf/stu
	NtHdJ0Hac+FGL5Lrmn8KC3AhpEjg9NM6xSgbqRju6wWg5qcybxnNyyiNRMcPvPTd6VNvh/+gvMKUy
	EEu9/SHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s9SVo-00FPAC-2B;
	Tue, 21 May 2024 16:38:52 +0000
Date: Tue, 21 May 2024 17:38:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai3@huawei.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [git pull] vfs bdev pile 2
Message-ID: <20240521163852.GP2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Next block device series - replacing ->bd_inode (me and Yu Kuai).
Two trivial conflicts (block/ioctl.c and fs/btrfs/disk-io.c); proposed
resolution in #merge-candidate (or in linux-next, for that matter).

The following changes since commit d18a8679581e8d1166b68e211d16c5349ae8c38c:

  make set_blocksize() fail unless block device is opened exclusive (2024-05-02 17:39:44 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-bd_inode-1

for you to fetch changes up to 203c1ce0bb063d1620698e39637b64f2d09c1368:

  RIP ->bd_inode (2024-05-03 02:36:56 -0400)

----------------------------------------------------------------
	bd_inode series

Replacement of bdev->bd_inode with sane(r) set of primitives.

----------------------------------------------------------------
Al Viro (16):
      erofs: switch erofs_bread() to passing offset instead of block number
      erofs_buf: store address_space instead of inode
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

Yu Kuai (4):
      ext4: remove block_device_ejected()
      bcachefs: remove dead function bdev_sectors()
      block2mtd: prevent direct access of bd_inode
      block: move two helpers into bdev.c

 block/bdev.c                           | 66 ++++++++++++++++++++++++----------
 block/blk-zoned.c                      |  4 +--
 block/blk.h                            |  2 ++
 block/fops.c                           |  4 +--
 block/genhd.c                          |  8 ++---
 block/ioctl.c                          | 14 ++++----
 block/partitions/core.c                |  8 ++---
 drivers/md/bcache/super.c              |  2 +-
 drivers/md/dm-vdo/dm-vdo-target.c      |  4 +--
 drivers/md/dm-vdo/indexer/io-factory.c |  2 +-
 drivers/mtd/devices/block2mtd.c        |  6 ++--
 drivers/s390/block/dasd_ioctl.c        |  2 +-
 drivers/scsi/scsicam.c                 |  2 +-
 fs/bcachefs/util.h                     |  5 ---
 fs/btrfs/disk-io.c                     |  6 ++--
 fs/btrfs/volumes.c                     |  2 +-
 fs/btrfs/zoned.c                       |  2 +-
 fs/buffer.c                            | 26 +++++++-------
 fs/cramfs/inode.c                      |  2 +-
 fs/erofs/data.c                        | 12 +++----
 fs/erofs/dir.c                         |  4 +--
 fs/erofs/internal.h                    |  4 +--
 fs/erofs/namei.c                       |  6 ++--
 fs/erofs/super.c                       |  8 ++---
 fs/erofs/xattr.c                       | 37 ++++++++-----------
 fs/erofs/zdata.c                       |  6 ++--
 fs/ext4/dir.c                          |  2 +-
 fs/ext4/ext4_jbd2.c                    |  2 +-
 fs/ext4/super.c                        | 24 ++-----------
 fs/gfs2/glock.c                        |  2 +-
 fs/gfs2/ops_fstype.c                   |  2 +-
 fs/jbd2/journal.c                      |  2 +-
 fs/nilfs2/segment.c                    |  2 +-
 include/linux/blk_types.h              |  2 +-
 include/linux/blkdev.h                 | 12 ++-----
 include/linux/buffer_head.h            |  4 +--
 include/linux/jbd2.h                   |  4 +--
 37 files changed, 145 insertions(+), 157 deletions(-)

