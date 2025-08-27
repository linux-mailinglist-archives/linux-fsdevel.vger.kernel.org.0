Return-Path: <linux-fsdevel+bounces-59371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C46B3844E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFDB367EAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A726C35A2AE;
	Wed, 27 Aug 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoKwCtSZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51E35A293;
	Wed, 27 Aug 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303320; cv=none; b=uoPQMlSbKxxCryVBKWAA9nff0toCxmN+gcUGRMjYdaBqyNTBqV+vSfO4WOXo5b8aWgdvcRvsaNafVIRKWkQnWfiAtTkJGtSN6jjDZiK7EiW2YGwSJpYh+ky9GceiSaFnd0vh99aT4czsO6bODdHr3TZXbbhWBHnAYMplPiwH2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303320; c=relaxed/simple;
	bh=rrLE6VNYaV1/todpYtogxf/XlET+/1DTpL2efIVhb2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DEs6pjWKKhCrd1rxPH6azve/hSRSGZuCVi9fEwTadGstYzIqicRaIeKfWCtFGthUalyQjFaFN/gDi0fFqTg7ditfqyS9NfTm/DW+gj7ctxmhWeJS4avmR2/Ulz33cjiuFM4VKOl+0DtDUh19Y5cf6LQQ4vQGvf6CuIcT/Zhr3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoKwCtSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02845C4CEEB;
	Wed, 27 Aug 2025 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756303319;
	bh=rrLE6VNYaV1/todpYtogxf/XlET+/1DTpL2efIVhb2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VoKwCtSZRI6dLK2wXJrBsq6FBKn+MgCUTrGFhttvBg+W0g+hVhbO7RY19OdOFnU0F
	 wHT05QXXsO9xXkWaU0ITpHRpolLXz6UTO6AoX9p5znLcFhOqQotcxjqdpqVsX5FOwm
	 SF1kuJWCWGhc0yH2ORFzT9k5txerhwMYorKV4b+OoVLcSPgIb3+j5pb0P0lAD9+oua
	 S+qpKa/ThKfCDu8LTnuQrPTO/QTMFwherQZbng0FTmr5Ib73VnIIf9za9302Ya0ZC4
	 WW+AhyHMTwTOregtvQlZeMDhr2B4nFoR+IgCJ6+GX6WMezBSIG34xzzP3rNcqvcJlA
	 ouf7ZD2nrKcXA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,  Pratyush Yadav <pratyush@kernel.org>,
  jasonmiu@google.com,  graf@amazon.com,  changyuanl@google.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
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
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  parav@nvidia.com,
  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
In-Reply-To: <CA+CK2bB9r_pMzd0VbLsAGTwh8kvV_o3rFM_W--drutewomr1ZQ@mail.gmail.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<mafs0ms7mxly1.fsf@kernel.org>
	<CA+CK2bBoLi9tYWHSFyDEHWd_cwvS_hR4q2HMmg-C+SJpQDNs=g@mail.gmail.com>
	<20250826142406.GE1970008@nvidia.com>
	<CA+CK2bBrCd8t_BUeE-sVPGjsJwmtk3mCSVhTMGbseTi_Wk+4yQ@mail.gmail.com>
	<20250826151327.GA2130239@nvidia.com>
	<CA+CK2bAbqMb0ZYvsC9tsf6w5myfUyqo3N4fUP3CwVA_kUDQteg@mail.gmail.com>
	<20250826162203.GE2130239@nvidia.com>
	<CA+CK2bB9r_pMzd0VbLsAGTwh8kvV_o3rFM_W--drutewomr1ZQ@mail.gmail.com>
Date: Wed, 27 Aug 2025 16:01:47 +0200
Message-ID: <mafs0frdcyib8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 26 2025, Pasha Tatashin wrote:

>> > The existing interface, with the addition of passing a pidfd, provides
>> > the necessary flexibility without being invasive. The change would be
>> > localized to the new code that performs the FD retrieval and wouldn't
>> > involve spoofing current or making widespread changes.
>> > For example, to handle cgroup charging for a memfd, the flow inside
>> > memfd_luo_retrieve() would look something like this:
>> >
>> > task = get_pid_task(target_pid, PIDTYPE_PID);
>> > mm = get_task_mm(task);
>> >     // ...
>> >     folio = kho_restore_folio(phys);
>> >     // Charge to the target mm, not 'current->mm'
>> >     mem_cgroup_charge(folio, mm, ...);
>> > mmput(mm);
>> > put_task_struct(task);
>> >
>> > This approach seems quite contained, and does not modify the existing
>> > interfaces. It avoids the need for the kernel to manage the entire
>> > session state and its associated security model.

Even with sessions, I don't think the kernel has to deal with the
security model. /dev/liveupdate can still be single-open only, with only
luod getting access to it. The the kernel just hands over sessions to
luod (maybe with a new ioctl LIVEUPDATE_IOCTL_CREATE_SESSION), and luod
takes care of the security model and lifecycle. If luod crashes and
loses its handle to /dev/liveupdate, all the sessions associated with it
go away too.

Essentially, the sessions from kernel perspective would just be a
container to group different resources together. I think this adds a
small bit of complexity on the session management and serialization
side, but I think will save complexity on participating subsystems.

>>
>> Execpt it doesn't work like that in all places, iommufd for example
>> uses GFP_KERNEL_ACCOUNT which relies on current.
>
> That's a good point. For kernel allocations, I don't see a clean way
> to account for a different process.
>
> We should not be doing major allocations during the retrieval process
> itself. Ideally, the kernel would restore an FD using only the
> preserved folio data (that we can cleanly charge), and then let the
> user process perform any subsequent actions that might cause new
> kernel memory allocations. However, I can see how that might not be
> practical for all handlers.
>
> Perhaps, we should add session extensions to the kernel as follow-up
> after this series lands, we would also need to rewrite luod design
> accordingly to move some of the sessions logic into the kernel.

I know the KHO is supposed to not be backwards compatible yet. What is
the goal for the LUO APIs? Are they also not backwards compatible? If
not, I think we should also consider how sessions will play into
backwards compatibility. For example, once we add sessions, what happens
to the older versions of luod that directly call preserve or unpreserve?

-- 
Regards,
Pratyush Yadav

