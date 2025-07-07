Return-Path: <linux-fsdevel+bounces-54198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F04AFBE98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 01:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447154A327C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 23:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB96A2874F4;
	Mon,  7 Jul 2025 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcFpzgiL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9917DFE7
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751930857; cv=none; b=r8qtNOH7zQJttnR2yCzs64p/wD7ZqR3r8sLHq9SiGR8iT/imFQS2YDFBbFogM4iq50EzvPxuN3FtXaUAsusqWoA5bnF/PpT4AHCd84dMXxCdc+WByfwWXhveeoB1PEAKXI8JPIoxpUw9/hbJ7ZircUv9dxAXsWMe8A2k5neqmKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751930857; c=relaxed/simple;
	bh=GPwPu9gDti3gjYYTt7+8dnpeDy/u3TqH4IBZfgWzizk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5L6jWMwISSJNjRBz+4p3v0FEwqHYSEcXmK6n0wIgDmRVO4/Vj/Zeamb/IAgHIivQ4q2/Hj+efvtNReYP0uGI8IVWc4TgH/gNzc9t0tzKxleGn4toUT86uaA7QgwH5WKOKNrr5NW8q0QkxUeW+xxL9xsQn8lQgXDDDwmm9JvC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcFpzgiL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d0976776dcso434799285a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 16:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751930854; x=1752535654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj5J5JAM34i/mqgMn2C+uf1FAWp7yLFStPcOWEzdlmc=;
        b=OcFpzgiLQJHZuJkT7FVPInm7NdJZUhoJkq7nKx94MSvctoTZnJeNWWcHkHMJfVqVDR
         MmUi4L7737zofnsygjcOg/xAJC/weN2dxuJx5Q0KzciTfzZDo4nilMiJwQtCkHe0Or8l
         IMS8zC2/y1SDPO0MiwQ9opJioPSVxGqkXxL6B6eFG5MEgizbaQ7JM2kkF0Wu15apAAgq
         UCnybGaxiLkqunUuLudT31/8MKsTFGMj/pD5jZ6v3HOmtZtgizvw45lU07IrwZVSD/kE
         pBezK2Z+pw/o7Xe6Ihlrq+/bbvenXuXwQ5HGrsR265X4lUqmL8kSjURE431g75BZZPZd
         xjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751930854; x=1752535654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yj5J5JAM34i/mqgMn2C+uf1FAWp7yLFStPcOWEzdlmc=;
        b=jTfrzbbjqTkMZlpkMFX0cB9G/z99mBpUxliyVZ3KVnvCwOACOfUMg4K1WBLU6iCPaE
         hcSmeuXDjCHfxbec/Lrsg+TnFwDspJTXwKfmIL7/KOKUXBwiF34Nbrs0irTj9Qz3pWb4
         JxREyMwEr9FSPK+4sewUNMlxMqstkw8gbn/EYRNiPxgDcjO2pN/4xFlOmpTTtPkrHhIq
         LWwn1qrLGBQgj1jTxKnGdtA5dOMoFg2Uc9pbL2lPinGbgEAf5cYaA2McQS+Y326hyidJ
         MIfAvQPAdlSAJfiooe9+W9zOa+9r+XJiyexrUYA1O4DLWsGbuzkteVWFk2Q/F2xthxnz
         6JPA==
X-Forwarded-Encrypted: i=1; AJvYcCVT1k+lIznhpHAfNydWDy9raWmghiEDe0SYSvYuhxMPySANzFYC8v1/QeeCC+XnoyqJn7lHjcAiBoiRaU1e@vger.kernel.org
X-Gm-Message-State: AOJu0YzSEsY2bcPeyrLLt92cUGEBshqKKQjjdKni9aw8mlTyTyUgeNec
	/qL8i4hBacJJApj9Qc7xRBNf1XbBBsFE2b082EVNNeerZC3LqhuBLwkAEVwfOlX2X96GEKGgeow
	UIrra9rYF+FBDh+C3z5D+rp1tbQc68II=
X-Gm-Gg: ASbGncuXHTQxeFWozUuoY3HMZT1AJWm0vEUseO2RcRIw/BqM9PWWukuVgAbm/EHbDlR
	7MJEi5vgtkvFsJy8twA4mrUYxBBJ8k7WQ17C3mnRWn7xEMz1uaVecO33kxPH46CioxG/3DOjDUq
	Cm1L7B6mNcZA8WqJ2IT8LS9XooVXapchfZpO7HEXoMrCcYoGmpygVu41SPupg=
