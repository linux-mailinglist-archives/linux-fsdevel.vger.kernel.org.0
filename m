Return-Path: <linux-fsdevel+bounces-59209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8414B36255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D31B7BC86A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9023314DF;
	Tue, 26 Aug 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpp3MwAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6431DAC95;
	Tue, 26 Aug 2025 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214192; cv=none; b=P1b7BM4M/lazrcefvn/gzHTfYI33nQPHY9ni1B7it4jtsz/ih8djycOSw90+N1Ss6odDMj39CKjISAS8DRS+kFdX9ibbepdL61iG5QGFCFQX3MzxyR6Zqq3SjdSGYRaB/fs5MNEKKQa50wABvXzgADhZMesI5fFHZ9/xeSb+Yqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214192; c=relaxed/simple;
	bh=tFb+Ondpv3Ccm4cT7YJIvIxpPOa3gBZBu7W+KGbSHs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h4D2HWv6H/3XrFAAkvZ5Wji2EgLk8bVwlZqHqXA7w2yzpJVd/t7KuhXROwvPvdrxF8A7J+sHHHSKkG3M/pzc6Xznx9+HnvDYCcZyM2hA+NWRcE0wWC/62dH+gkCmrR9cdYkY/ZssU4HFUY7tXt8ZjIkPyQoqK6nvPhFI3rC1hKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpp3MwAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E44C4CEF1;
	Tue, 26 Aug 2025 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756214192;
	bh=tFb+Ondpv3Ccm4cT7YJIvIxpPOa3gBZBu7W+KGbSHs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jpp3MwAeRCmcs1UuVWPLSMUBFxGBC6oylqYB3I9Uzi2zxr21OZ6UbVQud/RwJFL5A
	 JtdjMnl+UTMcT4Vgdm/+7BIHD4iduxJtj78yK3VPvpmhMG8nsPX30DSSTgLWTl+7Ku
	 BOieUo7gY9Iyv9Bh/2rSCb931n/kxnD0i7kIOvV62Lt7fUpCQnmQtb1TmMedYESuYs
	 Db2KWn2LhMbIvO2UWMg9WFZqHSbo4onE/E0K417i3qgQHY8Y8da+WdKX2Cy0Mz7GAQ
	 2eL4A+0PFwJa7uFynssXDVxGSTDsF74paRhslvfyRZw2VMr9oJmDa7gkTB0CBX5fry
	 ZXrM1hz5JJqzQ==
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
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Date: Tue, 26 Aug 2025 15:16:22 +0200
Message-ID: <mafs0ms7mxly1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Pasha,

On Thu, Aug 07 2025, Pasha Tatashin wrote:

> This series introduces the LUO, a kernel subsystem designed to
> facilitate live kernel updates with minimal downtime,
> particularly in cloud delplyoments aiming to update without fully
> disrupting running virtual machines.
>
> This series builds upon KHO framework by adding programmatic
> control over KHO's lifecycle and leveraging KHO for persisting LUO's
> own metadata across the kexec boundary. The git branch for this series
> can be found at:
>
> https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v3
>
> Changelog from v2:
> - Addressed comments from Mike Rapoport and Jason Gunthorpe
> - Only one user agent (LiveupdateD) can open /dev/liveupdate
> - With the above changes, sessions are not needed, and should be
>   maintained by the user-agent itself, so removed support for
>   sessions.

If all the FDs are restored in the agent's context, this assigns all the
resources to the agent. For example, if the agent restores a memfd, all
the memory gets charged to the agent's cgroup, and the client gets none
of it. This makes it impossible to do any kind of resource limits.

This was one of the advantages of being able to pass around sessions
instead of FDs. The agent can pass on the right session to the right
client, and then the client does the restore, getting all the resources
charged to it.

If we don't allow this, I think we will make LUO/LiveupdateD unsuitable
for many kinds of workloads. Do you have any ideas on how to do proper
resource attribution with the current patches? If not, then perhaps we
should reconsider this change?

[...]

-- 
Regards,
Pratyush Yadav

