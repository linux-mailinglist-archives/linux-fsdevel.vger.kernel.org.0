Return-Path: <linux-fsdevel+bounces-78707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LMqJ3GBoWnztwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:35:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 539321B6A44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1709430A41F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 11:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C893330642;
	Fri, 27 Feb 2026 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yzNBLfXK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OLWU5ivG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yzNBLfXK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OLWU5ivG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC1B361674
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772192074; cv=none; b=FsLLBx7sjufgk+NEZoFLjf82UwaQee0C2x+b+gs05fIuUVaETvQKNM7JdZ8s0I4fJ8+QcwyeSvkGci7SnuEq7QfjF4lJRDjAw2mitnqsO/ilCzkLVaesxbdpzKKoN5ZuLgUC2wgU45c9RtGhgiFTslstNm60k9P3mpOeLBDD7q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772192074; c=relaxed/simple;
	bh=/DYKZzwiZf7JORlpCwaYSZ4w+lIYmVegY+urJY1I7Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLkr7BybpZ9cOcTqrRuiI6lkqY+Ok9yGVptEc2SP9GiMZGd6VPGXESd408e/ivZKM3riX/q6ZI7SCo+oy2XLIDSsRx0a6nCiRWdyjuR5SjrzxqMn4fipyWfevG5WRLUcOu1WhMXD8eUCkaEzBECNtTNFfCmoYm7mT7AJewuzLmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yzNBLfXK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OLWU5ivG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yzNBLfXK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OLWU5ivG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F4115BDF8;
	Fri, 27 Feb 2026 11:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772192070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcwzK4XVgXogdPbxbbJoSTt0FD2Bb9QBnrGjayGfvZM=;
	b=yzNBLfXK+tYE0mTr6cv5Xc9DRb7sKV/48FxOb3BL6L8gr8/SztQ86e+i75x3i5JU8MIHq+
	Foif2ZfZ2YMDSp0zDP2cwq7GeXar2rH++IeEMIG0IG8EA6XFWp9OniiFoNgqCvn7ZiREVl
	Gr+DUjT3EwrVCHZGW2sYQOAf/MFKpOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772192070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcwzK4XVgXogdPbxbbJoSTt0FD2Bb9QBnrGjayGfvZM=;
	b=OLWU5ivGNUJ4qes+LLrsYb/10z52jI6sC6kltAiVjL01EcSLqvWRQMHNYmXIpO1KtmsG6u
	ntaoFB5s3+I+wpCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yzNBLfXK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OLWU5ivG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772192070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcwzK4XVgXogdPbxbbJoSTt0FD2Bb9QBnrGjayGfvZM=;
	b=yzNBLfXK+tYE0mTr6cv5Xc9DRb7sKV/48FxOb3BL6L8gr8/SztQ86e+i75x3i5JU8MIHq+
	Foif2ZfZ2YMDSp0zDP2cwq7GeXar2rH++IeEMIG0IG8EA6XFWp9OniiFoNgqCvn7ZiREVl
	Gr+DUjT3EwrVCHZGW2sYQOAf/MFKpOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772192070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcwzK4XVgXogdPbxbbJoSTt0FD2Bb9QBnrGjayGfvZM=;
	b=OLWU5ivGNUJ4qes+LLrsYb/10z52jI6sC6kltAiVjL01EcSLqvWRQMHNYmXIpO1KtmsG6u
	ntaoFB5s3+I+wpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 834BF3EA69;
	Fri, 27 Feb 2026 11:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CsECIEaBoWmkLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 11:34:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 40858A06D4; Fri, 27 Feb 2026 12:34:30 +0100 (CET)
Date: Fri, 27 Feb 2026 12:34:30 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	sj1557.seo@samsung.com, yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, anna@kernel.org, 
	jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org, 
	Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v8 01/17] fs: Move file_kattr initialization to callers
