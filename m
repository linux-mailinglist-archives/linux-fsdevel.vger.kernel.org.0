Return-Path: <linux-fsdevel+bounces-28247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CAA968800
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4AF281818
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 12:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0840619C57C;
	Mon,  2 Sep 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qf/AyJAd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GfRcXxsA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JKw9bQKD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vWf5xlfc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672719E99C;
	Mon,  2 Sep 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281664; cv=none; b=LEugdqTWI+nuQ8M41N0ORzrrrjM0Q+WAYzPPa0P2XMRvY7ZUiIp82q1p9UKFt5lNDCSfOvqVX1mGGz1UudeJb4eASC5xPWMXx7cL6wLA8JO9UjxPmkkJEeMxMG2PYxjixWuUWWPdO5gjI9syx82o5PSNyB+2oRerW76KviJHfBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281664; c=relaxed/simple;
	bh=MFo2TZCod0v2sP074XXMoouw1+7yGiBABZ4axFWyjZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkybua+mly0ebk77cFKTAdlUQ4r8miTyT0akkafFK5m1flm8Gz//xA+dHl9Vc4VwLC6HBmeDrGnLFvLQwrY7QilVTy5tpVcut8PHxaqDkEhbYYHbpNmAgymKgrmPVKxpZ+dESogrwxtJu/E3uxeTuV5qylaL/oDdtyFZlwQ42Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qf/AyJAd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GfRcXxsA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JKw9bQKD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vWf5xlfc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FADD1FBAD;
	Mon,  2 Sep 2024 12:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725281660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUfcnsaT50Spe9gr/GzOXNoVa7pI09BB72dUEUWz4JY=;
	b=Qf/AyJAdtVYsGjqmNPTLH13N9kQhzsb0Na/nnIf3ezvrOvc+tgWPrypecqWFE7JHOAmec9
	9TjELS6F3pSrKnaY3GUgikcAVnfwqaCzkSODmX/tZS63xgEYbol1PRbA+sboXVetzpZYQ6
	+CuWHVUX++H4emhlRW5/TvDW+VdRtU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725281660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUfcnsaT50Spe9gr/GzOXNoVa7pI09BB72dUEUWz4JY=;
	b=GfRcXxsAFhbQSvzru7OtVFqaFSxR71634popSkHRxhcfvTU+q3KYvuEOE/W1cLdyh7DFL+
	hBFrCbQ2pTCLAOAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725281659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUfcnsaT50Spe9gr/GzOXNoVa7pI09BB72dUEUWz4JY=;
	b=JKw9bQKDVK4S4n68YsoCpSMOzA0LXafxipWeFTnSgw14//BEJGVuRQpU0ein0ryKnffs5m
	RTmDmTbsywWR6cGFDFq7xMu1Xk5Qhu7AGpxfHdSLKpJS96QHxnEC+zSIMp80PZJMk71WQW
	bT3yVdKEjTIbH9nY9Ra7GIgwGfiaQ0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725281659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUfcnsaT50Spe9gr/GzOXNoVa7pI09BB72dUEUWz4JY=;
	b=vWf5xlfcWlAu6jtVApi9P2HgMvaz8ayqe8Q/0lwgxEFcCwqCUEPoe8/nNuLcptt32GOAP7
	nJlSThkfC/RSSYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E75013AE0;
	Mon,  2 Sep 2024 12:54:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OyD2Gnu11WbGFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Sep 2024 12:54:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 11C31A0965; Mon,  2 Sep 2024 14:54:19 +0200 (CEST)
