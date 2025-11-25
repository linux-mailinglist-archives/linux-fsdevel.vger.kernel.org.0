Return-Path: <linux-fsdevel+bounces-69833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6F3C86B53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 19:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 031CE3531BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37B033343A;
	Tue, 25 Nov 2025 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8QqTVwO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2318BBAE;
	Tue, 25 Nov 2025 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764096844; cv=none; b=ZIY5oS7b4KWWIpTV1ZvQI+Iyt2a40G1C5A69OUkWhmCCMsx2HpFShxzWC8lMn+GEOM9K3d4ZkMai0OFZ3OCAd3OrEQTNJiJ+B7cpqMTBmQ10ywZbrCTE5V5FLxPq7w5j6Pqfz8jFExNR7fmgpuHlAqSCgQykyKgvPaP5gLMQf38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764096844; c=relaxed/simple;
	bh=tj4Hk2zVRIwQCQP87xu4QTgjORr+xv2c2i4X2tAStZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpQoBZOnhvsp4Z+RLLNy34Tj13Hwyw8UbwQiNJmc9XxKuSaJCMAEqRiiRbqrX5lp//9XBFc7Krbm7QKWh9tw7uU1ze4BUrclWVN8uuo+Rtm6T0SmZIft34ymOm7TY7q/eepGP0aZ/rGGQD2eMiHZ+3kemHFLO1QZ2DTU0a8Iqg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8QqTVwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B3BC4CEF1;
	Tue, 25 Nov 2025 18:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764096843;
	bh=tj4Hk2zVRIwQCQP87xu4QTgjORr+xv2c2i4X2tAStZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H8QqTVwO+aRD63VeZ+7GlQZSXgdn0PXGxn5Hccx6EFhuUK4/IY7RA8zubinfNvfhG
	 ohdpylQnNuvcrKhq3XKX63n7Rkf3tA4+JYyXIypNkm6s/c1bjka/WazLOex514dALB
	 271Er0PoDjcGo2IGKc+1//GwxeZobK2FyBqBCrM+uX7CWaSPKELthJcEBDRn/L3/fB
	 9ZyklW1576lnBqIsb5nkaTc0AATx2Qn1zpm/soahOCU7j3fueeVCVLLSYU8815MK/7
	 BcgVdvhW39fBJc0JzVyOJyl1sm0e66Gx71YE8VunUW/1DLkdz3N8U1Ia+NUUG+Mr7N
	 4GBt6dlbi3Jww==
Date: Tue, 25 Nov 2025 20:53:42 +0200
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
Subject: Re: [PATCH v8 02/18] liveupdate: luo_core: integrate with KHO
Message-ID: <aSX7Nm_yrXHeejQU@kernel.org>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
 <20251125165850.3389713-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125165850.3389713-3-pasha.tatashin@soleen.com>

On Tue, Nov 25, 2025 at 11:58:32AM -0500, Pasha Tatashin wrote:
> Integrate the LUO with the KHO framework to enable passing LUO state
> across a kexec reboot.
> 
> This patch implements the lifecycle integration with KHO:
> 
> 1. Incoming State: During early boot (`early_initcall`), LUO checks if
>    KHO is active. If so, it retrieves the "LUO" subtree, verifies the
>    "luo-v1" compatibility string, and reads the `liveupdate-number` to
>    track the update count.
> 
> 2. Outgoing State: During late initialization (`late_initcall`), LUO
>    allocates a new FDT for the next kernel, populates it with the basic
>    header (compatible string and incremented update number), and
>    registers it with KHO (`kho_add_subtree`).
> 
> 3. Finalization: The `liveupdate_reboot()` notifier is updated to invoke
>    `kho_finalize()`. This ensures that all memory segments marked for
>    preservation are properly serialized before the kexec jump.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/kho/abi/luo.h      |  58 ++++++++++++
>  kernel/liveupdate/luo_core.c     | 154 ++++++++++++++++++++++++++++++-
>  kernel/liveupdate/luo_internal.h |  22 +++++
>  3 files changed, 233 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/kho/abi/luo.h
>  create mode 100644 kernel/liveupdate/luo_internal.h

-- 
Sincerely yours,
Mike.