Message-ID: <ih3mvucoroudud5l4pndgjxbxfxgcizu2mpli4fhkbnxwufrlm@cyoqgtmvlvpq>
References: <20260217214741.1928576-1-cel@kernel.org>
 <20260217214741.1928576-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217214741.1928576-2-cel@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78707-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 539321B6A44
X-Rspamd-Action: no action

On Tue 17-02-26 16:47:25, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> fileattr_fill_xflags() and fileattr_fill_flags() zero the entire
> file_kattr struct before populating select fields. This behavior
> prevents callers from setting flags in fa->fsx_xflags before
> calling these helpers; the zeroing clears any pre-set values.
> 
> As Darrick Wong observed, when a function named "fill_xflags"
> modifies more than just xflags, filesystems must understand
> implementation details beyond the function's apparent scope. When
> initialization occurs at entry points, helper functions need not
> duplicate that zeroing.
> 
> Move struct file_kattr zero-initialization from the fill functions
> to their callers. Entry points such as ioctl_setflags(),
> ioctl_fssetxattr(), and the file_getattr/file_setattr syscalls
> now perform aggregate initialization directly. The fill functions
> retain their field-setting logic but no longer clear the struct.
> 
> This change enables subsequent patches where filesystem
> ->fileattr_get() handlers can set case-sensitivity flags
> (FS_XFLAG_CASEFOLD, FS_XFLAG_CASENONPRESERVING) in fa->fsx_xflags
> before calling the fill functions.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file_attr.c     | 14 +++++---------
>  fs/xfs/xfs_ioctl.c |  2 +-
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 6d2a298a786d..42aa511111a0 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -15,12 +15,10 @@
>   * @fa:		fileattr pointer
>   * @xflags:	FS_XFLAG_* flags
>   *
> - * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
> - * other fields are zeroed.
> + * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).
>   */
>  void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
>  {
> -	memset(fa, 0, sizeof(*fa));
>  	fa->fsx_valid = true;
>  	fa->fsx_xflags = xflags;
>  	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
> @@ -48,11 +46,9 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
>   * @flags:	FS_*_FL flags
>   *
>   * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
> - * All other fields are zeroed.
>   */
>  void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
>  {
> -	memset(fa, 0, sizeof(*fa));
>  	fa->flags_valid = true;
>  	fa->flags = flags;
>  	if (fa->flags & FS_SYNC_FL)
> @@ -325,7 +321,7 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
>  {
>  	struct mnt_idmap *idmap = file_mnt_idmap(file);
>  	struct dentry *dentry = file->f_path.dentry;
> -	struct file_kattr fa;
> +	struct file_kattr fa = {};
>  	unsigned int flags;
>  	int err;
>  
> @@ -357,7 +353,7 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
>  {
>  	struct mnt_idmap *idmap = file_mnt_idmap(file);
>  	struct dentry *dentry = file->f_path.dentry;
> -	struct file_kattr fa;
> +	struct file_kattr fa = {};
>  	int err;
>  
>  	err = copy_fsxattr_from_user(&fa, argp);
> @@ -378,7 +374,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
>  	struct path filepath __free(path_put) = {};
>  	unsigned int lookup_flags = 0;
>  	struct file_attr fattr;
> -	struct file_kattr fa;
> +	struct file_kattr fa = {};
>  	int error;
>  
>  	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
> @@ -431,7 +427,7 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
>  	struct path filepath __free(path_put) = {};
>  	unsigned int lookup_flags = 0;
>  	struct file_attr fattr;
> -	struct file_kattr fa;
> +	struct file_kattr fa = {};
>  	int error;
>  
>  	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 4eeda4d4e3ab..369555275140 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -498,7 +498,7 @@ xfs_ioc_fsgetxattra(
>  	xfs_inode_t		*ip,
>  	void			__user *arg)
>  {
> -	struct file_kattr	fa;
> +	struct file_kattr	fa = {};
>  
>  	xfs_ilock(ip, XFS_ILOCK_SHARED);
>  	xfs_fill_fsxattr(ip, XFS_ATTR_FORK, &fa);
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

