Return-Path: <linux-fsdevel+bounces-59986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B42B40394
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 15:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254B43A292F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2944130DEBB;
	Tue,  2 Sep 2025 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="muldPbKB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8VB8ShqV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mDAQki4D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fa0yyIJo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C800830E82D
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819800; cv=none; b=Ogy5r/8+aCQXaLcuk+E3eo5RgH+wl7tbytPv81uR7NmWnfhVqj2r3gJPctrSK2ZWN9JtwE5z3joCXnoyBqExTDv7nLvJxrsgd/Ur8XcTIIWZSIHQoAPpEH/0aAP4xDasaDl/6E+x0aHkLMEcrVIfuUFbpheVxoB7msimnuYzTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819800; c=relaxed/simple;
	bh=E3yq5cRtyiSNLEiQnKoURmT3ZY/cEWvKXre66KYTGz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZaUmVQG7KJ3dQbaAs1ur1Exn3NNsSESmle/f9zm6FMQCdlXS0+jq/nxngTt/ZE+0yw5fF6CZVirwedoQ+TXiE7XMl8U+bJzhbBmeaJzQONjs22z2EgaW+2xePf/1ZTyhAyBpvqkGaW18G0q++KWt5jhBct+BOzfMPrKP1XChUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=muldPbKB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8VB8ShqV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mDAQki4D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fa0yyIJo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DEBA0211A1;
	Tue,  2 Sep 2025 13:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756819797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+tmHzc4JszRWN9Uk+IedaTWn5QYqC9HOR77ygGDmZQ=;
	b=muldPbKBoJrxHtg03AISKTJnQwNg8sWhaa5P3098MK8jgq7T1SDlICG4zkyjoKBdi+PAnG
	u/4EAg/MIfwd/mYWzcrhDvsxX0pMRrSUOl5drrjyn5TjVlCSkmMZ9G1ICpjpCFcF+wiJJG
	SSQ28eCH/rv4tCJjHDA8gFfDY7wFl7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756819797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+tmHzc4JszRWN9Uk+IedaTWn5QYqC9HOR77ygGDmZQ=;
	b=8VB8ShqVPRCkUe6K/aSJWNQgSbpBaFTlMKNuDchDCbUfN9h5g5zJfoPZ1lTeujPBbs04MQ
	LVDH7uWVvRAF6SBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mDAQki4D;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fa0yyIJo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756819796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+tmHzc4JszRWN9Uk+IedaTWn5QYqC9HOR77ygGDmZQ=;
	b=mDAQki4DW0gfkRf9PN/SMdVzR+/9JmNe5xaQV7D59VpZksxXABFEnnuGtpzOhI5h1X0+h5
	zqiNEuZTDH3ZyQYQgRYJG284H5XgeqkDJfsgIjYBfWOpf/OvY2y+67MBGolT/1JDCuNWTl
	qBeFrHiwvpAgawQ0q2c7Gesk38VQfpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756819796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+tmHzc4JszRWN9Uk+IedaTWn5QYqC9HOR77ygGDmZQ=;
	b=fa0yyIJoLYpQ9jwIcEAx1dkCGSzY+aF++vgpvpqKjgicxWylzxnUDw+ggc4MQOYuV2yUtx
	msM5ny4BpEQnw7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C077213882;
	Tue,  2 Sep 2025 13:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LyejLlTxtmiKXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Sep 2025 13:29:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 59571A0A9F; Tue,  2 Sep 2025 15:29:56 +0200 (CEST)
