Return-Path: <linux-fsdevel+bounces-53669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F1BAF5B9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9E1521269
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB37230AACA;
	Wed,  2 Jul 2025 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IzPoI/X0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vBd71ZZa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IzPoI/X0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vBd71ZZa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F730AAAE
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467830; cv=none; b=YpaCSkCGxWZ2SfU0MKnfmTW15JGoTW/gGiuqe8TA7SSM8oqr62Bt9V5vAx4qO5zkVyCD7iPpWplCZsETmlRf1XaTNYk2vadvi6o1dLvM3QhzHl+GzEzYHGg62RI8pdiLblKzNxNeuOqT4haCVdOPcEA9+k1junZBf6W1jnOftsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467830; c=relaxed/simple;
	bh=pT4yzj1lNpIXcGjJ5NDJQt7dDxIa2I5li6dwbOXXR5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltw6fXaDGAoSvhOQXMkqDQpeGz8Y86d62Ay7jSlmRPt3KgxG0Ow7z/7g0ZV0j2ejQcL0XQ1cQ6ND5psikqkA9yz6La4kbC6NR8Eiv00MD5jlToCVoYlCJKEkixrrBhAzNeMrJW1PJy6ek27EfsUQ4QJIxxpRD0Q/FmWZPiPRqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IzPoI/X0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vBd71ZZa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IzPoI/X0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vBd71ZZa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDF352118A;
	Wed,  2 Jul 2025 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751467826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNiWvVaJQ0hv8VndO0kB03luYJm/SCoG/PASRPiJfM4=;
	b=IzPoI/X04qX+BE7RNhoQglY4Hmnhl4Y6XoZUsX8KBxwtbM356/ceHcyIvwZvCsaQB8LhgS
	aAkDWgFBqIPCQ+ISDm+4oNW/1jcql0kTrQbm83vLXOKU/4tkylF3QMPshSJWBVvMDzoSWg
	m+28UG2wjWsYblyZCUREufplzJUnzu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751467826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNiWvVaJQ0hv8VndO0kB03luYJm/SCoG/PASRPiJfM4=;
	b=vBd71ZZasTrs4yLhYJgxEMoP/b+r5ADYr1FAOCq4TJqxKr831xeC6AZopY3UkdMpzVVXj8
	ZE19RQShTpMqocDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751467826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNiWvVaJQ0hv8VndO0kB03luYJm/SCoG/PASRPiJfM4=;
	b=IzPoI/X04qX+BE7RNhoQglY4Hmnhl4Y6XoZUsX8KBxwtbM356/ceHcyIvwZvCsaQB8LhgS
	aAkDWgFBqIPCQ+ISDm+4oNW/1jcql0kTrQbm83vLXOKU/4tkylF3QMPshSJWBVvMDzoSWg
	m+28UG2wjWsYblyZCUREufplzJUnzu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751467826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNiWvVaJQ0hv8VndO0kB03luYJm/SCoG/PASRPiJfM4=;
	b=vBd71ZZasTrs4yLhYJgxEMoP/b+r5ADYr1FAOCq4TJqxKr831xeC6AZopY3UkdMpzVVXj8
	ZE19RQShTpMqocDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19D661369C;
	Wed,  2 Jul 2025 14:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LXr6BTJHZWgLTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Jul 2025 14:50:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0796DA0A55; Wed,  2 Jul 2025 16:50:21 +0200 (CEST)
Date: Wed, 2 Jul 2025 16:50:21 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, sashal@kernel.org, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 09/10] ext4: replace ext4_writepage_trans_blocks()
Message-ID: <bq37dhlk3uxrwmejrhqkvjthlq7j3fac7dggkchpdzx7m223jl@njfevshlrkgh>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
 <20250701130635.4079595-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701130635.4079595-10-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 

