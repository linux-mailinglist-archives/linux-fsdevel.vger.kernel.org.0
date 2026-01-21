Return-Path: <linux-fsdevel+bounces-74836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EZHMvOucGmKZAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 11:48:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48238557BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 11:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9953C8EA24E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4533647DD69;
	Wed, 21 Jan 2026 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oyZr4bIa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hKGDT3RV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oyZr4bIa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hKGDT3RV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720747A0A2
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990536; cv=none; b=Dhb+bcBfb7o2DhG4CB2x7sBjEMKOnI6Gl1GPBfQw1yVxbHHumdrgeDzn9FrYFc+Bj6CBskVlQexVZrLYYJNn5b/PPDyktV6C019vQW/LdtDYe1PA/GBGs4F3W2F7VtvaCWW7ONJgL/CmxYAiqCKvNB0kVR/H8Pot5bps2KkV9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990536; c=relaxed/simple;
	bh=FuM/jn/pLIo1tsEbZu2EXv1DBTqVWbRptLylqPwV49M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA2skRAuVNMh9eguJOjoj3OHBPPGcNiKqfzVdpNoax4HHcKONWWN/5OarBaJUxDFJvylOUsG2RfMveUs02pUlaUM7Gtw/NGSR/dMJ3vOIb7QPvhWulbtiWNp8XO0d7s9hX2Djo7Y54gle8l0Uj/FPTL7G/PWp+2SlFhMc1+xVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oyZr4bIa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hKGDT3RV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oyZr4bIa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hKGDT3RV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 411673368B;
	Wed, 21 Jan 2026 10:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768990531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aF2V3WhsKglhokc+vDCdyrArCDZRi7BaNs5JOgZNrVU=;
	b=oyZr4bIa8xa6khQR+3eM1H61wEuW3Q0Mnyvw0c7ai3xakzeGQVGU/k5BpLu7zyxFGI53uU
	/Md2kFXYwOpTYCKaVuK9vdlm7AYjoWJosUfSR6+QZ/KVddN/7n+GkQpROamRQAgf+irhFa
	1efAhFd3urlGVtpZhRDELhC8i3q+sWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768990531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aF2V3WhsKglhokc+vDCdyrArCDZRi7BaNs5JOgZNrVU=;
	b=hKGDT3RVd5aKhQJyzWkmDrePqUureFmqRjTuFORoR2dLuF3B2vhHl4w5CN1/YYvRUf4RLG
	hO1E2Tf9swmlZDCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oyZr4bIa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hKGDT3RV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768990531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aF2V3WhsKglhokc+vDCdyrArCDZRi7BaNs5JOgZNrVU=;
	b=oyZr4bIa8xa6khQR+3eM1H61wEuW3Q0Mnyvw0c7ai3xakzeGQVGU/k5BpLu7zyxFGI53uU
	/Md2kFXYwOpTYCKaVuK9vdlm7AYjoWJosUfSR6+QZ/KVddN/7n+GkQpROamRQAgf+irhFa
	1efAhFd3urlGVtpZhRDELhC8i3q+sWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768990531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aF2V3WhsKglhokc+vDCdyrArCDZRi7BaNs5JOgZNrVU=;
	b=hKGDT3RVd5aKhQJyzWkmDrePqUureFmqRjTuFORoR2dLuF3B2vhHl4w5CN1/YYvRUf4RLG
	hO1E2Tf9swmlZDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34BC63EA63;
	Wed, 21 Jan 2026 10:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sl/WDEOncGnVbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 10:15:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E2DBFA09E9; Wed, 21 Jan 2026 11:15:26 +0100 (CET)
Date: Wed, 21 Jan 2026 11:15:26 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, sj1557.seo@samsung.com, 
	yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, adilger.kernel@dilger.ca, 
	cem@kernel.org, sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, 
	chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org, 
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v6 01/16] fs: Add case sensitivity flags to file_kattr
Message-ID: <avtj6ud7hb7qyya4ekj24lu2jwmirlqspxa4ptmhjrvuhrgfx6@ghzl2aqdokkg>
References: <20260120142439.1821554-1-cel@kernel.org>
 <20260120142439.1821554-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120142439.1821554-2-cel@kernel.org>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74836-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,oracle.com:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 48238557BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 20-01-26 09:24:24, Chuck Lever wrote:
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
> Relocate struct file_kattr initialization from fileattr_fill_xflags()
> and fileattr_fill_flags() to vfs_fileattr_get() and the ioctl/syscall
> call sites. This allows filesystem ->fileattr_get() callbacks to set
> flags directly in fa->fsx_xflags before invoking the fill functions,
> which previously would have zeroed those values. Callers that bypass
> vfs_fileattr_get() must now zero-initialize the struct themselves.
> 
> Case sensitivity information is exported to userspace via the
> fa_xflags field in the FS_IOC_FSGETXATTR ioctl and file_getattr()
> system call.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/file_attr.c           | 14 ++++++--------
>  fs/xfs/xfs_ioctl.c       |  2 +-
>  include/linux/fileattr.h |  3 ++-
>  include/uapi/linux/fs.h  |  2 ++
>  4 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 13cdb31a3e94..2700200c5b9c 100644
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
> @@ -84,6 +80,8 @@ int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
>  	struct inode *inode = d_inode(dentry);
>  	int error;
>  
> +	memset(fa, 0, sizeof(*fa));
> +

Umm, but ioctl_getflags() sets fa->flags_valid as a hint for
->fileattr_get() handler and this will now zero-out that hint. So I agree
that zeroing fa in fileattr_fill_{,x}flags() is a bit unexpected and moving
it is desirable but it needs a bit more careful surgery.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

