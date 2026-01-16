Return-Path: <linux-fsdevel+bounces-74071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 029DBD2E9B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E7830DC337
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5DF322B8D;
	Fri, 16 Jan 2026 09:15:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989931ED73;
	Fri, 16 Jan 2026 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554901; cv=none; b=H7Ufg9+5F3VZZZlMCmo7zuPVlaPxF6C20TDt6+YM3Q29D6w+5JTv4JfKoWDfzpsWAurBU0ngsq6PUSc+5PIsMwFZgG8Om4kCZpGpy8knMucbCgBukyCTTjuVRmzxZN+7GWKQFDamgO+jYjJMxOUDW3bpTOUNLtLgTb5EwehHYNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554901; c=relaxed/simple;
	bh=z2jA7Wsm4rNZGU8kVYScL2O2c8nLFlsPfIzkXWfFhSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BayZbWqFjUrkTZ1/2KJlBZNrLMFtEklAR2Qp3VHlcq4O1Gp/UVftJ+wPbvL+wOS8Kig3fUTHZQCZaKrDlxOvsUHf8k8cIkYlqbqPbf/1+MBtuLYylnQ8GezGTmaxOS/JH98hMzceTvZ8WPNl070OzsvVx5vQdgwy2s14IstZWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4E9E227A8E; Fri, 16 Jan 2026 10:14:51 +0100 (CET)
Date: Fri, 16 Jan 2026 10:14:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com, Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v5 07/14] ntfs: update iomap and address space
 operations
Message-ID: <20260116091451.GA20873@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-8-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111140345.3866-8-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

First, a highlevel comment on the code structure:

I'd expect the mft handling (ntfs_write_mft_block, ntfs_mft_writepage
and ntfs_bmap which is only used by that and could use a comment
update) to be in mft.c and not aops.c.  I'm not sure if feasible,
but separate aops for the MFT (that's the master file table IIRC) would
probably be a good idea as well.

Similarly, ntfs_dev_read/write feel a bit out of place here.

> +void ntfs_bio_end_io(struct bio *bio)
>  {
> +	if (bio->bi_private)
> +		folio_put((struct folio *)bio->bi_private);
> +	bio_put(bio);
> +}

This function confuses me.  In general end_io handlers should not
need to drop a folio reference.  For the normal buffered I/O path,
the folio is locked for reads, and has the writeback bit set for
writes, so this is no needed.  When doing I/O in a private folio,
the caller usually has a reference as it needs to do something with
it.  What is the reason for the special pattern here?  A somewhat
more descriptive name and a comment would help to describe why
it's done this way.  Also no need to cast a void pointer.


> +				if (bio &&
> +				   (bio_end_sector(bio) >> (vol->cluster_size_bits - 9)) !=
> +				    lcn) {
> +					flush_dcache_folio(folio);
> +					bio->bi_end_io = ntfs_bio_end_io;
> +					submit_bio(bio);

If the MFT is what I think it is, the flush_dcache_folio here is not
needed, as the folio can't ever be mapped into userspace.


> +static void ntfs_readahead(struct readahead_control *rac)
> +{
> +	struct address_space *mapping = rac->mapping;
> +	struct inode *inode = mapping->host;
> +	struct ntfs_inode *ni = NTFS_I(inode);
>  
> +	if (!NInoNonResident(ni) || NInoCompressed(ni)) {
> +		/* No readahead for resident and compressed. */
> +		return;
> +	}

Not supporting readahead for compressed inodes is a bit weird, as
they should benefit most from operating on larger ranges.  Not really
a blocker, but probably something worth addressing over time.

> +static int ntfs_mft_writepage(struct folio *folio, struct writeback_control *wbc)
> +{

Instead of having a ntfs_mft_writepage, maybe implement a
ntfs_mft_writepages that includes the writeback_iter() loop?  And then
move the folio_zero_segment into ntfs_write_mft_block so that one
intermediate layer can go away?

> +int ntfs_dev_read(struct super_block *sb, void *buf, loff_t start, loff_t size)

Do you want the data for ntfs_dev_read/write cached in the bdev
mapping?  If not simply using bdev_rw_virt might be easier.  If you
want them cached, maybe add a comment why.


