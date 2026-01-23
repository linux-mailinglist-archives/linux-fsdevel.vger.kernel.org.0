Return-Path: <linux-fsdevel+bounces-75179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPA7FlfAcmmxpAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:27:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FEA6EC47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29523300692C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F8132255D;
	Fri, 23 Jan 2026 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgUZWjFj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336012BE7D2;
	Fri, 23 Jan 2026 00:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769128008; cv=none; b=G1HRtP9PyNMF4vMqzKi86y9rm63yu78pI1PhVdedtL7guJdRxAYjyvzvpQna11tEofLiylyB634YBtWRvA09HPIX9wGaehaSLuppstuf3rmnOvrcFW+2swWG3Swwji/4ZdL7hu1seDAgXsI0PuTmzRCNjcdhkFvImLGZXixXEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769128008; c=relaxed/simple;
	bh=YfAXxf1cY4mpxIHAXBxlEMPMeobd0tAG5Xh8cUgRe68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slVTnW6cgtkCXYdSERI0lgIzfbvgP10OU8xm6LBxYLvnNLt/jEnAU55dmpQ4S+hCLPbgK1DYPtQ69ievZ+Bf+JCtKkrk4AgbepBoSRovG5ISa/kr+3/prY7UGzX5lKn2q9njaNKM4djlzeIdMtwd0NY5GrHef46g4EPCGgC9yCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgUZWjFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF66C116C6;
	Fri, 23 Jan 2026 00:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769128007;
	bh=YfAXxf1cY4mpxIHAXBxlEMPMeobd0tAG5Xh8cUgRe68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgUZWjFj8UxZ2ChZk6Og6wlP6cNdN3AVy1A3DaINVBfqqudi37G6Ax/h9H4aHnttZ
	 VxxaqJkeguW43TyDiwz3QIb9/AwLqHYIJFQ2S3SUMkcnHV7u1il9CeCyhadfCXIO2W
	 kXCIyEp1UPZusG031b3IWNGqsu/SWAwGjgCP558+XHHMvjhFAsn7A6EsNE0GmPyjF6
	 zg280RvYUHGuhiLYpjOvN4WzN3vB2Mm0o0ph9ZdFEi3YMumUc8b0Y2wwVHk37JjNVm
	 ZrqO6h+yfpWNbWwLGr/XNyxxcAiOqN8b4Flkim1K+Ijqq9bS3unUlg/xh+pZaGgUL3
	 VP2yHzSNVOjGQ==
Date: Thu, 22 Jan 2026 16:26:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org,
	chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 01/16] fs: Add case sensitivity flags to file_kattr
Message-ID: <20260123002646.GL5945@frogsfrogsfrogs>
References: <20260122160311.1117669-1-cel@kernel.org>
 <20260122160311.1117669-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122160311.1117669-2-cel@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75179-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 81FEA6EC47
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:02:56AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Enable upper layers such as NFSD to retrieve case sensitivity
> information from file systems by adding FS_XFLAG_CASEFOLD and
> FS_XFLAG_CASENONPRESERVING flags.
> 
> Filesystems report case-insensitive or case-nonpreserving behavior
> by setting these flags directly in fa->fsx_xflags. The default
> (flags unset) indicates POSIX semantics: case-sensitive and
> case-preserving. These flags are read-only; userspace cannot set
> them via ioctl.
> 
> Remove struct file_kattr initialization from fileattr_fill_xflags()
> and fileattr_fill_flags(). Callers at ioctl/syscall entry points
> zero-initialize the struct themselves, which allows them to pass
> hints (flags_valid, fsx_valid) to the filesystem's ->fileattr_get()
> callback via the fa argument. Filesystem handlers that invoke these
> fill functions can now set flags directly in fa->fsx_xflags before
> calling them, without the fill functions zeroing those values.

In hindsight I regret not asking for the file_kattr initialization
change to be in a separate patch.

> Case sensitivity information is exported to userspace via the
> fa_xflags field in the FS_IOC_FSGETXATTR ioctl and file_getattr()
> system call.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

The UAPI changes still look ok to me.  AFAICT the file_kattr
initialization now seem like they don't zap fields to confuse
vfs_fileattr_get.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/file_attr.c           | 12 ++++--------
>  fs/xfs/xfs_ioctl.c       |  2 +-
>  include/linux/fileattr.h |  3 ++-
>  include/uapi/linux/fs.h  |  2 ++
>  4 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 13cdb31a3e94..6e37040fc5fa 100644
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
> @@ -46,11 +44,9 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
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
> @@ -323,7 +319,7 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
>  {
>  	struct mnt_idmap *idmap = file_mnt_idmap(file);
>  	struct dentry *dentry = file->f_path.dentry;
> -	struct file_kattr fa;
> +	struct file_kattr fa = {};
>  	unsigned int flags;
>  	int err;
>  
> @@ -355,7 +351,7 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
>  {
>  	struct mnt_idmap *idmap = file_mnt_idmap(file);
>  	struct dentry *dentry = file->f_path.dentry;
> -	struct file_kattr fa;
> +	struct file_kattr fa = {};
>  	int err;
>  
>  	err = copy_fsxattr_from_user(&fa, argp);
> @@ -434,7 +430,7 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
>  	struct filename *name __free(putname) = NULL;
>  	unsigned int lookup_flags = 0;
>  	struct file_attr fattr;
> -	struct file_kattr fa;
> +	struct file_kattr fa = {};
>  	int error;
>  
>  	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 59eaad774371..f0417c4d1fca 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -496,7 +496,7 @@ xfs_ioc_fsgetxattra(
>  	xfs_inode_t		*ip,
>  	void			__user *arg)
>  {
> -	struct file_kattr	fa;
> +	struct file_kattr	fa = {};
>  
>  	xfs_ilock(ip, XFS_ILOCK_SHARED);
>  	xfs_fill_fsxattr(ip, XFS_ATTR_FORK, &fa);
> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> index f89dcfad3f8f..709de829659f 100644
> --- a/include/linux/fileattr.h
> +++ b/include/linux/fileattr.h
> @@ -16,7 +16,8 @@
>  
>  /* Read-only inode flags */
>  #define FS_XFLAG_RDONLY_MASK \
> -	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
> +	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | \
> +	 FS_XFLAG_CASEFOLD | FS_XFLAG_CASENONPRESERVING)
>  
>  /* Flags to indicate valid value of fsx_ fields */
>  #define FS_XFLAG_VALUES_MASK \
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 66ca526cf786..919148beaa8c 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -253,6 +253,8 @@ struct file_attr {
>  #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
>  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
>  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
> +#define FS_XFLAG_CASEFOLD	0x00020000	/* case-insensitive lookups */
> +#define FS_XFLAG_CASENONPRESERVING 0x00040000	/* case not preserved */
>  #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
>  
>  /* the read-only stuff doesn't really belong here, but any other place is
> -- 
> 2.52.0
> 
> 

