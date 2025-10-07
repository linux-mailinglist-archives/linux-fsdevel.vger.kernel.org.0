Return-Path: <linux-fsdevel+bounces-63548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C721EBC1761
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 15:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F3EE4F60C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A5B2E0B77;
	Tue,  7 Oct 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VjCjB/Fp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E842E0B68
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843024; cv=none; b=oiqm3JH7FFcjnZWVMi4iSOL4VQR+nXnZI/2mfRBPMuyNDi5dOXVAaKcjGGk6cdaW/c8lc5krQW6Hz7sAYylDVgq4vcGwZULoSzDyol/Yfg/ifBXKe2EOJgJU/dK5to9PNaBuo4+qQrVjZCsIXJJxW3mljBEe/Qa+vKZFh0G1byU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843024; c=relaxed/simple;
	bh=MFighuuXS4QKwYx1I+/cx6ZSbuJFS6E69cqe5MTzL8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4qgqMlDMUaWBoHyAdWdau9j7eEwnnI/CznP79NNJ5inx58fa2xh/NYka3iVhyDe+hhkhcLJRAtYdR4XjV69h+Df7AoAr0Hxixg/2RaNeqN/P+66Ysp3s2Xt2P2zmrTGlKnEH5y+SqT1B6owNjjmkFlh+QC6hIbcx/O3Gmy3ZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VjCjB/Fp; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e0302e2b69so104010321cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759843022; x=1760447822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGjQstuXxCbXjkgmEtho3zqtbBjdkL7MGqcvpT6Dbac=;
        b=VjCjB/FpyHbRDXfmNszZ92E5SW0WUp8+bg3G7cxR8sAokXm3pvdeTZQWqnaUKsHoeq
         F5T8yKFocj8vu1kP267vZVRI/Cp41vTk7pakrltfVXOwnlLV+WkUuOxrL5V/SPvgnF8V
         Cl6Cb//m9JrVx9wvBWqvhrzD/KSPAoPy8KTWhNg1RA5KFThVlsApddApjivBcFqMtbtM
         +F0g0i6UvvRgFi1BPb0PrwtEyS3LH4qY6df6BxwIlqcqRt0vhy41khEsITefknvdzNT7
         R8mHV4unuxuKm4xGcXGHjwcPsu88fuULYoS9u/XFGnezpkAb6TinLOrjWl3QiIHVnyb1
         udiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843022; x=1760447822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGjQstuXxCbXjkgmEtho3zqtbBjdkL7MGqcvpT6Dbac=;
        b=huAizFUmpjvzTUQ0F9CoJZIZ3UdCXNVyFT1QAVhWC/ysctjBVHq8zO0ACQz2rTVPOY
         bxdOMQ4WI0tD6xvFVsjLn/FyvOu3YargW+6EXKLhXDmVw4/Ets1WyJsbQMl1DjjbEVnq
         ZpfcsOOIZJo5DVUiKjN7ZSwWlaJ8ja4TpSgwdC31IyMU8iOW31fdA3RrweY5azs34Fw7
         pozUWWDqlBB1WyDBFucMnMywEsQwDbnd9nybDR4x6jmigde5ymI4RfPwr5Mlrn6qg1KW
         djsdamO3Bg7veK9ij8ZA7LhKcDc5z5i6Qu2Fk/FmfKwVEEeJEuUWINnGJyN80d0emXwb
         d59g==
X-Forwarded-Encrypted: i=1; AJvYcCUEety7dwMyqFXoBFmFs0XLT2jNkuZrolUmkxHkebGeaz68pWacoJ7irPWNTB9YPyZ/4Wq9zk3xDztQp5YI@vger.kernel.org
X-Gm-Message-State: AOJu0YxKncoYXF3qrn5mc+upc0TmUvP/oVhKaKv5tX35BZB5x8SfU5Ui
	scdDoNW5SqvHigJf+e7wYe3T/1TMLJlANJCpv4rxK/TFxSlNQqBrD4MMLLs/D5tWaNuP8Poxg9y
	DdGsnujRNKXd1ZW6HLHp/juDmQhQjcFqTO/9JjO8tBg==
X-Gm-Gg: ASbGncuMOBLy2IfNTmFjfATBnK8AKeVbjtBDP53GcxklI+gLg+x6NBCP3Afm5eila34
	Iek3loKPvJJgu4o/KWP40ilZ4Vlsc1RfDDTe95tUnM8iw9okF0JoKSx81U4ItzZmI6jKdrj4jyv
	+W0CFMOC5N/9IGDcfzD+nJ3QBuq2K6qDDHuV2QYnXWhT36OMB2U24ZFEOWLOmQ25gf01FcscAzs
	fE21XT+48gw+Kg1LVFL0AtHfTxo
