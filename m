Return-Path: <linux-fsdevel+bounces-36272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584B69E0920
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 17:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC41B2FBE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED72A13B797;
	Mon,  2 Dec 2024 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z4OapPUA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IyuBfQ5l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z4OapPUA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IyuBfQ5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEAC7DA7F;
	Mon,  2 Dec 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155152; cv=none; b=mf1tJg1m1xO04PAmbeR51OKdQsVwryudLivqVypmgerhtSa26iDWN5j2dR5QDr4A4BBDIRconPOQ0cU/n2P1OD7slkclUXQR5ri5wNrpbBCBGrq5n0/FmAFuBPcV6h2WyxK/0gW/I5zI7v329Nw3eUVCnJeVM0aeeAueHLkw0Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155152; c=relaxed/simple;
	bh=u0aaYgGhF/pf7rNy0ZOCVe9AStHX2mdW8sJWa2/i8xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIuwTOW0dg9mu/7v2YZhIlqw7JOuhmaajAXNQfxsXgDEOU9nqokx+B5PRGsozOjD1eu6oYN/xJTYcQUbSHcuomoahP1raA5KRhjKRKVpNIt9vfOBbVYligj1jrxgYUTFmcSie0nlpoq1mgzf93B+ec6KLpQ0gslvtnNScOioc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z4OapPUA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IyuBfQ5l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z4OapPUA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IyuBfQ5l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78AD11F396;
	Mon,  2 Dec 2024 15:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733155147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCe+Df6SQWIMK4AJZ2dKw/kIeq0uZKoG15fCSs7t3qo=;
	b=Z4OapPUAe7/bNo7aoMeyhU2KfiynYkCy1ImKXeT3h+eNIO18DaivAY/tw8oV4sjp9AJ3Pe
	l036qEN0g+PiVN67NhSS/3bKELFhsOlnF7hz0bgJisUKXJ4I+AWJGjZB8fqRMTGLEqi53l
	R50vHy8uaKeWtASwZ4l4BOiaFTiK1Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733155147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCe+Df6SQWIMK4AJZ2dKw/kIeq0uZKoG15fCSs7t3qo=;
	b=IyuBfQ5lGvPxYAVzl/8Vy2WMwkHx6h2qZdQXri5SJDU8zA/G4Akm/lm0TtloXfOTYXm2ZB
	w+Rpkelm9goDnRDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733155147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCe+Df6SQWIMK4AJZ2dKw/kIeq0uZKoG15fCSs7t3qo=;
	b=Z4OapPUAe7/bNo7aoMeyhU2KfiynYkCy1ImKXeT3h+eNIO18DaivAY/tw8oV4sjp9AJ3Pe
	l036qEN0g+PiVN67NhSS/3bKELFhsOlnF7hz0bgJisUKXJ4I+AWJGjZB8fqRMTGLEqi53l
	R50vHy8uaKeWtASwZ4l4BOiaFTiK1Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733155147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCe+Df6SQWIMK4AJZ2dKw/kIeq0uZKoG15fCSs7t3qo=;
	b=IyuBfQ5lGvPxYAVzl/8Vy2WMwkHx6h2qZdQXri5SJDU8zA/G4Akm/lm0TtloXfOTYXm2ZB
	w+Rpkelm9goDnRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6277313A31;
	Mon,  2 Dec 2024 15:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EUQHGEvZTWcOPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Dec 2024 15:59:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1515AA07B4; Mon,  2 Dec 2024 16:59:07 +0100 (CET)
Date: Mon, 2 Dec 2024 16:59:07 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] pseudofs: add support for export_ops
Message-ID: <20241202155907.v6kd2dtm7bqu7vu4@quack3>
References: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
 <20241129-work-pidfs-file_handle-v1-1-87d803a42495@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-work-pidfs-file_handle-v1-1-87d803a42495@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[e43.eu,gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 29-11-24 14:38:00, Christian Brauner wrote:
> From: Erin Shepherd <erin.shepherd@e43.eu>
> 
> Pseudo-filesystems might reasonably wish to implement the export ops
> (particularly for name_to_handle_at/open_by_handle_at); plumb this
> through pseudo_fs_context
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
> Link: https://lore.kernel.org/r/20241113-pidfs_fh-v2-1-9a4d28155a37@e43.eu
> Signed-off-by: Christian Brauner <brauner@kernel.org>

OK, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/libfs.c                | 1 +
>  include/linux/pseudo_fs.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 748ac59231547c29abcbade3fa025e3b00533d8b..2890a9c4a414b7e2be5c337e238db84743f0a30b 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -673,6 +673,7 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
>  	s->s_blocksize_bits = PAGE_SHIFT;
>  	s->s_magic = ctx->magic;
>  	s->s_op = ctx->ops ?: &simple_super_operations;
> +	s->s_export_op = ctx->eops;
>  	s->s_xattr = ctx->xattr;
>  	s->s_time_gran = 1;
>  	root = new_inode(s);
> diff --git a/include/linux/pseudo_fs.h b/include/linux/pseudo_fs.h
> index 730f77381d55f1816ef14adf7dd2cf1d62bb912c..2503f7625d65e7b1fbe9e64d5abf06cd8f017b5f 100644
> --- a/include/linux/pseudo_fs.h
> +++ b/include/linux/pseudo_fs.h
> @@ -5,6 +5,7 @@
>  
>  struct pseudo_fs_context {
>  	const struct super_operations *ops;
> +	const struct export_operations *eops;
>  	const struct xattr_handler * const *xattr;
>  	const struct dentry_operations *dops;
>  	unsigned long magic;
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

