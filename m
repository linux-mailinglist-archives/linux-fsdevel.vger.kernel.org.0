Return-Path: <linux-fsdevel+bounces-63594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EFDBC4F4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 14:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E207402BBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 12:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F792256C9F;
	Wed,  8 Oct 2025 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hTznbQdM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u7o1ByH6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hTznbQdM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u7o1ByH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96DA20C023
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927757; cv=none; b=XnU5y7dTB5AgcDHkPG9VjjewPdyhY6QVSmgWLx7R3y9+QSlyR/IFdFlDUGsUquHjZZNY6ucJ8Yxwr6vsbo7HJmF08skGleg7+6OiZ3QpnZ1ioOFSkXeRo8Twzi28Ikr5Ilf5kr2KC5wWkJk9HQd5yi/HJYYDxecp7VpAKyfb+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927757; c=relaxed/simple;
	bh=wD4ph7ksr7Y9PqrcdV3UGxg9ldNUcUA7ihnBteSKObU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUz7txTPMosAXlMqsWgvrAjbp2BlP7AepaZKtiIwInvIlQzOmsMaJ5BmA+8yH95HxWIwxeI8Gt1HljHb6b/9wPoiAN0wV/IoKOBrNFuvb+REvoBRyxv64Di4M1lS7XXFcOrXYF6u2kddydupAcoYcRGPIt8MCB8pHkRyuRZ6Ldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hTznbQdM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u7o1ByH6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hTznbQdM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u7o1ByH6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4F9333682;
	Wed,  8 Oct 2025 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759927753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+BW6/xM0yjRVEcYqLBcosbvQZRHGeQCo1d/3Di/Qk0=;
	b=hTznbQdMWZLom2mDKgB/qOLM8wl8Dpviwpwx2rh+h2CbnQN2paWN3wIIKXA379jqECmp9u
	Q8+9TTEMHspAH9KBP/vyETlQ/mXY+K6yBXADjRUJhyrBnUzyif0DA9tZ/5jilbcMNKeKnA
	DKl60XpqDesyC8YwLJteGvgAw8VGjlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759927753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+BW6/xM0yjRVEcYqLBcosbvQZRHGeQCo1d/3Di/Qk0=;
	b=u7o1ByH665vxSLDl3GM/W+IZzi0/fmshKy0J4Y7Sm96SRvCGLKdVHePufsvkRSKgkFPDcj
	4Ftr96m5IB5QGcAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hTznbQdM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u7o1ByH6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759927753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+BW6/xM0yjRVEcYqLBcosbvQZRHGeQCo1d/3Di/Qk0=;
	b=hTznbQdMWZLom2mDKgB/qOLM8wl8Dpviwpwx2rh+h2CbnQN2paWN3wIIKXA379jqECmp9u
	Q8+9TTEMHspAH9KBP/vyETlQ/mXY+K6yBXADjRUJhyrBnUzyif0DA9tZ/5jilbcMNKeKnA
	DKl60XpqDesyC8YwLJteGvgAw8VGjlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759927753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+BW6/xM0yjRVEcYqLBcosbvQZRHGeQCo1d/3Di/Qk0=;
	b=u7o1ByH665vxSLDl3GM/W+IZzi0/fmshKy0J4Y7Sm96SRvCGLKdVHePufsvkRSKgkFPDcj
	4Ftr96m5IB5QGcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A060913693;
	Wed,  8 Oct 2025 12:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D/EiJ8ld5mh8QwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 12:49:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08F98A0A9C; Wed,  8 Oct 2025 14:49:09 +0200 (CEST)
Date: Wed, 8 Oct 2025 14:49:08 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 11/13] ext4: switch to using the new extent movement
 method
Message-ID: <wdluk2p7bmgkh3n3xzep3tf3qb7mv3x2o6ltemjcahgorgmhwb@hfu7t7ar2vol>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-12-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092610.1936929-12-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C4F9333682
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
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Thu 25-09-25 17:26:07, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now that we have mext_move_extent(), we can switch to this new interface
> and deprecate move_extent_per_page(). First, after acquiring the
> i_rwsem, we can directly use ext4_map_blocks() to obtain a contiguous
> extent from the original inode as the extent to be moved. It can and
> it's safe to get mapping information from the extent status tree without
> needing to access the ondisk extent tree, because ext4_move_extent()
> will check the sequence cookie under the folio lock. Then, after
> populating the mext_data structure, we call ext4_move_extent() to move
> the extent. Finally, the length of the extent will be adjusted in
> mext.orig_map.m_len and the actual length moved is returned through
> m_len.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Two small comments below:

