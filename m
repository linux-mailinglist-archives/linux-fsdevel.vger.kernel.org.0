Return-Path: <linux-fsdevel+bounces-69635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7510C7F602
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 09:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFDB64E12AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B3325B311;
	Mon, 24 Nov 2025 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4nb9B6N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C11D5154;
	Mon, 24 Nov 2025 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763972332; cv=none; b=jOnUyLDKNJSn+Bjl3OEsuv7M6GV9gxNWNMyrLvm6JtQ3v/bBzfxKrRs2RrM39Tnp0zP+Z10CLVIOCXucr0UkBiaDwOqsE11t46GsM9dJoIVt7ZV6DogwgbiTfZZSQpXAPM+2L+M9kaYkhEvMFmP/EnAYzadilnCNlY2LE6PkJYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763972332; c=relaxed/simple;
	bh=WYWLQ0T4dkN8ERXG3u9J8ksvyh7k5Zp6ptzavMDxTI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alq3DNfgqoaFunODM4aLSNl6NSIQnYVxwCYoM7+6z9pXl9+FR7dscCGoRLf/wL3EpifNuhZNhSQQHR6bUstIxAPzo2ELcPZ62kMgt3qe3T8jZ4l9Bi3euuuY3nHgviEopUmOKz0KckCaGBwvrhw365nt2sjBaDweV7UQhEAfVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4nb9B6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A781AC4CEF1;
	Mon, 24 Nov 2025 08:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763972332;
	bh=WYWLQ0T4dkN8ERXG3u9J8ksvyh7k5Zp6ptzavMDxTI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4nb9B6NtVz90XW2XdKcz2w3HBHpJZR/aM1ZNR35r4yvDfhHSypM9mzA3W6YfsD/b
	 CWTbTvQXuj2Ivelvod05bz13F/xMHSMh1eB4TIvqOhmzJgVuCYUbTaBRdIMDu+WsnQ
	 Hv9hSiSlm6h42pfXMm7526csug76VGAcAJ2QBfe7LaRFocbC8f65jRuQcfxoz+Yj6F
	 cDXFj8FL/XpKzmWpGWFT8PIva62JL2DAm1+v1Af9C+1qlUdrYFe5xrV3OBFSKfdEFW
	 kYCoeLF1kbCOnDt1/j3vavEhYmdYkkkz/YxhVQ7NzlE5exG8jkVQg3JaMIns28yd2n
	 VlYneYz7SNm7w==
Date: Mon, 24 Nov 2025 10:18:28 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v7 06/22] liveupdate: luo_file: implement file systems
 callbacks
Message-ID: <aSQU1LlPDDsN2rUw@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-7-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122222351.1059049-7-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:33PM -0500, Pasha Tatashin wrote:
> This patch implements the core mechanism for managing preserved
> files throughout the live update lifecycle. It provides the logic to
> invoke the file handler callbacks (preserve, unpreserve, freeze,
> unfreeze, retrieve, and finish) at the appropriate stages.
> 
> During the reboot phase, luo_file_freeze() serializes the final
> metadata for each file (handler compatible string, token, and data
> handle) into a memory region preserved by KHO. In the new kernel,
> luo_file_deserialize() reconstructs the in-memory file list from this
> data, preparing the session for retrieval.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

With some comments below
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/kho/abi/luo.h      |  39 +-
>  include/linux/liveupdate.h       |  98 ++++
>  kernel/liveupdate/Makefile       |   1 +
>  kernel/liveupdate/luo_file.c     | 882 +++++++++++++++++++++++++++++++
>  kernel/liveupdate/luo_internal.h |  38 ++
>  5 files changed, 1057 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/liveupdate/luo_file.c
> 

...

