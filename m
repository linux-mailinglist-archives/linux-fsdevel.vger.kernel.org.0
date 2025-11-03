Return-Path: <linux-fsdevel+bounces-66720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE9FC2A881
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 09:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D9FE347C79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 08:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA592DC321;
	Mon,  3 Nov 2025 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o7KBs+1h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Elm6Yjki";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o7KBs+1h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Elm6Yjki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC52C0283
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157946; cv=none; b=VDnpMGlBlmuppWi6VDAGth2Y0OJ4KiSsT7OJPoSHqJ6yRJGGTkfPfJ2oZVJxCXXup5f2uK6t1pS4DDWHO7izizbP7z6NkeD3glevUNV1stBCcjU3OeaKwgtc1yKzNE4MEY2ARvmsDG4geCpLXQQWzZNTssjd5T4zoEQT1JMrnfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157946; c=relaxed/simple;
	bh=X8uk+hT0KMJqYpL/ncwIq3caS9NqOl0v8gh24DqwyZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+Ksyitb4EY6SFTIVOsXR6Q1Hyi5u+Dl4M7R5ukhZogXkfgxDPjNRvFSvkaj0TubXu4YxwMCgJkwkxmZxEprRDwbnZH5yI8fAFy4snltCGj/abQvQpkioZ8lTUphXjdS+CO1PKp00KUFq7zxfkuMXhF1KFOVa0STDYqJG6bENws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o7KBs+1h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Elm6Yjki; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o7KBs+1h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Elm6Yjki; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1524D21B0C;
	Mon,  3 Nov 2025 08:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762157943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPAKFxV4WCdjb87dxxJgN6RLPpiYUsGfxeA/knVg7pI=;
	b=o7KBs+1hiZj6a1B13uDGEQ6i8QewLRf0/uK6k7VVlQI0ZH4oKNhwBrsVvT+ZuYOcucZ98g
	LNwl6q6wiCC34Xbsya1kuqFuXTDjp1Sis3qY6T8CG7FMGR5Wb704pCyjAuX7+vXBWKOBZ6
	4AB9hKVCARa1MNpdpEUZVfq7skerSp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762157943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPAKFxV4WCdjb87dxxJgN6RLPpiYUsGfxeA/knVg7pI=;
	b=Elm6YjkiWTjTTixkffDtRGHuU7/BR3Asa2O8aoO7DZrBhWpnjXgMHINeEtvTjzvy6ESM6S
	4fedW+Bu15xKdYBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762157943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPAKFxV4WCdjb87dxxJgN6RLPpiYUsGfxeA/knVg7pI=;
	b=o7KBs+1hiZj6a1B13uDGEQ6i8QewLRf0/uK6k7VVlQI0ZH4oKNhwBrsVvT+ZuYOcucZ98g
	LNwl6q6wiCC34Xbsya1kuqFuXTDjp1Sis3qY6T8CG7FMGR5Wb704pCyjAuX7+vXBWKOBZ6
	4AB9hKVCARa1MNpdpEUZVfq7skerSp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762157943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPAKFxV4WCdjb87dxxJgN6RLPpiYUsGfxeA/knVg7pI=;
	b=Elm6YjkiWTjTTixkffDtRGHuU7/BR3Asa2O8aoO7DZrBhWpnjXgMHINeEtvTjzvy6ESM6S
	4fedW+Bu15xKdYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02CA21364F;
	Mon,  3 Nov 2025 08:19:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3UepAHdlCGnUZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 08:19:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4641DA2A64; Mon,  3 Nov 2025 09:19:02 +0100 (CET)
Date: Mon, 3 Nov 2025 09:19:02 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 06/25] ext4: introduce s_min_folio_order for future BS >
 PS support
Message-ID: <eywbqqzeiiz63dqsxrvetpqyj3poniywbvm4wwpcacmr6skaqb@ircbveu4srgi>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-7-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-7-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30

On Sat 25-10-25 11:22:02, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> This commit introduces the s_min_folio_order field to the ext4_sb_info
> structure. This field will store the minimum folio order required by the
> current filesystem, laying groundwork for future support of block sizes
> greater than PAGE_SIZE.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h  |  3 +++
>  fs/ext4/inode.c |  3 ++-
>  fs/ext4/super.c | 10 +++++-----
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 93c2bf4d125a..bca6c3709673 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1677,6 +1677,9 @@ struct ext4_sb_info {
>  	/* record the last minlen when FITRIM is called. */
>  	unsigned long s_last_trim_minblks;
>  
> +	/* minimum folio order of a page cache allocation */
> +	unsigned int s_min_folio_order;
> +
>  	/* Precomputed FS UUID checksum for seeding other checksums */
>  	__u32 s_csum_seed;
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index a63513a3db53..889761ed51dd 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5174,7 +5174,8 @@ void ext4_set_inode_mapping_order(struct inode *inode)
>  	if (!ext4_should_enable_large_folio(inode))
>  		return;
>  
> -	mapping_set_folio_order_range(inode->i_mapping, 0,
> +	mapping_set_folio_order_range(inode->i_mapping,
> +				      EXT4_SB(inode->i_sb)->s_min_folio_order,
>  				      EXT4_MAX_PAGECACHE_ORDER(inode));
>  }
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index aa5aee4d1b63..d353e25a5b92 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5100,11 +5100,8 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
>  	 * If the default block size is not the same as the real block size,
>  	 * we need to reload it.
>  	 */
> -	if (sb->s_blocksize == blocksize) {
> -		*lsb = logical_sb_block;
> -		sbi->s_sbh = bh;
> -		return 0;
> -	}
> +	if (sb->s_blocksize == blocksize)
> +		goto success;
>  
>  	/*
>  	 * bh must be released before kill_bdev(), otherwise
> @@ -5135,6 +5132,9 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
>  		ext4_msg(sb, KERN_ERR, "Magic mismatch, very weird!");
>  		goto out;
>  	}
> +
> +success:
> +	sbi->s_min_folio_order = get_order(blocksize);
>  	*lsb = logical_sb_block;
>  	sbi->s_sbh = bh;
>  	return 0;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

