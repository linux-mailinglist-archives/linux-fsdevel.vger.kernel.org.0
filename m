Return-Path: <linux-fsdevel+bounces-43554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76383A587E5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 20:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B05167377
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 19:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60342153F5;
	Sun,  9 Mar 2025 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpAHPKrG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C76F2153CF
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Mar 2025 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741549418; cv=none; b=ZMHD4uZoqambJm48ZQByGRlzWiXGHf5SnXri8r3D1a7gu/N534w4aHlu+Haa412dLdGgAyCAGe6M+mAVsHrdZkTOx8KzkwY0QSjshPCiyIxu+0nZcFAEeMmEvFcnWwS7RBFmGVI+sEdAUW/b8mxBoQm/EobggZU0CcEdZO1ezu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741549418; c=relaxed/simple;
	bh=PcXEvTmP0Nmq5iRQTwGA/fVuglGMEBJWCiim3Cel88Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pv1sGW5SM2EtoIPETwUZULfno5zqjHNTpQlTiayKBMPH2Moca9JSiD1oiLt04nxrfGyHv8HeVbP69Qn+WKM+FN/fS9mZg/VrviDnY3g2JRJYl4nAMsJ8Qu/03PWwjZJXszcCXrL1hmi2YbHIwsCwgvp/0rFIelDaIFdP6/pSGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpAHPKrG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741549414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmlFQWhZKZbPGn7ZfFNpeUgMQE0KdEQP748zRbes2mM=;
	b=HpAHPKrG8Uj5qLdr9vr1NPLfovIH8OXnOu4LOruMsAGbyZzZWa/qEtLsdzFGSFGXT626Hx
	eKlbd3CDWxqLeBfY9YavfGXQXf6jAcmrIwu6i2P4KclGmnEwFh7e91qiaSoPWhL0ljE3Q7
	G2KHqv5LPEuhlmbhkZLSlJ6yUqLg0jM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-aj7NrglNPnO15pRDVu-o0A-1; Sun, 09 Mar 2025 15:43:32 -0400
X-MC-Unique: aj7NrglNPnO15pRDVu-o0A-1
X-Mimecast-MFC-AGG-ID: aj7NrglNPnO15pRDVu-o0A_1741549412
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22410b910b0so47233665ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Mar 2025 12:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741549410; x=1742154210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmlFQWhZKZbPGn7ZfFNpeUgMQE0KdEQP748zRbes2mM=;
        b=AR1cDbSKwqqpMfXQ87ncNMVHtcuWkfrLBi1/CiuYm+q+yZi/X18/vYRGfy+FBwLtJT
         jOkTVN2vDreCDIfAFXl7UtAZqH9diCuUM7aPk/utazranTRHjSkhiDwbVdeDZr9SpVR8
         GkTss6mgHkRJcQcXLsIab/Dq36MjVmzE9CmBzl020SY9vU4rK7moH3UenDuTgheXvcFo
         /5EmOsJJUM6zEqwHYDxDUDt2Xfw+EVYbP+1qhiYVqKgSRrKZQuioil61SC7TEkf31nv8
         44ULcv5ux+q+w4aT8qbvau9NSmcpZ6dgBaez2zmuXTavMMu76dl3r42G6NHPsInU9DEs
         XUPA==
X-Forwarded-Encrypted: i=1; AJvYcCXJmw0A27UCpRzjt2Rnlq0/Y8T0xn5NmKP/kKtBQi5QKvGE2UVsQX+d/34k50iVTWMcWD3zE39vHWD9c+D8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+feaCNCwynJuY5Dd7kVYlZqJfd/9XAaemqMVSFhOokH04Ew3I
	mD76oNNCAq8gwD7GOrYZNfRFqGpNjzRfiOOsn6K20iyjHENvMljUHstyvTL3eR/oKa2z/lq2sE0
	OkyW6HrOoyBQVadUAtr3HvBVwe3nP2WwsYhSdFn661+dB9RM335+yABWppl21Oxz78j5V4hYWds
	s8wBMN8oQFr9BwRgv6NJUgrvB7cVE2vT0CFNeuohemKbr7AijS
