Return-Path: <linux-fsdevel+bounces-70949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6ACAB1F5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 07 Dec 2025 07:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E7293097BBA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Dec 2025 06:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B51284B25;
	Sun,  7 Dec 2025 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDdBX+HG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C168E3D6F
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Dec 2025 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765088209; cv=none; b=YXcCV3ht8GNl/eDvqCGDy16ixOj11TQoz6ZyyLSFAXtnjH/Y2pA4a4ozT/sMCrTuQ/r95dyTFyst7t8E1Ro2hULPu6Mi9bezRY+9gia8j6sj5gFDabwplkKQvndOYHlx6hZV72pqjOiCl2L99X/egkl/niq/3lp7v7zvKq6NpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765088209; c=relaxed/simple;
	bh=Vf6nRuZPEba+Oifq2sGnvE2wxBWCAWdIIwjomCWz4yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TD8+gpBR2ccazljek7cpRuSE4ioMXSXvq2g6lOpiUqsGxKBI2T3KxQbtutfwUHaum3CDyAnUKG2mznciC2Os2HZPcVaaU3rxPUK1FrBsFLvvEgRlEUNHPBqT3wBilIrxkGnfWM7h5FrN0fAfC66ycc8ALmz7nKmxisr+tiX4ITQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDdBX+HG; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c6cc366884so1783421a34.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Dec 2025 22:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765088206; x=1765693006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Un5sUc5Cx47cq3O9cSCtpokOGHVUQEIffWJ4oCrfNps=;
        b=lDdBX+HGMAEKYE60gxbiMVUnBtKI/10NEoaBpGBYnl5C7k8NmQC995SmOoVEtC3MZ5
         PUfZHoKxQ3py/lTQpDS6EGov1KvXCee6LMSMmBLpZVZixE3DtUCZtaYfIRbNQaf4nlp8
         +Cya8PjYKgX/BN+V9zb1qdX38//qLkKHX5JdrKF/rFiwywU+fDb0zgUy2yq5AmqwlOQM
         uCZF/9ASqajNQsYgefovqw+I5H/U4aMT+K/oAISB0XvqD/FEJDZkWy9zOAEqkBGb2DRi
         t7kQ2X/5rDmy5vXqlLgWb8YficBxXH+c65t5+3Ay5UQ2kPTQoMhva1lq3JaexVpuMHIK
         4CPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765088206; x=1765693006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Un5sUc5Cx47cq3O9cSCtpokOGHVUQEIffWJ4oCrfNps=;
        b=XPnhJAWh3BAHFCXuBlmknC9qvV12uCOkWq6vL1q2BekYdGgA9n7z62oM/teEyTl4xw
         gsIUn9dUGL+1PVjGYU8HFTKzoMVzeC+Xqs9+XwbOO6sJ90aA0xBLvQntwN2BM6NwWzcf
         qYPjjDB9zOcNbZzicHOykOOyxUTA+hGwjtMFxeSYiSd92KCS9QIHUa7ix+spDQSdPi4p
         V65p1a7rUfK6TKvFu4rYf6JfJVzeM2wuGaEEpRoiZDqVtftQ8qWPt3K6N7+m8iQoWrN1
         /9hfezqNBixL3Zvvn3s69fKmuKzV98qRldqGxsTP+UNjp8TF4r0mDgjG7RRp6QxCI+OC
         nSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvLx7kKDGsr1W4ESS02FKFpX7Lay3rrlrBZ+bADY3tS7JX/mZSaKaLlIQ9kUzmGhFyCbu619cslOha+qNI@vger.kernel.org
X-Gm-Message-State: AOJu0YzScjgT7som4/VYyYyCT8IJ3vV0tRRUBwcHUhtHR+Linv9Vgb3m
	QFZc1XDcYSeMD5c/pJtAJI3ild3TZRrtlsklLfn3VbtpMqRImSxtpX4Pg7521DaIOSDYd7ddsQl
	T5ZSQWGtQDuJGMG4Bru2M3w6MsC9gsY8=
X-Gm-Gg: ASbGncvvZTR7TV0/duHznhObCLU99heJGwW969CKhChnW79Xy4QSYQTDx++6x9RVJt4
	uhZV4X3D8XZ3fh8fCs5fMvtztI2D0opukPkXRRjYPBUgZuihDNHRR7LhugX9zvM1w0OJFGo2Szh
	Yj5uAYulcHiI+pCtnrGd/a0XalyC+bzrTuxXrTVULZOhNkYWeA6FxjgvPdbiCEighSlXSiw8tr9
	8wMp9FHewW3dTn46kUu1KAoHn9dRy/99Ekdoaq/50sOIusiIZqyV2ScZBRZTbO4nuyPiqZO
