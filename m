Return-Path: <linux-fsdevel+bounces-63549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F01BC17EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 15:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40D8D4E2CE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446732E0B58;
	Tue,  7 Oct 2025 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfq10qwA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8AC8E6;
	Tue,  7 Oct 2025 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843824; cv=none; b=sFqMozaSIgs9Qk9ToAkj+5HzjLFLH30PIpcm7wVme1Le+U4OZkXtn4MRNtjKqpr0cXuun+U0BahGrYcSDF1sBrHbu+YlD9BVeDADZb/QM0v36lN+DepfNZuGwH1XxVLKYsSDVj/a3ACMcOoCo8M50eS9xS+vjG8gql0BAlxyP60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843824; c=relaxed/simple;
	bh=a+hLMRZ89lMMfohnZj5rrKyndKWksZlfn0//bNtRnv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jHft47049a6RP88NlVEwrSNMSAtDqI7cGGfvcXWAxZl39PbCgIcGnxMvyieHPxA1zJWcr//6DSL1GDAL5vdVJqagKnPsFtBh7zU/djQ0WEIh9kT6Kj80Ci2XvkccaIHkh4tGCoEam7Do6u9ffXMqKC4rza3RAMDr8uiO8jm017s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfq10qwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92074C4CEF1;
	Tue,  7 Oct 2025 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759843824;
	bh=a+hLMRZ89lMMfohnZj5rrKyndKWksZlfn0//bNtRnv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jfq10qwAPMrOKPp2UWn6SkGdeFAYE0GUabtMligJY3wVU7Aq8Vpaig+nucTfu4Ajc
	 2ZCWUllTifw2PXGTtyHvi0afbUzDzKw/xEMI/Q8cFAwORA+B8jPmQ9V7pxjNOq9ctl
	 5JPz7CoVYIKtFXHWaamduBxbDeVM1quhrxSUpII69Yno07vmItODHPdyJ7qSIdWWHs
	 SILxDRyD+XXt0fsILH398D4Gz7J+B0xg4U7oABmaICYhXnaroMvkJQGGd6lY22XFQn
	 JzXBXN9OevTrIdhHUH1Bhdhv5w8wAKiTNGOxeYy9nUDUor5zr1ITtH9MlNKTsS0c6d
	 psfRTjxGAHJ6g==
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
Subject: Re: [PATCH v4 03/30] kho: drop notifiers
In-Reply-To: <CA+CK2bCFsPZQQQ0JFErnYt=dbzBx=ZJdV+eNXYWyNUE+xk7=yA@mail.gmail.com>
	(Pasha Tatashin's message of "Tue, 7 Oct 2025 09:16:24 -0400")
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
	<20250929010321.3462457-4-pasha.tatashin@soleen.com>
	<mafs0tt0cnevi.fsf@kernel.org>
	<CA+CK2bA2qfLF1Mbyvnat+L9+5KAw6LnhYETXVoYcMGJxwTGahg@mail.gmail.com>
	<mafs0playoqui.fsf@kernel.org>
	<CA+CK2bCFsPZQQQ0JFErnYt=dbzBx=ZJdV+eNXYWyNUE+xk7=yA@mail.gmail.com>
Date: Tue, 07 Oct 2025 15:30:13 +0200
Message-ID: <mafs0a522on4q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07 2025, Pasha Tatashin wrote:

> On Tue, Oct 7, 2025 at 8:10=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>>
>> On Mon, Oct 06 2025, Pasha Tatashin wrote:
>>
>> > On Mon, Oct 6, 2025 at 1:01=E2=80=AFPM Pratyush Yadav <pratyush@kernel=
.org> wrote:
>> >>
>> >> On Mon, Sep 29 2025, Pasha Tatashin wrote:
>> >>
>> >> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >> >
>> >> > The KHO framework uses a notifier chain as the mechanism for client=
s to
>> >> > participate in the finalization process. While this works for a sin=
gle,
>> >> > central state machine, it is too restrictive for kernel-internal
>> >> > components like pstore/reserve_mem or IMA. These components need a
>> >> > simpler, direct way to register their state for preservation (e.g.,
>> >> > during their initcall) without being part of a complex,
>> >> > shutdown-time notifier sequence. The notifier model forces all
>> >> > participants into a single finalization flow and makes direct
>> >> > preservation from an arbitrary context difficult.
>> >> > This patch refactors the client participation model by removing the
>> >> > notifier chain and introducing a direct API for managing FDT subtre=
es.
>> >> >
>> >> > The core kho_finalize() and kho_abort() state machine remains, but
>> >> > clients now register their data with KHO beforehand.
>> >> >
>> >> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> >> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> >> [...]
>> >> > diff --git a/mm/memblock.c b/mm/memblock.c
>> >> > index e23e16618e9b..c4b2d4e4c715 100644
>> >> > --- a/mm/memblock.c
>> >> > +++ b/mm/memblock.c
>> >> > @@ -2444,53 +2444,18 @@ int reserve_mem_release_by_name(const char =
*name)
>> >> >  #define MEMBLOCK_KHO_FDT "memblock"
>> >> >  #define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
>> >> >  #define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
>> >> > -static struct page *kho_fdt;
>> >> > -
>> >> > -static int reserve_mem_kho_finalize(struct kho_serialization *ser)
>> >> > -{
>> >> > -     int err =3D 0, i;
>> >> > -
>> >> > -     for (i =3D 0; i < reserved_mem_count; i++) {
>> >> > -             struct reserve_mem_table *map =3D &reserved_mem_table=
[i];
>> >> > -             struct page *page =3D phys_to_page(map->start);
>> >> > -             unsigned int nr_pages =3D map->size >> PAGE_SHIFT;
>> >> > -
>> >> > -             err |=3D kho_preserve_pages(page, nr_pages);
>> >> > -     }
>> >> > -
>> >> > -     err |=3D kho_preserve_folio(page_folio(kho_fdt));
>> >> > -     err |=3D kho_add_subtree(ser, MEMBLOCK_KHO_FDT, page_to_virt(=
kho_fdt));
>> >> > -
>> >> > -     return notifier_from_errno(err);
>> >> > -}
>> >> > -
>> >> > -static int reserve_mem_kho_notifier(struct notifier_block *self,
>> >> > -                                 unsigned long cmd, void *v)
>> >> > -{
>> >> > -     switch (cmd) {
>> >> > -     case KEXEC_KHO_FINALIZE:
>> >> > -             return reserve_mem_kho_finalize((struct kho_serializa=
tion *)v);
>> >> > -     case KEXEC_KHO_ABORT:
>> >> > -             return NOTIFY_DONE;
>> >> > -     default:
>> >> > -             return NOTIFY_BAD;
>> >> > -     }
>> >> > -}
>> >> > -
>> >> > -static struct notifier_block reserve_mem_kho_nb =3D {
>> >> > -     .notifier_call =3D reserve_mem_kho_notifier,
>> >> > -};
>> >> >
>> >> >  static int __init prepare_kho_fdt(void)
>> >> >  {
>> >> >       int err =3D 0, i;
>> >> > +     struct page *fdt_page;
>> >> >       void *fdt;
>> >> >
>> >> > -     kho_fdt =3D alloc_page(GFP_KERNEL);
>> >> > -     if (!kho_fdt)
>> >> > +     fdt_page =3D alloc_page(GFP_KERNEL);
>> >> > +     if (!fdt_page)
>> >> >               return -ENOMEM;
>> >> >
>> >> > -     fdt =3D page_to_virt(kho_fdt);
>> >> > +     fdt =3D page_to_virt(fdt_page);
>> >> >
>> >> >       err |=3D fdt_create(fdt, PAGE_SIZE);
>> >> >       err |=3D fdt_finish_reservemap(fdt);
>> >> > @@ -2499,7 +2464,10 @@ static int __init prepare_kho_fdt(void)
>> >> >       err |=3D fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_=
NODE_COMPATIBLE);
>> >> >       for (i =3D 0; i < reserved_mem_count; i++) {
>> >> >               struct reserve_mem_table *map =3D &reserved_mem_table=
[i];
>> >> > +             struct page *page =3D phys_to_page(map->start);
>> >> > +             unsigned int nr_pages =3D map->size >> PAGE_SHIFT;
>> >> >
>> >> > +             err |=3D kho_preserve_pages(page, nr_pages);
>> >> >               err |=3D fdt_begin_node(fdt, map->name);
>> >> >               err |=3D fdt_property_string(fdt, "compatible", RESER=
VE_MEM_KHO_NODE_COMPATIBLE);
>> >> >               err |=3D fdt_property(fdt, "start", &map->start, size=
of(map->start));
>> >> > @@ -2507,13 +2475,14 @@ static int __init prepare_kho_fdt(void)
>> >> >               err |=3D fdt_end_node(fdt);
>> >> >       }
>> >> >       err |=3D fdt_end_node(fdt);
>> >> > -
>> >> >       err |=3D fdt_finish(fdt);
>> >> >
>> >> > +     err |=3D kho_preserve_folio(page_folio(fdt_page));
>> >> > +     err |=3D kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
>> >> > +
>> >> >       if (err) {
>> >> >               pr_err("failed to prepare memblock FDT for KHO: %d\n"=
, err);
>> >> > -             put_page(kho_fdt);
>> >> > -             kho_fdt =3D NULL;
>> >> > +             put_page(fdt_page);
>> >>
>> >> This adds subtree to KHO even if the FDT might be invalid. And then
>> >> leaves a dangling reference in KHO to the FDT in case of an error. I
>> >> think you should either do this check after
>> >> kho_preserve_folio(page_folio(fdt_page)) and do a clean error check f=
or
>> >> kho_add_subtree(), or call kho_remove_subtree() in the error block.
>> >
>> > I agree, I do not like these err |=3D stuff, we should be checking
>> > errors cleanly, and do proper clean-ups.
>>
>> Yeah, this is mainly a byproduct of using FDTs. Getting and setting
>> simple properties also needs error checking and that can get tedious
>> real quick. Which is why this pattern has shown up I suppose.
>
> Exactly. This is also why it's important to replace FDT with something
> more sensible for general-purpose live update purposes.
>
> By the way, I forgot to address this comment in the v5 of the KHO
> series I sent out yesterday. Could you please take another look? If
> everything else is good, I will refresh that series so we can ask
> Andrew to take in the KHO patches. That would simplify the LUO series.

Good idea. Will take a look.

[...]

--=20
Regards,
Pratyush Yadav

