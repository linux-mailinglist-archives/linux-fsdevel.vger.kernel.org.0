Return-Path: <linux-fsdevel+bounces-59663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B3CB3C2EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 21:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E25BA2294F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412501C84C7;
	Fri, 29 Aug 2025 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nazcQCXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90A23770D
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495138; cv=none; b=u+7C+/j+kKeZuV0ca8KHwopGMw+2G7jkecba+25E5gWoCfT8cQi77yLeh9NHr4sFtLn+cdAjrkUg1+qlopZGPBbAucvoGlFIrO50LdPIFQTkIhntmGtPp+KplppiqRDgMNoaz3FE2BunPp7BToj1dYoxpAh4ecKdNj8KuL21tM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495138; c=relaxed/simple;
	bh=SfwuYXV0KU6eJVhKE0IPfVFe3B6ROS9QbY1dk+JP8m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sExpqXLpBOMSK08XWl8E+BYKxxt+G0xZF6LJM65e5EDKU3/+y7FlZSj04Zx2KwCzdmkostk0RQso+Frh9CH5ykZrvLTaziPfEUJQTBer7xrGjiGJ2zmUWGcRQUc9FnJU1Sz85FN2FhtfdjUtAxg4pzHNa3W8LsYSin1Q0+DEhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nazcQCXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3280CC4CEFD
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756495138;
	bh=SfwuYXV0KU6eJVhKE0IPfVFe3B6ROS9QbY1dk+JP8m4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nazcQCXa/MpyKKiMxsTJjGljUR1Dz21D7DblWhL2HS/wzcyu82EzyUnv02QSgcLDM
	 MEP6BjElo2fLvkQUZl3oC2+XPwnnrwyWOJeztB1aB8gUVWHMmmemtcvea5bBbTxzNn
	 1ik8f2o6SbeW8NGCRUuplqiUox29olQd3jk3yKiM0Lz0i9i29JC6qBTYGYH93ov/0d
	 bnO5QcpEFwdF+XxXDWgqvWvXb5znA9IxmumJoeIofnMof/q4NgpVBIm45ga520ZdNX
	 OZQKxauuFgrtVxA3REt+wuQjbMNkRPpXTzqCqB44ulKsTzJjyDHdzqJKEx5Uzl68/D
	 6Z7ZJBOp16d3w==
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b72f7f606so5565e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 12:18:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvQgKOYIgc1jbHRV4zwZcQK62QwQZiGZrnJFco75LP/YNBK+k3cja4p48HCjPGgYi1ClsvZqyixPpDJUIq@vger.kernel.org
X-Gm-Message-State: AOJu0YyurSgMe5U6VHNte+oz2qR/BfZssBReL/rJZW92KH15azju3C6i
	GRvJ9qqAfZCdatwp/wS/wYquMgCBYHE9JEnQshDNFidpiK49TRafL9NtgSBceLb4+eZhFgI9nyx
	nYzu5fk9rm/QxUzFATYUp5tomE3I26yXXfjP6Jxd+
X-Google-Smtp-Source: AGHT+IGwYizH5N431wsmMZe4RCeN+XM22BnJRX3a9bmzFsCySK9GHB8zxV4r/939VLJDfuuUh2SvN3//dXotftQ5t5k=
X-Received: by 2002:a05:600c:a101:b0:45b:74f7:9d30 with SMTP id
 5b1f17b1804b1-45b84ae2495mr141155e9.1.1756495135682; Fri, 29 Aug 2025
 12:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250826162019.GD2130239@nvidia.com>
In-Reply-To: <20250826162019.GD2130239@nvidia.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 29 Aug 2025 12:18:43 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPaSQN04M-pvpFTjjpzk3pfHNhpx+mCkvWpZOs=0TF3gg@mail.gmail.com>
X-Gm-Features: Ac12FXwg_LGboIxDPBDuUZE0PAjtgg9g5mIDqFcbL5uMlL902h2DZN1Mi-6Fu0Y
Message-ID: <CAF8kJuPaSQN04M-pvpFTjjpzk3pfHNhpx+mCkvWpZOs=0TF3gg@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 9:20=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Aug 07, 2025 at 01:44:35AM +0000, Pasha Tatashin wrote:
>
> > +     /*
> > +      * Most of the space should be taken by preserved folios. So take=
 its
> > +      * size, plus a page for other properties.
> > +      */
> > +     fdt =3D memfd_luo_create_fdt(PAGE_ALIGN(preserved_size) + PAGE_SI=
ZE);
> > +     if (!fdt) {
> > +             err =3D -ENOMEM;
> > +             goto err_unpin;
> > +     }
>
> This doesn't seem to have any versioning scheme, it really should..
>
> > +     err =3D fdt_property_placeholder(fdt, "folios", preserved_size,
> > +                                    (void **)&preserved_folios);
> > +     if (err) {
> > +             pr_err("Failed to reserve folios property in FDT: %s\n",
> > +                    fdt_strerror(err));
> > +             err =3D -ENOMEM;
> > +             goto err_free_fdt;
> > +     }
>
> Yuk.
>
> This really wants some luo helper
>
> 'luo alloc array'
> 'luo restore array'
> 'luo free array'

Yes, that will be one step forward.