X-Google-Smtp-Source: AGHT+IGTU11em87jeAo6kbD6dSOQffzi00PVFHQ+kjvwjKAEFHYJNasF5rV2kwcoj4CItjdfPWuUhV4Bdq+BX91kfOI=
X-Received: by 2002:a05:6830:3153:b0:7c7:5385:9ac2 with SMTP id
 46e09a7af769-7c97078be65mr3441356a34.8.1765088205704; Sat, 06 Dec 2025
 22:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205005841.3942668-1-avagin@google.com> <20251205005841.3942668-2-avagin@google.com>
 <25cac682-e6a5-4ab2-bae2-fb4df2d33626@huaweicloud.com>
In-Reply-To: <25cac682-e6a5-4ab2-bae2-fb4df2d33626@huaweicloud.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Sat, 6 Dec 2025 22:16:34 -0800
X-Gm-Features: AQt7F2p7RekYLuKI-hKafG4DE8Ti31OsLl4BdXgEl5swhlVsRR3s_ZW5SSZKSRw
Message-ID: <CANaxB-w+j89zVRpwVErT8JdrmKZqw+D7ANZBzk2pA2WCj75XPA@mail.gmail.com>
Subject: Re: [PATCH 1/3] cgroup, binfmt_elf: Add hwcap masks to the misc controller
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	criu@lists.linux.dev, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 2:11=E2=80=AFAM Chen Ridong <chenridong@huaweicloud.=
com> wrote:
>
>
>
> On 2025/12/5 8:58, Andrei Vagin wrote:
> > Add an interface to the misc cgroup controller that allows masking out
> > hardware capabilities (AT_HWCAP) reported to user-space processes. This
> > provides a mechanism to restrict the features a containerized
> > application can see.
> >
> > The new "misc.mask" cgroup file allows users to specify masks for
> > AT_HWCAP, AT_HWCAP2, AT_HWCAP3, and AT_HWCAP4.
> >
> > The output of "misc.mask" is extended to display the effective mask,
> > which is a combination of the masks from the current cgroup and all its
> > ancestors.
> >
> > Signed-off-by: Andrei Vagin <avagin@google.com>
> > ---
> >  fs/binfmt_elf.c             |  24 +++++--
> >  include/linux/misc_cgroup.h |  25 +++++++
> >  kernel/cgroup/misc.c        | 126 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 171 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 3eb734c192e9..59137784e81d 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -47,6 +47,7 @@
> >  #include <linux/dax.h>
> >  #include <linux/uaccess.h>
> >  #include <uapi/linux/rseq.h>
> > +#include <linux/misc_cgroup.h>
> >  #include <asm/param.h>
> >  #include <asm/page.h>
> >
> > @@ -182,6 +183,21 @@ create_elf_tables(struct linux_binprm *bprm, const=
 struct elfhdr *exec,
> >       int ei_index;
> >       const struct cred *cred =3D current_cred();
> >       struct vm_area_struct *vma;
> > +     struct misc_cg *misc_cg;
> > +     u64 hwcap_mask[4] =3D {0, 0, 0, 0};
> > +
> > +     misc_cg =3D get_current_misc_cg();
> > +     misc_cg_get_mask(MISC_CG_MASK_HWCAP, misc_cg, &hwcap_mask[0]);
> > +#ifdef ELF_HWCAP2
> > +     misc_cg_get_mask(MISC_CG_MASK_HWCAP2, misc_cg, &hwcap_mask[1]);
> > +#endif
> > +#ifdef ELF_HWCAP3
> > +     misc_cg_get_mask(MISC_CG_MASK_HWCAP3, misc_cg, &hwcap_mask[2]);
> > +#endif
> > +#ifdef ELF_HWCAP4
> > +     misc_cg_get_mask(MISC_CG_MASK_HWCAP4, misc_cg, &hwcap_mask[3]);
> > +#endif
> > +     put_misc_cg(misc_cg);
> >
> >       /*
> >        * In some cases (e.g. Hyper-Threading), we want to avoid L1
> > @@ -246,7 +262,7 @@ create_elf_tables(struct linux_binprm *bprm, const =
struct elfhdr *exec,
> >        */
> >       ARCH_DLINFO;
> >  #endif
> > -     NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
> > +     NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP & ~hwcap_mask[0]);
> >       NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
> >       NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
> >       NEW_AUX_ENT(AT_PHDR, phdr_addr);
> > @@ -264,13 +280,13 @@ create_elf_tables(struct linux_binprm *bprm, cons=
t struct elfhdr *exec,
> >       NEW_AUX_ENT(AT_SECURE, bprm->secureexec);
> >       NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
> >  #ifdef ELF_HWCAP2
> > -     NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
> > +     NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2 & ~hwcap_mask[1]);
> >  #endif
> >  #ifdef ELF_HWCAP3
> > -     NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3);
> > +     NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3 & ~hwcap_mask[2]);
> >  #endif
> >  #ifdef ELF_HWCAP4
> > -     NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4);
> > +     NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4 & ~hwcap_mask[3]);
> >  #endif
> >       NEW_AUX_ENT(AT_EXECFN, bprm->exec);
> >       if (k_platform) {
> > diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> > index 0cb36a3ffc47..cff830c238fb 100644
> > --- a/include/linux/misc_cgroup.h
> > +++ b/include/linux/misc_cgroup.h
> > @@ -8,6 +8,8 @@
> >  #ifndef _MISC_CGROUP_H_
> >  #define _MISC_CGROUP_H_
> >
> > +#include <linux/elf.h>
> > +
> >  /**
> >   * enum misc_res_type - Types of misc cgroup entries supported by the =
host.
> >   */
> > @@ -26,6 +28,20 @@ enum misc_res_type {
> >       MISC_CG_RES_TYPES
> >  };
> >
> > +enum misc_mask_type {
> > +     MISC_CG_MASK_HWCAP,
> > +#ifdef ELF_HWCAP2
> > +     MISC_CG_MASK_HWCAP2,
> > +#endif
> > +#ifdef ELF_HWCAP3
> > +     MISC_CG_MASK_HWCAP3,
> > +#endif
> > +#ifdef ELF_HWCAP4
> > +     MISC_CG_MASK_HWCAP4,
> > +#endif
> > +     MISC_CG_MASK_TYPES
> > +};
> > +
> >  struct misc_cg;
> >
> >  #ifdef CONFIG_CGROUP_MISC
> > @@ -62,12 +78,15 @@ struct misc_cg {
> >       struct cgroup_file events_local_file;
> >
> >       struct misc_res res[MISC_CG_RES_TYPES];
> > +     u64 mask[MISC_CG_MASK_TYPES];
> >  };
> >
> >  int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
> >  int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u6=
4 amount);
> >  void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64=
 amount);
