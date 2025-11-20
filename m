Return-Path: <linux-fsdevel+bounces-69244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A63C75100
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 16:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 38A072BEF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0713451BB;
	Thu, 20 Nov 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSbuSzzK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D29358D2A;
	Thu, 20 Nov 2025 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652896; cv=none; b=I9Q99evnoWraEOrWEyaWz3wDtsYxCPKCQeZhaRnLubudz7vWp5YLxU1PmVD9SZNn6+63XJyURLiZmD0AKFtiCePCmfdnDnwlbdRSuCbowiA2W2ugp/nSkQ2JBcpRkGOPaNw2EN5uNOgkg/ehqLILQulVR7nRjA0/yvs58axxEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652896; c=relaxed/simple;
	bh=iLlpiIoq6RvRNwPu4wKmwbysrxXgehN/NeIhRBCyojQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ARL+nk8+1+u3RA4PD7xRKQ7u9TvOxX55HU6f/0Ppjeo5imGL6FHwsPG+uLPVqwK8VXJibCDzWymo4pA1I+6i5ldUqshDarXeCMYecid8n5cvN4pl1To39CMijYC0QkJ5pzzMsgNF9TVhRIuKuV3IU7s7/0YGDgZ2eiXfD9ueGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSbuSzzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36EEC4CEF1;
	Thu, 20 Nov 2025 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763652895;
	bh=iLlpiIoq6RvRNwPu4wKmwbysrxXgehN/NeIhRBCyojQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BSbuSzzK7NmUg46X6Xqg6ULra0bk2IOvd4ky2Uu2VfaVLOtcvXkx17NUhrXYC5ucU
	 PJfv6TgrN2RCJfDTXq3QFuGducBydTpyGGuTVt1tX1UsYx158hZaIw6KucGedSBdnj
	 cnWvat7/iCNuhM3D4FhcULyewVEYpxKNXTsxKMFgotaIX21VGAH+F5QnMtqCQtdQ/z
	 u0eFdZ3lwuu0TO7ycFLhQMuIe6rxYzaKbfyXFMQmSh3psyGpXYrvKSG8c5ZUAthpep
	 YZM6LAvl7j2Lgl6pytE3RCmARngLlNipOyV3xf4vphQJBndBwXD2Xe912KrSst9b9D
	 szpXLx0N6hkVw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>,  pratyush@kernel.org,
  jasonmiu@google.com,  graf@amazon.com,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
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
Subject: Re: [PATCH v6 15/20] mm: memfd_luo: allow preserving memfd
In-Reply-To: <CA+CK2bADcVsRnovkwWftPCbubXoaFrPzSavMU+G9f3XAz3YMLQ@mail.gmail.com>
	(Pasha Tatashin's message of "Wed, 19 Nov 2025 16:56:10 -0500")
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
	<20251115233409.768044-16-pasha.tatashin@soleen.com>
	<aRsBHy5aQ_Ypyy9r@kernel.org>
	<CA+CK2bADcVsRnovkwWftPCbubXoaFrPzSavMU+G9f3XAz3YMLQ@mail.gmail.com>
Date: Thu, 20 Nov 2025 16:34:45 +0100
Message-ID: <mafs0a50g3ega.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19 2025, Pasha Tatashin wrote:

> On Mon, Nov 17, 2025 at 6:04=E2=80=AFAM Mike Rapoport <rppt@kernel.org> w=
rote:
>>
>> On Sat, Nov 15, 2025 at 06:34:01PM -0500, Pasha Tatashin wrote:
>> > From: Pratyush Yadav <ptyadav@amazon.de>
>> >
>> > The ability to preserve a memfd allows userspace to use KHO and LUO to
>> > transfer its memory contents to the next kernel. This is useful in many
>> > ways. For one, it can be used with IOMMUFD as the backing store for
>> > IOMMU page tables. Preserving IOMMUFD is essential for performing a
>> > hypervisor live update with passthrough devices. memfd support provides
>> > the first building block for making that possible.
>> >
>> > For another, applications with a large amount of memory that takes time
>> > to reconstruct, reboots to consume kernel upgrades can be very
>> > expensive. memfd with LUO gives those applications reboot-persistent
>> > memory that they can use to quickly save and reconstruct that state.
>> >
>> > While memfd is backed by either hugetlbfs or shmem, currently only
>> > support on shmem is added. To be more precise, support for anonymous
>> > shmem files is added.
>> >
>> > The handover to the next kernel is not transparent. All the properties
>> > of the file are not preserved; only its memory contents, position, and
>> > size. The recreated file gets the UID and GID of the task doing the
>> > restore, and the task's cgroup gets charged with the memory.
>> >
>> > Once preserved, the file cannot grow or shrink, and all its pages are
>> > pinned to avoid migrations and swapping. The file can still be read fr=
om
>> > or written to.
>> >
>> > Use vmalloc to get the buffer to hold the folios, and preserve
>> > it using kho_preserve_vmalloc(). This doesn't have the size limit.
>> >
>> > Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> > Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
[...]
>> > +     struct inode *inode =3D file_inode(file);
>> > +     struct memfd_luo_folio_ser *pfolios;
>> > +     struct kho_vmalloc *kho_vmalloc;
>> > +     unsigned int max_folios;
>> > +     long i, size, nr_pinned;
>> > +     struct folio **folios;
>>
>> pfolios and folios read like the former is a pointer to latter.
>> I'd s/pfolios/folios_ser/

folios_ser is a tricky name, it is very close to folio_ser (which is
what you might use for one member of the array).

I was bit by this when hacking on some hugetlb preservation code. I
wrote folios_ser instead of folio_ser in a loop, and then had to spend
half an hour trying to figure out why the code wasn't working. It is
kinda hard to differentiate between the two visually.

Not that I have a better name off the top of my head. Just saying that
this naming causes weird readability problems.

>
> Done
>
[...]

--=20
Regards,
Pratyush Yadav

