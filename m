Return-Path: <linux-fsdevel+bounces-27000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A23B695D898
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 23:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2573B1F25A6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 21:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA111C8232;
	Fri, 23 Aug 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4qY+zKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14C192B63
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724449095; cv=none; b=RhR+2O65MnrFn2KisAn2B2g9aG54jc6vWrFbDi8kDlVU/93PdYbCRF4hzrMiUtSfUKlPXRoR3fZc18YAWtuhi4gNfYPoTibKOfTpgpo+xF2Y9ArMd0BbEWbQw8Ew8Was93S2mCyWuEawTLjKQ6Co5GVNdgLdorJG+l3o9mWDHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724449095; c=relaxed/simple;
	bh=oQMujYYvSm+h0CHAOdcSjg+YBH1SIXVgbfsHXBMxm48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIPiU7PDZwRlSusEm+aPUFokQECeNJozU/bJg5y+EydVu3pCCUMF5cjbn6JJZJ1QxZfr2Hf+YagcB6WKHBWQduVUMG7k4CTyPdR/TBWcE6cLxHsuet68nGwactSA2hy6wQxGNRQNrHr1Fbubvh+U8opRgDgDd6/bFjIJYTMLX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4qY+zKc; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-709485aca4bso1776707a34.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724449093; x=1725053893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oO4mepCcRixO9WTTfhnEHbmVHgts0B/sai2JWgB3+EQ=;
        b=Q4qY+zKcqQib6aCmYXzcl7HJuD/wkUHUbxscUkmtO1DxO4t1Clz1EwV6SkVI0+Xbt+
         fHtLk3GNdIDfgPocBnCQ4acW3u1Yk7f/ipvXDxi4iLCMGkTuSvh3i92oopTFq5drw76C
         dArccc/vYIkndWYPBSuCxjCVQ+WsFvq9Ha1JlhlCf1TAdNnujUsDQceIIhYWSy5cl9DE
         H8Bm8+7DmBNTWK5iu23u2KoHBmtPxUody8IoxA7pNEsQhzecbDTh19Mvc+Duis6kKqI9
         KaAL6pKjqCsFiz9aDwWkW42/alSUymtgbNSy4bcJ7BZwKZMJCdaCkNFizGkCIlBwYY2Q
         idcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724449093; x=1725053893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oO4mepCcRixO9WTTfhnEHbmVHgts0B/sai2JWgB3+EQ=;
        b=abXKTsUEPTZEsnCrgNWtSCaDgRMQHQoIdN+NyHKTW7i/C9QtnF5udtcTCj4dzWWL7B
         uLEy98xQuPcP4AP/WXxog+IikWl8b4PBZ20N5u4vZpNDwdLqe/I1jMxQIliKzpkeuRqu
         1svU5CyvUxg7KXk+tKMLGEdBDbH9DA5L9VNvWPW93anFnIunX6gDMsGp7dTaMgtSGhq1
         1Oj9fSE7r3SwxM4/YYn2XbS8u0rVqwWqTxAGrho/kkMc4aCmFa3S3zDzPm09YtwzcL8/
         W+dK3XKpR9J7ZzAtfcfeSQ+UGAI5RoWs6Vs6vv7StHl+3Bj/o1xX9rEl3hypkiLamhJU
         MGOg==
X-Forwarded-Encrypted: i=1; AJvYcCXvlGFXuCdVKAru96f3hUvFM4cKXb1kcHjR2zuzQqMF1qFTiEng3Mnb6OHWesqpIMWa8XihU2TcB4teRhkl@vger.kernel.org
X-Gm-Message-State: AOJu0YyJvY+ftkC163GMx9SNMZIubiO4y6waNkz1IECHXnQ9k+U+yTHq
	Encnar2/x1iVw087NEGYU9O3ugdZ44o9GkbYWhGNJdfZjdldWKZ5gUmSYTfVSCZhTehLL8KPfut
	c82RAex2hDZZJtAp3NgxmE0Wa2ua14JCT
