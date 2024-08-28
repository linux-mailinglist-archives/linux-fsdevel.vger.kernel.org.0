Return-Path: <linux-fsdevel+bounces-27605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E36962C7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126351C241E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111B01A2C20;
	Wed, 28 Aug 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C7KT8q2q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IDDARMRi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B5qnEANe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnUx22B/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678DC13D889;
	Wed, 28 Aug 2024 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859274; cv=none; b=a+dZnGSgmQO1EM5UFKMPw1OFhzc9beVs+xST+ti/ks5tFGqPxda3yB0KqnR5NHOJTs9H/QaXjLRqJ5/sdYc+ZPLvkVsv5+n7ihMUm7vGwZ/DVEg5YS/tRCx1IQYU9AYixKiw+d+HQufXdkLQNdhNuAVl5DpBNo4NZiVQh+CsxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859274; c=relaxed/simple;
	bh=0MrHZwsCW0Y57nuox4lGSlndzkqpr7aXr7jJnEOkGb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyIjQeNlR8uo1vS8zy52wKSCeuyda32pyw0f4+3+4974qd5fzXPlrspVCAvc07h3FMBuJy478z+uIew6sIVqBYTlramla1OERJ9MHkK2IATYsa2RDEE2CI90hJaGCbTdl0iJz/lHGq3Vzyu3Aohn4Npg9lEzw4zwRW7RPKqRPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C7KT8q2q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IDDARMRi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B5qnEANe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnUx22B/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6B871FC86;
	Wed, 28 Aug 2024 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724859270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9O0Vci8+b4q68G1caoGSF7w6opascpZiikpZjFP/dws=;
	b=C7KT8q2qDGqR1u9oNyBhQ/hB78uMIU6/M9/PWy5ALFxWbK2kfqJ/JoNpykYicWEsgD8B7F
	GGBh0kR/TQsy290MAVPox+Zp/mtHmJPTzQDnCbUtM3ilM01elaAxCR/XRuCELiY5m/qT45
	yAD8687VvNU3P7xLXn8sbTFjOCav8/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724859270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9O0Vci8+b4q68G1caoGSF7w6opascpZiikpZjFP/dws=;
	b=IDDARMRid5PxQwYtyCDQNRwHUUeSdvEuUdWZbt2RBQAJ8t+rJVOZaIa+B9Z67WkH5p6vKT
	XFMfIrhAnmjLaqBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724859267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9O0Vci8+b4q68G1caoGSF7w6opascpZiikpZjFP/dws=;
	b=B5qnEANeVKXFIGM4wBUQN+RS2R0os77bJKi1uaU64QbSfC45aQxgTeTu32Z0amJBHS0gha
	jni1bYtByeXEyN1r3chuykid/X+J3j3iJlh8b7HF3HMkViw8ncPwhOUt5e9V/jasfqUiMp
	ayr4yUFDzcE5v+M9jzi7Y0+A7bCP1aU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724859267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9O0Vci8+b4q68G1caoGSF7w6opascpZiikpZjFP/dws=;
	b=ZnUx22B/FJKxla0jIH+VKSDQbj2OgNOT6rjjehHDmjTgjrJ+ceODF1hVt5ukX2lzHbldM2
	6HKI4LAizAOoK/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FA8C138D2;
	Wed, 28 Aug 2024 15:34:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L3XLIoNDz2bnUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 15:34:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 304CFA0965; Wed, 28 Aug 2024 17:34:27 +0200 (CEST)
