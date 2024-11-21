Return-Path: <linux-fsdevel+bounces-35437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F8F9D4C6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B6DB26085
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C051D5ADE;
	Thu, 21 Nov 2024 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XmXmOQgp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FBM0+Vkz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XmXmOQgp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FBM0+Vkz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8631D5157;
	Thu, 21 Nov 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190329; cv=none; b=Ms3Q7no7oK65D3FTd9ApmNAaDMWe9q1LztZMVuLiwYzCqFCykDVRQIW1r5fzyA1yIU41/6afwmD4MDhj8ygzAwp1X2Glf1quoHgO9jsMxU5aTLD2qQeGgg6wUerPi2rnoG31bi4p4bFPk8UYEWYKijZEZAKDGKab3uhXr1JEPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190329; c=relaxed/simple;
	bh=hCS4d0t24UBGZHnfwsC+SsdZKUUoJFE8mxC06/F+evo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+ZX4mCTQ4d3VXSRlstV7OSZ6EsYvlylGU79LKrKcaXLcYmttXagIrSp10mesmox0VwIaB6ejmxxINnbzPOY9mx4IMnOYFd8cmsINHHpHjAgomDFSBMUq4IAugjSxUCA/pJxdNObWq7M5rHt/4TzcjBzWx82V4BTMZqVdSCDjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XmXmOQgp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FBM0+Vkz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XmXmOQgp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FBM0+Vkz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE1641F802;
	Thu, 21 Nov 2024 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732190325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GcSWdomwDNDpO7ZSV571broabLlQiL9P5rzLFLnfqRY=;
	b=XmXmOQgpWD4xQdXE9FMcKsQKBYG8zJLyuajze7Z4gOl598dVI1UpiAxaxTTiaF1SjOlAel
	GOMmKrU6n5wqVhV/1/coNQeRF5mO+HVuqXmtu55C3P8xf4Cj6aQeJZFFRzTSZV8b3T1U23
	DfBlAwTeVIjpdQAT66QmQI9j0NNp2Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732190325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GcSWdomwDNDpO7ZSV571broabLlQiL9P5rzLFLnfqRY=;
	b=FBM0+Vkz83qVLdHck2RnXLdkMKgZcY5oLBRsyxUSKPYFGwZFfBDkf3B42K0Yc4iQNFlaWp
	MMnNzk5Zx4GWBMBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732190325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GcSWdomwDNDpO7ZSV571broabLlQiL9P5rzLFLnfqRY=;
	b=XmXmOQgpWD4xQdXE9FMcKsQKBYG8zJLyuajze7Z4gOl598dVI1UpiAxaxTTiaF1SjOlAel
	GOMmKrU6n5wqVhV/1/coNQeRF5mO+HVuqXmtu55C3P8xf4Cj6aQeJZFFRzTSZV8b3T1U23
	DfBlAwTeVIjpdQAT66QmQI9j0NNp2Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732190325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GcSWdomwDNDpO7ZSV571broabLlQiL9P5rzLFLnfqRY=;
	b=FBM0+Vkz83qVLdHck2RnXLdkMKgZcY5oLBRsyxUSKPYFGwZFfBDkf3B42K0Yc4iQNFlaWp
	MMnNzk5Zx4GWBMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C32F613927;
	Thu, 21 Nov 2024 11:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F2uhL3UgP2c7DAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:58:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7BA4AA089E; Thu, 21 Nov 2024 12:58:45 +0100 (CET)
Date: Thu, 21 Nov 2024 12:58:45 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hughd@google.com, linux-ext4@vger.kernel.org, tytso@mit.edu,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] ext4: use inode_set_cached_link()
Message-ID: <20241121115845.5rlrxawr62n4jhke@quack3>
References: <20241120112037.822078-1-mjguzik@gmail.com>
 <20241120112037.822078-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120112037.822078-3-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 20-11-24 12:20:35, Mateusz Guzik wrote:
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 3 ++-
>  fs/ext4/namei.c | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 89aade6f45f6..7c54ae5fcbd4 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5006,10 +5006,11 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  		if (IS_ENCRYPTED(inode)) {
>  			inode->i_op = &ext4_encrypted_symlink_inode_operations;
>  		} else if (ext4_inode_is_fast_symlink(inode)) {
> -			inode->i_link = (char *)ei->i_data;
>  			inode->i_op = &ext4_fast_symlink_inode_operations;
>  			nd_terminate_link(ei->i_data, inode->i_size,
>  				sizeof(ei->i_data) - 1);
> +			inode_set_cached_link(inode, (char *)ei->i_data,
> +					      inode->i_size);
>  		} else {
>  			inode->i_op = &ext4_symlink_inode_operations;
>  		}
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index bcf2737078b8..536d56d15072 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3418,7 +3418,6 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  			inode->i_op = &ext4_symlink_inode_operations;
>  		} else {
>  			inode->i_op = &ext4_fast_symlink_inode_operations;
> -			inode->i_link = (char *)&EXT4_I(inode)->i_data;
>  		}
>  	}
>  
> @@ -3434,6 +3433,9 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  		       disk_link.len);
>  		inode->i_size = disk_link.len - 1;
>  		EXT4_I(inode)->i_disksize = inode->i_size;
> +		if (!IS_ENCRYPTED(inode))
> +			inode_set_cached_link(inode, (char *)&EXT4_I(inode)->i_data,
> +					      inode->i_size);
>  	}
>  	err = ext4_add_nondir(handle, dentry, &inode);
>  	if (handle)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

