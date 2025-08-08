Return-Path: <linux-fsdevel+bounces-57051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7040B1E601
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 11:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA786218E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BBC27144C;
	Fri,  8 Aug 2025 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhtAcMSM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4354B2701CA;
	Fri,  8 Aug 2025 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646926; cv=none; b=V121mqV53zeeouCXNaatysxkvh2Ku9wDdDZ9yWXMC7JU0dw7HXH+oIQaIHFF24HWYR0m+hbwdMClw4F2K5Dr8bqGcjoNj/M7AFSF9rNHhrEf4wHhh8AFB5hjyobuPYAVZOzPd3BVgP6429TRnHt6NiA8vbTqAaCsbNMSBDT/1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646926; c=relaxed/simple;
	bh=4AaWxFG6AsC8E5O7NCayo4nqeqnXtZRa4VzNIQrAomk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEBN5RhOlPGm2Q4Nd4w416YoHEZFP1+LQMsfvQzrc09XvrDWoMWleX+urr55Mw8c4Ja97477qElw8bUDzV1uXXKDh2OccW9PnT01NMjQiKjbPwnDIL7YwONSS1DAvM+Yw+uFPiqVbhkAlaluQKzNLAKNq9u5y8U2qRJ1v4ySa4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhtAcMSM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6b7so2216938a12.2;
        Fri, 08 Aug 2025 02:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754646922; x=1755251722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gVyN2sYyvIbMubxKS3JcPctfUbylo1d4bg4gjum0mA=;
        b=BhtAcMSMSej4K+w2CKCM7iHqjZIvKyjXFbUVRUgYRrvu6GWqzqFwFo3FdWkplak3df
         Bdhx7aMDr0l29ndSfcBtIZCEJPzdnR/Ge7oYjVGTFoKROKf6KViorhRsx8iTGmawMZW3
         FwCS2q6wiV/mC0B4duzFO/Tzm2aMdQoena4ndY70OaxxmAiEawUIxcUs7aPauEpYbnFl
         oUtICPbP6wi20mPzpGnkcGSnNESPUpYabi6JDDzOM/UEzsqCHGGJAEksXYhApvKB68xv
         2uuIMInL2kOJh+ZPocz7WolMAQdgehZW405HCbpTUhQlQ02nDOzPv39G/D2wi8Tk2bt8
         srOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754646922; x=1755251722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gVyN2sYyvIbMubxKS3JcPctfUbylo1d4bg4gjum0mA=;
        b=wjC8aFURnDuvqAFgvNcNDuC+v8e8qHZfJr0MqrCQ5DA8Kr+vvFZPPdxD2/DqflAxXm
         7c4cDVlvtlxbbRvxEe/dV5SKR8bX/LMoEo/ZR+oRLYrFCUq2VEFe9Yu/SSlxlTMMed1r
         zOfSPJq0MPuvEpRiPhcD1dVscOqf3CDB32RiZUtvwoO3K3XM7Ek1I4WE0XYtPQyy6Mrv
         1zyxBbR8/tMN3BaprjGerkJjYBW7YhWcVBvj40GWjpWbpPfsJACewmScdgdp5xuw3I0l
         +N85wmVYnWz35cdHMyRn3ybRfPBLoUxx4IKnlAk22BLhT1lXjjcehLEhwmG33DGGHxuZ
         C1uA==
X-Forwarded-Encrypted: i=1; AJvYcCWBJ4CNF+4qWD6yQMYrD0RLBVeGJnf3j5JkOjUhxBUCIx2Z7JpguF2wqAYHLrYLRvDgkymgqWsCcg8r+789@vger.kernel.org, AJvYcCWojv/FQVcVkycMK/sPMB8Nv3ryerQGHZ+1J3VuK/zGOJOmmu0CQCty5aoi7NUi7rOSNnT6Jt3eraXe2Rki@vger.kernel.org
X-Gm-Message-State: AOJu0YwYKeB7TMB+53l4smqOaIaWkygwVxKJf7nTlRqm51/LZhBRg47K
	kCY8yH6+tmFvJSQm8EO6pAMYAfbcnH72WeyjUr/HLpjBReHLJjlO60hFu0+RLgVtyslH558Fgav
	r+S8Jle9Iy4zz70/q1YYQDqznwSJ4gcg=
X-Gm-Gg: ASbGncucRjmT8oPLG4nkVJv1ugrhNOSVtSca0VBfi/5g5b3Q+yGlmnBcrnRkVmoh5Qu
	h867isqWw5iftoRNR+z8cEdkLqTay8WwHjAaUjdlSUdjafmRKVR943kkXqrdYA9o0xCZEATSs7Q
	YAGWc8dhfLu/24IqsLzd8y1t6NVw9ubIj3cKr9Kk7TUfpAc4leQM6bFmPeKfhAZnjj42G665CdX
	loOFko=