Date: Tue, 2 Sep 2025 15:29:56 +0200
From: Jan Kara <jack@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.com>, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2, udf: update to use mmap_prepare
Message-ID: <kjcvzhgyiucsdcgsrbyglf3c2cybelhzggns5rh6tslvzstw3n@c7gyqtxnvzgt>
References: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: DEBA0211A1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Tue 02-09-25 12:53:41, Lorenzo Stoakes wrote:
> The f_op->mmap() callback is deprecated, and we are in the process of
> slowly converting users to f_op->mmap_prepare().
> 
> While some filesystems require additional work to be done before they can
> be converted, the gfs2 and udf filesystems (like most) are simple and can
> simply be replaced right away.
> 
> This patch adapts them to do so.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/gfs2/file.c | 12 ++++++------
>  fs/udf/file.c  |  8 +++++---
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index bc67fa058c84..c28ff8786238 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -577,7 +577,7 @@ static const struct vm_operations_struct gfs2_vm_ops = {
>  };
>  
>  /**
> - * gfs2_mmap
> + * gfs2_mmap_prepare
>   * @file: The file to map
>   * @vma: The VMA which described the mapping
>   *
> @@ -588,8 +588,9 @@ static const struct vm_operations_struct gfs2_vm_ops = {
>   * Returns: 0
>   */
>  
> -static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
> +static int gfs2_mmap_prepare(struct vm_area_desc *desc)
>  {
> +	struct file *file = desc->file;
>  	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
>  
>  	if (!(file->f_flags & O_NOATIME) &&
> @@ -605,7 +606,7 @@ static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
>  		gfs2_glock_dq_uninit(&i_gh);
>  		file_accessed(file);
>  	}
> -	vma->vm_ops = &gfs2_vm_ops;
> +	desc->vm_ops = &gfs2_vm_ops;
>  
>  	return 0;
>  }
> @@ -1585,7 +1586,7 @@ const struct file_operations gfs2_file_fops = {
>  	.iopoll		= iocb_bio_iopoll,
>  	.unlocked_ioctl	= gfs2_ioctl,
>  	.compat_ioctl	= gfs2_compat_ioctl,
> -	.mmap		= gfs2_mmap,
> +	.mmap_prepare	= gfs2_mmap,
>  	.open		= gfs2_open,
>  	.release	= gfs2_release,
>  	.fsync		= gfs2_fsync,
> @@ -1620,7 +1621,7 @@ const struct file_operations gfs2_file_fops_nolock = {
>  	.iopoll		= iocb_bio_iopoll,
>  	.unlocked_ioctl	= gfs2_ioctl,
>  	.compat_ioctl	= gfs2_compat_ioctl,
> -	.mmap		= gfs2_mmap,
> +	.mmap_prepare	= gfs2_mmap_prepare,
>  	.open		= gfs2_open,
>  	.release	= gfs2_release,
>  	.fsync		= gfs2_fsync,
> @@ -1639,4 +1640,3 @@ const struct file_operations gfs2_dir_fops_nolock = {
>  	.fsync		= gfs2_fsync,
>  	.llseek		= default_llseek,
>  };
> -
> diff --git a/fs/udf/file.c b/fs/udf/file.c
> index 0d76c4f37b3e..fbb2d6ba8ca2 100644
> --- a/fs/udf/file.c
> +++ b/fs/udf/file.c
> @@ -189,10 +189,12 @@ static int udf_release_file(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> -static int udf_file_mmap(struct file *file, struct vm_area_struct *vma)
> +static int udf_file_mmap_prepare(struct vm_area_desc *desc)
>  {
> +	struct file *file = desc->file;
> +
>  	file_accessed(file);
> -	vma->vm_ops = &udf_file_vm_ops;
> +	desc->vm_ops = &udf_file_vm_ops;
>  
>  	return 0;
>  }
> @@ -201,7 +203,7 @@ const struct file_operations udf_file_operations = {
>  	.read_iter		= generic_file_read_iter,
>  	.unlocked_ioctl		= udf_ioctl,
>  	.open			= generic_file_open,
> -	.mmap			= udf_file_mmap,
> +	.mmap_prepare		= udf_file_mmap_prepare,
>  	.write_iter		= udf_file_write_iter,
>  	.release		= udf_release_file,
>  	.fsync			= generic_file_fsync,
> -- 
> 2.50.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

