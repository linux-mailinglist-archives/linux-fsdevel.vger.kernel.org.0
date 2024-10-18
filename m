Return-Path: <linux-fsdevel+bounces-32383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AA79A47F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 22:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C67B249EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E8209674;
	Fri, 18 Oct 2024 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C87QQgU4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF10207A3B
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283385; cv=none; b=hevaDMKDkJOonA5LwW/uEb9y33DyHL8mCXnVfjV/tq25VOlsyfhLZJWr6LXYj6GHv+0kOxs3ZJ/1N7FUO6g1lyu9Rk+1JlTeXJyQr6AX614jtmtOXldiS/fBhk3nq9z4ruils2LJvrPdgm+UOl7YcUs6R9R5L7yMI+Ta1ZTaw7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283385; c=relaxed/simple;
	bh=SWRoq8DIDuzkXtXPalWChVqpfGyMb9N0vSRlxCJZFos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBlfEEvTLj74pQ6d+CpX/ngrhaCSQhu3gTvQlMvte00RVYTcPSm6J4KJg+KtzpqNZnBj7eIfc5wYKgfJAdCEwH4lWEejwLIuYFLL9hReYfx60fkyZONCdNL2tNADkwuFbdCnassgagKT+eVzy3oIE34uuzR3cGBLCiUVEQFFhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C87QQgU4; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4608f054f83so22900291cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729283382; x=1729888182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNQAmNfKMCcEXYmE+B++e1OLPfk125s2vPHs1hWebHs=;
        b=C87QQgU4x407fw2Oy+wE/7RHyiKyV+Bay/AhpddipFiv2gl0WqGUZFC5ZM0BJwslRt
         wn2vFS8brjXezlqShzapTe1CkosRuqdmsNwYZy9V+821Sbju7FFaW3RmeMtec8UNAFkS
         0mdo6+nvstPIOasxvt1w1ALvP2OaWVWYKld2CyEN9OcpCBn3mOZJhhgI3hUHi+oJ9DlJ
         8vuGac5Pk4RdorlwQY63/jUJctZoelY0d4arRUnbkofN3SojKSCuvJ+84kzmP8Byo/cq
         jt1UGvYuqGukZFTx0JH2kRDPEwwQvdRMsDAEvQFmeKsJFJhM0vZ7PUtru6czTBsX6VH3
         GfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283382; x=1729888182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNQAmNfKMCcEXYmE+B++e1OLPfk125s2vPHs1hWebHs=;
        b=Z9FOLnw+E0/1PeJOMy9YdonUU88r9O4SKk+KS/QShHqJhYOe8s8v/nMYqbmd0C5srq
         KR2JvgbOMYwbzrvMFOEulKU6b57XTEbNMgQztvP5re2lPh0W45/hO1VEI8qjuxUGYDf/
         B9QN0ndd/srpyj1tr1K2rp7jRcDRle+HIlg9J7nxaclPGR1jYeVQ/6Oq0KL9iq5OP9Ot
         xOA3hmj6n2D+hWMMBWuYFK+hTkVi5lTa8Gkp3ny0uZynyf6kHQ2deLJtPKWRlWeJOo4w
         IUMCIz6ighwsCNjbgW3DPRPT575DLETgfuDod2dzFxQGEICrfs8rKdtcDqxP7JRar6VT
         l2BA==
X-Forwarded-Encrypted: i=1; AJvYcCXqTFoOg8jkqA/p3cavivv2vtnK+u5UMchBtMmLJGOD0a9YUuKoZHzy1kmACRlH+IuNQXJ6Zxd0J9J3COfr@vger.kernel.org
X-Gm-Message-State: AOJu0YzEg7ChN6zC0DmtZ041UTu3k0T+sApyLtsvaKjQk7q1zZFYR4oy
	nvr8fti1EDoPg5vTn0inzdrKryO4XZs5G4u/M94ZVzCoE5CH0k2jRaSDQSXovarUKQ0TULOtTs7
	OsU+NimK1wbwHHZ+HL+A9qh6borw=
X-Google-Smtp-Source: AGHT+IHAIHCRBGX/LC1H73la26F77AWFDKgo4IF6ib6AXXvef6TIjRJ7nj32fBdWjVbEhqgFmABoDuUDpS3N3D2BWy4=
X-Received: by 2002:a05:622a:152:b0:460:ae0f:470c with SMTP id
 d75a77b69052e-460aee38981mr44648381cf.47.1729283382216; Fri, 18 Oct 2024
 13:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <0ba71b33-71ca-4dc0-a01b-7744933ae6d4@linux.alibaba.com>
In-Reply-To: <0ba71b33-71ca-4dc0-a01b-7744933ae6d4@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 18 Oct 2024 13:29:31 -0700
Message-ID: <CAJnrk1b9Ts-ve3A2O2tzsQ3R36mXmyLoHFiNOv961TpzHD_QDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 2:24=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
> On 10/15/24 2:22 AM, Joanne Koong wrote:
> >  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *=
wpa, struct folio *folio,
> > -                                       struct folio *tmp_folio, uint32=
_t page_index)
> > +                                       uint32_t page_index)
> >  {
> >       struct inode *inode =3D folio->mapping->host;
> >       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> >
> > -     folio_copy(tmp_folio, folio);
> > -
> > -     ap->pages[page_index] =3D &tmp_folio->page;
> > +     folio_get(folio);
>
> Why folio_get() is needed?
>

It's not strictly needed but I added this to ensure that the folio
will always be valid when we later on access it. My understanding is
that it's an implementation detail rather than a guarantee that the
folio can't be removed from the mapping until writeback finishes.

>
> >
> > @@ -2203,68 +2047,11 @@ static void fuse_writepages_send(struct fuse_fi=
ll_wb_data *data)
> >       struct fuse_writepage_args *wpa =3D data->wpa;
> >       struct inode *inode =3D data->inode;
> >       struct fuse_inode *fi =3D get_fuse_inode(inode);
> > -     int num_pages =3D wpa->ia.ap.num_pages;
> > -     int i;
> >
> >       spin_lock(&fi->lock);
> >       list_add_tail(&wpa->queue_entry, &fi->queued_writes);
>
> Could we also drop fi->queued_writes list and writectr counter after we
> dropping the temp folio?  I'm not sure.  When I grep all callsites of
> fuse_set_nowrite(), it seems that apart from the direct IO
> path(fuse_direct_io -> fuse_sync_writes), the truncation related code
> also relies on this writectr mechanism.

I'm not sure either, but I think we still need it. My understanding is
that the main purpose of this writectr is to detect when the inode has
pending writebacks. I think even without the temporary pages, we still
would need a way overall to track if the inode is writing back any
folio in its mapping.


Thanks,
Joanne

>
>
>
> --
> Thanks,
> Jingbo