X-Google-Smtp-Source: AGHT+IERtYRuCE8GvGMvTAUP+ozyqZNBw0qRDxtV1TXjgKtNn12ZnGoI6ofmNPEDUzIo5/IhEjob56lKvjcNhGQOtGw=
X-Received: by 2002:a17:907:3f99:b0:af9:38ed:5b49 with SMTP id
 a640c23a62f3a-af9c634e57amr214702566b.5.1754646922274; Fri, 08 Aug 2025
 02:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87bjorle20.fsf@wotan.olymp> <20250807124909.781-1-luochunsheng@ustc.edu>
In-Reply-To: <20250807124909.781-1-luochunsheng@ustc.edu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 Aug 2025 11:55:11 +0200
X-Gm-Features: Ac12FXwWykeoGxt8R9iCtSnf5eBnFNiEdq9FM7LoM8l67HZ_v-x-B9zvQDweU0w
Message-ID: <CAOQ4uxho4_3-Ue=QSngdsgQQNSA9VbAZw6wP=+U3xoc2jx3dcg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Move same-superblock check to fuse_copy_file_range
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: luis@igalia.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 2:49=E2=80=AFPM Chunsheng Luo <luochunsheng@ustc.edu=
> wrote:
>
> On Thu, Aug 07 2025,  Luis Henriques wrote:
>
> >> The copy_file_range COPY_FILE_SPLICE capability allows filesystems to
> >> handle cross-superblock copy. However, in the current fuse implementat=
ion,
> >> __fuse_copy_file_range accesses src_file->private_data under the assum=
ption
> >> that it points to a fuse_file structure. When the source file belongs =
to a
> >> non-FUSE filesystem, it will leads to kernel panics.
> >
> > I wonder if you have actually seen this kernel panic happening.  It see=
ms
> > like the code you're moving into fuse_copy_file_range() shouldn't be
> > needed as the same check is already done in generic_copy_file_checks()
> > (which is called from vfs_copy_file_range()).
> >
> > Either way, I think your change to fuse_copy_file_range() could be
> > simplified with something like:
> >
> >       ssize_t ret =3D -EXDEV;
> >
> >       if (file_inode(src_file)->i_sb =3D=3D file_inode(dst_file)->i_sb)
> >               ret =3D __fuse_copy_file_range(src_file, src_off, dst_fil=
e, dst_off,
> >                                            len, flags);
> >
> >       if (ret =3D=3D -EOPNOTSUPP || ret =3D=3D -EXDEV)
> >               ret =3D splice_copy_file_range(src_file, src_off, dst_fil=
e,
> >                                            dst_off, len);
> >
> > But again, my understanding is that this should never happen in practic=
e
> > and that the superblock check could even be removed from
> > __fuse_copy_file_range().
> >
> > Cheers,
> > --
> > Lu=C3=ADs
> >
>
> Yes, now copy_file_range won't crash.
>
> generic_copy_file_checks:
>         /*
>          * We allow some filesystems to handle cross sb copy, but passing
>          * a file of the wrong filesystem type to filesystem driver can r=
esult
>          * in an attempt to dereference the wrong type of ->private_data,=
 so
>          * avoid doing that until we really have a good reason.
>          *
>          * nfs and cifs define several different file_system_type structu=
res
>          * and several different sets of file_operations, but they all en=
d up
>          * using the same ->copy_file_range() function pointer.
>          */
>         if (flags & COPY_FILE_SPLICE) {
>                 /* cross sb splice is allowed */
>         } else if (file_out->f_op->copy_file_range) {
>                 if (file_in->f_op->copy_file_range !=3D
>                     file_out->f_op->copy_file_range)
>                         return -EXDEV;
>         } else if (file_inode(file_in)->i_sb !=3D file_inode(file_out)->i=
_sb) {
>                 return -EXDEV;
>         }
>
> generic_copy_file_checks mentions that now allows some filesystems to han=
dle cross-sb copy.
>
> code:
>         } else if (file_out->f_op->copy_file_range) {
>                 if (file_in->f_op->copy_file_range !=3D
>                     file_out->f_op->copy_file_range)
>                         return -EXDEV;
>
> If the same filesystem is satisfied but the sb is not same, it will go to=
 fuse_copy_file_range,
> so fuse_copy_file_range needs to handle this situation.
>
> Sorry, there is an mistake with my patch log description. __fuse_copy_fil=
e_range does not exist that
> the source file is a NON-Fuse filesystem, so It can safely use ->private_=
data.
>
> Therefore, this patch does not need.

Indeed, this patch makes no sense and does not change any logic at all.

Thanks,
Amir.

