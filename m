Return-Path: <linux-fsdevel+bounces-61397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC22B57CE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5743AA57E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40E4313297;
	Mon, 15 Sep 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZSXFcrsy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3fD2m0rl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZSXFcrsy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3fD2m0rl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E7530FC14
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942811; cv=none; b=o3STpvoXODur4GYl0gr8VmWz/qXjyKoIguP6aOZhKvQcLsFffjgwvNczUaCeHOT0rITsCE1Q50jJdvN+wgbvnpSkEPxYXWDpdWMCf8NpqwMpXRKJbCvbtLfP+J0ftE1TxOFN8V7pq9gvm5K0ZEkvfjh0tcz/foEBx8ZmDg7mLPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942811; c=relaxed/simple;
	bh=DNjCT8AjCBIhsNIIt7caR81pc8KcMInwSiEfAHrOjLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/bKnwvMXRYFgEnVY00hwz6phLxSIiIWIBl93UJziU1ZrUXXV12BwcqXmpWFwcb/mrEe/vVtOzCQLqK/6lYVVLUdkxH5YO0a/53lHYGgim9WbLI2NbUfc/rr0S125WIhB0Jas/sk76XokU0SZ2NwFClKwHfbGltbKNnqxBqNtOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZSXFcrsy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3fD2m0rl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZSXFcrsy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3fD2m0rl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83698336A2;
	Mon, 15 Sep 2025 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757942807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/GcvgzHFljI8lmWkgEFZKMFkx5vtDy9BKC9dr2WXzM=;
	b=ZSXFcrsy5tbNjQqSoVPmy60S5q4IYLaWz7xzaMFnm16yhV7GVO8krdX42Q17mjhKMhuZyE
	dccKOo/XDBewPpVZEtClisdORwZ9OW2Gh0P+N2K7iTv2Y2oCEVGAdtKqGG510EBd+azO89
	Kci5CEMy0+96jvF6/U2H5WwldMY56v4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757942807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/GcvgzHFljI8lmWkgEFZKMFkx5vtDy9BKC9dr2WXzM=;
	b=3fD2m0rlKAn16qJMgGK1oSMl7S3r61w6wg+MDFG3yz13vB4RhR+bq1rupS3ZJu1c/uzyIT
	k/yY2pWN213RLADw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757942807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/GcvgzHFljI8lmWkgEFZKMFkx5vtDy9BKC9dr2WXzM=;
	b=ZSXFcrsy5tbNjQqSoVPmy60S5q4IYLaWz7xzaMFnm16yhV7GVO8krdX42Q17mjhKMhuZyE
	dccKOo/XDBewPpVZEtClisdORwZ9OW2Gh0P+N2K7iTv2Y2oCEVGAdtKqGG510EBd+azO89
	Kci5CEMy0+96jvF6/U2H5WwldMY56v4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757942807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/GcvgzHFljI8lmWkgEFZKMFkx5vtDy9BKC9dr2WXzM=;
	b=3fD2m0rlKAn16qJMgGK1oSMl7S3r61w6wg+MDFG3yz13vB4RhR+bq1rupS3ZJu1c/uzyIT
	k/yY2pWN213RLADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 736051372E;
	Mon, 15 Sep 2025 13:26:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qtcoHBcUyGiTTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 13:26:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 23F8EA0A06; Mon, 15 Sep 2025 15:26:45 +0200 (CEST)
Date: Mon, 15 Sep 2025 15:26:45 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 29/33] nsfs: support exhaustive file handles
Message-ID: <qar72lx6pjoygcxefjssrbn6crytpfbpltpeuvplb3mnsle4gm@zpil2qdsn65o>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-29-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-29-1a247645cef5@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLbyy5b47ky7xssyr143sji8pp)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Fri 12-09-25 13:52:52, Christian Brauner wrote:
> Pidfd file handles are exhaustive meaning they don't require a handle on
> another pidfd to pass to open_by_handle_at() so it can derive the
> filesystem to decode in. Instead it can be derived from the file
> handle itself. The same is possible for namespace file handles.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c               |  6 ++++++
>  fs/internal.h              |  1 +
>  fs/nsfs.c                  | 10 ++++++++++
>  include/uapi/linux/fcntl.h |  1 +
>  4 files changed, 18 insertions(+)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 7c236f64cdea..f18c855bb0c2 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -11,6 +11,7 @@
>  #include <linux/personality.h>
>  #include <linux/uaccess.h>
>  #include <linux/compat.h>
> +#include <linux/nsfs.h>
>  #include "internal.h"
>  #include "mount.h"
>  
> @@ -189,6 +190,11 @@ static int get_path_anchor(int fd, struct path *root)
>  		return 0;
>  	}
>  
> +	if (fd == FD_NSFS_ROOT) {
> +		nsfs_get_root(root);
> +		return 0;
> +	}
> +
>  	return -EBADF;
>  }
>  
> diff --git a/fs/internal.h b/fs/internal.h
> index 38e8aab27bbd..a33d18ee5b74 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -355,3 +355,4 @@ int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
>  int anon_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  		       struct iattr *attr);
>  void pidfs_get_root(struct path *path);
> +void nsfs_get_root(struct path *path);
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 926e2680414e..22765fcab18e 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -25,6 +25,14 @@
>  
>  static struct vfsmount *nsfs_mnt;
>  
> +static struct path nsfs_root_path = {};
> +
> +void nsfs_get_root(struct path *path)
> +{
> +	*path = nsfs_root_path;
> +	path_get(path);
> +}
> +
>  static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  			unsigned long arg);
>  static const struct file_operations ns_file_operations = {
> @@ -598,4 +606,6 @@ void __init nsfs_init(void)
>  	if (IS_ERR(nsfs_mnt))
>  		panic("can't set nsfs up\n");
>  	nsfs_mnt->mnt_sb->s_flags &= ~SB_NOUSER;
> +	nsfs_root_path.mnt = nsfs_mnt;
> +	nsfs_root_path.dentry = nsfs_mnt->mnt_root;
>  }
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index f291ab4f94eb..3741ea1b73d8 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -111,6 +111,7 @@
>  #define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */
>  
>  #define FD_PIDFS_ROOT			-10002 /* Root of the pidfs filesystem */
> +#define FD_NSFS_ROOT			-10003 /* Root of the nsfs filesystem */
>  #define FD_INVALID			-10009 /* Invalid file descriptor: -10000 - EBADF = -10009 */
>  
>  /* Generic flags for the *at(2) family of syscalls. */
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

