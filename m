Return-Path: <linux-fsdevel+bounces-60303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0EFB448AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 23:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE42C1CC1CDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9FC2C15B4;
	Thu,  4 Sep 2025 21:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldTAnM6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568D0289811;
	Thu,  4 Sep 2025 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021901; cv=none; b=V3ao38oFblhwbayPU8tWjv1N2xUrY4xNX7zCsvYGPcCfj/jYIFN4oRPIx4jxtyiTG1jQUrJr5xDut/w+cQBFrBo7pyhyeIzntCVlkhA/O5SOqCUl75rYsS+zyROb5l9kAcCjZ5wIeJU4teeacOnNVoKe7KzByj08BDZ/cBo56mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021901; c=relaxed/simple;
	bh=HVak7VCscwd55hgs/Otdp3h8mY9xWgA9oRAC/Uj0WI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+AEsLEg4H9Q2s0eg7iT8F7DL5KlA2yDxRorU03DgCYX+oNwm4hEAFRS8sIr8ldr1Ma60AG1msBesNvefpoFu0zb4Zxr+4Z5BF/VAXunOxOpGlzvDP3wL6KTeo3+58SFBHiYmGcbgu6yv00JBq4ahRhId0ET9DXVlkjKkdKeNJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldTAnM6j; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b2f0660a7bso14851901cf.1;
        Thu, 04 Sep 2025 14:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757021899; x=1757626699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgVFu6wV+NCXgE3KziSfSYA2e3vYlEKqC50gbb3hB0o=;
        b=ldTAnM6j1HCDqxpO1kUj0FbCT9goRZiWu0n33mWLy+YyVIVYgIEW7tjYfbJ7dYmhy6
         Q2EEfHs/i20Iy9dkoXcwc3jkis1a50csLwD8qO7vdvdQtd47TJdHkI3m59TKrIG4IvHc
         TkzPTGcgMwwPW0eGva227S1SiA44EjCAeKUq9Xlw82gEhYbsxFeixWh8Lx0+9jFLnZBt
         0Lo8IjGu3PWOzbmfSwn3oV0fgayoPleoydYimhPc25Ider11XKmD0GImQkzYscyUMm8j
         +GZv0xCuT82iXZ/zHPvkdyXm6Y9nuBaS2gXc3LgRr9miDx1jXm8OGMABbsiwXTky962n
         hMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021899; x=1757626699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgVFu6wV+NCXgE3KziSfSYA2e3vYlEKqC50gbb3hB0o=;
        b=F0393bJiJmFDweBWJUXMC+SsWA1GaPpEbqql+zmYVg5l3AGECgzaS+giEih3ru21CZ
         uY5ma4H6im38fFpFTPyFJQ2CT7+y+uHVDLSLs28W2yG9q9p9/bctodvXCYIaCVGSCHJu
         qck/oxy4BWXvAlgcJ9w7sfzeDHEamoIHCSReG/PCSil4FpPwhcSpTzlaK0Y+mHrVDpx5
         Nad/sbV659y1VXnb4mPyz8PH0cBJhd7xYeE5gU9vvmJTfE6XrL2xoSY0XNH5K2anh3o2
         TNHqGgOdgwiUgQxZLXy+JFes8jBEzVb1E1sDJZTO4xZwKMguzPt96DOADIxrUNUe2MyI
         oZRA==
X-Forwarded-Encrypted: i=1; AJvYcCW6xhLTRmebUZC9A7+5+x1UP0Y2I5GPVesbCm0z6RKRkpBC0l9sKwEkCobJj3WsenmLO+4ps19B+glR@vger.kernel.org, AJvYcCWgJJOi9zcmKhj1NmTfop3y7f1u/iO26sIX5Q0PV36C1jcMPHZOUJhxU5HoAEPqcjYeh3dwuDTFw5hf+oumPA==@vger.kernel.org, AJvYcCX6qQwl3nCJOnE4Rx9AYHpz2iiu0vQHwwUEBGEsTYMP3NdmfB9xmftDDdxi6wUok3WIQ5Ge6pvzHs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV3CO6zSuwf5YgoMms/060Rrtzn95h8V56SNzLdUSbe+RPxcE8
	H7GhxHbxlzL3WJkDRuy1ErXpA2noueRePccD9mzNk3Vm2hLagecwIN1igujyrw3V0jcJkb/enJK
	Ez0n3/2Go5LlhcA/Z2FcFUTGUim54s6c=
