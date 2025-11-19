Return-Path: <linux-fsdevel+bounces-69150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6645BC71341
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 22:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1E1F52BC37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 21:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5B330BBB6;
	Wed, 19 Nov 2025 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BKkJUaQ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B9130ACED
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763589411; cv=none; b=sBKSOPCuIWuQBre52w0a6mX3anZSiGRaCtElXRwBrl3aHjwbtbczUrs4YiZdQAg43WEkT+L9APnWqPSHh1f94r/3tPPwFFr4ozp24KPKvXsIEy6TKup98JLO5ZuJ6F46eoWT8eoI4pUMpujYws1yIR/9Ck12Jra3dU+pRikqeQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763589411; c=relaxed/simple;
	bh=i0u8LZ3aaYfvsLZbvUV+TzVs9K3+rQ8JzEPutleCOFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZP5ufTW0XgBQEdM8tUemKZQFn1nOoWrRk4Q7P/449zZfBZcIHXglvqvF0HKXUrSFy5ws3UygRcp+zDQwU4d1BJWpFv1apINKRSHtD866B4H6WdDUJhYyfG7wg2t0xfmjS1Um9lNvW3cEsDuV7wYQdLwgLI3ROm+X03pXLgbaiJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=BKkJUaQ9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so258809a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 13:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763589408; x=1764194208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNCgiEwH4yoLxLSeabt8BIXDk+2v90qbq38QcBVyYpw=;
        b=BKkJUaQ9aOKG62XBaw9bwJZL2qD4ZfgVW/VtrgSokPGG42Bv0szJGCMUMc2Xk/2VGw
         u3/kIo9ZoUwTtAenHUCHWX9q72Y+I2ItqJXP773Las8YZGSmnSyyqG5FLTNHxeY9TvwH
         YdFLtbbODZMr8If0U7MPfz1wpn4Ft2li81G08K8IDKY0UqhNpXiyXBygReUEtJdmyBqG
         taVTGzcPi0ZMMB0gSi/SRgXxkKtkNOcVk6ztrdn7HWig973bIPQ+NraSVtehsZFj0JJS
         u9Qz+OGPt92EbY6sibQebv/ODCNgjYZTfnl+oRFaKNbybV4v3h+QM9hZ1hoW84h/AlxE
         qCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763589408; x=1764194208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GNCgiEwH4yoLxLSeabt8BIXDk+2v90qbq38QcBVyYpw=;
        b=GAfMYtatQQEBuPOv+aBLkHnpYdsVgz+DbcpyRTWTU/RVqjDIycHxZelnN85RC8ZX+O
         qI15eOlqu2ChJlOWk8eK2/O28R+rmziRiCCs0ey+sfT+oTJnB1MpMHsRL3aWqbP4uNe4
         HQa5B2vdQpH8RlmRNYoeUUBWSWBv33d3MHHT8sqEcDP4yFrpBMhbODcn8yuTRvptO7UH
         GKauor6Z9+2o8hLciJPzzE2qqKbe/jfV9lnzpUrLz7Xs7aZf0j+1QoINKe+QzEbVMv5q
         YmuCDHrhiLG/EYOjOBJO9k0xE/4OJ47uKikShhfv9G7m3sMNt0wvBhopPl5OWZ3/sU+k
         1ojA==
X-Forwarded-Encrypted: i=1; AJvYcCVp5ZHxp4TzU6oWYqjLQERnTpna0cnBwjvMcMdiYmt5j015DdxE6AX7mNV64IcStd0ZyonLJcrtqgUdTkjR@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDZ5ktUAPuuaS3DwPU3ZPnLS7dsj+zBwuNafUl+mqxBTAty7I
	8I3na3dmNUOO6CbBgiAUVos2TU/ENO/w1slXIHKvx3fp/fWEcEGsf1LliMM2NVd3DeFIWS/bkX4
	Dtv0p+OLDSuOq4jiQDuSHExRSThCe0QsptZ8OYaL1ZA==
X-Gm-Gg: ASbGncuG5C4vmt8w2uDRyqR1N0RhqrNpSXJMwAxEIRlk9kzApRTyU3dWek+kawq79Z8
	2s7C837K9r3+vxUkKrIiFuop9PGXz9+1/OxYEhsrWKEyYtk2IPjsYGpISGMFYm11g8hzTGVNld9
	nSqSSVF70GyujQ3sih089QN4qni98ZUnLj6pbXobWTc80CTQHTdVPtJqTmLgZvcEAQIy6lFcpEj
	V/OyRc4UkM0tYxM6MsT48U/0aAtm5/R1HO9bJY3Qv3frIRxmwmP+u/nGlKVCrbFJrAdnVsTSrOx
	rBY=
