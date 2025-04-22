Return-Path: <linux-fsdevel+bounces-46907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CB3A96612
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814FA16BAE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 10:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474F91E9B39;
	Tue, 22 Apr 2025 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rJXfKhvt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i09YnLef";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rJXfKhvt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i09YnLef"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123411172A
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318274; cv=none; b=DxbQKFaK5dtAKxm5QPLjVkR032Wx1KireR9aZap+ulSgKLziSpjxOXt0ABT8ZKmNNPSbLrR9YgtVcFJ2MAK5WDO/rphsJrJg8XaXO1qLTiTyHfps/8Ao+EqHSraW+6/6j6J7a0ftaiX7LKDlNq4tXTAmSqxLm+9t+6ihuUl/1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318274; c=relaxed/simple;
	bh=M+T9apoq9N3VhxknGag/mGF0MrKZ0BbmEgpqvDAT8Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6ACh2PfL1Cu3pThQZDJXoTBBZJLQVYglHfzeTY7r7rWJheFloeiH3FgQmUgnECbxBD7mOAvMS1rjH7M4qrJFosQ+N0wBTllpiDi0pPrqdr+jM/KTvMfWJoCKBcK1j37c1sa6zmtWyf+Vzi+J2jWBj9psEod6cHC3U2ax3Y6FuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rJXfKhvt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i09YnLef; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rJXfKhvt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i09YnLef; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F14921172;
	Tue, 22 Apr 2025 10:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745318271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7P5wCM1Fp58MkZOF0RAaVMOBLThDapBzVTf+10Iljpc=;
	b=rJXfKhvtFKZs1dsbconzRZi1uO8TTuMDslPmewEaOaLdxfLApx3jQbx5oGM6Xnbiy6+dk8
	BaT0q34zG2pzFE3cDPRrbXP8Jz+o3+mKPxf/WKOAB7564Nb154O604W7INZiYfnBVMd41o
	QadGhlx+GElx7/6hOECZ3XMrr31phQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745318271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7P5wCM1Fp58MkZOF0RAaVMOBLThDapBzVTf+10Iljpc=;
	b=i09YnLefAJ01lQmaV05+D3o7Lce+WOP8iQMOuJwyf0RSCFlMzbY7d/XZ6Rw1Ky3LuM6HAL
	pa3dOSPOwTrkZnAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745318271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7P5wCM1Fp58MkZOF0RAaVMOBLThDapBzVTf+10Iljpc=;
	b=rJXfKhvtFKZs1dsbconzRZi1uO8TTuMDslPmewEaOaLdxfLApx3jQbx5oGM6Xnbiy6+dk8
	BaT0q34zG2pzFE3cDPRrbXP8Jz+o3+mKPxf/WKOAB7564Nb154O604W7INZiYfnBVMd41o
	QadGhlx+GElx7/6hOECZ3XMrr31phQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745318271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7P5wCM1Fp58MkZOF0RAaVMOBLThDapBzVTf+10Iljpc=;
	b=i09YnLefAJ01lQmaV05+D3o7Lce+WOP8iQMOuJwyf0RSCFlMzbY7d/XZ6Rw1Ky3LuM6HAL
	pa3dOSPOwTrkZnAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01C73137CF;
	Tue, 22 Apr 2025 10:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bnNqAH9xB2i7egAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Apr 2025 10:37:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AAECCA0A56; Tue, 22 Apr 2025 12:37:50 +0200 (CEST)
Date: Tue, 22 Apr 2025 12:37:50 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH RFC 1/3] inode: add fastpath for filesystem user
 namespace retrieval
Message-ID: <mzryrjmph2ws7kprtnxj34xqp4cyhfdwpfnltkx4ziugwdqmu7@f4myyqyrmta3>
References: <20250416-work-mnt_idmap-s_user_ns-v1-0-273bef3a61ec@kernel.org>
 <20250416-work-mnt_idmap-s_user_ns-v1-1-273bef3a61ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-work-mnt_idmap-s_user_ns-v1-1-273bef3a61ec@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,gmail.com,zeniv.linux.org.uk,suse.cz,kernel.org,toxicpanda.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 16-04-25 15:17:22, Christian Brauner wrote:
