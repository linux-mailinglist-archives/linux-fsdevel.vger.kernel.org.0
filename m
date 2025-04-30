Return-Path: <linux-fsdevel+bounces-47702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10709AA4487
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 09:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609CF4C651A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 07:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6368A20E313;
	Wed, 30 Apr 2025 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a140BBS1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AmxW53oN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a140BBS1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AmxW53oN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C96204583
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999742; cv=none; b=uGI5W81Dtr7HQsdsW6Dci7vZ4XJeNL7aU3xwSyDpJq509DlKVBLFVDMBAbJivFZ0aXKDfwijGIOYmktqtqe22WXVpTw/KidWyXjFsZHZ830uV1jH4jjzoz9VSArM2ct0vdngOctndpZyrLzMIFh/wyLp9+Kq26AY797iY0agfEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999742; c=relaxed/simple;
	bh=oL6F2S79noK8agQjvQFZDwlOYMCafaISAu1nr/Nods8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiqRO7VL4E+B7quuEJmjoG0K8FffH2NlgriSdqdbIdzM+6WUfSaD8HRHIcqcxe5/7LwX/LTUjbvF8LSQIURZSAoFDAK4i/PhXRz/t0vIVBXXnpoZj3YO89BTbhNttV3slehFCv32Uhra8t6kM+lRCnVDsKG5CFCqT21yF9CeBHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a140BBS1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AmxW53oN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a140BBS1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AmxW53oN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 560922124B;
	Wed, 30 Apr 2025 07:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745999739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFcER3isckkEE9kHcLwsvX/qb4nWFwzfM26bTlsjaAQ=;
	b=a140BBS1KQd3tryldppCDK9qnsgmDg2wM3HGwhOxNFAgzuaZE/goMWCwDygzmJx1BtJjoS
	Je0SST09gIEPQrXtqc1Ksb5xnvpxhP0mJt4VMmrIUGAunqbMNTD/Kq5L6FTi0GUrZtmKdw
	eHxt+8F4kxF9Ct14j0TANsynNl82Hoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745999739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFcER3isckkEE9kHcLwsvX/qb4nWFwzfM26bTlsjaAQ=;
	b=AmxW53oNnFROgTk+SPkLZ/8HyS/CW1U3t6UZGMFlfS9VUB7uuQA9v9cEcd5OxjZKjFyM6E
	UaehUwbhuEMGaLDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745999739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFcER3isckkEE9kHcLwsvX/qb4nWFwzfM26bTlsjaAQ=;
	b=a140BBS1KQd3tryldppCDK9qnsgmDg2wM3HGwhOxNFAgzuaZE/goMWCwDygzmJx1BtJjoS
	Je0SST09gIEPQrXtqc1Ksb5xnvpxhP0mJt4VMmrIUGAunqbMNTD/Kq5L6FTi0GUrZtmKdw
	eHxt+8F4kxF9Ct14j0TANsynNl82Hoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745999739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFcER3isckkEE9kHcLwsvX/qb4nWFwzfM26bTlsjaAQ=;
	b=AmxW53oNnFROgTk+SPkLZ/8HyS/CW1U3t6UZGMFlfS9VUB7uuQA9v9cEcd5OxjZKjFyM6E
	UaehUwbhuEMGaLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 424AB139E7;
	Wed, 30 Apr 2025 07:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5d8sEHvXEWg9BgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Apr 2025 07:55:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0BD09A0AF0; Wed, 30 Apr 2025 09:55:35 +0200 (CEST)
Date: Wed, 30 Apr 2025 09:55:34 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	wanghaichi0403@gmail.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH 3/4] ext4: factor out ext4_get_maxbytes()
Message-ID: <piudbprxqkuph4sqlmdqw5mpfvhrygejzotz33nni34sxefqbs@j6bc3vhtkf2c>
References: <20250430011301.1106457-1-yi.zhang@huaweicloud.com>
 <20250430011301.1106457-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430011301.1106457-3-yi.zhang@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 30-04-25 09:13:00, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> There are several locations that get the correct maxbytes value based on
> the inode's block type. It would be beneficial to extract a common
> helper function to make the code more clear.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h    | 7 +++++++
>  fs/ext4/extents.c | 7 +------
>  fs/ext4/file.c    | 7 +------
>  fs/ext4/inode.c   | 8 +-------
>  4 files changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5a20e9cd7184..8664bb5367c5 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3378,6 +3378,13 @@ static inline unsigned int ext4_flex_bg_size(struct ext4_sb_info *sbi)
>  	return 1 << sbi->s_log_groups_per_flex;
>  }
>  
> +static inline loff_t ext4_get_maxbytes(struct inode *inode)
> +{
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		return inode->i_sb->s_maxbytes;
> +	return EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
> +}
> +
>  #define ext4_std_error(sb, errno)				\
>  do {								\
>  	if ((errno))						\
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c616a16a9f36..b294d2f35a26 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4931,12 +4931,7 @@ static const struct iomap_ops ext4_iomap_xattr_ops = {
>  
>  static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
>  {
> -	u64 maxbytes;
> -
> -	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		maxbytes = inode->i_sb->s_maxbytes;
> -	else
> -		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
> +	u64 maxbytes = ext4_get_maxbytes(inode);
>  
>  	if (*len == 0)
>  		return -EINVAL;
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index beb078ee4811..b845a25f7932 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -929,12 +929,7 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
>  loff_t ext4_llseek(struct file *file, loff_t offset, int whence)
>  {
>  	struct inode *inode = file->f_mapping->host;
> -	loff_t maxbytes;
> -
> -	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
> -		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
> -	else
> -		maxbytes = inode->i_sb->s_maxbytes;
> +	loff_t maxbytes = ext4_get_maxbytes(inode);
>  
>  	switch (whence) {
>  	default:
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f9725e6347c7..9f32af1241ff 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4006,7 +4006,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	struct inode *inode = file_inode(file);
>  	struct super_block *sb = inode->i_sb;
>  	ext4_lblk_t start_lblk, end_lblk;
> -	loff_t max_end;
> +	loff_t max_end = ext4_get_maxbytes(inode) - sb->s_blocksize;
>  	loff_t end = offset + length;
>  	handle_t *handle;
>  	unsigned int credits;
> @@ -4015,12 +4015,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	trace_ext4_punch_hole(inode, offset, length, 0);
>  	WARN_ON_ONCE(!inode_is_locked(inode));
>  
> -	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		max_end = sb->s_maxbytes;
> -	else
> -		max_end = EXT4_SB(sb)->s_bitmap_maxbytes;
> -	max_end -= sb->s_blocksize;
> -
>  	/* No need to punch hole beyond i_size */
>  	if (offset >= inode->i_size || offset >= max_end)
>  		return 0;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

