Return-Path: <linux-fsdevel+bounces-43244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F975A4FCB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4353ADBBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237CA215F5E;
	Wed,  5 Mar 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ6sqGrP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E1C20ADD8;
	Wed,  5 Mar 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171623; cv=none; b=eHwEUSKEtkqOMfZ6EVyOsKike+EBRYdjVWUobqdev0b75ZCfzTwrHtGn5FN/WbwghgOOUDDw8C1q9beAGaKA9556zfZkRBx6EZzeCK5akyl7WyszHtPJgcJyWtoPR00F1iAJJXsR0d/kj5djYS9qLcnXn55vqUnPGFQj68ZvTH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171623; c=relaxed/simple;
	bh=1tFzXfSysAIzwmvOCTx/elfSMDPDRSEwriuDfowVrak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPtr3+qvz00H8OCvu1rihTm6xD7Ec0Z5vGDzuRBODvQJIFMK/JGsLzNWymQvFfSmKl/X1txQlaoKG3uVOfupkKA8/P2lPvSzy1S+vFs1km8+ahvOgaEXTvGg7UNitDPfvvkIju3XeQrC4LpskOUTWPHXXlQDFPuMc6KG6+fhqu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ6sqGrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60F6C4CEE2;
	Wed,  5 Mar 2025 10:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741171623;
	bh=1tFzXfSysAIzwmvOCTx/elfSMDPDRSEwriuDfowVrak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJ6sqGrPY8iFmuTPyTXH2eTCAJF397Ge4C/SlN0eUdQUxy/wgxRj+OYpQFOEKUcUQ
	 J/kJr3v3sdQKnHspgAvetJDaJaalg2BQ3rfv2FiluVW7uuqwWGiN/mKLmJ6c6ntMTq
	 pX90ooH4QL26i9a3SRpolTAt2GmVTLL4c+/TRQ0ZsoRgyOWYQaou0uFVCcKV8SqNAa
	 l49s3AAWYGDaGARV0EWNWb18NEY/lHRfaVvpziA068l9aztOehzN906t6AxUnombVO
	 qqLjm2qjskY9s+wIz6oZhtxaN0r/ksJu9amm2Iqx9ELYV70VBmrA3Pd56jgWAL9u2J
	 OwTXsQKO86qvg==
Date: Wed, 5 Mar 2025 11:46:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] file: add fput and file_ref_put routines
 optimized for use when closing a fd
Message-ID: <20250305-gehversuche-ambivalent-c2c39242bb7d@brauner>
References: <20250304183506.498724-1-mjguzik@gmail.com>
 <20250304183506.498724-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304183506.498724-2-mjguzik@gmail.com>

On Tue, Mar 04, 2025 at 07:35:03PM +0100, Mateusz Guzik wrote:
> Vast majority of the time closing a file descriptor also operates on the
> last reference, where a regular fput usage will result in 2 atomics.
> This can be changed to only suffer 1.
> 
> See commentary above file_ref_put_close() for more information.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---

I'm not enthused about the patches tbh because we end up with two new
primivites and I really dislike so many new primitives with slightly
different semantics. But it should at least all be kept private to fs/.

>  fs/file.c                | 75 ++++++++++++++++++++++++++++++----------
>  fs/file_table.c          | 72 +++++++++++++++++++++++++++-----------
>  include/linux/file.h     |  2 ++
>  include/linux/file_ref.h |  1 +
>  4 files changed, 111 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 44efdc8c1e27..ea753f9c8e08 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -26,6 +26,28 @@
>  
>  #include "internal.h"
>  
> +static bool __file_ref_put_badval(file_ref_t *ref, unsigned long cnt)
> +{
> +	/*
> +	 * If the reference count was already in the dead zone, then this
> +	 * put() operation is imbalanced. Warn, put the reference count back to
> +	 * DEAD and tell the caller to not deconstruct the object.
> +	 */
> +	if (WARN_ONCE(cnt >= FILE_REF_RELEASED, "imbalanced put on file reference count")) {
> +		atomic_long_set(&ref->refcnt, FILE_REF_DEAD);
> +		return false;
> +	}
> +
> +	/*
> +	 * This is a put() operation on a saturated refcount. Restore the
> +	 * mean saturation value and tell the caller to not deconstruct the
> +	 * object.
> +	 */
> +	if (cnt > FILE_REF_MAXREF)
> +		atomic_long_set(&ref->refcnt, FILE_REF_SATURATED);
> +	return false;
> +}
> +
>  /**
>   * __file_ref_put - Slowpath of file_ref_put()
>   * @ref:	Pointer to the reference count
> @@ -67,27 +89,44 @@ bool __file_ref_put(file_ref_t *ref, unsigned long cnt)
>  		return true;
>  	}
>  
> -	/*
> -	 * If the reference count was already in the dead zone, then this
> -	 * put() operation is imbalanced. Warn, put the reference count back to
> -	 * DEAD and tell the caller to not deconstruct the object.
> -	 */
> -	if (WARN_ONCE(cnt >= FILE_REF_RELEASED, "imbalanced put on file reference count")) {
> -		atomic_long_set(&ref->refcnt, FILE_REF_DEAD);
> -		return false;
> -	}
> -
> -	/*
> -	 * This is a put() operation on a saturated refcount. Restore the
> -	 * mean saturation value and tell the caller to not deconstruct the
> -	 * object.
> -	 */
> -	if (cnt > FILE_REF_MAXREF)
> -		atomic_long_set(&ref->refcnt, FILE_REF_SATURATED);
> -	return false;
> +	return __file_ref_put_badval(ref, cnt);
>  }
>  EXPORT_SYMBOL_GPL(__file_ref_put);
>  
> +/**
> + * file_ref_put_close - drop a reference expecting it would transition to FILE_REF_NOREF
> + * @ref:	Pointer to the reference count
> + *
> + * Semantically it is equivalent to calling file_ref_put(), but it trades lower
> + * performance in face of other CPUs also modifying the refcount for higher
> + * performance when this happens to be the last reference.
> + *
> + * For the last reference file_ref_put() issues 2 atomics. One to drop the
> + * reference and another to transition it to FILE_REF_DEAD. This routine does
> + * the work in one step, but in order to do it has to pre-read the variable which
> + * decreases scalability.
> + *
> + * Use with close() et al, stick to file_ref_put() by default.
> + */
> +bool file_ref_put_close(file_ref_t *ref)
> +{
> +	long old, new;
> +
> +	old = atomic_long_read(&ref->refcnt);
> +	do {
> +		if (unlikely(old < 0))
> +			return __file_ref_put_badval(ref, old);
> +
> +		if (old == FILE_REF_ONEREF)
> +			new = FILE_REF_DEAD;
> +		else
> +			new = old - 1;
> +	} while (!atomic_long_try_cmpxchg(&ref->refcnt, &old, new));
> +
> +	return new == FILE_REF_DEAD;
> +}
> +EXPORT_SYMBOL_GPL(file_ref_put_close);
> +
>  unsigned int sysctl_nr_open __read_mostly = 1024*1024;
>  unsigned int sysctl_nr_open_min = BITS_PER_LONG;
>  /* our min() is unusable in constant expressions ;-/ */
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 5c00dc38558d..4189c682eb06 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -511,31 +511,37 @@ void flush_delayed_fput(void)
>  }
>  EXPORT_SYMBOL_GPL(flush_delayed_fput);
>  
> -void fput(struct file *file)
> +static void __fput_defer_free(struct file *file)

