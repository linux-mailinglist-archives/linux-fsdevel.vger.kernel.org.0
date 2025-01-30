Return-Path: <linux-fsdevel+bounces-40401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6768CA23173
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A813A6F07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016B71EC011;
	Thu, 30 Jan 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxhCyZfl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B1F1EBA02;
	Thu, 30 Jan 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738253090; cv=none; b=rRpvFiZPGksRGtx6S5MECt2UNFEGU77Mf9uEIm/zO+QlvbnotkmLhGAMpgjcThLb0G1B2g4c7k7dh8v/WVozaKKW1/LeqoRpjDgJKnzW5NpG+u7sIcYiuG9p/OyeLzERqVtr8wW9cKtVogHyVUOXlgiOITPull9X+XpTPGFGtxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738253090; c=relaxed/simple;
	bh=AYLbUouqbK4R93QojCgMLxCHxiD6mQwuOuctmWkMZN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv23VnxLZBAJAg/IAkyuLlnL6Vk23qfnR7/HWhPzu1lU+Qt90U6Nwvy4bV7sp9yBbvDbNrGkbDPcLmNg7i2BqCRjcxfqQ7/kV5hwi5KlYDt1facGM+KwnfsFIB1fpu5MWVDo4Wt6W7rdZLnVPfBq51YUD04GJQWC3j73hM55JqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxhCyZfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2F5C4CEE0;
	Thu, 30 Jan 2025 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738253089;
	bh=AYLbUouqbK4R93QojCgMLxCHxiD6mQwuOuctmWkMZN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MxhCyZfly9ODkHR1ppVjmGHyov234mPSuLrEnnC5wKSSpiNnqZZoiYi/bDd2+wYDt
	 F9T5ylsfregi7IGtidlH8AEN/x9OztuTWC3ENbBDsXikIhf+4Bcuv/0jeG/0zpJay2
	 GymoMwgfCrQR4R2ALs9hRgAd7pmHH+hRQmkOP8vlJ3PiG4nL6mZXYDgD0As9sfcwT0
	 hsHJroU80G20/ld0tUkx7S3tybnkDGr0kk65ELqTDc1IJ+Y6UvyXM/TAcdqDSzOyWY
	 P+VWGlDF6Y5cr3JqqdUkNNg8g5Xlg6d/MbVCWW2rHkp3bw4H5nAF99SmOB7W/UQfye
	 aKpQq38z+uaOw==
Date: Thu, 30 Jan 2025 17:04:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Introduce task_file open-coded
 iterator kfuncs
Message-ID: <20250130-hautklinik-quizsendung-d36d8146bc7b@brauner>
References: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50802EA81C89D22791CCF09099EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR03MB50802EA81C89D22791CCF09099EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>

On Mon, Jan 27, 2025 at 11:46:50PM +0000, Juntong Deng wrote:
> This patch adds the open-coded iterator style process file iterator
> kfuncs bpf_iter_task_file_{new,next,destroy} that iterates over all
> files opened by the specified process.
> 
> bpf_iter_task_file_next returns a pointer to bpf_iter_task_file_item,
> which currently contains *task, *file, fd. This is an extensible
> structure that enables compatibility with different versions
> through CO-RE.
> 
> The reference to struct file acquired by the previous
> bpf_iter_task_file_next() is released in the next
> bpf_iter_task_file_next(), and the last reference is released in the
> last bpf_iter_task_file_next() that returns NULL.
> 
> In the bpf_iter_task_file_destroy(), if the iterator does not iterate to
> the end, then the last struct file reference is released at this time.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---

I deeply dislike that this allows bpf programs to iterate through
another tasks files more than what is already possible with the
task_file_seq_* bpf api.

