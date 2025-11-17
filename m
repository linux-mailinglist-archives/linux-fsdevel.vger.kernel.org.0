Return-Path: <linux-fsdevel+bounces-68706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9309C6383C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA80E360805
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8F31D756;
	Mon, 17 Nov 2025 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVxQd+jd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C12D97AA;
	Mon, 17 Nov 2025 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374580; cv=none; b=uj7Zi2NQsb6sXWvp48p4tQAKj+eza3lPYONEGyaydvVhtFJs8KYBgxd47+D1+gd/7doFTfZPiXOOxOnOa5mhCtsqVJ607+UNUdzzpkd3QJ55R5ffxIuYNzA5CuR+Pup2+0s5g6d+YVAgA7KHqRJm2ys2y1OAc31xKGol92dRtmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374580; c=relaxed/simple;
	bh=3pqt/emoxDXMJPc9sIUv8mSiIo4NlUAIW0OPRzW2AvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6Zd546okZW1EuOQcN+w0GQozfL7/YklU8zzbwwPLhSmuXU4GFqhqRECUUIbD9mcHkqXambRpQ5r9w6TSBLknz/BsaiQukpM13hYV4y/E5480GanaZrhLdmRESVXIOPm7NHOLT+bsou8OBosxaqsXl8aLjRjjF5OoR08HgIGlnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVxQd+jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA8CC19422;
	Mon, 17 Nov 2025 10:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763374579;
	bh=3pqt/emoxDXMJPc9sIUv8mSiIo4NlUAIW0OPRzW2AvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVxQd+jd5trmwBgh/3zu4hTlLkx/9p5IL33qFYnWaBIb3WLOyiuAgzqHpcoyY8DvC
	 ZKiyBaH9cpng8Pso5NAbKGCW1AMqksvLeji0z7vLUtQynPZB7dfXmSo5pGdXpGyo+1
	 9y1zMypZS9pqu5U01wxSxH6kHOxp1xOme4U3op9CTwfVOcLKDGW9HLxzfcokqvHM1X
	 N5dXERXMh6/b5uyPBs0Z2qK1b8rH9LyONeVyW6Q8jsrspPSPTwlC3Vk/hn6kNAKrIF
	 IkGYpSBwyj2A2bCkDZfCTKCKnmMjwvr+Fr8ufs+Q1LYALnWpYdlaUoyTJeOPu56txT
	 eO8bZlmOwn+hA==
Date: Mon, 17 Nov 2025 12:15:57 +0200
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
Subject: Re: [PATCH v6 14/20] liveupdate: luo_file: add private argument to
 store runtime state
Message-ID: <aRr13Q1xk9eunilo@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-15-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-15-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:34:00PM -0500, Pasha Tatashin wrote:
> From: Pratyush Yadav <pratyush@kernel.org>
> 
> Currently file handlers only get the serialized_data field to store
> their state. This field has a pointer to the serialized state of the
> file, and it becomes a part of LUO file's serialized state.
> 
> File handlers can also need some runtime state to track information that
> shouldn't make it in the serialized data.
> 
> One such example is a vmalloc pointer. While kho_preserve_vmalloc()
> preserves the memory backing a vmalloc allocation, it does not store the
> original vmap pointer, since that has no use being passed to the next
> kernel. The pointer is needed to free the memory in case the file is
> unpreserved.
> 
> Provide a private field in struct luo_file and pass it to all the
> callbacks. The field's can be set by preserve, and must be freed by
> unpreserve.
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/liveupdate.h   | 5 +++++
>  kernel/liveupdate/luo_file.c | 9 +++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> index 36a831ae3ead..defc69a1985d 100644
> --- a/include/linux/liveupdate.h
> +++ b/include/linux/liveupdate.h
> @@ -29,6 +29,10 @@ struct file;
>   *                    this to the file being operated on.
>   * @serialized_data:  The opaque u64 handle, preserve/prepare/freeze may update
>   *                    this field.
> + * @private_data:     Private data for the file used to hold runtime state that
> + *                    is not preserved. Set by the handler's .preserve()
> + *                    callback, and must be freed in the handler's
> + *                    .unpreserve() callback.
>   *
>   * This structure bundles all parameters for the file operation callbacks.
>   * The 'data' and 'file' fields are used for both input and output.
> @@ -39,6 +43,7 @@ struct liveupdate_file_op_args {
>  	bool retrieved;
>  	struct file *file;
>  	u64 serialized_data;
> +	void *private_data;
>  };
>  
>  /**
> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index 3d3bd84cb281..df337c9c4f21 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -126,6 +126,10 @@ static LIST_HEAD(luo_file_handler_list);
>   *                 This handle is passed back to the handler's .freeze(),
>   *                 .retrieve(), and .finish() callbacks, allowing it to track
>   *                 and update its serialized state across phases.
> + * @private_data:  Pointer to the private data for the file used to hold runtime
> + *                 state that is not preserved. Set by the handler's .preserve()
> + *                 callback, and must be freed in the handler's .unpreserve()
> + *                 callback.
>   * @retrieved:     A flag indicating whether a user/kernel in the new kernel has
>   *                 successfully called retrieve() on this file. This prevents
>   *                 multiple retrieval attempts.
> @@ -152,6 +156,7 @@ struct luo_file {
>  	struct liveupdate_file_handler *fh;
>  	struct file *file;
>  	u64 serialized_data;
> +	void *private_data;
>  	bool retrieved;
>  	struct mutex mutex;
>  	struct list_head list;
> @@ -309,6 +314,7 @@ int luo_preserve_file(struct luo_session *session, u64 token, int fd)
>  		goto exit_err;
>  	} else {
>  		luo_file->serialized_data = args.serialized_data;
> +		luo_file->private_data = args.private_data;
>  		list_add_tail(&luo_file->list, &session->files_list);
>  		session->count++;
>  	}
> @@ -356,6 +362,7 @@ void luo_file_unpreserve_files(struct luo_session *session)
>  		args.session = (struct liveupdate_session *)session;
>  		args.file = luo_file->file;
>  		args.serialized_data = luo_file->serialized_data;
> +		args.private_data = luo_file->private_data;
>  		luo_file->fh->ops->unpreserve(&args);
>  		luo_flb_file_unpreserve(luo_file->fh);
>  
> @@ -384,6 +391,7 @@ static int luo_file_freeze_one(struct luo_session *session,
>  		args.session = (struct liveupdate_session *)session;
>  		args.file = luo_file->file;
>  		args.serialized_data = luo_file->serialized_data;
> +		args.private_data = luo_file->private_data;
>  
>  		err = luo_file->fh->ops->freeze(&args);
>  		if (!err)
> @@ -405,6 +413,7 @@ static void luo_file_unfreeze_one(struct luo_session *session,
>  		args.session = (struct liveupdate_session *)session;
>  		args.file = luo_file->file;
>  		args.serialized_data = luo_file->serialized_data;
> +		args.private_data = luo_file->private_data;
>  
>  		luo_file->fh->ops->unfreeze(&args);
>  	}
> -- 
> 2.52.0.rc1.455.g30608eb744-goog
> 

-- 
Sincerely yours,
Mike.

