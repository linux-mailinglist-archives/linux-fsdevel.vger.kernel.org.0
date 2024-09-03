Return-Path: <linux-fsdevel+bounces-28375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A995969F23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D700F2825E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D6D846D;
	Tue,  3 Sep 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kClwtRbr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BNSAlH78";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kClwtRbr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BNSAlH78"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF763D5
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370653; cv=none; b=DogVR+YW7AXVpjGTl3gSFgQDBngiudiQfVPsHwZntymhZ1jqkz0bg395+bx/b+1dmWlPDMgk/X+iXWAv0AKxBwPl01w8PJPsYpbJ6Y70IM6aUrP4N8gnKsumBrF7TwDsjHY1a4IZv/Hoc4kL7pNsBFcdjHrdOkawVYUyeGuM0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370653; c=relaxed/simple;
	bh=rWVs1ROgMJyBM6P1UK41osDiNm+Di5it9uJ9aau9jvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2kLXmZSD/Q1jD2DZ+6xBY1QdXfNTcK55rpGIo3G/DjcFe+nlq3LVxjxQTh4ld5zX4EmU2aMhi8j4N/sCMgmCWY07+zW2qN/rJyAvGtuhcixTTjos3KE3TIE5ilyknQZJqJzIQugskYQuaqNJLTjyANuvbgCbPI+ouR9JK5u1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kClwtRbr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BNSAlH78; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kClwtRbr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BNSAlH78; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B6541F37E;
	Tue,  3 Sep 2024 13:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3SCxQ+NmQRtwLHPhLo8QeM0g3b4P4nk3ro8U3Us4SYE=;
	b=kClwtRbrNKfDvch2sqEfBwKdKSJFfLaWnxSMdAMmB3YYovh32Ffw9yJZG77BRhKkv9lQOf
	O1uydPQv2oq3HYFOifjmCJDiWEr78tSuyICZoGVBHCjqrpHhLKE8odxDOR2BTVKJxEeojL
	ZnNqNGpmBSGFOZMNqdHHJdzT45o8wAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3SCxQ+NmQRtwLHPhLo8QeM0g3b4P4nk3ro8U3Us4SYE=;
	b=BNSAlH78v1otzwGi51cDuj2/dCyHN54BV6DWXptVPKcBiBP3LiC/I6hFiUpo/iN7kaP5A8
	er8MvnPn6jGgoxCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3SCxQ+NmQRtwLHPhLo8QeM0g3b4P4nk3ro8U3Us4SYE=;
	b=kClwtRbrNKfDvch2sqEfBwKdKSJFfLaWnxSMdAMmB3YYovh32Ffw9yJZG77BRhKkv9lQOf
	O1uydPQv2oq3HYFOifjmCJDiWEr78tSuyICZoGVBHCjqrpHhLKE8odxDOR2BTVKJxEeojL
	ZnNqNGpmBSGFOZMNqdHHJdzT45o8wAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3SCxQ+NmQRtwLHPhLo8QeM0g3b4P4nk3ro8U3Us4SYE=;
	b=BNSAlH78v1otzwGi51cDuj2/dCyHN54BV6DWXptVPKcBiBP3LiC/I6hFiUpo/iN7kaP5A8
	er8MvnPn6jGgoxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EECB13A52;
	Tue,  3 Sep 2024 13:37:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hEgsFxkR12ZjSgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 13:37:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1DEE7A096C; Tue,  3 Sep 2024 15:37:29 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:37:29 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 15/20] udf: store cookie in private data
Message-ID: <20240903133729.2mtp6uxro2gydsk7@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-15-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-15-6d3e4816aa7b@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 30-08-24 15:04:56, Christian Brauner wrote:
> Store the cookie to detect concurrent seeks on directories in
> file->private_data.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/udf/dir.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/udf/dir.c b/fs/udf/dir.c
> index f94f45fe2c91..5023dfe191e8 100644
> --- a/fs/udf/dir.c
> +++ b/fs/udf/dir.c
> @@ -60,7 +60,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
>  	 * identifying beginning of dir entry (names are under user control),
>  	 * we need to scan the directory from the beginning.
>  	 */
> -	if (!inode_eq_iversion(dir, file->f_version)) {
> +	if (!inode_eq_iversion(dir, *(u64 *)file->private_data)) {
>  		emit_pos = nf_pos;
>  		nf_pos = 0;
>  	} else {
> @@ -122,15 +122,37 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
>  	udf_fiiter_release(&iter);
>  out:
>  	if (pos_valid)
> -		file->f_version = inode_query_iversion(dir);
> +		*(u64 *)file->private_data = inode_query_iversion(dir);
>  	kfree(fname);
>  
>  	return ret;
>  }
>  
> +static int udf_dir_open(struct inode *inode, struct file *file)
> +{
> +	file->private_data = kzalloc(sizeof(u64), GFP_KERNEL);
> +	if (!file->private_data)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +static int udf_dir_release(struct inode *inode, struct file *file)
> +{
> +	kfree(file->private_data);
> +	return 0;
> +}
> +
> +static loff_t udf_dir_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	return generic_llseek_cookie(file, offset, whence,
> +				     (u64 *)file->private_data);
> +}
> +
>  /* readdir and lookup functions */
>  const struct file_operations udf_dir_operations = {
> -	.llseek			= generic_file_llseek,
> +	.open			= udf_dir_open,
> +	.release		= udf_dir_release,
> +	.llseek			= udf_dir_llseek,
>  	.read			= generic_read_dir,
>  	.iterate_shared		= udf_readdir,
>  	.unlocked_ioctl		= udf_ioctl,
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

