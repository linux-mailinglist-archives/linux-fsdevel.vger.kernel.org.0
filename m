Return-Path: <linux-fsdevel+bounces-63588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3392BBC49E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 13:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 165654E28BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 11:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD712F7479;
	Wed,  8 Oct 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxX3p06f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eVAPJK9k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxX3p06f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eVAPJK9k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54700244671
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924269; cv=none; b=dobpGApfb9PJUOCin/8LoXOJr87XZ9SDdmoxJXd97IigJPJthLcUzhkytYADoB6ZZ++QajX16PyZePk4WhXYPnRTkh8+GkWkT+iWK/PIH5EKQIvb/iVSp7ttsOileS8ZeDa8MjArjt47bCpQiFvY3CXEFAw+lHeV3kK0sGbfG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924269; c=relaxed/simple;
	bh=mw42SUJDDITRUbgt08cKk2Dl8LHIkgW9b0yY7Ia4NLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seFxpQWDHHiksibkb+szZrVjksPUaX8cO2sFzoF5BciJduGeju8LZruCaW0X0aP0i1ysQ96aX3lzCjZ1dGO6eGWslRQRCsjATrUpHlXlWRNOxUVVNGgTMIn9Jqq72QsxcAEiUaPJYTek3V9LrNaeJbvqcheg/y/rjHEq+gW1ZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hxX3p06f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eVAPJK9k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hxX3p06f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eVAPJK9k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 747D61F395;
	Wed,  8 Oct 2025 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759924265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4Bc/HWqRUVrP4TgIQU1x+uXkAdFOoEWWXqvS2HP7TU=;
	b=hxX3p06fA2KC2qzOMRgN0zuWraJDPFvlSrM4cRYX+TRpAJ6jtPm2ivxM2a9VuT7jyM7hje
	HXtWlnQihVjT9mXgKAfoNUmazoljexkriptsnvgS8+cxaKQWZ6/WD28gCDmyennRdCH8XI
	6UCqE7Ui/QgsR8OMuu8oxmEPOX2iqUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759924265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4Bc/HWqRUVrP4TgIQU1x+uXkAdFOoEWWXqvS2HP7TU=;
	b=eVAPJK9kJATwjUXaGK/pCT7pMDSzclLSMv4UXKKn6bdUk5kf3gssvHoPe7H08J//pWVuQN
	TktEL4Ibl0Gi9hBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759924265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4Bc/HWqRUVrP4TgIQU1x+uXkAdFOoEWWXqvS2HP7TU=;
	b=hxX3p06fA2KC2qzOMRgN0zuWraJDPFvlSrM4cRYX+TRpAJ6jtPm2ivxM2a9VuT7jyM7hje
	HXtWlnQihVjT9mXgKAfoNUmazoljexkriptsnvgS8+cxaKQWZ6/WD28gCDmyennRdCH8XI
	6UCqE7Ui/QgsR8OMuu8oxmEPOX2iqUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759924265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4Bc/HWqRUVrP4TgIQU1x+uXkAdFOoEWWXqvS2HP7TU=;
	b=eVAPJK9kJATwjUXaGK/pCT7pMDSzclLSMv4UXKKn6bdUk5kf3gssvHoPe7H08J//pWVuQN
	TktEL4Ibl0Gi9hBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5656B13A3D;
	Wed,  8 Oct 2025 11:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /qQQFSlQ5mgzMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 11:51:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 022D6A0ACD; Wed,  8 Oct 2025 13:51:00 +0200 (CEST)
