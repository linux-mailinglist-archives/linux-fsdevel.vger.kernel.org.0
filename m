Return-Path: <linux-fsdevel+bounces-56128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F272B138AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 12:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D437188C3E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467302472B5;
	Mon, 28 Jul 2025 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9dy97NL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8D1DDF7;
	Mon, 28 Jul 2025 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697748; cv=none; b=Ko5ISEL7JImD5PwQ2i/1sjPC0LRulogvfpbtGH7ZvjQguVYBFGKcaYfMgumBQKMjDKneMNH7o69QgJvTGEdigE4MB3R+APcdisJvPegTiwQKvQba35e7D5vo2h1OmXHtb0MQJJeVGbiTJRT6iGH8swurv3SIUUHBFihuNI3QvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697748; c=relaxed/simple;
	bh=slkf/CEUcS5BKPd4iT/cdxh3rsw6/TCS+iNm0nuYCWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eK2ZsmdJ8MDmgeV9igs032luyluaEsEPALZ8J/jjoDVCmkKKi7M5iaZpOZ4xVFqoh2CcBz9H9T+3BJooth+EcleVRDOgGSp7bkgxry9KP6qEVDme+/yZL0VXePEZ3OElUVtNtmfYzBSPyuoKaFdqC9ZLtIfq0hkc+fkATwQAzq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9dy97NL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C482C4CEE7;
	Mon, 28 Jul 2025 10:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753697748;
	bh=slkf/CEUcS5BKPd4iT/cdxh3rsw6/TCS+iNm0nuYCWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9dy97NLzTbR9r+tVuMA5GsO2jrgJHwsh7giEqcd/Yh32HdUlqywypP0lKq4VY70K
	 dP11ec6+n6Y5aBw1Z3F44dKB5Ds3UV19fAbDLk8LgRMPvrv+Ye69CPdym0ZhoLZRy/
	 +0iBSCBAqszcXRcbusHDs+1PI1KQSGU7lIaONpTgXnqL5f07K9v/Trnr233h50ATFl
	 lkWi2oFUduKtQNNG+p2T8hCvoorjUvd0UeIm3oDZAVabmVWhaUmkVPMIDzQhMhhGfo
	 SYbOj5Y/GCxzCVOMfR+sciBN9ysrdJCHXEiA7HDwrpGbdZ7vkhknVOHs0PACAFM5W/
	 OC69K+1Rmyuag==
Date: Mon, 28 Jul 2025 13:15:23 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
	leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v2 03/32] kho: warn if KHO is disabled due to an error
Message-ID: <aIdNu7wwsbnVGbAN@kernel.org>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-4-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723144649.1696299-4-pasha.tatashin@soleen.com>

On Wed, Jul 23, 2025 at 02:46:16PM +0000, Pasha Tatashin wrote:
> During boot scratch area is allocated based on command line
> parameters or auto calculated. However, scratch area may fail
> to allocate, and in that case KHO is disabled. Currently,
> no warning is printed that KHO is disabled, which makes it
> confusing for the end user to figure out why KHO is not
> available. Add the missing warning message.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/kexec_handover.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 1ff6b242f98c..368e23db0a17 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -565,6 +565,7 @@ static void __init kho_reserve_scratch(void)
>  err_free_scratch_desc:
>  	memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch));
>  err_disable_kho:
> +	pr_warn("Failed to reserve scratch area, disabling kexec handover\n");
>  	kho_enable = false;
>  }
>  
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

-- 
Sincerely yours,
Mike.

