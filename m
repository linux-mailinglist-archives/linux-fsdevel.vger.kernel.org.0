Return-Path: <linux-fsdevel+bounces-69832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAC8C86B47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 19:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7B864E7CBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B969333434;
	Tue, 25 Nov 2025 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWZDwEuk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879CA1E1E1E;
	Tue, 25 Nov 2025 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764096710; cv=none; b=BSyQ2Ep9wLnOAy0YqVhXejsNStR4aI8xjyTn4uav4JZcdkJFy9fUKjo/oOVfK348XM0fT/tCThm6MZTcbti1aTQ0wSbEb631fDi02AtO0ZShk3MeSzvm3RNhcXEjV3I7aAWJ2HQoqurrpOPocCubLWbV+uvYErv/0NcW2RjC+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764096710; c=relaxed/simple;
	bh=emoR9CFUIW/AsJT0wVfK21WulXTNtgDxAUtPTxqwPMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWTPZKuTyGoeCt1avMrQRLxcLdAPpw5qndXNLsUTv9bxuhMUeWW6mEtz90OtQZLLwCJNlGyd/d/gH4Vliaw3UuFBgc/wrIdlsFB7rvODU/1vmKFZGUCokO9xiALYoZ/DfvxX4WYOLQ5/wYzXGFjhwskXGtjGPlHrCMNxCrniSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWZDwEuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11841C4CEF1;
	Tue, 25 Nov 2025 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764096710;
	bh=emoR9CFUIW/AsJT0wVfK21WulXTNtgDxAUtPTxqwPMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWZDwEuk2g/afzjQbkRlvylw6VEBejP7+MHtzpvgi1f9gQTmWcqukCgLI52/SxzFA
	 h9uKGWU/GOJeCm/wHg/ouAaLGcMbZn9DyeBJfgqyl1Vl6bYIyA5V3M3fs8o476eiZX
	 uHAbrDuhIDGUPh0Sc0NVNPVlYw+BIxtAX8V39yO0Gx6DWfMmLZUjrU2lQyvWhW/0Ix
	 d/U4nQS43RWpQA+6XUnKS6nuGX3v3Rf1mfMGDiX1h9Ksyktmju1PcYuxrRWHMdug9P
	 HeANy6ZuRfDNUPQF2M0bHPEEtuESSuhbkbkKyv8vMNMaOT9fPGfoTWN7JyaFkCjD4T
	 AfEYrzGeLwi0g==
Date: Tue, 25 Nov 2025 20:51:29 +0200
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
Subject: Re: [PATCH v8 01/18] liveupdate: luo_core: Live Update Orchestrato,
Message-ID: <aSX6sQqwwA6I2mxW@kernel.org>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
 <20251125165850.3389713-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125165850.3389713-2-pasha.tatashin@soleen.com>

On Tue, Nov 25, 2025 at 11:58:31AM -0500, Pasha Tatashin wrote:
> Subject: [PATCH v8 01/18] liveupdate: luo_core: Live Update Orchestrato,

                                                              ^ Orchestrator

> Introduce LUO, a mechanism intended to facilitate kernel updates while
> keeping designated devices operational across the transition (e.g., via
> kexec). The primary use case is updating hypervisors with minimal
> disruption to running virtual machines. For userspace side of hypervisor
> update we have copyless migration. LUO is for updating the kernel.

-- 
Sincerely yours,
Mike.

