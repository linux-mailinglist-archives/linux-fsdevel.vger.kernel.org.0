Return-Path: <linux-fsdevel+bounces-9496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBC7841C5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 08:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADB9289066
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 07:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3A14D583;
	Tue, 30 Jan 2024 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URcyGOpC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60844500D;
	Tue, 30 Jan 2024 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598790; cv=none; b=rnfn7gF9jQ2JnuLhzQBJZoEWpG+qWG4LHD4JX5h36fD4Rlv1KQwirkF/P+DUqdUfQnlwnM9VBVt8QvYavIzSUKfilIrAXaa65ED0yS6gf9+5nJkN2HPaVK1v1VwXtQO+UdFKinN0k4lXFJA3TlwhhXCsC0HnsIonP8iscOJhQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598790; c=relaxed/simple;
	bh=oGSi+REcwrs/+BSbLE+SMirHJl4MYtMgh21giqxANxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNFHrVsLgOrPpOq7bSDK2Fw1/3NVQSxDyg12sbntM6rcJlaM5UFCMNQzjPbzb94PnrtzZHiJuYgoPj3vwIopIx0bDXNpbWK3mTKZQ3Ybxla5/SUY/wjjluzu7NygPk9MrTkEpHUJT8OmxJezvw7H6rc37eYW/oZD9D/IVqiVEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URcyGOpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA419C433F1;
	Tue, 30 Jan 2024 07:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706598790;
	bh=oGSi+REcwrs/+BSbLE+SMirHJl4MYtMgh21giqxANxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URcyGOpCzoFfcwqq4+CtiY0zXkzUO9VlQY0zXZlUmdU/BCjQzauXj54jpM831meQO
	 K0X1PYj3jHRpSoJBdLjon7W6D2gr3dBeYY1I2DTnEoSy+3ntGiStVHJHGQqFrqnEuE
	 qXDWE3IL4e5+sBByPpuqYshj25gNok0773hZ96ypP1OHtQi0h4a69v/CmfdSUR9V9l
	 HMzflFgu+NjI0uhjuYV6FPn99jcAb5zSySMLqC/9UPS+6kBg4zCBUzzA14UphTx2LD
	 b2410FHjjncrH15pUsiYUW+Y1e9XIOIkrr9OMjhE3FNyqpp/Ly5bT2S6h6ElteKOZN
	 iQtMM9dXffgnQ==
Date: Tue, 30 Jan 2024 09:12:44 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
	aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
	axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
	jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	timmurray@google.com
Subject: Re: [PATCH v2 1/3] userfaultfd: move userfaultfd_ctx struct to
 header file
Message-ID: <ZbihbPMZO2gT7mB4@kernel.org>
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-2-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129193512.123145-2-lokeshgidra@google.com>

On Mon, Jan 29, 2024 at 11:35:10AM -0800, Lokesh Gidra wrote:
> Moving the struct to userfaultfd_k.h to be accessible from
> mm/userfaultfd.c. There are no other changes in the struct.

Just a thought, it maybe worth to move all of fs/userfaultfd.c to
mm/userfaultfd.c ...
 
> This is required to prepare for using per-vma locks in userfaultfd
> operations.
> 
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  fs/userfaultfd.c              | 39 -----------------------------------
>  include/linux/userfaultfd_k.h | 39 +++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 05c8e8a05427..58331b83d648 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -50,45 +50,6 @@ static struct ctl_table vm_userfaultfd_table[] = {
>  
>  static struct kmem_cache *userfaultfd_ctx_cachep __ro_after_init;
>  
> -/*
> - * Start with fault_pending_wqh and fault_wqh so they're more likely
> - * to be in the same cacheline.
> - *
> - * Locking order:
> - *	fd_wqh.lock
> - *		fault_pending_wqh.lock
> - *			fault_wqh.lock
> - *		event_wqh.lock
> - *
> - * To avoid deadlocks, IRQs must be disabled when taking any of the above locks,
> - * since fd_wqh.lock is taken by aio_poll() while it's holding a lock that's
> - * also taken in IRQ context.
> - */
> -struct userfaultfd_ctx {
> -	/* waitqueue head for the pending (i.e. not read) userfaults */
> -	wait_queue_head_t fault_pending_wqh;
> -	/* waitqueue head for the userfaults */
> -	wait_queue_head_t fault_wqh;
> -	/* waitqueue head for the pseudo fd to wakeup poll/read */
> -	wait_queue_head_t fd_wqh;
> -	/* waitqueue head for events */
> -	wait_queue_head_t event_wqh;
> -	/* a refile sequence protected by fault_pending_wqh lock */
> -	seqcount_spinlock_t refile_seq;
> -	/* pseudo fd refcounting */
> -	refcount_t refcount;
> -	/* userfaultfd syscall flags */
> -	unsigned int flags;
> -	/* features requested from the userspace */
> -	unsigned int features;
> -	/* released */
> -	bool released;
> -	/* memory mappings are changing because of non-cooperative event */
> -	atomic_t mmap_changing;
> -	/* mm with one ore more vmas attached to this userfaultfd_ctx */
> -	struct mm_struct *mm;
> -};
> -
>  struct userfaultfd_fork_ctx {
>  	struct userfaultfd_ctx *orig;
>  	struct userfaultfd_ctx *new;
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index e4056547fbe6..691d928ee864 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -36,6 +36,45 @@
>  #define UFFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
>  #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
>  
> +/*
> + * Start with fault_pending_wqh and fault_wqh so they're more likely
> + * to be in the same cacheline.
> + *
> + * Locking order:
> + *	fd_wqh.lock
> + *		fault_pending_wqh.lock
> + *			fault_wqh.lock
> + *		event_wqh.lock
> + *
> + * To avoid deadlocks, IRQs must be disabled when taking any of the above locks,
> + * since fd_wqh.lock is taken by aio_poll() while it's holding a lock that's
> + * also taken in IRQ context.
> + */
> +struct userfaultfd_ctx {
> +	/* waitqueue head for the pending (i.e. not read) userfaults */
> +	wait_queue_head_t fault_pending_wqh;
> +	/* waitqueue head for the userfaults */
> +	wait_queue_head_t fault_wqh;
> +	/* waitqueue head for the pseudo fd to wakeup poll/read */
> +	wait_queue_head_t fd_wqh;
> +	/* waitqueue head for events */
> +	wait_queue_head_t event_wqh;
> +	/* a refile sequence protected by fault_pending_wqh lock */
> +	seqcount_spinlock_t refile_seq;
> +	/* pseudo fd refcounting */
> +	refcount_t refcount;
> +	/* userfaultfd syscall flags */
> +	unsigned int flags;
> +	/* features requested from the userspace */
> +	unsigned int features;
> +	/* released */
> +	bool released;
> +	/* memory mappings are changing because of non-cooperative event */
> +	atomic_t mmap_changing;
> +	/* mm with one ore more vmas attached to this userfaultfd_ctx */
> +	struct mm_struct *mm;
> +};
> +
>  extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
>  
>  /* A combined operation mode + behavior flags. */
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

-- 
Sincerely yours,
Mike.

