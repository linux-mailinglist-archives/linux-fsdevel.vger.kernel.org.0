Return-Path: <linux-fsdevel+bounces-65697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE10C0D2C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 12:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838433AF9C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 11:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3788D2FC02A;
	Mon, 27 Oct 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPZB8lkX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B51FF1AD;
	Mon, 27 Oct 2025 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565075; cv=none; b=QO/UveNKh+uqvIwM6Cei6WUb0ovz7ik5hRt1B5csMXFMUTSx+9YED5r0MyMpfkiTK+Pe2RaTPoCVC/sW4rMuezS8Zcov8veCWoDc4AbeuzCq1RihLZa+44PkpEiHBfMRr7MPuK1vAReOJEJxiedc6+LwAoL+oVqsZ9N9ZnUWlgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565075; c=relaxed/simple;
	bh=qEFSBVn7tvYChgqBuSbB762Baav+81SepQq/Uf98LX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tg/cX1djWyLahStzNaYVJ0hNofPoy/hpu0t8UgseM07PQNK/LfdQctRVXji7SSJksS/uVgTxiN4vfXotMOk47Z31+aRcvE8OS00WwTfV2rVz2F/5bF4/rKrs2eZy/RnRW4MyGT30gRAvrDNial8T7Oa1Mt9+jymb7zh+WzjP3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPZB8lkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC65DC4CEFF;
	Mon, 27 Oct 2025 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761565075;
	bh=qEFSBVn7tvYChgqBuSbB762Baav+81SepQq/Uf98LX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QPZB8lkXka1OfqOTgreoj/P2Lg1hhWZXmp0ATPFjOUcqNjUMSysHbPqTyyVoyY21G
	 pIPzTIEX+qR7+KzqRNGZ6cuJXse0MlchxX/qiRN2MqZYCiQY5t5V0OXONi9DqK3SSz
	 K3AyPumi09jDGxYjIm9az3m97OE5uWSLyHisKPIPa2hli7eY0f5ffKsNYg1fH9rG2p
	 Mc/tUYgYA3hAo/ShlSZseCveHX6OpCES8EJxQWqW8eVPC+0G+rGD1UU4DqFc705ygd
	 p9jQBRWFkJa9wCUdyjyZpLmnuP/QTLnJSuAhyKVtHkBPYhC5plFZDMfv/br3uPs/P3
	 MSRt9bNkz34ig==
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
  leonro@nvidia.com,  witu@nvidia.com,  hughd@google.com,
  skhawaja@google.com,  chrisl@kernel.org,  steven.sistare@oracle.com
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
In-Reply-To: <20251020142924.GS316284@nvidia.com> (Jason Gunthorpe's message
	of "Mon, 20 Oct 2025 11:29:24 -0300")
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
	<CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
	<mafs0ms5zn0nm.fsf@kernel.org>
	<CA+CK2bB6F634HCw_N5z9E5r_LpbGJrucuFb_5fL4da5_W99e4Q@mail.gmail.com>
	<20251010150116.GC3901471@nvidia.com> <mafs0bjm9lig8.fsf@kernel.org>
	<20251020142924.GS316284@nvidia.com>
Date: Mon, 27 Oct 2025 12:37:44 +0100
Message-ID: <mafs0y0owd187.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20 2025, Jason Gunthorpe wrote:

> On Tue, Oct 14, 2025 at 03:29:59PM +0200, Pratyush Yadav wrote:
>> > 1) Use a vmalloc and store a list of the PFNs in the pool. Pool becomes
>> >    frozen, can't add/remove PFNs.
>> 
>> Doesn't that circumvent LUO's state machine? The idea with the state
>> machine was to have clear points in time when the system goes into the
>> "limited capacity"/"frozen" state, which is the LIVEUPDATE_PREPARE
>> event. 
>
> I wouldn't get too invested in the FSM, it is there but it doesn't
> mean every luo client has to be focused on it.

Having each subsystem have its own state machine sounds like a bad idea
to me. It can get tricky to manage both for us and our users.

>
>> With what you propose, the first FD being preserved implicitly
>> triggers the prepare event. Same thing for unprepare/cancel operations.
>
> Yes, this is easy to write and simple to manage.
>
>> I am wondering if it is better to do it the other way round: prepare all
>> files first, and then prepare the hugetlb subsystem at
>> LIVEUPDATE_PREPARE event. At that point it already knows which pages to
>> mark preserved so the serialization can be done in one go.
>
> I think this would be slower and more complex?
>
>> > 2) Require the users of hugetlb memory, like memfd, to
>> >    preserve/restore the folios they are using (using their hugetlb order)
>> > 3) Just before kexec run over the PFN list and mark a bit if the folio
>> >    was preserved by KHO or not. Make sure everything gets KHO
>> >    preserved.
>> 
>> "just before kexec" would need a callback from LUO. I suppose a
>> subsystem is the place for that callback. I wrote my email under the
>> (wrong) impression that we were replacing subsystems.
>
> The file descriptors path should have luo client ops that have all
> the required callbacks. This is probably an existing op.
>
>> That makes me wonder: how is the subsystem-level callback supposed to
>> access the global data? I suppose it can use the liveupdate_file_handler
>> directly, but it is kind of strange since technically the subsystem and
>> file handler are two different entities.
>
> If we need such things we would need a way to link these together, but
> I'm wonder if we really don't..
>
>> Also as Pasha mentioned, 1G pages for guest_memfd will use hugetlb, and
>> I'm not sure how that would map with this shared global data. memfd and
>> guest_memfd will likely have different liveupdate_file_handler but would
>> share data from the same subsystem. Maybe that's a problem to solve for
>> later...
>
> On preserve memfd should call into hugetlb to activate it as a hugetlb
> page provider and preserve it too.

From what I understand, the main problem you want to solve is that the
life cycle of the global data should be tied to the file descriptors.
And since everything should have a FD anyway, can't we directly tie the
subsystems to file handlers? The subsystem gets a "preserve" callback
when the first FD that uses it gets preserved. It gets a "unpreserve"
callback when the last FD goes away. And the rest of the state machine
like prepare, cancel, etc. stay the same.

I think this gives us a clean abstraction that has LUO-managed lifetime.

It also works with the guest_memfd and memfd case since both can have
hugetlb as their underlying subsystem. For example,

static const struct liveupdate_file_ops memfd_luo_file_ops = {
	.preserve = memfd_luo_preserve,
	.unpreserve = memfd_luo_unpreserve,
	[...]
	.subsystem = &luo_hugetlb_subsys,
};

And then luo_{un,}preserve_file() can keep a refcount for the subsystem
and preserve or unpreserve the subsystem as needed. LUO can manage the
locking for these callbacks too.

-- 
Regards,
Pratyush Yadav