X-Google-Smtp-Source: AGHT+IErTOfhbVekCCdPxxpICEbrbhOaEM1jbyw9u/DzKXn3hm20NW7yY7Ebv6K5iiS95Vkga4m4uus70RCOVSYZKBk=
X-Received: by 2002:a05:622a:5884:b0:4dd:8dcc:17f5 with SMTP id
 d75a77b69052e-4e576a569b0mr225293361cf.28.1759843021454; Tue, 07 Oct 2025
 06:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-4-pasha.tatashin@soleen.com> <mafs0tt0cnevi.fsf@kernel.org>
 <CA+CK2bA2qfLF1Mbyvnat+L9+5KAw6LnhYETXVoYcMGJxwTGahg@mail.gmail.com> <mafs0playoqui.fsf@kernel.org>
In-Reply-To: <mafs0playoqui.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 7 Oct 2025 09:16:24 -0400
X-Gm-Features: AS18NWCRhwYsguwzm1bh0CindcVLAn8z07AreURWfMoXFjhjQmI0qWqW1QxWkf8
Message-ID: <CA+CK2bCFsPZQQQ0JFErnYt=dbzBx=ZJdV+eNXYWyNUE+xk7=yA@mail.gmail.com>
Subject: Re: [PATCH v4 03/30] kho: drop notifiers
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, changyuanl@google.com, 
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 8:10=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Mon, Oct 06 2025, Pasha Tatashin wrote:
>
> > On Mon, Oct 6, 2025 at 1:01=E2=80=AFPM Pratyush Yadav <pratyush@kernel.=
org> wrote:
> >>
> >> On Mon, Sep 29 2025, Pasha Tatashin wrote:
> >>
> >> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >> >
> >> > The KHO framework uses a notifier chain as the mechanism for clients=
 to