> >
> > +int misc_cg_get_mask(enum misc_mask_type type, struct misc_cg *cg, u64=
 *pmask);
> > +
> >  /**
> >   * css_misc() - Get misc cgroup from the css.
> >   * @css: cgroup subsys state object.
> > @@ -134,5 +153,11 @@ static inline void put_misc_cg(struct misc_cg *cg)
> >  {
> >  }
> >
> > +static inline int misc_cg_get_mask(enum misc_mask_type type, struct mi=
sc_cg *cg, u64 *pmask)
> > +{
> > +     *pmask =3D 0;
> > +     return 0;
> > +}
> > +
> >  #endif /* CONFIG_CGROUP_MISC */
> >  #endif /* _MISC_CGROUP_H_ */
> > diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> > index 6a01d91ea4cb..d1386d86060f 100644
> > --- a/kernel/cgroup/misc.c
> > +++ b/kernel/cgroup/misc.c
> > @@ -30,6 +30,19 @@ static const char *const misc_res_name[] =3D {
> >  #endif
> >  };
> >
> > +static const char *const misc_mask_name[] =3D {
> > +     "AT_HWCAP",
> > +#ifdef ELF_HWCAP2
> > +     "AT_HWCAP2",
> > +#endif
> > +#ifdef ELF_HWCAP3
> > +     "AT_HWCAP3",
> > +#endif
> > +#ifdef ELF_HWCAP4
> > +     "AT_HWCAP4",
> > +#endif
> > +};
> > +
> >  /* Root misc cgroup */
> >  static struct misc_cg root_cg;
> >
> > @@ -71,6 +84,11 @@ static inline bool valid_type(enum misc_res_type typ=
e)
> >       return type >=3D 0 && type < MISC_CG_RES_TYPES;
> >  }
> >
> > +static inline bool valid_mask_type(enum misc_mask_type type)
> > +{
> > +     return type >=3D 0 && type < MISC_CG_MASK_TYPES;
> > +}
> > +
> >  /**
> >   * misc_cg_set_capacity() - Set the capacity of the misc cgroup res.
> >   * @type: Type of the misc res.
> > @@ -391,6 +409,109 @@ static int misc_events_local_show(struct seq_file=
 *sf, void *v)
> >       return __misc_events_show(sf, true);
> >  }
> >
> > +/**
> > + * misc_cg_get_mask() - Get the mask of the specified type.
> > + * @type: The misc mask type.
> > + * @cg: The misc cgroup.
> > + * @pmask: Pointer to the resulting mask.
> > + *
> > + * This function calculates the effective mask for a given cgroup by w=
alking up
> > + * the hierarchy and ORing the masks from all parent cgroupfs. The fin=
al result
> > + * is stored in the location pointed to by @pmask.
> > + *
> > + * Context: Any context.
> > + * Return: 0 on success, -EINVAL if @type is invalid.
> > + */
> > +int misc_cg_get_mask(enum misc_mask_type type, struct misc_cg *cg, u64=
 *pmask)
