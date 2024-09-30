Return-Path: <linux-fsdevel+bounces-30349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05EC98A256
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCBE2852E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7D11714C0;
	Mon, 30 Sep 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cvQSyEaA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iuZM5EaB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Su0X3gHs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ysQb6iMQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD141A84;
	Mon, 30 Sep 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699135; cv=none; b=BvqzVFgRCU94v7gltmHMeTrYM3Y3YhKo7QM60gHTu/a4GG4uZ+da7XpTjFbYEFqrOvHUbeXLWqqtjOyIgEsOzM8vDSICPripfHuUHC60KZlDVzj2Fk/9kyY5HmID2d8fnRHK7jALo9tiPlfTYZB67rEWymuGpDYum/35gG8aac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699135; c=relaxed/simple;
	bh=+V564eowzouTecoWskTY1UCmlR4v2OPgp4hMLsOBGrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ9B9MSobkFVhGdeCR9LNHA3XWJJZwNrI8qv9c2XwT1u4IgxZgpinG96qpktNoYjj1GMgF35sdjAHH302pw9wuNs6fc9oxnoqbFgFyIifnhTtMoKS++1wlvwLQng/DO7PYqa7OErivs7YerEBeI4IJ4j2MdqlZbcNJwFWP+sGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cvQSyEaA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iuZM5EaB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Su0X3gHs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ysQb6iMQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1C02219C7;
	Mon, 30 Sep 2024 12:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727699130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCzn6XDk1qFI0wcZTEig1MkNHdR7p0XCdIe+O4bSFFk=;
	b=cvQSyEaA+dDgE6pNISxu3pD06tSr/fm/khQjPE/81FsTaKeblYzvWm+Lh+UZ1gYqOdJdUU
	cuMYV/kvhLh9tBHlhWszG68v6tgjR4GSznfrNGaUTcVWaTipR04FHNn2WnrwUlNu3AaBbJ
	4YZxovDavjM5VBU5Dgx9JLzj2rYOXAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727699130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCzn6XDk1qFI0wcZTEig1MkNHdR7p0XCdIe+O4bSFFk=;
	b=iuZM5EaBCd0nmLrHPCy0cVnw3+qKM4K0cFj6TapVzI70baTjKVUfexxd4ea+uY8ssE0drR
	PLm77Eg410JoxmAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727699129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCzn6XDk1qFI0wcZTEig1MkNHdR7p0XCdIe+O4bSFFk=;
	b=Su0X3gHsBVCRELVd43s9I7NY4YAET6c8GanX6Q7p/+NsxuQNZMZTULzNLAojxd6aTBePDN
	EHOcxLVViareAKcP2DLUZPn9ddxfKNwzTcYkVcrr5gwUkApZ9yUiT9skms20XsLSccBblM
	ijyDy1GLaEb+22lFKESPmpn8bOWi6rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727699129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCzn6XDk1qFI0wcZTEig1MkNHdR7p0XCdIe+O4bSFFk=;
	b=ysQb6iMQtfFd8Qg/huqef1JNm9bmx5TbQQS0KLYJXoSOTdPlQr5OurKD5UhdcqiHBt84m2
	0eAiPObm+2uoaWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7BC613A8B;
	Mon, 30 Sep 2024 12:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JTOiNLmY+mYSZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Sep 2024 12:25:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 940EBA0845; Mon, 30 Sep 2024 14:25:29 +0200 (CEST)
Date: Mon, 30 Sep 2024 14:25:29 +0200
From: Jan Kara <jack@suse.cz>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	kernel-janitors@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/35] fs: Reorganize kerneldoc parameter names
Message-ID: <20240930122529.5r5x3o2rq43f3f6l@quack3>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
 <20240930112121.95324-9-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930112121.95324-9-Julia.Lawall@inria.fr>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 30-09-24 13:20:54, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
>  fs/char_dev.c |    2 +-
>  fs/dcache.c   |    4 ++--
>  fs/seq_file.c |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index 57cc096c498a..c2ddb998f3c9 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -562,8 +562,8 @@ int cdev_device_add(struct cdev *cdev, struct device *dev)
>  
>  /**
>   * cdev_device_del() - inverse of cdev_device_add
> - * @dev: the device structure
>   * @cdev: the cdev structure
> + * @dev: the device structure
>   *
>   * cdev_device_del() is a helper function to call cdev_del and device_del.
>   * It should be used whenever cdev_device_add is used.
> diff --git a/fs/dcache.c b/fs/dcache.c
> index d7f6866f5f52..2894b30d8e40 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2039,8 +2039,8 @@ EXPORT_SYMBOL(d_obtain_root);
>  
>  /**
>   * d_add_ci - lookup or allocate new dentry with case-exact name
> - * @inode:  the inode case-insensitive lookup has found
>   * @dentry: the negative dentry that was passed to the parent's lookup func
> + * @inode:  the inode case-insensitive lookup has found
>   * @name:   the case-exact name to be associated with the returned dentry
>   *
>   * This is to avoid filling the dcache with case-insensitive names to the
> @@ -2093,8 +2093,8 @@ EXPORT_SYMBOL(d_add_ci);
>  
>  /**
>   * d_same_name - compare dentry name with case-exact name
> - * @parent: parent dentry
>   * @dentry: the negative dentry that was passed to the parent's lookup func
> + * @parent: parent dentry
>   * @name:   the case-exact name to be associated with the returned dentry
>   *
>   * Return: true if names are same, or false
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index e676c8b0cf5d..8bbb1ad46335 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -343,8 +343,8 @@ EXPORT_SYMBOL(seq_lseek);
>  
>  /**
>   *	seq_release -	free the structures associated with sequential file.
> - *	@file: file in question
>   *	@inode: its inode
> + *	@file: file in question
>   *
>   *	Frees the structures associated with sequential file; can be used
>   *	as ->f_op->release() if you don't have private data to destroy.
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

