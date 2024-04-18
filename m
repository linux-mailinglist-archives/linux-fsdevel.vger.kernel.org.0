Return-Path: <linux-fsdevel+bounces-17257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 627C18AA1C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 20:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DB51F222C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8969D178CEC;
	Thu, 18 Apr 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vTYxqrUz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6uD5kMbc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vTYxqrUz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6uD5kMbc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0C16191A;
	Thu, 18 Apr 2024 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463709; cv=none; b=l3gyRum3X26d7KzYcH/d6l51U337maxYQSSsJO4yjVWV2p1yOGTWjNtBYU+np5GCgKNtJzDPKALVl08qRbx7o66WhP0qxiV2k87LnsuDOocOL08CBGF8kgOxpOcX/bEkQR2FWc0gsjuZJ24LIOCRWjNY728UgJcPg/dbl6X9ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463709; c=relaxed/simple;
	bh=RGPXkkJpHlNFiQkPPtBdHl4aeqecg9CyLmPJaY+UM8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eV30Rwe6XXgtljPZoUG+0A2ECQrwCbqYDuLL/H+oz0NifoBu29LunfdHzp2CBoaPMuDYZHZHIdo56dC1BrVWgo68GaOvHKGPq+JZ5c7kHBcHXZM/Qdgmr2Fav8rWgaCnIUZeWqjdIA5ngRrOCnLm7+CMm9xpitXZEceef4I0u7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vTYxqrUz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6uD5kMbc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vTYxqrUz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6uD5kMbc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F0C3224C6;
	Thu, 18 Apr 2024 18:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713463702;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCxX8aSlqkopKSrHIL5Z8rd+gRSiOqZSK+6bvh96kPA=;
	b=vTYxqrUz6L9HP4SJab/Qux7BRVOLe9gVvzvyYWKt2OubHDbTXHMZq3r8fn0Ki1RPID6pnj
	xhDHdaMVo/xxoVUVShdso3Uy+scmr5bY2q9th2BkzTsmM2MCYSCxoQAOWDwoTheE/LAxvT
	vRk2kPT+0fIqFcmvEQyc4cHNJ0PnAQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713463702;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCxX8aSlqkopKSrHIL5Z8rd+gRSiOqZSK+6bvh96kPA=;
	b=6uD5kMbc5AtMbEndwj2qyFMWELfxF2WT4+OoZYHuLNq2b3tSlnxkF9gOv5Yyn6yzQp0OFA
	iZOt6MiBmAo6PNCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vTYxqrUz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6uD5kMbc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713463702;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCxX8aSlqkopKSrHIL5Z8rd+gRSiOqZSK+6bvh96kPA=;
	b=vTYxqrUz6L9HP4SJab/Qux7BRVOLe9gVvzvyYWKt2OubHDbTXHMZq3r8fn0Ki1RPID6pnj
	xhDHdaMVo/xxoVUVShdso3Uy+scmr5bY2q9th2BkzTsmM2MCYSCxoQAOWDwoTheE/LAxvT
	vRk2kPT+0fIqFcmvEQyc4cHNJ0PnAQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713463702;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCxX8aSlqkopKSrHIL5Z8rd+gRSiOqZSK+6bvh96kPA=;
	b=6uD5kMbc5AtMbEndwj2qyFMWELfxF2WT4+OoZYHuLNq2b3tSlnxkF9gOv5Yyn6yzQp0OFA
	iZOt6MiBmAo6PNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C5AE13687;
	Thu, 18 Apr 2024 18:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A2IxHpZhIWZqbgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 18 Apr 2024 18:08:22 +0000
Date: Thu, 18 Apr 2024 20:00:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: Removing PG_error use from btrfs
Message-ID: <20240418180051.GX3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ZiFbWx6o-hQ38QyZ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiFbWx6o-hQ38QyZ@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9F0C3224C6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Thu, Apr 18, 2024 at 06:41:47PM +0100, Matthew Wilcox wrote:
> We're down to just JFS and btrfs using the PG_error flag.  I sent a
> patch earlier to remove PG_error from JFS, so now it's your turn ...
> 
> btrfs currently uses it to indicate superblock writeback errors.
> This proposal moves that information to a counter in the btrfs_device.
> Maybe this isn't the best approach.  What do you think?

Tracking the number of errors in the device is a good approach.  The
superblock write is asynchronous but it's not necessary to track the
error in the page, we have the device structure in the end io callback.
Also it's guaranteed that this is running only from one place so not
even the atomics are needed.