Another idea is that having a middle layer manages the life cycle of
the reserved memory for you. Kind of like a slab allocator for the
preserved memory. It allows bulk free if there is an error on the live
update prepare(), you need to free all previously allocated memory
anyway. If there is some preserved memory that needs to stay after a
long term after the live update kernel boot up, use some special flags
to indicate so don't mix the free_all pool.
>
> Which would get a linearized list of pages in the vmap to hold the
> array and then allocate some structure to record the page list and
> return back the u64 of the phys_addr of the top of the structure to
> store in whatever.
>
> Getting fdt to allocate the array inside the fds is just not going to
> work for anything of size.
>
> > +     for (; i < nr_pfolios; i++) {
> > +             const struct memfd_luo_preserved_folio *pfolio =3D &pfoli=
os[i];
> > +             phys_addr_t phys;
> > +             u64 index;
> > +             int flags;
> > +
> > +             if (!pfolio->foliodesc)
> > +                     continue;
> > +
> > +             phys =3D PFN_PHYS(PRESERVED_FOLIO_PFN(pfolio->foliodesc))=
;
> > +             folio =3D kho_restore_folio(phys);
> > +             if (!folio) {
> > +                     pr_err("Unable to restore folio at physical addre=
ss: %llx\n",
> > +                            phys);
> > +                     goto put_file;
> > +             }
> > +             index =3D pfolio->index;
> > +             flags =3D PRESERVED_FOLIO_FLAGS(pfolio->foliodesc);
> > +
> > +             /* Set up the folio for insertion. */
> > +             /*
> > +              * TODO: Should find a way to unify this and
> > +              * shmem_alloc_and_add_folio().
> > +              */
> > +             __folio_set_locked(folio);
> > +             __folio_set_swapbacked(folio);
> >
> > +             ret =3D mem_cgroup_charge(folio, NULL, mapping_gfp_mask(m=
apping));
> > +             if (ret) {
> > +                     pr_err("shmem: failed to charge folio index %d: %=
d\n",
> > +                            i, ret);
> > +                     goto unlock_folio;
> > +             }
>
> [..]
>
> > +             folio_add_lru(folio);
> > +             folio_unlock(folio);
> > +             folio_put(folio);
> > +     }
>
> Probably some consolidation will be needed to make this less
> duplicated..
>
> But overall I think just using the memfd_luo_preserved_folio as the
> serialization is entirely file, I don't think this needs anything more
> complicated.
>
> What it does need is an alternative to the FDT with versioning.
>
> Which seems to me to be entirely fine as:
>
>  struct memfd_luo_v0 {
>     __aligned_u64 size;
>     __aligned_u64 pos;
>     __aligned_u64 folios;
>  };
>
>  struct memfd_luo_v0 memfd_luo_v0 =3D {.size =3D size, pos =3D file->f_po=
s, folios =3D folios};
>  luo_store_object(&memfd_luo_v0, sizeof(memfd_luo_v0), <.. identifier for=
 this fd..>, /*version=3D*/0);
>
> Which also shows the actual data needing to be serialized comes from
> more than one struct and has to be marshaled in code, somehow, to a
> single struct.
>
> Then I imagine a fairly simple forwards/backwards story. If something
> new is needed that is non-optional, lets say you compress the folios
> list to optimize holes:
>
>  struct memfd_luo_v1 {
>     __aligned_u64 size;
>     __aligned_u64 pos;
>     __aligned_u64 folios_list_with_holes;
>  };
>
> Obviously a v0 kernel cannot parse this, but in this case a v1 aware
> kernel could optionally duplicate and write out the v0 format as well:
>
>  luo_store_object(&memfd_luo_v0, sizeof(memfd_luo_v0), <.. identifier for=
 this fd..>, /*version=3D*/0);
>  luo_store_object(&memfd_luo_v1, sizeof(memfd_luo_v1), <.. identifier for=
 this fd..>, /*version=3D*/1);

Question: Do we have a matching FDT node to match the memfd C
structure hierarchy? Otherwise all the C struct will lump into one FDT
node. Maybe one FDT node for all C struct is fine. Then there is a
risk of overflowing the 4K buffer limit on the FDT node.

I would like to get independent of FDT for the versioning.

FDT on the top level sounds OK. Not ideal but workable. We are getting
deeper and deeper into complex internal data structures. Do we still
want every data structure referenced by a FDT identifier?

> Then the rule is fairly simple, when the sucessor kernel goes to
> deserialize it asks luo for the versions it supports:
>
>  if (luo_restore_object(&memfd_luo_v1, sizeof(memfd_luo_v1), <.. identifi=
er for this fd..>, /*version=3D*/1))
>     restore_v1(&memfd_luo_v1)
>  else if (luo_restore_object(&memfd_luo_v0, sizeof(memfd_luo_v0), <.. ide=
ntifier for this fd..>, /*version=3D*/0))
>     restore_v0(&memfd_luo_v0)
>  else
>     luo_failure("Do not understand this");
>
> luo core just manages this list of versioned data per serialized
> object. There is only one version per object.

Obviously, this can be done.

Is that approach you want to expand to every other C struct as well?
See the above FDT node complexity.

I am getting the feeling that we are hand crafting screws to build an
airplane. Can it be done? Of course. Does it scale well? I am not
sure. There are many developers who are currently hand-crafting this
kind of screws to be used on the different components of the airplane.

We need a machine that can stamp out screws with our specifications,
faster. I want such a machine. Other developers might want one as
well.

The initial discussion of the idea of such a machine is pretty
discouraged. There are huge communication barriers because of the
fixation on hand crafted screws. I understand exploring such machine
ideas alone might distract the engineer from hand crafting more
screws, one of them might realize that, oh, I want such a machine as
well.

At this stage, do you see that exploring such a machine idea can be
beneficial or harmful to the project? If such an idea is considered
harmful, we should stop discussing such an idea at all. Go back to
building more batches of hand crafted screws, which are waiting by the
next critical component.

Also if such a machine can produce screws up to your specification,
but it has a different look and feel than the hand crafted screws. We
can stamp out the screw faster.  Would you consider putting such a
machined screw on your most critical component of the engine?

Best Regards,

Chris

