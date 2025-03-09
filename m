Return-Path: <linux-fsdevel+bounces-43551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B27A58650
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 18:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2CD188D3CD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 17:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06C31E51F9;
	Sun,  9 Mar 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALHnDMhe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16492DF42
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Mar 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541634; cv=none; b=rgjzbyrtVVa3YIIBNAYaD5f75hkYLr7SrFONcQWRl50ExXzjAT4GOedCG+pGjEx4GMIOpohp9GtYR0elAkae/uhJbvDea/ptclIg53aSDLMZmOAXoJaB1uQp4wF+uQIdgqRpOTg/uSwv9xTcohn9YLwuL7+b2lEhQXE/YnhdAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541634; c=relaxed/simple;
	bh=ksP0cXW8blsb4N3DQKO2j9P0hpNgct+vTqOK+wzNzc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkx2kzZKX6r//lPRu5nzt98sFCfUA8zZ6GdIrTr2LB2XtCGdhC5/ZzAq97vdh1Ry6zOZf8B03I9ThRrmuiEv/Si+I1Tj0c4+IzMCeZRjzeqEqGVxavCWdstXb8Nr5u6KdDf0DSHDujeRwS287xwB17Xr+Uk5Ce+vuu1YtFGqHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALHnDMhe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741541630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeae9JjlVYfhzOaUnO+d6huNE0ieO5ZoDoGmXZOCzww=;
	b=ALHnDMheDu6N9BAXBVUVOE9gPNQcqJUmjukxBZ5gMMIINiHJpH/OmOnQ8HepOQJ6QgtOg9
	H0vjGThNpPM5Q6Q/HlEs589XI/oKvEKPSDqefZj221xglKgqwiughZyjtFc+/kI7MyvD/B
	py9rm1+Lo6kvuD/WM/JCZLQLmZxg9Oo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-jik8zoVPO6WpjUe94eL_5A-1; Sun, 09 Mar 2025 13:33:49 -0400
X-MC-Unique: jik8zoVPO6WpjUe94eL_5A-1
X-Mimecast-MFC-AGG-ID: jik8zoVPO6WpjUe94eL_5A_1741541628
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2242ca2a4a5so26123575ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Mar 2025 10:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541627; x=1742146427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeae9JjlVYfhzOaUnO+d6huNE0ieO5ZoDoGmXZOCzww=;
        b=dlP6ti6zNr2GOKQ/Js1f4vX9N1Sqex+14ZPi/fd45QqiXOebzF1Ocvff6fCdp73ih4
         qguZVe6d8fkhGeoN+pViO2x0R+Nt1WV9bKDg6rFgXFs7SvlJVojO/wek4oDw7taQuXZM
         Pvd8wPQ5+A/BRtXZvAVGpjzksOnbWwSKMCPNTWqNSZyCzmWn6IFri3ILA927wIMAiBqh
         f9ImPhVEYuxeyBADSQNgz8M1amYO+AWjUz4nez77qe6otatJIXJU3OKXhU+LaREjxs0W
         0fYQ5nZRvl1kqHxwjSbF4uFfOTvKxk9KDcw/yzzpfQtBZnVyC/Pqf67UHy7K7o1+joqs
         r3xg==
X-Forwarded-Encrypted: i=1; AJvYcCWjUF2m97oIgGrlshRGniWWAgZx1vZkZbH1t2oNZ4dHwe+QGp8SxyX3vQFHWjFOcttVlosbjNri3fYlWT6W@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlx1SGTkoT66aFNtaEQy+tukmUTagEitXe/6/HpKUmUvp4Hghz
	b9VXaN43Ut3ZBwCy0Qj8KsNi2UJB+Kn0Xl5GU1BDWRuWVGiz8YIYrs0VKTY2m0279BiOphD4Rsc
	aJhS9s8Cy9I/4/zao5OydokDRzIzerAhwRFWQAv37Bz6NvBa0QXlTNDdVij8Qs1VmGX0Qf4A1DX
	mYtl1sqDAZeUAOeNV5Z8wb/t2kl4R4DaNFCguLsrNpG4YyGQ==
X-Gm-Gg: ASbGnctOyspOPvJbBBnN51z+KnA8vMkN6Aq64cyZr/Tzf6G49RVtGDyrDiKuFG+VKmV
	h0gI/zfY4NPxbMMOCQRmF+fWdno4EtX2yYRd5pB8xwDqfg/TdpalG/Gir69pno75QsN/8qpU=
X-Received: by 2002:a17:902:ec91:b0:223:5e54:c521 with SMTP id d9443c01a7336-22428407e93mr160560625ad.0.1741541626939;
        Sun, 09 Mar 2025 10:33:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVeDJCNpU/bu5I9HyJljFTkBhxqx876qq4ego7LCzUKnkF4Lo6jqqGi8h0EorvxRQ+zWmeRpKHOCEFD82UudY=
