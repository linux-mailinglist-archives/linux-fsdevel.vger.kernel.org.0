Return-Path: <linux-fsdevel+bounces-60318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A299AB44A6E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 01:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EC9586438
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 23:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1AA2F6590;
	Thu,  4 Sep 2025 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVjJp4Xc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D0E2F6572;
	Thu,  4 Sep 2025 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757028580; cv=none; b=tuV/6tCGH3hRITYvaQ3upJru908QkLkjeLTE80ZBwusIkIYzSXhBsmUBTQktHIBeZAvu10Cmv/Q3VLgqoqdonoz0iefODv3NM5oZIBK8Gvq2ImYE7GhAg6GDZ5sAvdg5Y8lz3fwZqdzoDIJjQCpldCPf59HIBUnlq9YJ2ZLbXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757028580; c=relaxed/simple;
	bh=fUozvlmZHjDMMFeah7+1rjkBM4K9F4X9L5RLKFF1siQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJMNxETjhi+orX4PI42XJI5sfodzTZDa3b6BUbROBK8zPrY3Qosbq8Mj5kzleWko0PnLh0nWnMuW4IXiqRuzYrgOfFMmL+TJoVVz/v+zDB+G5SU6u1v3UKiqFWr8vN0XT0EOwNo9bRMOGCfXmcYssV2HgLgjmLA/nwjHCvKyP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVjJp4Xc; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b548745253so24559121cf.0;
        Thu, 04 Sep 2025 16:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757028578; x=1757633378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anMleAXlrQhOdmCLksyR6nBbbIhPKTPWZQSrxEe0iDg=;
        b=MVjJp4Xc2oP+UkBJYiI/RkR8ahFQoF9VUinsmFCLif/zRfXVcmOawdo0oFzCOTfVp0
         bowlA9wizQYsssNDYCyfTi+rfrpcK8/FdQHwXDx+CJwP1eunEbR1f46iloonKCQrN4e2
         V/MSfw8VV84N/B6Jw9qLVVUX2fJiEBJpf6rMTtfSNvxbgDgHy3AEbo0XfbsLFRxDfuYf
         MAmVtTXngkMMy6IUKJW+gTWcg9sODZUKRO7GtXXcQxRdUKdv0UXqVgPPZSCJA2z0tIp3
         rShg2SKKCz11TZX/LdKfi3Lw6f0XpouQmNjTjQ70Z12d+CY/7NglZzeBV+L80A0PMPqK
         qMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757028578; x=1757633378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anMleAXlrQhOdmCLksyR6nBbbIhPKTPWZQSrxEe0iDg=;
        b=FTOFXfeOGuPiZaPWlDR1zZ9aPefPFDI/vDQ1MsjDyr4nYWUaKzFDB0F9db08QYmgP3
         iY9DtUXJqJhmjHNMt7ElZJQU70NcmRJi5nyjAnYXRIB9Fz8q9OjXYbjrIWJ+BECgLKo0
         dfC1qiajw54LrwXMYlxXBdxoOG8vVvrZ7PkiIO/xrm0GWVIeYYiVqfaLFOkkpWjlYnrp
         FRNVy4spJN3NcWdRmPd1DvQ5igptqdRT4pdpJTV93IrakFnleGNtYvfO0HmCAgwLBKZf
         VQKtGHIKfWqhK53hJUwIv8Xh4gkvM7eJhFUjByirqMkJitTmORvMhDBx1bf5m+iCmmN7
         wZ5A==
X-Forwarded-Encrypted: i=1; AJvYcCVtLGiwefx6JEcBb8bKwjggVG+Yy8zAx0GohS7DR7VGOq2S/AHoSxCMS9IsR6Tupk9iM6Cjxea62N1P@vger.kernel.org, AJvYcCWZ6NbJ3TCfdN6PDSU6I6qN9uLfaB5fRZDBlUnmLVpH8kW1C0PypRbBjabxaGrErHADyp2C1VliOAPjqDpODg==@vger.kernel.org, AJvYcCXDw8URgdwfVkSMVhYTFvCyt8qTWwQV5z7d0pcDZJDDr7dEdAqej4QmsjGAyFwEK816ybJWM0NeLSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9YxF4ipITrrJ7/r5mPVaaCZ/SzFDPpKT6NO7FDu1p6t3UNynl
	ev2lj5hQjMAtctboAr0yFLJ+tyBr34pfQEkK7qBEeL0XcC/McT4Rf6aygXa3qbDOrRfnoqi2kpf
	3xMq6oXagOqqdvh1he7w/ivx6kJT2Iko=
