Return-Path: <linux-fsdevel+bounces-16689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F608A17D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D0B1C2132C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6FADF42;
	Thu, 11 Apr 2024 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eBNwv00S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACB28F44;
	Thu, 11 Apr 2024 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846983; cv=none; b=UEQDur/22nHENLbIcMx9Fsz7nfqI6stdljePmV7hMt+fcYZlceMryTWbRe6bioUKXF0D0BCX12rP8ewCot51EJBxwpxXsodaxXElbsBo9NbTFss2lavJb/IxRYfbHtbHT5bJAEwXUuqLrcmrZTbrDGwFRoQWJ/AW0GrQAIB0hBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846983; c=relaxed/simple;
	bh=ntuuW0lE6hF+9CuNs6JVToiNPpTMLsWchpxbNlcYx0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTHxuXhDX+4aLGXe+ivDhxsP5BXvquGrkvxAXPj2BrsD1LnrALybG7UQIrAznj647Nm0TDut30PCnJshUW6+0YaWn+VMJc36v7nZcIggbhyuO2sCCHSEMm1VST0Wazv2q0jbNfpeRlAltVa1LLEyJcbN/xKLc4tH+24TEtWy7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eBNwv00S; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RmQ/n07ivg/dAvtDjHhesNyYG4HYYZs4sU7E0j6dTu8=; b=eBNwv00SgNFMI/UWWHbVDgCr0j
	EOUNUfVg5m0BPFQDBVGl38SBX+cHtyKaZOX+xL0BbiVMpv5a/VbQIAwgmVKMqIcd2uXSujm3O4/5O
	0QUuefTyjRR2rQLgQBp/WKSIFEMCJCDuB3T3oG2VlSaaaHQkkVkqSV/WBlGm+S5hX1z1ypqeiaPEU
	dJ2PYzIbGcQG4MAsO0UKN6EaotX1HfEd+xqf5AVuN4qdmCJus94Hm9PkgPJoYRB04RcxU4vgQc32c
	ALmFMQwNHgfeYdP6GhTLID2brblDw139Gu5x6GfomYvTBOCXg14wgLt4KT0gUXW2jBKSG8qAQW6Aq
	hJQ9D5aA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ruvk2-00AYbS-0K;
	Thu, 11 Apr 2024 14:49:30 +0000
Date: Thu, 11 Apr 2024 15:49:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240411144930.GI2118490@ZenIV>
References: <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411140409.GH2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 11, 2024 at 03:04:09PM +0100, Al Viro wrote:
> > lot slimmer and we don't need to care about messing with a lot of that
> > code. I didn't care about making it static inline because that might've
> > meant we need to move other stuff into the header as well. Imho, it's
> > not that important but if it's a big deal to any of you just do the
> > changes on top of it, please.
> > 
> > Pushed to
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.super
> > 
> > If I hear no objections that'll show up in -next tomorrow. Al, would be
> > nice if you could do your changes on top of this, please.
> 
> Objection: start with adding bdev->bd_mapping, next convert the really
> obvious instances to it and most of this series becomes not needed at
> all.
> 
> Really.  There is no need whatsoever to push struct file down all those
> paths.
> 
> And yes, erofs and buffer.c stuff belongs on top of that, no arguments here.

FWIW, here's what you get if this is done in such order:

block/bdev.c                           | 31 ++++++++++++++++++++++---------
block/blk-zoned.c                      |  4 ++--
block/fops.c                           |  4 ++--
block/genhd.c                          |  2 +-
block/ioctl.c                          | 14 ++++++--------
block/partitions/core.c                |  2 +-
drivers/md/bcache/super.c              |  2 +-
drivers/md/dm-vdo/dm-vdo-target.c      |  4 ++--
drivers/md/dm-vdo/indexer/io-factory.c |  2 +-
drivers/mtd/devices/block2mtd.c        |  6 ++++--
drivers/scsi/scsicam.c                 |  2 +-
fs/bcachefs/util.h                     |  5 -----
fs/btrfs/disk-io.c                     |  6 +++---
fs/btrfs/volumes.c                     |  2 +-
fs/btrfs/zoned.c                       |  2 +-
fs/buffer.c                            | 10 +++++-----
fs/cramfs/inode.c                      |  2 +-
fs/ext4/dir.c                          |  2 +-
fs/ext4/ext4_jbd2.c                    |  2 +-
fs/ext4/super.c                        | 24 +++---------------------
fs/gfs2/glock.c                        |  2 +-
fs/gfs2/ops_fstype.c                   |  2 +-
fs/jbd2/journal.c                      |  2 +-
include/linux/blk_types.h              |  1 +
include/linux/blkdev.h                 | 12 ++----------
include/linux/buffer_head.h            |  4 ++--
include/linux/jbd2.h                   |  4 ++--
27 files changed, 69 insertions(+), 86 deletions(-)

The bulk of the changes is straight replacements of foo->bd_inode->i_mapping
with foo->bd_mapping.  That's completely mechanical and that takes out most
of the bd_inode uses.  Anyway, patches in followups

