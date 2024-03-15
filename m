Return-Path: <linux-fsdevel+bounces-14474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFD387CF98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14252841B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188A03C46E;
	Fri, 15 Mar 2024 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="soMzoPn8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tkC6fz0j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="soMzoPn8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tkC6fz0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3223B79E;
	Fri, 15 Mar 2024 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514692; cv=none; b=aJPof6XdaOgJNOAGlZKzPwjG5/+AHhRBg7T4dvU1NRNaJk94h3mnOdAv4h5MqTKgEN6/aMI3j0UwdYrkF3VdgKQziX/VLMFyorvzFmUYStNUaSVp5WiLPYjB3TeO1tGU2mrwnmtidQEWDGU9pGoykIRhD4k9g+AiqZFbZnctPc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514692; c=relaxed/simple;
	bh=5VGj938l4gzOkJyAE0EJee+jACZOzwhK6r+WoJkLDqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPWb3tUNQyFnICFTwx3SocDcZ+JHL9iRU9zHTLRnTwJTbzw99upnEkfS2Q9tdg92gou+FXSENOCEFvqv6i08wqeR0dnqsRRMIUDK59dJB06TPw2airtUQM/Q5zEW7e3HdT861zWwSdjTVL+90QJ7y3qltjnsB0kqzjk4o9kFGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=soMzoPn8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tkC6fz0j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=soMzoPn8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tkC6fz0j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 575141FB65;
	Fri, 15 Mar 2024 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710514688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SmP6XzXz1ghOxTOVpHJhKHVZ/lTbSLQbk4H+d8hiBbc=;
	b=soMzoPn81RUHdf2dacY4HZEQ1aYRQ6YrR3YliRdFB8kP/+zLyK5RrGFiYh9GxcZNk8XEIJ
	ibS8WcRufABv/SctifWrwJyLdNJyDLeepslzMb2tnwB4r3er0eehnmC4PPHc0u5g8zEb/v
	8w//TE3gL8TmqOaTUwVYw+rdaQi60xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710514688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SmP6XzXz1ghOxTOVpHJhKHVZ/lTbSLQbk4H+d8hiBbc=;
	b=tkC6fz0j4ZoZOOSwA4YlObdS5PPf4w8TrgB3mZfMxDSB75iIekiggUNTCoEMxunzpMVcKg
	ibEfvuc+Db5kWDBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710514688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SmP6XzXz1ghOxTOVpHJhKHVZ/lTbSLQbk4H+d8hiBbc=;
	b=soMzoPn81RUHdf2dacY4HZEQ1aYRQ6YrR3YliRdFB8kP/+zLyK5RrGFiYh9GxcZNk8XEIJ
	ibS8WcRufABv/SctifWrwJyLdNJyDLeepslzMb2tnwB4r3er0eehnmC4PPHc0u5g8zEb/v
	8w//TE3gL8TmqOaTUwVYw+rdaQi60xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710514688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SmP6XzXz1ghOxTOVpHJhKHVZ/lTbSLQbk4H+d8hiBbc=;
	b=tkC6fz0j4ZoZOOSwA4YlObdS5PPf4w8TrgB3mZfMxDSB75iIekiggUNTCoEMxunzpMVcKg
	ibEfvuc+Db5kWDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4914B1368C;
	Fri, 15 Mar 2024 14:58:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iDrWEQBi9GUsSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 14:58:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E7AEBA07D9; Fri, 15 Mar 2024 15:58:03 +0100 (CET)
Date: Fri, 15 Mar 2024 15:58:03 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 13/19] ext4: prevent direct access of bd_inode
Message-ID: <20240315145803.aq2e3zrbttv6amr3@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-14-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-14-yukuai1@huaweicloud.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 22-02-24 20:45:49, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that all filesystems stash the bdev file, it's ok to get mapping
> from the file.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/dir.c       | 2 +-
>  fs/ext4/ext4_jbd2.c | 2 +-
>  fs/ext4/super.c     | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 3985f8c33f95..0733bc1eec7a 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -192,7 +192,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
>  					(PAGE_SHIFT - inode->i_blkbits);
>  			if (!ra_has_index(&file->f_ra, index))
>  				page_cache_sync_readahead(
> -					sb->s_bdev->bd_inode->i_mapping,
> +					sb->s_bdev_file->f_mapping,
>  					&file->f_ra, file,
>  					index, 1);
>  			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 5d8055161acd..dbb9aff07ac1 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -206,7 +206,7 @@ static void ext4_journal_abort_handle(const char *caller, unsigned int line,
>  
>  static void ext4_check_bdev_write_error(struct super_block *sb)
>  {
> -	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
> +	struct address_space *mapping = sb->s_bdev_file->f_mapping;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	int err;
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 2d82b9d4b079..55b3df71bf5e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -244,7 +244,7 @@ static struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
>  struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
>  				   blk_opf_t op_flags)
>  {
> -	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
> +	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev_file->f_mapping,
>  			~__GFP_FS) | __GFP_MOVABLE;
>  
>  	return __ext4_sb_bread_gfp(sb, block, op_flags, gfp);
> @@ -253,7 +253,7 @@ struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
>  struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
>  					    sector_t block)
>  {
> -	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
> +	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev_file->f_mapping,
>  			~__GFP_FS);
>  
>  	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
> @@ -5560,7 +5560,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	 * used to detect the metadata async write error.
>  	 */
>  	spin_lock_init(&sbi->s_bdev_wb_lock);
> -	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
> +	errseq_check_and_advance(&sb->s_bdev_file->f_mapping->wb_err,
>  				 &sbi->s_bdev_wb_err);
>  	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
>  	ext4_orphan_cleanup(sb, es);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

