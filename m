Return-Path: <linux-fsdevel+bounces-63508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99271BBEC13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 18:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC2C3ACD9C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0930E2DCF47;
	Mon,  6 Oct 2025 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy3gP9+H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C92D7DC1;
	Mon,  6 Oct 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769719; cv=none; b=Bp2+rvOArG/toX1y15QlGnOyhKFeVbouyCREhKoEmZxc0/Ip4sEp6sHiwHi1f8LolzNyi/yYC9z13kz6sZpEXaDKSIRdWIYiBZndiFDo6mZ+LDuwHW9VLTlRNXQla5rQsIlptGg+dySBEqpoPHeDBrDZWoGG1vZLb6aj0oFgltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769719; c=relaxed/simple;
	bh=bNOBRpWkDT6nydzMvQKW3RR7QOwbofZoWQJVye/UKJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ji2efko0NTP2hsfEaK7sF3HkJjTL4EIwIxv39DPgWKDMY9voY9aZ5V+2Duomuxmk4VL7gHVW667FCzFc7JxdpwWa1K6mrHYZGRBnoPL50DPpQgPZdlOYjx/SDFt8wn4KdCCEn+FlGyRGMuW/ShIn6NO6/R+6XfOh2gnl06RShdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy3gP9+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802ACC4CEF5;
	Mon,  6 Oct 2025 16:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759769718;
	bh=bNOBRpWkDT6nydzMvQKW3RR7QOwbofZoWQJVye/UKJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dy3gP9+Hu4E5xMMiiXrOi1KBJQZnMJOFX+Pw/lPzRsL0eNwziUiawbI2RN3scxHdq
	 WtJQGLnrydwWN9OOe/90A84/2kWEo0S4RiuX4WyzxNemOjxh6of1Wv7pVq0CaWf/EB
	 wi+SmriVpfAZTAO7qSUiuVlh0u6er0wRoTJX5+ocBvXSi9zDVFA790ikivH8XcP0Vy
	 r+zc6grPhvf4IDJJvxb6hsddNYo13M0fB1zfLNvFdMXMRPZ/CaXs0qgP342leLMR4k
	 Vz2vEmfRVbrBiBUwqweVTMGK941+ZHMntFuSxcxOxERuspsdMX2JyW8vD5zXXW3A1T
	 kfnmY1JabGz0w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  changyuanl@google.com,  rppt@kernel.org,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org,
  steven.sistare@oracle.com
Subject: Re: [PATCH v4 02/30] kho: make debugfs interface optional
In-Reply-To: <20250929010321.3462457-3-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Mon, 29 Sep 2025 01:02:53 +0000")
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
	<20250929010321.3462457-3-pasha.tatashin@soleen.com>
Date: Mon, 06 Oct 2025 18:55:08 +0200
Message-ID: <mafs0y0ponf6b.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Pasha,

On Mon, Sep 29 2025, Pasha Tatashin wrote:

> Currently, KHO is controlled via debugfs interface, but once LUO is
> introduced, it can control KHO, and the debug interface becomes
> optional.
>
> Add a separate config CONFIG_KEXEC_HANDOVER_DEBUG that enables
> the debugfs interface, and allows to inspect the tree.
>
> Move all debugfs related code to a new file to keep the .c files
> clear of ifdefs.
>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[...]
> @@ -662,36 +660,24 @@ static void __init kho_reserve_scratch(void)
>  	kho_enable = false;
>  }
>  
> -struct fdt_debugfs {
> -	struct list_head list;
> -	struct debugfs_blob_wrapper wrapper;
> -	struct dentry *file;
> +struct kho_out {
> +	struct blocking_notifier_head chain_head;
> +	struct mutex lock; /* protects KHO FDT finalization */
> +	struct kho_serialization ser;
> +	bool finalized;
> +	struct kho_debugfs dbg;
>  };
>  
> -static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
> -			       const char *name, const void *fdt)
> -{
> -	struct fdt_debugfs *f;
> -	struct dentry *file;
> -
> -	f = kmalloc(sizeof(*f), GFP_KERNEL);
> -	if (!f)
> -		return -ENOMEM;
> -
> -	f->wrapper.data = (void *)fdt;
> -	f->wrapper.size = fdt_totalsize(fdt);
> -
> -	file = debugfs_create_blob(name, 0400, dir, &f->wrapper);
> -	if (IS_ERR(file)) {
> -		kfree(f);
> -		return PTR_ERR(file);
> -	}
> -
> -	f->file = file;
> -	list_add(&f->list, list);
> -
> -	return 0;
> -}
> +static struct kho_out kho_out = {
> +	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
> +	.lock = __MUTEX_INITIALIZER(kho_out.lock),
> +	.ser = {
> +		.track = {
> +			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
> +		},
> +	},
> +	.finalized = false,
> +};

There is already one definition for struct kho_out and a static struct
kho_out early in the file. This is a second declaration and definition.
And I was super confused when I saw patch 3 since it seemed to be making
unrelated changes to this struct (and removing an instance of this,
which should be done in this patch instead). In fact, this patch doesn't
even build due to this problem. I think some patch massaging is needed
to fix this all up.

>  
>  /**
>   * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
[...]

-- 
Regards,
Pratyush Yadav

