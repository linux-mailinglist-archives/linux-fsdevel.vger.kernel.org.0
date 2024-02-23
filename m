Return-Path: <linux-fsdevel+bounces-12592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 372118616C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEA31F26199
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 16:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F3A82D80;
	Fri, 23 Feb 2024 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnCMuL9y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C3184FB8
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704184; cv=none; b=g6DZa/4K9d3Ve61zKtSU3WgglZztgtVXgrzlzeTRh7E3bOsQmdHKl6V52wr5Ccjs3QxQiY7+DJVHO0IRBxMOSv/lSaUhjZISXYEy4N+E2f9pfCYxhKBcHHbfiRadISeL8jtAeuU/7j6MTatjcum1TgpBky44IVqWZu4Ix54FN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704184; c=relaxed/simple;
	bh=iBep7RO8ddpdLRdvlhmb/cZ26L/c96nkdhxMz8MwS+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwGo8RO1uQSlMSd4u4PWUXs/mQ2t7QPYHxwpfRwemmGd3wtgMpbdIZwRDKIGUzUAfM4jo8DRcir+uoqcLovnKueUeMq8CTuUH1A3qK9c3FxNhxf52sb3l5RjRiVazT+Hc71A5vEWYyqYHm9vdsBsb143ecq2NrXfyoDc9o4CzAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnCMuL9y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708704171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8foMIRBo85gMY/Ay5uzImhoC7ZGM46V4y3ehQV8tpF4=;
	b=JnCMuL9yRqP657gQVnEBWnDWCuiCIX9kYbajomOFj+Ar4qIiSndRmMe1I7qN5H9g+ifp02
	+evej1N/5GfpR6F4+YR0XE1IIdCtDrOaEIMGRCAJIU4LWXmeNtTS6CMfzFr8QHnboCXg6p
	Dr563MXQ6NI6Y/k3g1PvddcWctAeo1M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-4kWIGeypOISe9Z24WSPb0Q-1; Fri, 23 Feb 2024 11:02:49 -0500
X-MC-Unique: 4kWIGeypOISe9Z24WSPb0Q-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-512ec325f72so411344e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 08:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708704167; x=1709308967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8foMIRBo85gMY/Ay5uzImhoC7ZGM46V4y3ehQV8tpF4=;
        b=HiZBUUhwh+lNUsfnoG0T7UnY6BwLdBfrbxT87KaOLe8j8HfSvajKlKvbn+qugP7bKz
         UyLEcyDaO7NYu6LjdKWOg5OH79b/3lScU6SfJq0nHtIlvkkt1E++fZ4e3xNMpiiKZN4v
         axqLZ9FWMiSVQlqcnLMF0b/SITEd9tN6M1Gp1glt/ps+6eiKVejkJJDxHGM7rBPGytO6
         +JY4Q+h0lG8l9ZmStvji4trU+FkOBEDiJk971yuFC1nbmm/IJSdfWIgRtQfi/1yH67UX
         U2UJzIdUst0flG1xBpUKQYx0WOLG3SAdaRiJbtE0D4xaRcbgA70w5pMe+r0ADJND51qj
         6yMg==
X-Forwarded-Encrypted: i=1; AJvYcCWoCIMhXetcA0nPGTNcAZ8DOjJcEZJWiU0dfUJyqRPusqL0oDVRdmUjh8tbPF0PVTgD/PtnT3bDyLGaSht5N405veUmXWrtKYfjEblIng==
X-Gm-Message-State: AOJu0Ywg1MPkVJUneV2RVsxw6tKvUzn+rbkaVRprC3rkQoizTnznUS1E
	GjicL/MD/oAUvt8kF8THDsVsl7CcOXloloekqcVI3vW31Q1lJcXkCgEY/ArTt76xVMV7DxTrczF
	Ii8eVw522MRM6yDgEpDMfW4qzfKhSxoQt/JcBFYzpy58cBiFWSM1IUakvXX7E0w==
X-Received: by 2002:a05:6512:15a2:b0:512:ed89:7152 with SMTP id bp34-20020a05651215a200b00512ed897152mr45822lfb.55.1708704167108;
        Fri, 23 Feb 2024 08:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGTHIKiKzPtGcfPq1ZKnHpQzFxehMSw20qoKFDDdUuvbE+uKn5UPosRaaIaxMC3Y+GN8iW6w==
X-Received: by 2002:a05:6512:15a2:b0:512:ed89:7152 with SMTP id bp34-20020a05651215a200b00512ed897152mr45778lfb.55.1708704166630;
        Fri, 23 Feb 2024 08:02:46 -0800 (PST)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id u14-20020ac248ae000000b005115430488bsm2488657lfg.243.2024.02.23.08.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 08:02:46 -0800 (PST)
