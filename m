Return-Path: <linux-fsdevel+bounces-56129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11744B138D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 12:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9219189007E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D1425C818;
	Mon, 28 Jul 2025 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY7dVkWs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72801FBE9B;
	Mon, 28 Jul 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697931; cv=none; b=NaTmNGLETJuJd10CIUPN2pm80uN4ai5jytH+YWoCg0vUvyZCJAS0WCUq7a9e3GLgyz2kHQ7F3OBYIEYB/NhcoK2T5i3mFvbGFQ5wNNddZSCGCfk67PRjORlATo6tSEWbX8w0lNpuevuPa7ujibo8NOsH3OCQg08xMEmDP8pKUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697931; c=relaxed/simple;
	bh=zVzQvvAddDP62V30se1D6wE63TQYVFTDCsf+N1N3pAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb7TFZIvncNQ5VLSU5puvt2AqyzAxmF0axBiKsJDrchDo6PtWx3fOuRMxPUcT3HrQa95WDDHvTT1L+/D5XBwIF/2C39aj58moUqFRKyn5d06Q9jIBasejQDaouPZkJ8Sjy7+xI/leJQXXiA2KV82CnsKrOQXoGGZBcOCxrKxo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY7dVkWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE45C4CEE7;
	Mon, 28 Jul 2025 10:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753697931;
	bh=zVzQvvAddDP62V30se1D6wE63TQYVFTDCsf+N1N3pAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lY7dVkWskMdiX3zYFhlvt9M8GbNXRdktQ2KO1GeMS8CxBSPoF3g3EyYYvZVi6rVHn
	 o24oG5gpVcPqmMef98a/MgQ7qfHb9O2lAwY+Det1Cv+jj0aCXwcFUogaoLgG/VxNwl
	 8GacG1Xsi1gGQVxTNHktfwVqRtSsaAP9ZGzDci13IP2NgzNOkFXfRYU+JVOb2YQ76O
	 6ZCvA+4ywB4DSKZT0GpFpjW8KEJFh0fvX8kLV6EnwuLF7kdYUG5TW/r73ln5bZ67Zi
	 4USeNV6riBWSQW1Q2tdOvlC7Rs0tfw2ZI3I4vmpaL904qlqD0mCpTwo/vb98XKR5c/
	 0dtySijehknDQ==
Date: Mon, 28 Jul 2025 13:18:26 +0300
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
Subject: Re: [PATCH v2 04/32] kho: allow to drive kho from within kernel
Message-ID: <aIdOcmTl-zrxXKAB@kernel.org>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-5-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723144649.1696299-5-pasha.tatashin@soleen.com>

On Wed, Jul 23, 2025 at 02:46:17PM +0000, Pasha Tatashin wrote:
> Allow to do finalize and abort from kernel modules, so LUO could
> drive the KHO sequence via its own state machine.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/kexec_handover.h | 15 +++++++++
>  kernel/kexec_handover.c        | 58 ++++++++++++++++++++++++++++++++--
>  2 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h

...

> -static int kho_finalize(void)
> +int kho_abort(void)
> +{
> +	int ret = 0;
> +
> +	if (!kho_enable)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&kho_out.lock);
> +
> +	if (!kho_out.finalized) {
> +		ret = -ENOENT;
> +		goto unlock;
> +	}
> +
> +	ret = __kho_abort();
> +	if (ret)
> +		goto unlock;
> +
> +	kho_out.finalized = false;
> +	ret = kho_out_update_debugfs_fdt();
> +
> +unlock:
> +	mutex_unlock(&kho_out.lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kho_abort);

I don't think a module should be able to drive KHO. Please drop
EXPORT_SYMBOL_GPL here and for kho_finalize().

-- 
Sincerely yours,
Mike.

