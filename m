Return-Path: <linux-fsdevel+bounces-69384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 819FCC7AEEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 17:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B71C64EC5BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 16:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444122F0C69;
	Fri, 21 Nov 2025 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBw8L3QS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B32ED85D;
	Fri, 21 Nov 2025 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743530; cv=none; b=oVGVw0Yae/ID81uv1zcilMvrsVDYckoCrax1ch+25I9+gXTBKhvZg1FB6nTAXTd07oBPkEU7zvuaALDEoE9JQkqdqD2kSxKLINhTFPTn0+1hXmC9GqK8mOmmSvk8M+TT+h4+am7m9whmhjmj9LLcfjL18yn77O2WxBFTxNXaj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743530; c=relaxed/simple;
	bh=uKqlbpbWZRrKvI6snBLWA76JEhH3myl0WqefytuKsNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mhp+tlN4S9j5U/QQDKVkq47r4bjX+RlqOFCj4yg96vCcSQ2/Bgryc8yvQhXP8T+qXYodbrer7xeE0DX4fMUqg5nTxJfdlSB8huE5SeCHJ72R4REc2S9mKwCkHReSRdxSrMaZmSdwS5rUVVLsZ1J6T/snbqoNU+eMM+zVnTRHU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBw8L3QS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65F5C4CEF1;
	Fri, 21 Nov 2025 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763743530;
	bh=uKqlbpbWZRrKvI6snBLWA76JEhH3myl0WqefytuKsNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IBw8L3QSRDawIjSxvYdXP68CTt2ce590ZJcwdoZ2Jijz94Ey+jenn+VooM+tMuzu/
	 7OY/Y7/5mFacc9/raDz5D79GRf94kp4F6GGYHzpSCYsv8yU/pXMVEpNmSQ3dubQQns
	 KJdkJP793gTvJ2KdaXNFKVqn2+gL6lyH5xwCh62A51RWLBz3cdk2trhxyizwkcadmF
	 Ulfe9QhNq7K5YhvlwxVwWUctlUnulpiW1hGfgU1Ff1oTa+etifkU80qyZrYhttWcL/
	 VdDiv06qRZpeFblFV7JecQ44oJ1WIOkZ6IIs+LNwh+K7PYn1nDy7fpSPj1+FKo+oaw
	 3j6rWfC6PXb4g==
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
Subject: Re: [PATCH v6 05/20] liveupdate: luo_ioctl: add user interface
In-Reply-To: <20251115233409.768044-6-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 15 Nov 2025 18:33:51 -0500")
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
	<20251115233409.768044-6-pasha.tatashin@soleen.com>
Date: Fri, 21 Nov 2025 17:45:19 +0100
Message-ID: <mafs01plr1gio.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 15 2025, Pasha Tatashin wrote:

> Introduce the user-space interface for the Live Update Orchestrator
> via ioctl commands, enabling external control over the live update
> process and management of preserved resources.
>
> The idea is that there is going to be a single userspace agent driving
> the live update, therefore, only a single process can ever hold this
> device opened at a time.
>
> The following ioctl commands are introduced:
>
> LIVEUPDATE_IOCTL_CREATE_SESSION
> Provides a way for userspace to create a named session for grouping file
> descriptors that need to be preserved. It returns a new file descriptor
> representing the session.
>
> LIVEUPDATE_IOCTL_RETRIEVE_SESSION
> Allows the userspace agent in the new kernel to reclaim a preserved
> session by its name, receiving a new file descriptor to manage the
> restored resources.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

