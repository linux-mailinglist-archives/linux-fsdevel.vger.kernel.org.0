Return-Path: <linux-fsdevel+bounces-63987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31FBD47D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12767426EB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC830C60B;
	Mon, 13 Oct 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1mwuIjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B6A30FF30;
	Mon, 13 Oct 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369004; cv=none; b=GeuTT5lChQxV+HzcTX333tw70rJhrDHNoRtu3L5Rg0nfiGgsa5wQhN3kv+92L4AqyQYXsNc3VT1y4iGxLCmd0oRV4HXdxiy3Zf3IktVUKyD20wFiRG+XP5rWtxFVfUaf8DGyaBlrJIn5gXm3EJcZf8L0GIbb43k9BcutTGCe+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369004; c=relaxed/simple;
	bh=HrpU56u8pxLbc0g2WXKv8ddcf/Eh7MXMNWvvG37jNK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sWakCjOnIO41j3GFUY3VG2lcNpWe6DZFZSHZReWuoYOn5UbrSnxc1XJmf46pZnmlGWrV+NzxZJH1o5V794OodDgTlI4sr5xPhYirtTLrCtQ76UlK6VB6psCmgV2c59pan04Wu0JNQgcAqg2/AjfZJmduWVg1GxruvJ9MglsZi4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1mwuIjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467E2C4CEE7;
	Mon, 13 Oct 2025 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760369003;
	bh=HrpU56u8pxLbc0g2WXKv8ddcf/Eh7MXMNWvvG37jNK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=p1mwuIjGDqqsckgAZg28V4Tdmyj4Dd97sGqbbsa9lgNdyX/sRs42EfYMS3jIPWYV+
	 nr7vxK2+169v0M8HySQ0uqBzWr5hAOg9GhkSMNabre2gX2OpTEehC8GXK0Effdu/Fa
	 3qlF51k21MY8e6I51tFIoKonWMKzGJJTeSnhlkhcx9OTkxrj5xVP10uY7uempIhuyC
	 whGSrPHmNuYmQhrwOqoM1Mm7g38uBzRluMba02MY4iX0Nqu/FbMRr67HApS8b0rMcl
	 UOdvgHtogP3LzHWRJLxerRuaI1Yn22cFa8aVYGPDj1UhayuNHwJMC1NTcqr0MjEaca
	 vUKwnxoP+7xhw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  jasonmiu@google.com,
  graf@amazon.com,  changyuanl@google.com,  rppt@kernel.org,
  dmatlack@google.com,  rientjes@google.com,  corbet@lwn.net,
  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
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
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org,
  steven.sistare@oracle.com
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
In-Reply-To: <CA+CK2bB6F634HCw_N5z9E5r_LpbGJrucuFb_5fL4da5_W99e4Q@mail.gmail.com>
	(Pasha Tatashin's message of "Thu, 9 Oct 2025 19:50:12 -0400")
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
	<CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
	<mafs0ms5zn0nm.fsf@kernel.org>
	<CA+CK2bB6F634HCw_N5z9E5r_LpbGJrucuFb_5fL4da5_W99e4Q@mail.gmail.com>
Date: Mon, 13 Oct 2025 17:23:13 +0200
Message-ID: <mafs0o6qaltb2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09 2025, Pasha Tatashin wrote:

> On Thu, Oct 9, 2025 at 6:58=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>>
>> On Tue, Oct 07 2025, Pasha Tatashin wrote:
>>
>> > On Sun, Sep 28, 2025 at 9:03=E2=80=AFPM Pasha Tatashin
>> > <pasha.tatashin@soleen.com> wrote:
>> >>
>> [...]
>> > 4. New File-Lifecycle-Bound Global State
>> > ----------------------------------------
>> > A new mechanism for managing global state was proposed, designed to be
>> > tied to the lifecycle of the preserved files themselves. This would
>> > allow a file owner (e.g., the IOMMU subsystem) to save and retrieve
>> > global state that is only relevant when one or more of its FDs are
>> > being managed by LUO.
>>
>> Is this going to replace LUO subsystems? If yes, then why? The global
>> state will likely need to have its own lifecycle just like the FDs, and
>> subsystems are a simple and clean abstraction to control that. I get the
>> idea of only "activating" a subsystem when one or more of its FDs are
>> participating in LUO, but we can do that while keeping subsystems
>> around.
>
> Thanks for the feedback. The FLB Global State is not replacing the LUO
> subsystems. On the contrary, it's a higher-level abstraction that is
> itself implemented as a LUO subsystem. The goal is to provide a
> solution for a pattern that emerged during the PCI and IOMMU
> discussions.

Okay, makes sense then. I thought we were removing the subsystems idea.
I didn't follow the PCI and IOMMU discussions that closely.

Side note: I see a dependency between subsystems forming. For example,
the FLB subsystem probably wants to make sure all its dependent
subsystems (like LUO files) go through their callbacks before getting
its callback. Maybe in the current implementation doing it in any order
works, but in general, if it manages data of other subsystems, it should
be serialized after them.

Same with the hugetlb subsystem for example. On prepare or freeze time,
it would probably be a good idea if the files callbacks finish first. I
would imagine most subsystems would want to go after files.

With the current registration mechanism, the order depends on when the
subsystem is registered, which is hard to control. Maybe we should have
a global list of subsystems and can manually specify the order? Not sure
if that is a good idea, just throwing it out there off the top of my
head.

>
> You can see the WIP implementation here, which shows it registering as
> a subsystem named "luo-fh-states-v1-struct":
> https://github.com/soleen/linux/commit/94e191aab6b355d83633718bc4a1d27dda=
390001
>
> The existing subsystem API is a low-level tool that provides for the
> preservation of a raw 8-byte handle. It doesn't provide locking, nor
> is it explicitly tied to the lifecycle of any higher-level object like
> a file handler. The new API is designed to solve a more specific
> problem: allowing global components (like IOMMU or PCI) to
> automatically track when resources relevant to them are added to or
> removed from preservation. If HugeTLB requires a subsystem, it can
> still use it, but I suspect it might benefit from FLB Global State as
> well.

Hmm, right. Let me see how I can make use of it.

>
>> Here is how I imagine the proposed API would compare against subsystems
>> with hugetlb as an example (hugetlb support is still WIP, so I'm still
>> not clear on specifics, but this is how I imagine it will work):
>>
>> - Hugetlb subsystem needs to track its huge page pools and which pages
>>   are allocated and free. This is its global state. The pools get
>>   reconstructed after kexec. Post-kexec, the free pages are ready for
>>   allocation from other "regular" files and the pages used in LUO files
>>   are reserved.
>>
>> - Pre-kexec, when a hugetlb FD is preserved, it marks that as preserved
>>   in hugetlb's global data structure tracking this. This is runtime data
>>   (say xarray), and _not_ serialized data. Reason being, there are
>>   likely more FDs to come so no point in wasting time serializing just
>>   yet.
>>
>>   This can look something like:
>>
>>   hugetlb_luo_preserve_folio(folio, ...);
>>
>>   Nice and simple.
>>
>>   Compare this with the new proposed API:
>>
>>   liveupdate_fh_global_state_get(h, &hugetlb_data);
>>   // This will have update serialized state now.
>>   hugetlb_luo_preserve_folio(hugetlb_data, folio, ...);
>>   liveupdate_fh_global_state_put(h);
>>
>>   We do the same thing but in a very complicated way.
>>
>> - When the system-wide preserve happens, the hugetlb subsystem gets a
>>   callback to serialize. It converts its runtime global state to
>>   serialized state since now it knows no more FDs will be added.
>>
>>   With the new API, this doesn't need to be done since each FD prepare
>>   already updates serialized state.
>>
>> - If there are no hugetlb FDs, then the hugetlb subsystem doesn't put
>>   anything in LUO. This is same as new API.
>>
>> - If some hugetlb FDs are not restored after liveupdate and the finish
>>   event is triggered, the subsystem gets its finish() handler called and
>>   it can free things up.
>>
>>   I don't get how that would work with the new API.
>
> The new API isn't more complicated; It codifies the common pattern of
> "create on first use, destroy on last use" into a reusable helper,
> saving each file handler from having to reinvent the same reference
> counting and locking scheme. But, as you point out, subsystems provide
> more control, specifically they handle full creation/free instead of
> relying on file-handlers for that.
>
>> My point is, I see subsystems working perfectly fine here and I don't
>> get how the proposed API is any better.
>>
>> Am I missing something?
>
> No, I don't think you are. Your analysis is correct that this is
> achievable with subsystems. The goal of the new API is to make that
> specific, common use case simpler.

Right. Thanks for clarifying.

>
> Pasha

--=20
Regards,
Pratyush Yadav

