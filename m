Return-Path: <linux-fsdevel+bounces-50778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEABDACF7F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 21:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808EA189CDEE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F17927C864;
	Thu,  5 Jun 2025 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWQcaNf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B84127FB02
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151643; cv=none; b=dnIvnEfS+1OD0GBKDyk59oz4eNrkgtJxyMGk+sjoaA94MEj6Hw+96Cfx7f9x5YOMXZgByPZHJUxarfRBQdwCF5bCkMDw4nCb+LZ4pNCwpa/b+TwLSLLkhfTI9OVHBIb9rFlYSUA/RHDBU3PjurHYRb5j8hOfvl1cUgNf7g364HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151643; c=relaxed/simple;
	bh=IMpfA1wqZarLzuB4nrBCzI9upCvhdpPW0XmBDJS/1F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1UKOmSmc1NcnK5G9NGy4gaDQQDu+5FbI4rhVlS1eMplt7Zfnhypyz4LemInkJ3cu7e2S34mPPlkxmu12Oas/XOZghCFyfQxjXOuZlGytHUHfNwLXcTCGUTxdRgio9XxPrV04lUD7ug6VPKEwGvnI3WwPgN9BsEZRNth+03kyBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QWQcaNf+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-606bbe60c01so2378689a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749151640; x=1749756440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ktTlyyYyWStVAYtvm1hFc3t1pciBGiotvMTYgEWetf4=;
        b=QWQcaNf++5qYLOUIj+IO/rjRTBXp83BqsE54IYD7IfqWirN6HhUp0pqo70TI0f2JIh
         cWlOp5OuEEf0Zfn6MYxS7N+d+zDj0A5jG/7+n6XFRtZvxoaOVkKSoNeGzh/zJ7EYDLfK
         vPNVAmKqsvkJCjfzwOEpHKt/zlt8N2ujT80hdY/cZ99FuBytnfXUgPJuSs/ZI5VP7Ha9
         /JfCnVyRQWYojbRkfgyhB9qHDSVK97zZF3y8mHBIeJx3yQVPjL79sAxXRW+GMYe5ja+k
         JQlRORPkrJLMbp4nBRAIGJrUN0CThaK2WS3KR3qxsbV0Vv/oBfMd5wvYIhycxBGjSkSt
         leUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749151640; x=1749756440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktTlyyYyWStVAYtvm1hFc3t1pciBGiotvMTYgEWetf4=;
        b=Er3tCkNLFO05opfwdKADMT5jPUYbdZQS4kGifb26KV2XIJur4Urt6guwfn3IIK1U1z
         +FMO5c8WImYd1r9Qo6sT1hsh3s9L+g4fhnfc7bQBpulpm24zagU8emuapfizUxkswjpT
         Jw3Q9LxZWlDQrOomb6Mf66igdFuCSE6YzDGoo+GAJTiiWzYFbDC9VhG/qUCuGLkb643y
         CdvbZt2XER2UaO9qW3h3Y12jkW9Uv1vU47J/QNMdMJqQhSMvN1v5nx+dEpYU2glzV1bj
         UGedK2NUx4GDGyHpAej6os43cJQx3WRmOYHN3Y/uGgWhJ3CB8u3++qEj9LUoTfpbTMBu
         XH8A==
X-Forwarded-Encrypted: i=1; AJvYcCUg6aH7PQ5byRsOI2a5PPmNwJsYDUggXJny7q8MlfCSpLzVTSMv0CboOI0N406YKmf7gq9eW6sWbx5vtZny@vger.kernel.org
X-Gm-Message-State: AOJu0YxZiQjDu0/CIHM/vhRzvLq18DQWQ91OhyL+WsMmGtwq56uJ/1Lx
	EX30hPbFBTp8c2wSsu/Xh3/oFEpH278AO/n+kEJcFdxCK9rnoeg6nuWNlZxWEM4FdST/dvOUeQE
	dVxxZedKa
X-Gm-Gg: ASbGnctwCDyN0KXe2d7rnhmcS2sp22KNL842xvd6XYDWBljo9JZ3xQissYdTmbDCktH
	bGuJnumpasoSY7bujK5SOA2yoDOWR5MjaVQMkoa28qDGa1Wbp9dQcuti3JC/Nv4rj3fn5g3bvAN
	EzstJvMrH8yD5bWMSye8O4P1OhdJInJSFozRDIF2lEqzhSMkph4zB9pcktbM4mRYlAyttq1nY7H
	f5Wx25WXzuE3qyRdP3txrUKAvOL96iwID2JY+Ma9JCyp9N8IbKS2SLA3TahkYkUaraekYpclWVm
	ilZw0TunFBQGSDKBp9qsTbWrcJYjX4U35ubH19ITHzdct9qriFUx2+R8ykchkx1hitxNVRNbjZG
	XSoOrQeq+LUXZ2aPMpASPN47Btg==