> +int ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
> +		      __u64 donor_blk, __u64 len, __u64 *moved_len)
>  {
>  	struct inode *orig_inode = file_inode(o_filp);
>  	struct inode *donor_inode = file_inode(d_filp);
> -	struct ext4_ext_path *path = NULL;
> -	int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
> -	ext4_lblk_t o_end, o_start = orig_blk;
> -	ext4_lblk_t d_start = donor_blk;
> +	struct mext_data mext;
> +	struct super_block *sb = orig_inode->i_sb;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	int retries = 0;
> +	u64 m_len;
>  	int ret;
>  
> +	*moved_len = 0;
> +
>  	/* Protect orig and donor inodes against a truncate */
>  	lock_two_nondirectories(orig_inode, donor_inode);
>  
>  	ret = mext_check_validity(orig_inode, donor_inode);
>  	if (ret)
> -		goto unlock;
> +		goto out;
>  
>  	/* Wait for all existing dio workers */
>  	inode_dio_wait(orig_inode);
>  	inode_dio_wait(donor_inode);
>  
> -	/* Protect extent tree against block allocations via delalloc */
> -	ext4_double_down_write_data_sem(orig_inode, donor_inode);
>  	/* Check and adjust the specified move_extent range. */
>  	ret = mext_check_adjust_range(orig_inode, donor_inode, orig_blk,
>  				      donor_blk, &len);
>  	if (ret)
>  		goto out;
> -	o_end = o_start + len;
>  
> -	*moved_len = 0;
> -	while (o_start < o_end) {
> -		struct ext4_extent *ex;
> -		ext4_lblk_t cur_blk, next_blk;
> -		pgoff_t orig_page_index, donor_page_index;
> -		int offset_in_page;
> -		int unwritten, cur_len;
> -
> -		path = get_ext_path(orig_inode, o_start, path);
> -		if (IS_ERR(path)) {
> -			ret = PTR_ERR(path);
> +	mext.orig_inode = orig_inode;
> +	mext.donor_inode = donor_inode;
> +	while (len) {
> +		mext.orig_map.m_lblk = orig_blk;
> +		mext.orig_map.m_len = len;
> +		mext.orig_map.m_flags = 0;
> +		mext.donor_lblk = donor_blk;
> +
> +		ret = ext4_map_blocks(NULL, orig_inode, &mext.orig_map, 0);
> +		if (ret < 0)
>  			goto out;
> -		}
> -		ex = path[path->p_depth].p_ext;
> -		cur_blk = le32_to_cpu(ex->ee_block);
> -		cur_len = ext4_ext_get_actual_len(ex);
> -		/* Check hole before the start pos */
> -		if (cur_blk + cur_len - 1 < o_start) {
> -			next_blk = ext4_ext_next_allocated_block(path);
> -			if (next_blk == EXT_MAX_BLOCKS) {
> -				ret = -ENODATA;
> -				goto out;
> -			}
> -			d_start += next_blk - o_start;
> -			o_start = next_blk;
> -			continue;
> -		/* Check hole after the start pos */
> -		} else if (cur_blk > o_start) {
> -			/* Skip hole */
> -			d_start += cur_blk - o_start;
> -			o_start = cur_blk;
> -			/* Extent inside requested range ?*/
> -			if (cur_blk >= o_end)
> +
> +		/* Skip moving if it is a hole or a delalloc extent. */
> +		if (mext.orig_map.m_flags &
> +		    (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {
> +			ret = mext_move_extent(&mext, &m_len);
> +			if (ret == -ESTALE)
> +				continue;
> +			if (ret == -ENOSPC &&
> +			    ext4_should_retry_alloc(sb, &retries))
> +				continue;

ENOSPC here could come only from extent tree manipulations right? I was
wondering for a while why do we check it here :).

> +			if (ret == -EBUSY &&
> +			    sbi->s_journal && retries++ < 4 &&
> +			    jbd2_journal_force_commit_nested(sbi->s_journal))
> +				continue;
> +			if (ret)
>  				goto out;
> -		} else { /* in_range(o_start, o_blk, o_len) */
> -			cur_len += cur_blk - o_start;
> +
> +			*moved_len += m_len;
> +			retries = 0;
>  		}
> -		unwritten = ext4_ext_is_unwritten(ex);
> -		if (o_end - o_start < cur_len)
> -			cur_len = o_end - o_start;
> -
> -		orig_page_index = o_start >> (PAGE_SHIFT -
> -					       orig_inode->i_blkbits);
> -		donor_page_index = d_start >> (PAGE_SHIFT -
> -					       donor_inode->i_blkbits);
> -		offset_in_page = o_start % blocks_per_page;
> -		if (cur_len > blocks_per_page - offset_in_page)
> -			cur_len = blocks_per_page - offset_in_page;
> -		/*
> -		 * Up semaphore to avoid following problems:
> -		 * a. transaction deadlock among ext4_journal_start,
> -		 *    ->write_begin via pagefault, and jbd2_journal_commit
> -		 * b. racing with ->read_folio, ->write_begin, and
> -		 *    ext4_get_block in move_extent_per_page
> -		 */
> -		ext4_double_up_write_data_sem(orig_inode, donor_inode);
> -		/* Swap original branches with new branches */
> -		*moved_len += move_extent_per_page(o_filp, donor_inode,
> -				     orig_page_index, donor_page_index,
> -				     offset_in_page, cur_len,
> -				     unwritten, &ret);
> -		ext4_double_down_write_data_sem(orig_inode, donor_inode);
> -		if (ret < 0)
> -			break;
> -		o_start += cur_len;
> -		d_start += cur_len;
> +		orig_blk += mext.orig_map.m_len;
> +		donor_blk += mext.orig_map.m_len;
> +		len -= mext.orig_map.m_len;

In case we've called mext_move_extent() we should update everything only by
m_len, shouldn't we? Although I have somewhat hard time coming up with a
realistic scenario where m_len != mext.orig_map.m_len for the parameters we
call ext4_swap_extents() with... So maybe I'm missing something.

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

