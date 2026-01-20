Return-Path: <linux-fsdevel+bounces-74753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBbGBc0McGlyUwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:16:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0474DA28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD6EC96A2FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43BD3B8D68;
	Tue, 20 Jan 2026 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUvSfOG5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990333D6D2;
	Tue, 20 Jan 2026 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949900; cv=none; b=abf7RL0Ppn2pOjQezdrHBMt3mzExE/2GPWC8amcY+BRGBISSvZz52ETewBye2tps3pPyKKTmyPvl1ZnlDXO6PH8ykcD03x/Zb7W0+Bafscd0jFMQOqHAY7s5hlCdIwMJ1z5txmVeLnodkLdEvBkZwCi4QzufelmRs986EOY4LJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949900; c=relaxed/simple;
	bh=kKWYYJQH5itMruE7hjik+GQTPIeWrZ5RzReTzPA+rZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGXEqnNang+yu2C74oeHjB7oxRV/UAN4MGId4VhYSkl+kFTB2UBO0sdVl2NsJy0hzyXfjV1fzdjH5gkAcPaZf0TgX80dKeVi3j4k6JpfyDEShVLIsPAFrNGgf4y35MRpN9FrfebCIIzkA7PnUQsLKjcOeYdQBYBb4XVxwJapQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUvSfOG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B300EC16AAE;
	Tue, 20 Jan 2026 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768949899;
	bh=kKWYYJQH5itMruE7hjik+GQTPIeWrZ5RzReTzPA+rZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUvSfOG5tvf6jLGLVv6hM4pti40FUvuR4Irx5dceHrYWFAbxIS5aJWI5JFliaC2Hd
	 uYEmdNU8C13cAFHZcCQC29QS5iu6V6I468yw5osqZ1+lvxwbSyUk3xtU8XUT8h+KaK
	 wwC15/XdVbK6APJcvCo6kjyoGmo+BhBf6hkPSjukdvH1QJFzwuQ7vsE2BPlyfYbMLC
	 SlpjrZSzZWzmQY8/DWsW8LaNtInuPnA4tuiK8gGM00jtfkOU6yw9d40Y+fhN+7jgi7
	 HCwKnJtK4+NspA9Cb4+kuqIqogkWY4YghHeTTxsVZV2fcgonQOq02KMhdsp2SCOrNc
	 yDOM6LiXEmPGA==
Date: Tue, 20 Jan 2026 14:58:19 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	almaz.alexandrovich@paragon-software.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	Theodore Tso <tytso@mit.edu>, adilger.kernel@dilger.ca,
	Carlos Maiolino <cem@kernel.org>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Hans de Goede <hansg@kernel.org>,
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v6 01/16] fs: Add case sensitivity flags to file_kattr
Message-ID: <20260120225819.GA15551@frogsfrogsfrogs>
References: <20260120142439.1821554-1-cel@kernel.org>
 <20260120142439.1821554-2-cel@kernel.org>
 <20260120172608.GQ15551@frogsfrogsfrogs>
 <38bf1452-8cf8-477b-bcc3-9fe442033bc5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38bf1452-8cf8-477b-bcc3-9fe442033bc5@app.fastmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74753-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: AC0474DA28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[uapi change, so add linux-api]

On Tue, Jan 20, 2026 at 04:48:31PM -0500, Chuck Lever wrote:
> 
> 
> On Tue, Jan 20, 2026, at 12:26 PM, Darrick J. Wong wrote:
> > On Tue, Jan 20, 2026 at 09:24:24AM -0500, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> 
> >> Enable upper layers such as NFSD to retrieve case sensitivity
> >> information from file systems by adding FS_XFLAG_CASEFOLD and
> >> FS_XFLAG_CASENONPRESERVING flags.
> >> 
> >> Filesystems report case-insensitive or case-nonpreserving behavior
> >> by setting these flags directly in fa->fsx_xflags. The default
> >> (flags unset) indicates POSIX semantics: case-sensitive and
> >> case-preserving. These flags are read-only; userspace cannot set
> >> them via ioctl.
> >> 
> >> Relocate struct file_kattr initialization from fileattr_fill_xflags()
> >> and fileattr_fill_flags() to vfs_fileattr_get() and the ioctl/syscall
> >> call sites. This allows filesystem ->fileattr_get() callbacks to set
> >> flags directly in fa->fsx_xflags before invoking the fill functions,
> >> which previously would have zeroed those values. Callers that bypass
> >> vfs_fileattr_get() must now zero-initialize the struct themselves.
> >> 
> >> Case sensitivity information is exported to userspace via the
> >> fa_xflags field in the FS_IOC_FSGETXATTR ioctl and file_getattr()
> >> system call.
> >> 
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>  fs/file_attr.c           | 14 ++++++--------
> >>  fs/xfs/xfs_ioctl.c       |  2 +-
> >>  include/linux/fileattr.h |  3 ++-
> >>  include/uapi/linux/fs.h  |  2 ++
> >
> > This ought to go to linux-api because you're changing the userspace api.
> > Granted it's only adding a flag definition to an existing ioctl, but
> > FS_XFLAG_CASEFOLD /does/ collide with Andrey's fsverity xflag patch...
> >
> > (The rest of the changes looks ok to me.)
> 
> Process question for Christian: Do you want to see a v7 of this
> series with Cc: linux-api before proceeding, or are you taking
> both Andrey's and mine and can resolve the conflict, or ... ?