Date: Wed, 8 Oct 2025 13:51:00 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 08/13] ext4: refactor mext_check_arguments()
Message-ID: <sw2cwci4ofcj7s7yccwjlixcvlxkrfnwtbgtqv7lljjtaudstf@hmkkh2ciamy7>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092610.1936929-9-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 25-09-25 17:26:04, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When moving extents, mext_check_validity() performs some basic file
> system and file checks. However, some essential checks need to be
> performed after acquiring the i_rwsem are still scattered in
> mext_check_arguments(). Move those checks into mext_check_validity() and
> make it executes entirely under the i_rwsem to make the checks clearer.
> Furthermore, rename mext_check_arguments() to mext_check_adjust_range(),
> as it only performs checks and length adjustments on the move extent
> range. Finally, also change the print message for the non-existent file
> check to be consistent with other unsupported checks.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/move_extent.c | 97 +++++++++++++++++++------------------------
>  1 file changed, 43 insertions(+), 54 deletions(-)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index cdd175d5c1f3..0191a3c746db 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -501,60 +501,36 @@ static int mext_check_validity(struct inode *orig_inode,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	return 0;
> -}
> -
> -/**
> - * mext_check_arguments - Check whether move extent can be done
> - *
> - * @orig_inode:		original inode
> - * @donor_inode:	donor inode
> - * @orig_start:		logical start offset in block for orig
> - * @donor_start:	logical start offset in block for donor
> - * @len:		the number of blocks to be moved
> - *
> - * Check the arguments of ext4_move_extents() whether the files can be
> - * exchanged with each other.
> - * Return 0 on success, or a negative error value on failure.
> - */
> -static int
> -mext_check_arguments(struct inode *orig_inode,
> -		     struct inode *donor_inode, __u64 orig_start,
> -		     __u64 donor_start, __u64 *len)
> -{
> -	__u64 orig_eof, donor_eof;
> +	/* Ext4 move extent supports only extent based file */
> +	if (!(ext4_test_inode_flag(orig_inode, EXT4_INODE_EXTENTS)) ||
> +	    !(ext4_test_inode_flag(donor_inode, EXT4_INODE_EXTENTS))) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "Online defrag not supported for non-extent files");
> +		return -EOPNOTSUPP;
> +	}
>  
>  	if (donor_inode->i_mode & (S_ISUID|S_ISGID)) {
> -		ext4_debug("ext4 move extent: suid or sgid is set"
> -			   " to donor file [ino:orig %lu, donor %lu]\n",
> +		ext4_debug("ext4 move extent: suid or sgid is set to donor file [ino:orig %lu, donor %lu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
>  
> -	if (IS_IMMUTABLE(donor_inode) || IS_APPEND(donor_inode))
> +	if (IS_IMMUTABLE(donor_inode) || IS_APPEND(donor_inode)) {
> +		ext4_debug("ext4 move extent: donor should not be immutable or append file [ino:orig %lu, donor %lu]\n",
> +			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EPERM;
> +	}
>  
>  	/* Ext4 move extent does not support swap files */
>  	if (IS_SWAPFILE(orig_inode) || IS_SWAPFILE(donor_inode)) {
>  		ext4_debug("ext4 move extent: The argument files should not be swap files [ino:orig %lu, donor %lu]\n",
> -			orig_inode->i_ino, donor_inode->i_ino);
> +			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -ETXTBSY;
>  	}
>  
>  	if (ext4_is_quota_file(orig_inode) || ext4_is_quota_file(donor_inode)) {
>  		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %lu, donor %lu]\n",
> -			orig_inode->i_ino, donor_inode->i_ino);
> -		return -EOPNOTSUPP;
> -	}
> -
> -	/* Ext4 move extent supports only extent based file */
> -	if (!(ext4_test_inode_flag(orig_inode, EXT4_INODE_EXTENTS))) {
> -		ext4_debug("ext4 move extent: orig file is not extents "
> -			"based file [ino:orig %lu]\n", orig_inode->i_ino);
> -		return -EOPNOTSUPP;
> -	} else if (!(ext4_test_inode_flag(donor_inode, EXT4_INODE_EXTENTS))) {
> -		ext4_debug("ext4 move extent: donor file is not extents "
> -			"based file [ino:donor %lu]\n", donor_inode->i_ino);
> +			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EOPNOTSUPP;
>  	}
>  
> @@ -563,12 +539,25 @@ mext_check_arguments(struct inode *orig_inode,
>  		return -EINVAL;
>  	}
>  
> +	return 0;
> +}
> +
> +/*
> + * Check the moving range of ext4_move_extents() whether the files can be
> + * exchanged with each other, and adjust the length to fit within the file
> + * size. Return 0 on success, or a negative error value on failure.
> + */
> +static int mext_check_adjust_range(struct inode *orig_inode,
> +				   struct inode *donor_inode, __u64 orig_start,
> +				   __u64 donor_start, __u64 *len)
> +{
> +	__u64 orig_eof, donor_eof;
> +
>  	/* Start offset should be same */
>  	if ((orig_start & ~(PAGE_MASK >> orig_inode->i_blkbits)) !=
>  	    (donor_start & ~(PAGE_MASK >> orig_inode->i_blkbits))) {
> -		ext4_debug("ext4 move extent: orig and donor's start "
> -			"offsets are not aligned [ino:orig %lu, donor %lu]\n",
> -			orig_inode->i_ino, donor_inode->i_ino);
> +		ext4_debug("ext4 move extent: orig and donor's start offsets are not aligned [ino:orig %lu, donor %lu]\n",
> +			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
>  
> @@ -577,9 +566,9 @@ mext_check_arguments(struct inode *orig_inode,
>  	    (*len > EXT_MAX_BLOCKS) ||
>  	    (donor_start + *len >= EXT_MAX_BLOCKS) ||
>  	    (orig_start + *len >= EXT_MAX_BLOCKS))  {
> -		ext4_debug("ext4 move extent: Can't handle over [%u] blocks "
> -			"[ino:orig %lu, donor %lu]\n", EXT_MAX_BLOCKS,
> -			orig_inode->i_ino, donor_inode->i_ino);
> +		ext4_debug("ext4 move extent: Can't handle over [%u] blocks [ino:orig %lu, donor %lu]\n",
> +			   EXT_MAX_BLOCKS,
> +			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
>  
> @@ -594,9 +583,8 @@ mext_check_arguments(struct inode *orig_inode,
>  	else if (donor_eof < donor_start + *len - 1)
>  		*len = donor_eof - donor_start;
>  	if (!*len) {
> -		ext4_debug("ext4 move extent: len should not be 0 "
> -			"[ino:orig %lu, donor %lu]\n", orig_inode->i_ino,
> -			donor_inode->i_ino);
> +		ext4_debug("ext4 move extent: len should not be 0 [ino:orig %lu, donor %lu]\n",
> +			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
>  
> @@ -629,22 +617,22 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  	ext4_lblk_t d_start = donor_blk;
>  	int ret;
>  
> -	ret = mext_check_validity(orig_inode, donor_inode);
> -	if (ret)
> -		return ret;
> -
>  	/* Protect orig and donor inodes against a truncate */
>  	lock_two_nondirectories(orig_inode, donor_inode);
>  
> +	ret = mext_check_validity(orig_inode, donor_inode);
> +	if (ret)
> +		goto unlock;
> +
>  	/* Wait for all existing dio workers */
>  	inode_dio_wait(orig_inode);
>  	inode_dio_wait(donor_inode);
>  
>  	/* Protect extent tree against block allocations via delalloc */
>  	ext4_double_down_write_data_sem(orig_inode, donor_inode);
> -	/* Check the filesystem environment whether move_extent can be done */
> -	ret = mext_check_arguments(orig_inode, donor_inode, orig_blk,
> -				    donor_blk, &len);
> +	/* Check and adjust the specified move_extent range. */
> +	ret = mext_check_adjust_range(orig_inode, donor_inode, orig_blk,
> +				      donor_blk, &len);
>  	if (ret)
>  		goto out;
>  	o_end = o_start + len;
> @@ -725,6 +713,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  
>  	ext4_free_ext_path(path);
>  	ext4_double_up_write_data_sem(orig_inode, donor_inode);
> +unlock:
>  	unlock_two_nondirectories(orig_inode, donor_inode);
>  
>  	return ret;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

