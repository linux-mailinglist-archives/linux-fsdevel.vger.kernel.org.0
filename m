Return-Path: <linux-fsdevel+bounces-60692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3F5B5018C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7F31C6404E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EA835337E;
	Tue,  9 Sep 2025 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPx4wJh5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B223352096;
	Tue,  9 Sep 2025 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432046; cv=none; b=A3w5oixoAOHy1f6qkt/tdv9jfVctKWKGY6crCnOrv0hqiwk17ew3CeM7usUcexzvSN0l5WXWM/ik4wAm89F4jW7aSTaeITZ21GJWWkOGDhZCNMhJP4kVVOC12bZkPOK+YfPLOarq1b0qpNML7t5tQC+sk9k1BmuU8BCiqmV0r0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432046; c=relaxed/simple;
	bh=6JlSmRBzOwfJDw81Wdqg0lZlZvfb9SVf6c+eUyxm70k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bL6gjbJSZDDDxqCvGM+9VjEq3EEZAgR1mdDZqo9IDqlDxCe/C6oU0oCAva2c+hozmP1Cd8kKHvuCpWZp7yFKlQdgiHmjXJQjKiFYPUwoL/Z39uuXHHIUVnk9AgJFBU41joWwGsle7yWpS1Sw/GPP95Zc3gK/8Fl08hCOzwsBLJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPx4wJh5; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-811b06efefdso478281185a.1;
        Tue, 09 Sep 2025 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757432044; x=1758036844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nm019m6Jpg9WlE0fDkKmwk8SZTc8G6zXBvzps0igUOY=;
        b=ZPx4wJh5uUKkqSmwWiYmqg0N8R6oYbrYCFlzuTJb/W0dCuLMkxRQAmyB1SqaTROcOM
         DERr4CHMz1+hd1Vb+YUQAg9z4m0J+7YUgBZM+oiVtblkoMq7LynPU+bkOIcRA9NnhKx2
         xBkOk278NMzm0MfK6GE52RTit+Sr3KB6MiYOTfzftLr9t3CHupbNWyqnRh8VgGXoDSMW
         LMllWgG5xKw7OKTc5+TQ48PVQYL3MKIoojRRTXzqOu6E1SRJykpRrVVovYNeJUkmjnbj
         RqNqKEU3wXKKhAh2V6nTRuEUjNwiTcyAhVeQAclTg+2bCroHvnPVj3f+AtTfifxkUa4z
         j4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432044; x=1758036844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nm019m6Jpg9WlE0fDkKmwk8SZTc8G6zXBvzps0igUOY=;
        b=oc6/i1iYgrrVkPobM56JSexEU5ZJzsd2wVM7qzR8EoSOk1a/0PQGC1i84+6OICptGm
         YK3Uzk9NanGCovzNqWpZ8J7UgW4G1fjI1gNBEZ3gILdX28WhjT3xhPozCaWN2BeX20dS
         8a43k/iT3Ca/39L5iyof7PvMv7XACoIAPaRfg7x/eMEDQt5NEbIz+xZIDuJs9Zr5rPek
         meNsoJ5Zwx7PJ9ALR6SKqOaWSAjrHLBpo21NqjhwGs+FBTXup5fUhne2gcN92PfF8hA/
         mFmB4vYc0LpnVVC2oqnV9SM2caUHpOrNU4OWyPiCG/c9NvHWniGnUek8ErgwnnmIHC+3
         5T4A==
X-Forwarded-Encrypted: i=1; AJvYcCU3dxp6m5KKR8XcH717aLzA2dY4Web/pJBB+vklp72HjIYG6HLgFA3yMy4xtisFyKwkKx3NYaReKuo6Y6T6MQ==@vger.kernel.org, AJvYcCUM+tEUSSW3mxCgX49ALAovbxFBSLJ0GDXKdccOQzxG7ZdFuT8laP74Tm1NBkx9JXCpHfe1HX05Ennd@vger.kernel.org, AJvYcCUOKqBo72W0p/qiZZHEoHJ9AAtqP6XQtMPN+k1ZOrnWZAA0akRov0MLdftRWhYHHEbuCfGyipbCogwX0g==@vger.kernel.org, AJvYcCVhhS4bq2/l92d/x8vvPeQOkbM1yGTdyeR1FHQV79kYiM8ukFgXFtew9i2Hxjj+kmiItkvW4EJBtkzF@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCexEv0PSijopCGsvO2vJRrQLilEyDcf46IhN27PgU98snRIf
	MO2OupZk2NNlnGbZ0i3B+OV4S5F0gvuD6hiZTcaRD3u8QM5DdmLnzKKzIk1xRjOCNepl1Hg1DZa
	qdCckazhJDG3Ls5P4Y84jPuhio0dc4Cs=
X-Gm-Gg: ASbGncvQE6Edvp9/72c3HjsYf+Oiyvmi3hJztPgxakf4xTjbcciky/l+llSd76KLKCk
	Iv4Jy40b/bBQcb3huRJAhGS4f4Ig3Ik3UTO0zdTv9iSzmFvXM1Oylrf0IPzHbYJCOyVUoIpzcnD
	ptoa1H5kzBJpqL5MPSN4zvdcchlBBL2NsNxaMmO6HCZ/6cmqKZDvhsJoinFLiyYHgzfUwZ4gNPq
	O7TBc57hxlg7FVDG58BDS8=
