Return-Path: <linux-fsdevel+bounces-56295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DF0B155ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBA73AF30D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 23:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A930E287270;
	Tue, 29 Jul 2025 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExfrNWag"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5228469A;
	Tue, 29 Jul 2025 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831421; cv=none; b=iL+jO/PXKf65OVWkj41qTZ6qPhSfKlXtibE5P1xbj7QyEPPdz6lxiiX8ib5ISz3cg4vwoQNxfYvgiDPTVut1upWPH6FSwfS68Y0Bu/E018M/WmvrNJrLRaVLRyu7WxPVmAHtgMHrXh7Bd8EEbYkI+yADMo3hiHcSliAe5GSn2D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831421; c=relaxed/simple;
	bh=k87dPy6BPkaKz6PVwZ9QExifXqUdGreO1XryLzhHrAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SmnlwQsku4uADO/4WFv/7wRbq/RYURKDCICv53VR53zp/Jq27Gb8Bqzj0zHE0torXyvWWi7ZRPl1gRTx5R81RGC31yoOr3VQpdIvHz+sgbaQJQfHbW6Tm1s/L7PiMDDYqyuT9O1Tc93+mie++CkDsDSEYHiOHwyiNbekYQIGbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExfrNWag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50991C4CEF7;
	Tue, 29 Jul 2025 23:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753831420;
	bh=k87dPy6BPkaKz6PVwZ9QExifXqUdGreO1XryLzhHrAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ExfrNWagdnrOUCqpiU3Lx9CVfPIp7MiWDZf8en0ZPlkT/sSBVYPfQm95IJrm+lavz
	 xO3ixcF5LdhPdpxIhjbbIDM//OnwrYz2GlfzTafjYRm0z9rgGffZIy49H4UOsMDIim
	 MxXUAu7OBYRjdF+bOLfiMb3F2+nvBVDJfkZf1tOxdoGyMHEp5CPbGUpMX0Tde4Oc/A
	 dUTAZX7snWGKF++MpaMUDxcAOcifca93aYE7gxxcGtOlyWyZOzVWPQRuHA8jp8SVV0
	 Gsb68qtK7cOd352+mtgM9MLjS41RS3uKrcDMiOkE/kYX3hQeVqn6I0Nuhg1AD5dbxN
	 XH02XJsRenO3A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,  Thomas Gleixner <tglx@linutronix.de>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  pratyush@kernel.org,
  jasonmiu@google.com,  graf@amazon.com,  changyuanl@google.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  anna.schumaker@oracle.com,  song@kernel.org,  zhangguopeng@kylinos.cn,
  linux@weissschuh.net,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-mm@kvack.org,
  gregkh@linuxfoundation.org,  mingo@redhat.com,  bp@alien8.de,
  dave.hansen@linux.intel.com,  x86@kernel.org,  hpa@zytor.com,
  rafael@kernel.org,  dakr@kernel.org,  bartosz.golaszewski@linaro.org,
  cw00.choi@samsung.com,  myungjoo.ham@samsung.com,
  yesanishhere@gmail.com,  Jonathan.Cameron@huawei.com,
  quic_zijuhu@quicinc.com,  aleksander.lobakin@intel.com,
  ira.weiny@intel.com,  andriy.shevchenko@linux.intel.com,
  leon@kernel.org,  lukas@wunner.de,  bhelgaas@google.com,
  wagi@kernel.org,  djeffery@redhat.com,  stuart.w.hayes@gmail.com,
  lennart@poettering.net,  brauner@kernel.org,  linux-api@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  saeedm@nvidia.com,
  ajayachandra@nvidia.com,  parav@nvidia.com,  leonro@nvidia.com,
  witu@nvidia.com
Subject: Re: [PATCH v2 31/32] libluo: introduce luoctl
In-Reply-To: <20250729183548.49d6c2dc@gandalf.local.home>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
	<20250723144649.1696299-32-pasha.tatashin@soleen.com>
	<20250729161450.GM36037@nvidia.com> <877bzqkc38.ffs@tglx>
	<20250729222157.GT36037@nvidia.com>
	<20250729183548.49d6c2dc@gandalf.local.home>
Date: Wed, 30 Jul 2025 01:23:30 +0200
Message-ID: <mafs07bzqeg3x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 29 2025, Steven Rostedt wrote:

> On Tue, 29 Jul 2025 19:21:57 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
>
>> > As this is an evolving mechanism, having the corresponding library in
>> > the kernel similar to what we do with perf and other things makes a lot
>> > of sense.  
>> 
>> If we did this everywhere we'd have hundreds of libraries in the
>> kernel tree and I would feel bad for all the distros that have to deal
>> with packaging such a thing :(
>> 
>> It is great for development but I'm not sure mono-repo directions are
>> so good for the overall ecosystem.
>
> I have to agree here. When libtraceevent was in the kernel, it was a pain
> to orchestrate releases with distros. When it was moved out of the kernel,
> it made it much easier to manage.
>
> The main issue was versioning numbers. I know the kernel versioning is
> simply just "hey we added more stuff" and the numbers are meaningless.
>
> But a library usually has a different cycle than the kernel. If it doesn't
> have any changes from one kernel release to the next, the distros will make
> a new version anyway, as each kernel release means a new library release.
>
> This luoctl.c isn't even a library, as it has a "main()" and looks to me
> like an application. So my question is, why is it in tools/lib?

luoctl isn't the library, it is a user of it. See previous patches for
the main library. Don't get too excited though, it is only a thin
wrapper around the ioctls. The more interesting stuff is in patch 32
which shows the API in action.

To add some context: one of the reasons to include it in the series as
an RFC at the end was to showcase the userspace side of the API and have
a way for people to see how it can be used. Seeing an API in action
provides useful context for reviewing patches.

I think Pasha forgot to add the RFC tags when he created v2, since it is
only meant to be RFC right now and not proper patches.

The point of moving out of tree was also brought up in the live update
call and I agree with Jason's feedback on it. The plan is to drop it
from the series in the next revision, and just leave a reference to it
in the cover letter instead.

-- 
Regards,
Pratyush Yadav