This here means that bpf programs have access to all file types that
exist in the kernel. From general simple filesystem files to pidfds, kvm
fd, epoll fd, drm fds - anything you can think of. And then do arbitrary
and ever expanding stuff with those files from the iterator with less
restrictions (if I'm reading this right) than the task_file_seq_*
iterator.

Possibly even keeping that reference for a long time leading to weird
EBUSY issues for filesystem shutdown and similar problems.

This is a bad idea. Even in the kernel we only allow this type of
iteration for procfs and procfs-like usage and there we hold references
to files from another task for a very short time when we e.g., access
/proc/<PID>/fd/.

And you already have an iterator for that with task_file_seq_get_*()
even if it is more work.

I'm also not at all swayed by the fact that this is coming out of an
effort to move CRIU into bpf just to make things easier. Not a selling
point as we do have CRIU and I don't think we need to now put more CRIU
related stuff into the kernel.

So this will not get an ACK from me. I'm putting Al and Linus here as
well as they might have opinions on this and might disagree with me.

>  kernel/bpf/helpers.c   |  3 ++
>  kernel/bpf/task_iter.c | 90 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index f27ce162427a..359c5bbf4814 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3157,6 +3157,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 98d9b4c0daff..24a5af67e6c8 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -1027,6 +1027,96 @@ __bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
>  {
>  }
>  
> +struct bpf_iter_task_file_item {
> +	struct task_struct *task;
> +	struct file *file;
> +	unsigned int fd;
> +};
> +
> +struct bpf_iter_task_file {
> +	__u64 __opaque[4];
> +} __aligned(8);
> +
> +struct bpf_iter_task_file_kern {
> +	struct bpf_iter_task_file_item item;
> +	unsigned int next_fd;
> +} __aligned(8);
> +
> +/**
> + * bpf_iter_task_file_new() - Initialize a new task file iterator for a task,
> + * used to iterate over all files opened by a specified task
> + *
> + * @it: the new bpf_iter_task_file to be created
> + * @task: a pointer pointing to the task to be iterated over
> + */
> +__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it, struct task_struct *task)
> +{
> +	struct bpf_iter_task_file_kern *kit = (void *)it;
> +	struct bpf_iter_task_file_item *item = &kit->item;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(struct bpf_iter_task_file));
> +	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=
> +		     __alignof__(struct bpf_iter_task_file));
> +
> +	item->task = get_task_struct(task);
> +	item->file = NULL;
> +	item->fd = 0;
> +	kit->next_fd = 0;
> +
> +	return 0;
> +}
> +
> +/**
> + * bpf_iter_task_file_next() - Get the next file in bpf_iter_task_file
> + *
> + * bpf_iter_task_file_next acquires a reference to the struct file.
> + *
> + * The reference to struct file acquired by the previous
> + * bpf_iter_task_file_next() is released in the next bpf_iter_task_file_next(),
> + * and the last reference is released in the last bpf_iter_task_file_next()
> + * that returns NULL.
> + *
> + * @it: the bpf_iter_task_file to be checked
> + *
> + * @returns a pointer to bpf_iter_task_file_item
> + */
> +__bpf_kfunc struct bpf_iter_task_file_item *bpf_iter_task_file_next(struct bpf_iter_task_file *it)
> +{
> +	struct bpf_iter_task_file_kern *kit = (void *)it;
> +	struct bpf_iter_task_file_item *item = &kit->item;
> +
> +	if (item->file)
> +		fput(item->file);
> +
> +	item->file = fget_task_next(item->task, &kit->next_fd);
> +	if (!item->file)
> +		return NULL;
> +
> +	item->fd = kit->next_fd;
> +	kit->next_fd++;
> +
> +	return item;
> +}
> +
> +/**
> + * bpf_iter_task_file_destroy() - Destroy a bpf_iter_task_file
> + *
> + * If the iterator does not iterate to the end, then the last
> + * struct file reference is released at this time.
> + *
> + * @it: the bpf_iter_task_file to be destroyed
> + */
> +__bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it)
> +{
> +	struct bpf_iter_task_file_kern *kit = (void *)it;
> +	struct bpf_iter_task_file_item *item = &kit->item;
> +
> +	if (item->file)
> +		fput(item->file);
> +
> +	put_task_struct(item->task);
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
> -- 
> 2.39.5
> 

