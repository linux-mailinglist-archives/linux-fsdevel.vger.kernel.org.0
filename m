Return-Path: <linux-fsdevel+bounces-59899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB87B3ED4F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 19:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DB1188C026
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A435320A1B;
	Mon,  1 Sep 2025 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9dmzbN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9A2E6CD1;
	Mon,  1 Sep 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747303; cv=none; b=LY+gILH+444j/5FkwYZo1n67HOSinpA0NQl4l3WB1vKKI8+cv/s75f/fAYvjaTdDkcq4hAnNrDaAe8h4pP7bsSJPrsPglqO2/byfuv3igZpXyEClvRUvW4s/8Sj0liBUQf+BLwbpW4LTagnqIKtgnynpq3KnIqBoWZcGrGoO+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747303; c=relaxed/simple;
	bh=3mhC2/T1c6Z+vgeTqGwgs2Xmkym2DVFtNGG4o+LNDHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CFTn+nf5k8ItswTJ2AnfouYhj+P8klXiCKkr3MNUjcTu37BKz4N2rqJjKDnrGRekbqEY+cW95AU6Ny/QxcmO1mFbpC/4Xkd+IdqAXjaJIpDDa6iQWj6e5nme+35hQM8gBMK4hTPeCwARXQapOW5qwyVc21RL4Kk8LZpwGlYSSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9dmzbN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6769C4CEF0;
	Mon,  1 Sep 2025 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756747303;
	bh=3mhC2/T1c6Z+vgeTqGwgs2Xmkym2DVFtNGG4o+LNDHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=T9dmzbN3vJLJmQDq1Re5bzl8OxpzTbtxHyo9VrZ09/exjPs4/S/UQ/qjokktB5xH0
	 SSAhxDYKrSqviNam9PJfJyWLgwI4zqdg3I1711MwPV/OjBcVgO1pnXEGeXz3WuK0Xv
	 UVuAAVWCHK9DEEZHqKg20aHU8P+mQKhAhInpwws4Klng0iRivbKWCQXm3KK6C52Kus
	 igQubipBz8w3WOXaDSc+DURspm2666u/anhAH4CayF+VNK79UQd6Dcbo23j5PKLmkc
	 7e7Mzu21+so4+IDhVLL5kTXhZiCBHk37Mq4vGWxsegGW2R/VeQMTHWMDaNdZO+jGo4
	 NR5zsktrqL/VA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Jason Gunthorpe <jgg@nvidia.com>,
  pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  changyuanl@google.com,  dmatlack@google.com,  rientjes@google.com,
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
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
In-Reply-To: <CA+CK2bC96fxHBb78DvNhyfdjsDfPCLY5J5cN8W0hUDt9KAPBJQ@mail.gmail.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250826162019.GD2130239@nvidia.com> <aLXIcUwt0HVzRpYW@kernel.org>
	<CA+CK2bC96fxHBb78DvNhyfdjsDfPCLY5J5cN8W0hUDt9KAPBJQ@mail.gmail.com>
Date: Mon, 01 Sep 2025 19:21:31 +0200
Message-ID: <mafs03496w0kk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Pasha,

On Mon, Sep 01 2025, Pasha Tatashin wrote:

> On Mon, Sep 1, 2025 at 4:23=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wr=
ote:
>>
>> On Tue, Aug 26, 2025 at 01:20:19PM -0300, Jason Gunthorpe wrote:
>> > On Thu, Aug 07, 2025 at 01:44:35AM +0000, Pasha Tatashin wrote:
>> >
>> > > +   /*
>> > > +    * Most of the space should be taken by preserved folios. So tak=
e its
>> > > +    * size, plus a page for other properties.
>> > > +    */
>> > > +   fdt =3D memfd_luo_create_fdt(PAGE_ALIGN(preserved_size) + PAGE_S=
IZE);
>> > > +   if (!fdt) {
>> > > +           err =3D -ENOMEM;
>> > > +           goto err_unpin;
>> > > +   }
>> >
>> > This doesn't seem to have any versioning scheme, it really should..
>> >
>> > > +   err =3D fdt_property_placeholder(fdt, "folios", preserved_size,
>> > > +                                  (void **)&preserved_folios);
>> > > +   if (err) {
>> > > +           pr_err("Failed to reserve folios property in FDT: %s\n",
>> > > +                  fdt_strerror(err));
>> > > +           err =3D -ENOMEM;
>> > > +           goto err_free_fdt;
>> > > +   }
>> >
>> > Yuk.
>> >
>> > This really wants some luo helper
>> >
>> > 'luo alloc array'
>> > 'luo restore array'
>> > 'luo free array'
>>
>> We can just add kho_{preserve,restore}_vmalloc(). I've drafted it here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=3D=
kho/vmalloc/v1
>
> The patch looks okay to me, but it doesn't support holes in vmap
> areas. While that is likely acceptable for vmalloc, it could be a
> problem if we want to preserve memfd with holes and using vmap
> preservation as a method, which would require a different approach.
> Still, this would help with preserving memfd.

I agree. I think we should do it the other way round. Build a sparse
array first, and then use that to build vmap preservation. Our emails
seem to have crossed, but see my reply to Mike [0] that describes my
idea a bit more, along with WIP code.

[0] https://lore.kernel.org/lkml/mafs0ldmyw1hp.fsf@kernel.org/

>
> However, I wonder if we should add a separate preservation library on
> top of the kho and not as part of kho (or at least keep them in a
> separate file from core logic). This would allow us to preserve more
> advanced data structures such as this and define preservation version
> control, similar to Jason's store_object/restore_object proposal.

This is how I have done it in my code: created a separate file called
kho_array.c. If we have enough such data structures, we can probably
move it under kernel/liveupdate/lib/.

As for the store_object/restore_object proposal: see an alternate idea
at [1].

[1] https://lore.kernel.org/lkml/mafs0h5xmw12a.fsf@kernel.org/

--=20
Regards,
Pratyush Yadav

