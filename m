Return-Path: <linux-fsdevel+bounces-56274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F2B153FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 21:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E2F545B2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 19:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A12517A5;
	Tue, 29 Jul 2025 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D8IHiYMq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="84VB96h0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347581F956;
	Tue, 29 Jul 2025 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818831; cv=none; b=Ax0vJoX91S9JVHyh+eC49Ym6hvHpAr+tAb+2v+Mhnsi6kYI0of6rKXg+5P9jyhSbFBIlXUcFp16+M1PQe0w/3jUJ8gxk/EORgBFL4GlZ8pBg33BrJPP5PiR/P8M9Qizc8wxwoZF/IJYv6g2Y/Ck4VxRAv/n1VWgPPtPI581rZTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818831; c=relaxed/simple;
	bh=bs5ZmR9gdo5u9zpoZMe1nXXpT82NUDIPQwiGKz+lOv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y9a+LwTaur8S4Gqf5akNFgIrZFEfnFY+cpeegcGq2GXN0R4K/bGsdonQdcGdgqClVoJW29kKBhzw4KC5F+2sYrexMTiXQdBHim45iPgz8//Bt3eqkGYpC3WbstTIOduEERMAOwPC/XeWIbdNqXXuLsyRbeBJmjX3DwxrnhAqzmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D8IHiYMq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=84VB96h0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753818828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=murAsIGdQ6vlzwol4uFiktJ1U9ZUZDAn3df7ASsCmD8=;
	b=D8IHiYMqln69olqi/6g6npXcLQVV9NhOPq9simOGPAORx1WCUp6Y9LvMbouMOkAxzIGru5
	fzYmP78u1FWNs+tGfnQ5hVdCKKPy0IPZZDgIaQmQOhclLThxjS/nD7K2CRHRKoVs4t3viY
	Q3hAdwKxD55M6PZgz8UY9xequNcgThPVkshUggBZwEq+omEWc/UjPuE3BOVgDhqoncku3A
	Swf2RktBL3Y1jCSYd3heJ8dSP3bMTCYP4ijlJ5wiRKsusEYa/Qb8NSnMnfIefKUhjY1GFT
	clXl/VuN7sODouU3zY35RaW02sJK3BMssK0iJMoHu4f272V8b8fzG5IflB/zNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753818828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=murAsIGdQ6vlzwol4uFiktJ1U9ZUZDAn3df7ASsCmD8=;
	b=84VB96h0nopNOInx6f3954BclIbhdj2VAKaaaPvyAxSCFL2P4Z8AoTongAesBct1K6fmYv
	UacHzAa4keOqZWBw==
To: Jason Gunthorpe <jgg@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
 changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
 rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
 ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org,
 aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org,
 tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com,
 roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk,
 mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org,
 hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com,
 joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com,
 song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, gregkh@linuxfoundation.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org,
 cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com,
 Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
 aleksander.lobakin@intel.com, ira.weiny@intel.com,
 andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
 bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
 stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
 brauner@kernel.org, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, ajayachandra@nvidia.com,
 parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v2 31/32] libluo: introduce luoctl
In-Reply-To: <20250729161450.GM36037@nvidia.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-32-pasha.tatashin@soleen.com>
 <20250729161450.GM36037@nvidia.com>
Date: Tue, 29 Jul 2025 21:53:47 +0200
Message-ID: <877bzqkc38.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 29 2025 at 13:14, Jason Gunthorpe wrote:
> On Wed, Jul 23, 2025 at 02:46:44PM +0000, Pasha Tatashin wrote:
>> From: Pratyush Yadav <ptyadav@amazon.de>
>>  tools/lib/luo/Makefile       |   6 +-
>>  tools/lib/luo/cli/.gitignore |   1 +
>>  tools/lib/luo/cli/Makefile   |  18 ++++
>>  tools/lib/luo/cli/luoctl.c   | 178 +++++++++++++++++++++++++++++++++++
>>  4 files changed, 202 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/lib/luo/cli/.gitignore
>>  create mode 100644 tools/lib/luo/cli/Makefile
>>  create mode 100644 tools/lib/luo/cli/luoctl.c
>
> In the calls I thought the plan had changed to put libluo in its own
> repository?
>
> There is nothing tightly linked to the kernel here, I think it would
> be easier on everyone to not add ordinary libraries to the kernel
> tree.

As this is an evolving mechanism, having the corresponding library in
the kernel similar to what we do with perf and other things makes a lot
of sense.

Thanks,

        tglx

