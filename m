Return-Path: <linux-fsdevel+bounces-67645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247BBC45A7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96C2188447D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668862FFDFA;
	Mon, 10 Nov 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gVuUHJQH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h4fGrzxO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gVuUHJQH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h4fGrzxO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D78288513
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767161; cv=none; b=jvNwSSI0DKTN/5UX/wj0TIHnuF5PcARFnJH/ntSEGTclsOob897OdAqvpcQwwNTa51i/XopE7RKtCYdPfulhZacPIy3TjhyWdl16/VDsW8NdLsLO9a+crmyliAtsIll2z+WXfI5pR7Jw9u4K4/chGIfzCPF3ZRo3tmQdUJ25A50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767161; c=relaxed/simple;
	bh=7hbXW0FSpzvsRZIz/+hPE1FdSHXb4N+2bP9835gVzhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTH2sAUQaB/EKE+8eEsFNmUuUsFRDfFk+s9YroomEnlV26s3K096CmGkU49kc0Ezk4dMCmbhXg3Ado2A022B0HZBv5mD57xzH0f//R4tO8MGJkdTBp15uxvtbXfhNMx7naZtbf6MjB+/z5LB2IG0gRTDtbKc011GYSbKJXf+THY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gVuUHJQH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h4fGrzxO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gVuUHJQH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h4fGrzxO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE7751F397;
	Mon, 10 Nov 2025 09:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762767151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvGKfJ1HNUvIhpALd9hXLro+NefA36B4ILvuVBGUeHo=;
	b=gVuUHJQHD4mpH/CELdGOYG46YbCkzAxPTkE7AYVoCmvrSye69k2/Sxb4/JQKCbeFHjpMjK
	ZtpLKjnfQ7a43GRXx2ugxauZ58kLKxSj25ZA+da68T8zFr/7AGPH9XRrhVHBVtR7AOxdRk
	BEvwnCMy/K8jsb1vdXfPjrkiqJ4jmR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762767151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvGKfJ1HNUvIhpALd9hXLro+NefA36B4ILvuVBGUeHo=;
	b=h4fGrzxOjucmfUawUImMK1trx7NPH4jnGfhhrcFTjlqRD6oQvCDnotVSLBJ2o/EOas4TuM
	Zom3VL999AL7W3BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762767151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvGKfJ1HNUvIhpALd9hXLro+NefA36B4ILvuVBGUeHo=;
	b=gVuUHJQHD4mpH/CELdGOYG46YbCkzAxPTkE7AYVoCmvrSye69k2/Sxb4/JQKCbeFHjpMjK
	ZtpLKjnfQ7a43GRXx2ugxauZ58kLKxSj25ZA+da68T8zFr/7AGPH9XRrhVHBVtR7AOxdRk
	BEvwnCMy/K8jsb1vdXfPjrkiqJ4jmR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762767151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvGKfJ1HNUvIhpALd9hXLro+NefA36B4ILvuVBGUeHo=;
	b=h4fGrzxOjucmfUawUImMK1trx7NPH4jnGfhhrcFTjlqRD6oQvCDnotVSLBJ2o/EOas4TuM
	Zom3VL999AL7W3BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACC3213BF3;
	Mon, 10 Nov 2025 09:32:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IQQnKi+xEWmwbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 09:32:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4893FA28B1; Mon, 10 Nov 2025 10:32:31 +0100 (CET)
Date: Mon, 10 Nov 2025 10:32:31 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	tytso@mit.edu, torvalds@linux-foundation.org, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] fs: speed up path lookup with cheaper handling of
 MAY_EXEC
Message-ID: <qfoni4sufho6ruxsuxvcwnw4xryptydtt3wimsflf7kwfcortf@372gbykgkctf>
References: <20251107142149.989998-1-mjguzik@gmail.com>
 <20251107142149.989998-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107142149.989998-2-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri 07-11-25 15:21:47, Mateusz Guzik wrote:
> The generic inode_permission() routine does work which is known to be of
> no significance for lookup. There are checks for MAY_WRITE, while the
> requested permission is MAY_EXEC. Additionally devcgroup_inode_permission()
> is called to check for devices, but it is an invariant the inode is a
> directory.
> 
> Absent a ->permission func, execution lands in generic_permission()
> which checks upfront if the requested permission is granted for
> everyone.
> 
> We can elide the branches which are guaranteed to be false and cut
> straight to the check if everyone happens to be allowed MAY_EXEC on the
> inode (which holds true most of the time).
> 
> Moreover, filesystems which provide their own ->permission routine can
> take advantage of the optimization by setting the IOP_FASTPERM_MAY_EXEC
> flag on their inodes, which they can legitimately do if their MAY_EXEC
> handling matches generic_permission().
> 
> As a simple benchmark, as part of compilation gcc issues access(2) on
> numerous long paths, for example /usr/lib/gcc/x86_64-linux-gnu/12/crtendS.o
> 
> Issuing access(2) on it in a loop on ext4 on Sapphire Rapids (ops/s):
> before: 3797556
> after:  3987789 (+5%)
> 
> Note: this depends on the not-yet-landed ext4 patch to mark inodes with
> cache_no_acl()
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

