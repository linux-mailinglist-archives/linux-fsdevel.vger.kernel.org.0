Return-Path: <linux-fsdevel+bounces-9845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E732845513
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA70B257A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013C215B966;
	Thu,  1 Feb 2024 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eGAr021F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wvvG7dBy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CQczmUUy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/HXHZjBV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65284DA06;
	Thu,  1 Feb 2024 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782729; cv=none; b=bxF1/hCfWFSH99qiPw4/V1XB3gb/A4LoUftA2MB/0PmwuQqYH5G3LeEn6y5RaQFPR6m1ad4Q3zNf5damKlxNrBp7sgs75wK2HTXIJblzXAwoZ5oAkqI2kRrdwkvNHcYI/2sZc7f4CCH7Fs1oBjW+Nl1syE2mGgDx92EoYoxjRHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782729; c=relaxed/simple;
	bh=S2G4z6RZBbzLAYRrR+YYEIKZ8sb6tM8yEHofdWWjRKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpO7lYP6qEZCx9nitdZPT4ZiKBXGOTs0duZTs3b6pAz9dGa9gDK/d1vnHh6AVaqYbycfEJ8djd3q3ob5i5RobTqPByJ6vZxcJH15BUkzAAXDO6gyVEv5zNCWsiexZFIWBO3ry5MTMY++xqUzPFoAOZwChudcUbspQAzDx0YUoqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eGAr021F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wvvG7dBy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CQczmUUy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/HXHZjBV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C58841FB9D;
	Thu,  1 Feb 2024 10:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aaaluYxs6+6Ye7jquPMLRkuZsZTPHXSbveSRcVoV4zk=;
	b=eGAr021Fl51e2bDejLdMArSThxgaSGibUBvxrz41ffPfV286PtzmJyqE6ol4SFpQw3onRh
	9gRGINC5eS0roEFSWdVwRETdoiISfNX5ZZUwofB2oZC/Eo99IckjXNE4hxpU7Cnv6RooZQ
	4wvdcaEvVGEuOxGKvJvheAvToyeCWaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aaaluYxs6+6Ye7jquPMLRkuZsZTPHXSbveSRcVoV4zk=;
	b=wvvG7dByZCLFyUv8bV4AliSpUQJ34OkDjl3hKa+vwsc3dCRub7C+3K5TWcQO7Z2ErJzu9p
	GbHmFkkd9w0CJmCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aaaluYxs6+6Ye7jquPMLRkuZsZTPHXSbveSRcVoV4zk=;
	b=CQczmUUyJW8a6/ChVZ5k6BoLjep68gm9nhWYT0HrbX0KWq8fUaPV1ET6YEveuqryAZsr6d
	PGwDRFtIzNekJLFMGeO4lQzF70+YIq74i9nIkolQzYPN8xwjSQ48MuxS7URE2ND7Fj2ALg
	qo0YC32eiQbcOGjx4JCgR+lUyDrFpqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aaaluYxs6+6Ye7jquPMLRkuZsZTPHXSbveSRcVoV4zk=;
	b=/HXHZjBV6zwTeDh52CVPNoalbrQt2mK36Gyf0GxrgN3mIzcNc9RqXDRGPLm3XZd8Rr7/h7
	giV0Kkhv1QzIfgBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BA9411329F;
	Thu,  1 Feb 2024 10:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Jl+JLf9vu2VUXgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:18:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7B717A0809; Thu,  1 Feb 2024 11:18:35 +0100 (CET)