On Tue 01-07-25 21:06:34, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> After ext4 supports large folios, the semantics of reserving credits in
> pages is no longer applicable. In most scenarios, reserving credits in
> extents is sufficient. Therefore, introduce ext4_chunk_trans_extent()
> to replace ext4_writepage_trans_blocks(). move_extent_per_page() is the
> only remaining location where we are still processing extents in pages.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h        |  2 +-
>  fs/ext4/extents.c     |  6 +++---
>  fs/ext4/inline.c      |  6 +++---
>  fs/ext4/inode.c       | 33 +++++++++++++++------------------
>  fs/ext4/move_extent.c |  3 ++-
>  fs/ext4/xattr.c       |  2 +-
>  6 files changed, 25 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 18373de980f2..f705046ba6c6 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3064,9 +3064,9 @@ extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
>  extern void ext4_set_inode_flags(struct inode *, bool init);
>  extern int ext4_alloc_da_blocks(struct inode *inode);
>  extern void ext4_set_aops(struct inode *inode);
> -extern int ext4_writepage_trans_blocks(struct inode *);
>  extern int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode);
>  extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
> +extern int ext4_chunk_trans_extent(struct inode *inode, int nrblocks);
>  extern int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
>  				  int pextents);
>  extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index b543a46fc809..f0f155458697 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5171,7 +5171,7 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
>  				credits = depth + 2;
>  			}
>  
> -			restart_credits = ext4_writepage_trans_blocks(inode);
> +			restart_credits = ext4_chunk_trans_extent(inode, 0);
>  			err = ext4_datasem_ensure_credits(handle, inode, credits,
>  					restart_credits, 0);
>  			if (err) {
> @@ -5431,7 +5431,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  
>  	truncate_pagecache(inode, start);
>  
> -	credits = ext4_writepage_trans_blocks(inode);
> +	credits = ext4_chunk_trans_extent(inode, 0);
>  	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
>  	if (IS_ERR(handle))
>  		return PTR_ERR(handle);
> @@ -5527,7 +5527,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  
>  	truncate_pagecache(inode, start);
>  
> -	credits = ext4_writepage_trans_blocks(inode);
> +	credits = ext4_chunk_trans_extent(inode, 0);
>  	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
>  	if (IS_ERR(handle))
>  		return PTR_ERR(handle);
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index a1bbcdf40824..d5b32d242495 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -562,7 +562,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
>  		return 0;
>  	}
>  
> -	needed_blocks = ext4_writepage_trans_blocks(inode);
> +	needed_blocks = ext4_chunk_trans_extent(inode, 1);
>  
>  	ret = ext4_get_inode_loc(inode, &iloc);
>  	if (ret)
> @@ -1864,7 +1864,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
>  	};
>  
>  
> -	needed_blocks = ext4_writepage_trans_blocks(inode);
> +	needed_blocks = ext4_chunk_trans_extent(inode, 1);
>  	handle = ext4_journal_start(inode, EXT4_HT_INODE, needed_blocks);
>  	if (IS_ERR(handle))
>  		return PTR_ERR(handle);
> @@ -1979,7 +1979,7 @@ int ext4_convert_inline_data(struct inode *inode)
>  			return 0;
>  	}
>  
> -	needed_blocks = ext4_writepage_trans_blocks(inode);
> +	needed_blocks = ext4_chunk_trans_extent(inode, 1);
>  
>  	iloc.bh = NULL;
>  	error = ext4_get_inode_loc(inode, &iloc);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ceaede80d791..572a70b6a934 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1295,7 +1295,8 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>  	 * Reserve one block more for addition to orphan list in case
>  	 * we allocate blocks but write fails for some reason
>  	 */
> -	needed_blocks = ext4_writepage_trans_blocks(inode) + 1;
> +	needed_blocks = ext4_chunk_trans_extent(inode,
> +			ext4_journal_blocks_per_folio(inode)) + 1;
>  	index = pos >> PAGE_SHIFT;
>  
>  	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
> @@ -4462,7 +4463,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  		return ret;
>  
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		credits = ext4_writepage_trans_blocks(inode);
> +		credits = ext4_chunk_trans_extent(inode, 2);
>  	else
>  		credits = ext4_blocks_for_truncate(inode);
>  	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
> @@ -4611,7 +4612,7 @@ int ext4_truncate(struct inode *inode)
>  	}
>  
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		credits = ext4_writepage_trans_blocks(inode);
> +		credits = ext4_chunk_trans_extent(inode, 1);
>  	else
>  		credits = ext4_blocks_for_truncate(inode);
>  
> @@ -6238,25 +6239,19 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
>  }
>  
>  /*
> - * Calculate the total number of credits to reserve to fit
> - * the modification of a single pages into a single transaction,
> - * which may include multiple chunks of block allocations.
> - *
> - * This could be called via ext4_write_begin()
> - *
> - * We need to consider the worse case, when
> - * one new block per extent.
> + * Calculate the journal credits for modifying the number of blocks
> + * in a single extent within one transaction. 'nrblocks' is used only
> + * for non-extent inodes. For extent type inodes, 'nrblocks' can be
> + * zero if the exact number of blocks is unknown.
>   */
> -int ext4_writepage_trans_blocks(struct inode *inode)
> +int ext4_chunk_trans_extent(struct inode *inode, int nrblocks)
>  {
> -	int bpp = ext4_journal_blocks_per_folio(inode);
>  	int ret;
>  
> -	ret = ext4_meta_trans_blocks(inode, bpp, bpp);
> -
> +	ret = ext4_meta_trans_blocks(inode, nrblocks, 1);
>  	/* Account for data blocks for journalled mode */
>  	if (ext4_should_journal_data(inode))
> -		ret += bpp;
> +		ret += nrblocks;
>  	return ret;
>  }
>  
> @@ -6634,10 +6629,12 @@ static int ext4_block_page_mkwrite(struct inode *inode, struct folio *folio,
>  	handle_t *handle;
>  	loff_t size;
>  	unsigned long len;
> +	int credits;
>  	int ret;
>  
> -	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
> -				    ext4_writepage_trans_blocks(inode));
> +	credits = ext4_chunk_trans_extent(inode,
> +			ext4_journal_blocks_per_folio(inode));
> +	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, credits);
>  	if (IS_ERR(handle))
>  		return PTR_ERR(handle);
>  
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 1f8493a56e8f..adae3caf175a 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -280,7 +280,8 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
>  	 */
>  again:
>  	*err = 0;
> -	jblocks = ext4_writepage_trans_blocks(orig_inode) * 2;
> +	jblocks = ext4_meta_trans_blocks(orig_inode, block_len_in_page,
> +					 block_len_in_page) * 2;
>  	handle = ext4_journal_start(orig_inode, EXT4_HT_MOVE_EXTENTS, jblocks);
>  	if (IS_ERR(handle)) {
>  		*err = PTR_ERR(handle);
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 8d15acbacc20..3fb93247330d 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -962,7 +962,7 @@ int __ext4_xattr_set_credits(struct super_block *sb, struct inode *inode,
>  	 * so we need to reserve credits for this eventuality
>  	 */
>  	if (inode && ext4_has_inline_data(inode))
> -		credits += ext4_writepage_trans_blocks(inode) + 1;
> +		credits += ext4_chunk_trans_extent(inode, 1) + 1;
>  
>  	/* We are done if ea_inode feature is not enabled. */
>  	if (!ext4_has_feature_ea_inode(sb))
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

