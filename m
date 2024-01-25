Return-Path: <linux-fsdevel+bounces-9012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F7183CF42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 23:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7BF296818
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 22:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670B513B787;
	Thu, 25 Jan 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTfVShRy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5061386C5
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221437; cv=none; b=nlpPw6mm4wfhK2u0xchxKls3ggoc8RKxqZsT1uy82uNH0IL+nMb+/d2yC1ADXm8rg0hpWLiMe2gAytO/5VtfEcWRGtNQZHnKejvMLJVmWU+UbjNydBmeM+INGsx2Hcpdgy104r64JEIffbgtmLpD0yvmR4jwRhkXIS8/jNeuK+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221437; c=relaxed/simple;
	bh=6cRWQrFRgUief1NPnFvtkb56/IGUthGnWRG8BdZ5rnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGpq/xiZH+PhYRV7dzSO99TUX4dGgPhm+oAbB9L3x4q852X71VM6RCC3j7qByuJdmjnNkwLyBCMjSUyHjdyOJ9E6Bw7bfMK/DCBf9Sl6xNQiwVPHl2B4QEotP4gQ1nq7Tm16vqltEwuOLp0Fz3zjIv8m57ZSyDHO22jiQSjsGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTfVShRy; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-428405a0205so68771cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 14:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706221435; x=1706826235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugES21rFNQxHoBbo+moEN7jaIFZGE4ifkZMe2NX5CNo=;
        b=pTfVShRyO2AL4MzrXTva6NbnJCIQ7aIBT3EYZS18QmL3bRkV3i2uPcXDBI3m62d6dd
         3waK1Wf1OxCo14Z1Iq00q5O1RGp0lQmrCXUZ+5dJj4AQfCUDdeFAPtCL1uYh1i7zYXdK
         4ZxEg9VV3uJeGDrUSg2d+0GNp7F7aRVaUI+Hgl6q6rNwL/C0bVLXDMHz6u0wixTsldnA
         1jZlshntfObVlUcpTnMGmZezta2hs2FqXTFDTpykeqbP17MT38VHvWaziHqbEqZxK0a7
         DL7mE8Hf7/eL2JJZA0maFA5vTs0OE6/bee/EP+FgrEhlIWw55RvI63agxFf06Htd+y3t
         fQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706221435; x=1706826235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugES21rFNQxHoBbo+moEN7jaIFZGE4ifkZMe2NX5CNo=;
        b=nKwITDNOaf6gzNI87dEGjzYOCvTnprYx1gSl8r81Ph3Xq01gyFOBhIOzUjhITAw+2J
         uI/ZiZs9SDnPlgIGbsz3LGJdpdhUBtKhkbiAMFRCm6s2BWeIwBFXCRfIoYqkLtlYoQvj
         aSjb6sR2Gn/k6Dwkep71kplmmjyigewwZ0RS1LJUCB9ZaRCYqYuwjTSIYeYH4ikxhf2C
         9dusmsl1AjAW87/AvtkRnW96MfsBsIvjaFZdH9rI221xn2PZmwpDK5cCAfj3UhcF89rW
         DtL+ivSWKe3JeB3gHSa5CNhghw6d3IYZM8VrfD3+kmuWYsm1HXLoYoR6MC3Wgex2RsMe
         FLqw==
X-Gm-Message-State: AOJu0YxZo07F3YfzMSMqiVu1K2f7GfSSzJUr/NirxhjbMh0aA29C5nKp
	sfyjWx8pKABY8LqwWy1BKCTCUi1ssVWJ6A0/l53fKeOw9vOKPciKe/XQDYB9XUmuLf2ZRgHbiYy
	PXREageIRPiO2vjjPD+GEAAX677M9xKbCHo5G
X-Google-Smtp-Source: AGHT+IGyt1ku60lKQ5hWkUlvNugCNWMatPICldi3Xxa0R/YH6+vQKdazVRsKCHrMOApQSR0HU7DhpAxCNO2a57KN+L0=
X-Received: by 2002:a05:622a:6099:b0:42a:5924:b0bf with SMTP id
 hf25-20020a05622a609900b0042a5924b0bfmr69431qtb.22.1706221434912; Thu, 25 Jan
 2024 14:23:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125103317.2334989-1-edumazet@google.com> <ZbKHVt_wkIfjKJXB@casper.infradead.org>
In-Reply-To: <ZbKHVt_wkIfjKJXB@casper.infradead.org>
From: Arjun Roy <arjunroy@google.com>
Date: Thu, 25 Jan 2024 14:23:43 -0800
Message-ID: <CAOFY-A3pi-FNbe_=ED+4HGimBdLq95xiom++Jd6f9aRrbEssBA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: add sanity checks to rx zerocopy
To: Matthew Wilcox <willy@infradead.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	ZhangPeng <zhangpeng362@huawei.com>, linux-mm@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:07=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Jan 25, 2024 at 10:33:17AM +0000, Eric Dumazet wrote:
> > +++ b/net/ipv4/tcp.c
> > @@ -1786,7 +1786,17 @@ static skb_frag_t *skb_advance_to_frag(struct sk=
_buff *skb, u32 offset_skb,
> >
> >  static bool can_map_frag(const skb_frag_t *frag)
> >  {
> > -     return skb_frag_size(frag) =3D=3D PAGE_SIZE && !skb_frag_off(frag=
);
> > +     struct page *page;
> > +
> > +     if (skb_frag_size(frag) !=3D PAGE_SIZE || skb_frag_off(frag))
> > +             return false;
> > +
> > +     page =3D skb_frag_page(frag);
> > +
> > +     if (PageCompound(page) || page->mapping)
> > +             return false;
>
> I'm not entirely sure why you're testing PageCompound here.  If a driver
> allocates a compound page, we'd still want to be able to insert it,
> right?
>

Resend b/c I forgot I was in HTML mode email, oops.

Is there a common use case for a NIC driver to be doing this? I was
under the impression NIC drivers would get pages individually since it
would be harder to find physically contiguous groupings in general.

Anyways, a possible reason to not allow compound pages - if we have
some large memory range and different receiving users are interested
in different parts of the range in userspace - since the whole range
is pinned till everyone is done with it, it can lead to worse cases of
memory lingering when some user only wanted 10 bytes out of some N *
PAGE_SIZE range for a multi-minute long period.

-Arjun


> I have a feeling that we want to fix this in the VM layer.  There are
> some weird places calling vm_insert_page() and we should probably make
> them all fail.
>
> Something like this, perhaps?
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 1a60faad2e49..ae0abab56d38 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1871,6 +1871,10 @@ static int insert_page_into_pte_locked(struct vm_a=
rea_struct *vma, pte_t *pte,
>
>         if (!pte_none(ptep_get(pte)))
>                 return -EBUSY;
> +       if (folio->mapping &&
> +           ((addr - vma->vm_start) / PAGE_SIZE + vma->vm_pgoff) !=3D
> +           (folio->index + folio_page_idx(folio, page)))
> +               return -EINVAL;
>         /* Ok, finally just insert the thing.. */
>         folio_get(folio);
>         inc_mm_counter(vma->vm_mm, mm_counter_file(folio));