> > +{
> > +     struct misc_cg *i;
> > +     u64 mask =3D 0;
> > +
> > +     if (!(valid_mask_type(type)))
> > +             return -EINVAL;
> > +
> > +     for (i =3D cg; i; i =3D parent_misc(i))
> > +             mask |=3D READ_ONCE(i->mask[type]);
> > +
> > +     *pmask =3D mask;
> > +     return 0;
> > +}
> > +
> > +/**
> > + * misc_cg_mask_show() - Show the misc cgroup masks.
> > + * @sf: Interface file
> > + * @v: Arguments passed
> > + *
> > + * Context: Any context.
> > + * Return: 0 to denote successful print.
> > + */
> > +static int misc_cg_mask_show(struct seq_file *sf, void *v)
> > +{
> > +     struct misc_cg *cg =3D css_misc(seq_css(sf));
> > +     int i;
> > +
> > +     for (i =3D 0; i < MISC_CG_MASK_TYPES; i++) {
> > +             u64 rval, val =3D READ_ONCE(cg->mask[i]);
> > +
> > +             misc_cg_get_mask(i, cg, &rval);
> > +             seq_printf(sf, "%s\t%#016llx\t%#016llx\n", misc_mask_name=
[i], val, rval);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
>
> I'm concerned about the performance impact of the bottom-up traversal in =
deeply nested cgroup
> hierarchies. Could this approach introduce noticeable latency in such sce=
narios?
>

I wrote an execve benchmark to measure the impact of this change
(https://github.com/avagin/execve_vs_misccg).

The benchmark results are as follows:

depth | before (ops/sec)| after (ops/sec)| ratio %| perf
------------------------------------------------------
0     | 4813.06 =C2=B1 11.01 | 4826.78 =C2=B1 19.33| 100.28 |
2     | 4752.75 =C2=B1 11.28 | 4754.38 =C2=B1 21.93| 100.03 |
4     | 4767.41 =C2=B1 8.35  | 4729.81 =C2=B1 29.56|  99.21 |
8     | 4768.01 =C2=B1 10.42 | 4745.23 =C2=B1 27.68|  99.52 |
16    | 4749.34 =C2=B1 21.03 | 4723.63 =C2=B1 23.57|  99.45 |
32    | 4758.67 =C2=B1 10.94 | 4728.49 =C2=B1 13.9 |  99.36 |
64    | 4749.85 =C2=B1 12.33 | 4686.3  =C2=B1 13.06|  98.66 | 0.11%
128   | 4707.22 =C2=B1 12.01 | 4668.22 =C2=B1 16.9 |  99.17 | 0.33%
256   | 4725.75 =C2=B1 6.07  | 4629.09 =C2=B1 27.02|  97.95 | 1.61%

Columns:
* depth: The nesting level of the cgroup.
* before: without this patch.
* after: with this patch applied.
* ratio: performance of after relative to before.
* perf: profiling data from perf showing execution time spent in the
        misc_cg_get_mask function.

The performance impact is almost negligible for cgroup depths up to 64.
Even at a depth of 128, the overhead is less than 1%.

Thanks,
Andrei

