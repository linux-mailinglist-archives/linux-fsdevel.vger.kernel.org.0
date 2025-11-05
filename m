Return-Path: <linux-fsdevel+bounces-67078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB98C34DCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 10:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 330B1501984
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A650030DECC;
	Wed,  5 Nov 2025 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xeiR4NoS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uqvwPEKU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xeiR4NoS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uqvwPEKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8472FFF8C
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334516; cv=none; b=GbHfBF53cDClPC2ejdc1p3bwvIosaHbeTjb0/muKk3dIVXYWPhWAWcIsz/Z25Jn/aFg4q8vbbZdE3v4KirB3bLLoLqDPY9d8k55qX1HYtBBKWkNM99+ehmPi4HJ/oHY6bdBxhfiqP+PFYTJJtN2AKlNPxlQtS9a2uOcpEO0Imt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334516; c=relaxed/simple;
	bh=7QmbSoSFkJU0x22h/fBGtFwP6eIRiQcW2vzomv5wvQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iy62IagKXxTzBXPkvubrzc1oSc4AtmITvbAFGCOeVTJDB38XL+5BWro3JjZLUfT2+p0DvpdBeGI5fI2cv+HgOjUjqGB4fKg3EHkOMhel4p9NRbpXYhdrhaTb17qB0Ga97TDzGE9rKeRSYEKnxG8AzPEhPyRAY2vY2wNW3Kyfc5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xeiR4NoS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uqvwPEKU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xeiR4NoS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uqvwPEKU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86F8221181;
	Wed,  5 Nov 2025 09:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762334512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PiimWwxWLRmp6RdY8hBpnmT5w5iOYiscsbCX56fNBAM=;
	b=xeiR4NoS39SfhExjX/IbEG6Ah8riUDdj05SyDWi1Sjm9P9AsioakTVj/b4F3y8W45kAu4W
	5JQ1mVje6U2i+f9ewV8olKWoCRUJJRS+kYHzMD8Px1I5k0884E86/sIlxi5crdmbfWcx4n
	vN0RXs9+aW3yziq5bmUFWj0HmIUlTXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762334512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PiimWwxWLRmp6RdY8hBpnmT5w5iOYiscsbCX56fNBAM=;
	b=uqvwPEKUZeWCS1Oon506yU+IqoyTApTuNFNmwCAHWz+xxfm0SCKL6bFFw+gnQSOCgnLMrT
	8zuVFDiV0O47eWCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762334512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PiimWwxWLRmp6RdY8hBpnmT5w5iOYiscsbCX56fNBAM=;
	b=xeiR4NoS39SfhExjX/IbEG6Ah8riUDdj05SyDWi1Sjm9P9AsioakTVj/b4F3y8W45kAu4W
	5JQ1mVje6U2i+f9ewV8olKWoCRUJJRS+kYHzMD8Px1I5k0884E86/sIlxi5crdmbfWcx4n
	vN0RXs9+aW3yziq5bmUFWj0HmIUlTXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762334512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PiimWwxWLRmp6RdY8hBpnmT5w5iOYiscsbCX56fNBAM=;
	b=uqvwPEKUZeWCS1Oon506yU+IqoyTApTuNFNmwCAHWz+xxfm0SCKL6bFFw+gnQSOCgnLMrT
	8zuVFDiV0O47eWCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CEA3132DD;
	Wed,  5 Nov 2025 09:21:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x4h8HjAXC2lVFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 09:21:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 382E2A083B; Wed,  5 Nov 2025 10:21:52 +0100 (CET)
Date: Wed, 5 Nov 2025 10:21:52 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 15/25] ext4: rename 'page' references to 'folio' in
 multi-block allocator
Message-ID: <zi2xv42wg45qbveq4vxtdodencx7zb2esscwensoaka2hiojdr@imra4faaz42g>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-16-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-16-libaokun@huaweicloud.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,huaweicloud.com:email,suse.cz:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 

