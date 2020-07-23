Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57B922B9E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 01:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgGWXDr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 19:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgGWXDr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:03:47 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620A820792;
        Thu, 23 Jul 2020 23:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595545426;
        bh=QdWGY5VWHK7mBRakapXRiqkUhSKLEr/EpXz7hEPCeOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zgCWqZE8YbJridmeImBcwHYZxkbMVaZPXdjbpZWqRCtqM2u3NGbPlP0/wAzyL4AkR
         aiX3qiKoTwFpxcxzjmEJAbAL0MhuOdBEHs72MaUBwf/aWj0fQiXqfv3NJQyJDKAZJ7
         SfA+wShcolHGd/UxOChRhVHThL3dmPwnezq2IUM0=
Date:   Thu, 23 Jul 2020 16:03:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Satya Tangirala <satyat@google.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200723230345.GB870@sol.localdomain>
References: <20200720233739.824943-1-satyat@google.com>
 <20200720233739.824943-4-satyat@google.com>
 <20200722211629.GE2005@dread.disaster.area>
 <20200722223404.GA76479@sol.localdomain>
 <20200723220752.GF2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723220752.GF2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On Fri, Jul 24, 2020 at 08:07:52AM +1000, Dave Chinner wrote:
> > > > @@ -183,11 +184,16 @@ static void
> > > >  iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
> > > >  		unsigned len)
> > > >  {
> > > > +	struct inode *inode = file_inode(dio->iocb->ki_filp);
> > > >  	struct page *page = ZERO_PAGE(0);
> > > >  	int flags = REQ_SYNC | REQ_IDLE;
> > > >  	struct bio *bio;
> > > >  
> > > >  	bio = bio_alloc(GFP_KERNEL, 1);
> > > > +
> > > > +	/* encrypted direct I/O is guaranteed to be fs-block aligned */
> > > > +	WARN_ON_ONCE(fscrypt_needs_contents_encryption(inode));
> > > 
> > > Which means you are now placing a new constraint on this code in
> > > that we cannot ever, in future, zero entire blocks here.
> > > 
> > > This code can issue arbitrary sized zeroing bios - multiple entire fs blocks
> > > blocks if necessary - so I think constraining it to only support
> > > partial block zeroing by adding a warning like this is no correct.
> > 
> > In v3 and earlier this instead had the code to set an encryption context:
> > 
> > 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> > 				  GFP_KERNEL);
> > 
> > Would you prefer that, even though the call to fscrypt_set_bio_crypt_ctx() would
> 
> Actually, I have no idea what that function does. It's not in a
> 5.8-rc6 kernel, and it's not in this patchset....

The cover letter mentions that this patchset is based on fscrypt/master.

That is, "master" of https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git

fscrypt_set_bio_crypt_ctx() was introduced by
"fscrypt: add inline encryption support" on that branch.

> 
> > always be a no-op currently (since for now, iomap_dio_zero() will never be
> > called with an encrypted file) and thus wouldn't be properly tested?
> 
> Same can be said for this WARN_ON_ONCE() code :)
> 
> But, in the interests of not leaving landmines, if a fscrypt context
> is needed to be attached to the bio for data IO in direct IO, it
> should be attached to all bios that are allocated in the dio path
> rather than leave a landmine for people in future to trip over.

My concern is that if we were to pass the wrong 'lblk' to
fscrypt_set_bio_crypt_ctx(), we wouldn't catch it because it's not tested.
Passing the wrong 'lblk' would cause the data to be encrypted/decrypted
incorrectly.

It's not a big deal though, as it's "obviously correct".  So we can just go
with that if you prefer it.

> 
> > BTW, iomap_dio_zero() is actually limited to one page, so it's not quite
> > "arbitrary sizes".
> 
> Yup, but that's an implentation detail, not a design constraint.
> i.e. I typically review/talk about how stuff functions at a
> design/architecture level, not how it's been implemented in the
> code.
> 
> e.g. block size > page size patches in progress make use of the
> "arbitrary length" capability of the design:
> 
> https://lore.kernel.org/linux-xfs/20181107063127.3902-7-david@fromorbit.com/
> 
> > iomap is used for other filesystem operations too, so we need to consider when
> > to actually do the limiting.  I don't think we should break up the extents
> > returned FS_IOC_FIEMAP, for example.  FIEMAP already has a defined behavior.
> > Also, it would be weird for the list of extents that FIEMAP returns to change
> > depending on whether the filesystem is mounted with '-o inlinecrypt' or not.
> 
> We don't need to care about that in the iomap code. The caller
> controls the behaviour of the mapping callbacks themselves via
> the iomap_ops structure they pass into high level iomap functions.

Sure, I wasn't saying we need to.  I was talking about what we need to do in
ext4.

> 
> > That also avoids any confusion between pages and blocks, which is nice.
> 
> FWIW, the latest version of the above patchset (which,
> co-incidentally, I was bring up to date yesterday) abstracts away
> page and block sizes. It introduces the concept of "chunk size"
> which is calculated from the combination of the current page's size
> and the current inode's block size.
> 
> i.e. in the near future we are going to have both variable page
> sizes (on a per-page basis via Willy's current work) and per-inode
> blocks sizes smaller, the same and larger than the size of the
> current pager. Hence we need to get rid of any assumptions about
> page sizes and block sizes in the iomap code, not introduce new
> ones.
> 
> Hence if there is any limitation of filesystem functionality based
> on block size vs page size, it is going to be up to the filesystem
> to detect and enforce those restrictions, not the iomap
> infrastructure.

Sure, again I was talking about what we'll be doing in ext4, since with the
proposed change, it will be ext4 that does fscrypt_limit_io_blocks().  The limit
is based on blocks, not pages, so "fscrypt_limit_io_pages()" was a bit weird.

Note that currently, I don't think iomap_dio_bio_actor() would handle an
encrypted file with blocksize > PAGE_SIZE correctly, as the I/O could be split
in the middle of a filesystem block (even after the filesystem ensures that
direct I/O on encrypted files is fully filesystem-block-aligned, which we do ---
see the rest of this patchset), which isn't allowed on encrypted files.

However we currently don't support blocksize > PAGE_SIZE in ext4, f2fs, or
fs/crypto/ at all, so I don't think we should add extra logic to fs/iomap/ to
try to handle that case for encrypted files when we'd have no way to test it.

- Eric
