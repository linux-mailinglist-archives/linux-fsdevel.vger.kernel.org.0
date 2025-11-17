Return-Path: <linux-fsdevel+bounces-68712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B09CC63C72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 12:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9EB3AF797
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565532938E;
	Mon, 17 Nov 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+36XpUk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E641287507;
	Mon, 17 Nov 2025 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763378056; cv=none; b=eBCrs9sCdLhhVIeNZqDHnb7PzdMVwbzIYI5KihpnERuYMR4V/FVR66n8WxhWjO+ji80L9MovWxg7qLn7KkfGz/nYgpuvrXogYcL24Wkq6OecPY3k/OIqCU2K19gAqmlakXSYH3JUe2kwciYPMmwdH33zN9hMp1aG4BRDRZoJ7DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763378056; c=relaxed/simple;
	bh=a+Glbj+KjklqVqK02cJKv38+Iv5JmdqR17E30pDPyGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAKtdgyDO3u1c/6arkmnzfNBC2beP3HdiSTz+QEqTnl1U26DyqeQVlyPj3KjlNe7OHEM/fVX4L3aike9hdZV5jlpKJUKIbjDHYhKGhBXsMYy4ddGYMTtxZi/xpt98eTChcRvmjgLa3rEBp3sqS0K5ES+xB6T04QERaQZenzs/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+36XpUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A25C4CEF5;
	Mon, 17 Nov 2025 11:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763378055;
	bh=a+Glbj+KjklqVqK02cJKv38+Iv5JmdqR17E30pDPyGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+36XpUkgooOOplYjFcXSlkiRz9QJ9mw3TH5MHjiR6eSeLeykbimRz9eODBPmYD4f
	 Ej5+lc/S0OkUv84FBV83fgl+AKDrJNl+kGSPHK549sQ8fWypqZkB4JnN2UYUeJDApu
	 7qry8j+l66Ji7mT8iOgQWAU2FD9W+xkoybuLpEhH/qyA0gfSxOzw7azcWlz9JWNXTP
	 64UKmeUlQIpxjTIydSTLHMsFBE8EQUgngt5ecZ0+6dOCpxMKxShHCRMDZ3UQICc2Vb
	 xy5Os9Jr0mPExUf8Ubchkkc3k4+8GbI0RUjVMScWeibdxclYKM23yJpGreGXsCilWw
	 XrlAzdRBdVg7w==
Date: Mon, 17 Nov 2025 13:13:51 +0200
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
Subject: Re: [PATCH v6 20/20] tests/liveupdate: Add in-kernel liveupdate test
Message-ID: <aRsDb-4bXFQ9Zmtu@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-21-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-21-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:34:06PM -0500, Pasha Tatashin wrote:
> Introduce an in-kernel test module to validate the core logic of the
> Live Update Orchestrator's File-Lifecycle-Bound feature. This
> provides a low-level, controlled environment to test FLB registration
> and callback invocation without requiring userspace interaction or
> actual kexec reboots.
> 
> The test is enabled by the CONFIG_LIVEUPDATE_TEST Kconfig option.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/liveupdate/abi/luo.h |   5 +
>  kernel/liveupdate/luo_file.c       |   2 +
>  kernel/liveupdate/luo_internal.h   |   6 ++
>  lib/Kconfig.debug                  |  23 +++++
>  lib/tests/Makefile                 |   1 +
>  lib/tests/liveupdate.c             | 143 +++++++++++++++++++++++++++++
>  6 files changed, 180 insertions(+)
>  create mode 100644 lib/tests/liveupdate.c
> 
> diff --git a/include/linux/liveupdate/abi/luo.h b/include/linux/liveupdate/abi/luo.h
> index 85596ce68c16..cdcace9b48f5 100644
> --- a/include/linux/liveupdate/abi/luo.h
> +++ b/include/linux/liveupdate/abi/luo.h
> @@ -230,4 +230,9 @@ struct luo_flb_ser {
>  	u64 count;
>  } __packed;
>  
> +/* Kernel Live Update Test ABI */
> +#ifdef CONFIG_LIVEUPDATE_TEST
> +#define LIVEUPDATE_TEST_FLB_COMPATIBLE(i)	"liveupdate-test-flb-v" #i
> +#endif
> +
>  #endif /* _LINUX_LIVEUPDATE_ABI_LUO_H */
> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index df337c9c4f21..9a531096bdb5 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -834,6 +834,8 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
>  	INIT_LIST_HEAD(&fh->flb_list);
>  	list_add_tail(&fh->list, &luo_file_handler_list);
>  
> +	liveupdate_test_register(fh);
> +

Why this cannot be called from the test?

>  	return 0;
>  }
>  

-- 
Sincerely yours,
Mike.

