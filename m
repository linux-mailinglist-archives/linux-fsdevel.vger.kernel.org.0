Return-Path: <linux-fsdevel+bounces-69679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E62C80F9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D03E94E4EFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF80730F53B;
	Mon, 24 Nov 2025 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM8+cPAk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35FB30AAB4;
	Mon, 24 Nov 2025 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994094; cv=none; b=lLKztxZlbVJX7S2rr/U0EBsuZtsUuainmhUccTs6SFMMfbQmeGcJvRk0svIJLZRoyP8oWT1vJdwD8WsdwP2t1IwGpA/N2JYD18ESgq0EzLLInERxdRYPAIDuEJ1yesU0b72noHiZ8cZ33zfv5resyheOWFfKdkwTQAtBvipXcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994094; c=relaxed/simple;
	bh=8J349+aqYU/8MBNS87ks0zT1OFB1tcYyBFGPMvm8Xjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WErYcXHfCuskydMvJIVvZxlLmDS2zMKZ5gQ20Ar2oLHaaPI+ajSBmQWbbdTPfBjXlkXMtqR3bH9DiTvL7KAx+qxIq0MluW2vYok8/yWE7GExBEH5CMX9Sy5aMdIjEy1hVObEyw5hLWAX3W3VuDyrX2aWjXWJEinQfeGh0lKb1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM8+cPAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5459FC4CEF1;
	Mon, 24 Nov 2025 14:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763994093;
	bh=8J349+aqYU/8MBNS87ks0zT1OFB1tcYyBFGPMvm8Xjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KM8+cPAktUopUOxkR02UWCqLycl011KWke1x0XedfVZAK1Mh8Hku572UAnEKLEEts
	 GNF3d7mEFWDSG3b/00eRzormizV3GDXiaEG2zWpYaQrlq6yhfuK/dHJ96EtLq0nTBh
	 xYWTgLkMi/Lgth3dTS72A1BJO9hDEyoIvpR2rFZiqQDuUyl5LaIBfy+ILj6p4INLRl
	 CU6OT8lx+RanesPhsYtm64JkkjU6LAGXQLUb95D5ChSRBnX95AinNsQ3zUMcsyS3Nv
	 a1EdbI30rD7x7xmYn9H1ut+8bOqDqCPTQTmlbteX9u3AcHaiFqXyvIm7FhjFReiHVI
	 uBuRKSoRIDv+g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  linux@weissschuh.net,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-mm@kvack.org,
  gregkh@linuxfoundation.org,  tglx@linutronix.de,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  x86@kernel.org,
  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
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
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org
Subject: Re: [PATCH v7 02/22] liveupdate: luo_core: integrate with KHO
In-Reply-To: <20251122222351.1059049-3-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 22 Nov 2025 17:23:29 -0500")
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
	<20251122222351.1059049-3-pasha.tatashin@soleen.com>
Date: Mon, 24 Nov 2025 15:21:23 +0100
Message-ID: <mafs0ikezzf30.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 22 2025, Pasha Tatashin wrote:

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
> LUO now depends on `CONFIG_KEXEC_HANDOVER`.

Nit: This patch does not add the dependency. That is done by patch 1. I
guess that change needs to be moved here or the comment removed?

Other than this,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

