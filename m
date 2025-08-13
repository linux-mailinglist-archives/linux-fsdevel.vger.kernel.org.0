Return-Path: <linux-fsdevel+bounces-57713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF6AB24B5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B264D5C02F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C359D1EA7DD;
	Wed, 13 Aug 2025 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnkAXrTO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA072E765B;
	Wed, 13 Aug 2025 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093332; cv=none; b=fSzv6hXI26GoNHM2kVsH4DoYb8ve3VV3uMWfMwGVPj8DFpNaSTmWxvauiiwNetzhtJN49bPckxPlijKXKwhqN8iPAJ+GH01YRdfqmXJWGfSkCovU8tOsEVvb1+UGPp5R8QfmH05M7Q/GCXBDhPuty/KWQdFPSElqbxS2rhTtuIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093332; c=relaxed/simple;
	bh=Z1FONCORgDMbbWMlyIGq1MppJNSEgOqZfpdQRbvLW+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gmOJFkQ5RVnz9qT08f3EeVciXyXgfsafdmTt3at45Sf2VU1TWGWkXG/oP1dsn6RDm2YTpjLRc/QvWElZfP1GMyDnP+Lw4Gm3blOQnbKPPs/q+44uvL9RZkTr0OZY/cmPtwlz/xlKwJtqnPXGYU9L7Bfo+3NW1uDI/xs+yzaZLT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnkAXrTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A15C4CEF6;
	Wed, 13 Aug 2025 13:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755093331;
	bh=Z1FONCORgDMbbWMlyIGq1MppJNSEgOqZfpdQRbvLW+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gnkAXrTOpFI3ROP15wctp09tBwFzwxci6h4Y8PgwuC2CQV+he2WTSZRR+FnjF9f1x
	 Pj07eQQVvToM6lkX1x/CDTozJVGPCLh8LDQ269n3k9lJmMdq4K3oPPOP/Dc7HCE2Fy
	 0Ly35zrERwLE+KC5jD9+Y7eZHFOkJnC0wYk7pnWzfyehBIuVpu3pfe/eA7fu4oMh+E
	 ZnmTH/cjAeavuoGSKKUP4jITmVsFPU5mprGHLDXDgE4BwnQRwHn1oglWjqJBsEeGbD
	 axkt0DApgFSBC+AYL/rPSXnMQBqqfKXKyW7pWJMvrcL2WijEfmbxTjFYH6Yf5JDvGD
	 5oB8EUJC2Qgzw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Vipin Sharma
 <vipinsh@google.com>,  jasonmiu@google.com,  graf@amazon.com,
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
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
In-Reply-To: <CA+CK2bCmQ3hY+ACnLrVZ1qwiTiVvxEBCDNFmAHn_uVRagvshhw@mail.gmail.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250813063407.GA3182745.vipinsh@google.com>
	<mafs0wm77wgjx.fsf@kernel.org>
	<CA+CK2bCmQ3hY+ACnLrVZ1qwiTiVvxEBCDNFmAHn_uVRagvshhw@mail.gmail.com>
Date: Wed, 13 Aug 2025 15:55:21 +0200
Message-ID: <mafs0tt2buy0m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13 2025, Pasha Tatashin wrote:

> On Wed, Aug 13, 2025 at 12:29=E2=80=AFPM Pratyush Yadav <pratyush@kernel.=
org> wrote:
>>
>> Hi Vipin,
>>
>> Thanks for the review.
>>
>> On Tue, Aug 12 2025, Vipin Sharma wrote:
>>
>> > On 2025-08-07 01:44:35, Pasha Tatashin wrote:
>> >> From: Pratyush Yadav <ptyadav@amazon.de>
>> >> +static void memfd_luo_unpreserve_folios(const struct memfd_luo_prese=
rved_folio *pfolios,
>> >> +                                    unsigned int nr_folios)
>> >> +{
>> >> +    unsigned int i;
>> >> +
>> >> +    for (i =3D 0; i < nr_folios; i++) {
>> >> +            const struct memfd_luo_preserved_folio *pfolio =3D &pfol=
ios[i];
>> >> +            struct folio *folio;
>> >> +
>> >> +            if (!pfolio->foliodesc)
>> >> +                    continue;
>> >> +
>> >> +            folio =3D pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodes=
c));
>> >> +
>> >> +            kho_unpreserve_folio(folio);
>> >
>> > This one is missing WARN_ON_ONCE() similar to the one in
>> > memfd_luo_preserve_folios().
>>
>> Right, will add.
>>
>> >
>> >> +            unpin_folio(folio);
>>
>> Looking at this code caught my eye. This can also be called from LUO's
>> finish callback if no one claimed the memfd after live update. In that
>> case, unpin_folio() is going to underflow the pincount or refcount on
>> the folio since after the kexec, the folio is no longer pinned. We
>> should only be doing folio_put().
>>
>> I think this function should take a argument to specify which of these
>> cases it is dealing with.
>>
>> >> +    }
>> >> +}
>> >> +
>> >> +static void *memfd_luo_create_fdt(unsigned long size)
>> >> +{
>> >> +    unsigned int order =3D get_order(size);
>> >> +    struct folio *fdt_folio;
>> >> +    int err =3D 0;
>> >> +    void *fdt;
>> >> +
>> >> +    if (order > MAX_PAGE_ORDER)
>> >> +            return NULL;
>> >> +
>> >> +    fdt_folio =3D folio_alloc(GFP_KERNEL, order);
>> >
>> > __GFP_ZERO should also be used here. Otherwise this can lead to
>> > unintentional passing of old kernel memory.
>>
>> fdt_create() zeroes out the buffer so this should not be a problem.
>
> You are right, fdt_create() zeroes the whole buffer, however, I wonder
> if it could be `optimized` to only clear only the header part of FDT,
> not the rest and this could potentially lead us to send an FDT buffer
> that contains both a valid FDT and the trailing bits contain data from
> old kernel.

Fair enough. At least the API documentation does not say anything about
the state of the buffer. My main concern was around performance since
the FDT can be multiple megabytes long for big memfds. Anyway, this
isn't in the blackout window so perhaps we can live with it. Will add
the GFP_ZERO.

--=20
Regards,
Pratyush Yadav

