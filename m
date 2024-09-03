Return-Path: <linux-fsdevel+bounces-28354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC896969BF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AF2284CAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3AF1A42C4;
	Tue,  3 Sep 2024 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zWBqjKRG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BqW+A3zg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NgGqmqdk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jOzfheCX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73C1B9858
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363316; cv=none; b=aha7itx/Ik7TSO0tEvnvZQKjJ7qst2tkpUWllJC99NJvmyqDOjc5dQcxNTxIDaPJtpkZnaePlZGrVPjohMuO5Ptfk1ZPdbXtX0SJn8QCyZDs9tsS8zFYJ95RZO6t0fgRNTi9OL+W3Cs26el3b99fUZXAMPDM/23ke15wDfFjx1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363316; c=relaxed/simple;
	bh=Mn6SKdMU4HP/b/ZblsH4kf0z5UIvUFHAswOwhSEGNRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaf4+7pJzt95FZt9gRXO7rtQvN3rnZZGxbM4vmQ3lniBvB9uqs8SV1rg11u25FtfhO71ODdpFdcxUJnAbgqBwi9/8oMRC5brMrXPutkcD4YNlUfjmkJ06nbuz0PDR3HwbAlu3sN1AFSqqjCea57nnhbJVsYndewTFWONQR//cBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zWBqjKRG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BqW+A3zg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NgGqmqdk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jOzfheCX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C466121992;
	Tue,  3 Sep 2024 11:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K+Ejg6WgHELG19UNFqt6tXtkYY2mJCGi9I3gxCJVPa4=;
	b=zWBqjKRGsvSZpt3VoUAPmyIy5y0yZ+o2TFSE8FJuyLzthHAZa/cOrDq5GcLbqb06Iumlan
	GjO1r7LY5+kbWQn4pnuy29KTaboF1Jbx43QHG4bK7QgbEjJKg9Q13fINothzcUr4OGgEI3
	3GM5e6toqu1vPAcJ00oG8TqU2ksIvRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K+Ejg6WgHELG19UNFqt6tXtkYY2mJCGi9I3gxCJVPa4=;
	b=BqW+A3zguQ20dN0d1C3zF4pozImjBKvoymeDAFWkN72SLY7u6felbL3OgBfVcfxuy5iilD
	JMmYgIfXwgXmREBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K+Ejg6WgHELG19UNFqt6tXtkYY2mJCGi9I3gxCJVPa4=;
	b=NgGqmqdkxbeWjzk4EHCWIetMtu9Vvdkz7tKvi06yoXzgGf8D8pSVA7fcpCbxXNVWt6ZaVK
	0ni2AV9/NeVE68xzb8YjK8Oh5HfREo86n2crIUaB2r3dSD6IYghwVdNWa49M3FqEoYQCEg
	3XWSCSnLoAxPhBiVvK31aSyX9zHidCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K+Ejg6WgHELG19UNFqt6tXtkYY2mJCGi9I3gxCJVPa4=;
	b=jOzfheCXs765S1kMdiJuIdma7LYs+kCuF389a5pv3DiyTW6t8LnB67DulqgsZPhsTJMmvV
	s7mMVrnuEeu3nOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9C4613A52;
	Tue,  3 Sep 2024 11:35:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pupqLW/01mZVIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 11:35:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7E84CA096C; Tue,  3 Sep 2024 13:35:03 +0200 (CEST)
Date: Tue, 3 Sep 2024 13:35:03 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 05/20] fs: add vfs_setpos_cookie()
Message-ID: <20240903113503.dizel3o4ihf77qon@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-5-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-5-6d3e4816aa7b@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 30-08-24 15:04:46, Christian Brauner wrote:
> Add a new helper and make vfs_setpos() call it. We will use it in
> follow-up patches.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/read_write.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 90e283b31ca1..66ff52860496 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -40,18 +40,20 @@ static inline bool unsigned_offsets(struct file *file)
>  }
>  
>  /**
> - * vfs_setpos - update the file offset for lseek
> + * vfs_setpos_cookie - update the file offset for lseek and reset cookie
>   * @file:	file structure in question
>   * @offset:	file offset to seek to
>   * @maxsize:	maximum file size
> + * @cookie:	cookie to reset
>   *
> - * This is a low-level filesystem helper for updating the file offset to
> - * the value specified by @offset if the given offset is valid and it is
> - * not equal to the current file offset.
> + * Update the file offset to the value specified by @offset if the given
> + * offset is valid and it is not equal to the current file offset and
> + * reset the specified cookie to indicate that a seek happened.
>   *
>   * Return the specified offset on success and -EINVAL on invalid offset.
>   */
> -loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
> +static loff_t vfs_setpos_cookie(struct file *file, loff_t offset,
> +				loff_t maxsize, u64 *cookie)
>  {
>  	if (offset < 0 && !unsigned_offsets(file))
>  		return -EINVAL;
> @@ -60,10 +62,27 @@ loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
>  
>  	if (offset != file->f_pos) {
>  		file->f_pos = offset;
> -		file->f_version = 0;
> +		*cookie = 0;
>  	}
>  	return offset;
>  }
> +
> +/**
> + * vfs_setpos - update the file offset for lseek
> + * @file:	file structure in question
> + * @offset:	file offset to seek to
> + * @maxsize:	maximum file size
> + *
> + * This is a low-level filesystem helper for updating the file offset to
> + * the value specified by @offset if the given offset is valid and it is
> + * not equal to the current file offset.
> + *
> + * Return the specified offset on success and -EINVAL on invalid offset.
> + */
> +loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
> +{
> +	return vfs_setpos_cookie(file, offset, maxsize, &file->f_version);
> +}
>  EXPORT_SYMBOL(vfs_setpos);
>  
>  /**
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

