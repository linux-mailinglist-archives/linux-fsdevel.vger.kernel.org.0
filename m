Return-Path: <linux-fsdevel+bounces-66327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A54BC1BFAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84C415A8018
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9923433B6DA;
	Wed, 29 Oct 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejUoePLx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E7633B6D7;
	Wed, 29 Oct 2025 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751980; cv=none; b=g6dBoXQqOUcW2AXR9VS9K6Mmj3G8DoiQzJvbSvuNSMkik0E5Gs4wEiwmU52NGIDCo/FhL2picO9x781opyqCD5I7K/OrB9Vdg+enLO/ASwRjZBc3iYXJvWuSE5tBcil8y5Xfg4xbY1+1GAOJ/SWEmp8IOxcRG4gRP1w5tKMsy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751980; c=relaxed/simple;
	bh=tap0Ma9xaaS8+gNVBTb06UuQPmX+jiKpse0XY6MlNbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfJif0/Py+0pkXYkuGwGcvKmOI99YDu8cJM2vusMfcnY4PeH2KBSq9J7ZHM4nySk1pArDbLwwh7am8yhzWgcXXd6FcBfMRB2AIaUOz+WvP2F97G5v/etKVL6croIifcbfmLKnfbZYGCa5/ngxQAL2CEyz+XkyPR6LUAto5krqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejUoePLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A183C4CEF7;
	Wed, 29 Oct 2025 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761751979;
	bh=tap0Ma9xaaS8+gNVBTb06UuQPmX+jiKpse0XY6MlNbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejUoePLxez52CvDo7mByctlxe35dW/Ok2HdXdRJSyRJUaUbCJ2TZjIEy0nSjVkyl9
	 T0XZ7QmsQDBo0TrdjTj5zac+IfPNWVqYnKyXxwq3nkW/Kw/MaD95TS+H/5Iw5ohkcJ
	 EpIhxB+PR8hrMOSH9C0L9tjM8N7ODof5EzGGg9iIm7xtN0DCtabCWg0VT7pK8C4+pe
	 MvLL+ivcEVwlEE00k61l63fOAZG67z1YzgUpNtH38/ojY+J8ELxu4VLdFtbvTIgHI4
	 +VAU3O1g7h6udH1Mvd8mIkJblwb7smg4ajaviPuY/E1Y8fxYpnRv4o2qBtUfqtZ4I1
	 ehVDTN1HkUNnQ==
Date: Wed, 29 Oct 2025 16:32:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bhavik Sachdev <b.sachdev1904@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrei Vagin <avagin@gmail.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v3] statmount: accept fd as a parameter
Message-ID: <20251029-nachmachen-zucht-117c13371c8d@brauner>
References: <20251024181443.786363-1-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024181443.786363-1-b.sachdev1904@gmail.com>