Date: Mon, 2 Sep 2024 14:54:19 +0200
From: Jan Kara <jack@suse.cz>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RESEND v3 2/2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240902125419.qe34oqqkizumocta@quack3>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240828-exportfs-u64-mount-id-v3-2-10c2c4c16708@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828-exportfs-u64-mount-id-v3-2-10c2c4c16708@cyphar.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,toxicpanda.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,cyphar.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 28-08-24 20:19:43, Aleksa Sarai wrote:
> Now that we provide a unique 64-bit mount ID interface in statx(2), we
> can now provide a race-free way for name_to_handle_at(2) to provide a
> file handle and corresponding mount without needing to worry about
> racing with /proc/mountinfo parsing or having to open a file just to do
> statx(2).
> 
> While this is not necessary if you are using AT_EMPTY_PATH and don't
> care about an extra statx(2) call, users that pass full paths into
> name_to_handle_at(2) need to know which mount the file handle comes from
> (to make sure they don't try to open_by_handle_at a file handle from a
> different filesystem) and switching to AT_EMPTY_PATH would require
> allocating a file for every name_to_handle_at(2) call, turning
> 
>   err = name_to_handle_at(-EBADF, "/foo/bar/baz", &handle, &mntid,
>                           AT_HANDLE_MNT_ID_UNIQUE);
> 
> into
> 
>   int fd = openat(-EBADF, "/foo/bar/baz", O_PATH | O_CLOEXEC);
>   err1 = name_to_handle_at(fd, "", &handle, &unused_mntid, AT_EMPTY_PATH);
>   err2 = statx(fd, "", AT_EMPTY_PATH, STATX_MNT_ID_UNIQUE, &statxbuf);
>   mntid = statxbuf.stx_mnt_id;
>   close(fd);
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c                                       | 29 ++++++++++++++++------
>  include/linux/syscalls.h                           |  2 +-
>  include/uapi/linux/fcntl.h                         |  1 +
>  tools/perf/trace/beauty/include/uapi/linux/fcntl.h |  1 +
>  4 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 6e8cea16790e..8cb665629f4a 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -16,7 +16,8 @@
>  
>  static long do_sys_name_to_handle(const struct path *path,
>  				  struct file_handle __user *ufh,
> -				  int __user *mnt_id, int fh_flags)
> +				  void __user *mnt_id, bool unique_mntid,
> +				  int fh_flags)
>  {
>  	long retval;
>  	struct file_handle f_handle;
> @@ -69,9 +70,19 @@ static long do_sys_name_to_handle(const struct path *path,
>  	} else
>  		retval = 0;
>  	/* copy the mount id */
> -	if (put_user(real_mount(path->mnt)->mnt_id, mnt_id) ||
> -	    copy_to_user(ufh, handle,
> -			 struct_size(handle, f_handle, handle_bytes)))
> +	if (unique_mntid) {
> +		if (put_user(real_mount(path->mnt)->mnt_id_unique,
> +			     (u64 __user *) mnt_id))
> +			retval = -EFAULT;
> +	} else {
> +		if (put_user(real_mount(path->mnt)->mnt_id,
> +			     (int __user *) mnt_id))
> +			retval = -EFAULT;
> +	}
> +	/* copy the handle */
> +	if (retval != -EFAULT &&
> +		copy_to_user(ufh, handle,
> +			     struct_size(handle, f_handle, handle_bytes)))
>  		retval = -EFAULT;
>  	kfree(handle);
>  	return retval;
> @@ -83,6 +94,7 @@ static long do_sys_name_to_handle(const struct path *path,
>   * @name: name that should be converted to handle.
>   * @handle: resulting file handle
>   * @mnt_id: mount id of the file system containing the file
> + *          (u64 if AT_HANDLE_MNT_ID_UNIQUE, otherwise int)
>   * @flag: flag value to indicate whether to follow symlink or not
>   *        and whether a decodable file handle is required.
>   *
> @@ -92,7 +104,7 @@ static long do_sys_name_to_handle(const struct path *path,
>   * value required.
>   */
>  SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
> -		struct file_handle __user *, handle, int __user *, mnt_id,
> +		struct file_handle __user *, handle, void __user *, mnt_id,
>  		int, flag)
>  {
>  	struct path path;
> @@ -100,7 +112,8 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
>  	int fh_flags;
>  	int err;
>  
> -	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID))
> +	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID |
> +		     AT_HANDLE_MNT_ID_UNIQUE))
>  		return -EINVAL;
>  
>  	lookup_flags = (flag & AT_SYMLINK_FOLLOW) ? LOOKUP_FOLLOW : 0;
> @@ -109,7 +122,9 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
>  		lookup_flags |= LOOKUP_EMPTY;
>  	err = user_path_at(dfd, name, lookup_flags, &path);
>  	if (!err) {
> -		err = do_sys_name_to_handle(&path, handle, mnt_id, fh_flags);
> +		err = do_sys_name_to_handle(&path, handle, mnt_id,
> +					    flag & AT_HANDLE_MNT_ID_UNIQUE,
> +					    fh_flags);
>  		path_put(&path);
>  	}
>  	return err;
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 4bcf6754738d..5758104921e6 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -870,7 +870,7 @@ asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
>  #endif
>  asmlinkage long sys_name_to_handle_at(int dfd, const char __user *name,
>  				      struct file_handle __user *handle,
> -				      int __user *mnt_id, int flag);
> +				      void __user *mnt_id, int flag);
>  asmlinkage long sys_open_by_handle_at(int mountdirfd,
>  				      struct file_handle __user *handle,
>  				      int flags);
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 38a6d66d9e88..87e2dec79fea 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -152,6 +152,7 @@
>  #define AT_HANDLE_FID		0x200	/* File handle is needed to compare
>  					   object identity and may not be
>  					   usable with open_by_handle_at(2). */
> +#define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID. */
>  
>  #if defined(__KERNEL__)
>  #define AT_GETATTR_NOSEC	0x80000000
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
> index 38a6d66d9e88..87e2dec79fea 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
> @@ -152,6 +152,7 @@
>  #define AT_HANDLE_FID		0x200	/* File handle is needed to compare
>  					   object identity and may not be
>  					   usable with open_by_handle_at(2). */
> +#define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID. */
>  
>  #if defined(__KERNEL__)
>  #define AT_GETATTR_NOSEC	0x80000000
> 
> -- 
> 2.46.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

