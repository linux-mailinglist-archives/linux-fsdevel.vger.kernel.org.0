Return-Path: <linux-fsdevel+bounces-21261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1428C9008D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCDDB21665
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DBC197544;
	Fri,  7 Jun 2024 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxlvTFH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CE819538C
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774018; cv=none; b=Da1U6tovMJeH9HJuS+OCdR+syB0UtKkzjQYJlc5LVRsfGhsddrgmYIwFBYXCQvZ+w+1IR9QKYGBJ49ysUPksZE+FbyQ7klnZKXCHXfZ3iC97XamoDjNZYiBpt5Xk8c7COFtEbOs0tESwc033oeTDd9ZN6xhS3j5UnYeIkIsxJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774018; c=relaxed/simple;
	bh=WYXPAYQCUBRnlYbPyQW/Ce64q/wyKzZTfPFNqoH6T8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT2cDBzbatT4ga/8HjDbbLossoZ0aveeZxpkE2EX6uN717p2MJ5nT0evB/e5YUx0Gx8oFn9ThF4khbQ17QIBBe2ldB+B5pxj1BRAnmbrcDXz7YyxLNPNf+NTWzVw/ezeqssJRPINl25xm6HJWi9VWI+pjQFQladTDZfWPIqo7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxlvTFH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D17C32786;
	Fri,  7 Jun 2024 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774018;
	bh=WYXPAYQCUBRnlYbPyQW/Ce64q/wyKzZTfPFNqoH6T8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxlvTFH6+a8FJIugym8ucKjHL37UkNJvl4+h9lLR2POhJLhFyR115g/sxDWkcxNyF
	 LD1RdoJyZksdwT/A+727rQitDjj9YiJw7Js2HE6iM+d/78NJHKugZ9diQsxxjWlidq
	 GnJQ02zoALkR3KjuJDoNBl5fEl3sw9IE6/X6JJ/9tuiyZC4z6+J69lcq1n6+2oZ//0
	 psxHxIvv6bexpMgyfHboeRCeb/ob+Zs3TizP+F3jhGYDCKh8ZAQ+JgMUL9cjXvqztc
	 PGxrX08e6cbln62OKxFuX9/BOcXHBn5SUchP0SVoxPJ/pLdrwFf5X/gxvhPmXXa2vK
	 B5jiOPzviXLnA==
Date: Fri, 7 Jun 2024 17:26:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 11/19] switch simple users of fdget() to CLASS(fd, ...)
Message-ID: <20240607-gelacht-enkel-06a7c9b31d4e@brauner>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-11-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607015957.2372428-11-viro@zeniv.linux.org.uk>

On Fri, Jun 07, 2024 at 02:59:49AM +0100, Al Viro wrote:
> low-hanging fruit; that's another likely source of conflicts
> over the cycle and it might make a lot of sense to split;
> fortunately, it can be split pretty much on per-function
> basis - chunks are independent from each other.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

I can pick conversions from you for files where I already have changes
in the tree anyway or already have done conversion as part of other
patches.

