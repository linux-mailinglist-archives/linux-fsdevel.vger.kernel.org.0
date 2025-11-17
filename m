Return-Path: <linux-fsdevel+bounces-68624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4BDC622A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 03:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BB804E77C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 02:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4A1258EC1;
	Mon, 17 Nov 2025 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bQLyaVBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781FA22FE11;
	Mon, 17 Nov 2025 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348049; cv=none; b=WNzpVsGaj4CbUTyK4MFoQN6rw/7wAA8CWNjyHZXf9vgVUNoQZIMdmwnVQqb/XeZC27IKEI50Do17dVYiponOoQ+EZp/5jnoV9AhD7kXQS8A7OUq5ZcRZl+gBqFJ62MXGPUU6mUkgsvPV3RhATYsaSYARJsV/FNj10Q+M8w97Bk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348049; c=relaxed/simple;
	bh=gT/Jws3TUOkv78ezuhBECn5hn2F6V7xxYmqRwPANJYE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BalYQpneS6/D+CRkW2RbmPCPsAcHOl5A7kYmhhzjugOf7PFQmw6e3YrnyIW7wZ01gxE88H4XImXG67IONWAz1/jFICGPQ1idDEsIKGjMG3KL4K3insfTLof0hNTGX5hNXHIJYUq2ptX7ASzpTu2fnph5et57aSfNKT5KNUrdoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bQLyaVBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54D8C116D0;
	Mon, 17 Nov 2025 02:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763348048;
	bh=gT/Jws3TUOkv78ezuhBECn5hn2F6V7xxYmqRwPANJYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bQLyaVBdbyyM0oXtWKIvXOqoUHpgxlgK76A/wKmfxsmbwJ8Q8MJDoTghEtIMGocF8
	 Evr+ry6/+JjQBdutYhbOJrfavqGhrLBedJ7368KUCce+O982gvu3WJH3U9itu8l0qj
	 ayUgSBpevbPlBYCVx+7S9qMk6srbxSOGxd+WdmWA=
Date: Sun, 16 Nov 2025 18:54:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
 rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
 masahiroy@kernel.org, tj@kernel.org, yoann.congal@smile.fr,
 mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
 axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
 vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com,
 david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org,
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
 linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, ajayachandra@nvidia.com,
 jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com,
 hughd@google.com, skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v6 01/20] liveupdate: luo_core: luo_ioctl: Live Update
 Orchestrator
Message-Id: <20251116185406.0fb85a3c52c16c91af1a0c80@linux-foundation.org>
In-Reply-To: <20251115233409.768044-2-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
	<20251115233409.768044-2-pasha.tatashin@soleen.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Nov 2025 18:33:47 -0500 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> Introduce LUO, a mechanism intended to facilitate kernel updates while
> keeping designated devices operational across the transition (e.g., via
> kexec). 

Thanks, I updated mm.git's mm-unstable branch to this version.  I
expect at least one more version as a result of feedback for this v6.

I wasn't able to reproduce Stephen's build error
(https://lkml.kernel.org/r/20251117093614.1490d048@canb.auug.org.au)
with this series.


