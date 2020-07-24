Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6A22BD7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 07:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgGXFbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 01:31:37 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:46979 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgGXFbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:31:37 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 3E0F1D7ADE7;
        Fri, 24 Jul 2020 15:31:32 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jyqIs-0003Xl-Rk; Fri, 24 Jul 2020 15:31:30 +1000
Date:   Fri, 24 Jul 2020 15:31:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200724053130.GO2005@dread.disaster.area>
References: <20200720233739.824943-1-satyat@google.com>
 <20200720233739.824943-4-satyat@google.com>
 <20200722211629.GE2005@dread.disaster.area>
 <20200722223404.GA76479@sol.localdomain>
 <20200723220752.GF2005@dread.disaster.area>
 <20200723230345.GB870@sol.localdomain>
 <20200724013910.GH2005@dread.disaster.area>
 <20200724034628.GC870@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724034628.GC870@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QKgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=7-415B0cAAAA:8
        a=qgdjzU_bvmtCALAiQDgA:9 a=abFM6lBaT0MdK4Jk:21 a=bpKwr00CVUWniEzF:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 23, 2020 at 08:46:28PM -0700, Eric Biggers wrote:
> On Fri, Jul 24, 2020 at 11:39:10AM +1000, Dave Chinner wrote:
> > fscrypt_inode_uses_inline_crypto() ends up being:
> > 
> > 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
> > 	    inode->i_crypt_info->ci_inlinecrypt)
> > 
> > I note there are no checks for inode->i_crypt_info being non-null,
> > and I note that S_ENCRYPTED is set on the inode when the on-disk
> > encrypted flag is encountered, not when inode->i_crypt_info is set.
> > 
> 
> ->i_crypt_info is set when the file is opened, so it's guaranteed to be set for
> any I/O.  So the case you're concerned about just doesn't happen.

Ok. The connection is not obvious to someone who doesn't know the
fscrypt code inside out.

> > > Note that currently, I don't think iomap_dio_bio_actor() would handle an
> > > encrypted file with blocksize > PAGE_SIZE correctly, as the I/O could be split
> > > in the middle of a filesystem block (even after the filesystem ensures that
> > > direct I/O on encrypted files is fully filesystem-block-aligned, which we do ---
> > > see the rest of this patchset), which isn't allowed on encrypted files.
> > 
> > That can already happen unless you've specifically restricted DIO
> > alignments in the filesystem code. i.e. Direct IO already supports
> > sub-block ranges and alignment, and we can already do user DIO on
> > sub-block, sector aligned ranges just fine. And the filesystem can
> > already split the iomap on sub-block alignments and ranges if it
> > needs to because the iomap uses byte range addressing, not sector or
> > block based addressing.
> > 
> > So either you already have a situation where the 2^32 offset can
> > land *inside* a filesystem block, or the offset is guaranteed to be
> > filesystem block aligned and so you'll never get this "break an IO
> > on sub-block alignment" problem regardless of the filesystem block
> > size...
> > 
> > Either way, it's not an iomap problem - it's a filesystem mapping
> > problem...
> > 
> 
> I think you're missing the point here.  Currently, the granularity of encryption
> (a.k.a. "data unit size") is always filesystem blocks, so that's the minimum we
> can directly read or write to an encrypted file.  This has nothing to do with
> the IV wraparound case also being discussed.

So when you change the subject, please make it *really obvious* so
that people don't think you are still talking about the same issue.

> For example, changing a single bit in the plaintext of a filesystem block may
> result in the entire block's ciphertext changing.  (The exact behavior depends
> on the cryptographic algorithm that is used.)
> 
> That's why this patchset makes ext4 only allow direct I/O on encrypted files if
> the I/O is fully filesystem-block-aligned.  Note that this might be a more
> strict alignment requirement than the bdev_logical_block_size().
> 
> As long as the iomap code only issues filesystem-block-aligned bios, *given
> fully filesystem-block-aligned inputs*, we're fine.  That appears to be the case
> currently.

The actual size and shape of the bios issued by direct IO (both old
code and newer iomap code) is determined by the user supplied iov,
the size of the biovec array allocated in the bio, and the IO
constraints of the underlying hardware.  Hence direct IO does not
guarantee alignment to anything larger than the underlying block
device logical sector size because there's no guarantee when or
where a bio will fill up.

To guarantee alignment of what ends up at the hardware, you have to
set the block device parameters (e.g. logical sector size)
appropriately all the way down the stack. You also need to ensure
that the filesystem is correctly aligned on the block device so that
filesystem blocks don't overlap things like RAID stripe boundaires,
linear concat boundaries, etc.

IOWs, to constrain alignment in the IO path, you need to configure
you system correct so that the information provided to iomap for IO
alignment matches your requirements. This is not somethign iomap can
do itself; everything from above needs to be constrained by the
filesystem using iomap, everything sent below by iomap is
constrained by the block device config.

> (It's possible that in the future we'll support other encryption data unit
> sizes, perhaps powers of 2 from 512 to filesystem block size.  But for now the
> filesystem block size has been good enough for everyone,

Not the case. fscrypt use in enterprise environments needs support
for block size < page size so that it can be deployed on 64kB page
size machines without requiring 64kB filesystem block sizes.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