> >> > participate in the finalization process. While this works for a sing=
le,
> >> > central state machine, it is too restrictive for kernel-internal
> >> > components like pstore/reserve_mem or IMA. These components need a
> >> > simpler, direct way to register their state for preservation (e.g.,
> >> > during their initcall) without being part of a complex,
> >> > shutdown-time notifier sequence. The notifier model forces all
> >> > participants into a single finalization flow and makes direct
> >> > preservation from an arbitrary context difficult.
> >> > This patch refactors the client participation model by removing the
> >> > notifier chain and introducing a direct API for managing FDT subtree=
s.
> >> >
> >> > The core kho_finalize() and kho_abort() state machine remains, but
> >> > clients now register their data with KHO beforehand.
> >> >
> >> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> >> [...]
> >> > diff --git a/mm/memblock.c b/mm/memblock.c
> >> > index e23e16618e9b..c4b2d4e4c715 100644
> >> > --- a/mm/memblock.c
> >> > +++ b/mm/memblock.c
> >> > @@ -2444,53 +2444,18 @@ int reserve_mem_release_by_name(const char *=
name)
> >> >  #define MEMBLOCK_KHO_FDT "memblock"
> >> >  #define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
> >> >  #define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
> >> > -static struct page *kho_fdt;
> >> > -
> >> > -static int reserve_mem_kho_finalize(struct kho_serialization *ser)
> >> > -{
> >> > -     int err =3D 0, i;
> >> > -
> >> > -     for (i =3D 0; i < reserved_mem_count; i++) {
> >> > -             struct reserve_mem_table *map =3D &reserved_mem_table[=
i];
> >> > -             struct page *page =3D phys_to_page(map->start);
> >> > -             unsigned int nr_pages =3D map->size >> PAGE_SHIFT;
> >> > -
> >> > -             err |=3D kho_preserve_pages(page, nr_pages);
> >> > -     }
> >> > -
> >> > -     err |=3D kho_preserve_folio(page_folio(kho_fdt));
> >> > -     err |=3D kho_add_subtree(ser, MEMBLOCK_KHO_FDT, page_to_virt(k=
ho_fdt));
> >> > -
> >> > -     return notifier_from_errno(err);
> >> > -}
> >> > -
> >> > -static int reserve_mem_kho_notifier(struct notifier_block *self,
> >> > -                                 unsigned long cmd, void *v)
> >> > -{
> >> > -     switch (cmd) {
> >> > -     case KEXEC_KHO_FINALIZE:
> >> > -             return reserve_mem_kho_finalize((struct kho_serializat=
ion *)v);
> >> > -     case KEXEC_KHO_ABORT:
> >> > -             return NOTIFY_DONE;
> >> > -     default:
> >> > -             return NOTIFY_BAD;
> >> > -     }
> >> > -}
> >> > -
> >> > -static struct notifier_block reserve_mem_kho_nb =3D {
> >> > -     .notifier_call =3D reserve_mem_kho_notifier,
> >> > -};
> >> >
> >> >  static int __init prepare_kho_fdt(void)
> >> >  {
> >> >       int err =3D 0, i;
> >> > +     struct page *fdt_page;
> >> >       void *fdt;
> >> >
> >> > -     kho_fdt =3D alloc_page(GFP_KERNEL);
> >> > -     if (!kho_fdt)
> >> > +     fdt_page =3D alloc_page(GFP_KERNEL);
> >> > +     if (!fdt_page)
> >> >               return -ENOMEM;
> >> >
> >> > -     fdt =3D page_to_virt(kho_fdt);
> >> > +     fdt =3D page_to_virt(fdt_page);
> >> >
> >> >       err |=3D fdt_create(fdt, PAGE_SIZE);
> >> >       err |=3D fdt_finish_reservemap(fdt);
> >> > @@ -2499,7 +2464,10 @@ static int __init prepare_kho_fdt(void)
> >> >       err |=3D fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_N=
ODE_COMPATIBLE);
> >> >       for (i =3D 0; i < reserved_mem_count; i++) {
> >> >               struct reserve_mem_table *map =3D &reserved_mem_table[=
i];
> >> > +             struct page *page =3D phys_to_page(map->start);
> >> > +             unsigned int nr_pages =3D map->size >> PAGE_SHIFT;
> >> >
> >> > +             err |=3D kho_preserve_pages(page, nr_pages);
> >> >               err |=3D fdt_begin_node(fdt, map->name);
> >> >               err |=3D fdt_property_string(fdt, "compatible", RESERV=
E_MEM_KHO_NODE_COMPATIBLE);
> >> >               err |=3D fdt_property(fdt, "start", &map->start, sizeo=
f(map->start));
> >> > @@ -2507,13 +2475,14 @@ static int __init prepare_kho_fdt(void)
> >> >               err |=3D fdt_end_node(fdt);
> >> >       }
> >> >       err |=3D fdt_end_node(fdt);
> >> > -
> >> >       err |=3D fdt_finish(fdt);
> >> >
> >> > +     err |=3D kho_preserve_folio(page_folio(fdt_page));
> >> > +     err |=3D kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
> >> > +
> >> >       if (err) {
> >> >               pr_err("failed to prepare memblock FDT for KHO: %d\n",=
 err);
> >> > -             put_page(kho_fdt);
> >> > -             kho_fdt =3D NULL;
> >> > +             put_page(fdt_page);
> >>
> >> This adds subtree to KHO even if the FDT might be invalid. And then
> >> leaves a dangling reference in KHO to the FDT in case of an error. I
> >> think you should either do this check after
> >> kho_preserve_folio(page_folio(fdt_page)) and do a clean error check fo=
r
> >> kho_add_subtree(), or call kho_remove_subtree() in the error block.
> >
> > I agree, I do not like these err |=3D stuff, we should be checking
> > errors cleanly, and do proper clean-ups.
>
> Yeah, this is mainly a byproduct of using FDTs. Getting and setting
> simple properties also needs error checking and that can get tedious
> real quick. Which is why this pattern has shown up I suppose.

Exactly. This is also why it's important to replace FDT with something
more sensible for general-purpose live update purposes.

By the way, I forgot to address this comment in the v5 of the KHO
series I sent out yesterday. Could you please take another look? If
everything else is good, I will refresh that series so we can ask
Andrew to take in the KHO patches. That would simplify the LUO series.

Pasha

>
> >
> >> I prefer the former since if kho_add_subtree() is the one that fails,
> >> there is little sense in removing a subtree that was never added.
> >>
> >> >       }
> >> >
> >> >       return err;
> >> > @@ -2529,13 +2498,6 @@ static int __init reserve_mem_init(void)
> >> >       err =3D prepare_kho_fdt();
> >> >       if (err)
> >> >               return err;
> >> > -
> >> > -     err =3D register_kho_notifier(&reserve_mem_kho_nb);
> >> > -     if (err) {
> >> > -             put_page(kho_fdt);
> >> > -             kho_fdt =3D NULL;
> >> > -     }
> >> > -
> >> >       return err;
> >> >  }
> >> >  late_initcall(reserve_mem_init);
> >>
> >> --
> >> Regards,
> >> Pratyush Yadav
>
> --
> Regards,
> Pratyush Yadav

