Return-Path: <linux-fsdevel+bounces-67684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014D1C46BC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 14:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C785D188408C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68EF1F63F9;
	Mon, 10 Nov 2025 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBsr08XW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1742AD1F;
	Mon, 10 Nov 2025 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779685; cv=none; b=pO3cF+iYaX0maUOslt9CTfOI4w1YfYink91GWkOcN9TLopy/Do5obuSLlT0R6yYFopzAIrsex2pTse+xyKW8v/bq04ZKvWA+ksPmlYlyVDpZ0zlu4vaSJ5a5TDAdEGrkGbhrCwlZlwuzblDVB3ckN5xKqqD6TkXRuW6Oal65rRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779685; c=relaxed/simple;
	bh=Nty6eYvSZQwOVNMjVt6MpJ2VRDmLEsf0ItJ+R2b2b5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs1/VGu0SoHQxbNwbHcb3T890+grdELpeRqIoXmrVVJ94hNYk53lHZvpqCmyCewzdGXBxlSX6OjnrWRfcns3oDFWU7R2gdtqsFKVf2sqJVXyFTNg+6pigG1T3+l870GOJ1KrZ+0fvbTJSaiZyc1DcidVQyyBsS1hnThnf1VKwT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBsr08XW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC7FC4CEFB;
	Mon, 10 Nov 2025 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762779684;
	bh=Nty6eYvSZQwOVNMjVt6MpJ2VRDmLEsf0ItJ+R2b2b5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBsr08XWCoMFNAwbMOQ0qNvF4Su6puJFwAVVqSGXeT6zPs3x84rtXd1S+NejmtuJx
	 xZdr6ygbytRvjLLjSuil0yB1/WF1G2479mk8z0dDg11Wyp55cwJsF7pGl0DehEuhcZ
	 WVy01lGJQu0UrlJOlsnE40nEMhyV2hN0PmRaLfMiIYzXqz837/kxUFMsbhOvrkv7iE
	 unZy1naPkELeU5A3OWaTwOd54LEYSQj6e5v0JRS4ibLAAqLFQM73hnr4rGzDzaRVCZ
	 6L8e3xlbp4/r2UWtdNwmuPzalQnsl2O8+BHfUBH3qZdlIJoyclPpp5lAfF79lgxG3M
	 MXR0rv+rTTjZA==
Date: Mon, 10 Nov 2025 15:00:59 +0200
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
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
Message-ID: <aRHiCxoJnEGmj17q@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107210526.257742-3-pasha.tatashin@soleen.com>

On Fri, Nov 07, 2025 at 04:03:00PM -0500, Pasha Tatashin wrote:
> Integrate the LUO with the KHO framework to enable passing LUO state
> across a kexec reboot.
> 
> When LUO is transitioned to a "prepared" state, it tells KHO to
> finalize, so all memory segments that were added to KHO preservation
> list are getting preserved. After "Prepared" state no new segments
> can be preserved. If LUO is canceled, it also tells KHO to cancel the
> serialization, and therefore, later LUO can go back into the prepared
> state.
> 
> This patch introduces the following changes:
> - During the KHO finalization phase allocate FDT blob.
> - Populate this FDT with a LUO compatibility string ("luo-v1").
> 
> LUO now depends on `CONFIG_KEXEC_HANDOVER`. The core state transition
> logic (`luo_do_*_calls`) remains unimplemented in this patch.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---

...

> @@ -69,7 +197,22 @@ early_param("liveupdate", early_liveupdate_param);
>   */
>  int liveupdate_reboot(void)
>  {
> -	return 0;
> +	int err;
> +
> +	if (!liveupdate_enabled())
> +		return 0;
> +
> +	err = kho_finalize();

kho_finalize() should be really called from kernel_kexec().

We avoided it because of the concern that memory allocations that late in
reboot could be an issue. But I looked at hibernate() and it does
allocations on reboot->hibernate path, so adding kho_finalize() as the
first step of kernel_kexec() seems fine.

And if we prioritize stateless memory tracking in KHO, it won't be a
concern at all.

> +	if (err) {
> +		pr_err("kho_finalize failed %d\n", err);
> +		/*
> +		 * kho_finalize() may return libfdt errors, to aboid passing to
> +		 * userspace unknown errors, change this to EAGAIN.
> +		 */
> +		err = -EAGAIN;
> +	}
> +
> +	return err;
>  }
>  
>  /**

-- 
Sincerely yours,
Mike.

