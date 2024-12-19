Return-Path: <linux-fsdevel+bounces-37821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF309F7F3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BC4162D66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048922653B;
	Thu, 19 Dec 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MxTEy8hy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC482225A2C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625199; cv=none; b=rpZy3OjFRmu4T5lsL6So2oqgSlztHsMk28Tnbgev+rTqMB7MnNiM2V/dyMsMAl3HCnNGbbPKryR+GAd9Uz6QIBSdYMOcxP6UVBQu5QzAKiMjr8vhpnUz6ejTNrKVZCwRuBqOIzs3osq27CGT2DH4nDz6e/J5j2IU/HcsQIH4J3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625199; c=relaxed/simple;
	bh=RC/9mN8nAlNkQtQPodIEHtHnBwegDrotGV0lG6F6U4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEt9anmFlehJ+UBU4eFif+s8zsgrIZjoqnAydGWHMiZrrFKu3yRH9QMHX4g59ZzsacWBi/anSHztBiPI1UCeTCO/RdQiyXls3RcFg33UveiG0+LN94vE/dKnEr0tO+olTqim2LZ2iPoE+Vwr1cHCI8/TaH0yHXZLDgOpUSLidlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MxTEy8hy; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e8249b41-c96f-4d0d-a12f-a698c76f34b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734625185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+X4PXBuSAYtgPxGtRLP9sTcjWrwUEmvye0BtXKHCW1s=;
	b=MxTEy8hyMbtvdpp/fKDY1bjJv99r7jU4alQ1NtXSA+iyoWfvfJWZMEIBCJV8vhV0/hiZ+t
	M/gw2Y/MqnEdozV/y10hRPlbYJXOwFGNiqy9btBsoDdjgtCL/fRtdPGxBMzUlKAMxORZvf
	+KmZJWveBILQPHVznupw/viJpKV7cY8=
Date: Thu, 19 Dec 2024 08:19:38 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/5] bpf: Introduce task_file open-coded
 iterator kfuncs
Content-Language: en-GB
To: Juntong Deng <juntong.deng@outlook.com>, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, snorcht@gmail.com, brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50807D3E0975E184C4D1D0FB99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <AM6PR03MB50807D3E0975E184C4D1D0FB99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 12/17/24 3:37 PM, Juntong Deng wrote:
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
>   kernel/bpf/helpers.c   |  3 ++
>   kernel/bpf/task_iter.c | 91 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 94 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cd5f9884d85b..61a652bea0ba 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3147,6 +3147,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
>   BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
>   BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
>   BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 98d9b4c0daff..149a95762f68 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -1027,6 +1027,97 @@ __bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
>   {
>   }
>   
> +struct bpf_iter_task_file_item {
> +	struct task_struct *task;
> +	struct file *file;
> +	unsigned int fd;
> +} __aligned(8);

We probably do not __aligned(8) here as alignment has been
guaranteed in struct bpf_iter_task_file_kern.

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
> + * @task: a pointer pointing to a task to be iterated over
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
> +	item->fd = kit->next_fd;
> +
> +	kit->next_fd++;
> +
> +	if (!item->file)
> +		return NULL;

Maybe move the above if statement right after
	iterm->file = fget_task_next(item->task, &kit->next_fd);
to make code more coherent?

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
>   __bpf_kfunc_end_defs();
>   
>   DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);