X-Google-Smtp-Source: AGHT+IGutRxMccn3PUfXKG4g/WI5URz/N7x6OfCKLLL8cmIxB51QSCy+lw5sb4M2FkN84Dc2iO7O0FSyqYwdMyoJZw8=
X-Received: by 2002:ac8:5f8f:0:b0:4a7:14c3:7405 with SMTP id
 d75a77b69052e-4a9987b088amr238466411cf.27.1751930854452; Mon, 07 Jul 2025
 16:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-11-joannelkoong@gmail.com> <6d9c08dd-c1d0-48bd-aacb-b4300f87d525@redhat.com>
In-Reply-To: <6d9c08dd-c1d0-48bd-aacb-b4300f87d525@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 7 Jul 2025 16:27:23 -0700
X-Gm-Features: Ac12FXyG9BFglLABQ2gx_uPQKw1uMHNQwtb2HfpDZ-C6ELSa63Lb5rOkawRCj94
Message-ID: <CAJnrk1bTe88hy4XSkj1RSC4r+oA=VZ-=jKymt7uoB1q75KZCYg@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] fuse: optimize direct io large folios processing
To: David Hildenbrand <david@redhat.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jlayton@kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 3:24=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 26.04.25 02:08, Joanne Koong wrote:
> > Optimize processing folios larger than one page size for the direct io
> > case. If contiguous pages are part of the same folio, collate the
> > processing instead of processing each page in the folio separately.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/fuse/file.c | 55 +++++++++++++++++++++++++++++++++++++------------=
-
> >   1 file changed, 41 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 9a31f2a516b9..61eaec1c993b 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1490,7 +1490,8 @@ static int fuse_get_user_pages(struct fuse_args_p=
ages *ap, struct iov_iter *ii,
> >       }
> >
> >       while (nbytes < *nbytesp && nr_pages < max_pages) {
> > -             unsigned nfolios, i;
> > +             struct folio *prev_folio =3D NULL;
> > +             unsigned npages, i;
> >               size_t start;
> >
> >               ret =3D iov_iter_extract_pages(ii, &pages,
> > @@ -1502,23 +1503,49 @@ static int fuse_get_user_pages(struct fuse_args=
_pages *ap, struct iov_iter *ii,
> >
> >               nbytes +=3D ret;
> >
> > -             nfolios =3D DIV_ROUND_UP(ret + start, PAGE_SIZE);
> > +             npages =3D DIV_ROUND_UP(ret + start, PAGE_SIZE);
> >
> > -             for (i =3D 0; i < nfolios; i++) {
> > -                     struct folio *folio =3D page_folio(pages[i]);
> > -                     unsigned int offset =3D start +
> > -                             (folio_page_idx(folio, pages[i]) << PAGE_=
SHIFT);
> > -                     unsigned int len =3D min_t(unsigned int, ret, PAG=
E_SIZE - start);
> > +             /*
> > +              * We must check each extracted page. We can't assume eve=
ry page
> > +              * in a large folio is used. For example, userspace may m=
map() a
> > +              * file PROT_WRITE, MAP_PRIVATE, and then store to the mi=
ddle of
> > +              * a large folio, in which case the extracted pages could=
 be
> > +              *
> > +              * folio A page 0
> > +              * folio A page 1
> > +              * folio B page 0
> > +              * folio A page 3
> > +              *
> > +              * where folio A belongs to the file and folio B is an an=
onymous
> > +              * COW page.
> > +              */
> > +             for (i =3D 0; i < npages && ret; i++) {
> > +                     struct folio *folio;
> > +                     unsigned int offset;
> > +                     unsigned int len;
> > +
> > +                     WARN_ON(!pages[i]);
> > +                     folio =3D page_folio(pages[i]);
> > +
> > +                     len =3D min_t(unsigned int, ret, PAGE_SIZE - star=
t);
> > +
> > +                     if (folio =3D=3D prev_folio && pages[i] !=3D page=
s[i - 1]) {
>
> I don't really understand the "pages[i] !=3D pages[i - 1]" part.
>
> Why would you have to equal page pointers in there?
>

The pages extracted are user pages from a userspace iovec. AFAICT,
there's the possibility, eg if userspace mmaps() the file with
copy-on-write, that the same physical page could back multiple
contiguous virtual addresses.

>
> Something that might be simpler to understand and implement would be usin=
g
>
>         num_pages_contiguous()
>
> from
>
>         https://lore.kernel.org/all/20250704062602.33500-2-lizhe.67@byted=
ance.com/T/#u
>
> and then just making sure that we don't exceed the current folio, if we
> ever get contiguous pages that cross a folio.

Thanks for the link. I think here it's common that the pages array
would hold pages from multiple different folios, so maybe a new helper
num_pages_contiguous_folio() would be useful to return back the number
of contiguous pages that are within the scope of the same folio.


Thanks,
Joanne
>
>
> --
> Cheers,
>
> David / dhildenb
>

