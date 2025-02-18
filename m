Return-Path: <linux-fsdevel+bounces-41990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC40A39C0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 13:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85E5188FC00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A764241C80;
	Tue, 18 Feb 2025 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="va0WAio6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uhgYou0M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="va0WAio6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uhgYou0M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281810F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881261; cv=none; b=i9/XuQ0ExeCeHD+rs8ycxd/0GfvMBYxuVvpXb5AhMYdv1Toeje4xxRW3JcZICoFEgsWEBx8LkjQcwMnKsGMCp7gg6S7I9JCOqU7ENxHIRx4GfFntHs01Cl26gj87mrjxenVRjND5gdepw58gh86WojAPU3Emu+dtX6IkvN7oQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881261; c=relaxed/simple;
	bh=bds0z1Ps8lHCjN8PZJSpJtGwlL50yPWSJgoePSjKqIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbj3z4zVLB0mmC3DbjXW4ULWEVvC4FgNpVet3vyYuPds2ntElu7/YhpVM+s+/on+XA+uvS/jL8uf1EIz2v30qCqsD0l9nuOTpFN9ZOThuQixZCCnKDD3yrDnjjArR88i+k+MmheXGXC8qcsOAh/B4V/IjsLFJTLfS/Gx+7keyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=va0WAio6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uhgYou0M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=va0WAio6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uhgYou0M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F1901F442;
	Tue, 18 Feb 2025 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739881258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=32YxdVv/MFw34rijN0IiQG58J9aBNTWTnlrh5qWUaug=;
	b=va0WAio6OYEndVRlVk7JN2jufbVjz92ge/kh5NK0NK72yPEQWjQY27jjU0l7zD4hb2vvdK
	MLoK1FTMd/WvNJ3jLp0/mTCl9vGaM0x4Qyv7Qvc3tjW0mnbEkeB4rn2uKxkrcfWrmadc4i
	+aXcQ7krT4BVnaVJ2F3Ox8LhB7ef1FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739881258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=32YxdVv/MFw34rijN0IiQG58J9aBNTWTnlrh5qWUaug=;
	b=uhgYou0MiExwK9OHdDE5PuXs/+zZlfCn2FPOvEtzu5IWoWfb4as/89ElPijnIanJrSbZql
	YLdLCHFYxBsSzKBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739881258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=32YxdVv/MFw34rijN0IiQG58J9aBNTWTnlrh5qWUaug=;
	b=va0WAio6OYEndVRlVk7JN2jufbVjz92ge/kh5NK0NK72yPEQWjQY27jjU0l7zD4hb2vvdK
	MLoK1FTMd/WvNJ3jLp0/mTCl9vGaM0x4Qyv7Qvc3tjW0mnbEkeB4rn2uKxkrcfWrmadc4i
	+aXcQ7krT4BVnaVJ2F3Ox8LhB7ef1FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739881258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=32YxdVv/MFw34rijN0IiQG58J9aBNTWTnlrh5qWUaug=;
	b=uhgYou0MiExwK9OHdDE5PuXs/+zZlfCn2FPOvEtzu5IWoWfb4as/89ElPijnIanJrSbZql
	YLdLCHFYxBsSzKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A78E132C7;
	Tue, 18 Feb 2025 12:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XRZADip7tGcdNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 18 Feb 2025 12:20:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E8B8FA08B5; Tue, 18 Feb 2025 13:20:57 +0100 (CET)
Date: Tue, 18 Feb 2025 13:20:57 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Change inode_operations.mkdir to return struct
 dentry *
Message-ID: <twielfhtttexj7gnhzkfm4eygx4avot4xaw63nv4winm6rjfqz@674juh7cylku>
References: <20250217053727.3368579-1-neilb@suse.de>
 <20250217053727.3368579-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217053727.3368579-2-neilb@suse.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 17-02-25 16:30:03, NeilBrown wrote:
> Some filesystems, such as NFS, cifs, ceph, and fuse, do not have
> complete control of sequencing on the actual filesystem (e.g.  on a
> different server) and may find that the inode created for a mkdir
> request already exists in the icache and dcache by the time the mkdir
> request returns.  For example, if the filesystem is mounted twice the
> file could be visible on the other mount before it is on the original
> mount, and a pair of name_to_handle_at(), open_by_handle_at() could
> instantiate the directory inode with an IS_ROOT() dentry before the
> first mkdir returns.
> 
> This means that the dentry passed to ->mkdir() may not be the one that
> is associated with the inode after the ->mkdir() completes.  Some
> callers need to interact with the inode after the ->mkdir completes and
> they currently need to perform a lookup in the (rare) case that the
> dentry is no longer hashed.
> 
> This lookup-after-mkdir requires that the directory remains locked to
> avoid races.  Planned future patches to lock the dentry rather than the
> directory will mean that this lookup cannot be performed atomically with
> the mkdir.
> 
> To remove this barrier, this patch changes ->mkdir to return the
> resulting dentry if it is different from the one passed in.
> Possible returns are:
>   NULL - the directory was created and no other dentry was used
>   ERR_PTR() - an error occurred
>   non-NULL - this other dentry was spliced in
> 
> Not all filesystems reliable result in a positive hashed dentry:
> 
> - NFS does produce the proper dentry, but does not yet return it.  The
>   code change is larger than I wanted to include in this patch
> - cifs will, when posix extensions are enabled,  unhash the
>   dentry on success so a subsequent lookup  will create it if needed.
> - cifs without posix extensions will unhash the dentry if an
>   internal lookup finds a non-directory where it expected the dir.
> - kernfs and tracefs leave the dentry negative and the ->revalidate
>   operation ensures that lookup will be called to correctly populate
>   the dentry
> - hostfs leaves the dentry negative and uses
>      .d_delete = always_delete_dentry
>   so the negative dentry is quickly discarded and a lookup will add a
>   new entry.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Looks good to me. I've spotted just a few style nits:

> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 31eea688609a..bd3751dfddcf 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -562,7 +562,10 @@ otherwise noted.
>  ``mkdir``
>  	called by the mkdir(2) system call.  Only required if you want
>  	to support creating subdirectories.  You will probably need to
> -	call d_instantiate() just as you would in the create() method
> +	call d_instantiate() just as you would in the create() method.
> +	If some dentry other than the one given is spliced in, then it
> +	much be returned, otherwise NULL is returned is the original dentry
        ^^^^ must

> +	is successfully used, else an ERR_PTR() is returned.
>  
>  ``rmdir``
>  	called by the rmdir(2) system call.  Only required if you want

...

> @@ -918,6 +922,7 @@ static int fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	args.in_args[1].size = entry->d_name.len + 1;
>  	args.in_args[1].value = entry->d_name.name;
>  	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
> +

Bogus empty line here.

>  }
>  
>  static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,

...

> @@ -4313,10 +4314,17 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	if (max_links && dir->i_nlink >= max_links)
>  		return -EMLINK;
>  
> -	error = dir->i_op->mkdir(idmap, dir, dentry, mode);
> -	if (!error)
> +	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
> +	if (IS_ERR(de))
> +		return PTR_ERR(de);
> +	if (de) {
> +		fsnotify_mkdir(dir, de);
> +		/* Cannot return de yet */
> +		dput(de);
> +	} else
>  		fsnotify_mkdir(dir, dentry);

The prefered style is:
	} else {
  		fsnotify_mkdir(dir, dentry);
	}

Otherwise the patch looks good to me at least for the VFS bits and the
filesystems I understand like ext2, ext4, ocfs2, udf. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