Date: Wed, 28 Aug 2024 17:34:27 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: sort out the fallocate mode vs flag mess
Message-ID: <20240828153427.tbuzninrbj6wtam4@quack3>
References: <20240827065123.1762168-1-hch@lst.de>
 <20240827065123.1762168-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827065123.1762168-4-hch@lst.de>
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,lst.de:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 27-08-24 08:50:47, Christoph Hellwig wrote:
> The fallocate system call takes a mode argument, but that argument
> contains a wild mix of exclusive modes and an optional flags.
> 
> Replace FALLOC_FL_SUPPORTED_MASK with FALLOC_FL_MODE_MASK, which excludes
> the optional flag bit, so that we can use switch statement on the value
> to easily enumerate the cases while getting the check for duplicate modes
> for free.
> 
> To make this (and in the future the file system implementations) more
> readable also add a symbolic name for the 0 mode used to allocate blocks.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/open.c                   | 51 ++++++++++++++++++-------------------
>  include/linux/falloc.h      | 18 ++++++++-----
>  include/uapi/linux/falloc.h |  1 +
>  3 files changed, 38 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 22adbef7ecc2a6..daf1b55ca8180b 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -252,40 +252,39 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	if (offset < 0 || len <= 0)
>  		return -EINVAL;
>  
> -	/* Return error if mode is not supported */
> -	if (mode & ~FALLOC_FL_SUPPORTED_MASK)
> +	if (mode & ~(FALLOC_FL_MODE_MASK | FALLOC_FL_KEEP_SIZE))
>  		return -EOPNOTSUPP;
>  
> -	/* Punch hole and zero range are mutually exclusive */
> -	if ((mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)) ==
> -	    (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE))
> -		return -EOPNOTSUPP;
> -
> -	/* Punch hole must have keep size set */
> -	if ((mode & FALLOC_FL_PUNCH_HOLE) &&
> -	    !(mode & FALLOC_FL_KEEP_SIZE))
> +	/*
> +	 * Modes are exclusive, even if that is not obvious from the encoding
> +	 * as bit masks and the mix with the flag in the same namespace.
> +	 *
> +	 * To make things even more complicated, FALLOC_FL_ALLOCATE_RANGE is
> +	 * encoded as no bit set.
> +	 */
> +	switch (mode & FALLOC_FL_MODE_MASK) {
> +	case FALLOC_FL_ALLOCATE_RANGE:
> +	case FALLOC_FL_UNSHARE_RANGE:
> +	case FALLOC_FL_ZERO_RANGE:
> +		break;
> +	case FALLOC_FL_PUNCH_HOLE:
> +		if (!(mode & FALLOC_FL_KEEP_SIZE))
> +			return -EOPNOTSUPP;
> +		break;
> +	case FALLOC_FL_COLLAPSE_RANGE:
> +	case FALLOC_FL_INSERT_RANGE:
> +		if (mode & FALLOC_FL_KEEP_SIZE)
> +			return -EOPNOTSUPP;
> +		break;
> +	default:
>  		return -EOPNOTSUPP;
> -
> -	/* Collapse range should only be used exclusively. */
> -	if ((mode & FALLOC_FL_COLLAPSE_RANGE) &&
> -	    (mode & ~FALLOC_FL_COLLAPSE_RANGE))
> -		return -EINVAL;
> -
> -	/* Insert range should only be used exclusively. */
> -	if ((mode & FALLOC_FL_INSERT_RANGE) &&
> -	    (mode & ~FALLOC_FL_INSERT_RANGE))
> -		return -EINVAL;
> -
> -	/* Unshare range should only be used with allocate mode. */
> -	if ((mode & FALLOC_FL_UNSHARE_RANGE) &&
> -	    (mode & ~(FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE)))
> -		return -EINVAL;
> +	}
>  
>  	if (!(file->f_mode & FMODE_WRITE))
>  		return -EBADF;
>  
>  	/*
> -	 * We can only allow pure fallocate on append only files
> +	 * On append-only files only space preallocation is supported.
>  	 */
>  	if ((mode & ~FALLOC_FL_KEEP_SIZE) && IS_APPEND(inode))
>  		return -EPERM;
> diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> index f3f0b97b167579..3f49f3df6af5fb 100644
> --- a/include/linux/falloc.h
> +++ b/include/linux/falloc.h
> @@ -25,12 +25,18 @@ struct space_resv {
>  #define FS_IOC_UNRESVSP64	_IOW('X', 43, struct space_resv)
>  #define FS_IOC_ZERO_RANGE	_IOW('X', 57, struct space_resv)
>  
> -#define	FALLOC_FL_SUPPORTED_MASK	(FALLOC_FL_KEEP_SIZE |		\
> -					 FALLOC_FL_PUNCH_HOLE |		\
> -					 FALLOC_FL_COLLAPSE_RANGE |	\
> -					 FALLOC_FL_ZERO_RANGE |		\
> -					 FALLOC_FL_INSERT_RANGE |	\
> -					 FALLOC_FL_UNSHARE_RANGE)
> +/*
> + * Mask of all supported fallocate modes.  Only one can be set at a time.
> + *
> + * In addition to the mode bit, the mode argument can also encode flags.
> + * FALLOC_FL_KEEP_SIZE is the only supported flag so far.
> + */
> +#define FALLOC_FL_MODE_MASK	(FALLOC_FL_ALLOCATE_RANGE |	\
> +				 FALLOC_FL_PUNCH_HOLE |		\
> +				 FALLOC_FL_COLLAPSE_RANGE |	\
> +				 FALLOC_FL_ZERO_RANGE |		\
> +				 FALLOC_FL_INSERT_RANGE |	\
> +				 FALLOC_FL_UNSHARE_RANGE)
>  
>  /* on ia32 l_start is on a 32-bit boundary */
>  #if defined(CONFIG_X86_64)
> diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> index 51398fa57f6cdf..5810371ed72bbd 100644
> --- a/include/uapi/linux/falloc.h
> +++ b/include/uapi/linux/falloc.h
> @@ -2,6 +2,7 @@
>  #ifndef _UAPI_FALLOC_H_
>  #define _UAPI_FALLOC_H_
>  
> +#define FALLOC_FL_ALLOCATE_RANGE 0x00 /* allocate range */
>  #define FALLOC_FL_KEEP_SIZE	0x01 /* default is extend size */
>  #define FALLOC_FL_PUNCH_HOLE	0x02 /* de-allocates range */
>  #define FALLOC_FL_NO_HIDE_STALE	0x04 /* reserved codepoint */
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

