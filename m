Return-Path: <linux-fsdevel+bounces-9846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD95845515
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5095FB221A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC63015B963;
	Thu,  1 Feb 2024 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d07h7q0g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TCmtgkCP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d07h7q0g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TCmtgkCP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1D4DA0D;
	Thu,  1 Feb 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782745; cv=none; b=T9kDpcnZSc3onf5ikOoJfrQ1LM9e80YsKcHg1BH9Wfd4OvHIyesW17F+GmEBc6spqOY6zXQ7OMUTC4Ik3bxtSYJYa0v89Xz0z/E+l9jSsFb0QVy9q7BRLV9L1WOX4HJP9M9gk0L03nst8Z78cO+seAFAMqONDhbkWaUNj1hrxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782745; c=relaxed/simple;
	bh=wpE9fqZfs4aHM4wakxIt+akjXSGRuNj+3drCVQo+vos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MblMycUJeKtltixV1g1h2APHQr6Nvn8560E0VaafuLqgRRjJHiSmTk3BpSQZwx7NPkQwtUKh5Bl+djslrNT9MO+fSpRWxQv2c3YkmFWVOUM1BzFQ085a1OEtrvQlJb8AVh4NqF2ZdMo6VLLWZ8iE2X8AsnNAyX3krNLy+6DTC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d07h7q0g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TCmtgkCP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d07h7q0g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TCmtgkCP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D616621F4F;
	Thu,  1 Feb 2024 10:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qks1tFcC1iTnlqXXNlmB5wSJC4TOneqS1/xeEV7t43A=;
	b=d07h7q0gR2RXpymkUumK0QN6G1XesvWT9qAJPhb0881DimyYuHyk2Y9dZMk0/4x5ErEioc
	X+UKSrRkOhVzNuYNqcxOutmmlyVaBG0HSqwvXgm1sViJ4RgUayfOSGqWHyBzqOw3lsF9er
	ZDQjY+upY3WULFfwAvL5BNyvjK/TqvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qks1tFcC1iTnlqXXNlmB5wSJC4TOneqS1/xeEV7t43A=;
	b=TCmtgkCPxaUZgmKrQpBuJxFLK2horq7z4lh88hG91oe+zBvWxrZtzrUHXUzrQkp7Few1ct
	iJ4ysQsOTspmQEAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qks1tFcC1iTnlqXXNlmB5wSJC4TOneqS1/xeEV7t43A=;
	b=d07h7q0gR2RXpymkUumK0QN6G1XesvWT9qAJPhb0881DimyYuHyk2Y9dZMk0/4x5ErEioc
	X+UKSrRkOhVzNuYNqcxOutmmlyVaBG0HSqwvXgm1sViJ4RgUayfOSGqWHyBzqOw3lsF9er
	ZDQjY+upY3WULFfwAvL5BNyvjK/TqvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qks1tFcC1iTnlqXXNlmB5wSJC4TOneqS1/xeEV7t43A=;
	b=TCmtgkCPxaUZgmKrQpBuJxFLK2horq7z4lh88hG91oe+zBvWxrZtzrUHXUzrQkp7Few1ct
	iJ4ysQsOTspmQEAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C20601329F;
	Thu,  1 Feb 2024 10:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id rmRbLxVwu2V4XgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:19:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 885B7A0809; Thu,  1 Feb 2024 11:19:01 +0100 (CET)
Date: Thu, 1 Feb 2024 11:19:01 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 22/34] f2fs: port block device access to files
Message-ID: <20240201101901.szz4lrkqlszyuclm@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-22-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-22-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Tue 23-01-24 14:26:39, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/f2fs/f2fs.h  |  2 +-
>  fs/f2fs/super.c | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 65294e3b0bef..6fc172c99915 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1239,7 +1239,7 @@ struct f2fs_bio_info {
>  #define FDEV(i)				(sbi->devs[i])
>  #define RDEV(i)				(raw_super->devs[i])
>  struct f2fs_dev_info {
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	struct block_device *bdev;
>  	char path[MAX_PATH_LEN];
>  	unsigned int total_segments;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ea94c148fee5..557ea5c6c926 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1605,7 +1605,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>  
>  	for (i = 0; i < sbi->s_ndevs; i++) {
>  		if (i > 0)
> -			bdev_release(FDEV(i).bdev_handle);
> +			fput(FDEV(i).bdev_file);
>  #ifdef CONFIG_BLK_DEV_ZONED
>  		kvfree(FDEV(i).blkz_seq);
>  #endif
> @@ -4247,7 +4247,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  
>  	for (i = 0; i < max_devices; i++) {
>  		if (i == 0)
> -			FDEV(0).bdev_handle = sb_bdev_handle(sbi->sb);
> +			FDEV(0).bdev_file = sbi->sb->s_bdev_file;
>  		else if (!RDEV(i).path[0])
>  			break;
>  
> @@ -4267,14 +4267,14 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  				FDEV(i).end_blk = FDEV(i).start_blk +
>  					(FDEV(i).total_segments <<
>  					sbi->log_blocks_per_seg) - 1;
> -				FDEV(i).bdev_handle = bdev_open_by_path(
> +				FDEV(i).bdev_file = bdev_file_open_by_path(
>  					FDEV(i).path, mode, sbi->sb, NULL);
>  			}
>  		}
> -		if (IS_ERR(FDEV(i).bdev_handle))
> -			return PTR_ERR(FDEV(i).bdev_handle);
> +		if (IS_ERR(FDEV(i).bdev_file))
> +			return PTR_ERR(FDEV(i).bdev_file);
>  
> -		FDEV(i).bdev = FDEV(i).bdev_handle->bdev;
> +		FDEV(i).bdev = file_bdev(FDEV(i).bdev_file);
>  		/* to release errored devices */
>  		sbi->s_ndevs = i + 1;
>  
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

