Return-Path: <linux-fsdevel+bounces-4916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E196806388
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 01:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6591C20366
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD52CA68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD3kcPc1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1141220;
	Tue,  5 Dec 2023 23:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEE8C433C7;
	Tue,  5 Dec 2023 23:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701820671;
	bh=PehSLn5KDP3f4jIRzjmUlaVwYMHHsyFfaZ+dIqzfuaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PD3kcPc1BGPalXH0uGMRBV5/7KrxVuBbGzJX68EO8M4FplFKcg2Uuzq5x6C3AdZI2
	 evtibWYH1B2cPLrure/Rl+OuVlkMMnfdz0qWNvl9Lp/W3tX95GB4kSXtrOxPxLqa68
	 WPgtPNAK5ZGV9Lmy+xuWjh/IEdhKTEih3Py+rEtp5gtu1Vzm6nBJyO7WrDWIBeP2so
	 IDJ6YKLny1FnLU70aLdXt2foQi5uJk3GWSheJTGL2ODf0EoUCZQuwKsDuqXEvRNSp/
	 gmYIKqOJVmTeOnuU6a4BTkKu9x7HRmyBb/UTmtoNY/KkPfBjL+0swTAwG12Dvk6Z3w
	 isAnTAlLqFDrQ==
Date: Tue, 5 Dec 2023 15:57:49 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 02/46] fscrypt: add per-extent encryption support
Message-ID: <20231205235749.GA1118@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <5e91532d4f6ddb10af8aac7f306186d6f1b9e917.1701468306.git.josef@toxicpanda.com>
 <20231205035820.GE1168@sol.localdomain>
 <20231205224809.GA15355@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205224809.GA15355@localhost.localdomain>

On Tue, Dec 05, 2023 at 05:48:09PM -0500, Josef Bacik wrote:
> > Also, I think that for now we should keep things simple by doing the following
> > instead of fscrypt_generate_dun():
> > 
> > 	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE] = { first_lblk };
> > 
> > Note that these two changes would eliminate the need for the inode parameter to
> > the function.
> > 
> > Please also make sure to update the function comment.  Note that the first line
> > gives the function name incorrectly.
> > 
> 
> First off thanks for the review, I'm currently going through it one by one, so
> I've come to this bit and I've got a question.
> 
> The DUN has to be le64, so this strictly isn't ok.  So would you be ok with
> 
> __le64 first_lblk_le = le64_to_cpu(first_lblk;
> u64 dun [BLK_CRYPTO_DUN_ARRAY_SIZE] = { first_lblk_le };
> 
> or do you want something different?  Additionally fscrypt_generate_dun() also
> takes into account the data units per block bits, which as I'm typing this out
> I'm realizing doesn't really matter for us even if we have different sectorsize
> per pagesize.  I guess I'll put a big comment about why we're not using that in
> there to make sure future Josef isn't confused.

The blk-crypto DUN is CPU endian, as indicated by the type (array of u64).  Note
that fscrypt_generate_dun() converts u64 => __le64 => u64.  (And then
blk-crypto-fallback converts u64 => __le64.)  Getting rid of that round trip is
nice, which is why I'm recommending it.  The only reason that
fscrypt_generate_dun() does the round trip is because it allows it to reuse
fscrypt_generate_iv(), and I wanted to be 100% sure that all of the IV methods
were implemented the same as in FS layer encryption.  With the extent-based
encryption we're just supporting one method, so things are simpler.

Yeah, it should be 'first_lblk << ci_data_units_per_block_bits'.
That would just be for future-proofing, since btrfs isn't setting
supports_subblock_data_units anyway.

> > > +/**
> > > + * fscrypt_extent_context_size() - Return the size of the on-disk extent context
> > > + * @inode: the inode this extent belongs to.
> > > + *
> > > + * Return the size of the extent context for this inode.  Since there is only
> > > + * one extent context version currently this is just the size of the extent
> > > + * context if the inode is encrypted.
> > > + */
> > > +size_t fscrypt_extent_context_size(struct inode *inode)
> > > +{
> > > +	if (!IS_ENCRYPTED(inode))
> > > +		return 0;
> > > +
> > > +	return sizeof(struct fscrypt_extent_context);
> > > +}
> > > +EXPORT_SYMBOL_GPL(fscrypt_extent_context_size);
> > 
> > Huh, shouldn't the filesystem use the size from fscrypt_set_extent_context() (or
> > fscrypt_context_for_new_extent() as I recommend calling it)?  Why is the above
> > function necessary?
> 
> This is because we need to know how big the context is ahead of time before
> searching down the b-tree to insert the file extent item, and we have to add
> this size to the file extent item ahead of time.  The disconnect between when we
> need to know how big it'll be and when we actually generate the context to save
> on disk is the reason for there being two helpers.
> 
> The main reason for this is code separation.  I would have to have the context
> on stack for the !fscrypt case if I were to only have one helper, because I
> would need it there to generate the extent context to save on disk to pass it
> around to all the things that add file extents, and I could use the length from
> that.  Not a huge deal, but this way is a little cleaner.  You can see how I've
> used the two helpers in later patches, but the general flow is
> 
> total_size = sizeof(our file extent);
> total_size += fscrypt_extent_context_size(inode);
> 
> btrfs_insert_empty_item(path, total_size);
> 
> btrfs_fscrypt_save_extent_info(path, inode);
> 
> and then in btrfs_fscrypt_save_extent_info() we do
> 
> u8 ctx[BTRFS_MAX_EXTENT_CTX_SIZE];
> 
> size = fscrypt_set_extent_context(inode, ctx);
> 
> Now the above case does seem like we could just uconditionally do something like
> 
> u8 ctx[BTRFS_MAX_EXTENT_CTX_SIZE];
> 
> total_size = sizeof(our file extent);
> ctx_size = fscrypt_set_extent_context(inode, ctx);
> if (ctx_size < 0)
> 	goto error;
> total_size += ctx_size;
> btrfs_insert_empty_item(path, total_size);
> copy_ctx_into_file_extent(path, ctx);
> 
> But there's some other file extent manipulation cases that aren't this clear
> cut, so I'd have to pass this ctx around to be copied in.  And in the !encrypted
> part we're paying a higher stack memory cost.
> 
> If you still don't like this I can rework it, but I wanted to explain my
> reasoning before I went changing a bunch of stuff to make the new paradigm fit.
> 
> The rest of the comments make sense, I'll fix everything up.  Thanks,

Maybe fscrypt_set_extent_context() (or fscrypt_context_for_new_extent()?) should
return the size if it's passed a NULL pointer?  It just seems error-prone have
the size of the thing being generated be returned by a different function.

- Eric

