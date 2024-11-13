Return-Path: <linux-fsdevel+bounces-34633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CDA9C6F0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 13:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E10B31944
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20A2022CF;
	Wed, 13 Nov 2024 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orF1Q31t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A66201000;
	Wed, 13 Nov 2024 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499764; cv=none; b=QT4dY7s24NAQ6jn6IAN9dTUZ3+EG+yCdUJAUNUlh7QhZoIZzmHSb4zAh0dyoxL/NInUKsKfeMBmJs1Bnrs+VvwgJnf47RHlyzD6dCDrNul5RQ3/ApzF7zDxK9gVqyIgrNiUDuQV5tLZI+a6PuOzaxZJdbi4+wGy/TPOkwReTabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499764; c=relaxed/simple;
	bh=i5WeLzOl37PJLwW/6eFG6H5UBEaIHZipft6EYDTMM5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6Xls01oTLSOIokL62fLDHCCpY3JD0K0DyfZpsSbUrxQMfBhdQHJb9+xxPvS1m0G5cMvP5uPOPFLLSDP9rkWzDKtLl//A3LZCWANdBojAM94lwj4kmfHTTJ1NH9jpQd9rP+KG//HRcHzUkRG2DeSyLGfka49MwRhi+D7ZhAtzo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orF1Q31t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3070C4CECD;
	Wed, 13 Nov 2024 12:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731499764;
	bh=i5WeLzOl37PJLwW/6eFG6H5UBEaIHZipft6EYDTMM5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orF1Q31t2CjX4f3vq1iE1fe8+T8/sua9382J3Wuw+Imv0WITQifzuub7WbcwX2FEU
	 1Nh2arCicS1bXBpm4AsvWfiiUlLCorGAckuiUiSwaE/Me5nms0cOM4+APMo9Z4udNP
	 +UErf+KUXPTNm3omOqUd1UB6aD0WWeF22Q9GDuW/ZYdYHjfey/wFlrqPWTELuomcHu
	 tE/2LFsM+Doz6ZlSop2cveFgFMOzhBPJas8e0tBCZEMpnm9FVphLHOZ1OFSkRzM2gc
	 lS7yckoVSmOPRyOuTb9m/hXYD+zD5LwjHjd6jdULTj0wgV+SeGBRQGriBJpehwGrd0
	 AaymGsFuOOi6w==
Date: Wed, 13 Nov 2024 13:09:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, paul@paul-moore.com, bluca@debian.org
Subject: Re: [PATCH 4/4] pidfs: implement fh_to_dentry
Message-ID: <20241113-erlogen-aussehen-b75a9f8cb441@brauner>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241101135452.19359-5-erin.shepherd@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101135452.19359-5-erin.shepherd@e43.eu>

