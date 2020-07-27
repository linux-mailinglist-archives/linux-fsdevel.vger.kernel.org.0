Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9F622E426
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 04:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgG0C7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 22:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgG0C7t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 22:59:49 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D97E204EA;
        Mon, 27 Jul 2020 02:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595818788;
        bh=6VsbD9L/bKNxYlOOkshUhbWnCY7Jw3yGIZKV+/p6WHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROOfzvIfVMpRQEJLZWPEzo8LYx85Zxn/pM8XtRf/VRrr3VtRv3Pmx6tK7aXCfbSYf
         S6/eKyb1opVWxXT3i5ldAs/v3xtl6cBd5CypAS4gjNc/Ro1hbyvODZ/BE4WQcxbHXG
         mLrZESYgIHSRa9fIb2+MbwxjYjCjrPNEGC6Tfn+8=
Date:   Sun, 26 Jul 2020 19:59:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Satya Tangirala <satyat@google.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 1/7] fscrypt: Add functions for direct I/O support
Message-ID: <20200727025946.GA29423@sol.localdomain>
References: <20200724184501.1651378-1-satyat@google.com>
 <20200724184501.1651378-2-satyat@google.com>
 <20200725001441.GQ2005@dread.disaster.area>
 <20200726024920.GB14321@sol.localdomain>
 <20200727005848.GV2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727005848.GV2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:58:48AM +1000, Dave Chinner wrote:
> On Sat, Jul 25, 2020 at 07:49:20PM -0700, Eric Biggers wrote:
> > On Sat, Jul 25, 2020 at 10:14:41AM +1000, Dave Chinner wrote:
> > > > +bool fscrypt_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
> > > > +{
> > > > +	const struct inode *inode = file_inode(iocb->ki_filp);
> > > > +	const unsigned int blocksize = i_blocksize(inode);
> > > > +
> > > > +	/* If the file is unencrypted, no veto from us. */
> > > > +	if (!fscrypt_needs_contents_encryption(inode))
> > > > +		return true;
> > > > +
> > > > +	/* We only support direct I/O with inline crypto, not fs-layer crypto */
> > > > +	if (!fscrypt_inode_uses_inline_crypto(inode))
> > > > +		return false;
> > > > +
> > > > +	/*
> > > > +	 * Since the granularity of encryption is filesystem blocks, the I/O
> > > > +	 * must be block aligned -- not just disk sector aligned.
> > > > +	 */
> > > > +	if (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter), blocksize))
> > > > +		return false;
> > > 
> > > Doesn't this force user buffers to be filesystem block size aligned,
> > > instead of 512 byte aligned as is typical for direct IO?
> > > 
> > > That's going to cause applications that work fine on normal
> > > filesystems becaues the memalign() buffers to 512 bytes or logical
> > > block device sector sizes (as per the open(2) man page) to fail on
> > > encrypted volumes, and it's not going to be obvious to users as to
> > > why this happens.
> > 
> > The status quo is that direct I/O on encrypted files falls back to buffered I/O.
> 
> Largely irrelevant.
> 
> You claimed in another thread that performance is a key feature that
> inline encryption + DIO provides. Now you're implying that failing
> to provide that performance doesn't really matter at all.
> 
> > So this patch is strictly an improvement; it's making direct I/O work in a case
> > where previously it didn't work.
> 
> Improvements still need to follow longstanding conventions. And,
> IMO, it's not an improvement if the feature results in 
> unpredictable performance for userspace applications.
> 
> i.e. there is no point in enabling direct IO if it is unpredictably
> going to fall back to the buffered IO path when applications are
> coded to the guidelines the man page said they should use. Such
> problems are an utter PITA to diagnose in the field, and on those
> grounds alone the current implementation gets a NACK.
> 
> > Note that there are lots of other cases where ext4 and f2fs fall back to
> > buffered I/O; see ext4_dio_supported() and f2fs_force_buffered_io().  So this
> > isn't a new problem.
> 
> No shit, sherlock. But that's also irrelevant to the discussion at
> hand - claiming "we can fall back to buffered IO" doesn't address
> the problem I've raised. It's just an excuse for not fixing it.

Actually we never specifically discussed the motivation for DIO on encrypted
files, but yes there are some specific applications that need it for performance
reasons (e.g., zram writeback to a loop device backed by an encrypted file), as
well as benchmarking applications.  These applications aren't expected to have
much trouble (if any) dealing with a fs blocksize alignment requirement.

We always try to make encrypted files behave just like unencrypted files, but
sometimes it's just not possible to do so.  We document the exceptions in
Documentation/filesystems/fscrypt.rst, which this patchset updates to document
the conditions for direct I/O working.  Note that these conditions include more
than just the alignment requirement.

The open() man page does mention that O_DIRECT I/O typically needs to be aligned
to logical_block_size; however it also says "In Linux alignment restrictions
vary by filesystem and kernel version and might be absent entirely."

The other examples of falling back to buffered I/O are relevant, since they show
that similar issues are already being dealt with in the (rare) use cases of
O_DIRECT.  So I don't think the convention is as strong as you think it is...

> Indeed, the problem is easy to fix - fscrypt only cares that the
> user IO offset and length is DUN aligned.  fscrypt does not care
> that the user memory buffer is filesystem block aligned - user
> memory buffer alignment is an underlying hardware DMA constraint -
> and so fscrypt_dio_supported() needs to relax or remove the user
> memroy buffer alignment constraint so that it follows existing
> conventions....

Relaxing the user buffer alignment requirement would mean that a single
encryption data unit could be discontiguous in memory.  I'm not sure that's
allowed -- it *might* be, but we'd have to verify it on every vendor's inline
encryption hardware, as well as handle this case in block/blk-crypto-fallback.c.
It's much easier to just require proper alignment.

Also, would relaxing the user buffer alignment really address your concern,
given that the file offset and length would still have to be fs-block aligned?
Applications might also align the offset and length to logical_block_size only.

So I don't see how this is "easy to fix" at all, other than by limiting direct
I/O support to data_unit_size == logical_block_size (which we could do for now
if it gets you to stop nacking the DIO patches, though I'm pretty sure that
restriction won't work for some people so would need to be re-visited later...).

- Eric
