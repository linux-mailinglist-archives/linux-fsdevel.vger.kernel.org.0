Return-Path: <linux-fsdevel+bounces-13747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1448735E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AC42839AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0FB7FBB4;
	Wed,  6 Mar 2024 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QodlTD1K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4367F7E9;
	Wed,  6 Mar 2024 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709725861; cv=none; b=I6h4GQOOjlEqus/Tvd/D4E+0+Bcy0eF55IckKHj+UuUxuKx2ztG8X6uyo9cb9eRPH0cSJQqomR7KtywAF9jCvFJmYeq/szKkKIzZAgXFiP8eYu4KK9TwautGhP2wX6cFg+iYx4l14AyIiBGj4HotX5Zk1Jqeva4o/f376ASi0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709725861; c=relaxed/simple;
	bh=vwrURXpIMj1jqcUglQsFMJ0otRAl9PCvcW29Elk4VQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSKaDfg4GKz202S5friGnTaSo8ADpskYpiAusLmt9J999aS974WY0cpP6kNBZ6xZ/vvFqqUVQuoIaoxxZ7DKG7p8MRvbcqeoAmal9fCl1AlyhFsgSMAXzkhmC+9qkJEXbA1CYTC5C8ugN836aDWLpm9r509fhpVa1DmYlK15LuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QodlTD1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EBAC433C7;
	Wed,  6 Mar 2024 11:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709725860;
	bh=vwrURXpIMj1jqcUglQsFMJ0otRAl9PCvcW29Elk4VQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QodlTD1Kw4nB7/LLPdSYcRLIGU/ZePWrRHbgEtEgSdttv6euDxc5emr0NfD4Po0nr
	 ST19Od/uUf0dps9orl7afeZ+Ke6bNByCLYmYpM9jJeyNhPMuBSblkKh2gkgxhzgdeZ
	 /J+abL6OcwN1B4WWuvRUCnziOiia84akv9V5/phNQ1ys0BS5YjZ75fQHz83AkycC/H
	 yiyi3rPwUo9+TKJ6N4gWbeYs0UjdmqCtPulPxKGoQbA8+vIqVNd0MFjKJkL2oJshoP
	 W3JSs/wRO1l2+G0oF8gee6TSWFZ+flOxvQm5ZSDFQX4S3U+u+xp26f3p+1HhBM+KXd
	 a3Ag7DxmX+wPA==
Date: Wed, 6 Mar 2024 12:50:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>, linux-mm@kvack.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	kpsingh@google.com, jannh@google.com, jolsa@kernel.org, daniel@iogearbox.net, 
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 bpf-next 2/9] bpf: add new acquire/release BPF kfuncs
 for mm_struct
Message-ID: <20240306-plazieren-schaben-e086ab1b92ef@brauner>
References: <cover.1709675979.git.mattbobrowski@google.com>
 <eb9fb133d5611d40ab1f073cc2fcaa48cb581998.1709675979.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb9fb133d5611d40ab1f073cc2fcaa48cb581998.1709675979.git.mattbobrowski@google.com>

On Wed, Mar 06, 2024 at 07:39:31AM +0000, Matt Bobrowski wrote:
> A BPF LSM program will at times introspect the mm_struct that is
> nested within a given task_struct. Such introspection performed by a
> BPF LSM program may involve reading virtual addresses out from fields
> like arg_start/arg_end and env_start/env_end, or reading fields
> directly out from the backing exe_file. In order to perform reliable
> reads against fields contained within mm_struct, we need to introduce
> a new set of BPF kfuncs that have the ability to acquire and release
> references on the mm_struct that is nested within a task_struct.
> 
> The following BPF kfuncs have been added in order to support this
> capability:
> 
> struct mm_struct *bpf_task_mm_grab(struct task_struct *task);
> void bpf_mm_drop(struct mm_struct *mm);
> 
> These new BPF kfuncs are pretty self-explanatory, but in kernel terms
> bpf_task_mm_grab() effectively allows you to get a reference on the
> mm_struct nested within a supplied task_struct. Whereas, bpf_mm_drop()
> allows you put a reference on a previously gotten mm_struct
> reference. Both BPF kfuncs are also backed by BPF's respective
> KF_ACQUIRE/KF_RELEASE semantics, ensuring that the BPF program behaves
> in accordance to the constraints enforced upon it when operating on
> reference counted in-kernel data structures.
> 
> Notably, these newly added BPF kfuncs are simple wrappers around the
> mmgrab() and mmdrop() in-kernel helpers. Both mmgrab() and mmdrop()
> are used in favour of their somewhat similar counterparts mmget() and
> mmput() as they're considered to be the more lightweight variants in
> comparison, and there's no requirement to also pin the underlying
> address spaces just yet.
> 
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---

That's not something I can in any way ACK or NAK. That's clearly mm.
And same question as in the other mail. What's the user of this? I find
it extremly strange that the justification is "some LSM program" needs
this. This is really an annoying justification when we can't even see
the users. With LSMs we can at least see what they're doing with this in
their hooks.

>  kernel/trace/bpf_trace.c | 47 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index f639663ac339..801808b6efb0 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1473,10 +1473,57 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
>  	return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, value_len);
>  }
>  
> +/**
> + * bpf_task_mm_grab - get a reference on the mm_struct nested within the
> + * 		      supplied task_struct
> + * @task: task_struct nesting the mm_struct that is to be referenced
> + *
> + * Grab a reference on the mm_struct that is nested within the supplied
> + * *task*. This kfunc will return NULL for threads that do not possess a valid
> + * mm_struct. For example, those that are flagged as PF_KTHREAD. A reference on
> + * a mm_struct acquired by this kfunc must be released using bpf_mm_drop().
> + *
> + * This helper only pins the mm_struct and not necessarily the address space
> + * associated with the referenced mm_struct that is returned from this
> + * kfunc. Internally, this kfunc leans on mmgrab(), such that calling
> + * bpf_task_mm_grab() would be analogous to calling mmgrab() outside of BPF
> + * program context.
> + *
> + * Return: A referenced pointer to the mm_struct nested within the supplied
> + * *task*, or NULL.
> + */
> +__bpf_kfunc struct mm_struct *bpf_task_mm_grab(struct task_struct *task)
> +{
> +	struct mm_struct *mm;
> +
> +	task_lock(task);
> +	mm = task->mm;
> +	if (likely(mm))
> +		mmgrab(mm);
> +	task_unlock(task);
> +
> +	return mm;
> +}
> +
> +/**
> + * bpf_mm_drop - put a reference on the supplied mm_struct
> + * @mm: mm_struct of which to put a reference on
> + *
> + * Put a reference on the supplied *mm*. This kfunc internally leans on
> + * mmdrop(), such that calling bpf_mm_drop() would be analogous to calling
> + * mmdrop() outside of BPF program context.
> + */
> +__bpf_kfunc void bpf_mm_drop(struct mm_struct *mm)
> +{
> +	mmdrop(mm);
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(lsm_kfunc_set_ids)
>  BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_task_mm_grab, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL);
> +BTF_ID_FLAGS(func, bpf_mm_drop, KF_RELEASE);
>  BTF_KFUNCS_END(lsm_kfunc_set_ids)
>  
>  static int bpf_lsm_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 
> /M

