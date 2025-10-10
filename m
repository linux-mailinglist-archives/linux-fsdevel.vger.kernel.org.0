Return-Path: <linux-fsdevel+bounces-63765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C442BCD6BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E6F3B72CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E3A2F7462;
	Fri, 10 Oct 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E9mPsN2Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1/gLeijh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J2iI3jL7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rNeY6Tjj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C72F3C12
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105501; cv=none; b=onFo2PO8iBO/o/QR8Hgrbqrd7qrScF2KJ//FcQLv4Fa+rXqNyRdSaxVb3yFXJ48j5AEJHZoWAaKFcUtRzBJL4uhATE5sEymieqk98KhXQuARvgcc3AVa3Qm26HuCbmIIxqry6yi0K1TWpNetvYYIlb9XK1DqC6W0rtoOVsUzgUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105501; c=relaxed/simple;
	bh=VdgRS9sXkpX+yIn9B6tsZ5IjxQcYxolhN07Ecu1i2FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPxwyzoYGPTnqgJ9s7Kauh8kK0ik2Oao00PaNycVsGUAAl624/7VPwpPhcxSfiozmaTqRaWjG7741/p/hINUjkzQIPbgQ0nVGx21+D+Y121CxntPh/HpfiqlhHk1hNa3+ZwY54JY+Rh5iLZZ07RLeAsWzMZ/FZR5FfQmxlKzsmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E9mPsN2Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1/gLeijh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J2iI3jL7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rNeY6Tjj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 059DC21C67;
	Fri, 10 Oct 2025 14:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gluqjOXke3auOK5xmT0F+5ItRmuROnA6uF+vxRj7BGM=;
	b=E9mPsN2QSf5QrkYU/Nj7Hyw/Yod8+NirXPjg0s8AR3pYs2HXL+WM9vmwGUkSBKqzawleRT
	ua3tIi1VNMYb6Nj1J2ucGugb5Z9mXh9ogVh/OMroyfYzeZoK43oSaXJd2SwUusO95Gwnyp
	R7Dfz6xVw6DBOtBAlYoxLjxQU2lcbsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gluqjOXke3auOK5xmT0F+5ItRmuROnA6uF+vxRj7BGM=;
	b=1/gLeijh3LCN4fuCRaH6FMJm8eukHA4TztUieATNdpV0NQ5fMcX3IkS3cR3EKObfbHFgKK
	WjmyqcH5cSmkYQDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gluqjOXke3auOK5xmT0F+5ItRmuROnA6uF+vxRj7BGM=;
	b=J2iI3jL7rtHDqjPUSYfT8z5BI0ztKjcbVhxKsU+YifOHtrHYonxJRmcfPTp6v7VCnedZCq
	jKw+MfXn8DNbYQ76yJypQuHfEt47alSKQaUVJcpbhjiXL7R2AAPS1AAXtEiWjrz4X2jRdm
	E6Sduw9lkMD8yzwATQVR51mKd08MNQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gluqjOXke3auOK5xmT0F+5ItRmuROnA6uF+vxRj7BGM=;
	b=rNeY6Tjj1HJipj9ELI4Vs4pPmCiuHFITyb8dnzxMgDbiEyvPsqIEMlkpKdFSMxLsBejjVq
	HpiZ5KFt4Hz5eSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E00511375D;
	Fri, 10 Oct 2025 14:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FDejNhcU6WgZBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 14:11:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6803FA0A58; Fri, 10 Oct 2025 16:11:35 +0200 (CEST)
Date: Fri, 10 Oct 2025 16:11:35 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 06/14] btrfs: use the new ->i_state accessors
Message-ID: <vcpzljbky5iumhvwawj4aax5mpkmdhwy3qd36u5f3dm4way36c@woucily2haih>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-7-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-7-mjguzik@gmail.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 09-10-25 09:59:20, Mateusz Guzik wrote:
> Change generated with coccinelle and fixed up by hand as appropriate.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> cheat sheet:
> 
> If ->i_lock is held, then:
> 
> state = inode->i_state          => state = inode_state_read(inode)
> inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
> inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
> inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)
> 
> If ->i_lock is not held or only held conditionally:
> 
> state = inode->i_state          => state = inode_state_read_once(inode)
> inode->i_state |= (I_A | I_B)   => inode_state_set_raw(inode, I_A | I_B)
> inode->i_state &= ~(I_A | I_B)  => inode_state_clear_raw(inode, I_A | I_B)
> inode->i_state = I_A | I_B      => inode_state_assign_raw(inode, I_A | I_B)
> 
>  fs/btrfs/inode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3b1b3a0553ee..433ffe231546 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3884,7 +3884,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
>  		ASSERT(ret != -ENOMEM);
>  		return ret;
>  	} else if (existing) {
> -		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
> +		WARN_ON(!(inode_state_read_once(&existing->vfs_inode) & (I_WILL_FREE | I_FREEING)));
>  	}
>  
>  	return 0;
> @@ -5361,7 +5361,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
>  	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
>  	struct rb_node *node;
>  
> -	ASSERT(inode->i_state & I_FREEING);
> +	ASSERT(inode_state_read_once(inode) & I_FREEING);
>  	truncate_inode_pages_final(&inode->i_data);
>  
>  	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
> @@ -5799,7 +5799,7 @@ struct btrfs_inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (!(inode->vfs_inode.i_state & I_NEW))
> +	if (!(inode_state_read_once(&inode->vfs_inode) & I_NEW))
>  		return inode;
>  
>  	ret = btrfs_read_locked_inode(inode, path);
> @@ -5823,7 +5823,7 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (!(inode->vfs_inode.i_state & I_NEW))
> +	if (!(inode_state_read_once(&inode->vfs_inode) & I_NEW))
>  		return inode;
>  
>  	path = btrfs_alloc_path();
> @@ -7480,7 +7480,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
>  	u64 page_start = folio_pos(folio);
>  	u64 page_end = page_start + folio_size(folio) - 1;
>  	u64 cur;
> -	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
> +	int inode_evicting = inode_state_read_once(&inode->vfs_inode) & I_FREEING;
>  
>  	/*
>  	 * We have folio locked so no new ordered extent can be created on this
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