Well now that I've griped at both patchsets on the same public list,
I'll at least chime in that I'd be satisfied if whoever decides to merge
them to fix up the conflicts whenever they merge them. :)

--D

> 
> > --D
> >
> >>  4 files changed, 11 insertions(+), 10 deletions(-)
> >> 
> >> diff --git a/fs/file_attr.c b/fs/file_attr.c
> >> index 13cdb31a3e94..2700200c5b9c 100644
> >> --- a/fs/file_attr.c
> >> +++ b/fs/file_attr.c
> >> @@ -15,12 +15,10 @@
> >>   * @fa:		fileattr pointer
> >>   * @xflags:	FS_XFLAG_* flags
> >>   *
> >> - * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
> >> - * other fields are zeroed.
> >> + * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).
> >>   */
> >>  void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
> >>  {
> >> -	memset(fa, 0, sizeof(*fa));
> >>  	fa->fsx_valid = true;
> >>  	fa->fsx_xflags = xflags;
> >>  	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
> >> @@ -46,11 +44,9 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
> >>   * @flags:	FS_*_FL flags
> >>   *
> >>   * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
> >> - * All other fields are zeroed.
> >>   */
> >>  void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
> >>  {
> >> -	memset(fa, 0, sizeof(*fa));
> >>  	fa->flags_valid = true;
> >>  	fa->flags = flags;
> >>  	if (fa->flags & FS_SYNC_FL)
> >> @@ -84,6 +80,8 @@ int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
> >>  	struct inode *inode = d_inode(dentry);
> >>  	int error;
> >>  
> >> +	memset(fa, 0, sizeof(*fa));
> >> +
> >>  	if (!inode->i_op->fileattr_get)
> >>  		return -ENOIOCTLCMD;
> >>  
> >> @@ -323,7 +321,7 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
> >>  {
> >>  	struct mnt_idmap *idmap = file_mnt_idmap(file);
> >>  	struct dentry *dentry = file->f_path.dentry;
> >> -	struct file_kattr fa;
> >> +	struct file_kattr fa = {};
> >>  	unsigned int flags;
> >>  	int err;
> >>  
> >> @@ -355,7 +353,7 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
> >>  {
> >>  	struct mnt_idmap *idmap = file_mnt_idmap(file);
> >>  	struct dentry *dentry = file->f_path.dentry;
> >> -	struct file_kattr fa;
> >> +	struct file_kattr fa = {};
> >>  	int err;
> >>  
> >>  	err = copy_fsxattr_from_user(&fa, argp);
> >> @@ -434,7 +432,7 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
> >>  	struct filename *name __free(putname) = NULL;
> >>  	unsigned int lookup_flags = 0;
> >>  	struct file_attr fattr;
> >> -	struct file_kattr fa;
> >> +	struct file_kattr fa = {};
> >>  	int error;
> >>  
> >>  	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
> >> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> >> index 59eaad774371..f0417c4d1fca 100644
> >> --- a/fs/xfs/xfs_ioctl.c
> >> +++ b/fs/xfs/xfs_ioctl.c
> >> @@ -496,7 +496,7 @@ xfs_ioc_fsgetxattra(
> >>  	xfs_inode_t		*ip,
> >>  	void			__user *arg)
> >>  {
> >> -	struct file_kattr	fa;
> >> +	struct file_kattr	fa = {};
> >>  
> >>  	xfs_ilock(ip, XFS_ILOCK_SHARED);
> >>  	xfs_fill_fsxattr(ip, XFS_ATTR_FORK, &fa);
> >> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> >> index f89dcfad3f8f..709de829659f 100644
> >> --- a/include/linux/fileattr.h
> >> +++ b/include/linux/fileattr.h
> >> @@ -16,7 +16,8 @@
> >>  
> >>  /* Read-only inode flags */
> >>  #define FS_XFLAG_RDONLY_MASK \
> >> -	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
> >> +	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | \
> >> +	 FS_XFLAG_CASEFOLD | FS_XFLAG_CASENONPRESERVING)
> >>  
> >>  /* Flags to indicate valid value of fsx_ fields */
> >>  #define FS_XFLAG_VALUES_MASK \
> >> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> >> index 66ca526cf786..919148beaa8c 100644
> >> --- a/include/uapi/linux/fs.h
> >> +++ b/include/uapi/linux/fs.h
> >> @@ -253,6 +253,8 @@ struct file_attr {
> >>  #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
> >>  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
> >>  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
> >> +#define FS_XFLAG_CASEFOLD	0x00020000	/* case-insensitive lookups */
> >> +#define FS_XFLAG_CASENONPRESERVING 0x00040000	/* case not preserved */
> >>  #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
> >>  
> >>  /* the read-only stuff doesn't really belong here, but any other place is
> >> -- 
> >> 2.52.0
> >> 
> >>
> 
> -- 
> Chuck Lever
> 