> +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
> +{
> +	struct liveupdate_file_op_args args = {0};
> +	struct liveupdate_file_handler *fh;
> +	struct luo_file *luo_file;
> +	struct file *file;
> +	int err;
> +
> +	if (luo_token_is_used(file_set, token))
> +		return -EEXIST;
> +
> +	file = fget(fd);
> +	if (!file)
> +		return -EBADF;
> +
> +	err = luo_alloc_files_mem(file_set);
> +	if (err)
> +		goto  err_files_mem;
> +
> +	if (file_set->count == LUO_FILE_MAX) {

This can be checked before getting the file and allocating memory, can't it?

> +		err = -ENOSPC;
> +		goto err_files_mem;

The goto label should say what it does, not what the error was.

> +	}
> +
> +	err = -ENOENT;
> +	luo_list_for_each_private(fh, &luo_file_handler_list, list) {
> +		if (fh->ops->can_preserve(fh, file)) {
> +			err = 0;
> +			break;
> +		}
> +	}
> +
> +	/* err is still -ENOENT if no handler was found */
> +	if (err)
> +		goto err_files_mem;
> +
> +	luo_file = kzalloc(sizeof(*luo_file), GFP_KERNEL);
> +	if (!luo_file) {
> +		err = -ENOMEM;
> +		goto err_files_mem;
> +	}
> +
> +	luo_file->file = file;
> +	luo_file->fh = fh;
> +	luo_file->token = token;
> +	luo_file->retrieved = false;
> +	mutex_init(&luo_file->mutex);
> +
> +	args.handler = fh;
> +	args.file = file;
> +	err = fh->ops->preserve(&args);
> +	if (err)
> +		goto err_kfree;
> +
> +	luo_file->serialized_data = args.serialized_data;
> +	list_add_tail(&luo_file->list, &file_set->files_list);
> +	file_set->count++;
> +
> +	return 0;
> +
> +err_kfree:
> +	mutex_destroy(&luo_file->mutex);

Don't think we need this, luo_file is freed in the next line.

> +	kfree(luo_file);
> +err_files_mem:
> +	fput(file);
> +	luo_free_files_mem(file_set);

I'd have the error path as

err_free_luo_file:
	kfree(luo_file);
err_free_files_mem:
	luo_free_files_mem(file_set);
err_put_file:
	fput(file);

> +
> +	return err;
> +}

...

> +void luo_file_unpreserve_files(struct luo_file_set *file_set)
> +{
> +	struct luo_file *luo_file;
> +
> +	while (!list_empty(&file_set->files_list)) {

list_for_each_entry_safe_reverse()?

> +		struct liveupdate_file_op_args args = {0};
> +
> +		luo_file = list_last_entry(&file_set->files_list,
> +					   struct luo_file, list);
> +
> +		args.handler = luo_file->fh;
> +		args.file = luo_file->file;
> +		args.serialized_data = luo_file->serialized_data;
> +		luo_file->fh->ops->unpreserve(&args);
> +
> +		list_del(&luo_file->list);
> +		file_set->count--;
> +
> +		fput(luo_file->file);
> +		mutex_destroy(&luo_file->mutex);
> +		kfree(luo_file);
> +	}
> +
> +	luo_free_files_mem(file_set);
> +}

...

> +int luo_file_finish(struct luo_file_set *file_set)
> +{
> +	struct list_head *files_list = &file_set->files_list;
> +	struct luo_file *luo_file;
> +	int err;
> +
> +	if (!file_set->count)
> +		return 0;
> +
> +	list_for_each_entry(luo_file, files_list, list) {
> +		err = luo_file_can_finish_one(file_set, luo_file);
> +		if (err)
> +			return err;
> +	}
> +
> +	while (!list_empty(&file_set->files_list)) {

list_for_each_entry_safe_reverse()?

> +		luo_file = list_last_entry(&file_set->files_list,
> +					   struct luo_file, list);
> +
> +		luo_file_finish_one(file_set, luo_file);
> +
> +		if (luo_file->file)
> +			fput(luo_file->file);
> +		list_del(&luo_file->list);
> +		file_set->count--;
> +		mutex_destroy(&luo_file->mutex);
> +		kfree(luo_file);
> +	}
> +

...

> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> index 1292ac47eef8..c8973b543d1d 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -40,6 +40,28 @@ static inline int luo_ucmd_respond(struct luo_ucmd *ucmd,
>   */
>  #define luo_restore_fail(__fmt, ...) panic(__fmt, ##__VA_ARGS__)
>  
> +/* Mimics list_for_each_entry() but for private list head entries */
> +#define luo_list_for_each_private(pos, head, member)				\
> +	for (struct list_head *__iter = (head)->next;				\
> +	     __iter != (head) &&						\
> +	     ({ pos = container_of(__iter, typeof(*(pos)), member); 1; });	\
> +	     __iter = __iter->next)

Ideally something like this should go to include/linux/list.h, but it can
be done later to avoid bikeshedding about the name :)

And you can reuse most of list_for_each_entry, just replace the line that
accesses __private member:

#define luo_list_for_each_private(pos, head, member)			\
	for (pos = list_first_entry(head, typeof(*pos), member);	\
	     &ACCESS_PRIVATE(pos, member) != head;			\
	     pos = list_next_entry(pos, member))

-- 
Sincerely yours,
Mike.