X-Google-Smtp-Source: AGHT+IHsvKQIqY1eKcTSpIDfewB71Vz1SzsjVHsBfXSv4SayZ8R1VsL4otO2UwFpXNAm9zonHXLetqA++OARoiEstzA=
X-Received: by 2002:a05:620a:a207:b0:814:ac72:cb53 with SMTP id
 af79cd13be357-814ac72ce37mr1348060785a.39.1757432042924; Tue, 09 Sep 2025
 08:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-14-joannelkoong@gmail.com> <a1529c0f-1f1a-477a-aeeb-a4f108aab26b@linux.alibaba.com>
In-Reply-To: <a1529c0f-1f1a-477a-aeeb-a4f108aab26b@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 9 Sep 2025 11:33:49 -0400
X-Gm-Features: Ac12FXxmaTYFDfytENNUUKz7GREv8kkuFk-74PyqDa4R1bwoLlwwHTGCX5N6tT0
Message-ID: <CAJnrk1aCCqoOAgcPUpr+Z09DhJ5BAYoSho5dveGQKB9zincYSQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	djwong@kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:14=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> On 2025/9/9 02:51, Joanne Koong wrote:
> > There is no longer a dependency on CONFIG_BLOCK in the iomap read and
> > readahead logic. Move this logic out of the CONFIG_BLOCK guard. This
> > allows non-block-based filesystems to use iomap for reads/readahead.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >   fs/iomap/buffered-io.c | 151 +++++++++++++++++++++-------------------=
-
> >   1 file changed, 76 insertions(+), 75 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index f673e03f4ffb..c424e8c157dd 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -358,81 +358,6 @@ void iomap_finish_folio_read(struct folio *folio, =
size_t off, size_t len,
> >   }
> > +
> > +/**
> > + * Read in a folio range asynchronously through bios.
> > + *
> > + * This should only be used for read/readahead, not for buffered write=
s.
> > + * Buffered writes must read in the folio synchronously.
> > + */
> > +static int iomap_read_folio_range_bio_async(const struct iomap_iter *i=
ter,
> > +             struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen=
)
> > +{
> > +     struct folio *folio =3D ctx->cur_folio;
> > +     const struct iomap *iomap =3D &iter->iomap;
> > +     size_t poff =3D offset_in_folio(folio, pos);
> > +     loff_t length =3D iomap_length(iter);
> > +     sector_t sector;
> > +     struct bio *bio =3D ctx->private;
> > +
> > +     iomap_start_folio_read(folio, plen);
> > +
> > +     sector =3D iomap_sector(iomap, pos);
> > +     if (!bio || bio_end_sector(bio) !=3D sector ||
> > +         !bio_add_folio(bio, folio, plen, poff)) {
> > +             gfp_t gfp =3D mapping_gfp_constraint(folio->mapping, GFP_=
KERNEL);
> > +             gfp_t orig_gfp =3D gfp;
> > +             unsigned int nr_vecs =3D DIV_ROUND_UP(length, PAGE_SIZE);
> > +
> > +             if (bio)
> > +                     submit_bio(bio);
> > +
> > +             if (ctx->rac) /* same as readahead_gfp_mask */
> > +                     gfp |=3D __GFP_NORETRY | __GFP_NOWARN;
> > +             bio =3D bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> > +                                  REQ_OP_READ, gfp);
> > +             /*
> > +              * If the bio_alloc fails, try it again for a single page=
 to
> > +              * avoid having to deal with partial page reads.  This em=
ulates
> > +              * what do_mpage_read_folio does.
> > +              */
> > +             if (!bio)
> > +                     bio =3D bio_alloc(iomap->bdev, 1, REQ_OP_READ, or=
ig_gfp);
> > +             if (ctx->rac)
> > +                     bio->bi_opf |=3D REQ_RAHEAD;
> > +             bio->bi_iter.bi_sector =3D sector;
> > +             bio->bi_end_io =3D iomap_read_end_io;
> > +             bio_add_folio_nofail(bio, folio, plen, poff);
> > +             ctx->private =3D bio;
>
> Yes, I understand some way is needed to isolate bio from non-bio
> based filesystems, and I also agree `bio` shouldn't be stashed
> into `iter->private` since it's just an abuse usage as mentioned
> in:
> https://lore.kernel.org/r/20250903203031.GM1587915@frogsfrogsfrogs
> https://lore.kernel.org/r/aLkskcgl3Z91oIVB@infradead.org
>
> However, the naming of `(struct iomap_read_folio_ctx)->private`
> really makes me feel confused because the `private` name in
> `read_folio_ctx` is much like a filesystem read context instead
> of just be used as `bio` internally in iomap for block-based
> filesystems.
>
> also the existing of `iter->private` makes the naming of
> `ctx->private` more confusing at least in my view.

Do you think "ctx->data" would be better? Or is there something else
you had in mind?

Thanks,
Joanne
>
> Thanks,
> Gao Xiang

