Return-Path: <linux-fsdevel+bounces-63511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2EBBBECDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 19:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A033BED51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC0F242D63;
	Mon,  6 Oct 2025 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OJrCUT8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4004123F42D
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771432; cv=none; b=uX3iVn9Ea/5cfYsIGdII+yvTqxO8dMJDt4eAK1Jax4O4V87P8hgHTE+3KmlcDQqs+R5ARg5owa0rbn2dk9GQkKBV+scJ9ltkE8UqRA6GQpvRzizOfdx1/S3ysLxMt9fAgQ8je+3wNHP1I34fFm9hTDGB0/rHVHPPj6SsTDocscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771432; c=relaxed/simple;
	bh=VCA8jFwiTolL3cm7GWMVLR0c56Cedh5z95+OPkLnavM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S30h2KrPo3uhAg6//+gEHNwLqJVnODVxBd3RHU83pRN/iLWkwOl+7SHTM/ZLT60iLV8/ivz9zA88TSb29KijlWrDiBB1ttWd0FnjNZQhBfwYSwF11QHlzXrs3U1xyTns/qKBqFf1r6ABcFOhqAOsLXf51upnKzDdCoHXZZg7OUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=OJrCUT8j; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-87808473c3bso683964385a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759771430; x=1760376230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiMWaxwcwGco8r+FHYAdZ8/rgwTBKI1DQmsAsIjVEPg=;
        b=OJrCUT8jQ1mNcnSR1NLmBIfqGdxpgHINYtabLRdjkMxkXPT6sGB7gIwQr1H9xNEona
         DiC5wbz9mf1rauL19afcY+exwSjOTA36/uAwUq7iW7rNU1KqrG4P86xc/I59vVvmrTkZ
         d14QO1XAbxvrlU2XyT2aPqmir6tqASQEM563cJAjxlwJifzUgk4dDxzXQmxd5N7AR+YR
         Ml0FipJxTKlKwnCRMppOupicEfx6Hr5Z8I9lNpxrRfz8bw1r3HC/vaXnR+1QW0k3Na1V
         MTeQkG7PrCLcQoD8JEPM9bkOWnkMoYom/DpuH+/VH8mYfgUxfx/CMPecfex4Tzcl9kRA
         8V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759771430; x=1760376230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiMWaxwcwGco8r+FHYAdZ8/rgwTBKI1DQmsAsIjVEPg=;
        b=iDJnuyVFulTDr+737mxiS2HAxvvdOayr/Up0Gkb5mu/wNID7JTkqOfqJnIh6lQiLH2
         GVN3qdrpl17g3pLE03CgAO0Pj03SbxdYjR6G5A3YheBSbKia4mMT26teZmg2FybgCOAo
         KbobZgweiboOyLVY1Aznivvaw4QS4nzkOMpjzxkZlerKNyhLtvCazctCm3ub2J+lsHSV
         G+zzDVyHZNFEs14bL1qvz5fCZxpJqHUD81EFafA/cOIoPBemRiFGFve5uORRUoPw0DGJ
         E29YfhPwlKBI5t8nAQcHGD7TbSltcxbFdVgy4jGybBCPbsme8IHkGOJJUOLEdrlnlJJ4
         f9ww==
X-Forwarded-Encrypted: i=1; AJvYcCUYVOQdAEXQh/pumkHzG59HqfhhfbHKRw6oLk69sdtRIGregnCMoPKFtG6ouyb2hYVjrPHdOw+FVR6R4/aY@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1iaOUWSguDx7Wp9deG1A0g0pWD1xvCfucRx/Yo/P4Z8bPn1R
	IzhEnVHSAeY/UXltsw/xi0FDl3EGT00JkPdVjrkgcG8WVKxzbs5ITNk7kPLMw/RhcUj+8d/xDrC
	5962GsOZHNHjV0kl11ik/3Qe6m70eQDxQEdd6AqLFlA==
X-Gm-Gg: ASbGnctlE1A8f9oOEACms0k8dkwWoHVxlisWjI5cuTTBCFVTRpRBPxtakVkQbpacVlM
	fQPGNrvJoHiWrzz8Lm1w4fZVwTD6Ef49cATYXL5BNFmT8GfeQODD/1fr6gG9wU/QOdfsQ2fiSub
	Z0XTtbidXndqlMf/9otfDWe1bzjvnZ5fRoDtO2GXWKjOaBHmvj6DoRt0xvpkBQ9bMndN2acUJae
	d3QL3lp7yd3ZDQmulKYgEa8qUvX/sPgjOgnxsg=
