Return-Path: <linux-fsdevel+bounces-63770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE7FBCD7BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A339355EE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166452F548A;
	Fri, 10 Oct 2025 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yr6gpleg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qLPTLh6E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yr6gpleg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qLPTLh6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5B2F5468
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105904; cv=none; b=jVGPLZLSf1T00gGIbtnBYhmGWBlKeXYutT5qPm8cnc/T2jJX0yNX/zn/fnVeJZyExOmtq2XBk0My/3/qSD/xwpFYuRpZ7nsAIlvHmB9aOJ0RwmyeNxnP2fWj+dU6jZJMeFndX0lZW748WvFXy0wKu3V8hkRJhcaOgAowNRg3Acg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105904; c=relaxed/simple;
	bh=Hagf2RwHl0k9Akf0oq35ccyTf9nCbYqIeZchDk+OB6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCo5yVn5CH41XVNFvWZbq+1l+GHmelilgM/RnK1YlU/O3G5o6ssLkVcEDOm2o4EdiFrXL1i0Ad9kzy2pOHtVdynNbFslN9Uv6QeRF3caiKlGmu5qemcyairCmfMVdFmY7lLSjhOp3bHHpYO8XbPXq7ERcu55CKZR0XOhw3a6L4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yr6gpleg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qLPTLh6E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yr6gpleg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qLPTLh6E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 235CE21AF3;
	Fri, 10 Oct 2025 14:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hRwPaws48IueZqWnmH+GwAX5QK/78NH0EE4gdzZj4qk=;
	b=Yr6gplegGwbIx29LM4L4kRBembGuiih5kq/Bwl7oU+TPjuj5PYti0tGvue6kAkQN9TuwBY
	0e9NmS0H39GW1Gqi9fyMRgs+t5D8ZdRvh9O3LWqFEFjdLIZGk9gc7E8AsWWLCdHmdT1lum
	M5FOknELbDOr+d3vGwyywIrsIOkGaYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hRwPaws48IueZqWnmH+GwAX5QK/78NH0EE4gdzZj4qk=;
	b=qLPTLh6EkIVGoW7oiPRwBh9llm/+I2dUzeNIrM8G0le4kc/6jBw8wauav1YcDVGwVQmXoe
	KtHkQpCqtXANJcBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hRwPaws48IueZqWnmH+GwAX5QK/78NH0EE4gdzZj4qk=;
	b=Yr6gplegGwbIx29LM4L4kRBembGuiih5kq/Bwl7oU+TPjuj5PYti0tGvue6kAkQN9TuwBY
	0e9NmS0H39GW1Gqi9fyMRgs+t5D8ZdRvh9O3LWqFEFjdLIZGk9gc7E8AsWWLCdHmdT1lum
	M5FOknELbDOr+d3vGwyywIrsIOkGaYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hRwPaws48IueZqWnmH+GwAX5QK/78NH0EE4gdzZj4qk=;
	b=qLPTLh6EkIVGoW7oiPRwBh9llm/+I2dUzeNIrM8G0le4kc/6jBw8wauav1YcDVGwVQmXoe
	KtHkQpCqtXANJcBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3BBA1375D;
	Fri, 10 Oct 2025 14:18:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NoF+O6sV6WiCDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 14:18:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 21515A28E2; Fri, 10 Oct 2025 16:18:11 +0200 (CEST)
Date: Fri, 10 Oct 2025 16:18:11 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 11/14] overlayfs: use the new ->i_state accessors
Message-ID: <boaeeosplz54nlmr65ifgn2jttxkijonz4amlcl5rpvwldng2w@rx7fblisprpk>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-12-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-12-mjguzik@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 09-10-25 09:59:25, Mateusz Guzik wrote:
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
>  fs/overlayfs/dir.c   |  2 +-
>  fs/overlayfs/inode.c |  6 +++---
>  fs/overlayfs/util.c  | 10 +++++-----
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index a5e9ddf3023b..83b955a1d55c 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -686,7 +686,7 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
>  		goto out_drop_write;
>  
>  	spin_lock(&inode->i_lock);
> -	inode->i_state |= I_CREATING;
> +	inode_state_set(inode, I_CREATING);
>  	spin_unlock(&inode->i_lock);
>  
>  	inode_init_owner(&nop_mnt_idmap, inode, dentry->d_parent->d_inode, mode);
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index aaa4cf579561..b7938dd43b95 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -1149,7 +1149,7 @@ struct inode *ovl_get_trap_inode(struct super_block *sb, struct dentry *dir)
>  	if (!trap)
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (!(trap->i_state & I_NEW)) {
> +	if (!(inode_state_read_once(trap) & I_NEW)) {
>  		/* Conflicting layer roots? */
>  		iput(trap);
>  		return ERR_PTR(-ELOOP);
> @@ -1240,7 +1240,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
>  		inode = ovl_iget5(sb, oip->newinode, key);
>  		if (!inode)
>  			goto out_err;
> -		if (!(inode->i_state & I_NEW)) {
> +		if (!(inode_state_read_once(inode) & I_NEW)) {
>  			/*
>  			 * Verify that the underlying files stored in the inode
>  			 * match those in the dentry.
> @@ -1300,7 +1300,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
>  	if (upperdentry)
>  		ovl_check_protattr(inode, upperdentry);
>  
> -	if (inode->i_state & I_NEW)
> +	if (inode_state_read_once(inode) & I_NEW)
>  		unlock_new_inode(inode);
>  out:
>  	return inode;
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index f76672f2e686..2da1c035f716 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1019,8 +1019,8 @@ bool ovl_inuse_trylock(struct dentry *dentry)
>  	bool locked = false;
>  
>  	spin_lock(&inode->i_lock);
> -	if (!(inode->i_state & I_OVL_INUSE)) {
> -		inode->i_state |= I_OVL_INUSE;
> +	if (!(inode_state_read(inode) & I_OVL_INUSE)) {
> +		inode_state_set(inode, I_OVL_INUSE);
>  		locked = true;
>  	}
>  	spin_unlock(&inode->i_lock);
> @@ -1034,8 +1034,8 @@ void ovl_inuse_unlock(struct dentry *dentry)
>  		struct inode *inode = d_inode(dentry);
>  
>  		spin_lock(&inode->i_lock);
> -		WARN_ON(!(inode->i_state & I_OVL_INUSE));
> -		inode->i_state &= ~I_OVL_INUSE;
> +		WARN_ON(!(inode_state_read(inode) & I_OVL_INUSE));
> +		inode_state_clear(inode, I_OVL_INUSE);
>  		spin_unlock(&inode->i_lock);
>  	}
>  }
> @@ -1046,7 +1046,7 @@ bool ovl_is_inuse(struct dentry *dentry)
>  	bool inuse;
>  
>  	spin_lock(&inode->i_lock);
> -	inuse = (inode->i_state & I_OVL_INUSE);
> +	inuse = (inode_state_read(inode) & I_OVL_INUSE);
>  	spin_unlock(&inode->i_lock);
>  
>  	return inuse;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

