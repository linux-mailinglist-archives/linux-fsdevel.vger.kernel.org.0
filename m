Return-Path: <linux-fsdevel+bounces-62258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28C3B8AE22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 20:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705483A5C75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 18:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDA826657B;
	Fri, 19 Sep 2025 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8h8t1FO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FE126B97D
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305710; cv=none; b=C6RqfG44P7U8bZgr+swtDEr6215mJ+BVzkfRBYeYsJS17pON0yU38/VGGSYssoEmW6MJpPcGMwPxSZZ4lZG8KkUwN8HpXShh1jPKffA0p+9BrxydoW0e7aWxpW+39xP1cYu5nyVxzNA+wfgz0F6k7Bp3i5f2Bf3a/CBs0/3IjS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305710; c=relaxed/simple;
	bh=SU7ouAUS4fSEsX0AQf3RRT7FNWxnC3izv7DdmJIVxho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5yNZdo1lxfmkYbQBG9GsLEhzGSIao5qThyAmjbQK5/2gvYL44LqqPb6SCfjNUZ58OkvDuF3pLvnO3MSQbNTZKTm/VzbMRChhbCdl11+7J6dprxRihBIpJgWjMfJ0Mu5qpgBUSdrFzE5UMhCQ9ex4UVr1tIbGkJ0hSerHKYpjas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8h8t1FO; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b7997a43ceso27586951cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305705; x=1758910505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rc3o0DtMuxjBD1JkaH5/eYeaLZxutE0LWJ2BWNFmsE=;
        b=Q8h8t1FOkV8QAhLeMmDjN5OIZwpQtvb0LBdiHlVebFzkJ3dIF22epcu1V4lPBXbNKq
         dkjo9AGwNjlgLrBYQkkvOBmFRc7XSrlHQnuLGCkORH3xrLBLYaFd1PPenwn7EHdEm1Px
         6I8sCsgxYgbKJXT7L8kAWS6uCN9OibPhB2pf8GmhqTwCEhwq+Pl5kEwprOvCKJYfEhr8
         pFCcKSh7LyIg1KsmIviqIz949LB98/twp4b1W5bXC1RTE/C2/QkCR4+qEkz4ofUGNwmJ
         BbgfcfhbaTUlXwKjvwWC55j5o18s9PRKs0HVRLPrjA5sk5Nk7tiKoTCs75YgeodnwdBD
         A//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305705; x=1758910505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Rc3o0DtMuxjBD1JkaH5/eYeaLZxutE0LWJ2BWNFmsE=;
        b=SdpBxODH9Mag8mjgI7rUHBnbNrJ+GXNr+EYv7WcQcNvtsaBQ2v6uOzaIvJuPUSmGPa
         JtWrwDpmp3W1uy4ood5H12XUPGDwLg1W+n8nZJITz7Zygkxru+pmXBtceKOYRZFGBERn
         WeX3U3bykzAenM4EmFXciweiPGxW42iAB0fzESpSGUxH+H9x+DbMp05mn/WW6i8n+GfY
         J4Jw8TjXbR/02QIFEJm6uCB+f38kITtjbB2MUsLzkR57T4TzBosEO+UHG587GKzU/i1C
         d2ZIL9MWMr4CUH+/aLE/WIjSmIBEh4D+dPTHNRYKEm1nLtTVBImHeOEqDHCtrTT3wZvv
         IW3g==
X-Forwarded-Encrypted: i=1; AJvYcCU3vhh1+Yv0EBDNf866iBIm5INBLKNAyV5a2BNNwJbwsmXEWGExiqI6SCc2Vo+ojJHnPdDnWi3ADAQ9nO5m@vger.kernel.org
X-Gm-Message-State: AOJu0YxEuenTxUvM5MekZuxklU3jKiZ5oq4vsOC3BwvG+fC8RN0092RJ
	bO0wuFn2BntS+tQWbz0r9Sz8rT5+slHi0ZiekouLiKFF7Gsp0V5Md6y5LQ9PXwUbimWmwRkKQZA
	jq+fFiRi/kdFNLlAOPvRuWZGI4+DlP/c=
X-Gm-Gg: ASbGnctCUwiNQSCk08jiQ5b8hwDUzHiVA+4SgL90HMIytNDjYfA4+UFxcaD7PKDubuN
	4cuqU6rkLCgpq0Eb7tv3+R+k6VF5m2TN8VXCf3bZDVVL1UzutF4kie8IHyJ4IiVe9F5eU+ix+uo
	3d0n7EuJZ3QSKe3r+gFsKmayAWDlsbW76jn6mZ2VUi6pCrnZsGWip8+YoybQAO8m6a1M+y9vGfO
	DFnwr7Gsr7VLcAzc3VGVKFefFmPpW4s5xu9gvIq