X-Google-Smtp-Source: AGHT+IFv/eQIGSPIMF5AtEJ9/NjM4NT3tDLx/ni0W3avlG1qBmkP6qV6SoLJbkqgHaLD5t7vOoviSBII4unw5QD/72E=
X-Received: by 2002:a05:620a:469e:b0:85e:5022:33a2 with SMTP id
 af79cd13be357-87a3a34d387mr1695495985a.39.1759771429425; Mon, 06 Oct 2025
 10:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-3-pasha.tatashin@soleen.com> <mafs0y0ponf6b.fsf@kernel.org>
In-Reply-To: <mafs0y0ponf6b.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 6 Oct 2025 13:23:11 -0400
X-Gm-Features: AS18NWCYmyLqK5As63FctOGJiEPF3B80wEZqrPZ_K5x_kzJeySLPd8Ta4rPXhIg
Message-ID: <CA+CK2bC0j=CbTNo=V-dceZEz9mji0yTWkE7QyUzvR1SRCiAJ=A@mail.gmail.com>
Subject: Re: [PATCH v4 02/30] kho: make debugfs interface optional
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

On Mon, Oct 6, 2025 at 12:55=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Hi Pasha,
>
> On Mon, Sep 29 2025, Pasha Tatashin wrote:
>
> > Currently, KHO is controlled via debugfs interface, but once LUO is
> > introduced, it can control KHO, and the debug interface becomes
> > optional.
> >
> > Add a separate config CONFIG_KEXEC_HANDOVER_DEBUG that enables
> > the debugfs interface, and allows to inspect the tree.
> >
> > Move all debugfs related code to a new file to keep the .c files
> > clear of ifdefs.
> >
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> [...]
> > @@ -662,36 +660,24 @@ static void __init kho_reserve_scratch(void)
> >       kho_enable =3D false;
> >  }
> >
> > -struct fdt_debugfs {
> > -     struct list_head list;
> > -     struct debugfs_blob_wrapper wrapper;
> > -     struct dentry *file;
> > +struct kho_out {
> > +     struct blocking_notifier_head chain_head;
> > +     struct mutex lock; /* protects KHO FDT finalization */
> > +     struct kho_serialization ser;
> > +     bool finalized;
> > +     struct kho_debugfs dbg;
> >  };
> >
> > -static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *=
dir,
> > -                            const char *name, const void *fdt)
> > -{
> > -     struct fdt_debugfs *f;
> > -     struct dentry *file;
> > -
> > -     f =3D kmalloc(sizeof(*f), GFP_KERNEL);
> > -     if (!f)
> > -             return -ENOMEM;
> > -
> > -     f->wrapper.data =3D (void *)fdt;
> > -     f->wrapper.size =3D fdt_totalsize(fdt);
> > -
> > -     file =3D debugfs_create_blob(name, 0400, dir, &f->wrapper);
> > -     if (IS_ERR(file)) {
> > -             kfree(f);
> > -             return PTR_ERR(file);
> > -     }
> > -
> > -     f->file =3D file;
> > -     list_add(&f->list, list);
> > -
> > -     return 0;
> > -}
> > +static struct kho_out kho_out =3D {
> > +     .chain_head =3D BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
> > +     .lock =3D __MUTEX_INITIALIZER(kho_out.lock),
> > +     .ser =3D {
> > +             .track =3D {
> > +                     .orders =3D XARRAY_INIT(kho_out.ser.track.orders,=
 0),
> > +             },
> > +     },
> > +     .finalized =3D false,
> > +};
>
> There is already one definition for struct kho_out and a static struct
> kho_out early in the file. This is a second declaration and definition.
> And I was super confused when I saw patch 3 since it seemed to be making
> unrelated changes to this struct (and removing an instance of this,
> which should be done in this patch instead). In fact, this patch doesn't
> even build due to this problem. I think some patch massaging is needed
> to fix this all up.

Let me fix it. I Plan to send a separate series only with KHO changes
from LUO, so we can expedite its landing.

Pasha

>
> >
> >  /**
> >   * kho_add_subtree - record the physical address of a sub FDT in KHO r=
oot tree.
> [...]
>
> --
> Regards,
> Pratyush Yadav

