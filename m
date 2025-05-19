Return-Path: <linux-fsdevel+bounces-49459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B46ABC857
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 22:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766637AA46B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 20:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A498A217679;
	Mon, 19 May 2025 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bEaZMTjB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bbv64XgJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bEaZMTjB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bbv64XgJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70293211715
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747686269; cv=none; b=B8jqTdrHJqAgBIVC23D0W4hgbT3WvSPV+AOkLzwdyeSgtFpCmfv3nn5lLzEAeaQQHYy1U250kidyeOtxhkUjSMnSrLcKRSBLGdpe7sEN402JUXdsCihoLTwPJ1dah07lL2jKuOZSgJWoER8QJ4WK0EHjF/pJa0SrYwKi5ab5Evo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747686269; c=relaxed/simple;
	bh=vKVPad6NB2x2jxACj0etyvY1GH+oppiv1umngiMCaSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu0QJRlUk9G8ST7VRL5svvSGvSmgwzEGZFkGcHjhfoiimuvsJVdI1zl/rAVyc8jJcrv3KBIrCGnv7luF/tdp17fEW6cIBciSlwfu2uuDvrdlZ8/XGOFHlC+198FyJJwQ8G0NXPmCPKRoD7nFkGjUrWGwCXBE4j0zMYsUYDQqzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bEaZMTjB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bbv64XgJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bEaZMTjB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bbv64XgJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CAB5204CC;
	Mon, 19 May 2025 20:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747686265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k879OpuEXQUarLUFeeLE7zaY4SZBkg/56/Kn+adTwh0=;
	b=bEaZMTjB1rkeZvjA75uuaZvayPkhjTe2nQvggcEzNU4HpBy1JdHEPuPvWH2eNomu5UsuKu
	CBWOaldt6ttzMI/LC2gGyzjCnDr9DIG1H8jv04ZdM0ShEiRkee8UPqQ2/Q6vuLkEuqW9T2
	Q3Y5k+tIyodtu+KKekObxBbyneCCabY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747686265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k879OpuEXQUarLUFeeLE7zaY4SZBkg/56/Kn+adTwh0=;
	b=Bbv64XgJcexinKjvI1nctVf3RR2Ol0aLlHdoX7DbNXuoINK+2fCbyzD5VBPe1fX1fe/ke9
	4GThIgl87AQYv5DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bEaZMTjB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Bbv64XgJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747686265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k879OpuEXQUarLUFeeLE7zaY4SZBkg/56/Kn+adTwh0=;
	b=bEaZMTjB1rkeZvjA75uuaZvayPkhjTe2nQvggcEzNU4HpBy1JdHEPuPvWH2eNomu5UsuKu
	CBWOaldt6ttzMI/LC2gGyzjCnDr9DIG1H8jv04ZdM0ShEiRkee8UPqQ2/Q6vuLkEuqW9T2
	Q3Y5k+tIyodtu+KKekObxBbyneCCabY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747686265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k879OpuEXQUarLUFeeLE7zaY4SZBkg/56/Kn+adTwh0=;
	b=Bbv64XgJcexinKjvI1nctVf3RR2Ol0aLlHdoX7DbNXuoINK+2fCbyzD5VBPe1fX1fe/ke9
	4GThIgl87AQYv5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DD4213A7C;
	Mon, 19 May 2025 20:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6dq0EnmTK2giFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 May 2025 20:24:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0A56AA0A31; Mon, 19 May 2025 22:24:25 +0200 (CEST)
Date: Mon, 19 May 2025 22:24:24 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH v2 5/8] ext4: correct the journal credits calculations of
 allocating blocks
Message-ID: <nhxfuu53wyacsrq7xqgxvgzcggyscu2tbabginahcygvmc45hy@t4fvmyeky33e>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512063319.3539411-6-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,huawei.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 5CAB5204CC
X-Spam-Level: 
X-Spam-Flag: NO

On Mon 12-05-25 14:33:16, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The journal credits calculation in ext4_ext_index_trans_blocks() is
> currently inadequate. It only multiplies the depth of the extents tree
> and doesn't account for the blocks that may be required for adding the
> leaf extents themselves.
> 
> After enabling large folios, we can easily run out of handle credits,
> triggering a warning in jbd2_journal_dirty_metadata() on filesystems
> with a 1KB block size. This occurs because we may need more extents when
> iterating through each large folio in
> ext4_do_writepages()->mpage_map_and_submit_extent(). Therefore, we
> should modify ext4_ext_index_trans_blocks() to include a count of the
> leaf extents in the worst case as well.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

One comment below

> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c616a16a9f36..e759941bd262 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2405,9 +2405,10 @@ int ext4_ext_index_trans_blocks(struct inode *inode, int extents)
>  	depth = ext_depth(inode);
>  
>  	if (extents <= 1)
> -		index = depth * 2;
> +		index = depth * 2 + extents;
>  	else
> -		index = depth * 3;
> +		index = depth * 3 +
> +			DIV_ROUND_UP(extents, ext4_ext_space_block(inode, 0));
>  
>  	return index;
>  }
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ffbf444b56d4..3e962a760d71 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5792,18 +5792,16 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
>  	int ret;
>  
>  	/*
> -	 * How many index blocks need to touch to map @lblocks logical blocks
> -	 * to @pextents physical extents?
> +	 * How many index and lead blocks need to touch to map @lblocks
> +	 * logical blocks to @pextents physical extents?
>  	 */
>  	idxblocks = ext4_index_trans_blocks(inode, lblocks, pextents);
>  
> -	ret = idxblocks;
> -
>  	/*
>  	 * Now let's see how many group bitmaps and group descriptors need
>  	 * to account
>  	 */
> -	groups = idxblocks + pextents;
> +	groups = idxblocks;

I don't think you can drop 'pextents' from this computation... Yes, you now
account possible number of modified extent tree leaf blocks in
ext4_index_trans_blocks() but additionally, each extent separately may be
allocated from a different group and thus need to update different bitmap
and group descriptor block. That is separate from the computation you do in
ext4_index_trans_blocks() AFAICT...

								Honza

>  	gdpblocks = groups;
>  	if (groups > ngroups)
>  		groups = ngroups;
> @@ -5811,7 +5809,7 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
>  		gdpblocks = EXT4_SB(inode->i_sb)->s_gdb_count;
>  
>  	/* bitmaps and block group descriptor blocks */
> -	ret += groups + gdpblocks;
> +	ret = idxblocks + groups + gdpblocks;
>  
>  	/* Blocks for super block, inode, quota and xattr blocks */
>  	ret += EXT4_META_TRANS_BLOCKS(inode->i_sb);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