> We currently always chase a pointer inode->i_sb->s_user_ns whenever we
> need to map a uid/gid which is noticeable during path lookup as noticed
> by Linus in [1]. In the majority of cases we don't need to bother with
> that pointer chase because the inode won't be located on a filesystem
> that's mounted in a user namespace. The user namespace of the superblock
> cannot ever change once it's mounted. So introduce and raise IOP_USERNS
> on all inodes and check for that flag in i_user_ns() when we retrieve
> the user namespace.
> 
> Link: https://lore.kernel.org/CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Some performance numbers would be in place here I guess - in particular
whether this change indeed improved the speed of path lookup or whether the
cost just moved elsewhere. Otherwise the patch looks good so feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/inode.c                    |  6 ++++++
>  fs/mnt_idmapping.c            | 14 --------------
>  include/linux/fs.h            |  5 ++++-
>  include/linux/mnt_idmapping.h | 14 ++++++++++++++
>  4 files changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 99318b157a9a..7335d05dd7d5 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -245,6 +245,8 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
>  		inode->i_opflags |= IOP_XATTR;
>  	if (sb->s_type->fs_flags & FS_MGTIME)
>  		inode->i_opflags |= IOP_MGTIME;
> +	if (unlikely(!initial_idmapping(i_user_ns(inode))))
> +		inode->i_opflags |= IOP_USERNS;
>  	i_uid_write(inode, 0);
>  	i_gid_write(inode, 0);
>  	atomic_set(&inode->i_writecount, 0);
> @@ -1864,6 +1866,10 @@ static void iput_final(struct inode *inode)
>  
>  	WARN_ON(inode->i_state & I_NEW);
>  
> +	/* This is security sensitive so catch missing IOP_USERNS. */
> +	VFS_WARN_ON_ONCE(!initial_idmapping(i_user_ns(inode)) &&
> +			 !(inode->i_opflags & IOP_USERNS));
> +
>  	if (op->drop_inode)
>  		drop = op->drop_inode(inode);
>  	else
> diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> index a37991fdb194..8f7ae908ea16 100644
> --- a/fs/mnt_idmapping.c
> +++ b/fs/mnt_idmapping.c
> @@ -42,20 +42,6 @@ struct mnt_idmap invalid_mnt_idmap = {
>  };
>  EXPORT_SYMBOL_GPL(invalid_mnt_idmap);
>  
> -/**
> - * initial_idmapping - check whether this is the initial mapping
> - * @ns: idmapping to check
> - *
> - * Check whether this is the initial mapping, mapping 0 to 0, 1 to 1,
> - * [...], 1000 to 1000 [...].
> - *
> - * Return: true if this is the initial mapping, false if not.
> - */
> -static inline bool initial_idmapping(const struct user_namespace *ns)
> -{
> -	return ns == &init_user_ns;
> -}
> -
>  /**
>   * make_vfsuid - map a filesystem kuid according to an idmapping
>   * @idmap: the mount's idmapping
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..d28384d5b752 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -663,6 +663,7 @@ is_uncached_acl(struct posix_acl *acl)
>  #define IOP_DEFAULT_READLINK	0x0010
>  #define IOP_MGTIME	0x0020
>  #define IOP_CACHED_LINK	0x0040
> +#define IOP_USERNS	0x0080
>  
>  /*
>   * Keep mostly read-only and often accessed (especially for
> @@ -1454,7 +1455,9 @@ struct super_block {
>  
>  static inline struct user_namespace *i_user_ns(const struct inode *inode)
>  {
> -	return inode->i_sb->s_user_ns;
> +	if (unlikely(inode->i_opflags & IOP_USERNS))
> +		return inode->i_sb->s_user_ns;
> +	return &init_user_ns;
>  }
>  
>  /* Helper functions so that in most cases filesystems will
> diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
> index e71a6070a8f8..85553b3a7904 100644
> --- a/include/linux/mnt_idmapping.h
> +++ b/include/linux/mnt_idmapping.h
> @@ -25,6 +25,20 @@ static_assert(sizeof(vfsgid_t) == sizeof(kgid_t));
>  static_assert(offsetof(vfsuid_t, val) == offsetof(kuid_t, val));
>  static_assert(offsetof(vfsgid_t, val) == offsetof(kgid_t, val));
>  
> +/**
> + * initial_idmapping - check whether this is the initial mapping
> + * @ns: idmapping to check
> + *
> + * Check whether this is the initial mapping, mapping 0 to 0, 1 to 1,
> + * [...], 1000 to 1000 [...].
> + *
> + * Return: true if this is the initial mapping, false if not.
> + */
> +static inline bool initial_idmapping(const struct user_namespace *ns)
> +{
> +	return ns == &init_user_ns;
> +}
> +
>  static inline bool is_valid_mnt_idmap(const struct mnt_idmap *idmap)
>  {
>  	return idmap != &nop_mnt_idmap && idmap != &invalid_mnt_idmap;
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

