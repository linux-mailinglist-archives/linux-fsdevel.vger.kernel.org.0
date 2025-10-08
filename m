Return-Path: <linux-fsdevel+bounces-63587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEA8BC49D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 13:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13EC24F1DE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86412F744C;
	Wed,  8 Oct 2025 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z1onDlCZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wI/sr3JX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z1onDlCZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wI/sr3JX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727C52F0C7E
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924046; cv=none; b=mZbLBUVNfk5nUXU7ezy2QLrI4m28bAgVvMBNVESygVfzIDhHDhuCaJP2vBxdV56jdccFqIai5SVXF/By951cybhvpe8ya4UUAWnacmQEQhHDPkBFOsUsrLo/mfTnvxNtpNkNeQtk6wv7FDpdQ9gGq/QBnlPGN31D1uTf1s5VuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924046; c=relaxed/simple;
	bh=BCj2017w4q0AVTz8k/ZtqLbgbB6Um++4AhpJZ8g7v9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK1czq6W3L0hDZuVEaN80TNgx+c6AMmnUTyPCqqRxTR1nsP6FfYruu3MGQNwRcdGTwMbccmrMGUC37BTYDL7j9E5SEG7P0l08mzFUP78rIsLVRVFEgTQzDJvl6ee7IcKtbDVTPXyQvK2vyPM+K7Rm6/IrsHjf1VFzc5NgvFtT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z1onDlCZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wI/sr3JX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z1onDlCZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wI/sr3JX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B560A1F395;
	Wed,  8 Oct 2025 11:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759924042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3E3CbeDSSPxcw0Ahh2QDjxxCNPz/SeyAKZYji2hB7II=;
	b=Z1onDlCZgrwObF7T9FEmGzAAaVCUuF/vZ9zJ40GBUm2wDdmCffOVQXvSPX49W+8Ftuo7Bd
	4w7oyV88SA2bh9/igjBrzHtd+OhkhVOhXbVj3+YZyhFH0SS1kfNRWdSravD6npbUZYI3lD
	8DYhEhAsMjCTDCj/7RtvwPiV2s1NCxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759924042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3E3CbeDSSPxcw0Ahh2QDjxxCNPz/SeyAKZYji2hB7II=;
	b=wI/sr3JXNpCcuJ9mdWYKgil52E/VyauNDk8iM9D6JdjjdzxfsR7w/W3TlNuoYEUc7g3kWX
	2kZDmjnI3SaGOTDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Z1onDlCZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="wI/sr3JX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759924042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3E3CbeDSSPxcw0Ahh2QDjxxCNPz/SeyAKZYji2hB7II=;
	b=Z1onDlCZgrwObF7T9FEmGzAAaVCUuF/vZ9zJ40GBUm2wDdmCffOVQXvSPX49W+8Ftuo7Bd
	4w7oyV88SA2bh9/igjBrzHtd+OhkhVOhXbVj3+YZyhFH0SS1kfNRWdSravD6npbUZYI3lD
	8DYhEhAsMjCTDCj/7RtvwPiV2s1NCxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759924042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3E3CbeDSSPxcw0Ahh2QDjxxCNPz/SeyAKZYji2hB7II=;
	b=wI/sr3JXNpCcuJ9mdWYKgil52E/VyauNDk8iM9D6JdjjdzxfsR7w/W3TlNuoYEUc7g3kWX
	2kZDmjnI3SaGOTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A010F13A3D;
	Wed,  8 Oct 2025 11:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6YYVJ0pP5mj+LgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 11:47:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 389A7A0ACD; Wed,  8 Oct 2025 13:47:14 +0200 (CEST)
Date: Wed, 8 Oct 2025 13:47:14 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 07/13] ext4: add mext_check_validity() to do basic
 check