> I'm currently running fstests against it and it hasn't blown up yet.
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3d512b041977..5f6f8472ecec 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3627,28 +3627,24 @@ ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
>  static void btrfs_end_super_write(struct bio *bio)
>  {
>  	struct btrfs_device *device = bio->bi_private;
> -	struct bio_vec *bvec;
> -	struct bvec_iter_all iter_all;
> -	struct page *page;
> -
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		page = bvec->bv_page;
> +	struct folio_iter fi;

I'd rather make the conversion from pages to folios a separate patch
from the error counting change. I haven't seen anything obviously wrong
but the superblock write is a critical action so it's a matter of
precaution.

> +	bio_for_each_folio_all(fi, bio) {
>  		if (bio->bi_status) {
>  			btrfs_warn_rl_in_rcu(device->fs_info,
> -				"lost page write due to IO error on %s (%d)",
> +				"lost sb write due to IO error on %s (%d)",
>  				btrfs_dev_name(device),
>  				blk_status_to_errno(bio->bi_status));
> -			ClearPageUptodate(page);
> -			SetPageError(page);
>  			btrfs_dev_stat_inc_and_print(device,
>  						     BTRFS_DEV_STAT_WRITE_ERRS);
> -		} else {
> -			SetPageUptodate(page);
> +			/* Ensure failure if a primary sb fails */
> +			if (bio->bi_opf & REQ_FUA)
> +				atomic_set(&device->sb_wb_errors, INT_MAX / 2);

This is using some magic constant so it would be better defined
separately and documented what it means.

> +			else
> +				atomic_inc(&device->sb_wb_errors);
>  		}
> -
> -		put_page(page);
> -		unlock_page(page);
> +		folio_unlock(fi.folio);
> +		folio_put(fi.folio);
>  	}
>  
>  	bio_put(bio);
> @@ -3750,19 +3746,21 @@ static int write_dev_supers(struct btrfs_device *device,
>  	struct address_space *mapping = device->bdev->bd_mapping;
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	int i;
> -	int errors = 0;
>  	int ret;
>  	u64 bytenr, bytenr_orig;
>  
> +	atomic_set(&device->sb_wb_errors, 0);
> +
>  	if (max_mirrors == 0)
>  		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
>  
>  	shash->tfm = fs_info->csum_shash;
>  
>  	for (i = 0; i < max_mirrors; i++) {
> -		struct page *page;
> +		struct folio *folio;
>  		struct bio *bio;
>  		struct btrfs_super_block *disk_super;
> +		size_t offset;
>  
>  		bytenr_orig = btrfs_sb_offset(i);
>  		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
> @@ -3772,7 +3770,7 @@ static int write_dev_supers(struct btrfs_device *device,
>  			btrfs_err(device->fs_info,
>  				"couldn't get super block location for mirror %d",
>  				i);
> -			errors++;
> +			atomic_inc(&device->sb_wb_errors);
>  			continue;
>  		}
>  		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
> @@ -3785,20 +3783,18 @@ static int write_dev_supers(struct btrfs_device *device,
>  				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
>  				    sb->csum);
>  
> -		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
> -					   GFP_NOFS);
> -		if (!page) {
> +		folio = __filemap_get_folio(mapping, bytenr >> PAGE_SHIFT,
> +				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_NOFS);
> +		if (IS_ERR(folio)) {
>  			btrfs_err(device->fs_info,
>  			    "couldn't get super block page for bytenr %llu",
>  			    bytenr);
> -			errors++;
> +			atomic_inc(&device->sb_wb_errors);
>  			continue;
>  		}
>  
> -		/* Bump the refcount for wait_dev_supers() */
> -		get_page(page);
> -
> -		disk_super = page_address(page);
> +		offset = offset_in_folio(folio, bytenr);
> +		disk_super = folio_address(folio) + offset;
>  		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
>  
>  		/*
> @@ -3812,8 +3808,7 @@ static int write_dev_supers(struct btrfs_device *device,
>  		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
>  		bio->bi_private = device;
>  		bio->bi_end_io = btrfs_end_super_write;
> -		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
> -			       offset_in_page(bytenr));
> +		bio_add_folio_nofail(bio, folio, BTRFS_SUPER_INFO_SIZE, offset);
>  
>  		/*
>  		 * We FUA only the first super block.  The others we allow to
> @@ -3825,9 +3820,9 @@ static int write_dev_supers(struct btrfs_device *device,
>  		submit_bio(bio);
>  
>  		if (btrfs_advance_sb_log(device, i))
> -			errors++;
> +			atomic_inc(&device->sb_wb_errors);
>  	}
> -	return errors < i ? 0 : -1;
> +	return atomic_read(&device->sb_wb_errors) < i ? 0 : -1;
>  }
>  
>  /*
> @@ -3849,7 +3844,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
>  		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
>  
>  	for (i = 0; i < max_mirrors; i++) {
> -		struct page *page;
> +		struct folio *folio;
>  
>  		ret = btrfs_sb_log_location(device, i, READ, &bytenr);
>  		if (ret == -ENOENT) {
> @@ -3864,29 +3859,19 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
>  		    device->commit_total_bytes)
>  			break;
>  
> -		page = find_get_page(device->bdev->bd_mapping,
> +		folio = filemap_get_folio(device->bdev->bd_mapping,
>  				     bytenr >> PAGE_SHIFT);
> -		if (!page) {
> -			errors++;
> -			if (i == 0)
> -				primary_failed = true;
> +		/* If the folio has been removed, then we know it completed */
> +		if (IS_ERR(folio))
>  			continue;
> -		}
> -		/* Page is submitted locked and unlocked once the IO completes */
> -		wait_on_page_locked(page);
> -		if (PageError(page)) {
> -			errors++;
> -			if (i == 0)
> -				primary_failed = true;
> -		}
> -
> -		/* Drop our reference */
> -		put_page(page);
> -
> -		/* Drop the reference from the writing run */
> -		put_page(page);
> +		/* Folio is unlocked once the IO completes */
> +		folio_wait_locked(folio);
> +		folio_put(folio);
>  	}
>  
> +	errors += atomic_read(&device->sb_wb_errors);
> +	if (errors >= INT_MAX / 2)
> +		primary_failed = true;

Alternatively a flag can be set in the device if the primary superblock
write fails but I think encoding that in the error count also works, as
long as it's a named constant.