X-Google-Smtp-Source: AGHT+IFLyS+wG0rWTlTQxvo48mFxi5vli+cxPH15GpPZdhy+X8F56gfcnoxRYXFwUVFltbkM5G+J1V5jBE1mGtvRoNo=
X-Received: by 2002:a05:6402:27cc:b0:643:8301:d107 with SMTP id
 4fb4d7f45d1cf-645364828ddmr742149a12.30.1763589407434; Wed, 19 Nov 2025
 13:56:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-16-pasha.tatashin@soleen.com> <aRsBHy5aQ_Ypyy9r@kernel.org>
In-Reply-To: <aRsBHy5aQ_Ypyy9r@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 19 Nov 2025 16:56:10 -0500
X-Gm-Features: AWmQ_bkST9g5qeVKeHrDii74Rowe2_O-kbr5Wx0FA7LJaDDxeXF38UaoBxVWMYo
Message-ID: <CA+CK2bADcVsRnovkwWftPCbubXoaFrPzSavMU+G9f3XAz3YMLQ@mail.gmail.com>
Subject: Re: [PATCH v6 15/20] mm: memfd_luo: allow preserving memfd
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
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
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 6:04=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 15, 2025 at 06:34:01PM -0500, Pasha Tatashin wrote:
> > From: Pratyush Yadav <ptyadav@amazon.de>
> >
> > The ability to preserve a memfd allows userspace to use KHO and LUO to
> > transfer its memory contents to the next kernel. This is useful in many
> > ways. For one, it can be used with IOMMUFD as the backing store for
> > IOMMU page tables. Preserving IOMMUFD is essential for performing a
> > hypervisor live update with passthrough devices. memfd support provides
> > the first building block for making that possible.
> >
> > For another, applications with a large amount of memory that takes time
> > to reconstruct, reboots to consume kernel upgrades can be very
> > expensive. memfd with LUO gives those applications reboot-persistent
> > memory that they can use to quickly save and reconstruct that state.
> >
> > While memfd is backed by either hugetlbfs or shmem, currently only
> > support on shmem is added. To be more precise, support for anonymous
> > shmem files is added.
> >
> > The handover to the next kernel is not transparent. All the properties
> > of the file are not preserved; only its memory contents, position, and
> > size. The recreated file gets the UID and GID of the task doing the
> > restore, and the task's cgroup gets charged with the memory.
> >
> > Once preserved, the file cannot grow or shrink, and all its pages are
> > pinned to avoid migrations and swapping. The file can still be read fro=
m
> > or written to.
> >
> > Use vmalloc to get the buffer to hold the folios, and preserve
> > it using kho_preserve_vmalloc(). This doesn't have the size limit.
> >
> > Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
>
> The order of signed-offs seems wrong, Pasha's should be the last one.

Updated.


> > + * This interface is a contract. Any modification to the FDT structure=
,
> > + * node properties, compatible string, or the layout of the serializat=
ion
> > + * structures defined here constitutes a breaking change. Such changes=
 require
