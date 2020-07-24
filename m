Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F06622BB99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 03:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGXBjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 21:39:17 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:38731 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbgGXBjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 21:39:17 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 71C7F366291;
        Fri, 24 Jul 2020 11:39:12 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jymg2-00028i-T8; Fri, 24 Jul 2020 11:39:10 +1000
Date:   Fri, 24 Jul 2020 11:39:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200724013910.GH2005@dread.disaster.area>
References: <20200720233739.824943-1-satyat@google.com>
 <20200720233739.824943-4-satyat@google.com>
 <20200722211629.GE2005@dread.disaster.area>
 <20200722223404.GA76479@sol.localdomain>
 <20200723220752.GF2005@dread.disaster.area>
 <20200723230345.GB870@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723230345.GB870@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=Sl42X8Ll_owcVs_SU54A:9 a=GBvlyDy58HXx1nsP:21 a=b1TFODAEc1PeXSa0:21
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 23, 2020 at 04:03:45PM -0700, Eric Biggers wrote:
> Hi Dave,
> 
> On Fri, Jul 24, 2020 at 08:07:52AM +1000, Dave Chinner wrote:
> > > > > @@ -183,11 +184,16 @@ static void
> > > > >  iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
> > > > >  		unsigned len)
> > > > >  {
> > > > > +	struct inode *inode = file_inode(dio->iocb->ki_filp);
> > > > >  	struct page *page = ZERO_PAGE(0);
> > > > >  	int flags = REQ_SYNC | REQ_IDLE;
> > > > >  	struct bio *bio;
> > > > >  
> > > > >  	bio = bio_alloc(GFP_KERNEL, 1);
> > > > > +
> > > > > +	/* encrypted direct I/O is guaranteed to be fs-block aligned */
> > > > > +	WARN_ON_ONCE(fscrypt_needs_contents_encryption(inode));
> > > > 
> > > > Which means you are now placing a new constraint on this code in
> > > > that we cannot ever, in future, zero entire blocks here.
> > > > 
> > > > This code can issue arbitrary sized zeroing bios - multiple entire fs blocks
> > > > blocks if necessary - so I think constraining it to only support
> > > > partial block zeroing by adding a warning like this is no correct.
> > > 
> > > In v3 and earlier this instead had the code to set an encryption context:
> > > 
> > > 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> > > 				  GFP_KERNEL);
> > > 
> > > Would you prefer that, even though the call to fscrypt_set_bio_crypt_ctx() would
> > 
> > Actually, I have no idea what that function does. It's not in a
> > 5.8-rc6 kernel, and it's not in this patchset....
> 
> The cover letter mentions that this patchset is based on fscrypt/master.

Which the reader is left to work out where it exists. If you are
going to say "based on", then a pointer to the actual tree like
this:

> That is, "master" of https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git

is somewhat helpful.

> fscrypt_set_bio_crypt_ctx() was introduced by
> "fscrypt: add inline encryption support" on that branch.

Way too much static inline function abstraction.

fscrypt_inode_uses_inline_crypto() ends up being:

	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
	    inode->i_crypt_info->ci_inlinecrypt)

I note there are no checks for inode->i_crypt_info being non-null,
and I note that S_ENCRYPTED is set on the inode when the on-disk
encrypted flag is encountered, not when inode->i_crypt_info is set.

Further, I note that the local variable for ci is fetched before
fscrypt_inode_uses_inline_crypto() is run, so leaving a landmine for
people who try to access ci before checking if inline crypto is
enabled. Or, indeed, if S_ENCRYPTED is set and the crypt_info has
not been set up, fscrypt_set_bio_crypt_ctx() will oops in the DIO
path.

> > > always be a no-op currently (since for now, iomap_dio_zero() will never be
> > > called with an encrypted file) and thus wouldn't be properly tested?
> > 
> > Same can be said for this WARN_ON_ONCE() code :)
> > 
> > But, in the interests of not leaving landmines, if a fscrypt context
> > is needed to be attached to the bio for data IO in direct IO, it
> > should be attached to all bios that are allocated in the dio path
> > rather than leave a landmine for people in future to trip over.
> 
> My concern is that if we were to pass the wrong 'lblk' to
> fscrypt_set_bio_crypt_ctx(), we wouldn't catch it because it's not tested.
> Passing the wrong 'lblk' would cause the data to be encrypted/decrypted
> incorrectly.

When you implement sub-block DIO alignment for fscrypt enabled
filesystems, fsx will tell you pretty quickly if you screwed up....

> Note that currently, I don't think iomap_dio_bio_actor() would handle an
> encrypted file with blocksize > PAGE_SIZE correctly, as the I/O could be split
> in the middle of a filesystem block (even after the filesystem ensures that
> direct I/O on encrypted files is fully filesystem-block-aligned, which we do ---
> see the rest of this patchset), which isn't allowed on encrypted files.

That can already happen unless you've specifically restricted DIO
alignments in the filesystem code. i.e. Direct IO already supports
sub-block ranges and alignment, and we can already do user DIO on
sub-block, sector aligned ranges just fine. And the filesystem can
already split the iomap on sub-block alignments and ranges if it
needs to because the iomap uses byte range addressing, not sector or
block based addressing.

So either you already have a situation where the 2^32 offset can
land *inside* a filesystem block, or the offset is guaranteed to be
filesystem block aligned and so you'll never get this "break an IO
on sub-block alignment" problem regardless of the filesystem block
size...

Either way, it's not an iomap problem - it's a filesystem mapping
problem...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
