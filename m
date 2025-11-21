Return-Path: <linux-fsdevel+bounces-69381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFDAC7AAFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 16:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B86AE349460
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 15:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AA43491D0;
	Fri, 21 Nov 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WES5sOMj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B72D7388;
	Fri, 21 Nov 2025 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740550; cv=none; b=GMHJaItxB8RdYTSNc4f257AUn4iAeHeEUeRYCyocrRCtSZ3zspzULG350KzMwKeqxHP3X3UP6A9oSdxZA5R1myXoJ+w0759N2TBBCNbG9xNwPBfKJoiA/RTb5FHfk6gS/eZK3qtk3NmAh3gmN4jfK7coGIWLNGy/Lwrus1JKUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740550; c=relaxed/simple;
	bh=8K8v4Fqc1uPGUBC8powdKMrR3iKxfMCptCFO6IAuuh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wl6Kjm5skMl2WSIfnjlGhj+NexQdpMan5u3VoL/BZQ2h603A1UmKMYEDtMFfC6znmIqWck+7tuqzSBq5XZnywGwTGkPlQj+D2ZC0Dok36xsoaTDaKjh2VZFTS4IGx/L88DwWQ9ho1/FbC6H+PFkY6IWKslRiyxNT/V856Orkxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WES5sOMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F28C4CEF1;
	Fri, 21 Nov 2025 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763740550;
	bh=8K8v4Fqc1uPGUBC8powdKMrR3iKxfMCptCFO6IAuuh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WES5sOMjmeBJGZu3nYtoQyB/m5dAzcI1PJuJTRFO/cQh1YV4bi5dSqlMG49+TkMWQ
	 6FvKh4HBeQE3QxPBe5mw/rXyTiMb3cVq7HGL63h/lRTHjmv8SuCYviUw5oMCb5qq5E
	 0E+wJACBqr/CzkdoUnErDHRT7Tg4hrVh03tbKuHi/Ql3dNMLlcIxoTjn6q0NSEuDTm
	 oiaf2kQYhlZXogOQGlGhRolF+d4xYE4eZ7588U0oURn5bcn7SCd1bicigyv4ENdImD
	 iyiZ315qFHzYMbuvr986pS9db9FLhsPyPXvC0M+qREcI1bRi7VidVVZlhHaHpiNXVM
	 69dMJFY0/3BTw==
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
Subject: Re: [PATCH v6 03/20] kexec: call liveupdate_reboot() before kexec
In-Reply-To: <20251115233409.768044-4-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 15 Nov 2025 18:33:49 -0500")
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
	<20251115233409.768044-4-pasha.tatashin@soleen.com>
Date: Fri, 21 Nov 2025 16:55:39 +0100
Message-ID: <mafs0cy5b1itg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 15 2025, Pasha Tatashin wrote:

> Modify the kernel_kexec() to call liveupdate_reboot().
>
> This ensures that the Live Update Orchestrator is notified just
> before the kernel executes the kexec jump. The liveupdate_reboot()
> function triggers the final freeze event, allowing participating
> FDs perform last-minute check or state saving within the blackout
> window.
>
> If liveupdate_reboot() returns an error (indicating a failure during
> LUO finalization), the kexec operation is aborted to prevent proceeding
> with an inconsistent state. An error is returned to user.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