X-Google-Smtp-Source: AGHT+IGR0eQhUdX+BE/0D+8bzRt7h0N4AhkbBRetRMSEQ3qUIwv2gsp2KOR1vdCbT3C2qlHJYvRLaQ==
X-Received: by 2002:a05:6402:50d2:b0:604:e33f:e5c0 with SMTP id 4fb4d7f45d1cf-60774b8001amr329835a12.30.1749151639586;
        Thu, 05 Jun 2025 12:27:19 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6077837756esm34452a12.17.2025.06.05.12.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 12:27:18 -0700 (PDT)
Date: Thu, 5 Jun 2025 19:27:13 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kpsingh@kernel.org, amir73il@gmail.com, repnop@google.com,
	jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net,
	gnoack@google.com, m@maowtm.org
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <aEHvkQ1C7Ne1dB4n@google.com>
References: <20250603065920.3404510-1-song@kernel.org>
 <20250603065920.3404510-4-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603065920.3404510-4-song@kernel.org>

On Mon, Jun 02, 2025 at 11:59:19PM -0700, Song Liu wrote:
> Introduce a path iterator, which reliably walk a struct path toward
> the root. This path iterator is based on path_walk_parent. A fixed
> zero'ed root is passed to path_walk_parent(). Therefore, unless the
> user terminates it earlier, the iterator will terminate at the real
> root.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/Makefile    |  1 +
>  kernel/bpf/helpers.c   |  3 +++
>  kernel/bpf/path_iter.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c  |  5 ++++
>  4 files changed, 67 insertions(+)
>  create mode 100644 kernel/bpf/path_iter.c
> 
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 3a335c50e6e3..454a650d934e 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
>  ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
>  obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
>  endif
> +obj-$(CONFIG_BPF_SYSCALL) += path_iter.o
>  
>  CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b71e428ad936..b190c78e40f6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3397,6 +3397,9 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPAB
>  BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>  #endif
>  BTF_ID_FLAGS(func, __bpf_trap)
> +BTF_ID_FLAGS(func, bpf_iter_path_new, KF_ITER_NEW | KF_SLEEPABLE)

Hm, I'd expect KF_TRUSTED_ARGS to be enforced onto
bpf_iter_path_new(), no? Shouldn't this only be operating on a stable
struct path reference?

> +BTF_ID_FLAGS(func, bpf_iter_path_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_iter_path_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)

At this point, the claim is that such are only to be used from the
context of the BPF LSM. If true, I'd expect these BPF kfuncs to be
part of bpf_fs_kfunc_set_ids once moved into fs/bpf_fs_kfuncs.c.

>  static const struct btf_kfunc_id_set common_kfunc_set = {
> diff --git a/kernel/bpf/path_iter.c b/kernel/bpf/path_iter.c
> new file mode 100644
> index 000000000000..0d972ec84beb
> --- /dev/null
> +++ b/kernel/bpf/path_iter.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <linux/bpf.h>
> +#include <linux/bpf_mem_alloc.h>
> +#include <linux/namei.h>
> +#include <linux/path.h>
> +
> +/* open-coded iterator */
> +struct bpf_iter_path {
> +	__u64 __opaque[3];
> +} __aligned(8);
> +
> +struct bpf_iter_path_kern {
> +	struct path path;
> +	__u64 flags;
> +} __aligned(8);
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_iter_path_new(struct bpf_iter_path *it,
> +				  struct path *start,
> +				  __u64 flags)
> +{
> +	struct bpf_iter_path_kern *kit = (void *)it;
> +
> +	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
> +	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
> +
> +	if (flags) {
> +		memset(&kit->path, 0, sizeof(struct path));

This warrants a comment for sure. Also why not just zero it out
entirely?

> +		return -EINVAL;
> +	}
> +
> +	kit->path = *start;
> +	path_get(&kit->path);
> +	kit->flags = flags;
> +
> +	return 0;
> +}
> +
> +__bpf_kfunc struct path *bpf_iter_path_next(struct bpf_iter_path *it)
> +{
> +	struct bpf_iter_path_kern *kit = (void *)it;
> +	struct path root = {};

I think this also warrants a comment. Specifically, that unless the
loop is explicitly terminated, bpf_iter_path_next() will continue
looping until we've reached the global root of the VFS.

> +	if (!path_walk_parent(&kit->path, &root))
> +		return NULL;
> +	return &kit->path;
> +}
> +
> +__bpf_kfunc void bpf_iter_path_destroy(struct bpf_iter_path *it)
> +{
> +	struct bpf_iter_path_kern *kit = (void *)it;
> +
> +	path_put(&kit->path);
> +}
> +
> +__bpf_kfunc_end_defs();
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a7d6e0c5928b..45b45cdfb223 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7036,6 +7036,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
>  	struct sock *sk;
>  };
>  
> +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path) {
> +	struct dentry *dentry;
> +};

Only trusted if struct path is trusted, and hence why KF_TRUSTED_ARGS
should be enforced. 

>  static bool type_is_rcu(struct bpf_verifier_env *env,
>  			struct bpf_reg_state *reg,
>  			const char *field_name, u32 btf_id)
> @@ -7076,6 +7080,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
>  				    const char *field_name, u32 btf_id)
>  {
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path));
>  
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
>  					  "__safe_trusted_or_null");
> -- 
> 2.47.1
> 