Message-ID: <klbs735aa2hewiugz474b35b4o7yxxsnkiqjwvka7x6eefphht@l3hdn3hjaisr>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092610.1936929-8-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B560A1F395
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Thu 25-09-25 17:26:03, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Currently, the basic validation checks during the move extent operation
> are scattered across __ext4_ioctl() and ext4_move_extents(), which makes
> the code somewhat disorganized. Introduce a new helper,
> mext_check_validity(), to handle these checks. This change involves only
> code relocation without any logical modifications.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ioctl.c       |  10 -----
>  fs/ext4/move_extent.c | 102 +++++++++++++++++++++++++++---------------
>  2 files changed, 65 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 84e3c73952d7..a0d3a951ae85 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1349,16 +1349,6 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		if (!(fd_file(donor)->f_mode & FMODE_WRITE))
>  			return -EBADF;
>  
> -		if (ext4_has_feature_bigalloc(sb)) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "Online defrag not supported with bigalloc");
> -			return -EOPNOTSUPP;
> -		} else if (IS_DAX(inode)) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "Online defrag not supported with DAX");
> -			return -EOPNOTSUPP;
> -		}
> -
>  		err = mnt_want_write_file(filp);
>  		if (err)
>  			return err;
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 6175906c7119..cdd175d5c1f3 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -442,6 +442,68 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
>  	goto unlock_folios;
>  }
>  
> +/*
> + * Check the validity of the basic filesystem environment and the
> + * inodes' support status.
> + */
> +static int mext_check_validity(struct inode *orig_inode,
> +			       struct inode *donor_inode)
> +{
> +	struct super_block *sb = orig_inode->i_sb;
> +
> +	/* origin and donor should be different inodes */
> +	if (orig_inode == donor_inode) {
> +		ext4_debug("ext4 move extent: The argument files should not be same inode [ino:orig %lu, donor %lu]\n",
> +			   orig_inode->i_ino, donor_inode->i_ino);
> +		return -EINVAL;
> +	}
> +
> +	/* origin and donor should belone to the same filesystem */
> +	if (orig_inode->i_sb != donor_inode->i_sb) {
> +		ext4_debug("ext4 move extent: The argument files should be in same FS [ino:orig %lu, donor %lu]\n",
> +			   orig_inode->i_ino, donor_inode->i_ino);
> +		return -EINVAL;
> +	}
> +
> +	/* Regular file check */
> +	if (!S_ISREG(orig_inode->i_mode) || !S_ISREG(donor_inode->i_mode)) {
> +		ext4_debug("ext4 move extent: The argument files should be regular file [ino:orig %lu, donor %lu]\n",
> +			   orig_inode->i_ino, donor_inode->i_ino);
> +		return -EINVAL;
> +	}
> +
> +	if (ext4_has_feature_bigalloc(sb)) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "Online defrag not supported with bigalloc");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (IS_DAX(orig_inode)) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "Online defrag not supported with DAX");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*
> +	 * TODO: it's not obvious how to swap blocks for inodes with full
> +	 * journaling enabled.
> +	 */
> +	if (ext4_should_journal_data(orig_inode) ||
> +	    ext4_should_journal_data(donor_inode)) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "Online defrag not supported with data journaling");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (IS_ENCRYPTED(orig_inode) || IS_ENCRYPTED(donor_inode)) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "Online defrag not supported for encrypted files");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * mext_check_arguments - Check whether move extent can be done
>   *
> @@ -567,43 +629,9 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  	ext4_lblk_t d_start = donor_blk;
>  	int ret;
>  
> -	if (orig_inode->i_sb != donor_inode->i_sb) {
> -		ext4_debug("ext4 move extent: The argument files "
> -			"should be in same FS [ino:orig %lu, donor %lu]\n",
> -			orig_inode->i_ino, donor_inode->i_ino);
> -		return -EINVAL;
> -	}
> -
> -	/* orig and donor should be different inodes */
> -	if (orig_inode == donor_inode) {
> -		ext4_debug("ext4 move extent: The argument files should not "
> -			"be same inode [ino:orig %lu, donor %lu]\n",
> -			orig_inode->i_ino, donor_inode->i_ino);
> -		return -EINVAL;
> -	}
> -
> -	/* Regular file check */
> -	if (!S_ISREG(orig_inode->i_mode) || !S_ISREG(donor_inode->i_mode)) {
> -		ext4_debug("ext4 move extent: The argument files should be "
> -			"regular file [ino:orig %lu, donor %lu]\n",
> -			orig_inode->i_ino, donor_inode->i_ino);
> -		return -EINVAL;
> -	}
> -
> -	/* TODO: it's not obvious how to swap blocks for inodes with full
> -	   journaling enabled */
> -	if (ext4_should_journal_data(orig_inode) ||
> -	    ext4_should_journal_data(donor_inode)) {
> -		ext4_msg(orig_inode->i_sb, KERN_ERR,
> -			 "Online defrag not supported with data journaling");
> -		return -EOPNOTSUPP;
> -	}
> -
> -	if (IS_ENCRYPTED(orig_inode) || IS_ENCRYPTED(donor_inode)) {
> -		ext4_msg(orig_inode->i_sb, KERN_ERR,
> -			 "Online defrag not supported for encrypted files");
> -		return -EOPNOTSUPP;
> -	}
> +	ret = mext_check_validity(orig_inode, donor_inode);
> +	if (ret)
> +		return ret;
>  
>  	/* Protect orig and donor inodes against a truncate */
>  	lock_two_nondirectories(orig_inode, donor_inode);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