Date: Thu, 1 Feb 2024 11:18:35 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 21/34] ext4: port block device access to file
Message-ID: <20240201101835.sstafasouvdxaj2v@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-21-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-21-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CQczmUUy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/HXHZjBV"
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C58841FB9D
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 23-01-24 14:26:38, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h  |  2 +-
>  fs/ext4/fsmap.c |  8 ++++----
>  fs/ext4/super.c | 52 ++++++++++++++++++++++++++--------------------------
>  3 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index a5d784872303..dcdad5da419e 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1548,7 +1548,7 @@ struct ext4_sb_info {
>  	unsigned long s_commit_interval;
>  	u32 s_max_batch_time;
>  	u32 s_min_batch_time;
> -	struct bdev_handle *s_journal_bdev_handle;
> +	struct file *s_journal_bdev_file;
>  #ifdef CONFIG_QUOTA
>  	/* Names of quota files with journalled quota */
>  	char __rcu *s_qf_names[EXT4_MAXQUOTAS];
> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> index 11e6f33677a2..df853c4d3a8c 100644
> --- a/fs/ext4/fsmap.c
> +++ b/fs/ext4/fsmap.c
> @@ -576,9 +576,9 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
>  	if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
>  	    fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
>  		return true;
> -	if (EXT4_SB(sb)->s_journal_bdev_handle &&
> +	if (EXT4_SB(sb)->s_journal_bdev_file &&
>  	    fm->fmr_device ==
> -	    new_encode_dev(EXT4_SB(sb)->s_journal_bdev_handle->bdev->bd_dev))
> +	    new_encode_dev(file_bdev(EXT4_SB(sb)->s_journal_bdev_file)->bd_dev))
>  		return true;
>  	return false;
>  }
> @@ -648,9 +648,9 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
>  	memset(handlers, 0, sizeof(handlers));
>  	handlers[0].gfd_dev = new_encode_dev(sb->s_bdev->bd_dev);
>  	handlers[0].gfd_fn = ext4_getfsmap_datadev;
> -	if (EXT4_SB(sb)->s_journal_bdev_handle) {
> +	if (EXT4_SB(sb)->s_journal_bdev_file) {
>  		handlers[1].gfd_dev = new_encode_dev(
> -			EXT4_SB(sb)->s_journal_bdev_handle->bdev->bd_dev);
> +			file_bdev(EXT4_SB(sb)->s_journal_bdev_file)->bd_dev);
>  		handlers[1].gfd_fn = ext4_getfsmap_logdev;
>  	}
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index dcba0f85dfe2..aa007710cfc3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1359,14 +1359,14 @@ static void ext4_put_super(struct super_block *sb)
>  
>  	sync_blockdev(sb->s_bdev);
>  	invalidate_bdev(sb->s_bdev);
> -	if (sbi->s_journal_bdev_handle) {
> +	if (sbi->s_journal_bdev_file) {
>  		/*
>  		 * Invalidate the journal device's buffers.  We don't want them
>  		 * floating about in memory - the physical journal device may
>  		 * hotswapped, and it breaks the `ro-after' testing code.
>  		 */
> -		sync_blockdev(sbi->s_journal_bdev_handle->bdev);
> -		invalidate_bdev(sbi->s_journal_bdev_handle->bdev);
> +		sync_blockdev(file_bdev(sbi->s_journal_bdev_file));
> +		invalidate_bdev(file_bdev(sbi->s_journal_bdev_file));
>  	}
>  
>  	ext4_xattr_destroy_cache(sbi->s_ea_inode_cache);
> @@ -4233,7 +4233,7 @@ int ext4_calculate_overhead(struct super_block *sb)
>  	 * Add the internal journal blocks whether the journal has been
>  	 * loaded or not
>  	 */
> -	if (sbi->s_journal && !sbi->s_journal_bdev_handle)
> +	if (sbi->s_journal && !sbi->s_journal_bdev_file)
>  		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_total_len);
>  	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
>  		/* j_inum for internal journal is non-zero */
> @@ -5670,9 +5670,9 @@ failed_mount9: __maybe_unused
>  #endif
>  	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
>  	brelse(sbi->s_sbh);
> -	if (sbi->s_journal_bdev_handle) {
> -		invalidate_bdev(sbi->s_journal_bdev_handle->bdev);
> -		bdev_release(sbi->s_journal_bdev_handle);
> +	if (sbi->s_journal_bdev_file) {
> +		invalidate_bdev(file_bdev(sbi->s_journal_bdev_file));
> +		fput(sbi->s_journal_bdev_file);
>  	}
>  out_fail:
>  	invalidate_bdev(sb->s_bdev);
> @@ -5842,30 +5842,30 @@ static journal_t *ext4_open_inode_journal(struct super_block *sb,
>  	return journal;
>  }
>  
> -static struct bdev_handle *ext4_get_journal_blkdev(struct super_block *sb,
> +static struct file *ext4_get_journal_blkdev(struct super_block *sb,
>  					dev_t j_dev, ext4_fsblk_t *j_start,
>  					ext4_fsblk_t *j_len)
>  {
>  	struct buffer_head *bh;
>  	struct block_device *bdev;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	int hblock, blocksize;
>  	ext4_fsblk_t sb_block;
>  	unsigned long offset;
>  	struct ext4_super_block *es;
>  	int errno;
>  
> -	bdev_handle = bdev_open_by_dev(j_dev,
> +	bdev_file = bdev_file_open_by_dev(j_dev,
>  		BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_RESTRICT_WRITES,
>  		sb, &fs_holder_ops);
> -	if (IS_ERR(bdev_handle)) {
> +	if (IS_ERR(bdev_file)) {
>  		ext4_msg(sb, KERN_ERR,
>  			 "failed to open journal device unknown-block(%u,%u) %ld",
> -			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(bdev_handle));
> -		return bdev_handle;
> +			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(bdev_file));
> +		return bdev_file;
>  	}
>  
> -	bdev = bdev_handle->bdev;
> +	bdev = file_bdev(bdev_file);
>  	blocksize = sb->s_blocksize;
>  	hblock = bdev_logical_block_size(bdev);
>  	if (blocksize < hblock) {
> @@ -5912,12 +5912,12 @@ static struct bdev_handle *ext4_get_journal_blkdev(struct super_block *sb,
>  	*j_start = sb_block + 1;
>  	*j_len = ext4_blocks_count(es);
>  	brelse(bh);
> -	return bdev_handle;
> +	return bdev_file;
>  
>  out_bh:
>  	brelse(bh);
>  out_bdev:
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  	return ERR_PTR(errno);
>  }
>  
> @@ -5927,14 +5927,14 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
>  	journal_t *journal;
>  	ext4_fsblk_t j_start;
>  	ext4_fsblk_t j_len;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	int errno = 0;
>  
> -	bdev_handle = ext4_get_journal_blkdev(sb, j_dev, &j_start, &j_len);
> -	if (IS_ERR(bdev_handle))
> -		return ERR_CAST(bdev_handle);
> +	bdev_file = ext4_get_journal_blkdev(sb, j_dev, &j_start, &j_len);
> +	if (IS_ERR(bdev_file))
> +		return ERR_CAST(bdev_file);
>  
> -	journal = jbd2_journal_init_dev(bdev_handle->bdev, sb->s_bdev, j_start,
> +	journal = jbd2_journal_init_dev(file_bdev(bdev_file), sb->s_bdev, j_start,
>  					j_len, sb->s_blocksize);
>  	if (IS_ERR(journal)) {
>  		ext4_msg(sb, KERN_ERR, "failed to create device journal");
> @@ -5949,14 +5949,14 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
>  		goto out_journal;
>  	}
>  	journal->j_private = sb;
> -	EXT4_SB(sb)->s_journal_bdev_handle = bdev_handle;
> +	EXT4_SB(sb)->s_journal_bdev_file = bdev_file;
>  	ext4_init_journal_params(sb, journal);
>  	return journal;
>  
>  out_journal:
>  	jbd2_journal_destroy(journal);
>  out_bdev:
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  	return ERR_PTR(errno);
>  }
>  
> @@ -7314,12 +7314,12 @@ static inline int ext3_feature_set_ok(struct super_block *sb)
>  static void ext4_kill_sb(struct super_block *sb)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> -	struct bdev_handle *handle = sbi ? sbi->s_journal_bdev_handle : NULL;
> +	struct file *bdev_file = sbi ? sbi->s_journal_bdev_file : NULL;
>  
>  	kill_block_super(sb);
>  
> -	if (handle)
> -		bdev_release(handle);
> +	if (bdev_file)
> +		fput(bdev_file);
>  }
>  
>  static struct file_system_type ext4_fs_type = {
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

