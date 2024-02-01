Return-Path: <linux-fsdevel+bounces-9850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8D6845536
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F971F2E06B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1087715B99F;
	Thu,  1 Feb 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XQbstSzB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v8Bz7zm5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XQbstSzB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v8Bz7zm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AD615B11F;
	Thu,  1 Feb 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783044; cv=none; b=UzEdOyETEc81Eh3tdYkTkGYsC/uOOg3DCCMp5d4oZ00YOVI/moON9gtHgLqKHj5j/E0Fph42Tt1PtNVuMZzo6acvZu6qSmKdeJtv/YOLSBi6xUOOXStZjXTh89gLaMTdSsVI61TcfEptItccJnN12azmZ5oGY5iGnJvM2tj9ZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783044; c=relaxed/simple;
	bh=JPGxcrzpYft+xuBkHlzG+lLhZNTSIlKF4+wq2yWS8wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzSIuOq8lZUs8EM8DWp3dkA3CfN4iaHj/QSKwva471aBTTfdlzzxVqOb+Mp/HAZSNrEYA+Jl3R4jS3XqpwwAeDblHIAR7yjw7acRYux8KbZR3WMgCYi+OBxML7sK65BU6RiwHXaGiMTCypdvtaJOOZ1+yg2La9NBWH5WABzLKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XQbstSzB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v8Bz7zm5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XQbstSzB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v8Bz7zm5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD9B721DED;
	Thu,  1 Feb 2024 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706783040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpy1VcRY1+xuuXEUdMMnraXd5TZgWe5rdB2DrpJqp6E=;
	b=XQbstSzBPzbxG1T//BFXU9vFoceAgFUgSZJroG3LfGb9cWNz1WPJqad1VhDTZiBTZqDn8u
	nye0MNEFMQf7axntJF/CYuB3C9J3XvCIVgTYPdP3uf2mBWNq4OgxGmX+A/4BAt6UPrCmeF
	jR1CAIGQSVi1InFumlQ52rgdjWdjfAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706783040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpy1VcRY1+xuuXEUdMMnraXd5TZgWe5rdB2DrpJqp6E=;
	b=v8Bz7zm5cfIPsXnCL5lXSNOlGVLm41I7Evwdywpg1EFEkpIVNfLfBGaguv0RWL3CDlTh4y
	FpGngduBfQUzH+Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706783040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpy1VcRY1+xuuXEUdMMnraXd5TZgWe5rdB2DrpJqp6E=;
	b=XQbstSzBPzbxG1T//BFXU9vFoceAgFUgSZJroG3LfGb9cWNz1WPJqad1VhDTZiBTZqDn8u
	nye0MNEFMQf7axntJF/CYuB3C9J3XvCIVgTYPdP3uf2mBWNq4OgxGmX+A/4BAt6UPrCmeF
	jR1CAIGQSVi1InFumlQ52rgdjWdjfAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706783040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpy1VcRY1+xuuXEUdMMnraXd5TZgWe5rdB2DrpJqp6E=;
	b=v8Bz7zm5cfIPsXnCL5lXSNOlGVLm41I7Evwdywpg1EFEkpIVNfLfBGaguv0RWL3CDlTh4y
	FpGngduBfQUzH+Bw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A2C121329F;
	Thu,  1 Feb 2024 10:24:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tdO1J0Bxu2WAXwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:24:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 61FF9A0809; Thu,  1 Feb 2024 11:24:00 +0100 (CET)