On Sat 25-10-25 11:22:11, libaokun@huaweicloud.com wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> The ext4 multi-block allocator now fully supports folio objects. Update
> all variable names, function names, and comments to replace legacy 'page'
> terminology with 'folio', improving clarity and consistency.
> 
> No functional changes.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 155c43ff2bc2..cf07d1067f5f 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -98,14 +98,14 @@
>   * block bitmap and buddy information. The information are stored in the
>   * inode as:
>   *
> - *  {                        page                        }
> + *  {                        folio                        }
>   *  [ group 0 bitmap][ group 0 buddy] [group 1][ group 1]...
>   *
>   *
>   * one block each for bitmap and buddy information.  So for each group we
> - * take up 2 blocks. A page can contain blocks_per_page (PAGE_SIZE /
> - * blocksize) blocks.  So it can have information regarding groups_per_page
> - * which is blocks_per_page/2
> + * take up 2 blocks. A folio can contain blocks_per_folio (folio_size /
> + * blocksize) blocks.  So it can have information regarding groups_per_folio
> + * which is blocks_per_folio/2
>   *
>   * The buddy cache inode is not stored on disk. The inode is thrown
>   * away when the filesystem is unmounted.
> @@ -1556,7 +1556,7 @@ static int ext4_mb_get_buddy_folio_lock(struct super_block *sb,
>  	return 0;
>  }
>  
> -static void ext4_mb_put_buddy_page_lock(struct ext4_buddy *e4b)
> +static void ext4_mb_put_buddy_folio_lock(struct ext4_buddy *e4b)
>  {
>  	if (e4b->bd_bitmap_folio) {
>  		folio_unlock(e4b->bd_bitmap_folio);
> @@ -1570,7 +1570,7 @@ static void ext4_mb_put_buddy_page_lock(struct ext4_buddy *e4b)
>  
>  /*
>   * Locking note:  This routine calls ext4_mb_init_cache(), which takes the
> - * block group lock of all groups for this page; do not hold the BG lock when
> + * block group lock of all groups for this folio; do not hold the BG lock when
>   * calling this routine!
>   */
>  static noinline_for_stack
> @@ -1618,7 +1618,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
>  	if (e4b.bd_buddy_folio == NULL) {
>  		/*
>  		 * If both the bitmap and buddy are in
> -		 * the same page we don't need to force
> +		 * the same folio we don't need to force
>  		 * init the buddy
>  		 */
>  		ret = 0;
> @@ -1634,7 +1634,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
>  		goto err;
>  	}
>  err:
> -	ext4_mb_put_buddy_page_lock(&e4b);
> +	ext4_mb_put_buddy_folio_lock(&e4b);
>  	return ret;
>  }
>  
> @@ -2227,7 +2227,7 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>  	ac->ac_buddy = ret >> 16;
>  
>  	/*
> -	 * take the page reference. We want the page to be pinned
> +	 * take the folio reference. We want the folio to be pinned
>  	 * so that we don't get a ext4_mb_init_cache_call for this
>  	 * group until we update the bitmap. That would mean we
>  	 * double allocate blocks. The reference is dropped
> @@ -2933,7 +2933,7 @@ static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
>  	if (cr < CR_ANY_FREE && spin_is_locked(ext4_group_lock_ptr(sb, group)))
>  		return 0;
>  
> -	/* This now checks without needing the buddy page */
> +	/* This now checks without needing the buddy folio */
>  	ret = ext4_mb_good_group_nolock(ac, group, cr);
>  	if (ret <= 0) {
>  		if (!ac->ac_first_err)
> @@ -4725,7 +4725,7 @@ static void ext4_discard_allocated_blocks(struct ext4_allocation_context *ac)
>  				   "ext4: mb_load_buddy failed (%d)", err))
>  			/*
>  			 * This should never happen since we pin the
> -			 * pages in the ext4_allocation_context so
> +			 * folios in the ext4_allocation_context so
>  			 * ext4_mb_load_buddy() should never fail.
>  			 */
>  			return;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