On Fri, Nov 01, 2024 at 01:54:52PM +0000, Erin Shepherd wrote:
> This enables userspace to use name_to_handle_at to recover a pidfd
> to a process.
> 
> We stash the process' PID in the root pid namespace inside the handle,
> and use that to recover the pid (validating that pid->ino matches the
> value in the handle, i.e. that the pid has not been reused).
> 
> We use the root namespace in order to ensure that file handles can be
> moved across namespaces; however, we validate that the PID exists in
> the current namespace before returning the inode.
> 
> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
> ---
>  fs/pidfs.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index c8e7e9011550..2d66610ef385 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -348,23 +348,59 @@ static const struct dentry_operations pidfs_dentry_operations = {
>  	.d_prune	= stashed_dentry_prune,
>  };
>  
> -static int pidfs_encode_fh(struct inode *inode, __u32 *fh, int *max_len,
> +#define PIDFD_FID_LEN 3
> +
> +struct pidfd_fid {
> +	u64 ino;
> +	s32 pid;
> +} __packed;
> +
> +static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>  			   struct inode *parent)
>  {
>  	struct pid *pid = inode->i_private;
> -	
> -	if (*max_len < 2) {
> -		*max_len = 2;
> +	struct pidfd_fid *fid = (struct pidfd_fid *)fh;
> +
> +	if (*max_len < PIDFD_FID_LEN) {
> +		*max_len = PIDFD_FID_LEN;
>  		return FILEID_INVALID;
>  	}
>  
> -	*max_len = 2;
> -	*(u64 *)fh = pid->ino;
> -	return FILEID_KERNFS;
> +	fid->ino = pid->ino;
> +	fid->pid = pid_nr(pid);

Hm, a pidfd comes in two flavours:

(1) thread-group leader pidfd: pidfd_open(<pid>, 0)
(2) thread pidfd:              pidfd_open(<pid>, PIDFD_THREAD)

In your current scheme fid->pid = pid_nr(pid) means that you always
encode a pidfs file handle for a thread pidfd no matter if the provided
pidfd was a thread-group leader pidfd or a thread pidfd. This is very
likely wrong as it means users that use a thread-group pidfd get a
thread-specific pid back.

I think we need to encode (1) and (2) in the pidfs file handle so users
always get back the correct type of pidfd.

That very likely means name_to_handle_at() needs to encode this into the
pidfs file handle.

We need to think a bit how to do this as we need access to the file so
we can tell (1) and (2) apart. It shouldn't be that big of a deal. For
pidfds we don't need any path-based lookup anyway. IOW, AT_EMPTY_PATH is
the only valid case. Starting with v6.13 we'll have getname_maybe_null()
so access to the file is roughly:

struct path path;
struct filename *fname;
unsigned in f_flags = 0;

fname = getname_maybe_null(name, flag & AT_EMPTY_PATH);
if (fname) {
        ret = filename_lookup(dfd, fname, lookup_flags, &path, NULL);
        if (ret)
                return ret;
} else {
	CLASS(fd, f)(dfd);
	if (fd_empty(f))
		return -EBADF;
	path = fd_file(f)->f_path;
	if (pidfd_pid(fd_file(f))
		f_flags = fd_file(f)->f_flags;
	path_get(&path);
}

and then a thread pidfd is reconginzable as f_flags & PIDFD_THREAD/O_EXCL.

The question again is how to plumb this through to the export_operations
encoding function.

> +	*max_len = PIDFD_FID_LEN;
> +	return FILEID_INO64_GEN;
> +}
> +
> +static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
> +					 struct fid *gen_fid,
> +					 int fh_len, int fh_type)
> +{
> +	int ret;
> +	struct path path;
> +	struct pidfd_fid *fid = (struct pidfd_fid *)gen_fid;
> +	struct pid *pid;
> +
> +	if (fh_type != FILEID_INO64_GEN || fh_len < PIDFD_FID_LEN)
> +		return NULL;
> +
> +	pid = find_get_pid_ns(fid->pid, &init_pid_ns);
> +	if (!pid || pid->ino != fid->ino || pid_vnr(pid) == 0) {
> +		put_pid(pid);
> +		return NULL;
> +	}

I think we can avoid the premature reference bump and do:

scoped_guard(rcu) {
        struct pid *pid;

	pid = find_pid_ns(fid->pid, &init_pid_ns);
	if (!pid)
		return NULL;

	/* Did the pid get recycled? */
	if (pid->ino != fid->ino)
		return NULL;

	/* Must be resolvable in the caller's pid namespace. */
	if (pid_vnr(pid) == 0)
		return NULL;

	/* Ok, this is the pid we want. */
	get_pid(pid);
}

> +
> +	ret = path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	mntput(path.mnt);
> +	return path.dentry;
>  }
>  
>  static const struct export_operations pidfs_export_operations = {
>  	.encode_fh = pidfs_encode_fh,
> +	.fh_to_dentry = pidfs_fh_to_dentry,
>  };
>  
>  static int pidfs_init_inode(struct inode *inode, void *data)
> -- 
> 2.46.1
> 

