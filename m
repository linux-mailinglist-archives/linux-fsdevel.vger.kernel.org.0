Return-Path: <linux-fsdevel+bounces-64131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E4BBD9B93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 15:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311063B8DED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F217314A62;
	Tue, 14 Oct 2025 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrHy1FFo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E2C2F6194;
	Tue, 14 Oct 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448610; cv=none; b=pqPj6rl/J3HYTbV4s6VKVqytuy0TGYt1M72U8BtxlvWOIGZXLGU2CSM0GsCs/SJRUIeWrM5yDh2jYInZF9N9rQgeF1oBxjcsthXPBRwgvpg4gEvg9UuF2qQZHEipm4iwA3LTK0KkiD/mE7R9t57lvsDjuohNYzgdY5KBCzdhNrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448610; c=relaxed/simple;
	bh=pNGGyokr8X1AGHFovWK/YwKzLd8yndY2pnPSWQjmLOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iMaECpvfHc0MQ/oYvzFh/XFZSANI3pSSjbCZgbZquya3f3Z3kYbqDhKlbxU1GcAQHhgqt5oz+j55zf1O1bjhjoQFXt/O9NWBTuCVRsw9RTHFrZEEZxZr75Iyj/Fy1PY9gPOFqzeDMqS11mxppsRLcFZC2XTHix7TLkB4c/Qj/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrHy1FFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209F8C4CEE7;
	Tue, 14 Oct 2025 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760448610;
	bh=pNGGyokr8X1AGHFovWK/YwKzLd8yndY2pnPSWQjmLOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PrHy1FFo4vOfHgRLP+LZxJrAoiX0f1g6DosVRTkP9hjElSUeRaA1tnwNqdrN1/RNP
	 rCuPe2GcHw/uA62lAVv0LwUqtXVfO7y3Up7IQSsZx/pLSHidaEipXsgJjA1IZHwSqn
	 s8QOxS1YJoYZ3lS0VWUn7NwuKt5v8TOZj1lw2aS3xYIW4tR08HJwTRshi33ijbW6rv
	 tT4cyA2lKl2ikFIA7gNlVVRNFodqD6voRaOl6ej6ozxGTWFejcm0r+Kb5AoO25TOpS
	 XxnNKMs2DTqMC5RnCxyzWLAWoiuTW8vU56PRAIXGlxUrTlsgqJWZpGrHjjtlr6l8hK
	 ix4SyXG6XtlNw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  jasonmiu@google.com,  graf@amazon.com,
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
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  parav@nvidia.com,
  leonro@nvidia.com,  witu@nvidia.com,  hughd@google.com,
  skhawaja@google.com,  chrisl@kernel.org,  steven.sistare@oracle.com
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
In-Reply-To: <20251010150116.GC3901471@nvidia.com> (Jason Gunthorpe's message
	of "Fri, 10 Oct 2025 12:01:16 -0300")
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
	<CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
	<mafs0ms5zn0nm.fsf@kernel.org>
	<CA+CK2bB6F634HCw_N5z9E5r_LpbGJrucuFb_5fL4da5_W99e4Q@mail.gmail.com>
	<20251010150116.GC3901471@nvidia.com>
Date: Tue, 14 Oct 2025 15:29:59 +0200
Message-ID: <mafs0bjm9lig8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 10 2025, Jason Gunthorpe wrote:

> On Thu, Oct 09, 2025 at 07:50:12PM -0400, Pasha Tatashin wrote:
>> >   This can look something like:
>> >
>> >   hugetlb_luo_preserve_folio(folio, ...);
>> >
>> >   Nice and simple.
>> >
>> >   Compare this with the new proposed API:
>> >
>> >   liveupdate_fh_global_state_get(h, &hugetlb_data);
>> >   // This will have update serialized state now.
>> >   hugetlb_luo_preserve_folio(hugetlb_data, folio, ...);
>> >   liveupdate_fh_global_state_put(h);
>> >
>> >   We do the same thing but in a very complicated way.
>> >
>> > - When the system-wide preserve happens, the hugetlb subsystem gets a
>> >   callback to serialize. It converts its runtime global state to
>> >   serialized state since now it knows no more FDs will be added.
>> >
>> >   With the new API, this doesn't need to be done since each FD prepare
>> >   already updates serialized state.
>> >
>> > - If there are no hugetlb FDs, then the hugetlb subsystem doesn't put
>> >   anything in LUO. This is same as new API.
>> >
>> > - If some hugetlb FDs are not restored after liveupdate and the finish
>> >   event is triggered, the subsystem gets its finish() handler called and
>> >   it can free things up.
>> >
>> >   I don't get how that would work with the new API.
>> 
>> The new API isn't more complicated; It codifies the common pattern of
>> "create on first use, destroy on last use" into a reusable helper,
>> saving each file handler from having to reinvent the same reference
>> counting and locking scheme. But, as you point out, subsystems provide
>> more control, specifically they handle full creation/free instead of
>> relying on file-handlers for that.
>
> I'd say hugetlb *should* be doing the more complicated thing. We
> should not have global static data for luo floating around the kernel,
> this is too easily abused in bad ways.

Not sure how much difference this makes in practice, but I get your
point.

>
> The above "complicated" sequence forces the caller to have a fd
> session handle, and "hides" the global state inside luo so the
> subsystem can't just randomly reach into it whenever it likes.
>
> This is a deliberate and violent way to force clean coding practices
> and good layering.
>
> Not sure why hugetlb pools would need another xarray??

Not sure myself either. I used it to demonstrate my point of having
runtime state and serialized state separate from each other.

>
> 1) Use a vmalloc and store a list of the PFNs in the pool. Pool becomes
>    frozen, can't add/remove PFNs.

Doesn't that circumvent LUO's state machine? The idea with the state
machine was to have clear points in time when the system goes into the
"limited capacity"/"frozen" state, which is the LIVEUPDATE_PREPARE
event. With what you propose, the first FD being preserved implicitly
triggers the prepare event. Same thing for unprepare/cancel operations.

I am wondering if it is better to do it the other way round: prepare all
files first, and then prepare the hugetlb subsystem at
LIVEUPDATE_PREPARE event. At that point it already knows which pages to
mark preserved so the serialization can be done in one go.

> 2) Require the users of hugetlb memory, like memfd, to
>    preserve/restore the folios they are using (using their hugetlb order)
> 3) Just before kexec run over the PFN list and mark a bit if the folio
>    was preserved by KHO or not. Make sure everything gets KHO
>    preserved.

"just before kexec" would need a callback from LUO. I suppose a
subsystem is the place for that callback. I wrote my email under the
(wrong) impression that we were replacing subsystems.

That makes me wonder: how is the subsystem-level callback supposed to
access the global data? I suppose it can use the liveupdate_file_handler
directly, but it is kind of strange since technically the subsystem and
file handler are two different entities.

Also as Pasha mentioned, 1G pages for guest_memfd will use hugetlb, and
I'm not sure how that would map with this shared global data. memfd and
guest_memfd will likely have different liveupdate_file_handler but would
share data from the same subsystem. Maybe that's a problem to solve for
later...

>
> Restore puts the PFNs that were not preserved directly in the free
> pool, the end user of the folio like the memfd restores and eventually
> normally frees the other folios.

Yeah, on the restore side this idea works fine I think.

>
> It is simple and fits nicely into the infrastructure here, where the
> first time you trigger a global state it does the pfn list and
> freezing, and the lifecycle and locking for this operation is directly
> managed by luo.
>
> The memfd, when it knows it has hugetlb folios inside it, would
> trigger this.
>
> Jason

-- 
Regards,
Pratyush Yadav

