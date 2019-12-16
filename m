Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFA41205FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 13:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfLPMmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 07:42:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:60066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727512AbfLPMmB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:42:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C273AF59;
        Mon, 16 Dec 2019 12:41:59 +0000 (UTC)
Date:   Mon, 16 Dec 2019 06:41:55 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, dsterba@suse.cz,
        jthumshirn@suse.de, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/8 v6] btrfs direct-io using iomap
Message-ID: <20191216124155.htq6dhtvrqdrfc3s@fiona>
References: <20191213195750.32184-1-rgoldwyn@suse.de>
 <0cfcbf67-8bca-8d55-6d7e-b79e5e5f66c0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cfcbf67-8bca-8d55-6d7e-b79e5e5f66c0@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On  2:01 16/12, Nikolay Borisov wrote:
> 
> 
> On 13.12.19 г. 21:57 ч., Goldwyn Rodrigues wrote:
> > This is an effort to use iomap for direct I/O in btrfs. This would
> > change the call from __blockdev_direct_io() to iomap_dio_rw().
> > 
> > The main objective is to lose the buffer head and use bio defined by
> > iomap code, and hopefully to use more of generic-FS codebase.
> > 
> > These patches are based and tested on v5.5-rc1. I have tested it against
> > xfstests/btrfs.
> > 
> > The tree is available at
> > https://github.com/goldwynr/linux/tree/btrfs-iomap-dio
> > 
> > Changes since v1
> > - Incorporated back the efficiency change for inode locking
> > - Review comments about coding style and git comments
> > - Merge related patches into one
> > - Direct read to go through btrfs_direct_IO()
> > - Removal of no longer used function dio_end_io()
> > 
> > Changes since v2
> > - aligning iomap offset/length to the position/length of I/O
> > - Removed btrfs_dio_data
> > - Removed BTRFS_INODE_READDIO_NEED_LOCK
> > - Re-incorporating write efficiency changes caused lockdep_assert() in
> >   iomap to be triggered, remove that code.
> > 
> > Changes since v3
> > - Fixed freeze on generic/095. Use iomap_end() to account for
> >   failed/incomplete dio instead of btrfs_dio_data
> > 
> > Changes since v4
> > - moved lockdep_assert_held() to functions calling iomap_dio_rw()
> >   This may be called immidiately after calling inode lock and
> >   may feel not required, but it seems important.
> > - Removed comments which are no longer required
> > - Changed commit comments to make them more appropriate
> > 
> > Changes since v5
> > - restore inode_dio_wait() in truncate
> 
> I'm confused about this - you no longer call inode_dio_begin after patch
> 4/8 so inode_dio_wait which is left intact in truncate can never trigger
> a wait really. Exclusion is provided by the fact that btrfs_direct_IO is
> called with rwsem held shared and truncate holds it exclusive? So what
> necessitated restoring inode_dio_wait?

The optimization of the write path of direct I/O. The rwsem is
released if write is within i_size. This is also the reason we
removed lockdep_assert_held().

Reference: 38851cc19adb ("Btrfs: implement unlocked dio write")

This was inspired by ext4. However, ext4 after it's switch to
iomap_dio_rw() does not employ this optimization.

> 
> 
> Another point, I don't see whether you have explicitly addressed
> concerns raised in:
> 
> https://lore.kernel.org/linux-btrfs/20191212003043.31093-1-rgoldwyn@suse.de/T/#me7f96506e5a1d921d05b76d01ecf6ea1ebcea594

I did address it by releasing csums (referring io_bio) before calling
bio_endio().


-- 
Goldwyn
