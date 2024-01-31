Return-Path: <linux-fsdevel+bounces-9692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393178446FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AECC1C22842
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50BC131737;
	Wed, 31 Jan 2024 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QfRZWuN/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wd8vb2tf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QfRZWuN/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wd8vb2tf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8012CDB8;
	Wed, 31 Jan 2024 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725061; cv=none; b=IYaUtza3OlFSHtqepOSPLgi+aDKsgJLWJPSnPoD/w60BasiDjuGcTop/1Obf2MSuXOX2pe/KpPKa1TC3yFHX4WzWvBopyRPlzkhDxCwY245JgxnENSbtdkez5QdCKWRaJwmPjGSwXj/WCnlAvyqtnIcXK9c6tnYfhjt2kA/djZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725061; c=relaxed/simple;
	bh=ZurfBZtHr9WEY7HvI5OCnhb82Xf96IvrQORyjIEmveQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2NN696HW2DDLEJjX5onma9NBA/q+V4j3lXtlXknSREGghhgoyeL1kjfwKqcEibzKAVly3R/a7wqH7f67sdAaUUcP1D7RNYuJnVmUc8cU7hug219sFd5KBzio/hMX3Uawy6UPaoJVnI/kJ+HHuUxAkGuGMHf4i/320q/KrWgnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QfRZWuN/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wd8vb2tf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QfRZWuN/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wd8vb2tf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73BB51FB95;
	Wed, 31 Jan 2024 18:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AVOVzIjaWamwPNghGeG2GvhLLr/nSosngrC9kYLQ12U=;
	b=QfRZWuN/RuySNbJ9ynOfVC974YJMezpxBE8Gj2nezDr6rxUR4zYyIZRLmYV4dJrXgftJw9
	he3ABUyLntVjTPFZe7bl8lOINE5ip1hsI9k6wLOKUflCFryuMiZC0729+tieQZii49Caw9
	MtaU7dpyw4+Hsh1L9gCT/5+qsC7W5mA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AVOVzIjaWamwPNghGeG2GvhLLr/nSosngrC9kYLQ12U=;
	b=Wd8vb2tf4wlMgtbg2OLKrTTA7iEw2Y8mZAYX6jibUDW7DR5bajmbHCU/CmUo772jLx1iG0
	oMFxvbE3pnXeu7BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AVOVzIjaWamwPNghGeG2GvhLLr/nSosngrC9kYLQ12U=;
	b=QfRZWuN/RuySNbJ9ynOfVC974YJMezpxBE8Gj2nezDr6rxUR4zYyIZRLmYV4dJrXgftJw9
	he3ABUyLntVjTPFZe7bl8lOINE5ip1hsI9k6wLOKUflCFryuMiZC0729+tieQZii49Caw9
	MtaU7dpyw4+Hsh1L9gCT/5+qsC7W5mA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AVOVzIjaWamwPNghGeG2GvhLLr/nSosngrC9kYLQ12U=;
	b=Wd8vb2tf4wlMgtbg2OLKrTTA7iEw2Y8mZAYX6jibUDW7DR5bajmbHCU/CmUo772jLx1iG0
	oMFxvbE3pnXeu7BA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 67D49139D9;
	Wed, 31 Jan 2024 18:17:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0aZXGcGOumWkJAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 18:17:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 19A2BA0809; Wed, 31 Jan 2024 19:17:37 +0100 (CET)
Date: Wed, 31 Jan 2024 19:17:37 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 06/34] power: port block device access to file
Message-ID: <20240131181737.6fkxznbu2uuqji7y@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-6-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-6-adbd023e19cc@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="QfRZWuN/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Wd8vb2tf
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.15 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.14)[68.05%]
X-Spam-Score: -1.15
X-Rspamd-Queue-Id: 73BB51FB95
X-Spam-Flag: NO

On Tue 23-01-24 14:26:23, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/power/swap.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 6053ddddaf65..692f12fe60c1 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -222,7 +222,7 @@ int swsusp_swap_in_use(void)
>   */
>  
>  static unsigned short root_swap = 0xffff;
> -static struct bdev_handle *hib_resume_bdev_handle;
> +static struct file *hib_resume_bdev_file;
>  
>  struct hib_bio_batch {
>  	atomic_t		count;
> @@ -276,7 +276,7 @@ static int hib_submit_io(blk_opf_t opf, pgoff_t page_off, void *addr,
>  	struct bio *bio;
>  	int error = 0;
>  
> -	bio = bio_alloc(hib_resume_bdev_handle->bdev, 1, opf,
> +	bio = bio_alloc(file_bdev(hib_resume_bdev_file), 1, opf,
>  			GFP_NOIO | __GFP_HIGH);
>  	bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
>  
> @@ -357,14 +357,14 @@ static int swsusp_swap_check(void)
>  		return res;
>  	root_swap = res;
>  
> -	hib_resume_bdev_handle = bdev_open_by_dev(swsusp_resume_device,
> +	hib_resume_bdev_file = bdev_file_open_by_dev(swsusp_resume_device,
>  			BLK_OPEN_WRITE, NULL, NULL);
> -	if (IS_ERR(hib_resume_bdev_handle))
> -		return PTR_ERR(hib_resume_bdev_handle);
> +	if (IS_ERR(hib_resume_bdev_file))
> +		return PTR_ERR(hib_resume_bdev_file);
>  
> -	res = set_blocksize(hib_resume_bdev_handle->bdev, PAGE_SIZE);
> +	res = set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
>  	if (res < 0)
> -		bdev_release(hib_resume_bdev_handle);
> +		fput(hib_resume_bdev_file);
>  
>  	return res;
>  }
> @@ -1523,10 +1523,10 @@ int swsusp_check(bool exclusive)
>  	void *holder = exclusive ? &swsusp_holder : NULL;
>  	int error;
>  
> -	hib_resume_bdev_handle = bdev_open_by_dev(swsusp_resume_device,
> +	hib_resume_bdev_file = bdev_file_open_by_dev(swsusp_resume_device,
>  				BLK_OPEN_READ, holder, NULL);
> -	if (!IS_ERR(hib_resume_bdev_handle)) {
> -		set_blocksize(hib_resume_bdev_handle->bdev, PAGE_SIZE);
> +	if (!IS_ERR(hib_resume_bdev_file)) {
> +		set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
>  		clear_page(swsusp_header);
>  		error = hib_submit_io(REQ_OP_READ, swsusp_resume_block,
>  					swsusp_header, NULL);
> @@ -1551,11 +1551,11 @@ int swsusp_check(bool exclusive)
>  
>  put:
>  		if (error)
> -			bdev_release(hib_resume_bdev_handle);
> +			fput(hib_resume_bdev_file);
>  		else
>  			pr_debug("Image signature found, resuming\n");
>  	} else {
> -		error = PTR_ERR(hib_resume_bdev_handle);
> +		error = PTR_ERR(hib_resume_bdev_file);
>  	}
>  
>  	if (error)
> @@ -1570,12 +1570,12 @@ int swsusp_check(bool exclusive)
>  
>  void swsusp_close(void)
>  {
> -	if (IS_ERR(hib_resume_bdev_handle)) {
> +	if (IS_ERR(hib_resume_bdev_file)) {
>  		pr_debug("Image device not initialised\n");
>  		return;
>  	}
>  
> -	bdev_release(hib_resume_bdev_handle);
> +	fput(hib_resume_bdev_file);
>  }
>  
>  /**
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