Imho just call it __fput_deferred().

>  {
> -	if (file_ref_put(&file->f_ref)) {
> -		struct task_struct *task = current;
> +	struct task_struct *task = current;
>  
> -		if (unlikely(!(file->f_mode & (FMODE_BACKING | FMODE_OPENED)))) {
> -			file_free(file);
> +	if (unlikely(!(file->f_mode & (FMODE_BACKING | FMODE_OPENED)))) {
> +		file_free(file);
> +		return;
> +	}
> +	if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
> +		init_task_work(&file->f_task_work, ____fput);
> +		if (!task_work_add(task, &file->f_task_work, TWA_RESUME))
>  			return;
> -		}
> -		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
> -			init_task_work(&file->f_task_work, ____fput);
> -			if (!task_work_add(task, &file->f_task_work, TWA_RESUME))
> -				return;
> -			/*
> -			 * After this task has run exit_task_work(),
> -			 * task_work_add() will fail.  Fall through to delayed
> -			 * fput to avoid leaking *file.
> -			 */
> -		}
> -
> -		if (llist_add(&file->f_llist, &delayed_fput_list))
> -			schedule_delayed_work(&delayed_fput_work, 1);
> +		/*
> +		 * After this task has run exit_task_work(),
> +		 * task_work_add() will fail.  Fall through to delayed
> +		 * fput to avoid leaking *file.
> +		 */
>  	}
> +
> +	if (llist_add(&file->f_llist, &delayed_fput_list))
> +		schedule_delayed_work(&delayed_fput_work, 1);
>  }
>  
> +void fput(struct file *file)
> +{
> +	if (unlikely(file_ref_put(&file->f_ref))) {
> +		__fput_defer_free(file);
> +	}
> +}
> +EXPORT_SYMBOL(fput);
> +
>  /*
>   * synchronous analog of fput(); for kernel threads that might be needed
>   * in some umount() (and thus can't use flush_delayed_fput() without
> @@ -549,10 +555,34 @@ void __fput_sync(struct file *file)
>  	if (file_ref_put(&file->f_ref))
>  		__fput(file);
>  }
> -
> -EXPORT_SYMBOL(fput);
>  EXPORT_SYMBOL(__fput_sync);
>  
> +/*
> + * Equivalent to __fput_sync(), but optimized for being called with the last
> + * reference.
> + *
> + * See file_ref_put_close() for details.
> + */
> +void fput_close_sync(struct file *file)
> +{
> +	if (unlikely(file_ref_put_close(&file->f_ref)))
> +		__fput(file);
> +}
> +EXPORT_SYMBOL(fput_close_sync);

Shouldn't be exported to modules, please.

> +
> +/*
> + * Equivalent to fput(), but optimized for being called with the last
> + * reference.
> + *
> + * See file_ref_put_close() for details.
> + */
> +void fput_close(struct file *file)
> +{
> +	if (file_ref_put_close(&file->f_ref))
> +		__fput_defer_free(file);
> +}
> +EXPORT_SYMBOL(fput_close);

Shouldn't be exported to modules, please.

> +
>  void __init files_init(void)
>  {
>  	struct kmem_cache_args args = {
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 302f11355b10..7b04e87cbde6 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -124,6 +124,8 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
>  
>  extern void flush_delayed_fput(void);
>  extern void __fput_sync(struct file *);
> +void fput_close_sync(struct file *);
> +void fput_close(struct file *);

Should go into internal.h.

>  
>  extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
>  
> diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
> index 9b3a8d9b17ab..f269299941aa 100644
> --- a/include/linux/file_ref.h
> +++ b/include/linux/file_ref.h
> @@ -62,6 +62,7 @@ static inline void file_ref_init(file_ref_t *ref, unsigned long cnt)
>  }
>  
>  bool __file_ref_put(file_ref_t *ref, unsigned long cnt);
> +bool file_ref_put_close(file_ref_t *ref);
>  
>  /**
>   * file_ref_get - Acquire one reference on a file
> -- 
> 2.43.0
> 

