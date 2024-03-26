Return-Path: <linux-fsdevel+bounces-15368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B4888D169
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 23:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17489323125
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 22:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6355413DDCD;
	Tue, 26 Mar 2024 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xOb6fSVn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+Jzt6Htp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xOb6fSVn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+Jzt6Htp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AAE13E889;
	Tue, 26 Mar 2024 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492980; cv=none; b=p44pipHPftFlfGdI7kFVNAS8FjN9VZyKbbop7lfO/tAYCt0lrz+5VIMgRmwsZuyFExbKLX5PdFC8EL+o5nITpEoZ26Z26NEZiOsl4vsNNTMk405JnzJoqmRtd2Pv0qafLWczf7Ootg0T8DOlne6Ko/sQi+AT52DY9R21AleAAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492980; c=relaxed/simple;
	bh=ysaYZWx1fpHhZuKpitiqLQYb+Z1hGj2d9b38xmv5AlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6iq2yHdzdkus559OpQb0qE7ePbwTEvw+pCvt3tJUa+4zQ/gD6BDoWjBV2OHtDZe680leudOkOLsqF+z1se3oeiKSOKQ1LmlM723jFswff3BPRYEjXiQjL8CqiOXJU3gzCl+IWKsuGPlbjso98b5vQdTeSMFAB7Ax2mex7Otpmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xOb6fSVn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+Jzt6Htp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xOb6fSVn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+Jzt6Htp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77879226BF;
	Tue, 26 Mar 2024 22:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711492975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyqFoqv+ccRIT5Hw+pj+3mthpQr2kSrL1cxNK02hXrA=;
	b=xOb6fSVnLbgvFVK2AkRjs332JH4aSplCDmrar9RLARuYFI3Vwp6NfWkySZsi8ZEb6+CwXN
	f6oos0L+VRPZRYUrX5aT+kvsaLSJ+zJGN/2KVTyPuAt3A3zybaNjbK+spC86P7gGVfh8YR
	/zHdSdXOHlkicSm3L72l12gtrxr/5iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711492975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyqFoqv+ccRIT5Hw+pj+3mthpQr2kSrL1cxNK02hXrA=;
	b=+Jzt6HtpolZINMp5DgZHQlFFqT3xur9hhr78eUPFMa0rQ18xiANcybS5uYgQ0q0tMCziiu
	kB4Nv8lhlno1d1Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711492975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyqFoqv+ccRIT5Hw+pj+3mthpQr2kSrL1cxNK02hXrA=;
	b=xOb6fSVnLbgvFVK2AkRjs332JH4aSplCDmrar9RLARuYFI3Vwp6NfWkySZsi8ZEb6+CwXN
	f6oos0L+VRPZRYUrX5aT+kvsaLSJ+zJGN/2KVTyPuAt3A3zybaNjbK+spC86P7gGVfh8YR
	/zHdSdXOHlkicSm3L72l12gtrxr/5iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711492975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyqFoqv+ccRIT5Hw+pj+3mthpQr2kSrL1cxNK02hXrA=;
	b=+Jzt6HtpolZINMp5DgZHQlFFqT3xur9hhr78eUPFMa0rQ18xiANcybS5uYgQ0q0tMCziiu
	kB4Nv8lhlno1d1Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 67DF613215;
	Tue, 26 Mar 2024 22:42:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wMoTGW9PA2anFAAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 26 Mar 2024 22:42:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 165C4A0812; Tue, 26 Mar 2024 23:42:55 +0100 (CET)
Date: Tue, 26 Mar 2024 23:42:55 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Message-ID: <20240326224255.5iwsflu5vksguc4x@quack3>
References: <20240326133107.bnjx2rjf5l6yijgz@quack3>
 <20240326-lehrkraft-messwerte-e3895039e63b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-lehrkraft-messwerte-e3895039e63b@brauner>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Tue 26-03-24 16:46:19, Christian Brauner wrote:
> Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
> default this option is set. When it is set the long-standing behavior
> of being able to write to mounted block devices is enabled.
> 
> But in order to guard against unintended corruption by writing to the
> block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
> off. In that case it isn't possible to write to mounted block devices
> anymore.
> 
> A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
> which disallows concurrent BLK_OPEN_WRITE access. When we still had the
> bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
> the mode was passed around. Since we managed to get rid of the bdev
> handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
> on whether the file was opened writable and writes to that block device
> are blocked. That logic doesn't work because we do allow
> BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.
> 
> Fix the detection logic and use one of the FMODE_* bits we freed up a
> while ago. We could've also abused O_EXCL as an indicator that
> BLK_OPEN_RESTRICT_WRITES has been requested. For userspace open paths
> O_EXCL will never be retained but for internal opens where we open files
> that are never installed into a file descriptor table this is fine. But
> it would be a gamble that this doesn't cause bugs. Note that
> BLK_OPEN_RESTRICT_WRITES is an internal only flag that cannot directly
> be raised by userspace. It is implicitly raised during mounting.
> 
> Passes xftests and blktests with CONFIG_BLK_DEV_WRITE_MOUNTED set and
> unset.
> 
> Link: https://lore.kernel.org/r/ZfyyEwu9Uq5Pgb94@casper.infradead.org
> Link: https://lore.kernel.org/r/20240323-zielbereich-mittragen-6fdf14876c3e@brauner
> Fixes: 321de651fa56 ("block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c       | 14 +++++++-------
>  include/linux/fs.h |  2 ++
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 070890667563..6955693e4bcd 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -814,13 +814,11 @@ static void bdev_yield_write_access(struct file *bdev_file)
>  		return;
>  
>  	bdev = file_bdev(bdev_file);
> -	/* Yield exclusive or shared write access. */
> -	if (bdev_file->f_mode & FMODE_WRITE) {
> -		if (bdev_writes_blocked(bdev))
> -			bdev_unblock_writes(bdev);
> -		else
> -			bdev->bd_writers--;
> -	}
> +
> +	if (bdev_file->f_mode & FMODE_WRITE_RESTRICTED)
> +		bdev_unblock_writes(bdev);
> +	else if (bdev_file->f_mode & FMODE_WRITE)
> +		bdev->bd_writers--;
>  }
>  
>  /**
> @@ -900,6 +898,8 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>  	bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
>  	if (bdev_nowait(bdev))
>  		bdev_file->f_mode |= FMODE_NOWAIT;
> +	if (mode & BLK_OPEN_RESTRICT_WRITES)
> +		bdev_file->f_mode |= FMODE_WRITE_RESTRICTED;
>  	bdev_file->f_mapping = bdev->bd_inode->i_mapping;
>  	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
>  	bdev_file->private_data = holder;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 00fc429b0af0..8dfd53b52744 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -121,6 +121,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  #define FMODE_PWRITE		((__force fmode_t)0x10)
>  /* File is opened for execution with sys_execve / sys_uselib */
>  #define FMODE_EXEC		((__force fmode_t)0x20)
> +/* File writes are restricted (block device specific) */
> +#define FMODE_WRITE_RESTRICTED  ((__force fmode_t)0x40)
>  /* 32bit hashes as llseek() offset (for directories) */
>  #define FMODE_32BITHASH         ((__force fmode_t)0x200)
>  /* 64bit hashes as llseek() offset (for directories) */
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