X-Google-Smtp-Source: AGHT+IEOF35VGMF9a1ZaLVimHWB0OjgX2eOhjohJ5DznGKZ6/3+c82cmMZyXkryQslmAu008hgSVqxZmyxRumx1/WEQ=
X-Received: by 2002:a05:6808:3192:b0:3da:b3cb:cfc1 with SMTP id
 5614622812f47-3de2a834ae2mr4471981b6e.3.1724449092932; Fri, 23 Aug 2024
 14:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823162730.521499-1-joannelkoong@gmail.com>
 <20240823162730.521499-7-joannelkoong@gmail.com> <20240823190346.GB2237731@perftesting>
In-Reply-To: <20240823190346.GB2237731@perftesting>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 23 Aug 2024 14:38:02 -0700
Message-ID: <CAJnrk1aU-iY+7v-b+=YJm_ajHFJjm2ZfsT_TwC2EJSy6zSn2uQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] fuse: convert fuse_writepages_fill() to use a
 folio for its tmp page
To: Josef Bacik <josef@toxicpanda.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 12:03=E2=80=AFPM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> On Fri, Aug 23, 2024 at 09:27:27AM -0700, Joanne Koong wrote:
> > To pave the way for refactoring out the shared logic in
> > fuse_writepages_fill() and fuse_writepage_locked(), this change convert=
s
> > the temporary page in fuse_writepages_fill() to use the folio API.
> >
> > This is similar to the change in e0887e095a80 ("fuse: Convert
> > fuse_writepage_locked to take a folio"), which converted the tmp page i=
n
> > fuse_writepage_locked() to use the folio API.
> >
> > inc_node_page_state() is intentionally preserved here instead of
> > converting to node_stat_add_folio() since it is updating the stat of th=
e
> > underlying page and to better maintain API symmetry with
> > dec_node_page_stat() in fuse_writepage_finish_stat().
> >
> > No functional changes added.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index a51b0b085616..905b202a7acd 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -2260,7 +2260,7 @@ static int fuse_writepages_fill(struct folio *fol=
io,
> >       struct inode *inode =3D data->inode;
> >       struct fuse_inode *fi =3D get_fuse_inode(inode);
> >       struct fuse_conn *fc =3D get_fuse_conn(inode);
> > -     struct page *tmp_page;
> > +     struct folio *tmp_folio;
> >       int err;
> >
> >       if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) =
{
> > @@ -2269,8 +2269,8 @@ static int fuse_writepages_fill(struct folio *fol=
io,
> >       }
> >
> >       err =3D -ENOMEM;
> > -     tmp_page =3D alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> > -     if (!tmp_page)
> > +     tmp_folio =3D folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
> > +     if (!tmp_folio)
> >               goto out_unlock;
> >
> >       /*
> > @@ -2290,7 +2290,7 @@ static int fuse_writepages_fill(struct folio *fol=
io,
> >               err =3D -ENOMEM;
> >               wpa =3D fuse_writepage_args_alloc();
> >               if (!wpa) {
> > -                     __free_page(tmp_page);
> > +                     folio_put(tmp_folio);
> >                       goto out_unlock;
> >               }
> >               fuse_writepage_add_to_bucket(fc, wpa);
> > @@ -2308,14 +2308,14 @@ static int fuse_writepages_fill(struct folio *f=
olio,
> >       }
> >       folio_start_writeback(folio);
> >
> > -     copy_highpage(tmp_page, &folio->page);
> > -     ap->pages[ap->num_pages] =3D tmp_page;
> > +     folio_copy(tmp_folio, folio);
> > +     ap->pages[ap->num_pages] =3D &tmp_folio->page;
> >       ap->descs[ap->num_pages].offset =3D 0;
> >       ap->descs[ap->num_pages].length =3D PAGE_SIZE;
> >       data->orig_pages[ap->num_pages] =3D &folio->page;
> >
> >       inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> > -     inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
> > +     inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
>
> I *think* you can use
>
> node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
>
> here instead of inc_node_page_state().  Thanks,

I was thinking inc_node_page_state() here would be better for
preserving the API symmetry with the dec_node_page_state() function
that gets called when the writeback gets finished (in
fuse_writepage_finish_stat) - I don't think it's immediately obvious
that node_stat_add_folio() and dec_node_page_state() are inverses of
each other. I don't feel strongly about this though, so i'm happy to
change this to node_stat_add_folio as well.


Thanks,
Joanne

>
> Josef

