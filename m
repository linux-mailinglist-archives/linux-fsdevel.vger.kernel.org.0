Return-Path: <linux-fsdevel+bounces-60271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE3B43C32
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 14:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A7016AC27
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95612FE059;
	Thu,  4 Sep 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/ZCDfPq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C92629C;
	Thu,  4 Sep 2025 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990666; cv=none; b=s1dHtKfODMsSlfSJHdYjh2/iig4Bdtwxwtgj5B+u0UoupqSEudf5LjWxgPelilfbRn/mCXJuWSrpePiwzfmqH9QrnZo83jN5fVRxnvfRPsobBKNivkXM5nlxwgwKiA+sBKZG8bT8I3udDWrJ9wI7qjJD0okXo6Ha/rq82MndEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990666; c=relaxed/simple;
	bh=8/eVc7vWpyZYNyruSsCDjRKKy2KGqc1y07Wo5xHNUoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EtYUhLR9ArtsWMeP6b2IpXIiOn9yVvL3QqMXo1apK2bWlzymgWaHMCnvcW42D6YhBYxKIKhn1TTxymL/+B2A3H3/5gPnIbHiyq3Dv/rCa2rhE6oYa5ThMYAD11D/my7MttZFZjgObRuPjGSSqCBxV85m1pto+Bt+zf73tXrJXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/ZCDfPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7899EC4CEF0;
	Thu,  4 Sep 2025 12:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756990665;
	bh=8/eVc7vWpyZYNyruSsCDjRKKy2KGqc1y07Wo5xHNUoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q/ZCDfPqOqseYnoW+PN2j4RogP9bF1M8oDdqg8PP0CGt03j4Lh+rzTi6HbJEgR/SJ
	 qq+195iNezWVcaURhPRCSEaCMf2a+ALMFkXVC96ZUuB1ijXXH8ODxEiubGtrz7mm3k
	 t6MWOz6/eUDrfHP9eAvw+JJNKnkfGUVXh/ja/3MiZvt0mQmzSjFPWjEIUmYOl+4BYA
	 bFr4zNcjyt+tc5A13LqwsBaHU7gKI1yWNt3SF5QsxMHpfuwgr2faUnIpRxyJ6EIaBj
	 kWSvOU//5+ETFo6VuyYvjCfx2UQOhyMBV28IsLrJmWmI9Yt5mBOQws0jA7pW/u3o6y
	 pUcDm6M1eiVaA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  jasonmiu@google.com,  graf@amazon.com,
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
  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
In-Reply-To: <20250903150157.GH470103@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250826162019.GD2130239@nvidia.com> <mafs0bjo0yffo.fsf@kernel.org>
	<20250828124320.GB7333@nvidia.com> <mafs0h5xmw12a.fsf@kernel.org>
	<20250902134846.GN186519@nvidia.com> <mafs0v7lzvd7m.fsf@kernel.org>
	<20250903150157.GH470103@nvidia.com>
Date: Thu, 04 Sep 2025 14:57:35 +0200
Message-ID: <mafs0a53av0hs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jason,

On Wed, Sep 03 2025, Jason Gunthorpe wrote:

> On Wed, Sep 03, 2025 at 04:10:37PM +0200, Pratyush Yadav wrote:
>
>> > So, it could be useful, but I wouldn't use it for memfd, the vmalloc
>> > approach is better and we shouldn't optimize for sparsness which
>> > should never happen.
>> 
>> I disagree. I think we are re-inventing the same data format with minor
>> variations. I think we should define extensible fundamental data formats
>> first, and then use those as the building blocks for the rest of our
>> serialization logic.
>
> page, vmalloc, slab seem to me to be the fundamental units of memory
> management in linux, so they should get KHO support.
>
> If you want to preserve a known-sized array you use vmalloc and then
> write out the per-list items. If it is a dictionary/sparse array then
> you write an index with each item too. This is all trivial and doesn't
> really need more abstraction in of itself, IMHO.

We will use up double the space for tracking metadata, but maybe that is
fine until we start seeing bigger memfds in real workloads.

