Return-Path: <linux-fsdevel+bounces-15370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE1888D248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 23:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D89326ADE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 22:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CE113DDC4;
	Tue, 26 Mar 2024 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1QHEGhf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D5713DDC7;
	Tue, 26 Mar 2024 22:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493586; cv=none; b=P6BV7Sp3rYUQFKuTHHyK354/3UpVhMQJLiYfZKq8zlkD/xoyAl5tRdG3UR3LYa6kotKZlvaXMAs4eQj234BGNKFldJZZWyIPKs6jwCFVEZLVR5aAWLR7o2ZWAxJXlpodnxfiTR6guIX35jMKIHzWzMXNDeSmrTLZo103mVpm6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493586; c=relaxed/simple;
	bh=kr4ugb0a2ULz64/mCBMSxX3n7SnZ+F784fzqUgvlurk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9Bs+Ps410CGMvTetDJL9wcxZYAsluLypDk36+8DS5ktbKiYj/q3YYpzPnfbXd08uvNC80x4wE4SAz1Dqzf0osSSlAZ4iqhg8gr3fGE0UUrSIOrq55GH9tLA/bJAXtmk9+1l7pHCttZcuA7O4X3imfwRME5oZG8JZFbhK4pdAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1QHEGhf; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so114279921fa.3;
        Tue, 26 Mar 2024 15:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711493583; x=1712098383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGgALYVn3j6sEFQYAH/+oIf0Xfv3DpByVPwYwGg56do=;
        b=N1QHEGhfL1Vnbi8kKvWplmiXf+p9l2RhNUX268yewGKx5iEOuESHAKwCm2wreDCLM3
         ZDjZwtRsqbQQWiETioifKeqxKX0Be4hwy/qFFaBPh4nINUKp1RnsJhTcWP0wvBpG0p5+
         2HpH89J2PXz08jaS5mMcH35YhP3xHDyH6lWIxjB4XaPx5tyQlRQR/FhZvAr7D8d5JGw1
         AgUT9FTPVXWLIctgtaRArmJU+yvxb5o3nnyfdubgL4UOOe4nvuQDT0ua/dVu3Bsl56iW
         PtmVc5UxMQX0YxkDxTDaqr4mylhJOrM5rCTCHZx+YUxtHztienIzkEdNg2clkr16jkVc
         mNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711493583; x=1712098383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGgALYVn3j6sEFQYAH/+oIf0Xfv3DpByVPwYwGg56do=;
        b=pPWXBahSpArGrlIAP9adE+Mg6HukpdiR8DqW8Ff3/up3hm3fpVU37E3C5dcCKT/3Jt
         nhzslKA81fs1nmm0dHURTbxddkFNiR6KhFHeXd5KJxVpaO3Rh9OgRWSo5cK3fdbZtXN3
         HPMZUkpntfbcf39w479oOoyR5s82ueQPKycSYfLnbp1xkkrSs6stJ4j4/h0IQBZh9jCg
         xIAWCLCqIen/q0VV+j8cVJUWL+Q3iBsbRP7g6lN2jTegCyZvKQ+7XW6IiZ0B5swNJ/pM
         eL9III6X4vG4EEGYOhDf2eGGoZwya0fERXiL/Bux00N/yR7WE2b4DSUHkZCclxdJ0UJ6
         gZEA==
X-Forwarded-Encrypted: i=1; AJvYcCVTKRxC6sTnBaT/TbeXYzy38hl6CLgeHsV4rVaxzkTRxVlw1obdRR1zSVb7kJeLH7QxhTahPDG+xHhC4f1ArVzVG5+YjLGt27AaozJHw+0087J4JnBqSZPt7IjrRhcNCRESSF3I3cpKCho7+Q==
X-Gm-Message-State: AOJu0YzEmLLIZGy3dz/AsQF3casX1AcoFSDHSTcRF0i0NgXaadR3F1Q1
	/d9JR1r+K1KJxHSiK/2IBiVklUtIauxCm91MtI6I3l20X+M9tKLC5cyQewrEKineFBhxj6WXSVV
	6W4SvxuEQHuBoqjNfHpOma/wJpXM=
X-Google-Smtp-Source: AGHT+IEolqJMeAANTemImf2DuaNJdNaLuCTNmbxSFTah/htK+cycypMcUiMVK4vogxZfUZcHT97fZM4T0r9XQUXO0YU=
X-Received: by 2002:a2e:781a:0:b0:2d4:714b:4c5d with SMTP id
 t26-20020a2e781a000000b002d4714b4c5dmr816730ljc.44.1711493582960; Tue, 26 Mar
 2024 15:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322210455.3738-1-soma.nakata01@gmail.com> <20240326140533.a0d0041371e21540dd934722@linux-foundation.org>
In-Reply-To: <20240326140533.a0d0041371e21540dd934722@linux-foundation.org>
From: Soma <soma.nakata01@gmail.com>
Date: Wed, 27 Mar 2024 07:52:51 +0900
Message-ID: <CAOpe7Sc1PByy+c9V4eWH=fo9_zjgNGw1D6TWAiZ9-ujKgNdq_w@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: set folio->mapping to NULL before xas_store()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 6:05=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 23 Mar 2024 06:04:54 +0900 Soma Nakata <soma.nakata01@gmail.com> =
wrote:
>
> > Functions such as __filemap_get_folio() check the truncation of
> > folios based on the mapping field. Therefore setting this field to NULL
> > earlier prevents unnecessary operations on already removed folios.
> >
> > ...
> >
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -139,11 +139,12 @@ static void page_cache_delete(struct address_spac=
e *mapping,
> >
> >       VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> >
> > +     folio->mapping =3D NULL;
> > +     /* Leave page->index set: truncation lookup relies upon it */
> > +
> >       xas_store(&xas, shadow);
> >       xas_init_marks(&xas);
> >
> > -     folio->mapping =3D NULL;
> > -     /* Leave page->index set: truncation lookup relies upon it */
> >       mapping->nrpages -=3D nr;
> >  }
>
> Seems at least harmless, but I wonder if it can really make any
> difference.  Don't readers of folio->mapping lock the folio first?

Yes, the reader locks the folio.
Only __filemap_remove_folio() calls page_cache_delete(),
and it says the caller has to lock the folio or make sure
that usage is safe. In the latter case, this patch improves
efficiency a little bit.
However, I found that there is not any latter case actually,
so discard it or apply, also to make the order of operations in
page_cache_delete() and page_cache_delete_batch() the same
for a cleanup.
Thanks,