X-Gm-Gg: ASbGnctckXKCb8ARwjMrUovF4MNZgvnW4JoBPogBOa+ZvlXbSeS6d8VCuSku/xNGbPt
	qpKcKVNv/moznv4SXa4sGAm0YPYChr6lIwtfD8YpugfP/+xT9M9ENuWB0XZQglyrC4qTkPsbPwo
	clE7auKS7v1Wi/GdirGvo1XyyUgVBnt36Q/+TujY1Dl/Q08GUuKxOJ0AiGRXT43jQxgYvkr8Q25
	tp2dof8p40P5gOso1o=
X-Google-Smtp-Source: AGHT+IHJHDH8x0L8+otlL7BWU5iyvbfRPDeh+v13FWaK2KnOyTTpevFJKkbRx0Lh0XEomk51CpT6lKTK64rjVLQIh4I=
X-Received: by 2002:ac8:7fd0:0:b0:4b4:9590:e08a with SMTP id
 d75a77b69052e-4b49590eb6fmr96285271cf.67.1757021898985; Thu, 04 Sep 2025
 14:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-13-joannelkoong@gmail.com> <aLkv1ueEE8-ULH6V@infradead.org>
In-Reply-To: <aLkv1ueEE8-ULH6V@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 14:38:07 -0700
X-Gm-Features: Ac12FXxb8w_sxzbS9odJW4yl-Q1vOgxR8GYOerBMy37uwzPXgBehpPO_JjKihH8
Message-ID: <CAJnrk1YFcjAC_aWhduom2dZT=1GcFCSF4CvBw4431YUp+7kQ1Q@mail.gmail.com>
Subject: Re: [PATCH v1 12/16] iomap: add iomap_read_ops for read and readahead
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:21=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Aug 29, 2025 at 04:56:23PM -0700, Joanne Koong wrote:
> > Add a "struct iomap_read_ops" that contains a read_folio_range()
> > callback that callers can provide as a custom handler for reading in a
> > folio range, if the caller does not wish to issue bio read requests
> > (which otherwise is the default behavior). read_folio_range() may read
> > the request asynchronously or synchronously. The caller is responsible
> > for calling iomap_start_folio_read()/iomap_finish_folio_read() when
> > reading the folio range.
> >
> > This makes it so that non-block based filesystems may use iomap for
> > reads.
>
> Also for things like checksumming in block based file systems.  I've
> carried this patch originally from Goldwyn around for a while with
> my PI support patches:
>
> https://git.infradead.org/?p=3Dusers/hch/misc.git;a=3Dcommitdiff;h=3D54ad=
84fded1d954cb9ebf483008cb57421efc959
>
> I'll see if we'll still need submit_bio with your version or if
> that can be reworked on top of your callout.
>
> > @@ -356,6 +356,12 @@ void iomap_finish_folio_read(struct folio *folio, =
size_t off, size_t len,
> >       if (finished)
> >               folio_end_read(folio, uptodate);
> >  }
> > +
> > +void iomap_finish_folio_read(struct folio *folio, size_t off, size_t l=
en,
> > +             int error)
> > +{
> > +     return __iomap_finish_folio_read(folio, off, len, error, true);
> > +}
> >  EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
>
> ..
>
> > +     if (ifs)
> > +             iomap_start_folio_read(folio, 1);
>
> I don't fully understand these changes.  Any chance they could be split
> into a prep patch with a detailed commit message so that the method
> addition itself is mostly mechanical?

Good idea, I will do this in v2 to make it more clear.

Thanks for looking at the patchset.

>
> > +                     if (read_ops && read_ops->read_folio_range) {
> > +                             ret =3D read_ops->read_folio_range(iter, =
folio, pos, plen);
> > +                             if (ret)
> > +                                     break;
> > +                     } else {
> > +                             iomap_read_folio_range_async(iter, ctx, p=
os, plen);
> > +                     }
>
> Overly long lines.
>
I'll fix this, sorry to make you keep having to point this out. I'll
be more careful about line lengths.