X-Gm-Gg: ASbGncshcI8KExZe7M/KsEBCHuBO+dqIBFRihmFnZ4LlzfpNZdEaOwYhC8o1MfOLXHA
	jr1Ecn8MQFzHlK7hZcIlhM9jNIlGK1X1LvzKUI3c78CB6ydNm/opI2KDj0siet3BZ2Xyi9Gw=
X-Received: by 2002:a17:903:234f:b0:224:18bb:44c2 with SMTP id d9443c01a7336-22428881fcfmr148875025ad.6.1741549410185;
        Sun, 09 Mar 2025 12:43:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSAbOntYSkhj1Cxv/OKzLZ+MTf5PVqVJzDQBxypFycd8UKOYukszbnBM7t3IP41dFYeJF0GgjcCRZgdLMMPds=
X-Received: by 2002:a17:903:234f:b0:224:18bb:44c2 with SMTP id
 d9443c01a7336-22428881fcfmr148874895ad.6.1741549409900; Sun, 09 Mar 2025
 12:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210133448.3796209-1-willy@infradead.org> <20250210133448.3796209-7-willy@infradead.org>
In-Reply-To: <20250210133448.3796209-7-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 9 Mar 2025 20:43:18 +0100
X-Gm-Features: AQ5f1JrJmS3XoJdt7uF7y2sdMDjqqEnMKkCOFpiHJUUXqMVVe6GJ1yX0jC0X5_k
Message-ID: <CAHc6FU4oR4bkDgfqEweHAmoMDUVtGDzDFDU0QAMxx_SrjcQ61w@mail.gmail.com>
Subject: Re: [PATCH 6/8] gfs2: Convert gfs2_find_jhead() to use a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 2:35=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Remove a call to grab_cache_page() by using a folio throughout
> this function.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/lops.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 09e4c5915243..30597b0f7cc3 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -514,7 +514,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs=
2_log_header_host *head,
>         struct gfs2_journal_extent *je;
>         int sz, ret =3D 0;
>         struct bio *bio =3D NULL;
> -       struct page *page =3D NULL;
> +       struct folio *folio =3D NULL;
>         bool done =3D false;
>         errseq_t since;
>
> @@ -527,9 +527,10 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gf=
s2_log_header_host *head,
>                 u64 dblock =3D je->dblock;
>
>                 for (; block < je->lblock + je->blocks; block++, dblock++=
) {
> -                       if (!page) {
> -                               page =3D grab_cache_page(mapping, block >=
> shift);
> -                               if (!page) {
> +                       if (!folio) {
> +                               folio =3D filemap_grab_folio(mapping,
> +                                               block >> shift);
> +                               if (!folio) {
>                                         ret =3D -ENOMEM;
>                                         done =3D true;
>                                         goto out;
> @@ -541,7 +542,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs=
2_log_header_host *head,
>                                 sector_t sector =3D dblock << sdp->sd_fsb=
2bb_shift;
>
>                                 if (bio_end_sector(bio) =3D=3D sector) {
> -                                       sz =3D bio_add_page(bio, page, bs=
ize, off);
> +                                       sz =3D bio_add_folio(bio, folio, =
bsize, off);

The check below needs adjusting: bio_add_folio() returns whether the
addition was successful, not how many bytes were added.

I'll fix that.

>                                         if (sz =3D=3D bsize)
>                                                 goto block_added;
>                                 }
> @@ -562,12 +563,12 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct g=
fs2_log_header_host *head,
>                         bio =3D gfs2_log_alloc_bio(sdp, dblock, gfs2_end_=
log_read);
>                         bio->bi_opf =3D REQ_OP_READ;
>  add_block_to_new_bio:
> -                       sz =3D bio_add_page(bio, page, bsize, off);
> +                       sz =3D bio_add_folio(bio, folio, bsize, off);

Likewise here.

>                         BUG_ON(sz !=3D bsize);
>  block_added:
>                         off +=3D bsize;
> -                       if (off =3D=3D PAGE_SIZE)
> -                               page =3D NULL;
> +                       if (off =3D=3D folio_size(folio))
> +                               folio =3D NULL;
>                         if (blocks_submitted <=3D blocks_read + max_block=
s) {
>                                 /* Keep at least one bio in flight */
>                                 continue;
> --
> 2.47.2
>

Thanks,
Andreas