The gain is nice. I'm just wondering where exactly is it coming from? I
don't see that we'd be saving some memory load or significant amount of
work. So is it really coming from the more compact code and saved several
unlikely branches and function calls?

								Honza

> ---
>  fs/namei.c         | 43 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/fs.h | 13 +++++++------
>  2 files changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index a9f9d0453425..6b2a5a5478e7 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -540,6 +540,9 @@ static inline int do_inode_permission(struct mnt_idmap *idmap,
>   * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
>   *
>   * Separate out file-system wide checks from inode-specific permission checks.
> + *
> + * Note: lookup_inode_permission_may_exec() does not call here. If you add
> + * MAY_EXEC checks, adjust it.
>   */
>  static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
>  {
> @@ -602,6 +605,42 @@ int inode_permission(struct mnt_idmap *idmap,
>  }
>  EXPORT_SYMBOL(inode_permission);
>  
> +/**
> + * lookup_inode_permission_may_exec - Check traversal right for given inode
> + *
> + * This is a special case routine for may_lookup() making assumptions specific
> + * to path traversal. Use inode_permission() if you are doing something else.
> + *
> + * Work is shaved off compared to inode_permission() as follows:
> + * - we know for a fact there is no MAY_WRITE to worry about
> + * - it is an invariant the inode is a directory
> + *
> + * Since majority of real-world traversal happens on inodes which grant it for
> + * everyone, we check it upfront and only resort to more expensive work if it
> + * fails.
> + *
> + * Filesystems which have their own ->permission hook and consequently miss out
> + * on IOP_FASTPERM can still get the optimization if they set IOP_FASTPERM_MAY_EXEC
> + * on their directory inodes.
> + */
> +static __always_inline int lookup_inode_permission_may_exec(struct mnt_idmap *idmap,
> +	struct inode *inode, int mask)
> +{
> +	/* Lookup already checked this to return -ENOTDIR */
> +	VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode), inode);
> +	VFS_BUG_ON((mask & ~MAY_NOT_BLOCK) != 0);
> +
> +	mask |= MAY_EXEC;
> +
> +	if (unlikely(!(inode->i_opflags & (IOP_FASTPERM | IOP_FASTPERM_MAY_EXEC))))
> +		return inode_permission(idmap, inode, mask);
> +
> +	if (unlikely(((inode->i_mode & 0111) != 0111) || !no_acl_inode(inode)))
> +		return inode_permission(idmap, inode, mask);
> +
> +	return security_inode_permission(inode, mask);
> +}
> +
>  /**
>   * path_get - get a reference to a path
>   * @path: path to get the reference to
> @@ -1855,7 +1894,7 @@ static inline int may_lookup(struct mnt_idmap *idmap,
>  	int err, mask;
>  
>  	mask = nd->flags & LOOKUP_RCU ? MAY_NOT_BLOCK : 0;
> -	err = inode_permission(idmap, nd->inode, mask | MAY_EXEC);
> +	err = lookup_inode_permission_may_exec(idmap, nd->inode, mask);
>  	if (likely(!err))
>  		return 0;
>  
> @@ -1870,7 +1909,7 @@ static inline int may_lookup(struct mnt_idmap *idmap,
>  	if (err != -ECHILD)	// hard error
>  		return err;
>  
> -	return inode_permission(idmap, nd->inode, MAY_EXEC);
> +	return lookup_inode_permission_may_exec(idmap, nd->inode, 0);
>  }
>  
>  static int reserve_stack(struct nameidata *nd, struct path *link)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 03e450dd5211..7d5de647ac7b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -647,13 +647,14 @@ is_uncached_acl(struct posix_acl *acl)
>  	return (long)acl & 1;
>  }
>  
> -#define IOP_FASTPERM	0x0001
> -#define IOP_LOOKUP	0x0002
> -#define IOP_NOFOLLOW	0x0004
> -#define IOP_XATTR	0x0008
> +#define IOP_FASTPERM		0x0001
> +#define IOP_LOOKUP		0x0002
> +#define IOP_NOFOLLOW		0x0004
> +#define IOP_XATTR		0x0008
>  #define IOP_DEFAULT_READLINK	0x0010
> -#define IOP_MGTIME	0x0020
> -#define IOP_CACHED_LINK	0x0040
> +#define IOP_MGTIME		0x0020
> +#define IOP_CACHED_LINK		0x0040
> +#define IOP_FASTPERM_MAY_EXEC	0x0080
>  
>  /*
>   * Inode state bits.  Protected by inode->i_lock
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

