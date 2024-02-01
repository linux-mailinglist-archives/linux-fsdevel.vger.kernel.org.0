Return-Path: <linux-fsdevel+bounces-9838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0B88454E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1833B1F248D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AA615B110;
	Thu,  1 Feb 2024 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L3d9AcZW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S7xwwv3Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQh3Kf3F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t0Yae1o8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FAE4DA1D;
	Thu,  1 Feb 2024 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782202; cv=none; b=RMQeCPPteZLI1wq6BkT6YGaFeLw2/5FSpwbuhd5dCofKtB+r0xMSS636MXZVS29SWMKfoBEye7FyEw+IjzPUlUNf7w3CDOWMbl7HbeA2L8hcsnqwFs4h/DCTWhdk69HFHuESEQpF3ca9iVZydLW/1C2AB7sR3Wd0qQSmVvP1yOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782202; c=relaxed/simple;
	bh=dS76l7yQjXg+hYE5ifqgbacx5v+UWl3KmtqUWxDPG4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUn7nK5o8QbFghTuOJNXUwc+ceey9/dwky0SxuwZFywjEzlwsXbLVDWPLulkQHIPbah4ydrhYCO8bFFGmOl5CMrbzhpQOiO4ySk5LQadADfeLY+Y6Nv0sbRaKL06mFeMyLPJiK5CnYU+uPXp7bg6mJiVBeyBiC12LjDtu3hk8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L3d9AcZW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S7xwwv3Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQh3Kf3F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t0Yae1o8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DAD3421D71;
	Thu,  1 Feb 2024 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3v1Mgw0m1b7qRDS/J4mhG54Svo4JNMyRzWD6k9rPa+4=;
	b=L3d9AcZWtRzZL7M4QesP3LB8PPx3lDWj/eYiqQiVhUL+p4PyUvC5RKPoBZiiw2hoZrFfs4
	E7Je2tTW6aowd60xbpIvpCjICl+Mo3bSCkfwGlrAJckSZiveS6FVa1IjN5J+FqahLqxjku
	+aJ2HL5bCx0I3d9MswzHDo3JQ6tRsu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3v1Mgw0m1b7qRDS/J4mhG54Svo4JNMyRzWD6k9rPa+4=;
	b=S7xwwv3ZaSTRPn/eT5AjtiQM+DTtNFCIg5CyOTFLrdQuNK9IdpdNlo9xHJKgrOYdetNLWD
	BCqF+btzn0ySdvBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3v1Mgw0m1b7qRDS/J4mhG54Svo4JNMyRzWD6k9rPa+4=;
	b=iQh3Kf3FEKXQgzi1rl7njCd3+VGLnIKKkQBkOiyYzZ2Ozx7Acp5+k9Rq+xN0XoR2Aw+LSa
	d9DiaOCYAHvz09U72uFdpvKjAo9qrkVYShjhiJCDqQJ8ZYVTPSIc5nVg0D3t7msYxZO0zM
	wgHqlg9GHzS5kMVKABfgv8dcgr2fUeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3v1Mgw0m1b7qRDS/J4mhG54Svo4JNMyRzWD6k9rPa+4=;
	b=t0Yae1o8XZYoT4F+8Mu2ckBE4pYEodEOHpoHQepmmyvOP7g1wYwYm6U7XFrC7YkvTLiOB3
	pudMoy7vkQIm3qCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CE99613594;
	Thu,  1 Feb 2024 10:09:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oLpoMvZtu2X1WwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:09:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 74F81A0809; Thu,  1 Feb 2024 11:09:58 +0100 (CET)
Date: Thu, 1 Feb 2024 11:09:58 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 33/34] block: expose bdev_file_inode()
Message-ID: <20240201100958.aci5seesxlvj4rmz@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-33-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-33-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iQh3Kf3F;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=t0Yae1o8
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DAD3421D71
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 23-01-24 14:26:50, Christian Brauner wrote:
> Now that we open block devices as files we don't need to rely on
> bd_inode to get to the correct inode. Use the helper.
> 
> We could use bdev_file->f_inode directly here since we know that
> @f_inode refers to a bdev fs inode but it is generically correct to use
> bdev_file->f_mapping->host since that will also work for bdev_files
> opened from userspace.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

I think you wouldn't need this patch, if you picked up patch:
https://lore.kernel.org/all/20231211140833.975935-1-yukuai1@huaweicloud.com

from previous Yu Kuai's series. Because the only user of bdev_file_inode()
in ext4 is actually dead code...

								Honza

> ---
>  block/bdev.c           | 2 +-
>  block/fops.c           | 5 -----
>  include/linux/blkdev.h | 5 +++++
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 4b47003d8082..185c43ebeea5 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -51,7 +51,7 @@ EXPORT_SYMBOL(I_BDEV);
>  
>  struct block_device *file_bdev(struct file *bdev_file)
>  {
> -	return I_BDEV(bdev_file->f_mapping->host);
> +	return I_BDEV(bdev_file_inode(bdev_file));
>  }
>  EXPORT_SYMBOL(file_bdev);
>  
> diff --git a/block/fops.c b/block/fops.c
> index a0bff2c0d88d..240d968c281c 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -19,11 +19,6 @@
>  #include <linux/module.h>
>  #include "blk.h"
>  
> -static inline struct inode *bdev_file_inode(struct file *file)
> -{
> -	return file->f_mapping->host;
> -}
> -
>  static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
>  {
>  	blk_opf_t opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2f5dbde23094..4b7080e56e44 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1490,6 +1490,11 @@ void blkdev_put_no_open(struct block_device *bdev);
>  struct block_device *I_BDEV(struct inode *inode);
>  struct block_device *file_bdev(struct file *bdev_file);
>  
> +static inline struct inode *bdev_file_inode(struct file *file)
> +{
> +	return file->f_mapping->host;
> +}
> +
>  #ifdef CONFIG_BLOCK
>  void invalidate_bdev(struct block_device *bdev);
>  int sync_blockdev(struct block_device *bdev);
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