Date: Fri, 23 Feb 2024 17:02:45 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com, djwong@kernel.org
Subject: Re: [PATCH v4 07/25] fsverity: support block-based Merkle tree
 caching
Message-ID: <qojmht7l3lgx5hy7sqh5tru7u3uuowl5siszzcj3futgyqtbtv@pth44gm7ueog>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-8-aalbersh@redhat.com>
 <20240223052459.GC25631@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223052459.GC25631@sol.localdomain>

On 2024-02-22 21:24:59, Eric Biggers wrote:
> On Mon, Feb 12, 2024 at 05:58:04PM +0100, Andrey Albershteyn wrote:
> > diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
> > index f58432772d9e..7e153356e7bc 100644
> > --- a/fs/verity/read_metadata.c
> > +++ b/fs/verity/read_metadata.c
> [...]
> >  	/*
> > -	 * Iterate through each Merkle tree page in the requested range and copy
> > -	 * the requested portion to userspace.  Note that the Merkle tree block
> > -	 * size isn't important here, as we are returning a byte stream; i.e.,
> > -	 * we can just work with pages even if the tree block size != PAGE_SIZE.
> > +	 * Iterate through each Merkle tree block in the requested range and
> > +	 * copy the requested portion to userspace. Note that we are returning
> > +	 * a byte stream, so PAGE_SIZE & block_size are not important here.
> 
> The block size *is* important here now, because this code is now working with
> the data in blocks.  Maybe just delete the last sentence from the comment.
> 
> > +		fsverity_drop_block(inode, &block);
> > +		block.kaddr = NULL;
> 
> Either the 'block.kaddr = NULL' should not be here, or it should be done
> automatically in fsverity_drop_block().
> 
> > +		num_ra_pages = level == 0 ?
> > +			min(max_ra_pages, params->tree_pages - hpage_idx) : 0;
> > +		err = fsverity_read_merkle_tree_block(
> > +			inode, hblock_idx << params->log_blocksize, block,
> > +			params->log_blocksize, num_ra_pages);
> 
> 'hblock_idx << params->log_blocksize' needs to be
> '(u64)hblock_idx << params->log_blocksize'
> 
> >  	for (; level > 0; level--) {
> > -		kunmap_local(hblocks[level - 1].addr);
> > -		put_page(hblocks[level - 1].page);
> > +		fsverity_drop_block(inode, &hblocks[level - 1].block);
> >  	}
> 
> Braces should be removed above
> 
> > +/**
> > + * fsverity_invalidate_range() - invalidate range of Merkle tree blocks
> > + * @inode: inode to which this Merkle tree blocks belong
> > + * @offset: offset into the Merkle tree
> > + * @size: number of bytes to invalidate starting from @offset
> 
> Maybe use @pos instead of @offset, to make it clear that it's in bytes.
> 
> But, what happens if the region passed is not Merkle tree block aligned?
> Perhaps this function should operate on blocks, to avoid that case?
> 
> > + * Note! As this function clears fs-verity bitmap and can be run from multiple
> > + * threads simultaneously, filesystem has to take care of operation ordering
> > + * while invalidating Merkle tree and caching it. See fsverity_invalidate_page()
> > + * as reference.
> 
> I'm not sure what this means.  What specifically does the filesystem have to do?
> 
> > +/* fsverity_invalidate_page() - invalidate Merkle tree blocks in the page
> 
> Is this intended to be kerneldoc?  Kerneldoc comments start with /**
> 
> Also, this function is only used within fs/verity/verify.c itself.  So it should
> be static, and it shouldn't be declared in include/linux/fsverity.h.
> 
> > + * @inode: inode to which this Merkle tree blocks belong
> > + * @page: page which contains blocks which need to be invalidated
> > + * @index: index of the first Merkle tree block in the page
> 
> The only value that is assigned to index is 'pos >> PAGE_SHIFT', which implies
> it is in units of pages, not Merkle tree blocks.  Which is correct?
> 
> > + *
> > + * This function invalidates "verified" state of all Merkle tree blocks within
> > + * the 'page'.
> > + *
> > + * When the Merkle tree block size and page size are the same, then the
> > + * ->hash_block_verified bitmap isn't allocated, and we use PG_checked
> > + * to directly indicate whether the page's block has been verified. This
> > + * function does nothing in this case as page is invalidated by evicting from
> > + * the memory.
> > + *
> > + * Using PG_checked also guarantees that we re-verify hash pages that
> > + * get evicted and re-instantiated from the backing storage, as new
> > + * pages always start out with PG_checked cleared.
> 
> This comment duplicates information from the comment in the function itself.
> 
> > +void fsverity_drop_block(struct inode *inode,
> > +		struct fsverity_blockbuf *block)
> > +{
> > +	if (inode->i_sb->s_vop->drop_block)
> > +		inode->i_sb->s_vop->drop_block(block);
> > +	else {
> > +		struct page *page = (struct page *)block->context;
> > +
> > +		/* Merkle tree block size == PAGE_SIZE; */
> > +		if (block->verified)
> > +			SetPageChecked(page);
> > +
> > +		kunmap_local(block->kaddr);
> > +		put_page(page);
> > +	}
> > +}
> 
> I don't think this is the logical place for the call to SetPageChecked().
> verity_data_block() currently does:
> 
>         if (vi->hash_block_verified)
>                 set_bit(hblock_idx, vi->hash_block_verified);
>         else
>                 SetPageChecked(page);
> 
> You're proposing moving the SetPageChecked() to fsverity_drop_block().  Why?  We
> should try to do things in a consistent place.
> 
> Similarly, I don't see why is_hash_block_verified() shouldn't keep the
> PageChecked().
> 
> If we just keep PG_checked be get and set in the same places it currently is,
> then adding fsverity_blockbuf::verified wouldn't be necessary.
> 
> Maybe you intended to move the awareness of PG_checked out of fs/verity/ and
> into the filesystems?