Date: Thu, 1 Feb 2024 11:24:00 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 26/34] reiserfs: port block device access to file
Message-ID: <20240201102400.bp2alnq3fmkzsxua@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-26-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-26-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XQbstSzB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=v8Bz7zm5
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AD9B721DED
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 23-01-24 14:26:43, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/reiserfs/journal.c  | 38 +++++++++++++++++++-------------------
>  fs/reiserfs/procfs.c   |  2 +-
>  fs/reiserfs/reiserfs.h |  8 ++++----
>  3 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index 171c912af50f..6474529c4253 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -2386,7 +2386,7 @@ static int journal_read(struct super_block *sb)
>  
>  	cur_dblock = SB_ONDISK_JOURNAL_1st_BLOCK(sb);
>  	reiserfs_info(sb, "checking transaction log (%pg)\n",
> -		      journal->j_bdev_handle->bdev);
> +		      file_bdev(journal->j_bdev_file));
>  	start = ktime_get_seconds();
>  
>  	/*
> @@ -2447,7 +2447,7 @@ static int journal_read(struct super_block *sb)
>  		 * device and journal device to be the same
>  		 */
>  		d_bh =
> -		    reiserfs_breada(journal->j_bdev_handle->bdev, cur_dblock,
> +		    reiserfs_breada(file_bdev(journal->j_bdev_file), cur_dblock,
>  				    sb->s_blocksize,
>  				    SB_ONDISK_JOURNAL_1st_BLOCK(sb) +
>  				    SB_ONDISK_JOURNAL_SIZE(sb));
> @@ -2588,9 +2588,9 @@ static void journal_list_init(struct super_block *sb)
>  
>  static void release_journal_dev(struct reiserfs_journal *journal)
>  {
> -	if (journal->j_bdev_handle) {
> -		bdev_release(journal->j_bdev_handle);
> -		journal->j_bdev_handle = NULL;
> +	if (journal->j_bdev_file) {
> +		fput(journal->j_bdev_file);
> +		journal->j_bdev_file = NULL;
>  	}
>  }
>  
> @@ -2605,7 +2605,7 @@ static int journal_init_dev(struct super_block *super,
>  
>  	result = 0;
>  
> -	journal->j_bdev_handle = NULL;
> +	journal->j_bdev_file = NULL;
>  	jdev = SB_ONDISK_JOURNAL_DEVICE(super) ?
>  	    new_decode_dev(SB_ONDISK_JOURNAL_DEVICE(super)) : super->s_dev;
>  
> @@ -2616,37 +2616,37 @@ static int journal_init_dev(struct super_block *super,
>  	if ((!jdev_name || !jdev_name[0])) {
>  		if (jdev == super->s_dev)
>  			holder = NULL;
> -		journal->j_bdev_handle = bdev_open_by_dev(jdev, blkdev_mode,
> +		journal->j_bdev_file = bdev_file_open_by_dev(jdev, blkdev_mode,
>  							  holder, NULL);
> -		if (IS_ERR(journal->j_bdev_handle)) {
> -			result = PTR_ERR(journal->j_bdev_handle);
> -			journal->j_bdev_handle = NULL;
> +		if (IS_ERR(journal->j_bdev_file)) {
> +			result = PTR_ERR(journal->j_bdev_file);
> +			journal->j_bdev_file = NULL;
>  			reiserfs_warning(super, "sh-458",
>  					 "cannot init journal device unknown-block(%u,%u): %i",
>  					 MAJOR(jdev), MINOR(jdev), result);
>  			return result;
>  		} else if (jdev != super->s_dev)
> -			set_blocksize(journal->j_bdev_handle->bdev,
> +			set_blocksize(file_bdev(journal->j_bdev_file),
>  				      super->s_blocksize);
>  
>  		return 0;
>  	}
>  
> -	journal->j_bdev_handle = bdev_open_by_path(jdev_name, blkdev_mode,
> +	journal->j_bdev_file = bdev_file_open_by_path(jdev_name, blkdev_mode,
>  						   holder, NULL);
> -	if (IS_ERR(journal->j_bdev_handle)) {
> -		result = PTR_ERR(journal->j_bdev_handle);
> -		journal->j_bdev_handle = NULL;
> +	if (IS_ERR(journal->j_bdev_file)) {
> +		result = PTR_ERR(journal->j_bdev_file);
> +		journal->j_bdev_file = NULL;
>  		reiserfs_warning(super, "sh-457",
>  				 "journal_init_dev: Cannot open '%s': %i",
>  				 jdev_name, result);
>  		return result;
>  	}
>  
> -	set_blocksize(journal->j_bdev_handle->bdev, super->s_blocksize);
> +	set_blocksize(file_bdev(journal->j_bdev_file), super->s_blocksize);
>  	reiserfs_info(super,
>  		      "journal_init_dev: journal device: %pg\n",
> -		      journal->j_bdev_handle->bdev);
> +		      file_bdev(journal->j_bdev_file));
>  	return 0;
>  }
>  
> @@ -2804,7 +2804,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
>  				 "journal header magic %x (device %pg) does "
>  				 "not match to magic found in super block %x",
>  				 jh->jh_journal.jp_journal_magic,
> -				 journal->j_bdev_handle->bdev,
> +				 file_bdev(journal->j_bdev_file),
>  				 sb_jp_journal_magic(rs));
>  		brelse(bhjh);
>  		goto free_and_return;
> @@ -2828,7 +2828,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
>  	reiserfs_info(sb, "journal params: device %pg, size %u, "
>  		      "journal first block %u, max trans len %u, max batch %u, "
>  		      "max commit age %u, max trans age %u\n",
> -		      journal->j_bdev_handle->bdev,
> +		      file_bdev(journal->j_bdev_file),
>  		      SB_ONDISK_JOURNAL_SIZE(sb),
>  		      SB_ONDISK_JOURNAL_1st_BLOCK(sb),
>  		      journal->j_trans_max,
> diff --git a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
> index 83cb9402e0f9..5c68a4a52d78 100644
> --- a/fs/reiserfs/procfs.c
> +++ b/fs/reiserfs/procfs.c
> @@ -354,7 +354,7 @@ static int show_journal(struct seq_file *m, void *unused)
>  		   "prepare: \t%12lu\n"
>  		   "prepare_retry: \t%12lu\n",
>  		   DJP(jp_journal_1st_block),
> -		   SB_JOURNAL(sb)->j_bdev_handle->bdev,
> +		   file_bdev(SB_JOURNAL(sb)->j_bdev_file),
>  		   DJP(jp_journal_dev),
>  		   DJP(jp_journal_size),
>  		   DJP(jp_journal_trans_max),
> diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
> index 725667880e62..0554903f42a9 100644
> --- a/fs/reiserfs/reiserfs.h
> +++ b/fs/reiserfs/reiserfs.h
> @@ -299,7 +299,7 @@ struct reiserfs_journal {
>  	/* oldest journal block.  start here for traverse */
>  	struct reiserfs_journal_cnode *j_first;
>  
> -	struct bdev_handle *j_bdev_handle;
> +	struct file *j_bdev_file;
>  
>  	/* first block on s_dev of reserved area journal */
>  	int j_1st_reserved_block;
> @@ -2810,10 +2810,10 @@ struct reiserfs_journal_header {
>  
>  /* We need these to make journal.c code more readable */
>  #define journal_find_get_block(s, block) __find_get_block(\
> -		SB_JOURNAL(s)->j_bdev_handle->bdev, block, s->s_blocksize)
> -#define journal_getblk(s, block) __getblk(SB_JOURNAL(s)->j_bdev_handle->bdev,\
> +		file_bdev(SB_JOURNAL(s)->j_bdev_file), block, s->s_blocksize)
> +#define journal_getblk(s, block) __getblk(file_bdev(SB_JOURNAL(s)->j_bdev_file),\
>  		block, s->s_blocksize)
> -#define journal_bread(s, block) __bread(SB_JOURNAL(s)->j_bdev_handle->bdev,\
> +#define journal_bread(s, block) __bread(file_bdev(SB_JOURNAL(s)->j_bdev_file),\
>  		block, s->s_blocksize)
>  
>  enum reiserfs_bh_state_bits {
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

