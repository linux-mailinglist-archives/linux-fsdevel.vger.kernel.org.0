Return-Path: <linux-fsdevel+bounces-14476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C0E87CFCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85691C222D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8EF3CF6B;
	Fri, 15 Mar 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="imjDoNGq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lOBCWd9B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MpsCKT4p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T6MJmB42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF43C680;
	Fri, 15 Mar 2024 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515214; cv=none; b=Fjd7XOTjkAuxoxOUVtf1C0yidjAt4JezSd8vt3e72JiSfY/SqTdJ4PY3bzt2/T1qs/XXjknYUz6mSy0PZZaVaDiDieMBczQTzKiSdq2ng1qdjEIxvwjx9MbK4hyeH/D4Ga/5uxOCmnX+9+ZI+0gJYla/cppAYqZBZF76PB5LJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515214; c=relaxed/simple;
	bh=QwSmbaOIgQEs4j0V8Mxa0AtBigBKkk8zNBSossl9e64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9BYlZNBu62L34iKyNaaSs/IukfDSttx0ngXWFEULPF9QXQJbPG18l7xQeVyC+oCBzfyUWmBSinIWTEI/nO37bp9Vi9F6UBf2Su9JCYLEszmhRYn2mWgtlF3yE43IPBaZx9EPP5o7zBOBNFseuf7x2GtCsMqtuUgGSsuOobncBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=imjDoNGq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lOBCWd9B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MpsCKT4p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T6MJmB42; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99A1621DEE;
	Fri, 15 Mar 2024 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710515210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9unvmjq3IBY9p6AeuU6ZA/OY0k6Y9OlDsVFizUQPAeA=;
	b=imjDoNGqtm902XiAAKz5Yrv0YqlGfxbVPRbyzm4zy6l7GlRSgcshp5iGJTBQQ6YM6W4506
	U3MPz7mhxQVqirnG7zPUmaRO5Euv6fBQ0M+BRaPhas2sR9oOsA01iTDWsfHYb8md0VbiVy
	kRonhtpJrNshxcUGzjGpos2e1YHlEoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710515210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9unvmjq3IBY9p6AeuU6ZA/OY0k6Y9OlDsVFizUQPAeA=;
	b=lOBCWd9BpzS/nc6aoq4rUzDlNPpcfgJLydeNXlovFQzjMJJcr4OB8hE/ozTFfsXhwZsIUd
	axDTYCvF8hTVuPBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710515209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9unvmjq3IBY9p6AeuU6ZA/OY0k6Y9OlDsVFizUQPAeA=;
	b=MpsCKT4p99TvRwHOy4gIr+jroldsGDF5tv3q+P5vWLEc/CHObm7FMs3WZ3wOLUvB4YQaG+
	CFwD118BDzT/0kg68wP05EEB1l3EHvDIsbdZqFbcHMi17EpTwGmSni/bMcii2oORlwq4+b
	uMjCv84O/jgCyEJs3qFx5lbVPU4b9G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710515209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9unvmjq3IBY9p6AeuU6ZA/OY0k6Y9OlDsVFizUQPAeA=;
	b=T6MJmB42/cA5TRc0dKdzHnegXrAneKMAh+8zAeRRXSv2PT6b5Mhw+Ija9VtUZuOGOdJrkv
	X39cELtNEq9blBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BBBF1368C;
	Fri, 15 Mar 2024 15:06:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cwEVIglk9GU2TAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 15:06:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2A87BA07D9; Fri, 15 Mar 2024 16:06:45 +0100 (CET)
