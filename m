Return-Path: <linux-fsdevel+bounces-79376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFuXCLk7qGkTqgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:03:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9D9200E9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90816302C333
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739A831F98A;
	Wed,  4 Mar 2026 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVS7P4fV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0204D238C1B;
	Wed,  4 Mar 2026 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632994; cv=none; b=ZDBatipHDM9dUSAostYr/TxteNaa6ogEN4auW6MmFQLTurEC8GNwPL2UwtJolp/KQhMZE4eJcWT/6mUmM4Wxw9dYXHPa39B8Az7f4B6Vg6H7WCmpmjAzlMd5vcGpPsySagdlb8HGSiEfnYSHKmpQPwTNbczClmenVh2pm+LGCWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632994; c=relaxed/simple;
	bh=4GVOeqkDXGvYfCt0oL/Wk91424ZQyeBosFo+Pg27+i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beviNxIqzHeFEGd701qAzX9Gv7XOG3asRK8b+VIRDCgIMZ0fNHVvlPn1v1zAhnmREWoeUDAhqnRHc+MZH6XHmOFXET+bEe/Bz1URnflc95wjqf9JGRfcmRGHQu67lwLJ73Vmf2dqg/AQb0AIYpQGEo7NrfWR4oaMQ5AUaLfRVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVS7P4fV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37538C4CEF7;
	Wed,  4 Mar 2026 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772632993;
	bh=4GVOeqkDXGvYfCt0oL/Wk91424ZQyeBosFo+Pg27+i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVS7P4fVjVUYcFd0u+LVnFghIKYt15fsqVSgUzb+4g3rAqu0gTN0uRb0WagN7j3Nk
	 pyoLCapu7Qg5340Z3Jb16Qjk1PPRVFtJTxcCU7x1sd84v3xeBYywsxYquxq+G8itna
	 GrPjLYC9fg6d6nu6d1RYZoKVLKR6SCu32pLk8kU0hRxmO9OLQoOHXfiMTBoMCEkStA
	 wClt8xIupu/a2FBddmUSLSxqOpk9FwuDEZxJXJwS+nv8zzepJLI3h9+Rof/KduGqjY
	 xO9sY/8uC4xrFuCNV9HciUBIj8M+pgg05MA6QBujxStlT7zk3tOC6YFrWNBSnyhxeK
	 Y2DFBy1oa4CGw==
Date: Wed, 4 Mar 2026 15:03:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v2] vfs: add support for empty path to openat2(2)
Message-ID: <20260304-larven-wiewohl-dba04626ded5@brauner>
References: <20260302131650.3259153-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302131650.3259153-1-jkoolstra@xs4all.nl>
X-Rspamd-Queue-Id: 8B9D9200E9F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79376-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,oracle.com,suse.cz,gmail.com,vger.kernel.org,cyphar.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 02:16:50PM +0100, Jori Koolstra wrote:
> To get an operable version of an O_PATH file descriptors, it is possible
> to use openat(fd, ".", O_DIRECTORY) for directories, but other files
> currently require going through open("/proc/<pid>/fd/<nr>") which
> depends on a functioning procfs.
> 
> This patch adds the OPENAT2_EMPTY_PATH flag to openat2(2). If passed
> LOOKUP_EMPTY is set at path resolve time.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/open.c                    | 9 ++++-----
>  include/linux/fcntl.h        | 5 ++++-
>  include/uapi/linux/openat2.h | 4 ++++
>  3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 91f1139591ab..4f0a76dc8993 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1160,7 +1160,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
>  EXPORT_SYMBOL_GPL(kernel_file_open);
>  
>  #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
> -#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
> +#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | OPENAT2_EMPTY_PATH)
>  
>  inline struct open_how build_open_how(int flags, umode_t mode)
>  {
> @@ -1185,9 +1185,6 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  	int lookup_flags = 0;
>  	int acc_mode = ACC_MODE(flags);
>  
> -	BUILD_BUG_ON_MSG(upper_32_bits(VALID_OPEN_FLAGS),
> -			 "struct open_flags doesn't yet handle flags > 32 bits");
> -
>  	/*
>  	 * Strip flags that aren't relevant in determining struct open_flags.
>  	 */
> @@ -1281,6 +1278,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  		lookup_flags |= LOOKUP_DIRECTORY;
>  	if (!(flags & O_NOFOLLOW))
>  		lookup_flags |= LOOKUP_FOLLOW;
> +	if (flags & OPENAT2_EMPTY_PATH)
> +		lookup_flags |= LOOKUP_EMPTY;
>  
>  	if (how->resolve & RESOLVE_NO_XDEV)
>  		lookup_flags |= LOOKUP_NO_XDEV;
> @@ -1362,7 +1361,7 @@ static int do_sys_openat2(int dfd, const char __user *filename,
>  	if (unlikely(err))
>  		return err;
>  
> -	CLASS(filename, name)(filename);
> +	CLASS(filename_flags, name)(filename, op.lookup_flags);
>  	return FD_ADD(how->flags, do_file_open(dfd, name, &op));
>  }
>  
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index a332e79b3207..d1bb87ff70e3 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -7,10 +7,13 @@
>  
>  /* List of all valid flags for the open/openat flags argument: */
>  #define VALID_OPEN_FLAGS \
> +	 /* lower 32-bit flags */ \
>  	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
>  	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
>  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> -	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> +	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | \
> +	 /* upper 32-bit flags (openat2(2) only) */ \
> +	 OPENAT2_EMPTY_PATH)

I forgot to mention this cautionary little nugget in the last review...

The legacy open(2)/openat(2) codepaths currently aren't able to deal
with flag values in the upper 32-bit of a u64 flag parameter.

Basically, by adding OPENAT2_EMPTY_PATH into VALID_OPEN_FLAGS that's now
a u64. That has fun consequences:

inline struct open_how build_open_how(int flags, umode_t mode)
{
     struct open_how how = {
             .flags = flags & VALID_OPEN_FLAGS,

This will now cause bits 32 to 63 to be raised and how.flags ends up
with OPENAT2_EMPTY_PATH by pure chance.

That in turn means open(2), openat(2), and io_uring openat can
inadvertently enable OPENAT2_EMPTY_PATH when the flags value has bit 31
set.

So that needs to be fixed.

Another thing that I would like to see explicitly mentioned in the
commit message is that OPENAT2_EMPTY_PATH means that it will now be
possible to reopen an O_PATH file descriptor in sandboxes that don't
mount procfs.

IOW, if there's any program out there that - weirdly - relies on the
fact that you can create a container without procfs mounted, drop
cap_sys_admin and then funnel O_PATH fds into there via SCM_RIGHTS
relying on them not being able to be re-opened read-write will be
surprised.

While I don't necessarily think (anymore) that this is a realistic
scenario it is worth documenting it.