X-Google-Smtp-Source: AGHT+IFqVuAbTud8sr5sQDzUbR4SVBdcuk43pldjIoGePaUBz5b0yq9EV02amkv9JjhitX99n9+uqsw7zVrBa9moCeo=
X-Received: by 2002:a05:622a:13c6:b0:4b5:d9a1:fe38 with SMTP id
 d75a77b69052e-4c0720ab81emr54958861cf.38.1758305705459; Fri, 19 Sep 2025
 11:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-8-joannelkoong@gmail.com> <20250918214953.GW1587915@frogsfrogsfrogs>
In-Reply-To: <20250918214953.GW1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 19 Sep 2025 11:14:53 -0700
X-Gm-Features: AS18NWBx_3JdX9ikwterXg-lOW9lZ51jYQabtjy-zedgbMsJztKl5lVrFUJr6dY
Message-ID: <CAJnrk1Z1Cqi_PGhjRyiAOV-QrYLJyq=jh0_c+E9q0xYPjBmz_Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] iomap: track read/readahead folio ownership internally
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:49=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Sep 16, 2025 at 04:44:17PM -0700, Joanne Koong wrote:
> > The purpose of "struct iomap_read_folio_ctx->cur_folio_in_bio" is to
> > track folio ownership to know who is responsible for unlocking it.
> > Rename "cur_folio_in_bio" to "cur_folio_owned" to better reflect this
> > purpose and so that this can be generically used later on by filesystem=
s
> > that are not block-based.
>
> Hrmm, well if this is becoming a private variable, then I'd shorten it
> to "folio_owned" since it's not really in the ctx/cur anymore, but I
> might be bikeshedding now. :)

Oo I'll do this for ->read_folio (and for the arg name in
iomap_read_folio_iter()) since there's only 1 folio which makes it
obvious which folio it is, but for ->readahead I'll keep it as
"cur_folio_owned" to make it more obvious that the folio owned state
refers to the folio in ctx->cur_folio.

>
> > Since "struct iomap_read_folio_ctx" will be made a public interface
> > later on when read/readahead takes in caller-provided callbacks, track
> > the folio ownership state internally instead of exposing it in "struct
> > iomap_read_folio_ctx" to make the interface simpler for end users.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
> >  1 file changed, 23 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 6c5a631848b7..587bbdbd24bc 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -352,7 +352,6 @@ static void iomap_read_end_io(struct bio *bio)
> >
> >  struct iomap_read_folio_ctx {
> >       struct folio            *cur_folio;
> > -     bool                    cur_folio_in_bio;
> >       void                    *read_ctx;
> >       struct readahead_control *rac;
> >  };
> > @@ -376,7 +375,6 @@ static void iomap_bio_read_folio_range(const struct=
 iomap_iter *iter,
> >       sector_t sector;
> >       struct bio *bio =3D ctx->read_ctx;
> >
> > -     ctx->cur_folio_in_bio =3D true;
> >       if (ifs) {
> >               spin_lock_irq(&ifs->state_lock);
> >               ifs->read_bytes_pending +=3D plen;
> > @@ -413,7 +411,7 @@ static void iomap_bio_read_folio_range(const struct=
 iomap_iter *iter,
> >  }
> >
> >  static int iomap_read_folio_iter(struct iomap_iter *iter,
> > -             struct iomap_read_folio_ctx *ctx)
> > +             struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
> >  {
> >       const struct iomap *iomap =3D &iter->iomap;
> >       loff_t pos =3D iter->pos;
> > @@ -450,6 +448,7 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
> >                       folio_zero_range(folio, poff, plen);
> >                       iomap_set_range_uptodate(folio, poff, plen);
> >               } else {
> > +                     *cur_folio_owned =3D true;
> >                       iomap_bio_read_folio_range(iter, ctx, pos, plen);
> >               }
> >
> > @@ -472,16 +471,22 @@ int iomap_read_folio(struct folio *folio, const s=
truct iomap_ops *ops)
> >       struct iomap_read_folio_ctx ctx =3D {
> >               .cur_folio      =3D folio,
> >       };
> > +     /*
> > +      * If an external IO helper takes ownership of the folio, it is
> > +      * responsible for unlocking it when the read completes.
>
> Not sure what "external" means here -- I think for your project it means
> a custom folio read method supplied by a filesystem, but for the exist
> code (xfs submitting unaltered bios), that part is still mostly internal
> to iomap.
>
> If we were *only* refactoring code I would suggest s/external/async/
> because that's what the bio code does, but a filesystem supplying its
> own folio read function could very well fill the folio synchronously and
> it'd still have to unlock the folio.
>
> Maybe just get rid of the word external?  The rest of the code changes
> look fine to me.

Sounds good, I'll get rid of "external".

Thanks for reviewing this patchset!
>
> --D
>