yes

> Your change in how PG_checked is get and set is sort of a
> step towards that, but it doesn't complete it.  It doesn't make sense to leave
> in this half-finished state.

What do you think is missing? I didn't want to make too many changes
to fs which already use fs-verity and completely change the
interface, just to shift page handling stuff to middle layer
functions. So yeah kinda "step towards" only :)

> IMO, keeping fs/verity/ aware of PG_checked is
> fine for now.  It avoids the need for some indirect calls, which is nice.

> > +/**
> > + * struct fsverity_blockbuf - Merkle Tree block
> > + * @kaddr: virtual address of the block's data
> > + * @size: buffer size
> 
> Is "buffer size" different from block size?
> 
> > + * @verified: true if block is verified against Merkle tree
> 
> This field has confusing semantics, as it's not used by the filesystems but only
> by fs/verity/ internally.  As per my feedback above, I don't think this field is
> necessary.
> 
> > + * Buffer containing single Merkle Tree block. These buffers are passed
> > + *  - to filesystem, when fs-verity is building/writing merkel tree,
> > + *  - from filesystem, when fs-verity is reading merkle tree from a disk.
> > + * Filesystems sets kaddr together with size to point to a memory which contains
> > + * Merkle tree block. Same is done by fs-verity when Merkle tree is need to be
> > + * written down to disk.
> 
> Writes actually still use fsverity_operations::write_merkle_tree_block(), which
> does not use this struct.
> 
> > + * For Merkle tree block == PAGE_SIZE, fs-verity sets verified flag to true if
> > + * block in the buffer was verified.
> 
> Again, I think we can do without this field.
> 
> > +	/**
> > +	 * Read a Merkle tree block of the given inode.
> > +	 * @inode: the inode
> > +	 * @pos: byte offset of the block within the Merkle tree
> > +	 * @block: block buffer for filesystem to point it to the block
> > +	 * @log_blocksize: size of the expected block
> 
> Presumably @log_blocksize is the log2 of the size of the block?
> 
> > +	 * @num_ra_pages: The number of pages with blocks that should be
> > +	 *		  prefetched starting at @index if the page at @index
> > +	 *		  isn't already cached.  Implementations may ignore this
> > +	 *		  argument; it's only a performance optimization.
> 
> There's no parameter named @index.
> 
> > +	 * As filesystem does caching of the blocks, this functions needs to tell
> > +	 * fsverity which blocks are not valid anymore (were evicted from memory)
> > +	 * by calling fsverity_invalidate_range().
> 
> This function only reads a single block, so what does this mean by "blocks"?
> 
> Since there's only one block being read, why isn't the validation status just
> conveyed through a bool in fsverity_blockbuf?

There's the case when XFS also needs to invalidate multiple tree
blocks when only single one is requested. Same as ext4 invalidates
all blocks in the page when page is evicted. This happens, for
example, when PAGE size is 64k and fs block size is 4k. XFS then
calls fsverity_invalidate_range() for all those blocks; not just for
requested one.

I can rephrase this comment.

> > +	/**
> > +	 * Release the reference to a Merkle tree block
> > +	 *
> > +	 * @page: the block to release
> 
> @block, not @page
> 
> - Eric
> 

Thanks for all the spotted mistakes, I will fix them.

-- 
- Andrey