Date: Fri, 15 Mar 2024 16:06:45 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 14/19] jbd2: prevent direct access of bd_inode
Message-ID: <20240315150645.jdegmdoahjdz7uo7@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-15-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-15-yukuai1@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 22-02-24 20:45:50, Yu Kuai wrote:
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
>  fs/ext4/super.c      |  2 +-
>  fs/jbd2/journal.c    | 26 +++++++++++++++-----------
>  include/linux/jbd2.h | 18 ++++++++++++++----
>  3 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 55b3df71bf5e..4df1a5cfe0a5 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5918,7 +5918,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
>  	if (IS_ERR(bdev_file))
>  		return ERR_CAST(bdev_file);
>  
> -	journal = jbd2_journal_init_dev(file_bdev(bdev_file), sb->s_bdev, j_start,
> +	journal = jbd2_journal_init_dev(bdev_file, sb->s_bdev_file, j_start,
>  					j_len, sb->s_blocksize);
>  	if (IS_ERR(journal)) {
>  		ext4_msg(sb, KERN_ERR, "failed to create device journal");
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index b6c114c11b97..abd42a6ccd0e 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1516,11 +1516,12 @@ static int journal_load_superblock(journal_t *journal)
>   * very few fields yet: that has to wait until we have created the
>   * journal structures from from scratch, or loaded them from disk. */
>  
> -static journal_t *journal_init_common(struct block_device *bdev,
> -			struct block_device *fs_dev,
> +static journal_t *journal_init_common(struct file *bdev_file,
> +			struct file *fs_dev_file,
>  			unsigned long long start, int len, int blocksize)
>  {
>  	static struct lock_class_key jbd2_trans_commit_key;
> +	struct block_device *bdev = file_bdev(bdev_file);
>  	journal_t *journal;
>  	int err;
>  	int n;
> @@ -1531,7 +1532,9 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  
>  	journal->j_blocksize = blocksize;
>  	journal->j_dev = bdev;
> -	journal->j_fs_dev = fs_dev;
> +	journal->j_dev_file = bdev_file;
> +	journal->j_fs_dev = file_bdev(fs_dev_file);
> +	journal->j_fs_dev_file = fs_dev_file;
>  	journal->j_blk_offset = start;
>  	journal->j_total_len = len;
>  	jbd2_init_fs_dev_write_error(journal);
> @@ -1628,8 +1631,8 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  
>  /**
>   *  journal_t * jbd2_journal_init_dev() - creates and initialises a journal structure
> - *  @bdev: Block device on which to create the journal
> - *  @fs_dev: Device which hold journalled filesystem for this journal.
> + *  @bdev_file: Opened block device on which to create the journal
> + *  @fs_dev_file: Opened device which hold journalled filesystem for this journal.
>   *  @start: Block nr Start of journal.
>   *  @len:  Length of the journal in blocks.
>   *  @blocksize: blocksize of journalling device
> @@ -1640,13 +1643,13 @@ static journal_t *journal_init_common(struct block_device *bdev,
>   *  range of blocks on an arbitrary block device.
>   *
>   */
> -journal_t *jbd2_journal_init_dev(struct block_device *bdev,
> -			struct block_device *fs_dev,
> +journal_t *jbd2_journal_init_dev(struct file *bdev_file,
> +			struct file *fs_dev_file,
>  			unsigned long long start, int len, int blocksize)
>  {
>  	journal_t *journal;
>  
> -	journal = journal_init_common(bdev, fs_dev, start, len, blocksize);
> +	journal = journal_init_common(bdev_file, fs_dev_file, start, len, blocksize);
>  	if (IS_ERR(journal))
>  		return ERR_CAST(journal);
>  
> @@ -1683,8 +1686,9 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
>  		  inode->i_sb->s_id, inode->i_ino, (long long) inode->i_size,
>  		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
>  
> -	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
> -			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
> +	journal = journal_init_common(inode->i_sb->s_bdev_file,
> +			inode->i_sb->s_bdev_file, blocknr,
> +			inode->i_size >> inode->i_sb->s_blocksize_bits,
>  			inode->i_sb->s_blocksize);
>  	if (IS_ERR(journal))
>  		return ERR_CAST(journal);
> @@ -2009,7 +2013,7 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
>  		byte_count = (block_stop - block_start + 1) *
>  				journal->j_blocksize;
>  
> -		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
> +		truncate_inode_pages_range(journal->j_dev_file->f_mapping,
>  				byte_start, byte_stop);
>  
>  		if (flags & JBD2_JOURNAL_FLUSH_DISCARD) {
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 971f3e826e15..fc26730ae8ef 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -968,6 +968,11 @@ struct journal_s
>  	 */
>  	struct block_device	*j_dev;
>  
> +	/**
> +	 * @j_dev_file: Opended device @j_dev.
> +	 */
> +	struct file		*j_dev_file;
> +
>  	/**
>  	 * @j_blocksize: Block size for the location where we store the journal.
>  	 */
> @@ -993,6 +998,11 @@ struct journal_s
>  	 */
>  	struct block_device	*j_fs_dev;
>  
> +	/**
> +	 * @j_fs_dev_file: Opened device @j_fs_dev.
> +	 */
> +	struct file		*j_fs_dev_file;
> +
>  	/**
>  	 * @j_fs_dev_wb_err:
>  	 *
> @@ -1533,8 +1543,8 @@ extern void	 jbd2_journal_unlock_updates (journal_t *);
>  
>  void jbd2_journal_wait_updates(journal_t *);
>  
> -extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
> -				struct block_device *fs_dev,
> +extern journal_t *jbd2_journal_init_dev(struct file *bdev_file,
> +				struct file *fs_dev_file,
>  				unsigned long long start, int len, int bsize);
>  extern journal_t * jbd2_journal_init_inode (struct inode *);
>  extern int	   jbd2_journal_update_format (journal_t *);
> @@ -1696,7 +1706,7 @@ static inline void jbd2_journal_abort_handle(handle_t *handle)
>  
>  static inline void jbd2_init_fs_dev_write_error(journal_t *journal)
>  {
> -	struct address_space *mapping = journal->j_fs_dev->bd_inode->i_mapping;
> +	struct address_space *mapping = journal->j_fs_dev_file->f_mapping;
>  
>  	/*
>  	 * Save the original wb_err value of client fs's bdev mapping which
> @@ -1707,7 +1717,7 @@ static inline void jbd2_init_fs_dev_write_error(journal_t *journal)
>  
>  static inline int jbd2_check_fs_dev_write_error(journal_t *journal)
>  {
> -	struct address_space *mapping = journal->j_fs_dev->bd_inode->i_mapping;
> +	struct address_space *mapping = journal->j_fs_dev_file->f_mapping;
>  
>  	return errseq_check(&mapping->wb_err,
>  			    READ_ONCE(journal->j_fs_dev_wb_err));
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