X-Received: by 2002:a17:902:ec91:b0:223:5e54:c521 with SMTP id
 d9443c01a7336-22428407e93mr160560415ad.0.1741541626548; Sun, 09 Mar 2025
 10:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210133448.3796209-1-willy@infradead.org> <20250210133448.3796209-8-willy@infradead.org>
In-Reply-To: <20250210133448.3796209-8-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 9 Mar 2025 18:33:34 +0100
X-Gm-Features: AQ5f1JoErhymXT73WDCjWnMgsHtNHHCwZXK7ooTdMPlPz3zxsx8DcT30iEwSeZM
Message-ID: <CAHc6FU5GrXSfxiRyrx_ShR7hJkCMaQD=k-mhTJ37CzbUMR68dQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] gfs2: Convert gfs2_end_log_write_bh() to work on a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 2:35=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> gfs2_end_log_write() has to handle bios which consist of both pages
> which belong to folios and pages which were allocated from a mempool and
> do not belong to a folio.  It would be cleaner to have separate endio
> handlers which handle each type, but it's not clear to me whether that's
> even possible.
>
> This patch is slightly forward-looking in that page_folio() cannot
> currently return NULL, but it will return NULL in the future for pages
> which do not belong to a folio.
>
> This was the last user of page_has_buffers(), so remove it.

Right now in for-next, ocfs2 is still using page_has_buffers(), so I'm
going to skip this part.

Thanks,
Andreas


> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/lops.c              | 28 ++++++++++++++--------------
>  include/linux/buffer_head.h |  1 -
>  2 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 30597b0f7cc3..8b46bd01a448 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -157,7 +157,9 @@ u64 gfs2_log_bmap(struct gfs2_jdesc *jd, unsigned int=
 lblock)
>  /**
>   * gfs2_end_log_write_bh - end log write of pagecache data with buffers
>   * @sdp: The superblock
> - * @bvec: The bio_vec
> + * @folio: The folio
> + * @offset: The first byte within the folio that completed
> + * @size: The number of bytes that completed
>   * @error: The i/o status
>   *
>   * This finds the relevant buffers and unlocks them and sets the
> @@ -166,17 +168,13 @@ u64 gfs2_log_bmap(struct gfs2_jdesc *jd, unsigned i=
nt lblock)
>   * that is pinned in the pagecache.
>   */
>
> -static void gfs2_end_log_write_bh(struct gfs2_sbd *sdp,
> -                                 struct bio_vec *bvec,
> -                                 blk_status_t error)
> +static void gfs2_end_log_write_bh(struct gfs2_sbd *sdp, struct folio *fo=
lio,
> +               size_t offset, size_t size, blk_status_t error)
>  {
>         struct buffer_head *bh, *next;
> -       struct page *page =3D bvec->bv_page;
> -       unsigned size;
>
> -       bh =3D page_buffers(page);
> -       size =3D bvec->bv_len;
> -       while (bh_offset(bh) < bvec->bv_offset)
> +       bh =3D folio_buffers(folio);
> +       while (bh_offset(bh) < offset)
>                 bh =3D bh->b_this_page;
>         do {
>                 if (error)
> @@ -186,7 +184,7 @@ static void gfs2_end_log_write_bh(struct gfs2_sbd *sd=
p,
>                 size -=3D bh->b_size;
>                 brelse(bh);
>                 bh =3D next;
> -       } while(bh && size);
> +       } while (bh && size);
>  }
>
>  /**
> @@ -203,7 +201,6 @@ static void gfs2_end_log_write(struct bio *bio)
>  {
>         struct gfs2_sbd *sdp =3D bio->bi_private;
>         struct bio_vec *bvec;
> -       struct page *page;
>         struct bvec_iter_all iter_all;
>
>         if (bio->bi_status) {
> @@ -217,9 +214,12 @@ static void gfs2_end_log_write(struct bio *bio)
>         }
>
>         bio_for_each_segment_all(bvec, bio, iter_all) {
> -               page =3D bvec->bv_page;
> -               if (page_has_buffers(page))
> -                       gfs2_end_log_write_bh(sdp, bvec, bio->bi_status);
> +               struct page *page =3D bvec->bv_page;
> +               struct folio *folio =3D page_folio(page);
> +
> +               if (folio && folio_buffers(folio))
> +                       gfs2_end_log_write_bh(sdp, folio, bvec->bv_offset=
,
> +                                       bvec->bv_len, bio->bi_status);
>                 else
>                         mempool_free(page, gfs2_page_pool);
>         }
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 932139c5d46f..fab70b26e131 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -182,7 +182,6 @@ static inline unsigned long bh_offset(const struct bu=
ffer_head *bh)
>                 BUG_ON(!PagePrivate(page));                     \
>                 ((struct buffer_head *)page_private(page));     \
>         })
> -#define page_has_buffers(page) PagePrivate(page)
>  #define folio_buffers(folio)           folio_get_private(folio)
>
>  void buffer_check_dirty_writeback(struct folio *folio,
> --
> 2.47.2
>


