Return-Path: <linux-fsdevel+bounces-8987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF84183C933
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 18:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC931C25E72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377A4135A74;
	Thu, 25 Jan 2024 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bItXT9mS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0294514076D
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201673; cv=none; b=sWSZURDrQheTWNENvzdWQThOnTOJGPCdifwzzIK+9Hs0TdMOl56x2g4scIOu2d9M4GJvwifYjwzIczTzDEVHKvpNw6Lk9zC7zQY4hB6slAErFa3bbcoat5Ng12ttBkGB+6X9jUiVcItdJMO3oiz6woFg+Mc/Bs2f+oUWAUxx5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201673; c=relaxed/simple;
	bh=AmFC/UDCVQ9FVpKZ5PV0jQ6FNjF2TiWEq07uxUcYKu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YK/eG+nhh/L08r/oYjQQfMbEvreFo/IKGf2S/+Z9ijRKe3QpUztPQncn/SzEOKpgecWqhp/NGsSmqFzwDI0aWVfMb7zVjABP8XIINBr11/D3nSkL8Y3bwGC2AIl2CKN7dsnnwWt59FmKSGF4LyYNMdrcg6avshm/kfIJ3I/Omts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bItXT9mS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso19562a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 08:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706201670; x=1706806470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOiXeojwLOXICuMt5BTSyUSoCml0QlNFyHPEHrk0k4U=;
        b=bItXT9mSmSq3F4T5/UAvTptHVDAQMBlyokbQF7uhem9Z9H5h3WUt23odkyCTmf2nNs
         UJGPG4OcrPnTVcg9XrpdZaJvd5U0vyWQeFM41jfdeliO2NZ0nICxG/LV294Cb0gtypwg
         yNEFviIlJqc7cwfd0eN9Q5krDahatNIqVYzBY0sTpxD5Ep3dNXErcyHwr0e3NpAvpHD9
         0uIseOEmoJAJ6yjWPpzdimzIFL+L+UPEmlKBkLohW4HMuPC+yMd3rMS5n19Iz6Qo6Ej2
         h9+IfkH0TSnaoWGisY4Hz5QILC5YojuvFTexrcEcGMhVrU11tw4FwxDmdoTHeNc4nkfM
         k/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706201670; x=1706806470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOiXeojwLOXICuMt5BTSyUSoCml0QlNFyHPEHrk0k4U=;
        b=ky+1qoU5Px5AmQpg1kxCZp3eh79odLIJyt1FF34ninWI5NP3jwi3X/NyDHUpZbTglW
         waG0i2VgCRQFAmnm54XEXJHYSu7YNQbzjpmtQhZt7iBzs+QiYgntGX7McWmoJ7+dv0Ug
         +IuU6N7zzzObOlIDSgiR5l3UWPX+4qJqmmZ/P1rHUhrfBLfw8kUL/Wsuu933dk0tau4R
         sZbz88IKOMp0jfGyGStUQukNkEqyx8ZaY6KFkIv2TyhOMVMvs2DLeDm/MviC/c8xWk1n
         CgGihKx7Je+okNk/APFLnl7b0F3++nptVT0soozR4XGJ7Fx5gsfyl/XWDOaSPB8uuiuK
         YMew==
X-Gm-Message-State: AOJu0YyNY0rVJ0gdSj1YUhQ+eqpMVwxfFlSQposHreJbl+EaiblEDWwp
	A/o5A6MTVSZu9KuJLFoOiyElcsHTKatVM5PB/Q8jxhhyQuZr9FBBM1opATPAS3Vim2ByQ7zlDHN
	ysxOQEv4FCsCtqgEK0zWLAOastt07+ZUxi/+M
X-Google-Smtp-Source: AGHT+IE2z6ya/M/OiUUYRxn7uUuauoi1OOC2cn8v/ECFbMfBGDjI6n2fTEYDKPs48TdYcboyo2CW2Wt5Fy7VrwBeh4Q=
X-Received: by 2002:a05:6402:c08:b0:55c:e69d:5d4e with SMTP id
 co8-20020a0564020c0800b0055ce69d5d4emr234145edb.0.1706201669987; Thu, 25 Jan
 2024 08:54:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125103317.2334989-1-edumazet@google.com> <ZbKHVt_wkIfjKJXB@casper.infradead.org>
 <ZbKH04PDW7NhImjV@casper.infradead.org>
In-Reply-To: <ZbKH04PDW7NhImjV@casper.infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jan 2024 17:54:18 +0100
Message-ID: <CANn89iJAjEm47Cqt2=5fEnFFVNH-KQbemmqkEfJFUtJZ+c4QRQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: add sanity checks to rx zerocopy
To: Matthew Wilcox <willy@infradead.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, ZhangPeng <zhangpeng362@huawei.com>, 
	Arjun Roy <arjunroy@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:09=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
>
> Fixing email address for linux-mm.
>
> On Thu, Jan 25, 2024 at 04:07:50PM +0000, Matthew Wilcox wrote:
> > On Thu, Jan 25, 2024 at 10:33:17AM +0000, Eric Dumazet wrote:
> > > +++ b/net/ipv4/tcp.c
> > > @@ -1786,7 +1786,17 @@ static skb_frag_t *skb_advance_to_frag(struct =
sk_buff *skb, u32 offset_skb,
> > >
> > >  static bool can_map_frag(const skb_frag_t *frag)
> > >  {
> > > -   return skb_frag_size(frag) =3D=3D PAGE_SIZE && !skb_frag_off(frag=
);
> > > +   struct page *page;
> > > +
> > > +   if (skb_frag_size(frag) !=3D PAGE_SIZE || skb_frag_off(frag))
> > > +           return false;
> > > +
> > > +   page =3D skb_frag_page(frag);
> > > +
> > > +   if (PageCompound(page) || page->mapping)
> > > +           return false;
> >
> > I'm not entirely sure why you're testing PageCompound here.  If a drive=
r
> > allocates a compound page, we'd still want to be able to insert it,
> > right?

I tried to get something that would be free of merge conflicts, up to linux=
-4.18
I was not sure if I had to use compound_head(page) in order to test
for the mapping ?

page =3D compound_head(page);
if (page->mapping)
     return false;

I guess that we would have to adjust the page pointer based on
skb_frag_off(frag),
right now we bail if skb_frag_off(frag) is not zero.

I would leave this change for future kernels if there is interest.

> >
> > I have a feeling that we want to fix this in the VM layer.  There are
> > some weird places calling vm_insert_page() and we should probably make
> > them all fail.
> >
> > Something like this, perhaps?


Perhaps, but backports to stable versions (without folio) would be a
bit of a work ?

> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 1a60faad2e49..ae0abab56d38 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1871,6 +1871,10 @@ static int insert_page_into_pte_locked(struct vm=
_area_struct *vma, pte_t *pte,
> >
> >       if (!pte_none(ptep_get(pte)))
> >               return -EBUSY;
> > +     if (folio->mapping &&
> > +         ((addr - vma->vm_start) / PAGE_SIZE + vma->vm_pgoff) !=3D
> > +         (folio->index + folio_page_idx(folio, page)))
> > +             return -EINVAL;
> >       /* Ok, finally just insert the thing.. */
> >       folio_get(folio);
> >       inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
> >

