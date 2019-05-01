Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38110F01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 00:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfEAW3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 18:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfEAW3E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 18:29:04 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7F2C20866;
        Wed,  1 May 2019 22:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556749743;
        bh=DNViizN6P2o3YEnj0ekosIH6Z4fUZ1Gf+JDOu+zxrnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KDTpRBYamNpGPwCp+oajBSC5O2LZwiPf3aogDTxbp+vvSmN9AWbZSJmeroOjKjNow
         RfV/RqyzlntRrFMuYmc4fkj4YkbCTPnBo1Q6Yxn3c2BdWPnPeDgYPSl8AFyEbwKFS1
         gwV44fVLTMpF95pPhBaP0R6wD2FcOE5uymjLmV74=
Date:   Wed, 1 May 2019 15:29:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chandan Rajendra <chandan@linux.ibm.com>
Cc:     tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
        hch@infradead.org, linux-fscrypt@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH V2 10/13] fscrypt_encrypt_page: Loop across
 all blocks mapped by a page range
Message-ID: <20190501222859.GA127264@gmail.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
 <20190430171133.GC48973@gmail.com>
 <20190430230840.GE48973@gmail.com>
 <4666731.7CFakFE75r@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4666731.7CFakFE75r@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chandan,

On Wed, May 01, 2019 at 08:19:35PM +0530, Chandan Rajendra wrote:
> On Wednesday, May 1, 2019 4:38:41 AM IST Eric Biggers wrote:
> > On Tue, Apr 30, 2019 at 10:11:35AM -0700, Eric Biggers wrote:
> > > On Sun, Apr 28, 2019 at 10:01:18AM +0530, Chandan Rajendra wrote:
> > > > For subpage-sized blocks, this commit now encrypts all blocks mapped by
> > > > a page range.
> > > > 
> > > > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> > > > ---
> > > >  fs/crypto/crypto.c | 37 +++++++++++++++++++++++++------------
> > > >  1 file changed, 25 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> > > > index 4f0d832cae71..2d65b431563f 100644
> > > > --- a/fs/crypto/crypto.c
> > > > +++ b/fs/crypto/crypto.c
> > > > @@ -242,18 +242,26 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
> > > 
> > > Need to update the function comment to clearly explain what this function
> > > actually does now.
> > > 
> > > >  {
> > > >  	struct fscrypt_ctx *ctx;
> > > >  	struct page *ciphertext_page = page;
> > > > +	int i, page_nr_blks;
> > > >  	int err;
> > > >  
> > > >  	BUG_ON(len % FS_CRYPTO_BLOCK_SIZE != 0);
> > > >  
> > > 
> > > Make a 'blocksize' variable so you don't have to keep calling i_blocksize().
> > > 
> > > Also, you need to check whether 'len' and 'offs' are filesystem-block-aligned,
> > > since the code now assumes it.
> > > 
> > > 	const unsigned int blocksize = i_blocksize(inode);
> > > 
> > >         if (!IS_ALIGNED(len | offs, blocksize))
> > >                 return -EINVAL;
> > > 
> > > However, did you check whether that's always true for ubifs?  It looks like it
> > > may expect to encrypt a prefix of a block, that is only padded to the next
> > > 16-byte boundary.
> > > 		
> > > > +	page_nr_blks = len >> inode->i_blkbits;
> > > > +
> > > >  	if (inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES) {
> > > >  		/* with inplace-encryption we just encrypt the page */
> > > > -		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num, page,
> > > > -					     ciphertext_page, len, offs,
> > > > -					     gfp_flags);
> > > > -		if (err)
> > > > -			return ERR_PTR(err);
> > > > -
> > > > +		for (i = 0; i < page_nr_blks; i++) {
> > > > +			err = fscrypt_do_page_crypto(inode, FS_ENCRYPT,
> > > > +						lblk_num, page,
> > > > +						ciphertext_page,
> > > > +						i_blocksize(inode), offs,
> > > > +						gfp_flags);
> > > > +			if (err)
> > > > +				return ERR_PTR(err);
> > 
> > Apparently ubifs does encrypt data shorter than the filesystem block size, so
> > this part is wrong.
> > 
> > I suggest we split this into two functions, fscrypt_encrypt_block_inplace() and
> > fscrypt_encrypt_blocks(), so that it's conceptually simpler what each function
> > does.  Currently this works completely differently depending on whether the
> > filesystem set FS_CFLG_OWN_PAGES in its fscrypt_operations, which is weird.
> > 
> > I also noticed that using fscrypt_ctx for writes seems to be unnecessary.
> > AFAICS, page_private(bounce_page) could point directly to the pagecache page.
> > That would simplify things a lot, especially since then fscrypt_ctx could be
> > removed entirely after you convert reads to use read_callbacks_ctx.
> > 
> > IMO, these would be worthwhile cleanups for fscrypt by themselves, without
> > waiting for the read_callbacks stuff to be finalized.  Finalizing the
> > read_callbacks stuff will probably require reaching a consensus about how they
> > should work with future filesystem features like fsverity and compression.
> > 
> > So to move things forward, I'm considering sending out a series with the above
> > cleanups for fscrypt, plus the equivalent of your patches:
> > 
> > 	"fscrypt_encrypt_page: Loop across all blocks mapped by a page range"
> > 	"fscrypt_zeroout_range: Encrypt all zeroed out blocks of a page"
> > 	"Add decryption support for sub-pagesized blocks" (fs/crypto/ part only)
> > 
> > Then hopefully we can get all that applied for 5.3 so that fs/crypto/ itself is
> > ready for blocksize != PAGE_SIZE; and get your changes to ext4_bio_write_page(),
> > __ext4_block_zero_page_range(), and ext4_block_write_begin() applied too, so
> > that ext4 is partially ready for encryption with blocksize != PAGE_SIZE.
> > 
> > Then only the read_callbacks stuff will remain, to get encryption support into
> > fs/mpage.c and fs/buffer.c.  Do you think that's a good plan?
> 
> Hi Eric,
> 
> IMHO, I will continue posting the next version of the current patchset and if
> there are no serious reservations from FS maintainers the "read callbacks"
> patchset can be merged. In such a scenario, the cleanups being
> non-complicated, can be merged later.
> 
> -- 
> chandan
> 

Most of the patches I have in mind are actually things that are in your patchset
already, or have been requested, or will be requested eventually :-).  I'm
concerned that people will keep going back and forth on this patchset for a lot
longer, arguing about fsverity, compression, details of the fs/crypto/ stuff,
etc.  Moreover it's based on unmerged patches that add the fsverity feature, so
it can't be merged as-is anyway.

IMO, it's also difficult for people to review the read_callbacks stuff when it's
mixed in with lots of other fscrypt and ext4 changes for blocksize != PAGE_SIZE.

I actually have a patchset almost ready already, so I'm going to send it out and
see what you think.  It *should* make things a lot easier for you, since then
you can base a much smaller read_callbacks patchset on top of it.

Thanks!

- Eric