On Fri, Oct 24, 2025 at 11:40:37PM +0530, Bhavik Sachdev wrote:
> Extend `struct mnt_id_req` to take in a fd and introduce STATMOUNT_BY_FD
> flag. When a valid fd is provided and STATMOUNT_BY_FD is set, statmount
> will return mountinfo about the mount the fd is on.
> 
> This even works for "unmounted" mounts (mounts that have been umounted
> using umount2(mnt, MNT_DETACH)), if you have access to a file descriptor
> on that mount. These "umounted" mounts will have no mountpoint hence we
> return "[detached]" and the mnt_ns_id to be 0.
> 
> Co-developed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
> ---
> We would like to add support for checkpoint/restoring file descriptors
> open on these "unmounted" mounts to CRIU (Checkpoint/Restore in
> Userspace) [1].
> 
> Currently, we have no way to get mount info for these "unmounted" mounts
> since they do appear in /proc/<pid>/mountinfo and statmount does not
> work on them, since they do not belong to any mount namespace.
> 
> This patch helps us by providing a way to get mountinfo for these
> "unmounted" mounts by using a fd on the mount.
> 
> Changes from v2 [2] to v3:
> * Rename STATMOUNT_FD flag to STATMOUNT_BY_FD.
> * Fixed UAF bug caused by the reference to fd_mount being bound by scope
> of CLASS(fd_raw, f)(kreq.fd) by using fget_raw instead.
> * Reused @spare parameter in mnt_id_req instead of adding new fields to
> the struct.
> 
> Changes from v1 [3] to v2:
> v1 of this patchset, took a different approach and introduced a new
> umount_mnt_ns, to which "unmounted" mounts would be moved to (instead of
> their namespace being NULL) thus allowing them to be still available via
> statmount.
> 
> Introducing umount_mnt_ns complicated namespace locking and modified
> performance sensitive code [4] and it was agreed upon that fd-based
> statmount would be better.
> 
> [1]: https://github.com/checkpoint-restore/criu/pull/2754
> [2]: https://lore.kernel.org/linux-fsdevel/20251011124753.1820802-1-b.sachdev1904@gmail.com/
> [3]: https://lore.kernel.org/linux-fsdevel/20251002125422.203598-1-b.sachdev1904@gmail.com/
> [4]: https://lore.kernel.org/linux-fsdevel/7e4d9eb5-6dde-4c59-8ee3-358233f082d0@virtuozzo.com/
> ---
>  fs/namespace.c             | 96 +++++++++++++++++++++++++++-----------
>  include/uapi/linux/mount.h |  7 ++-
>  2 files changed, 74 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d82910f33dc4..7e47397045dd 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5207,6 +5207,12 @@ static int statmount_mnt_root(struct kstatmount *s, struct seq_file *seq)
>  	return 0;
>  }
>  
> +static int statmount_mnt_point_detached(struct kstatmount *s, struct seq_file *seq)
> +{
> +	seq_puts(seq, "[detached]");
> +	return 0;
> +}
> +
>  static int statmount_mnt_point(struct kstatmount *s, struct seq_file *seq)
>  {
>  	struct vfsmount *mnt = s->mnt;
> @@ -5262,7 +5268,10 @@ static int statmount_sb_source(struct kstatmount *s, struct seq_file *seq)
>  static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
>  {
>  	s->sm.mask |= STATMOUNT_MNT_NS_ID;
> -	s->sm.mnt_ns_id = ns->ns.ns_id;
> +	if (ns)
> +		s->sm.mnt_ns_id = ns->ns.ns_id;
> +	else
> +		s->sm.mnt_ns_id = 0;
>  }
>  
>  static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
> @@ -5431,7 +5440,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
>  		break;
>  	case STATMOUNT_MNT_POINT:
>  		offp = &sm->mnt_point;
> -		ret = statmount_mnt_point(s, seq);
> +		if (!s->root.mnt && !s->root.dentry)

In what circumstances would one of these two be NULL and the other
won't? IOW, how it is possible that s->root.mnt != NULL but
s->root.dentry == NULL or vica versa?

> +			ret = statmount_mnt_point_detached(s, seq);
> +		else
> +			ret = statmount_mnt_point(s, seq);
>  		break;
>  	case STATMOUNT_MNT_OPTS:
>  		offp = &sm->mnt_opts;
> @@ -5572,29 +5584,33 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
>  
>  /* locks: namespace_shared */
>  static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
> -			struct mnt_namespace *ns)
> +			struct mnt_namespace *ns, unsigned int flags)
>  {
>  	struct mount *m;
>  	int err;
>  
>  	/* Has the namespace already been emptied? */
> -	if (mnt_ns_id && mnt_ns_empty(ns))
> +	if (!(flags & STATMOUNT_BY_FD) && mnt_ns_id && mnt_ns_empty(ns))
>  		return -ENOENT;
>  
> -	s->mnt = lookup_mnt_in_ns(mnt_id, ns);
> -	if (!s->mnt)
> -		return -ENOENT;
> +	if (!(flags & STATMOUNT_BY_FD)) {
> +		s->mnt = lookup_mnt_in_ns(mnt_id, ns);
> +		if (!s->mnt)
> +			return -ENOENT;
> +	}
>  
> -	err = grab_requested_root(ns, &s->root);
> -	if (err)
> -		return err;
> +	if (ns) {
> +		err = grab_requested_root(ns, &s->root);
> +		if (err)
> +			return err;
> +	}
>  
>  	/*
>  	 * Don't trigger audit denials. We just want to determine what
>  	 * mounts to show users.
>  	 */
>  	m = real_mount(s->mnt);
> -	if (!is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
> +	if (ns && !is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
>  	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> @@ -5718,7 +5734,7 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
>  }
>  
>  static int copy_mnt_id_req(const struct mnt_id_req __user *req,
> -			   struct mnt_id_req *kreq)
> +			   struct mnt_id_req *kreq, unsigned int flags)
>  {
>  	int ret;
>  	size_t usize;
> @@ -5736,7 +5752,9 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
>  	ret = copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
>  	if (ret)
>  		return ret;
> -	if (kreq->spare != 0)
> +	if (flags & STATMOUNT_BY_FD)
> +		return 0;
> +	if (kreq->fd != 0)
>  		return -EINVAL;
>  	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
>  	if (kreq->mnt_id <= MNT_UNIQUE_ID_OFFSET)
> @@ -5749,20 +5767,21 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
>   * that, or if not simply grab a passive reference on our mount namespace and
>   * return that.
>   */
> -static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq)
> +static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq,
> +						   unsigned int flags)
>  {
>  	struct mnt_namespace *mnt_ns;
>  
> -	if (kreq->mnt_ns_id && kreq->spare)
> +	if (kreq->mnt_ns_id && kreq->fd)
>  		return ERR_PTR(-EINVAL);
>  
>  	if (kreq->mnt_ns_id)
>  		return lookup_mnt_ns(kreq->mnt_ns_id);
>  
> -	if (kreq->spare) {
> +	if (!(flags & STATMOUNT_BY_FD) && kreq->fd) {
>  		struct ns_common *ns;
>  
> -		CLASS(fd, f)(kreq->spare);
> +		CLASS(fd, f)(kreq->fd);
>  		if (fd_empty(f))
>  			return ERR_PTR(-EBADF);
>  
> @@ -5782,29 +5801,47 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
>  	return mnt_ns;
>  }
>  
> +DEFINE_FREE(put_file, struct file *, if (_T) fput(_T))
> +
>  SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
>  		struct statmount __user *, buf, size_t, bufsize,
>  		unsigned int, flags)
>  {
>  	struct mnt_namespace *ns __free(mnt_ns_release) = NULL;
>  	struct kstatmount *ks __free(kfree) = NULL;
> +	struct file *file_from_fd __free(put_file) = NULL;
> +	struct vfsmount *fd_mnt;
>  	struct mnt_id_req kreq;
>  	/* We currently support retrieval of 3 strings. */
>  	size_t seq_size = 3 * PATH_MAX;
>  	int ret;
>  
> -	if (flags)
> +	if (flags & ~STATMOUNT_BY_FD)
>  		return -EINVAL;
>  
> -	ret = copy_mnt_id_req(req, &kreq);
> +	ret = copy_mnt_id_req(req, &kreq, flags);
>  	if (ret)
>  		return ret;
>  
> -	ns = grab_requested_mnt_ns(&kreq);
> -	if (!ns)
> -		return -ENOENT;
> +	if (flags & STATMOUNT_BY_FD) {
> +		file_from_fd = fget_raw(kreq.fd);
> +		if (!file_from_fd)
> +			return -EBADF;
>  
> -	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
> +		fd_mnt = file_from_fd->f_path.mnt;
> +		ns = real_mount(fd_mnt)->mnt_ns;
> +		if (ns)
> +			refcount_inc(&ns->passive);
> +		else
> +			if (!ns_capable_noaudit(file_from_fd->f_cred->user_ns, CAP_SYS_ADMIN))
> +				return -ENOENT;

Ugh, that's a very different security model from everything else we have
in here. Usually it's mnt->mnt_ns->user_ns so it's objective credentials
of the mount namespace we're talking about. Now we're changing the
conversation completely and are talking about the openers credentials.
I'm not yet sure how to feel about that.

> +	} else {
> +		ns = grab_requested_mnt_ns(&kreq, flags);
> +		if (!ns)
> +			return -ENOENT;
> +	}
> +
> +	if (ns && (ns != current->nsproxy->mnt_ns) &&
>  	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
>  		return -ENOENT;
>  
> @@ -5817,8 +5854,11 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
>  	if (ret)
>  		return ret;
>  
> +	if (flags & STATMOUNT_BY_FD)
> +		ks->mnt = fd_mnt;
> +
>  	scoped_guard(namespace_shared)
> -		ret = do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns);
> +		ret = do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns, flags);
>  
>  	if (!ret)
>  		ret = copy_statmount_to_user(ks);
> @@ -5910,7 +5950,7 @@ static void __free_klistmount_free(const struct klistmount *kls)
>  }
>  
>  static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *kreq,
> -				     size_t nr_mnt_ids)
> +				     size_t nr_mnt_ids, unsigned int flags)
>  {
>  
>  	u64 last_mnt_id = kreq->param;
> @@ -5927,7 +5967,7 @@ static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *
>  	if (!kls->kmnt_ids)
>  		return -ENOMEM;
>  
> -	kls->ns = grab_requested_mnt_ns(kreq);
> +	kls->ns = grab_requested_mnt_ns(kreq, flags);
>  	if (!kls->ns)
>  		return -ENOENT;
>  
> @@ -5957,11 +5997,11 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
>  	if (!access_ok(mnt_ids, nr_mnt_ids * sizeof(*mnt_ids)))
>  		return -EFAULT;
>  
> -	ret = copy_mnt_id_req(req, &kreq);
> +	ret = copy_mnt_id_req(req, &kreq, 0);
>  	if (ret)
>  		return ret;
>  
> -	ret = prepare_klistmount(&kls, &kreq, nr_mnt_ids);
> +	ret = prepare_klistmount(&kls, &kreq, nr_mnt_ids, flags);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 7fa67c2031a5..3eaa21d85531 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -197,7 +197,7 @@ struct statmount {
>   */
>  struct mnt_id_req {
>  	__u32 size;
> -	__u32 spare;
> +	__u32 fd;
>  	__u64 mnt_id;
>  	__u64 param;
>  	__u64 mnt_ns_id;
> @@ -232,4 +232,9 @@ struct mnt_id_req {
>  #define LSMT_ROOT		0xffffffffffffffff	/* root mount */
>  #define LISTMOUNT_REVERSE	(1 << 0) /* List later mounts first */
>  
> +/*
> + * @flag bits for statmount(2)
> + */
> +#define STATMOUNT_BY_FD		0x0000001U /* want mountinfo for given fd */
> +
>  #endif /* _UAPI_LINUX_MOUNT_H */
> -- 
> 2.51.0
> 