> > + * incrementing the version number in the MEMFD_LUO_FH_COMPATIBLE stri=
ng.
>
> The same comment about contract as for the generic LUO documentation
> applies here (https://lore.kernel.org/all/aRnG8wDSSAtkEI_z@kernel.org/)

Added.

>
> > + *
> > + * FDT Structure Overview:
> > + *   The memfd state is contained within a single FDT with the followi=
ng layout:
>
> ...
>
> > +static struct memfd_luo_folio_ser *memfd_luo_preserve_folios(struct fi=
le *file, void *fdt,
> > +                                                          u64 *nr_foli=
osp)
> > +{
>
> If we are already returning nr_folios by reference, we might do it for
> memfd_luo_folio_ser as well and make the function return int.

Done

>
> > +     struct inode *inode =3D file_inode(file);
> > +     struct memfd_luo_folio_ser *pfolios;
> > +     struct kho_vmalloc *kho_vmalloc;
> > +     unsigned int max_folios;
> > +     long i, size, nr_pinned;
> > +     struct folio **folios;
>
> pfolios and folios read like the former is a pointer to latter.
> I'd s/pfolios/folios_ser/

Done

> > +     int err =3D -EINVAL;
> > +     pgoff_t offset;
> > +     u64 nr_folios;
>
> ...
>
> > +     kvfree(folios);
> > +     *nr_foliosp =3D nr_folios;
> > +     return pfolios;
> > +
> > +err_unpreserve:
> > +     i--;
> > +     for (; i >=3D 0; i--)
>
> Maybe a single line
>
>         for (--i; i >=3D 0; --i)

Done, but wrote it as:
for (i =3D i - 1; i >=3D 0; i--)
Which looks a little cleaner to me.

>
> > +             kho_unpreserve_folio(folios[i]);
> > +     vfree(pfolios);
> > +err_unpin:
> > +     unpin_folios(folios, nr_folios);
> > +err_free_folios:
> > +     kvfree(folios);
> > +     return ERR_PTR(err);
> > +}
> > +
> > +static void memfd_luo_unpreserve_folios(void *fdt, struct memfd_luo_fo=
lio_ser *pfolios,
> > +                                     u64 nr_folios)
> > +{
> > +     struct kho_vmalloc *kho_vmalloc;
> > +     long i;
> > +
> > +     if (!nr_folios)
> > +             return;
> > +
> > +     kho_vmalloc =3D (struct kho_vmalloc *)fdt_getprop(fdt, 0, MEMFD_F=
DT_FOLIOS, NULL);
> > +     /* The FDT was created by this kernel so expect it to be sane. */
> > +     WARN_ON_ONCE(!kho_vmalloc);
>
> The FDT won't have FOLIOS property if size was zero, will it?
> I think that if we add kho_vmalloc handle to struct memfd_luo_private and
> pass that around it will make things easier and simpler.

I am actually thinking of removing FDTs and using versioned struct directly=
.

>
> > +     kho_unpreserve_vmalloc(kho_vmalloc);
> > +
> > +     for (i =3D 0; i < nr_folios; i++) {
> > +             const struct memfd_luo_folio_ser *pfolio =3D &pfolios[i];
> > +             struct folio *folio;
> > +
> > +             if (!pfolio->foliodesc)
> > +                     continue;
>
> How can this happen? Can pfolios be a sparse array?

With the current implementation of memfd_pin_folios, which populates
holes, this array will be dense. This check is defensive coding in
case we switch to a sparse preservation mechanism in the future. I
will add a comment, and add a warn_on_once.

>
> > +             folio =3D pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc=
));
> > +
> > +             kho_unpreserve_folio(folio);
> > +             unpin_folio(folio);
> > +     }
> > +
> > +     vfree(pfolios);
> > +}
>
> ...
>
> > +static void memfd_luo_finish(struct liveupdate_file_op_args *args)
> > +{
> > +     const struct memfd_luo_folio_ser *pfolios;
> > +     struct folio *fdt_folio;
> > +     const void *fdt;
> > +     u64 nr_folios;
> > +
> > +     if (args->retrieved)
> > +             return;
> > +
> > +     fdt_folio =3D memfd_luo_get_fdt(args->serialized_data);
> > +     if (!fdt_folio) {
> > +             pr_err("failed to restore memfd FDT\n");
> > +             return;
> > +     }
> > +
> > +     fdt =3D folio_address(fdt_folio);
> > +
> > +     pfolios =3D memfd_luo_fdt_folios(fdt, &nr_folios);
> > +     if (!pfolios)
> > +             goto out;
> > +
> > +     memfd_luo_discard_folios(pfolios, nr_folios);
>
> Does not this free the actual folios that were supposed to be preserved?

It does, when memfd was not reclaimed.

>
> > +     vfree(pfolios);
> > +
> > +out:
> > +     folio_put(fdt_folio);
> > +}
>
> ...
>
> > +static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
> > +{
> > +     struct folio *fdt_folio;
> > +     const u64 *pos, *size;
> > +     struct file *file;
> > +     int len, ret =3D 0;
> > +     const void *fdt;
> > +
> > +     fdt_folio =3D memfd_luo_get_fdt(args->serialized_data);
>
> Why do we need to kho_restore_folio() twice? Here and in
> memfd_luo_finish()?

Here we retrieve memfd and give it to userspace. In finish, discard
whatever was not reclaimed.

>
> > +     if (!fdt_folio)
> > +             return -ENOENT;
> > +
> > +     fdt =3D page_to_virt(folio_page(fdt_folio, 0));
>
> folio_address()

Done

>

>
> --
> Sincerely yours,
> Mike.