>
>> cases can then build on top of it. For example, the preservation bitmaps
>> can get rid of their linked list logic and just use KHO array to hold
>> and retrieve its bitmaps. It will make the serialization simpler.
>
> I don't think the bitmaps should, the serialization here is very
> special because it is not actually preserved, it just exists for the
> time while the new kernel runs in scratch and is insta freed once the
> allocators start up.

I don't think it matters if they are preserved or not. The serialization
and deserialization is independent of that. You can very well create a
KHO array that you don't KHO-preserve. On next boot, you can still use
it, you just have to be careful of doing it while scratch-only. Same as
we do now.

>
>> I also don't get why you think sparseness "should never happen". For
>> memfd for example, you say in one of your other emails that "And again
>> in real systems we expect memfd to be fully populated too." Which
>> systems and use cases do you have in mind? Why do you think people won't
>> want a sparse memfd?
>
> memfd should principally be used to back VM memory, and I expect VM
> memory to be fully populated. Why would it be sparse?

For the _hypervisor_ live update case, sure. Though even there, I have a
feeling we will start seeing userspace components on the hypervisor use
memfd for stashing some of their state. Pasha has already mentioned they
have a use case for a memfd that is not VM memory.

But hypervisor live upadte isn't the only use case for LUO. We are
looking at enabling state preservation for "normal" userspace
applications. Think big storage nodes with memory in order of TiB. Those
can use a memfd to back their caches so on a kernel upgrade the caches
don't have to be re-fetched. Sparseness is to be expected for such use
cases.

>
>> All in all, I think KHO array is going to prove useful and will make
>> serialization for subsystems easier. I think sparseness will also prove
>> useful but it is not a hill I want to die on. I am fine with starting
>> with a non-sparse array if people really insist. But I do think we
>> should go with KHO array as a base instead of re-inventing the linked
>> list of pages again and again.
>
> The two main advantages I see to the kho array design vs vmalloc is
> that it should be a bit faster as it doesn't establish a vmap, and it
> handles unknown size lists much better.
>
> Are these important considerations? IDK.
>
> As I said to Chris, I think we should see more examples of what we
> actually need before assuming any certain datastructure is the best
> choice.
>
> So I'd stick to simpler open coded things and go back and improve them
> than start out building the wrong shared data structure.
>
> How about have at least three luo clients that show meaningful benefit
> before proposing something beyond the fundamental page, vmalloc, slab
> things?

I think the fundamentals themselves get some benefit. But anyway, since
I have done most of the work on this feature anyway, I will do the rest
and send the patches out. Then you can have a look and if you're still
not convinced, I am fine shelving it for now to revisit later when a
stronger case can be made.

>
>> What do you mean by "data per version"? I think there should be only one
>> version of the serialized object. Multiple versions of the same thing
>> will get ugly real quick.
>
> If you want to support backwards/forwards compatability then you
> probably should support multiple versions as well. Otherwise it
> could become quite hard to make downgrades..

Hmm, forward can work regardless since a newer kernel should speak older
formats too, but for backwards it makes sense to have an older version.

But perhaps it might be a better idea to come up with a mechanism for
the kernel to discover which formats the "next" kernel speaks so it can
for one decide whether it can do the live update at all, and for another
which formats it should use. Maybe we give a way for luod to choose
formats, and give it the responsibility for doing these checks?

>
> Ideally I'd want to remove the upstream code for obsolete versions
> fairly quickly so I'd imagine kernels will want to generate both
> versions during the transition period and then eventually newer
> kernels will only accept the new version.
>
> I've argued before that the extended matrix of any kernel version to
> any other kernel version should lie with the distro/CSP making the
> kernel fork. They know what their upgrade sequence will be so they can
> manage any missing versions to make it work.
>
> Upstream should do like v6.1 to v6.2 only or something similarly well
> constrained. I think this is a reasonable trade off to get subsystem
> maintainers to even accept this stuff at all.
[...]

-- 
Regards,
Pratyush Yadav

