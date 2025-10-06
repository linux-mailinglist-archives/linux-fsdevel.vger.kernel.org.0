Return-Path: <linux-fsdevel+bounces-63506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3107BBEA64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 18:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A72A24F017A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261A721CFEF;
	Mon,  6 Oct 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmOzWz2S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F8F20E03F;
	Mon,  6 Oct 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768260; cv=none; b=SJQZUhTWurYpz/Qi6lDJqGPaOcHxAB3KxwqINd6pCaLQQCMKl8nwYvPAaoQsdfdgh0zqCjWWia83ooO1PkCesWw0tcB2LTCMvz35Mq0SOGrzNINLTNR3vqDPDPCeybvxhNdHOmQVPURP4fOJmz/YQ/6IEUzx/3igt5zotxMfR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768260; c=relaxed/simple;
	bh=yD0PjDQlf46RiJVrF/Aszb7CVdshcKm/wDonN3zBFKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZTCZEr4tI5O6zdHJ5SJ4+BOF4b1RpGl5I/muHuePIMINQkg2ZedXLM1pSa9T+W4OAqNiU/OU6Lu8QH/FDzAW7Tt2zQ5Kt4vKMEqdWYnBjE+8mxmUBnxG3+HgkEIpwoURqFUlGrcJkjg95Klu2hdTP9crJfpF21ZebrDiAa5W4UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmOzWz2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E435C4CEF5;
	Mon,  6 Oct 2025 16:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759768260;
	bh=yD0PjDQlf46RiJVrF/Aszb7CVdshcKm/wDonN3zBFKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nmOzWz2SnthepQu0FPGRBR+aVkqF9ApmQ+zx91kTdSjpax06w+O1ocikxZUxhTvEl
	 BkiQ/OdKVfDKPNQf3b8Cv0Vuv74aRdbYVmxzDhgVhHTLZyqhQenmnJj1HZ5JZctahT
	 j3vRK2ho7EZrufPIHz0BSk+yB3W5zeHAxAMPQ9ODza2WiQAMGpi87FP23eg3+eWSU7
	 xAwJMgbFq6blAZze7hA6lAChs0wcA40LSeN6YRe/c6r6npA76+nE84OWCU3cHivFdm
	 /LXzBroGswAo/PYUtcx8R9abLLGBwJ9guZ+FWOq2tKSpMydDSnFGR03gTDNMfHe2Sb
	 TGHeqGQZhy+0A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  changyuanl@google.com,  rppt@kernel.org,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
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
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org,
  steven.sistare@oracle.com
Subject: Re: [PATCH v4 02/30] kho: make debugfs interface optional
In-Reply-To: <20250929010321.3462457-3-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Mon, 29 Sep 2025 01:02:53 +0000")
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
	<20250929010321.3462457-3-pasha.tatashin@soleen.com>
Date: Mon, 06 Oct 2025 18:30:49 +0200
Message-ID: <mafs07bx8ouva.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 29 2025, Pasha Tatashin wrote:

> Currently, KHO is controlled via debugfs interface, but once LUO is
> introduced, it can control KHO, and the debug interface becomes
> optional.
>
> Add a separate config CONFIG_KEXEC_HANDOVER_DEBUG that enables
> the debugfs interface, and allows to inspect the tree.
>
> Move all debugfs related code to a new file to keep the .c files
> clear of ifdefs.
>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  MAINTAINERS                      |   3 +-
>  kernel/Kconfig.kexec             |  10 ++
>  kernel/Makefile                  |   1 +
>  kernel/kexec_handover.c          | 255 +++++--------------------------
>  kernel/kexec_handover_debug.c    | 218 ++++++++++++++++++++++++++
>  kernel/kexec_handover_internal.h |  44 ++++++
>  6 files changed, 311 insertions(+), 220 deletions(-)
>  create mode 100644 kernel/kexec_handover_debug.c
>  create mode 100644 kernel/kexec_handover_internal.h
>
[...]
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -109,6 +109,16 @@ config KEXEC_HANDOVER
>  	  to keep data or state alive across the kexec. For this to work,
>  	  both source and target kernels need to have this option enabled.
>  
> +config KEXEC_HANDOVER_DEBUG

Nit: can we call it KEXEC_HANDOVER_DEBUGFS instead? I think we would
like to add a KEXEC_HANDOVER_DEBUG at some point to control debug
asserts for KHO, and the naming would get confusing. And renaming config
symbols is kind of a pain.

> +	bool "kexec handover debug interface"
> +	depends on KEXEC_HANDOVER
> +	depends on DEBUG_FS
> +	help
> +	  Allow to control kexec handover device tree via debugfs
> +	  interface, i.e. finalize the state or aborting the finalization.
> +	  Also, enables inspecting the KHO fdt trees with the debugfs binary
> +	  blobs.
> +
[...]

-- 
Regards,
Pratyush Yadav

