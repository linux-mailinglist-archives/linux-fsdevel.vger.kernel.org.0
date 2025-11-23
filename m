Return-Path: <linux-fsdevel+bounces-69513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA044C7E1A6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 15:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C693AB4EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4562D5C61;
	Sun, 23 Nov 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnrpq6fX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C735959;
	Sun, 23 Nov 2025 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763907404; cv=none; b=eSDY9v5FE0qUdB2ZXHxCgbhmhRkOx2sXRTY2HBTXKJihGQSmYEUaYpQp4UyPiXhvp5YmiXX8zDH9unkSD5iCkBWrwj8mJ+f++Ce6jrOJ+v8COgIkBos/AMTutwaPC2kUcHiQGIYg66B4OkkWXT9gsYcmij4L3OdhFsjA/tN/wmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763907404; c=relaxed/simple;
	bh=4Xz3KOznAYb3M8bxg5UGBUpO8Ca5J6a4kiLtZ6+lz2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGaFIW0Ei4szcFm5vACpTq6evjsMX/roV1rlauK8FsEAD6rGRU+nlgC7fi4TZ08uwccmHjc9pd0S4Qkrhfrootq6FFz+AeVMLA6z0QLk5OJvM6kg1ADX/qvKdei2kY7AdcmJH5fHQJzb/dN5Zq6Pe2OVft/0amirNfgzw6mgyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnrpq6fX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4957EC113D0;
	Sun, 23 Nov 2025 14:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763907403;
	bh=4Xz3KOznAYb3M8bxg5UGBUpO8Ca5J6a4kiLtZ6+lz2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnrpq6fXUrx9QXPgz+DBX+Qxzr/8ycksAoTg+LwWybP0PSZk4FDpF6DgEmo2LweQ+
	 9WRQNo+wYjPVEW84HwBUh6/j2fQvPZS1eYLtOuhesU/AlAoH9rCpA5u8O7ZN723wzg
	 17RfltwDDU/LSt1+oAQljK15ipIKPcAWW9sSBlmt9LqlYSFx1yvFd5rHpqU6m+GBo0
	 kRAAr9s8jITykV8Yvg2yjJze7/OSoExQCYaiTXAvO2qlXly5L1oNXj6uM0TmXpX4y/
	 z4M0z8J9H5dkjewW9/VPnD4ib9jTFsbBfXNvgGsHvJ+Lk95kBH6wLcxwB4k4R6OfAq
	 dV5bTMLRSo6Gg==
Date: Sun, 23 Nov 2025 16:16:19 +0200
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
Subject: Re: [PATCH v7 04/22] liveupdate: luo_session: add sessions support
Message-ID: <aSMXM8ayzV2kx6Ws@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-5-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122222351.1059049-5-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:31PM -0500, Pasha Tatashin wrote:
> Introduce concept of "Live Update Sessions" within the LUO framework.
> LUO sessions provide a mechanism to group and manage `struct file *`
> instances (representing file descriptors) that need to be preserved
> across a kexec-based live update.
> 
> Each session is identified by a unique name and acts as a container
> for file objects whose state is critical to a userspace workload, such
> as a virtual machine or a high-performance database, aiming to maintain
> their functionality across a kernel transition.
> 
> This groundwork establishes the framework for preserving file-backed
> state across kernel updates, with the actual file data preservation
> mechanisms to be implemented in subsequent patches.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/kho/abi/luo.h      |  71 +++++
>  include/uapi/linux/liveupdate.h  |   3 +
>  kernel/liveupdate/Makefile       |   3 +-
>  kernel/liveupdate/luo_core.c     |   9 +
>  kernel/liveupdate/luo_internal.h |  29 ++
>  kernel/liveupdate/luo_session.c  | 462 +++++++++++++++++++++++++++++++
>  6 files changed, 576 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/liveupdate/luo_session.c
> 

...

> +int __init luo_session_setup_outgoing(void *fdt_out)
> +{
> +	struct luo_session_header_ser *header_ser;
> +	void *outgoing_buffer;
> +	u64 header_ser_pa;
> +	int err;
> +
> +	outgoing_buffer = kho_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);
> +	if (IS_ERR(outgoing_buffer))
> +		return PTR_ERR(header_ser);

Should be 
		return PTR_ERR(outgoing_buffer);

Or, preferably, just drop outgoing_buffer and use header_ser everywhere.

> +	header_ser = outgoing_buffer;
> +	header_ser_pa = virt_to_phys(header_ser);
> +
> +	err = fdt_begin_node(fdt_out, LUO_FDT_SESSION_NODE_NAME);
> +	err |= fdt_property_string(fdt_out, "compatible",
> +				   LUO_FDT_SESSION_COMPATIBLE);
> +	err |= fdt_property(fdt_out, LUO_FDT_SESSION_HEADER, &header_ser_pa,
> +			    sizeof(header_ser_pa));
> +	err |= fdt_end_node(fdt_out);
> +
> +	if (err)
> +		goto err_unpreserve;
> +
> +	luo_session_global.outgoing.header_ser = header_ser;
> +	luo_session_global.outgoing.ser = (void *)(header_ser + 1);
> +	luo_session_global.outgoing.active = true;
> +
> +	return 0;
> +
> +err_unpreserve:
> +	kho_unpreserve_free(header_ser);
> +	return err;
> +}

...

> +int luo_session_deserialize(void)
> +{
> +	struct luo_session_header *sh = &luo_session_global.incoming;
> +	static bool is_deserialized;
> +	static int err;
> +
> +	/* If has been deserialized, always return the same error code */
> +	if (is_deserialized)
> +		return err;

is_deserialized and err are uninitialized here.

> +
> +	is_deserialized = true;
> +	if (!sh->active)
> +		return 0;
> +

...

> +/**
> + * luo_session_quiesce - Ensure no active sessions exist and lock session lists.
> + *
> + * Acquires exclusive write locks on both incoming and outgoing session lists.
> + * It then validates no sessions exist in either list.
> + *
> + * This mechanism is used during file handler un/registration to ensure that no
> + * sessions are currently using the handler, and no new sessions can be created
> + * while un/registration is in progress.

It makes sense to add something like this comment from luo_file.c here as well:

	 * This prevents registering new handlers while sessions are active or
	 * while deserialization is in progress.

> + *
> + * Return:
> + * true  - System is quiescent (0 sessions) and locked.
> + * false - Active sessions exist. The locks are released internally.
> + */

With those addressed:

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>


-- 
Sincerely yours,
Mike.