>  arch/powerpc/kvm/book3s_64_vio.c           |   7 +-
>  arch/powerpc/kvm/powerpc.c                 |  24 ++---
>  arch/powerpc/platforms/cell/spu_syscalls.c |  13 +--
>  arch/x86/kernel/cpu/sgx/main.c             |  10 +-
>  arch/x86/kvm/svm/sev.c                     |  39 +++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c  |  23 ++---
>  drivers/gpu/drm/drm_syncobj.c              |   9 +-
>  drivers/infiniband/core/ucma.c             |  19 ++--
>  drivers/media/mc/mc-request.c              |  18 ++--
>  drivers/media/rc/lirc_dev.c                |  13 +--
>  drivers/vfio/group.c                       |   6 +-
>  drivers/vfio/virqfd.c                      |  16 +--
>  drivers/virt/acrn/irqfd.c                  |  10 +-
>  drivers/xen/privcmd.c                      |  31 ++----
>  fs/btrfs/ioctl.c                           |   5 +-
>  fs/coda/inode.c                            |  11 +-
>  fs/eventfd.c                               |   9 +-
>  fs/eventpoll.c                             |  38 ++-----
>  fs/ext4/ioctl.c                            |  21 ++--
>  fs/f2fs/file.c                             |  15 +--
>  fs/fhandle.c                               |   5 +-
>  fs/fsopen.c                                |  19 ++--
>  fs/fuse/dev.c                              |   6 +-
>  fs/ioctl.c                                 |  23 ++---
>  fs/kernel_read_file.c                      |  12 +--
>  fs/locks.c                                 |  15 +--
>  fs/namespace.c                             |  47 +++------
>  fs/notify/fanotify/fanotify_user.c         |  44 +++-----
>  fs/notify/inotify/inotify_user.c           |  38 +++----
>  fs/ocfs2/cluster/heartbeat.c               |  13 +--
>  fs/open.c                                  |  48 ++++-----
>  fs/read_write.c                            | 111 ++++++++-------------
>  fs/remap_range.c                           |  11 +-
>  fs/select.c                                |  13 +--
>  fs/signalfd.c                              |   9 +-
>  fs/smb/client/ioctl.c                      |  11 +-
>  fs/splice.c                                |  47 ++++-----
>  fs/sync.c                                  |  29 ++----
>  fs/utimes.c                                |  11 +-
>  fs/xattr.c                                 |  40 +++-----
>  fs/xfs/xfs_exchrange.c                     |  10 +-
>  fs/xfs/xfs_ioctl.c                         |  69 ++++---------
>  io_uring/sqpoll.c                          |  29 ++----
>  ipc/mqueue.c                               |  76 +++++---------
>  kernel/bpf/btf.c                           |  11 +-
>  kernel/bpf/syscall.c                       |  32 ++----
>  kernel/bpf/token.c                         |  15 +--
>  kernel/events/core.c                       |  14 +--
>  kernel/nsproxy.c                           |   5 +-
>  kernel/pid.c                               |  20 ++--
>  kernel/signal.c                            |  29 ++----
>  kernel/sys.c                               |  15 +--
>  kernel/taskstats.c                         |  18 ++--
>  kernel/watch_queue.c                       |   6 +-
>  mm/fadvise.c                               |  10 +-
>  mm/filemap.c                               |  17 +---
>  mm/memcontrol.c                            |  29 ++----
>  mm/readahead.c                             |  17 +---
>  net/core/net_namespace.c                   |  10 +-
>  security/integrity/ima/ima_main.c          |   7 +-
>  security/landlock/syscalls.c               |  26 ++---
>  security/loadpin/loadpin.c                 |   8 +-
>  virt/kvm/eventfd.c                         |  15 +--
>  virt/kvm/vfio.c                            |  14 +--
>  64 files changed, 454 insertions(+), 937 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> index ce8f9539af2b..742aa58a7c7e 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -115,10 +115,9 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
>  	struct iommu_table_group *table_group;
>  	long i;
>  	struct kvmppc_spapr_tce_iommu_table *stit;
> -	struct fd f;
> +	CLASS(fd, f)(tablefd);
>  
> -	f = fdget(tablefd);
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	rcu_read_lock();
> @@ -130,8 +129,6 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
>  	}
>  	rcu_read_unlock();
>  
> -	fdput(f);
> -
>  	if (!found)
>  		return -EINVAL;
>  
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index fd62144e497e..e31412069117 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -1933,12 +1933,11 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  #endif
>  #ifdef CONFIG_KVM_MPIC
>  	case KVM_CAP_IRQ_MPIC: {
> -		struct fd f;
> +		CLASS(fd, f)(cap->args[0]);
>  		struct kvm_device *dev;
>  
>  		r = -EBADF;
> -		f = fdget(cap->args[0]);
> -		if (!fd_file(f))
> +		if (fd_empty(f))
>  			break;
>  
>  		r = -EPERM;
> @@ -1946,18 +1945,16 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  		if (dev)
>  			r = kvmppc_mpic_connect_vcpu(dev, vcpu, cap->args[1]);
>  
> -		fdput(f);
>  		break;
>  	}
>  #endif
>  #ifdef CONFIG_KVM_XICS
>  	case KVM_CAP_IRQ_XICS: {
> -		struct fd f;
> +		CLASS(fd, f)(cap->args[0]);
>  		struct kvm_device *dev;
>  
>  		r = -EBADF;
> -		f = fdget(cap->args[0]);
> -		if (!fd_file(f))
> +		if (fd_empty(f))
>  			break;
>  
>  		r = -EPERM;
> @@ -1968,34 +1965,27 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  			else
>  				r = kvmppc_xics_connect_vcpu(dev, vcpu, cap->args[1]);
>  		}
> -
> -		fdput(f);
>  		break;
>  	}
>  #endif /* CONFIG_KVM_XICS */
>  #ifdef CONFIG_KVM_XIVE
>  	case KVM_CAP_PPC_IRQ_XIVE: {
> -		struct fd f;
> +		CLASS(fd, f)(cap->args[0]);
>  		struct kvm_device *dev;
>  
>  		r = -EBADF;
> -		f = fdget(cap->args[0]);
> -		if (!fd_file(f))
> +		if (fd_empty(f))
>  			break;
>  
>  		r = -ENXIO;
> -		if (!xive_enabled()) {
> -			fdput(f);
> +		if (!xive_enabled())
>  			break;
> -		}
>  
>  		r = -EPERM;
>  		dev = kvm_device_from_filp(fd_file(f));
>  		if (dev)
>  			r = kvmppc_xive_native_connect_vcpu(dev, vcpu,
>  							    cap->args[1]);
> -
> -		fdput(f);
>  		break;
>  	}
>  #endif /* CONFIG_KVM_XIVE */
> diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
> index cd7d42fc12a6..ca602376d025 100644
> --- a/arch/powerpc/platforms/cell/spu_syscalls.c
> +++ b/arch/powerpc/platforms/cell/spu_syscalls.c
> @@ -64,12 +64,10 @@ SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
>  		return -ENOSYS;
>  
>  	if (flags & SPU_CREATE_AFFINITY_SPU) {
> -		struct fd neighbor = fdget(neighbor_fd);
> +		CLASS(fd, neighbor)(neighbor_fd);
>  		ret = -EBADF;
> -		if (fd_file(neighbor)) {
> +		if (!fd_empty(neighbor))
>  			ret = calls->create_thread(name, flags, mode, fd_file(neighbor));
> -			fdput(neighbor);
> -		}
>  	} else
>  		ret = calls->create_thread(name, flags, mode, NULL);
>  
> @@ -80,7 +78,6 @@ SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
>  SYSCALL_DEFINE3(spu_run,int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
>  {
>  	long ret;
> -	struct fd arg;
>  	struct spufs_calls *calls;
>  
>  	calls = spufs_calls_get();
> @@ -88,11 +85,9 @@ SYSCALL_DEFINE3(spu_run,int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
>  		return -ENOSYS;
>  
>  	ret = -EBADF;
> -	arg = fdget(fd);
> -	if (fd_file(arg)) {
> +	CLASS(fd, arg)(fd);
> +	if (!fd_empty(arg))
>  		ret = calls->spu_run(fd_file(arg), unpc, ustatus);
> -		fdput(arg);
> -	}
>  
>  	spufs_calls_put(calls);
>  	return ret;
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index d01deb386395..d91284001162 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -893,19 +893,15 @@ static struct miscdevice sgx_dev_provision = {
>  int sgx_set_attribute(unsigned long *allowed_attributes,
>  		      unsigned int attribute_fd)
>  {
> -	struct fd f = fdget(attribute_fd);
> +	CLASS(fd, f)(attribute_fd);
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EINVAL;
>  
> -	if (fd_file(f)->f_op != &sgx_provision_fops) {
> -		fdput(f);
> +	if (fd_file(f)->f_op != &sgx_provision_fops)
>  		return -EINVAL;
> -	}
>  
>  	*allowed_attributes |= SGX_ATTR_PROVISIONKEY;
> -
> -	fdput(f);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(sgx_set_attribute);
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6a8154d6935a..197c80b809dc 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -373,17 +373,12 @@ static int sev_bind_asid(struct kvm *kvm, unsigned int handle, int *error)
>  
>  static int __sev_issue_cmd(int fd, int id, void *data, int *error)
>  {
> -	struct fd f;
> -	int ret;
> +	CLASS(fd, f)(fd);
>  
> -	f = fdget(fd);
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  
> -	ret = sev_issue_cmd_external_user(fd_file(f), id, data, error);
> -
> -	fdput(f);
> -	return ret;
> +	return sev_issue_cmd_external_user(fd_file(f), id, data, error);
>  }
>  
>  static int sev_issue_cmd(struct kvm *kvm, int id, void *data, int *error)
> @@ -1908,23 +1903,21 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>  {
>  	struct kvm_sev_info *dst_sev = &to_kvm_svm(kvm)->sev_info;
>  	struct kvm_sev_info *src_sev, *cg_cleanup_sev;
> -	struct fd f = fdget(source_fd);
> +	CLASS(fd, f)(source_fd);
>  	struct kvm *source_kvm;
>  	bool charged = false;
>  	int ret;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  
> -	if (!file_is_kvm(fd_file(f))) {
> -		ret = -EBADF;
> -		goto out_fput;
> -	}
> +	if (!file_is_kvm(fd_file(f)))
> +		return -EBADF;
>  
>  	source_kvm = fd_file(f)->private_data;
>  	ret = sev_lock_two_vms(kvm, source_kvm);
>  	if (ret)
> -		goto out_fput;
> +		return ret;
>  
>  	if (kvm->arch.vm_type != source_kvm->arch.vm_type ||
>  	    sev_guest(kvm) || !sev_guest(source_kvm)) {
> @@ -1971,8 +1964,6 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>  	cg_cleanup_sev->misc_cg = NULL;
>  out_unlock:
>  	sev_unlock_two_vms(kvm, source_kvm);
> -out_fput:
> -	fdput(f);
>  	return ret;
>  }
>  
> @@ -2209,23 +2200,21 @@ int sev_mem_enc_unregister_region(struct kvm *kvm,
>  
>  int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>  {
> -	struct fd f = fdget(source_fd);
> +	CLASS(fd, f)(source_fd);
>  	struct kvm *source_kvm;
>  	struct kvm_sev_info *source_sev, *mirror_sev;
>  	int ret;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  
> -	if (!file_is_kvm(fd_file(f))) {
> -		ret = -EBADF;
> -		goto e_source_fput;
> -	}
> +	if (!file_is_kvm(fd_file(f)))
> +		return -EBADF;
>  
>  	source_kvm = fd_file(f)->private_data;
>  	ret = sev_lock_two_vms(kvm, source_kvm);
>  	if (ret)
> -		goto e_source_fput;
> +		return ret;
>  
>  	/*
>  	 * Mirrors of mirrors should work, but let's not get silly.  Also
> @@ -2268,8 +2257,6 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>  
>  e_unlock:
>  	sev_unlock_two_vms(kvm, source_kvm);
> -e_source_fput:
> -	fdput(f);
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> index a9298cb8d19a..570634654489 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -36,21 +36,19 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>  						  int fd,
>  						  int32_t priority)
>  {
> -	struct fd f = fdget(fd);
> +	CLASS(fd, f)(fd);
>  	struct amdgpu_fpriv *fpriv;
>  	struct amdgpu_ctx_mgr *mgr;
>  	struct amdgpu_ctx *ctx;
>  	uint32_t id;
>  	int r;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EINVAL;
>  
>  	r = amdgpu_file_to_fpriv(fd_file(f), &fpriv);
> -	if (r) {
> -		fdput(f);
> +	if (r)
>  		return r;
> -	}
>  
>  	mgr = &fpriv->ctx_mgr;
>  	mutex_lock(&mgr->lock);
> @@ -58,7 +56,6 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>  		amdgpu_ctx_priority_override(ctx, priority);
>  	mutex_unlock(&mgr->lock);
>  
> -	fdput(f);
>  	return 0;
>  }
>  
> @@ -67,31 +64,25 @@ static int amdgpu_sched_context_priority_override(struct amdgpu_device *adev,
>  						  unsigned ctx_id,
>  						  int32_t priority)
>  {
> -	struct fd f = fdget(fd);
> +	CLASS(fd, f)(fd);
>  	struct amdgpu_fpriv *fpriv;
>  	struct amdgpu_ctx *ctx;
>  	int r;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EINVAL;
>  
>  	r = amdgpu_file_to_fpriv(fd_file(f), &fpriv);
> -	if (r) {
> -		fdput(f);
> +	if (r)
>  		return r;
> -	}
>  
>  	ctx = amdgpu_ctx_get(fpriv, ctx_id);
>  
> -	if (!ctx) {
> -		fdput(f);
> +	if (!ctx)
>  		return -EINVAL;
> -	}
>  
>  	amdgpu_ctx_priority_override(ctx, priority);
>  	amdgpu_ctx_put(ctx);
> -	fdput(f);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 7fb31ca3b5fc..4eaebd69253b 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -712,16 +712,14 @@ static int drm_syncobj_fd_to_handle(struct drm_file *file_private,
>  				    int fd, u32 *handle)
>  {
>  	struct drm_syncobj *syncobj;
> -	struct fd f = fdget(fd);
> +	CLASS(fd, f)(fd);
>  	int ret;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EINVAL;
>  
> -	if (fd_file(f)->f_op != &drm_syncobj_file_fops) {
> -		fdput(f);
> +	if (fd_file(f)->f_op != &drm_syncobj_file_fops)
>  		return -EINVAL;
> -	}
>  
>  	/* take a reference to put in the idr */
>  	syncobj = fd_file(f)->private_data;
> @@ -739,7 +737,6 @@ static int drm_syncobj_fd_to_handle(struct drm_file *file_private,
>  	} else
>  		drm_syncobj_put(syncobj);
>  
> -	fdput(f);
>  	return ret;
>  }
>  
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index dc57d07a1f45..cc95718fd24b 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -1615,7 +1615,6 @@ static ssize_t ucma_migrate_id(struct ucma_file *new_file,
>  	struct ucma_event *uevent, *tmp;
>  	struct ucma_context *ctx;
>  	LIST_HEAD(event_list);
> -	struct fd f;
>  	struct ucma_file *cur_file;
>  	int ret = 0;
>  
> @@ -1623,21 +1622,17 @@ static ssize_t ucma_migrate_id(struct ucma_file *new_file,
>  		return -EFAULT;
>  
>  	/* Get current fd to protect against it being closed */
> -	f = fdget(cmd.fd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(cmd.fd);
> +	if (fd_empty(f))
>  		return -ENOENT;
> -	if (fd_file(f)->f_op != &ucma_fops) {
> -		ret = -EINVAL;
> -		goto file_put;
> -	}
> +	if (fd_file(f)->f_op != &ucma_fops)
> +		return -EINVAL;
>  	cur_file = fd_file(f)->private_data;
>  
>  	/* Validate current fd and prevent destruction of id. */
>  	ctx = ucma_get_ctx(cur_file, cmd.id);
> -	if (IS_ERR(ctx)) {
> -		ret = PTR_ERR(ctx);
> -		goto file_put;
> -	}
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
>  
>  	rdma_lock_handler(ctx->cm_id);
>  	/*
> @@ -1678,8 +1673,6 @@ static ssize_t ucma_migrate_id(struct ucma_file *new_file,
>  err_unlock:
>  	rdma_unlock_handler(ctx->cm_id);
>  	ucma_put_ctx(ctx);
> -file_put:
> -	fdput(f);
>  	return ret;
>  }
>  
> diff --git a/drivers/media/mc/mc-request.c b/drivers/media/mc/mc-request.c
> index e064914c476e..df39c8c11e9a 100644
> --- a/drivers/media/mc/mc-request.c
> +++ b/drivers/media/mc/mc-request.c
> @@ -246,22 +246,21 @@ static const struct file_operations request_fops = {
>  struct media_request *
>  media_request_get_by_fd(struct media_device *mdev, int request_fd)
>  {
> -	struct fd f;
>  	struct media_request *req;
>  
>  	if (!mdev || !mdev->ops ||
>  	    !mdev->ops->req_validate || !mdev->ops->req_queue)
>  		return ERR_PTR(-EBADR);
>  
> -	f = fdget(request_fd);
> -	if (!fd_file(f))
> -		goto err_no_req_fd;
> +	CLASS(fd, f)(request_fd);
> +	if (fd_empty(f))
> +		goto err;
>  
>  	if (fd_file(f)->f_op != &request_fops)
> -		goto err_fput;
> +		goto err;
>  	req = fd_file(f)->private_data;
>  	if (req->mdev != mdev)
> -		goto err_fput;
> +		goto err;
>  
>  	/*
>  	 * Note: as long as someone has an open filehandle of the request,
> @@ -272,14 +271,9 @@ media_request_get_by_fd(struct media_device *mdev, int request_fd)
>  	 * before media_request_get() is called.
>  	 */
>  	media_request_get(req);
> -	fdput(f);
> -
>  	return req;
>  
> -err_fput:
> -	fdput(f);
> -
> -err_no_req_fd:
> +err:
>  	dev_dbg(mdev->dev, "cannot find request_fd %d\n", request_fd);
>  	return ERR_PTR(-EINVAL);
>  }
> diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
> index b8dfd530fab7..af6337489d21 100644
> --- a/drivers/media/rc/lirc_dev.c
> +++ b/drivers/media/rc/lirc_dev.c
> @@ -816,28 +816,23 @@ void __exit lirc_dev_exit(void)
>  
>  struct rc_dev *rc_dev_get_from_fd(int fd, bool write)
>  {
> -	struct fd f = fdget(fd);
> +	CLASS(fd, f)(fd);
>  	struct lirc_fh *fh;
>  	struct rc_dev *dev;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return ERR_PTR(-EBADF);
>  
> -	if (fd_file(f)->f_op != &lirc_fops) {
> -		fdput(f);
> +	if (fd_file(f)->f_op != &lirc_fops)
>  		return ERR_PTR(-EINVAL);
> -	}
>  
> -	if (write && !(fd_file(f)->f_mode & FMODE_WRITE)) {
> -		fdput(f);
> +	if (write && !(fd_file(f)->f_mode & FMODE_WRITE))
>  		return ERR_PTR(-EPERM);
> -	}
>  
>  	fh = fd_file(f)->private_data;
>  	dev = fh->rc;
>  
>  	get_device(&dev->dev);
> -	fdput(f);
>  
>  	return dev;
>  }
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index f0d77e3c7196..8bad9b11c844 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -104,15 +104,14 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
>  {
>  	struct vfio_container *container;
>  	struct iommufd_ctx *iommufd;
> -	struct fd f;
>  	int ret;
>  	int fd;
>  
>  	if (get_user(fd, arg))
>  		return -EFAULT;
>  
> -	f = fdget(fd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	mutex_lock(&group->group_lock);
> @@ -153,7 +152,6 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
>  
>  out_unlock:
>  	mutex_unlock(&group->group_lock);
> -	fdput(f);
>  	return ret;
>  }
>  
> diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
> index d22881245e89..aa2891f97508 100644
> --- a/drivers/vfio/virqfd.c
> +++ b/drivers/vfio/virqfd.c
> @@ -113,7 +113,6 @@ int vfio_virqfd_enable(void *opaque,
>  		       void (*thread)(void *, void *),
>  		       void *data, struct virqfd **pvirqfd, int fd)
>  {
> -	struct fd irqfd;
>  	struct eventfd_ctx *ctx;
>  	struct virqfd *virqfd;
>  	int ret = 0;
> @@ -133,8 +132,8 @@ int vfio_virqfd_enable(void *opaque,
>  	INIT_WORK(&virqfd->inject, virqfd_inject);
>  	INIT_WORK(&virqfd->flush_inject, virqfd_flush_inject);
>  
> -	irqfd = fdget(fd);
> -	if (!fd_file(irqfd)) {
> +	CLASS(fd, irqfd)(fd);
> +	if (fd_empty(irqfd)) {
>  		ret = -EBADF;
>  		goto err_fd;
>  	}
> @@ -142,7 +141,7 @@ int vfio_virqfd_enable(void *opaque,
>  	ctx = eventfd_ctx_fileget(fd_file(irqfd));
>  	if (IS_ERR(ctx)) {
>  		ret = PTR_ERR(ctx);
> -		goto err_ctx;
> +		goto err_fd;
>  	}
>  
>  	virqfd->eventfd = ctx;
> @@ -181,18 +180,9 @@ int vfio_virqfd_enable(void *opaque,
>  		if ((!handler || handler(opaque, data)) && thread)
>  			schedule_work(&virqfd->inject);
>  	}
> -
> -	/*
> -	 * Do not drop the file until the irqfd is fully initialized,
> -	 * otherwise we might race against the EPOLLHUP.
> -	 */
> -	fdput(irqfd);
> -
>  	return 0;
>  err_busy:
>  	eventfd_ctx_put(ctx);
> -err_ctx:
> -	fdput(irqfd);
>  err_fd:
>  	kfree(virqfd);
>  
> diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
> index 9994d818bb7e..f4d37ceea2ab 100644
> --- a/drivers/virt/acrn/irqfd.c
> +++ b/drivers/virt/acrn/irqfd.c
> @@ -112,7 +112,6 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
>  	struct eventfd_ctx *eventfd = NULL;
>  	struct hsm_irqfd *irqfd, *tmp;
>  	__poll_t events;
> -	struct fd f;
>  	int ret = 0;
>  
>  	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
> @@ -124,8 +123,8 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
>  	INIT_LIST_HEAD(&irqfd->list);
>  	INIT_WORK(&irqfd->shutdown, hsm_irqfd_shutdown_work);
>  
> -	f = fdget(args->fd);
> -	if (!fd_file(f)) {
> +	CLASS(fd, f)(args->fd);
> +	if (fd_empty(f)) {
>  		ret = -EBADF;
>  		goto out;
>  	}
> @@ -133,7 +132,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
>  	eventfd = eventfd_ctx_fileget(fd_file(f));
>  	if (IS_ERR(eventfd)) {
>  		ret = PTR_ERR(eventfd);
> -		goto fail;
> +		goto out;
>  	}
>  
>  	irqfd->eventfd = eventfd;
> @@ -162,13 +161,10 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
>  	if (events & EPOLLIN)
>  		acrn_irqfd_inject(irqfd);
>  
> -	fdput(f);
>  	return 0;
>  fail:
>  	if (eventfd && !IS_ERR(eventfd))
>  		eventfd_ctx_put(eventfd);
> -
> -	fdput(f);
>  out:
>  	kfree(irqfd);
>  	return ret;
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index c35c2455aa61..ba772a6347f6 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -930,7 +930,6 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
>  {
>  	struct privcmd_kernel_irqfd *kirqfd, *tmp;
>  	__poll_t events;
> -	struct fd f;
>  	void *dm_op;
>  	int ret;
>  
> @@ -949,8 +948,8 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
>  	kirqfd->dom = irqfd->dom;
>  	INIT_WORK(&kirqfd->shutdown, irqfd_shutdown);
>  
> -	f = fdget(irqfd->fd);
> -	if (!fd_file(f)) {
> +	CLASS(fd, f)(irqfd->fd);
> +	if (fd_empty(f)) {
>  		ret = -EBADF;
>  		goto error_kfree;
>  	}
> @@ -958,7 +957,7 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
>  	kirqfd->eventfd = eventfd_ctx_fileget(fd_file(f));
>  	if (IS_ERR(kirqfd->eventfd)) {
>  		ret = PTR_ERR(kirqfd->eventfd);
> -		goto error_fd_put;
> +		goto error_kfree;
>  	}
>  
>  	/*
> @@ -989,19 +988,11 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
>  	if (events & EPOLLIN)
>  		irqfd_inject(kirqfd);
>  
> -	/*
> -	 * Do not drop the file until the kirqfd is fully initialized, otherwise
> -	 * we might race against the EPOLLHUP.
> -	 */
> -	fdput(f);
>  	return 0;
>  
>  error_eventfd:
>  	eventfd_ctx_put(kirqfd->eventfd);
>  
> -error_fd_put:
> -	fdput(f);
> -
>  error_kfree:
>  	kfree(kirqfd);
>  	return ret;
> @@ -1310,7 +1301,6 @@ static int privcmd_ioeventfd_assign(struct privcmd_ioeventfd *ioeventfd)
>  	struct privcmd_kernel_ioeventfd *kioeventfd;
>  	struct privcmd_kernel_ioreq *kioreq;
>  	unsigned long flags;
> -	struct fd f;
>  	int ret;
>  
>  	/* Check for range overflow */
> @@ -1330,14 +1320,15 @@ static int privcmd_ioeventfd_assign(struct privcmd_ioeventfd *ioeventfd)
>  	if (!kioeventfd)
>  		return -ENOMEM;
>  
> -	f = fdget(ioeventfd->event_fd);
> -	if (!fd_file(f)) {
> -		ret = -EBADF;
> -		goto error_kfree;
> -	}
> +	{
> +		CLASS(fd, f)(ioeventfd->event_fd);
> +		if (fd_empty(f)) {
> +			ret = -EBADF;
> +			goto error_kfree;
> +		}
>  
> -	kioeventfd->eventfd = eventfd_ctx_fileget(fd_file(f));
> -	fdput(f);
> +		kioeventfd->eventfd = eventfd_ctx_fileget(fd_file(f));
> +	}
>  
>  	if (IS_ERR(kioeventfd->eventfd)) {
>  		ret = PTR_ERR(kioeventfd->eventfd);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 2dccb7f90e4d..1703ba0b07e6 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1309,9 +1309,9 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
>  		ret = btrfs_mksubvol(&file->f_path, idmap, name,
>  				     namelen, NULL, readonly, inherit);
>  	} else {
> -		struct fd src = fdget(fd);
> +		CLASS(fd, src)(fd);
>  		struct inode *src_inode;
> -		if (!fd_file(src)) {
> +		if (fd_empty(src)) {
>  			ret = -EINVAL;
>  			goto out_drop_write;
>  		}
> @@ -1342,7 +1342,6 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
>  					       BTRFS_I(src_inode)->root,
>  					       readonly, inherit);
>  		}
> -		fdput(src);
>  	}
>  out_drop_write:
>  	mnt_drop_write_file(file);
> diff --git a/fs/coda/inode.c b/fs/coda/inode.c
> index 7d56b6d1e4c3..293cf5e6dfeb 100644
> --- a/fs/coda/inode.c
> +++ b/fs/coda/inode.c
> @@ -122,22 +122,17 @@ static const struct fs_parameter_spec coda_param_specs[] = {
>  static int coda_parse_fd(struct fs_context *fc, int fd)
>  {
>  	struct coda_fs_context *ctx = fc->fs_private;
> -	struct fd f;
> +	CLASS(fd, f)(fd);
>  	struct inode *inode;
>  	int idx;
>  
> -	f = fdget(fd);
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  	inode = file_inode(fd_file(f));
> -	if (!S_ISCHR(inode->i_mode) || imajor(inode) != CODA_PSDEV_MAJOR) {
> -		fdput(f);
> +	if (!S_ISCHR(inode->i_mode) || imajor(inode) != CODA_PSDEV_MAJOR)
>  		return invalf(fc, "code: Not coda psdev");
> -	}
>  
>  	idx = iminor(inode);
> -	fdput(f);
> -
>  	if (idx < 0 || idx >= MAX_CODADEVS)
>  		return invalf(fc, "coda: Bad minor number");
>  	ctx->idx = idx;
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index 22c934f3a080..76129bfcd663 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -347,13 +347,10 @@ EXPORT_SYMBOL_GPL(eventfd_fget);
>   */
>  struct eventfd_ctx *eventfd_ctx_fdget(int fd)
>  {
> -	struct eventfd_ctx *ctx;
> -	struct fd f = fdget(fd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
>  		return ERR_PTR(-EBADF);
> -	ctx = eventfd_ctx_fileget(fd_file(f));
> -	fdput(f);
> -	return ctx;
> +	return eventfd_ctx_fileget(fd_file(f));
>  }
>  EXPORT_SYMBOL_GPL(eventfd_ctx_fdget);
>  
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 28d1a754cf33..1e63f3b03ca5 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2259,25 +2259,22 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
>  {
>  	int error;
>  	int full_check = 0;
> -	struct fd f, tf;
>  	struct eventpoll *ep;
>  	struct epitem *epi;
>  	struct eventpoll *tep = NULL;
>  
> -	error = -EBADF;
> -	f = fdget(epfd);
> -	if (!fd_file(f))
> -		goto error_return;
> +	CLASS(fd, f)(epfd);
> +	if (fd_empty(f))
> +		return -EBADF;
>  
>  	/* Get the "struct file *" for the target file */
> -	tf = fdget(fd);
> -	if (!fd_file(tf))
> -		goto error_fput;
> +	CLASS(fd, tf)(fd);
> +	if (fd_empty(tf))
> +		return -EBADF;
>  
>  	/* The target file descriptor must support poll */
> -	error = -EPERM;
>  	if (!file_can_poll(fd_file(tf)))
> -		goto error_tgt_fput;
> +		return -EPERM;
>  
>  	/* Check if EPOLLWAKEUP is allowed */
>  	if (ep_op_has_event(op))
> @@ -2396,12 +2393,6 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
>  		loop_check_gen++;
>  		mutex_unlock(&epnested_mutex);
>  	}
> -
> -	fdput(tf);
> -error_fput:
> -	fdput(f);
> -error_return:
> -
>  	return error;
>  }
>  
> @@ -2429,8 +2420,6 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
>  static int do_epoll_wait(int epfd, struct epoll_event __user *events,
>  			 int maxevents, struct timespec64 *to)
>  {
> -	int error;
> -	struct fd f;
>  	struct eventpoll *ep;
>  
>  	/* The maximum number of event must be greater than zero */
> @@ -2442,17 +2431,16 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
>  		return -EFAULT;
>  
>  	/* Get the "struct file *" for the eventpoll file */
> -	f = fdget(epfd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(epfd);
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	/*
>  	 * We have to check that the file structure underneath the fd
>  	 * the user passed to us _is_ an eventpoll file.
>  	 */
> -	error = -EINVAL;
>  	if (!is_file_epoll(fd_file(f)))
> -		goto error_fput;
> +		return -EINVAL;
>  
>  	/*
>  	 * At this point it is safe to assume that the "private_data" contains
> @@ -2461,11 +2449,7 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
>  	ep = fd_file(f)->private_data;
>  
>  	/* Time to fish for events ... */
> -	error = ep_poll(ep, events, maxevents, to);
> -
> -error_fput:
> -	fdput(f);
> -	return error;
> +	return ep_poll(ep, events, maxevents, to);
>  }
>  
>  SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 63eaa1fa2556..5503c92cdb6d 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1330,7 +1330,6 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  
>  	case EXT4_IOC_MOVE_EXT: {
>  		struct move_extent me;
> -		struct fd donor;
>  		int err;
>  
>  		if (!(filp->f_mode & FMODE_READ) ||
> @@ -1342,30 +1341,26 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  			return -EFAULT;
>  		me.moved_len = 0;
>  
> -		donor = fdget(me.donor_fd);
> -		if (!fd_file(donor))
> +		CLASS(fd, donor)(me.donor_fd);
> +		if (fd_empty(donor))
>  			return -EBADF;
>  
> -		if (!(fd_file(donor)->f_mode & FMODE_WRITE)) {
> -			err = -EBADF;
> -			goto mext_out;
> -		}
> +		if (!(fd_file(donor)->f_mode & FMODE_WRITE))
> +			return -EBADF;
>  
>  		if (ext4_has_feature_bigalloc(sb)) {
>  			ext4_msg(sb, KERN_ERR,
>  				 "Online defrag not supported with bigalloc");
> -			err = -EOPNOTSUPP;
> -			goto mext_out;
> +			return -EOPNOTSUPP;
>  		} else if (IS_DAX(inode)) {
>  			ext4_msg(sb, KERN_ERR,
>  				 "Online defrag not supported with DAX");
> -			err = -EOPNOTSUPP;
> -			goto mext_out;
> +			return -EOPNOTSUPP;
>  		}
>  
>  		err = mnt_want_write_file(filp);
>  		if (err)
> -			goto mext_out;
> +			return err;
>  
>  		err = ext4_move_extents(filp, fd_file(donor), me.orig_start,
>  					me.donor_start, me.len, &me.moved_len);
> @@ -1374,8 +1369,6 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		if (copy_to_user((struct move_extent __user *)arg,
>  				 &me, sizeof(me)))
>  			err = -EFAULT;
> -mext_out:
> -		fdput(donor);
>  		return err;
>  	}
>  
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 89db22f9488b..c70191b8b345 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2962,32 +2962,27 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>  static int __f2fs_ioc_move_range(struct file *filp,
>  				struct f2fs_move_range *range)
>  {
> -	struct fd dst;
>  	int err;
>  
>  	if (!(filp->f_mode & FMODE_READ) ||
>  			!(filp->f_mode & FMODE_WRITE))
>  		return -EBADF;
>  
> -	dst = fdget(range->dst_fd);
> -	if (!fd_file(dst))
> +	CLASS(fd, dst)(range->dst_fd);
> +	if (fd_empty(dst))
>  		return -EBADF;
>  
> -	if (!(fd_file(dst)->f_mode & FMODE_WRITE)) {
> -		err = -EBADF;
> -		goto err_out;
> -	}
> +	if (!(fd_file(dst)->f_mode & FMODE_WRITE))
> +		return -EBADF;
>  
>  	err = mnt_want_write_file(filp);
>  	if (err)
> -		goto err_out;
> +		return err;
>  
>  	err = f2fs_move_file_range(filp, range->pos_in, fd_file(dst),
>  					range->pos_out, range->len);
>  
>  	mnt_drop_write_file(filp);
> -err_out:
> -	fdput(dst);
>  	return err;
>  }
>  
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 94fc4126eaa4..c6ae83e456b2 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -125,11 +125,10 @@ static struct vfsmount *get_vfsmount_from_fd(int fd)
>  		mnt = mntget(fs->pwd.mnt);
>  		spin_unlock(&fs->lock);
>  	} else {
> -		struct fd f = fdget(fd);
> -		if (!fd_file(f))
> +		CLASS(fd, f)(fd);
> +		if (fd_empty(f))
>  			return ERR_PTR(-EBADF);
>  		mnt = mntget(fd_file(f)->f_path.mnt);
> -		fdput(f);
>  	}
>  	return mnt;
>  }
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index cf9f37b2a5d4..f779836c7288 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -354,7 +354,6 @@ SYSCALL_DEFINE5(fsconfig,
>  		int, aux)
>  {
>  	struct fs_context *fc;
> -	struct fd f;
>  	int ret;
>  	int lookup_flags = 0;
>  
> @@ -397,12 +396,11 @@ SYSCALL_DEFINE5(fsconfig,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	f = fdget(fd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
>  		return -EBADF;
> -	ret = -EINVAL;
>  	if (fd_file(f)->f_op != &fscontext_fops)
> -		goto out_f;
> +		return -EINVAL;
>  
>  	fc = fd_file(f)->private_data;
>  	if (fc->ops == &legacy_fs_context_ops) {
> @@ -411,17 +409,14 @@ SYSCALL_DEFINE5(fsconfig,
>  		case FSCONFIG_SET_PATH:
>  		case FSCONFIG_SET_PATH_EMPTY:
>  		case FSCONFIG_SET_FD:
> -			ret = -EOPNOTSUPP;
> -			goto out_f;
> +			return -EOPNOTSUPP;
>  		}
>  	}
>  
>  	if (_key) {
>  		param.key = strndup_user(_key, 256);
> -		if (IS_ERR(param.key)) {
> -			ret = PTR_ERR(param.key);
> -			goto out_f;
> -		}
> +		if (IS_ERR(param.key))
> +			return PTR_ERR(param.key);
>  	}
>  
>  	switch (cmd) {
> @@ -500,7 +495,5 @@ SYSCALL_DEFINE5(fsconfig,
>  	}
>  out_key:
>  	kfree(param.key);
> -out_f:
> -	fdput(f);
>  	return ret;
>  }
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 991b9ae8e7c9..27826116a4fb 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2315,13 +2315,12 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
>  	int res;
>  	int oldfd;
>  	struct fuse_dev *fud = NULL;
> -	struct fd f;
>  
>  	if (get_user(oldfd, argp))
>  		return -EFAULT;
>  
> -	f = fdget(oldfd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(oldfd);
> +	if (fd_empty(f))
>  		return -EINVAL;
>  
>  	/*
> @@ -2338,7 +2337,6 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
>  		mutex_unlock(&fuse_mutex);
>  	}
>  
> -	fdput(f);
>  	return res;
>  }
>  
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 6e0c954388d4..638a36be31c1 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -231,11 +231,11 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
>  static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
>  			     u64 off, u64 olen, u64 destoff)
>  {
> -	struct fd src_file = fdget(srcfd);
> +	CLASS(fd, src_file)(srcfd);
>  	loff_t cloned;
>  	int ret;
>  
> -	if (!fd_file(src_file))
> +	if (fd_empty(src_file))
>  		return -EBADF;
>  	cloned = vfs_clone_file_range(fd_file(src_file), off, dst_file, destoff,
>  				      olen, 0);
> @@ -245,7 +245,6 @@ static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
>  		ret = -EINVAL;
>  	else
>  		ret = 0;
> -	fdput(src_file);
>  	return ret;
>  }
>  
> @@ -892,22 +891,20 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
>  
>  SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
>  {
> -	struct fd f = fdget(fd);
> +	CLASS(fd, f)(fd);
>  	int error;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	error = security_file_ioctl(fd_file(f), cmd, arg);
>  	if (error)
> -		goto out;
> +		return error;
>  
>  	error = do_vfs_ioctl(fd_file(f), fd, cmd, arg);
>  	if (error == -ENOIOCTLCMD)
>  		error = vfs_ioctl(fd_file(f), cmd, arg);
>  
> -out:
> -	fdput(f);
>  	return error;
>  }
>  
> @@ -950,15 +947,15 @@ EXPORT_SYMBOL(compat_ptr_ioctl);
>  COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
>  		       compat_ulong_t, arg)
>  {
> -	struct fd f = fdget(fd);
> +	CLASS(fd, f)(fd);
>  	int error;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	error = security_file_ioctl_compat(fd_file(f), cmd, arg);
>  	if (error)
> -		goto out;
> +		return error;
>  
>  	switch (cmd) {
>  	/* FICLONE takes an int argument, so don't use compat_ptr() */
> @@ -1009,10 +1006,6 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
>  			error = -ENOTTY;
>  		break;
>  	}
> -
> - out:
> -	fdput(f);
> -
>  	return error;
>  }
>  #endif
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> index 9ff37ae650ea..de32c95d823d 100644
> --- a/fs/kernel_read_file.c
> +++ b/fs/kernel_read_file.c
> @@ -175,15 +175,11 @@ ssize_t kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
>  				 size_t buf_size, size_t *file_size,
>  				 enum kernel_read_file_id id)
>  {
> -	struct fd f = fdget(fd);
> -	ssize_t ret = -EBADF;
> +	CLASS(fd, f)(fd);
>  
> -	if (!fd_file(f) || !(fd_file(f)->f_mode & FMODE_READ))
> -		goto out;
> +	if (fd_empty(f) || !(fd_file(f)->f_mode & FMODE_READ))
> +		return -EBADF;
>  
> -	ret = kernel_read_file(fd_file(f), offset, buf, buf_size, file_size, id);
> -out:
> -	fdput(f);
> -	return ret;
> +	return kernel_read_file(fd_file(f), offset, buf, buf_size, file_size, id);
>  }
>  EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
> diff --git a/fs/locks.c b/fs/locks.c
> index ee8e1925dc42..4170035a2bc8 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2132,7 +2132,6 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
>  {
>  	int can_sleep, error, type;
>  	struct file_lock fl;
> -	struct fd f;
>  
>  	/*
>  	 * LOCK_MAND locks were broken for a long time in that they never
> @@ -2151,19 +2150,18 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
>  	if (type < 0)
>  		return type;
>  
> -	error = -EBADF;
> -	f = fdget(fd);
> -	if (!fd_file(f))
> -		return error;
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
> +		return -EBADF;
>  
>  	if (type != F_UNLCK && !(fd_file(f)->f_mode & (FMODE_READ | FMODE_WRITE)))
> -		goto out_putf;
> +		return -EBADF;
>  
>  	flock_make_lock(fd_file(f), &fl, type);
>  
>  	error = security_file_lock(fd_file(f), fl.c.flc_type);
>  	if (error)
> -		goto out_putf;
> +		return error;
>  
>  	can_sleep = !(cmd & LOCK_NB);
>  	if (can_sleep)
> @@ -2177,9 +2175,6 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
>  		error = locks_lock_file_wait(fd_file(f), &fl);
>  
>  	locks_release_private(&fl);
> - out_putf:
> -	fdput(f);
> -
>  	return error;
>  }
>  
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 7c8248aca8bd..6fbb70272ebd 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3948,7 +3948,6 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
>  	struct file *file;
>  	struct path newmount;
>  	struct mount *mnt;
> -	struct fd f;
>  	unsigned int mnt_flags = 0;
>  	long ret;
>  
> @@ -3976,19 +3975,18 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
>  		return -EINVAL;
>  	}
>  
> -	f = fdget(fs_fd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(fs_fd);
> +	if (fd_empty(f))
>  		return -EBADF;
>  
> -	ret = -EINVAL;
>  	if (fd_file(f)->f_op != &fscontext_fops)
> -		goto err_fsfd;
> +		return -EINVAL;
>  
>  	fc = fd_file(f)->private_data;
>  
>  	ret = mutex_lock_interruptible(&fc->uapi_mutex);
>  	if (ret < 0)
> -		goto err_fsfd;
> +		return ret;
>  
>  	/* There must be a valid superblock or we can't mount it */
>  	ret = -EINVAL;
> @@ -4055,8 +4053,6 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
>  	path_put(&newmount);
>  err_unlock:
>  	mutex_unlock(&fc->uapi_mutex);
> -err_fsfd:
> -	fdput(f);
>  	return ret;
>  }
>  
> @@ -4507,10 +4503,8 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
>  static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
>  				struct mount_kattr *kattr, unsigned int flags)
>  {
> -	int err = 0;
>  	struct ns_common *ns;
>  	struct user_namespace *mnt_userns;
> -	struct fd f;
>  
>  	if (!((attr->attr_set | attr->attr_clr) & MOUNT_ATTR_IDMAP))
>  		return 0;
> @@ -4526,20 +4520,16 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
>  	if (attr->userns_fd > INT_MAX)
>  		return -EINVAL;
>  
> -	f = fdget(attr->userns_fd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(attr->userns_fd);
> +	if (fd_empty(f))
>  		return -EBADF;
>  
> -	if (!proc_ns_file(fd_file(f))) {
> -		err = -EINVAL;
> -		goto out_fput;
> -	}
> +	if (!proc_ns_file(fd_file(f)))
> +		return -EINVAL;
>  
>  	ns = get_proc_ns(file_inode(fd_file(f)));
> -	if (ns->ops->type != CLONE_NEWUSER) {
> -		err = -EINVAL;
> -		goto out_fput;
> -	}
> +	if (ns->ops->type != CLONE_NEWUSER)
> +		return -EINVAL;
>  
>  	/*
>  	 * The initial idmapping cannot be used to create an idmapped
> @@ -4550,22 +4540,15 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
>  	 * result.
>  	 */
>  	mnt_userns = container_of(ns, struct user_namespace, ns);
> -	if (mnt_userns == &init_user_ns) {
> -		err = -EPERM;
> -		goto out_fput;
> -	}
> +	if (mnt_userns == &init_user_ns)
> +		return -EPERM;
>  
>  	/* We're not controlling the target namespace. */
> -	if (!ns_capable(mnt_userns, CAP_SYS_ADMIN)) {
> -		err = -EPERM;
> -		goto out_fput;
> -	}
> +	if (!ns_capable(mnt_userns, CAP_SYS_ADMIN))
> +		return -EPERM;
>  
>  	kattr->mnt_userns = get_user_ns(mnt_userns);
> -
> -out_fput:
> -	fdput(f);
> -	return err;
> +	return 0;
>  }
>  
>  static int build_mount_kattr(const struct mount_attr *attr, size_t usize,
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 13454e5fd3fb..7b5abc1b8c8f 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1003,22 +1003,17 @@ static int fanotify_find_path(int dfd, const char __user *filename,
>  		 dfd, filename, flags);
>  
>  	if (filename == NULL) {
> -		struct fd f = fdget(dfd);
> +		CLASS(fd, f)(dfd);
>  
> -		ret = -EBADF;
> -		if (!fd_file(f))
> -			goto out;
> +		if (fd_empty(f))
> +			return -EBADF;
>  
> -		ret = -ENOTDIR;
>  		if ((flags & FAN_MARK_ONLYDIR) &&
> -		    !(S_ISDIR(file_inode(fd_file(f))->i_mode))) {
> -			fdput(f);
> -			goto out;
> -		}
> +		    !(S_ISDIR(file_inode(fd_file(f))->i_mode)))
> +			return -ENOTDIR;
>  
>  		*path = fd_file(f)->f_path;
>  		path_get(path);
> -		fdput(f);
>  	} else {
>  		unsigned int lookup_flags = 0;
>  
> @@ -1682,7 +1677,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	struct inode *inode = NULL;
>  	struct vfsmount *mnt = NULL;
>  	struct fsnotify_group *group;
> -	struct fd f;
>  	struct path path;
>  	struct fan_fsid __fsid, *fsid = NULL;
>  	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
> @@ -1752,14 +1746,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		umask = FANOTIFY_EVENT_FLAGS;
>  	}
>  
> -	f = fdget(fanotify_fd);
> -	if (unlikely(!fd_file(f)))
> +	CLASS(fd, f)(fanotify_fd);
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	/* verify that this is indeed an fanotify instance */
> -	ret = -EINVAL;
>  	if (unlikely(fd_file(f)->f_op != &fanotify_fops))
> -		goto fput_and_out;
> +		return -EINVAL;
>  	group = fd_file(f)->private_data;
>  
>  	/*
> @@ -1767,23 +1760,21 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	 * marks.  This also includes setting up such marks by a group that
>  	 * was initialized by an unprivileged user.
>  	 */
> -	ret = -EPERM;
>  	if ((!capable(CAP_SYS_ADMIN) ||
>  	     FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
>  	    mark_type != FAN_MARK_INODE)
> -		goto fput_and_out;
> +		return -EPERM;
>  
>  	/*
>  	 * Permission events require minimum priority FAN_CLASS_CONTENT.
>  	 */
> -	ret = -EINVAL;
>  	if (mask & FANOTIFY_PERM_EVENTS &&
>  	    group->priority < FSNOTIFY_PRIO_CONTENT)
> -		goto fput_and_out;
> +		return -EINVAL;
>  
>  	if (mask & FAN_FS_ERROR &&
>  	    mark_type != FAN_MARK_FILESYSTEM)
> -		goto fput_and_out;
> +		return -EINVAL;
>  
>  	/*
>  	 * Evictable is only relevant for inode marks, because only inode object
> @@ -1791,7 +1782,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	 */
>  	if (flags & FAN_MARK_EVICTABLE &&
>  	     mark_type != FAN_MARK_INODE)
> -		goto fput_and_out;
> +		return -EINVAL;
>  
>  	/*
>  	 * Events that do not carry enough information to report
> @@ -1803,7 +1794,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
>  	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
>  	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
> -		goto fput_and_out;
> +		return -EINVAL;
>  
>  	/*
>  	 * FAN_RENAME uses special info type records to report the old and
> @@ -1811,23 +1802,22 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	 * useful and was not implemented.
>  	 */
>  	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
> -		goto fput_and_out;
> +		return -EINVAL;
>  
>  	if (mark_cmd == FAN_MARK_FLUSH) {
> -		ret = 0;
>  		if (mark_type == FAN_MARK_MOUNT)
>  			fsnotify_clear_vfsmount_marks_by_group(group);
>  		else if (mark_type == FAN_MARK_FILESYSTEM)
>  			fsnotify_clear_sb_marks_by_group(group);
>  		else
>  			fsnotify_clear_inode_marks_by_group(group);
> -		goto fput_and_out;
> +		return 0;
>  	}
>  
>  	ret = fanotify_find_path(dfd, pathname, &path, flags,
>  			(mask & ALL_FSNOTIFY_EVENTS), obj_type);
>  	if (ret)
> -		goto fput_and_out;
> +		return ret;
>  
>  	if (mark_cmd == FAN_MARK_ADD) {
>  		ret = fanotify_events_supported(group, &path, mask, flags);
> @@ -1906,8 +1896,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  
>  path_put_and_out:
>  	path_put(&path);
> -fput_and_out:
> -	fdput(f);
>  	return ret;
>  }
>  
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index c7e451d5bd51..f46ec6afee3c 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -732,7 +732,6 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
>  	struct fsnotify_group *group;
>  	struct inode *inode;
>  	struct path path;
> -	struct fd f;
>  	int ret;
>  	unsigned flags = 0;
>  
> @@ -752,21 +751,17 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
>  	if (unlikely(!(mask & ALL_INOTIFY_BITS)))
>  		return -EINVAL;
>  
> -	f = fdget(fd);
> -	if (unlikely(!fd_file(f)))
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	/* IN_MASK_ADD and IN_MASK_CREATE don't make sense together */
> -	if (unlikely((mask & IN_MASK_ADD) && (mask & IN_MASK_CREATE))) {
> -		ret = -EINVAL;
> -		goto fput_and_out;
> -	}
> +	if (unlikely((mask & IN_MASK_ADD) && (mask & IN_MASK_CREATE)))
> +		return -EINVAL;
>  
>  	/* verify that this is indeed an inotify instance */
> -	if (unlikely(fd_file(f)->f_op != &inotify_fops)) {
> -		ret = -EINVAL;
> -		goto fput_and_out;
> -	}
> +	if (unlikely(fd_file(f)->f_op != &inotify_fops))
> +		return -EINVAL;
>  
>  	if (!(mask & IN_DONT_FOLLOW))
>  		flags |= LOOKUP_FOLLOW;
> @@ -776,7 +771,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
>  	ret = inotify_find_inode(pathname, &path, flags,
>  			(mask & IN_ALL_EVENTS));
>  	if (ret)
> -		goto fput_and_out;
> +		return ret;
>  
>  	/* inode held in place by reference to path; group by fget on fd */
>  	inode = path.dentry->d_inode;
> @@ -785,8 +780,6 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
>  	/* create/update an inode mark */
>  	ret = inotify_update_watch(group, inode, mask);
>  	path_put(&path);
> -fput_and_out:
> -	fdput(f);
>  	return ret;
>  }
>  
> @@ -794,33 +787,26 @@ SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
>  {
>  	struct fsnotify_group *group;
>  	struct inotify_inode_mark *i_mark;
> -	struct fd f;
> -	int ret = -EINVAL;
> +	CLASS(fd, f)(fd);
>  
> -	f = fdget(fd);
> -	if (unlikely(!fd_file(f)))
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	/* verify that this is indeed an inotify instance */
>  	if (unlikely(fd_file(f)->f_op != &inotify_fops))
> -		goto out;
> +		return -EINVAL;
>  
>  	group = fd_file(f)->private_data;
>  
>  	i_mark = inotify_idr_find(group, wd);
>  	if (unlikely(!i_mark))
> -		goto out;
> -
> -	ret = 0;
> +		return -EINVAL;
>  
>  	fsnotify_destroy_mark(&i_mark->fsn_mark, group);
>  
>  	/* match ref taken by inotify_idr_find */
>  	fsnotify_put_mark(&i_mark->fsn_mark);
> -
> -out:
> -	fdput(f);
> -	return ret;
> +	return 0;
>  }
>  
>  /*
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index 4b9f45d7049e..08d9ac1b137f 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -1765,7 +1765,6 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
>  	long fd;
>  	int sectsize;
>  	char *p = (char *)page;
> -	struct fd f;
>  	ssize_t ret = -EINVAL;
>  	int live_threshold;
>  
> @@ -1784,23 +1783,23 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
>  	if (fd < 0 || fd >= INT_MAX)
>  		goto out;
>  
> -	f = fdget(fd);
> -	if (fd_file(f) == NULL)
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
>  		goto out;
>  
>  	if (reg->hr_blocks == 0 || reg->hr_start_block == 0 ||
>  	    reg->hr_block_bytes == 0)
> -		goto out2;
> +		goto out;
>  
>  	if (!S_ISBLK(fd_file(f)->f_mapping->host->i_mode))
> -		goto out2;
> +		goto out;
>  
>  	reg->hr_bdev_file = bdev_file_open_by_dev(fd_file(f)->f_mapping->host->i_rdev,
>  			BLK_OPEN_WRITE | BLK_OPEN_READ, NULL, NULL);
>  	if (IS_ERR(reg->hr_bdev_file)) {
>  		ret = PTR_ERR(reg->hr_bdev_file);
>  		reg->hr_bdev_file = NULL;
> -		goto out2;
> +		goto out;
>  	}
>  
>  	sectsize = bdev_logical_block_size(reg_bdev(reg));
> @@ -1906,8 +1905,6 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
>  		fput(reg->hr_bdev_file);
>  		reg->hr_bdev_file = NULL;
>  	}
> -out2:
> -	fdput(f);
>  out:
>  	return ret;
>  }
> diff --git a/fs/open.c b/fs/open.c
> index 4cb5e12e84a5..71e166e0907c 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -187,19 +187,13 @@ long do_ftruncate(struct file *file, loff_t length, int small)
>  
>  long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
>  {
> -	struct fd f;
> -	int error;
> -
>  	if (length < 0)
>  		return -EINVAL;
> -	f = fdget(fd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
>  		return -EBADF;
>  
> -	error = do_ftruncate(fd_file(f), length, small);
> -
> -	fdput(f);
> -	return error;
> +	return do_ftruncate(fd_file(f), length, small);
>  }
>  
>  SYSCALL_DEFINE2(ftruncate, unsigned int, fd, unsigned long, length)
> @@ -346,14 +340,12 @@ EXPORT_SYMBOL_GPL(vfs_fallocate);
>  
>  int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len)
>  {
> -	struct fd f = fdget(fd);
> -	int error = -EBADF;
> +	CLASS(fd, f)(fd);
>  
> -	if (fd_file(f)) {
> -		error = vfs_fallocate(fd_file(f), mode, offset, len);
> -		fdput(f);
> -	}
> -	return error;
> +	if (fd_empty(f))
> +		return -EBADF;
> +
> +	return vfs_fallocate(fd_file(f), mode, offset, len);
>  }
>  
>  SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
> @@ -663,14 +655,12 @@ int vfs_fchmod(struct file *file, umode_t mode)
>  
>  SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
>  {
> -	struct fd f = fdget(fd);
> -	int err = -EBADF;
> +	CLASS(fd, f)(fd);
>  
> -	if (fd_file(f)) {
> -		err = vfs_fchmod(fd_file(f), mode);
> -		fdput(f);
> -	}
> -	return err;
> +	if (fd_empty(f))
> +		return -EBADF;
> +
> +	return vfs_fchmod(fd_file(f), mode);
>  }
>  
>  static int do_fchmodat(int dfd, const char __user *filename, umode_t mode,
> @@ -857,14 +847,12 @@ int vfs_fchown(struct file *file, uid_t user, gid_t group)
>  
>  int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
>  {
> -	struct fd f = fdget(fd);
> -	int error = -EBADF;
> +	CLASS(fd, f)(fd);
>  
> -	if (fd_file(f)) {
> -		error = vfs_fchown(fd_file(f), user, group);
> -		fdput(f);
> -	}
> -	return error;
> +	if (fd_empty(f))
> +		return -EBADF;
> +
> +	return vfs_fchown(fd_file(f), user, group);
>  }
>  
>  SYSCALL_DEFINE3(fchown, unsigned int, fd, uid_t, user, gid_t, group)
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 6d49202e2507..4d3067381915 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -652,21 +652,17 @@ SYSCALL_DEFINE3(write, unsigned int, fd, const char __user *, buf,
>  ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
>  		     loff_t pos)
>  {
> -	struct fd f;
> -	ssize_t ret = -EBADF;
> -
>  	if (pos < 0)
>  		return -EINVAL;
>  
> -	f = fdget(fd);
> -	if (fd_file(f)) {
> -		ret = -ESPIPE;
> -		if (fd_file(f)->f_mode & FMODE_PREAD)
> -			ret = vfs_read(fd_file(f), buf, count, &pos);
> -		fdput(f);
> -	}
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
> +		return -EBADF;
>  
> -	return ret;
> +	if (fd_file(f)->f_mode & FMODE_PREAD)
> +		return vfs_read(fd_file(f), buf, count, &pos);
> +
> +	return -ESPIPE;
>  }
>  
>  SYSCALL_DEFINE4(pread64, unsigned int, fd, char __user *, buf,
> @@ -686,21 +682,17 @@ COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, buf,
>  ssize_t ksys_pwrite64(unsigned int fd, const char __user *buf,
>  		      size_t count, loff_t pos)
>  {
> -	struct fd f;
> -	ssize_t ret = -EBADF;
> -
>  	if (pos < 0)
>  		return -EINVAL;
>  
> -	f = fdget(fd);
> -	if (fd_file(f)) {
> -		ret = -ESPIPE;
> -		if (fd_file(f)->f_mode & FMODE_PWRITE)
> -			ret = vfs_write(fd_file(f), buf, count, &pos);
> -		fdput(f);
> -	}
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
> +		return -EBADF;
>  
> -	return ret;
> +	if (fd_file(f)->f_mode & FMODE_PWRITE)
> +		return vfs_write(fd_file(f), buf, count, &pos);
> +
> +	return -ESPIPE;
>  }
>  
>  SYSCALL_DEFINE4(pwrite64, unsigned int, fd, const char __user *, buf,
> @@ -1028,18 +1020,16 @@ static inline loff_t pos_from_hilo(unsigned long high, unsigned long low)
>  static ssize_t do_preadv(unsigned long fd, const struct iovec __user *vec,
>  			 unsigned long vlen, loff_t pos, rwf_t flags)
>  {
> -	struct fd f;
>  	ssize_t ret = -EBADF;
>  
>  	if (pos < 0)
>  		return -EINVAL;
>  
> -	f = fdget(fd);
> -	if (fd_file(f)) {
> +	CLASS(fd, f)(fd);
> +	if (!fd_empty(f)) {
>  		ret = -ESPIPE;
>  		if (fd_file(f)->f_mode & FMODE_PREAD)
>  			ret = vfs_readv(fd_file(f), vec, vlen, &pos, flags);
> -		fdput(f);
>  	}
>  
>  	if (ret > 0)
> @@ -1051,18 +1041,16 @@ static ssize_t do_preadv(unsigned long fd, const struct iovec __user *vec,
>  static ssize_t do_pwritev(unsigned long fd, const struct iovec __user *vec,
>  			  unsigned long vlen, loff_t pos, rwf_t flags)
>  {
> -	struct fd f;
>  	ssize_t ret = -EBADF;
>  
>  	if (pos < 0)
>  		return -EINVAL;
>  
> -	f = fdget(fd);
> -	if (fd_file(f)) {
> +	CLASS(fd, f)(fd);
> +	if (!fd_empty(f)) {
>  		ret = -ESPIPE;
>  		if (fd_file(f)->f_mode & FMODE_PWRITE)
>  			ret = vfs_writev(fd_file(f), vec, vlen, &pos, flags);
> -		fdput(f);
>  	}
>  
>  	if (ret > 0)
> @@ -1214,7 +1202,6 @@ COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
>  static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
>  			   size_t count, loff_t max)
>  {
> -	struct fd in, out;
>  	struct inode *in_inode, *out_inode;
>  	struct pipe_inode_info *opipe;
>  	loff_t pos;
> @@ -1225,35 +1212,32 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
>  	/*
>  	 * Get input file, and verify that it is ok..
>  	 */
> -	retval = -EBADF;
> -	in = fdget(in_fd);
> -	if (!fd_file(in))
> -		goto out;
> +	CLASS(fd, in)(in_fd);
> +	if (fd_empty(in))
> +		return -EBADF;
>  	if (!(fd_file(in)->f_mode & FMODE_READ))
> -		goto fput_in;
> -	retval = -ESPIPE;
> +		return -EBADF;
>  	if (!ppos) {
>  		pos = fd_file(in)->f_pos;
>  	} else {
>  		pos = *ppos;
>  		if (!(fd_file(in)->f_mode & FMODE_PREAD))
> -			goto fput_in;
> +			return -ESPIPE;
>  	}
>  	retval = rw_verify_area(READ, fd_file(in), &pos, count);
>  	if (retval < 0)
> -		goto fput_in;
> +		return retval;
>  	if (count > MAX_RW_COUNT)
>  		count =  MAX_RW_COUNT;
>  
>  	/*
>  	 * Get output file, and verify that it is ok..
>  	 */
> -	retval = -EBADF;
> -	out = fdget(out_fd);
> -	if (!fd_file(out))
> -		goto fput_in;
> +	CLASS(fd, out)(out_fd);
> +	if (fd_empty(out))
> +		return -EBADF;
>  	if (!(fd_file(out)->f_mode & FMODE_WRITE))
> -		goto fput_out;
> +		return -EBADF;
>  	in_inode = file_inode(fd_file(in));
>  	out_inode = file_inode(fd_file(out));
>  	out_pos = fd_file(out)->f_pos;
> @@ -1262,9 +1246,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
>  		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);
>  
>  	if (unlikely(pos + count > max)) {
> -		retval = -EOVERFLOW;
>  		if (pos >= max)
> -			goto fput_out;
> +			return -EOVERFLOW;
>  		count = max - pos;
>  	}
>  
> @@ -1283,7 +1266,7 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
>  	if (!opipe) {
>  		retval = rw_verify_area(WRITE, fd_file(out), &out_pos, count);
>  		if (retval < 0)
> -			goto fput_out;
> +			return retval;
>  		retval = do_splice_direct(fd_file(in), &pos, fd_file(out), &out_pos,
>  					  count, fl);
>  	} else {
> @@ -1309,12 +1292,6 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
>  	inc_syscw(current);
>  	if (pos > max)
>  		retval = -EOVERFLOW;
> -
> -fput_out:
> -	fdput(out);
> -fput_in:
> -	fdput(in);
> -out:
>  	return retval;
>  }
>  
> @@ -1570,36 +1547,32 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
>  {
>  	loff_t pos_in;
>  	loff_t pos_out;
> -	struct fd f_in;
> -	struct fd f_out;
>  	ssize_t ret = -EBADF;
>  
> -	f_in = fdget(fd_in);
> -	if (!fd_file(f_in))
> -		goto out2;
> +	CLASS(fd, f_in)(fd_in);
> +	if (fd_empty(f_in))
> +		return -EBADF;
>  
> -	f_out = fdget(fd_out);
> -	if (!fd_file(f_out))
> -		goto out1;
> +	CLASS(fd, f_out)(fd_out);
> +	if (fd_empty(f_out))
> +		return -EBADF;
>  
> -	ret = -EFAULT;
>  	if (off_in) {
>  		if (copy_from_user(&pos_in, off_in, sizeof(loff_t)))
> -			goto out;
> +			return -EFAULT;
>  	} else {
>  		pos_in = fd_file(f_in)->f_pos;
>  	}
>  
>  	if (off_out) {
>  		if (copy_from_user(&pos_out, off_out, sizeof(loff_t)))
> -			goto out;
> +			return -EFAULT;
>  	} else {
>  		pos_out = fd_file(f_out)->f_pos;
>  	}
>  
> -	ret = -EINVAL;
>  	if (flags != 0)
> -		goto out;
> +		return -EINVAL;
>  
>  	ret = vfs_copy_file_range(fd_file(f_in), pos_in, fd_file(f_out), pos_out, len,
>  				  flags);
> @@ -1621,12 +1594,6 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
>  			fd_file(f_out)->f_pos = pos_out;
>  		}
>  	}
> -
> -out:
> -	fdput(f_out);
> -out1:
> -	fdput(f_in);
> -out2:
>  	return ret;
>  }
>  
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 4403d5c68fcb..26afbbbfb10c 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -536,20 +536,19 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
>  	}
>  
>  	for (i = 0, info = same->info; i < count; i++, info++) {
> -		struct fd dst_fd = fdget(info->dest_fd);
> -		struct file *dst_file = fd_file(dst_fd);
> +		CLASS(fd, dst_fd)(info->dest_fd);
>  
> -		if (!dst_file) {
> +		if (fd_empty(dst_fd)) {
>  			info->status = -EBADF;
>  			goto next_loop;
>  		}
>  
>  		if (info->reserved) {
>  			info->status = -EINVAL;
> -			goto next_fdput;
> +			goto next_loop;
>  		}
>  
> -		deduped = vfs_dedupe_file_range_one(file, off, dst_file,
> +		deduped = vfs_dedupe_file_range_one(file, off, fd_file(dst_fd),
>  						    info->dest_offset, len,
>  						    REMAP_FILE_CAN_SHORTEN);
>  		if (deduped == -EBADE)
> @@ -559,8 +558,6 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
>  		else
>  			info->bytes_deduped = len;
>  
> -next_fdput:
> -		fdput(dst_fd);
>  next_loop:
>  		if (fatal_signal_pending(current))
>  			break;
> diff --git a/fs/select.c b/fs/select.c
> index 97e1009dde00..0befca98af60 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -525,19 +525,16 @@ static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec
>  			}
>  
>  			for (j = 0; j < BITS_PER_LONG; ++j, ++i, bit <<= 1) {
> -				struct fd f;
>  				if (i >= n)
>  					break;
>  				if (!(bit & all_bits))
>  					continue;
>  				mask = EPOLLNVAL;
> -				f = fdget(i);
> -				if (fd_file(f)) {
> +				CLASS(fd, f)(i);
> +				if (!fd_empty(f)) {
>  					wait_key_set(wait, in, out, bit,
>  						     busy_flag);
>  					mask = vfs_poll(fd_file(f), wait);
> -
> -					fdput(f);
>  				}
>  				if ((mask & POLLIN_SET) && (in & bit)) {
>  					res_in |= bit;
> @@ -858,13 +855,12 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
>  {
>  	int fd = pollfd->fd;
>  	__poll_t mask = 0, filter;
> -	struct fd f;
>  
>  	if (fd < 0)
>  		goto out;
>  	mask = EPOLLNVAL;
> -	f = fdget(fd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
>  		goto out;
>  
>  	/* userland u16 ->events contains POLL... bitmap */
> @@ -874,7 +870,6 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
>  	if (mask & busy_flag)
>  		*can_busy_poll = true;
>  	mask &= filter;		/* Mask out unneeded events. */
> -	fdput(f);
>  
>  out:
>  	/* ... and so does ->revents */
> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index c39cf00ab28a..cc7af00b8527 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -292,20 +292,17 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
>  		 */
>  		fd_install(ufd, file);
>  	} else {
> -		struct fd f = fdget(ufd);
> -		if (!fd_file(f))
> +		CLASS(fd, f)(ufd);
> +		if (fd_empty(f))
>  			return -EBADF;
>  		ctx = fd_file(f)->private_data;
> -		if (fd_file(f)->f_op != &signalfd_fops) {
> -			fdput(f);
> +		if (fd_file(f)->f_op != &signalfd_fops)
>  			return -EINVAL;
> -		}
>  		spin_lock_irq(&current->sighand->siglock);
>  		ctx->sigmask = *mask;
>  		spin_unlock_irq(&current->sighand->siglock);
>  
>  		wake_up(&current->sighand->signalfd_wqh);
> -		fdput(f);
>  	}
>  
>  	return ufd;
> diff --git a/fs/smb/client/ioctl.c b/fs/smb/client/ioctl.c
> index 94bf2e5014d9..6d9df3646df3 100644
> --- a/fs/smb/client/ioctl.c
> +++ b/fs/smb/client/ioctl.c
> @@ -72,7 +72,6 @@ static long cifs_ioctl_copychunk(unsigned int xid, struct file *dst_file,
>  			unsigned long srcfd)
>  {
>  	int rc;
> -	struct fd src_file;
>  	struct inode *src_inode;
>  
>  	cifs_dbg(FYI, "ioctl copychunk range\n");
> @@ -89,8 +88,8 @@ static long cifs_ioctl_copychunk(unsigned int xid, struct file *dst_file,
>  		return rc;
>  	}
>  
> -	src_file = fdget(srcfd);
> -	if (!fd_file(src_file)) {
> +	CLASS(fd, src_file)(srcfd);
> +	if (fd_empty(src_file)) {
>  		rc = -EBADF;
>  		goto out_drop_write;
>  	}
> @@ -98,20 +97,18 @@ static long cifs_ioctl_copychunk(unsigned int xid, struct file *dst_file,
>  	if (fd_file(src_file)->f_op->unlocked_ioctl != cifs_ioctl) {
>  		rc = -EBADF;
>  		cifs_dbg(VFS, "src file seems to be from a different filesystem type\n");
> -		goto out_fput;
> +		goto out_drop_write;
>  	}
>  
>  	src_inode = file_inode(fd_file(src_file));
>  	rc = -EINVAL;
>  	if (S_ISDIR(src_inode->i_mode))
> -		goto out_fput;
> +		goto out_drop_write;
>  
>  	rc = cifs_file_copychunk_range(xid, fd_file(src_file), 0, dst_file, 0,
>  					src_inode->i_size, 0);
>  	if (rc > 0)
>  		rc = 0;
> -out_fput:
> -	fdput(src_file);
>  out_drop_write:
>  	mnt_drop_write_file(dst_file);
>  	return rc;
> diff --git a/fs/splice.c b/fs/splice.c
> index 06232d7e505f..42aa7bc46be5 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1626,8 +1626,6 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
>  		error = vmsplice_to_user(fd_file(f), &iter, flags);
>  
>  	kfree(iov);
> -out_fdput:
> -	fdput(f);
>  	return error;
>  }
>  
> @@ -1635,27 +1633,22 @@ SYSCALL_DEFINE6(splice, int, fd_in, loff_t __user *, off_in,
>  		int, fd_out, loff_t __user *, off_out,
>  		size_t, len, unsigned int, flags)
>  {
> -	struct fd in, out;
> -	ssize_t error;
> -
>  	if (unlikely(!len))
>  		return 0;
>  
>  	if (unlikely(flags & ~SPLICE_F_ALL))
>  		return -EINVAL;
>  
> -	error = -EBADF;
> -	in = fdget(fd_in);
> -	if (fd_file(in)) {
> -		out = fdget(fd_out);
> -		if (fd_file(out)) {
> -			error = __do_splice(fd_file(in), off_in, fd_file(out), off_out,
> +	CLASS(fd, in)(fd_in);
> +	if (fd_empty(in))
> +		return -EBADF;
> +
> +	CLASS(fd, out)(fd_out);
> +	if (fd_empty(out))
> +		return -EBADF;
> +
> +	return __do_splice(fd_file(in), off_in, fd_file(out), off_out,
>  					    len, flags);
> -			fdput(out);
> -		}
> -		fdput(in);
> -	}
> -	return error;
>  }
>  
>  /*
> @@ -2005,25 +1998,19 @@ ssize_t do_tee(struct file *in, struct file *out, size_t len,
>  
>  SYSCALL_DEFINE4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags)
>  {
> -	struct fd in, out;
> -	ssize_t error;
> -
>  	if (unlikely(flags & ~SPLICE_F_ALL))
>  		return -EINVAL;
>  
>  	if (unlikely(!len))
>  		return 0;
>  
> -	error = -EBADF;
> -	in = fdget(fdin);
> -	if (fd_file(in)) {
> -		out = fdget(fdout);
> -		if (fd_file(out)) {
> -			error = do_tee(fd_file(in), fd_file(out), len, flags);
> -			fdput(out);
> -		}
> - 		fdput(in);
> - 	}
> +	CLASS(fd, in)(fdin);
> +	if (fd_empty(in))
> +		return -EBADF;
>  
> -	return error;
> +	CLASS(fd, out)(fdout);
> +	if (fd_empty(out))
> +		return -EBADF;
> +
> +	return do_tee(fd_file(in), fd_file(out), len, flags);
>  }
> diff --git a/fs/sync.c b/fs/sync.c
> index 67df255eb189..2955cd4c77a3 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -148,11 +148,11 @@ void emergency_sync(void)
>   */
>  SYSCALL_DEFINE1(syncfs, int, fd)
>  {
> -	struct fd f = fdget(fd);
> +	CLASS(fd, f)(fd);
>  	struct super_block *sb;
>  	int ret, ret2;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  	sb = fd_file(f)->f_path.dentry->d_sb;
>  
> @@ -162,7 +162,6 @@ SYSCALL_DEFINE1(syncfs, int, fd)
>  
>  	ret2 = errseq_check_and_advance(&sb->s_wb_err, &fd_file(f)->f_sb_err);
>  
> -	fdput(f);
>  	return ret ? ret : ret2;
>  }
>  
> @@ -205,14 +204,12 @@ EXPORT_SYMBOL(vfs_fsync);
>  
>  static int do_fsync(unsigned int fd, int datasync)
>  {
> -	struct fd f = fdget(fd);
> -	int ret = -EBADF;
> +	CLASS(fd, f)(fd);
>  
> -	if (fd_file(f)) {
> -		ret = vfs_fsync(fd_file(f), datasync);
> -		fdput(f);
> -	}
> -	return ret;
> +	if (fd_empty(f))
> +		return -EBADF;
> +
> +	return vfs_fsync(fd_file(f), datasync);
>  }
>  
>  SYSCALL_DEFINE1(fsync, unsigned int, fd)
> @@ -355,16 +352,12 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
>  int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
>  			 unsigned int flags)
>  {
> -	int ret;
> -	struct fd f;
> +	CLASS(fd, f)(fd);
>  
> -	ret = -EBADF;
> -	f = fdget(fd);
> -	if (fd_file(f))
> -		ret = sync_file_range(fd_file(f), offset, nbytes, flags);
> +	if (fd_empty(f))
> +		return -EBADF;
>  
> -	fdput(f);
> -	return ret;
> +	return sync_file_range(fd_file(f), offset, nbytes, flags);
>  }
>  
>  SYSCALL_DEFINE4(sync_file_range, int, fd, loff_t, offset, loff_t, nbytes,
> diff --git a/fs/utimes.c b/fs/utimes.c
> index 99b26f792b89..c7c7958e57b2 100644
> --- a/fs/utimes.c
> +++ b/fs/utimes.c
> @@ -108,18 +108,13 @@ static int do_utimes_path(int dfd, const char __user *filename,
>  
>  static int do_utimes_fd(int fd, struct timespec64 *times, int flags)
>  {
> -	struct fd f;
> -	int error;
> -
>  	if (flags)
>  		return -EINVAL;
>  
> -	f = fdget(fd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
>  		return -EBADF;
> -	error = vfs_utimes(&fd_file(f)->f_path, times);
> -	fdput(f);
> -	return error;
> +	return vfs_utimes(&fd_file(f)->f_path, times);
>  }
>  
>  /*
> diff --git a/fs/xattr.c b/fs/xattr.c
> index d4f84f57e703..980dc1710e97 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -697,11 +697,11 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
>  SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
>  		const void __user *,value, size_t, size, int, flags)
>  {
> -	struct fd f = fdget(fd);
> -	int error = -EBADF;
> +	CLASS(fd, f)(fd);
> +	int error;
>  
> -	if (!fd_file(f))
> -		return error;
> +	if (fd_empty(f))
> +		return -EBADF;
>  	audit_file(fd_file(f));
>  	error = mnt_want_write_file(fd_file(f));
>  	if (!error) {
> @@ -710,7 +710,6 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
>  				 value, size, flags);
>  		mnt_drop_write_file(fd_file(f));
>  	}
> -	fdput(f);
>  	return error;
>  }
>  
> @@ -808,16 +807,13 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
>  SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
>  		void __user *, value, size_t, size)
>  {
> -	struct fd f = fdget(fd);
> -	ssize_t error = -EBADF;
> +	CLASS(fd, f)(fd);
>  
> -	if (!fd_file(f))
> -		return error;
> +	if (fd_empty(f))
> +		return -EBADF;
>  	audit_file(fd_file(f));
> -	error = getxattr(file_mnt_idmap(fd_file(f)), fd_file(f)->f_path.dentry,
> +	return getxattr(file_mnt_idmap(fd_file(f)), fd_file(f)->f_path.dentry,
>  			 name, value, size);
> -	fdput(f);
> -	return error;
>  }
>  
>  /*
> @@ -884,15 +880,12 @@ SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
>  
>  SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
>  {
> -	struct fd f = fdget(fd);
> -	ssize_t error = -EBADF;
> +	CLASS(fd, f)(fd);
>  
> -	if (!fd_file(f))
> -		return error;
> +	if (fd_empty(f))
> +		return -EBADF;
>  	audit_file(fd_file(f));
> -	error = listxattr(fd_file(f)->f_path.dentry, list, size);
> -	fdput(f);
> -	return error;
> +	return listxattr(fd_file(f)->f_path.dentry, list, size);
>  }
>  
>  /*
> @@ -953,11 +946,11 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
>  
>  SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
>  {
> -	struct fd f = fdget(fd);
> -	int error = -EBADF;
> +	CLASS(fd, f)(fd);
> +	int error;
>  
> -	if (!fd_file(f))
> -		return error;
> +	if (fd_empty(f))
> +		return -EBADF;
>  	audit_file(fd_file(f));
>  	error = mnt_want_write_file(fd_file(f));
>  	if (!error) {
> @@ -965,7 +958,6 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
>  				    fd_file(f)->f_path.dentry, name);
>  		mnt_drop_write_file(fd_file(f));
>  	}
> -	fdput(f);
>  	return error;
>  }
>  
> diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
> index 9790e0f45d14..35b9b58a4f6f 100644
> --- a/fs/xfs/xfs_exchrange.c
> +++ b/fs/xfs/xfs_exchrange.c
> @@ -778,8 +778,6 @@ xfs_ioc_exchange_range(
>  		.file2			= file,
>  	};
>  	struct xfs_exchange_range	args;
> -	struct fd			file1;
> -	int				error;
>  
>  	if (copy_from_user(&args, argp, sizeof(args)))
>  		return -EFAULT;
> @@ -793,12 +791,10 @@ xfs_ioc_exchange_range(
>  	fxr.length		= args.length;
>  	fxr.flags		= args.flags;
>  
> -	file1 = fdget(args.file1_fd);
> -	if (!fd_file(file1))
> +	CLASS(fd, file1)(args.file1_fd);
> +	if (fd_empty(file1))
>  		return -EBADF;
>  	fxr.file1 = fd_file(file1);
>  
> -	error = xfs_exchange_range(&fxr);
> -	fdput(file1);
> -	return error;
> +	return xfs_exchange_range(&fxr);
>  }
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index c8b432fb7b40..4458ddf5dec5 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1060,41 +1060,29 @@ xfs_ioc_swapext(
>  	xfs_swapext_t	*sxp)
>  {
>  	xfs_inode_t     *ip, *tip;
> -	struct fd	f, tmp;
> -	int		error = 0;
>  
>  	/* Pull information for the target fd */
> -	f = fdget((int)sxp->sx_fdtarget);
> -	if (!fd_file(f)) {
> -		error = -EINVAL;
> -		goto out;
> -	}
> +	CLASS(fd, f)((int)sxp->sx_fdtarget);
> +	if (fd_empty(f))
> +		return -EINVAL;
>  
>  	if (!(fd_file(f)->f_mode & FMODE_WRITE) ||
>  	    !(fd_file(f)->f_mode & FMODE_READ) ||
> -	    (fd_file(f)->f_flags & O_APPEND)) {
> -		error = -EBADF;
> -		goto out_put_file;
> -	}
> +	    (fd_file(f)->f_flags & O_APPEND))
> +		return -EBADF;
>  
> -	tmp = fdget((int)sxp->sx_fdtmp);
> -	if (!fd_file(tmp)) {
> -		error = -EINVAL;
> -		goto out_put_file;
> -	}
> +	CLASS(fd, tmp)((int)sxp->sx_fdtmp);
> +	if (fd_empty(tmp))
> +		return -EINVAL;
>  
>  	if (!(fd_file(tmp)->f_mode & FMODE_WRITE) ||
>  	    !(fd_file(tmp)->f_mode & FMODE_READ) ||
> -	    (fd_file(tmp)->f_flags & O_APPEND)) {
> -		error = -EBADF;
> -		goto out_put_tmp_file;
> -	}
> +	    (fd_file(tmp)->f_flags & O_APPEND))
> +		return -EBADF;
>  
>  	if (IS_SWAPFILE(file_inode(fd_file(f))) ||
> -	    IS_SWAPFILE(file_inode(fd_file(tmp)))) {
> -		error = -EINVAL;
> -		goto out_put_tmp_file;
> -	}
> +	    IS_SWAPFILE(file_inode(fd_file(tmp))))
> +		return -EINVAL;
>  
>  	/*
>  	 * We need to ensure that the fds passed in point to XFS inodes
> @@ -1102,37 +1090,22 @@ xfs_ioc_swapext(
>  	 * control over what the user passes us here.
>  	 */
>  	if (fd_file(f)->f_op != &xfs_file_operations ||
> -	    fd_file(tmp)->f_op != &xfs_file_operations) {
> -		error = -EINVAL;
> -		goto out_put_tmp_file;
> -	}
> +	    fd_file(tmp)->f_op != &xfs_file_operations)
> +		return -EINVAL;
>  
>  	ip = XFS_I(file_inode(fd_file(f)));
>  	tip = XFS_I(file_inode(fd_file(tmp)));
>  
> -	if (ip->i_mount != tip->i_mount) {
> -		error = -EINVAL;
> -		goto out_put_tmp_file;
> -	}
> -
> -	if (ip->i_ino == tip->i_ino) {
> -		error = -EINVAL;
> -		goto out_put_tmp_file;
> -	}
> +	if (ip->i_mount != tip->i_mount)
> +		return -EINVAL;
>  
> -	if (xfs_is_shutdown(ip->i_mount)) {
> -		error = -EIO;
> -		goto out_put_tmp_file;
> -	}
> +	if (ip->i_ino == tip->i_ino)
> +		return -EINVAL;
>  
> -	error = xfs_swap_extents(ip, tip, sxp);
> +	if (xfs_is_shutdown(ip->i_mount))
> +		return -EIO;
>  
> - out_put_tmp_file:
> -	fdput(tmp);
> - out_put_file:
> -	fdput(f);
> - out:
> -	return error;
> +	return xfs_swap_extents(ip, tip, sxp);
>  }
>  
>  static int
> diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
> index ffa7d341bd95..26b1c14d5967 100644
> --- a/io_uring/sqpoll.c
> +++ b/io_uring/sqpoll.c
> @@ -105,29 +105,21 @@ static struct io_sq_data *io_attach_sq_data(struct io_uring_params *p)
>  {
>  	struct io_ring_ctx *ctx_attach;
>  	struct io_sq_data *sqd;
> -	struct fd f;
> +	CLASS(fd, f)(p->wq_fd);
>  
> -	f = fdget(p->wq_fd);
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return ERR_PTR(-ENXIO);
> -	if (!io_is_uring_fops(fd_file(f))) {
> -		fdput(f);
> +	if (!io_is_uring_fops(fd_file(f)))
>  		return ERR_PTR(-EINVAL);
> -	}
>  
>  	ctx_attach = fd_file(f)->private_data;
>  	sqd = ctx_attach->sq_data;
> -	if (!sqd) {
> -		fdput(f);
> +	if (!sqd)
>  		return ERR_PTR(-EINVAL);
> -	}
> -	if (sqd->task_tgid != current->tgid) {
> -		fdput(f);
> +	if (sqd->task_tgid != current->tgid)
>  		return ERR_PTR(-EPERM);
> -	}
>  
>  	refcount_inc(&sqd->refs);
> -	fdput(f);
>  	return sqd;
>  }
>  
> @@ -415,16 +407,11 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
>  	/* Retain compatibility with failing for an invalid attach attempt */
>  	if ((ctx->flags & (IORING_SETUP_ATTACH_WQ | IORING_SETUP_SQPOLL)) ==
>  				IORING_SETUP_ATTACH_WQ) {
> -		struct fd f;
> -
> -		f = fdget(p->wq_fd);
> -		if (!fd_file(f))
> +		CLASS(fd, f)(p->wq_fd);
> +		if (fd_empty(f))
>  			return -ENXIO;
> -		if (!io_is_uring_fops(fd_file(f))) {
> -			fdput(f);
> +		if (!io_is_uring_fops(fd_file(f)))
>  			return -EINVAL;
> -		}
> -		fdput(f);
>  	}
>  	if (ctx->flags & IORING_SETUP_SQPOLL) {
>  		struct task_struct *tsk;
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 9133a52be69b..c72ef725e845 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -1062,7 +1062,6 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
>  		size_t msg_len, unsigned int msg_prio,
>  		struct timespec64 *ts)
>  {
> -	struct fd f;
>  	struct inode *inode;
>  	struct ext_wait_queue wait;
>  	struct ext_wait_queue *receiver;
> @@ -1083,37 +1082,27 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
>  
>  	audit_mq_sendrecv(mqdes, msg_len, msg_prio, ts);
>  
> -	f = fdget(mqdes);
> -	if (unlikely(!fd_file(f))) {
> -		ret = -EBADF;
> -		goto out;
> -	}
> +	CLASS(fd, f)(mqdes);
> +	if (fd_empty(f))
> +		return -EBADF;
>  
>  	inode = file_inode(fd_file(f));
> -	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations)) {
> -		ret = -EBADF;
> -		goto out_fput;
> -	}
> +	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations))
> +		return -EBADF;
>  	info = MQUEUE_I(inode);
>  	audit_file(fd_file(f));
>  
> -	if (unlikely(!(fd_file(f)->f_mode & FMODE_WRITE))) {
> -		ret = -EBADF;
> -		goto out_fput;
> -	}
> +	if (unlikely(!(fd_file(f)->f_mode & FMODE_WRITE)))
> +		return -EBADF;
>  
> -	if (unlikely(msg_len > info->attr.mq_msgsize)) {
> -		ret = -EMSGSIZE;
> -		goto out_fput;
> -	}
> +	if (unlikely(msg_len > info->attr.mq_msgsize))
> +		return -EMSGSIZE;
>  
>  	/* First try to allocate memory, before doing anything with
>  	 * existing queues. */
>  	msg_ptr = load_msg(u_msg_ptr, msg_len);
> -	if (IS_ERR(msg_ptr)) {
> -		ret = PTR_ERR(msg_ptr);
> -		goto out_fput;
> -	}
> +	if (IS_ERR(msg_ptr))
> +		return PTR_ERR(msg_ptr);
>  	msg_ptr->m_ts = msg_len;
>  	msg_ptr->m_type = msg_prio;
>  
> @@ -1171,9 +1160,6 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
>  out_free:
>  	if (ret)
>  		free_msg(msg_ptr);
> -out_fput:
> -	fdput(f);
> -out:
>  	return ret;
>  }
>  
> @@ -1183,7 +1169,6 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>  {
>  	ssize_t ret;
>  	struct msg_msg *msg_ptr;
> -	struct fd f;
>  	struct inode *inode;
>  	struct mqueue_inode_info *info;
>  	struct ext_wait_queue wait;
> @@ -1197,30 +1182,22 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>  
>  	audit_mq_sendrecv(mqdes, msg_len, 0, ts);
>  
> -	f = fdget(mqdes);
> -	if (unlikely(!fd_file(f))) {
> -		ret = -EBADF;
> -		goto out;
> -	}
> +	CLASS(fd, f)(mqdes);
> +	if (fd_empty(f))
> +		return -EBADF;
>  
>  	inode = file_inode(fd_file(f));
> -	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations)) {
> -		ret = -EBADF;
> -		goto out_fput;
> -	}
> +	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations))
> +		return -EBADF;
>  	info = MQUEUE_I(inode);
>  	audit_file(fd_file(f));
>  
> -	if (unlikely(!(fd_file(f)->f_mode & FMODE_READ))) {
> -		ret = -EBADF;
> -		goto out_fput;
> -	}
> +	if (unlikely(!(fd_file(f)->f_mode & FMODE_READ)))
> +		return -EBADF;
>  
>  	/* checks if buffer is big enough */
> -	if (unlikely(msg_len < info->attr.mq_msgsize)) {
> -		ret = -EMSGSIZE;
> -		goto out_fput;
> -	}
> +	if (unlikely(msg_len < info->attr.mq_msgsize))
> +		return -EMSGSIZE;
>  
>  	/*
>  	 * msg_insert really wants us to have a valid, spare node struct so
> @@ -1274,9 +1251,6 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>  		}
>  		free_msg(msg_ptr);
>  	}
> -out_fput:
> -	fdput(f);
> -out:
>  	return ret;
>  }
>  
> @@ -1451,21 +1425,18 @@ SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
>  
>  static int do_mq_getsetattr(int mqdes, struct mq_attr *new, struct mq_attr *old)
>  {
> -	struct fd f;
>  	struct inode *inode;
>  	struct mqueue_inode_info *info;
>  
>  	if (new && (new->mq_flags & (~O_NONBLOCK)))
>  		return -EINVAL;
>  
> -	f = fdget(mqdes);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(mqdes);
> +	if (fd_empty(f))
>  		return -EBADF;
>  
> -	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations)) {
> -		fdput(f);
> +	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations))
>  		return -EBADF;
> -	}
>  
>  	inode = file_inode(fd_file(f));
>  	info = MQUEUE_I(inode);
> @@ -1489,7 +1460,6 @@ static int do_mq_getsetattr(int mqdes, struct mq_attr *new, struct mq_attr *old)
>  	}
>  
>  	spin_unlock(&info->lock);
> -	fdput(f);
>  	return 0;
>  }
>  
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a0e812c29c97..d0adca07b0b5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7505,21 +7505,16 @@ int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  struct btf *btf_get_by_fd(int fd)
>  {
>  	struct btf *btf;
> -	struct fd f;
> +	CLASS(fd, f)(fd);
>  
> -	f = fdget(fd);
> -
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return ERR_PTR(-EBADF);
>  
> -	if (fd_file(f)->f_op != &btf_fops) {
> -		fdput(f);
> +	if (fd_file(f)->f_op != &btf_fops)
>  		return ERR_PTR(-EINVAL);
> -	}
>  
>  	btf = fd_file(f)->private_data;
>  	refcount_inc(&btf->refcnt);
> -	fdput(f);
>  
>  	return btf;
>  }
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 477bb89f03aa..fd833a2b7c1b 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3234,20 +3234,16 @@ int bpf_link_new_fd(struct bpf_link *link)
>  
>  struct bpf_link *bpf_link_get_from_fd(u32 ufd)
>  {
> -	struct fd f = fdget(ufd);
> +	CLASS(fd, f)(ufd);
>  	struct bpf_link *link;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return ERR_PTR(-EBADF);
> -	if (fd_file(f)->f_op != &bpf_link_fops) {
> -		fdput(f);
> +	if (fd_file(f)->f_op != &bpf_link_fops)
>  		return ERR_PTR(-EINVAL);
> -	}
>  
>  	link = fd_file(f)->private_data;
>  	bpf_link_inc(link);
> -	fdput(f);
> -
>  	return link;
>  }
>  EXPORT_SYMBOL(bpf_link_get_from_fd);
> @@ -4952,33 +4948,25 @@ static int bpf_link_get_info_by_fd(struct file *file,
>  static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
>  				  union bpf_attr __user *uattr)
>  {
> -	int ufd = attr->info.bpf_fd;
> -	struct fd f;
> -	int err;
> -
>  	if (CHECK_ATTR(BPF_OBJ_GET_INFO_BY_FD))
>  		return -EINVAL;
>  
> -	f = fdget(ufd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(attr->info.bpf_fd);
> +	if (fd_empty(f))
>  		return -EBADFD;
>  
>  	if (fd_file(f)->f_op == &bpf_prog_fops)
> -		err = bpf_prog_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
> +		return bpf_prog_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
>  					      uattr);
>  	else if (fd_file(f)->f_op == &bpf_map_fops)
> -		err = bpf_map_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
> +		return bpf_map_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
>  					     uattr);
>  	else if (fd_file(f)->f_op == &btf_fops)
> -		err = bpf_btf_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr, uattr);
> +		return bpf_btf_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr, uattr);
>  	else if (fd_file(f)->f_op == &bpf_link_fops)
> -		err = bpf_link_get_info_by_fd(fd_file(f), fd_file(f)->private_data,
> +		return bpf_link_get_info_by_fd(fd_file(f), fd_file(f)->private_data,
>  					      attr, uattr);
> -	else
> -		err = -EINVAL;
> -
> -	fdput(f);
> -	return err;
> +	return -EINVAL;
>  }
>  
>  #define BPF_BTF_LOAD_LAST_FIELD btf_token_fd
> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> index 9a1d356e79ed..4164feec9a3b 100644
> --- a/kernel/bpf/token.c
> +++ b/kernel/bpf/token.c
> @@ -117,17 +117,15 @@ int bpf_token_create(union bpf_attr *attr)
>  	struct inode *inode;
>  	struct file *file;
>  	struct path path;
> -	struct fd f;
> +	CLASS(fd, f)(attr->token_create.bpffs_fd);
>  	umode_t mode;
>  	int err, fd;
>  
> -	f = fdget(attr->token_create.bpffs_fd);
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	path = fd_file(f)->f_path;
>  	path_get(&path);
> -	fdput(f);
>  
>  	if (path.dentry != path.mnt->mnt_sb->s_root) {
>  		err = -EINVAL;
> @@ -232,19 +230,16 @@ int bpf_token_create(union bpf_attr *attr)
>  
>  struct bpf_token *bpf_token_get_from_fd(u32 ufd)
>  {
> -	struct fd f = fdget(ufd);
> +	CLASS(fd, f)(ufd);
>  	struct bpf_token *token;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return ERR_PTR(-EBADF);
> -	if (fd_file(f)->f_op != &bpf_token_fops) {
> -		fdput(f);
> +	if (fd_file(f)->f_op != &bpf_token_fops)
>  		return ERR_PTR(-EINVAL);
> -	}
>  
>  	token = fd_file(f)->private_data;
>  	bpf_token_inc(token);
> -	fdput(f);
>  
>  	return token;
>  }
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fd4621cd9c23..bc4910442642 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -930,22 +930,20 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
>  {
>  	struct perf_cgroup *cgrp;
>  	struct cgroup_subsys_state *css;
> -	struct fd f = fdget(fd);
> +	CLASS(fd, f)(fd);
>  	int ret = 0;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	css = css_tryget_online_from_dir(fd_file(f)->f_path.dentry,
>  					 &perf_event_cgrp_subsys);
> -	if (IS_ERR(css)) {
> -		ret = PTR_ERR(css);
> -		goto out;
> -	}
> +	if (IS_ERR(css))
> +		return PTR_ERR(css);
>  
>  	ret = perf_cgroup_ensure_storage(event, css);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	cgrp = container_of(css, struct perf_cgroup, css);
>  	event->cgrp = cgrp;
> @@ -959,8 +957,6 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
>  		perf_detach_cgroup(event);
>  		ret = -EINVAL;
>  	}
> -out:
> -	fdput(f);
>  	return ret;
>  }
>  
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index dc952c3b05af..c9d97ed20122 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -545,12 +545,12 @@ static void commit_nsset(struct nsset *nsset)
>  
>  SYSCALL_DEFINE2(setns, int, fd, int, flags)
>  {
> -	struct fd f = fdget(fd);
> +	CLASS(fd, f)(fd);
>  	struct ns_common *ns = NULL;
>  	struct nsset nsset = {};
>  	int err = 0;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	if (proc_ns_file(fd_file(f))) {
> @@ -580,7 +580,6 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
>  	}
>  	put_nsset(&nsset);
>  out:
> -	fdput(f);
>  	return err;
>  }
>  
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 2715afb77eab..115448e89c3e 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -536,11 +536,10 @@ EXPORT_SYMBOL_GPL(find_ge_pid);
>  
>  struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
>  {
> -	struct fd f;
> +	CLASS(fd, f)(fd);
>  	struct pid *pid;
>  
> -	f = fdget(fd);
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return ERR_PTR(-EBADF);
>  
>  	pid = pidfd_pid(fd_file(f));
> @@ -548,8 +547,6 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
>  		get_pid(pid);
>  		*flags = fd_file(f)->f_flags;
>  	}
> -
> -	fdput(f);
>  	return pid;
>  }
>  
> @@ -747,23 +744,18 @@ SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
>  		unsigned int, flags)
>  {
>  	struct pid *pid;
> -	struct fd f;
> -	int ret;
>  
>  	/* flags is currently unused - make sure it's unset */
>  	if (flags)
>  		return -EINVAL;
>  
> -	f = fdget(pidfd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(pidfd);
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	pid = pidfd_pid(fd_file(f));
>  	if (IS_ERR(pid))
> -		ret = PTR_ERR(pid);
> -	else
> -		ret = pidfd_getfd(pid, fd);
> +		return PTR_ERR(pid);
>  
> -	fdput(f);
> -	return ret;
> +	return pidfd_getfd(pid, fd);
>  }
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 6c438fd436d8..9f4949ac8a3c 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3900,7 +3900,6 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  		siginfo_t __user *, info, unsigned int, flags)
>  {
>  	int ret;
> -	struct fd f;
>  	struct pid *pid;
>  	kernel_siginfo_t kinfo;
>  	enum pid_type type;
> @@ -3913,20 +3912,17 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
>  		return -EINVAL;
>  
> -	f = fdget(pidfd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(pidfd);
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	/* Is this a pidfd? */
>  	pid = pidfd_to_pid(fd_file(f));
> -	if (IS_ERR(pid)) {
> -		ret = PTR_ERR(pid);
> -		goto err;
> -	}
> +	if (IS_ERR(pid))
> +		return PTR_ERR(pid);
>  
> -	ret = -EINVAL;
>  	if (!access_pidfd_pidns(pid))
> -		goto err;
> +		return -EINVAL;
>  
>  	switch (flags) {
>  	case 0:
> @@ -3950,28 +3946,23 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  	if (info) {
>  		ret = copy_siginfo_from_user_any(&kinfo, info);
>  		if (unlikely(ret))
> -			goto err;
> +			return ret;
>  
> -		ret = -EINVAL;
>  		if (unlikely(sig != kinfo.si_signo))
> -			goto err;
> +			return -EINVAL;
>  
>  		/* Only allow sending arbitrary signals to yourself. */
> -		ret = -EPERM;
>  		if ((task_pid(current) != pid || type > PIDTYPE_TGID) &&
>  		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
> -			goto err;
> +			return -EPERM;
>  	} else {
>  		prepare_kill_siginfo(sig, &kinfo, type);
>  	}
>  
>  	if (type == PIDTYPE_PGID)
> -		ret = kill_pgrp_info(sig, &kinfo, pid);
> +		return kill_pgrp_info(sig, &kinfo, pid);
>  	else
> -		ret = kill_pid_info_type(sig, &kinfo, pid, type);
> -err:
> -	fdput(f);
> -	return ret;
> +		return kill_pid_info_type(sig, &kinfo, pid, type);
>  }
>  
>  static int
> diff --git a/kernel/sys.c b/kernel/sys.c
> index a4be1e568ff5..243d58916899 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1911,12 +1911,11 @@ SYSCALL_DEFINE1(umask, int, mask)
>  
>  static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
>  {
> -	struct fd exe;
> +	CLASS(fd, exe)(fd);
>  	struct inode *inode;
>  	int err;
>  
> -	exe = fdget(fd);
> -	if (!fd_file(exe))
> +	if (fd_empty(exe))
>  		return -EBADF;
>  
>  	inode = file_inode(fd_file(exe));
> @@ -1926,18 +1925,14 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
>  	 * sure that this one is executable as well, to avoid breaking an
>  	 * overall picture.
>  	 */
> -	err = -EACCES;
>  	if (!S_ISREG(inode->i_mode) || path_noexec(&fd_file(exe)->f_path))
> -		goto exit;
> +		return -EACCES;
>  
>  	err = file_permission(fd_file(exe), MAY_EXEC);
>  	if (err)
> -		goto exit;
> +		return err;
>  
> -	err = replace_mm_exe_file(mm, fd_file(exe));
> -exit:
> -	fdput(exe);
> -	return err;
> +	return replace_mm_exe_file(mm, fd_file(exe));
>  }
>  
>  /*
> diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> index 0700f40c53ac..0cd680ccc7e5 100644
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -411,15 +411,14 @@ static int cgroupstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
>  	struct nlattr *na;
>  	size_t size;
>  	u32 fd;
> -	struct fd f;
>  
>  	na = info->attrs[CGROUPSTATS_CMD_ATTR_FD];
>  	if (!na)
>  		return -EINVAL;
>  
>  	fd = nla_get_u32(info->attrs[CGROUPSTATS_CMD_ATTR_FD]);
> -	f = fdget(fd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
>  		return 0;
>  
>  	size = nla_total_size(sizeof(struct cgroupstats));
> @@ -427,14 +426,13 @@ static int cgroupstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
>  	rc = prepare_reply(info, CGROUPSTATS_CMD_NEW, &rep_skb,
>  				size);
>  	if (rc < 0)
> -		goto err;
> +		return rc;
>  
>  	na = nla_reserve(rep_skb, CGROUPSTATS_TYPE_CGROUP_STATS,
>  				sizeof(struct cgroupstats));
>  	if (na == NULL) {
>  		nlmsg_free(rep_skb);
> -		rc = -EMSGSIZE;
> -		goto err;
> +		return -EMSGSIZE;
>  	}
>  
>  	stats = nla_data(na);
> @@ -443,14 +441,10 @@ static int cgroupstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
>  	rc = cgroupstats_build(stats, fd_file(f)->f_path.dentry);
>  	if (rc < 0) {
>  		nlmsg_free(rep_skb);
> -		goto err;
> +		return rc;
>  	}
>  
> -	rc = send_reply(rep_skb, info);
> -
> -err:
> -	fdput(f);
> -	return rc;
> +	return send_reply(rep_skb, info);
>  }
>  
>  static int cmd_attr_register_cpumask(struct genl_info *info)
> diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
> index d36242fd4936..1895fbc32bcb 100644
> --- a/kernel/watch_queue.c
> +++ b/kernel/watch_queue.c
> @@ -663,16 +663,14 @@ struct watch_queue *get_watch_queue(int fd)
>  {
>  	struct pipe_inode_info *pipe;
>  	struct watch_queue *wqueue = ERR_PTR(-EINVAL);
> -	struct fd f;
> +	CLASS(fd, f)(fd);
>  
> -	f = fdget(fd);
> -	if (fd_file(f)) {
> +	if (!fd_empty(f)) {
>  		pipe = get_pipe_info(fd_file(f), false);
>  		if (pipe && pipe->watch_queue) {
>  			wqueue = pipe->watch_queue;
>  			kref_get(&wqueue->usage);
>  		}
> -		fdput(f);
>  	}
>  
>  	return wqueue;
> diff --git a/mm/fadvise.c b/mm/fadvise.c
> index 532dee205c6e..588fe76c5a14 100644
> --- a/mm/fadvise.c
> +++ b/mm/fadvise.c
> @@ -190,16 +190,12 @@ EXPORT_SYMBOL(vfs_fadvise);
>  
>  int ksys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice)
>  {
> -	struct fd f = fdget(fd);
> -	int ret;
> +	CLASS(fd, f)(fd);
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  
> -	ret = vfs_fadvise(fd_file(f), offset, len, advice);
> -
> -	fdput(f);
> -	return ret;
> +	return vfs_fadvise(fd_file(f), offset, len, advice);
>  }
>  
>  SYSCALL_DEFINE4(fadvise64_64, int, fd, loff_t, offset, loff_t, len, int, advice)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c79c2c773171..13b2f133796d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4373,31 +4373,25 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
>  		struct cachestat_range __user *, cstat_range,
>  		struct cachestat __user *, cstat, unsigned int, flags)
>  {
> -	struct fd f = fdget(fd);
> +	CLASS(fd, f)(fd);
>  	struct address_space *mapping;
>  	struct cachestat_range csr;
>  	struct cachestat cs;
>  	pgoff_t first_index, last_index;
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	if (copy_from_user(&csr, cstat_range,
> -			sizeof(struct cachestat_range))) {
> -		fdput(f);
> +			sizeof(struct cachestat_range)))
>  		return -EFAULT;
> -	}
>  
>  	/* hugetlbfs is not supported */
> -	if (is_file_hugepages(fd_file(f))) {
> -		fdput(f);
> +	if (is_file_hugepages(fd_file(f)))
>  		return -EOPNOTSUPP;
> -	}
>  
> -	if (flags != 0) {
> -		fdput(f);
> +	if (flags != 0)
>  		return -EINVAL;
> -	}
>  
>  	first_index = csr.off >> PAGE_SHIFT;
>  	last_index =
> @@ -4405,7 +4399,6 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
>  	memset(&cs, 0, sizeof(struct cachestat));
>  	mapping = fd_file(f)->f_mapping;
>  	filemap_cachestat(mapping, first_index, last_index, &cs);
> -	fdput(f);
>  
>  	if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
>  		return -EFAULT;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 58d000013024..46240137fee3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5266,8 +5266,6 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  	struct mem_cgroup_event *event;
>  	struct cgroup_subsys_state *cfile_css;
>  	unsigned int efd, cfd;
> -	struct fd efile;
> -	struct fd cfile;
>  	struct dentry *cdentry;
>  	const char *name;
>  	char *endp;
> @@ -5298,8 +5296,8 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  	init_waitqueue_func_entry(&event->wait, memcg_event_wake);
>  	INIT_WORK(&event->remove, memcg_event_remove);
>  
> -	efile = fdget(efd);
> -	if (!fd_file(efile)) {
> +	CLASS(fd, efile)(efd);
> +	if (fd_empty(efile)) {
>  		ret = -EBADF;
>  		goto out_kfree;
>  	}
> @@ -5307,11 +5305,11 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  	event->eventfd = eventfd_ctx_fileget(fd_file(efile));
>  	if (IS_ERR(event->eventfd)) {
>  		ret = PTR_ERR(event->eventfd);
> -		goto out_put_efile;
> +		goto out_kfree;
>  	}
>  
> -	cfile = fdget(cfd);
> -	if (!fd_file(cfile)) {
> +	CLASS(fd, cfile)(cfd);
> +	if (fd_empty(cfile)) {
>  		ret = -EBADF;
>  		goto out_put_eventfd;
>  	}
> @@ -5320,7 +5318,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  	/* AV: shouldn't we check that it's been opened for read instead? */
>  	ret = file_permission(fd_file(cfile), MAY_READ);
>  	if (ret < 0)
> -		goto out_put_cfile;
> +		goto out_put_eventfd;
>  
>  	/*
>  	 * The control file must be a regular cgroup1 file. As a regular cgroup
> @@ -5329,7 +5327,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  	cdentry = fd_file(cfile)->f_path.dentry;
>  	if (cdentry->d_sb->s_type != &cgroup_fs_type || !d_is_reg(cdentry)) {
>  		ret = -EINVAL;
> -		goto out_put_cfile;
> +		goto out_put_eventfd;
>  	}
>  
>  	/*
> @@ -5356,7 +5354,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  		event->unregister_event = memsw_cgroup_usage_unregister_event;
>  	} else {
>  		ret = -EINVAL;
> -		goto out_put_cfile;
> +		goto out_put_eventfd;
>  	}
>  
>  	/*
> @@ -5368,10 +5366,10 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  					       &memory_cgrp_subsys);
>  	ret = -EINVAL;
>  	if (IS_ERR(cfile_css))
> -		goto out_put_cfile;
> +		goto out_put_eventfd;
>  	if (cfile_css != css) {
>  		css_put(cfile_css);
> -		goto out_put_cfile;
> +		goto out_put_eventfd;
>  	}
>  
>  	ret = event->register_event(memcg, event->eventfd, buf);
> @@ -5384,19 +5382,12 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  	list_add(&event->list, &memcg->event_list);
>  	spin_unlock_irq(&memcg->event_list_lock);
>  
> -	fdput(cfile);
> -	fdput(efile);
> -
>  	return nbytes;
>  
>  out_put_css:
>  	css_put(css);
> -out_put_cfile:
> -	fdput(cfile);
>  out_put_eventfd:
>  	eventfd_ctx_put(event->eventfd);
> -out_put_efile:
> -	fdput(efile);
>  out_kfree:
>  	kfree(event);
>  
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 2be4603488c5..3ce1269b972a 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -721,29 +721,22 @@ EXPORT_SYMBOL_GPL(page_cache_async_ra);
>  
>  ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
>  {
> -	ssize_t ret;
> -	struct fd f;
> +	CLASS(fd, f)(fd);
>  
> -	ret = -EBADF;
> -	f = fdget(fd);
> -	if (!fd_file(f) || !(fd_file(f)->f_mode & FMODE_READ))
> -		goto out;
> +	if (fd_empty(f) || !(fd_file(f)->f_mode & FMODE_READ))
> +		return -EBADF;
>  
>  	/*
>  	 * The readahead() syscall is intended to run only on files
>  	 * that can execute readahead. If readahead is not possible
>  	 * on this file, then we must return -EINVAL.
>  	 */
> -	ret = -EINVAL;
>  	if (!fd_file(f)->f_mapping || !fd_file(f)->f_mapping->a_ops ||
>  	    (!S_ISREG(file_inode(fd_file(f))->i_mode) &&
>  	    !S_ISBLK(file_inode(fd_file(f))->i_mode)))
> -		goto out;
> +		return -EINVAL;
>  
> -	ret = vfs_fadvise(fd_file(f), offset, count, POSIX_FADV_WILLNEED);
> -out:
> -	fdput(f);
> -	return ret;
> +	return vfs_fadvise(fd_file(f), offset, count, POSIX_FADV_WILLNEED);
>  }
>  
>  SYSCALL_DEFINE3(readahead, int, fd, loff_t, offset, size_t, count)
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index fd536e385b83..e1e56cbf5cbf 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -703,20 +703,18 @@ EXPORT_SYMBOL_GPL(get_net_ns);
>  
>  struct net *get_net_ns_by_fd(int fd)
>  {
> -	struct fd f = fdget(fd);
> -	struct net *net = ERR_PTR(-EINVAL);
> +	CLASS(fd, f)(fd);
>  
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return ERR_PTR(-EBADF);
>  
>  	if (proc_ns_file(fd_file(f))) {
>  		struct ns_common *ns = get_proc_ns(file_inode(fd_file(f)));
>  		if (ns->ops == &netns_operations)
> -			net = get_net(container_of(ns, struct net, ns));
> +			return get_net(container_of(ns, struct net, ns));
>  	}
> -	fdput(f);
>  
> -	return net;
> +	return ERR_PTR(-EINVAL);
>  }
>  EXPORT_SYMBOL_GPL(get_net_ns_by_fd);
>  #endif
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index e7c1d3ae33fe..e6b4cdd6e84c 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1062,19 +1062,16 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
>   */
>  void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>  {
> -	struct fd f;
> -
>  	if (!buf || !size)
>  		return;
>  
> -	f = fdget(kernel_fd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(kernel_fd);
> +	if (fd_empty(f))
>  		return;
>  
>  	process_buffer_measurement(file_mnt_idmap(fd_file(f)), file_inode(fd_file(f)),
>  				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
>  				   NULL, false, NULL, 0);
> -	fdput(f);
>  }
>  
>  /**
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 97b3df540dc7..a661d373ea92 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -234,31 +234,21 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>  static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
>  						    const fmode_t mode)
>  {
> -	struct fd ruleset_f;
> +	CLASS(fd, ruleset_f)(fd);
>  	struct landlock_ruleset *ruleset;
>  
> -	ruleset_f = fdget(fd);
> -	if (!fd_file(ruleset_f))
> +	if (fd_empty(ruleset_f))
>  		return ERR_PTR(-EBADF);
>  
>  	/* Checks FD type and access right. */
> -	if (fd_file(ruleset_f)->f_op != &ruleset_fops) {
> -		ruleset = ERR_PTR(-EBADFD);
> -		goto out_fdput;
> -	}
> -	if (!(fd_file(ruleset_f)->f_mode & mode)) {
> -		ruleset = ERR_PTR(-EPERM);
> -		goto out_fdput;
> -	}
> +	if (fd_file(ruleset_f)->f_op != &ruleset_fops)
> +		return ERR_PTR(-EBADFD);
> +	if (!(fd_file(ruleset_f)->f_mode & mode))
> +		return ERR_PTR(-EPERM);
>  	ruleset = fd_file(ruleset_f)->private_data;
> -	if (WARN_ON_ONCE(ruleset->num_layers != 1)) {
> -		ruleset = ERR_PTR(-EINVAL);
> -		goto out_fdput;
> -	}
> +	if (WARN_ON_ONCE(ruleset->num_layers != 1))
> +		return ERR_PTR(-EINVAL);
>  	landlock_get_ruleset(ruleset);
> -
> -out_fdput:
> -	fdput(ruleset_f);
>  	return ruleset;
>  }
>  
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 02144ec39f43..68252452b66c 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -283,7 +283,6 @@ enum loadpin_securityfs_interface_index {
>  
>  static int read_trusted_verity_root_digests(unsigned int fd)
>  {
> -	struct fd f;
>  	void *data;
>  	int rc;
>  	char *p, *d;
> @@ -295,8 +294,8 @@ static int read_trusted_verity_root_digests(unsigned int fd)
>  	if (!list_empty(&dm_verity_loadpin_trusted_root_digests))
>  		return -EPERM;
>  
> -	f = fdget(fd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
>  		return -EINVAL;
>  
>  	data = kzalloc(SZ_4K, GFP_KERNEL);
> @@ -359,7 +358,6 @@ static int read_trusted_verity_root_digests(unsigned int fd)
>  	}
>  
>  	kfree(data);
> -	fdput(f);
>  
>  	return 0;
>  
> @@ -379,8 +377,6 @@ static int read_trusted_verity_root_digests(unsigned int fd)
>  	/* disallow further attempts after reading a corrupt/invalid file */
>  	deny_reading_verity_digests = true;
>  
> -	fdput(f);
> -
>  	return rc;
>  }
>  
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index 65efb3735e79..70bc0d1f5f6a 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -303,7 +303,6 @@ static int
>  kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  {
>  	struct kvm_kernel_irqfd *irqfd, *tmp;
> -	struct fd f;
>  	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
>  	int ret;
>  	__poll_t events;
> @@ -326,8 +325,8 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
>  	seqcount_spinlock_init(&irqfd->irq_entry_sc, &kvm->irqfds.lock);
>  
> -	f = fdget(args->fd);
> -	if (!fd_file(f)) {
> +	CLASS(fd, f)(args->fd);
> +	if (fd_empty(f)) {
>  		ret = -EBADF;
>  		goto out;
>  	}
> @@ -335,7 +334,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  	eventfd = eventfd_ctx_fileget(fd_file(f));
>  	if (IS_ERR(eventfd)) {
>  		ret = PTR_ERR(eventfd);
> -		goto fail;
> +		goto out;
>  	}
>  
>  	irqfd->eventfd = eventfd;
> @@ -439,12 +438,6 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  #endif
>  
>  	srcu_read_unlock(&kvm->irq_srcu, idx);
> -
> -	/*
> -	 * do not drop the file until the irqfd is fully initialized, otherwise
> -	 * we might race against the EPOLLHUP
> -	 */
> -	fdput(f);
>  	return 0;
>  
>  fail:
> @@ -457,8 +450,6 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  	if (eventfd && !IS_ERR(eventfd))
>  		eventfd_ctx_put(eventfd);
>  
> -	fdput(f);
> -
>  out:
>  	kfree(irqfd);
>  	return ret;
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 388ae471d258..72aa1fdeb699 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -190,11 +190,10 @@ static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)
>  {
>  	struct kvm_vfio *kv = dev->private;
>  	struct kvm_vfio_file *kvf;
> -	struct fd f;
> +	CLASS(fd, f)(fd);
>  	int ret;
>  
> -	f = fdget(fd);
> -	if (!fd_file(f))
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	ret = -ENOENT;
> @@ -220,9 +219,6 @@ static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)
>  	kvm_vfio_update_coherency(dev);
>  
>  	mutex_unlock(&kv->lock);
> -
> -	fdput(f);
> -
>  	return ret;
>  }
>  
> @@ -233,14 +229,13 @@ static int kvm_vfio_file_set_spapr_tce(struct kvm_device *dev,
>  	struct kvm_vfio_spapr_tce param;
>  	struct kvm_vfio *kv = dev->private;
>  	struct kvm_vfio_file *kvf;
> -	struct fd f;
>  	int ret;
>  
>  	if (copy_from_user(&param, arg, sizeof(struct kvm_vfio_spapr_tce)))
>  		return -EFAULT;
>  
> -	f = fdget(param.groupfd);
> -	if (!fd_file(f))
> +	CLASS(fd, f)(param.groupfd);
> +	if (fd_empty(f))
>  		return -EBADF;
>  
>  	ret = -ENOENT;
> @@ -266,7 +261,6 @@ static int kvm_vfio_file_set_spapr_tce(struct kvm_device *dev,
>  
>  err_fdput:
>  	mutex_unlock(&kv->lock);
> -	fdput(f);
>  	return ret;
>  }
>  #endif
> -- 
> 2.39.2
> 