X-Gm-Gg: ASbGncup/Pf6vXxQKKXl8i9woAXSKu0g7xR6MgBrpcwcFqQI4YS3lyRm+gOIwi4s3Ig
	aGWjI26ROKUXZsXsspGXRwSKBny12w/LSxGk9mljcJJFfRhcj+b85T1MsGwHHzfPPClQqHiYdQd
	/0y534gVsvWGLC2MFD93kKuV+dM3Z4chWLRG3f2wM582Td8cr+bOCHEFU6vcv/sq8J4jeNyXWXE
	w10e2f2
X-Google-Smtp-Source: AGHT+IFv6LHkLlFMLEKnsGiwbAgJqMI8oMJccTJb6gCtseIQflQe0TtZYI/AsdBbRIT6fyWjks+w4bcVvens8BpPdNk=
X-Received: by 2002:a05:622a:22a3:b0:4b4:8efa:f9df with SMTP id
 d75a77b69052e-4b48efb0896mr91042051cf.72.1757028577639; Thu, 04 Sep 2025
 16:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-14-joannelkoong@gmail.com> <aLJZv5L6q0FH5F8a@debian>
 <CAJnrk1af4-FG==X=4LzoBRaxL9N-hnh1i-zx89immQZMLKSzyQ@mail.gmail.com> <a44fd64d-e0b1-4131-9d71-2d36151c90f4@linux.alibaba.com>
In-Reply-To: <a44fd64d-e0b1-4131-9d71-2d36151c90f4@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 16:29:26 -0700
X-Gm-Features: Ac12FXyXy9lDByOU7ejm_7fELBjCwpp5PsKjiSmF-rfEDw0XF-DcJA05aPWkpmQ
Message-ID: <CAJnrk1bBmA+VK6UK1n6DRnuLvX8UOMp-VgQGnn2rUrq0=mCyqA@mail.gmail.com>
Subject: Re: [PATCH v1 13/16] iomap: add a private arg for read and readahead
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 6:55=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> On 2025/9/3 05:24, Joanne Koong wrote:
> > On Fri, Aug 29, 2025 at 6:54=E2=80=AFPM Gao Xiang <xiang@kernel.org> wr=
ote:
> >>
> >> Hi Joanne,
> >>
> >> On Fri, Aug 29, 2025 at 04:56:24PM -0700, Joanne Koong wrote:
> >>> Add a void *private arg for read and readahead which filesystems that
> >>> pass in custom read callbacks can use. Stash this in the existing
> >>> private field in the iomap_iter.
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>> ---
> >>>   block/fops.c           | 4 ++--
> >>>   fs/erofs/data.c        | 4 ++--
> >>>   fs/gfs2/aops.c         | 4 ++--
> >>>   fs/iomap/buffered-io.c | 8 ++++++--
> >>>   fs/xfs/xfs_aops.c      | 4 ++--
> >>>   fs/zonefs/file.c       | 4 ++--
> >>>   include/linux/iomap.h  | 4 ++--
> >>>   7 files changed, 18 insertions(+), 14 deletions(-)
> >>>
> >>
> >> ...
> >>
> >>>   int iomap_read_folio(struct folio *folio, const struct iomap_ops *o=
ps,
> >>> -             const struct iomap_read_ops *read_ops)
> >>> +             const struct iomap_read_ops *read_ops, void *private)
> >>>   {
> >>>        struct iomap_iter iter =3D {
> >>>                .inode          =3D folio->mapping->host,
> >>>                .pos            =3D folio_pos(folio),
> >>>                .len            =3D folio_size(folio),
> >>> +             .private        =3D private,
> >>>        };
> >>
> >> Will this whole work be landed for v6.18?
> >>
> >> If not, may I ask if this patch can be shifted advance in this
> >> patchset for applying separately (I tried but no luck).
> >>
> >> Because I also need some similar approach for EROFS iomap page
> >> cache sharing feature since EROFS uncompressed I/Os go through
> >> iomap and extra information needs a proper way to pass down to
> >> iomap_{begin,end} with extra pointer `.private` too.
> >
> > Hi Gao,
> >
> > I'm not sure whether this will be landed for v6.18 but I'm happy to
> > shift this patch to the beginning of the patchset for applying
> > separately.
>
> Yeah, thanks.  At least this common patch can be potentially applied
> easily (e.g. form a common commit id for both features if really
> needed) since other iomap/FUSE patches are not dependency of our new
> feature and shouldn't be coupled with our development branch later.
>

Hi Gao,

I'll be dropping this patch in v2 since all the iomap read stuff is
going to go through a struct ctx arg instead of through iter->private.
Sorry this won't help your use case, but looking forward to seeing your pat=
ches.


Thanks,
Joanne

> Thanks,
> Gao Xiang
>
> >
> > Thanks,
> > Joanne
> >>
> >> Thanks,
> >> Gao Xiang
>

