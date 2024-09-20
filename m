Return-Path: <linux-fsdevel+bounces-29765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD4097D816
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 18:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E1EFB23B9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2033E17DFEC;
	Fri, 20 Sep 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fzBsUIsb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZS+Iu+FD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fzBsUIsb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZS+Iu+FD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332817C224;
	Fri, 20 Sep 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726848851; cv=none; b=aBLygUjlCh8SRloUiClqryAVKIqUQzC8XIYP4DDsZuvSPGxOnFoLle6Ltbz9wiKopzxYs+nc966lWwthNu9tIo5aNhDp1zk+D+dRHLDQmoxtWEeJgoiK2aKPEOlr8MTjt4+DrshYcdgX8Kb0DnqvcCqkVG0J/HKyfF7rak+bZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726848851; c=relaxed/simple;
	bh=C2SqpYIGpwlVdRW4Q3baOxZijY8WtWEJoENSXs9zodY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olkMBdUeNDkbl4iTDIF8/EXpDQqMOIj3Eo/NrKRhRlKnXTgA1KB4/fc+5Pr4g/lcdv8sbWPYfdAaJtse18vDl6sdi9xGwmSSxWxrWeJcXPxc5+dCHX48owRtnl2SEDVMGsIfDXSRCut1BMOs1avBSDOG7NY8VblJTOA8sbkZGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fzBsUIsb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZS+Iu+FD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fzBsUIsb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZS+Iu+FD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D35141F7F1;
	Fri, 20 Sep 2024 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726848847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNVPuZJDLc5AAqlm93Kc3imjJeumAJqKMSO1OJa2d+Q=;
	b=fzBsUIsbwWRywYTMua2OrXmWRt339qzmLgva8i2BcbYXyYCP2XB1jz0KtpLLMzxjo/MzSq
	sbvnBXl7FVCE5Jk65v3YC1gIAvtqB9dTRntPcphEN6sJlHwd2ItvPmjrOYSDkTCuoN3bIZ
	+uXxKrH1euntHkToFppkMnodrbnCmew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726848847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNVPuZJDLc5AAqlm93Kc3imjJeumAJqKMSO1OJa2d+Q=;
	b=ZS+Iu+FDbkhZtiWJPlBxmm1T8fl1qODK+impvKFfPLwlEd4ihoq1sfZV0M1LHoxFBZbVjW
	XWWp0hv01wgvDyDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726848847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNVPuZJDLc5AAqlm93Kc3imjJeumAJqKMSO1OJa2d+Q=;
	b=fzBsUIsbwWRywYTMua2OrXmWRt339qzmLgva8i2BcbYXyYCP2XB1jz0KtpLLMzxjo/MzSq
	sbvnBXl7FVCE5Jk65v3YC1gIAvtqB9dTRntPcphEN6sJlHwd2ItvPmjrOYSDkTCuoN3bIZ
	+uXxKrH1euntHkToFppkMnodrbnCmew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726848847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNVPuZJDLc5AAqlm93Kc3imjJeumAJqKMSO1OJa2d+Q=;
	b=ZS+Iu+FDbkhZtiWJPlBxmm1T8fl1qODK+impvKFfPLwlEd4ihoq1sfZV0M1LHoxFBZbVjW
	XWWp0hv01wgvDyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECBDF13AE1;
	Fri, 20 Sep 2024 16:14:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PfiIOUmf7WbVawAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Sep 2024 16:14:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E4C28A08BD; Fri, 20 Sep 2024 18:13:51 +0200 (CEST)
Date: Fri, 20 Sep 2024 18:13:51 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 03/10] ext4: drop ext4_update_disksize_before_punch()
Message-ID: <20240920161351.ax3oidpt6w6bf3o4@quack3>
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904062925.716856-4-yi.zhang@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 04-09-24 14:29:18, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since we always write back dirty data before zeroing range and punching
> hole, the delalloc extended file's disksize of should be updated
> properly when writing back pages, hence we don't need to update file's
> disksize before discarding page cache in ext4_zero_range() and
> ext4_punch_hole(), just drop ext4_update_disksize_before_punch().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

So when we don't write out before hole punching & company this needs to stay
in some shape or form. 

								Honza

> ---
>  fs/ext4/ext4.h    |  3 ---
>  fs/ext4/extents.c |  4 ----
>  fs/ext4/inode.c   | 37 +------------------------------------
>  3 files changed, 1 insertion(+), 43 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 08acd152261e..e8d7965f62c4 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3414,9 +3414,6 @@ static inline int ext4_update_inode_size(struct inode *inode, loff_t newsize)
>  	return changed;
>  }
>  
> -int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
> -				      loff_t len);
> -
>  struct ext4_group_info {
>  	unsigned long   bb_state;
>  #ifdef AGGRESSIVE_CHECK
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 19a9b14935b7..d9fccf2970e9 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4637,10 +4637,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
>  			  EXT4_EX_NOCACHE);
>  
> -		ret = ext4_update_disksize_before_punch(inode, offset, len);
> -		if (ret)
> -			goto out_invalidate_lock;
> -
>  		/* Now release the pages and zero block aligned part of pages */
>  		truncate_pagecache_range(inode, start, end - 1);
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 8af25442d44d..9343ce9f2b01 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3872,37 +3872,6 @@ int ext4_can_truncate(struct inode *inode)
>  	return 0;
>  }
>  
> -/*
> - * We have to make sure i_disksize gets properly updated before we truncate
> - * page cache due to hole punching or zero range. Otherwise i_disksize update
> - * can get lost as it may have been postponed to submission of writeback but
> - * that will never happen after we truncate page cache.
> - */
> -int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
> -				      loff_t len)
> -{
> -	handle_t *handle;
> -	int ret;
> -
> -	loff_t size = i_size_read(inode);
> -
> -	WARN_ON(!inode_is_locked(inode));
> -	if (offset > size || offset + len < size)
> -		return 0;
> -
> -	if (EXT4_I(inode)->i_disksize >= size)
> -		return 0;
> -
> -	handle = ext4_journal_start(inode, EXT4_HT_MISC, 1);
> -	if (IS_ERR(handle))
> -		return PTR_ERR(handle);
> -	ext4_update_i_disksize(inode, size);
> -	ret = ext4_mark_inode_dirty(handle, inode);
> -	ext4_journal_stop(handle);
> -
> -	return ret;
> -}
> -
>  static void ext4_wait_dax_page(struct inode *inode)
>  {
>  	filemap_invalidate_unlock(inode->i_mapping);
> @@ -4022,13 +3991,9 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
>  
>  	/* Now release the pages and zero block aligned part of pages*/
> -	if (last_block_offset > first_block_offset) {
> -		ret = ext4_update_disksize_before_punch(inode, offset, length);
> -		if (ret)
> -			goto out_dio;
> +	if (last_block_offset > first_block_offset)
>  		truncate_pagecache_range(inode, first_block_offset,
>  					 last_block_offset);
> -	}
>  
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>  		credits = ext4_writepage_trans_blocks(inode);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

