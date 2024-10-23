Return-Path: <linux-fsdevel+bounces-32674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545859AD2CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 19:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F41285107
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 17:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676E91D0F73;
	Wed, 23 Oct 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MELeo5ys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB51BCA07
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704247; cv=none; b=OkDo46qAagj9sgSdpkgQ8S7dAGNIEeXidvwr/TpF3lyHJNOn/U6yqQdtGVQETkVjT1V8X6gRGv10l8iNFebQLTrxoDB4jcibsBcuIoX7/emAsi67XrOLh6aSxnBH7NukSLIjKa1c/BtoabSMKMXslkA8IUqfwtMfPGvsI6r85OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704247; c=relaxed/simple;
	bh=HxI6xxm0vIXgqxepiHkaaiiy2i1UTQ+otEG9x5bFUv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T37UEl86jyt747YxD037Hj0gA9+01olGBOIH+98C3ptE1eglzEHtHlQ4jkzyNqywqihApwJ6cfuz3wVQD/bup0la26CpSHbANshLpfeGey6nkRNKia65qmfPQK9yGuyr5P/u9JMTECpN1JM25OVr0jeMG0SadODvklM4qBdh/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MELeo5ys; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460d1145cd8so183851cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729704245; x=1730309045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HedQptZx5lde5cUaVz0NvtHQUI/jB/SeSFJbjhRNq4A=;
        b=MELeo5yso3f6T/B0KQPGRI3cw8z8ih19UMM+G1GUTGXnAwFbBIGVyoEImYjGGSqYMO
         nlEIucCizHn5PGb7XIKnQ1Q6qlYv4towMrExNFQ2/mAEWDnC+xy7uYy+E0RpOjFihRdX
         Ra5K2PbhW7MXJQPL1r5pf55BGR2FzTRQp8ABGFh9POIz3iXnrLY30eLOWswNtzkwbmVQ
         SxBAFF4OX1VHuMUZbmsTezmo7XicPaKYrpin5f2Dgi50E2wjaQwQAipLckjWm35zUMnx
         JvEAbsMj/ndeQZ5fw03OIr9dBrFJKPD1zL9QY4ZCENaiplgALVAIcyCPJCTR1IlJUPxD
         xCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704245; x=1730309045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HedQptZx5lde5cUaVz0NvtHQUI/jB/SeSFJbjhRNq4A=;
        b=H+nYZ3mLG95PtmoLFCCT1UCGdLvurUNj3vU8j/+f0PYEXZkQkCsNE3vYI3W23DnZoB
         UDsNndKzHxd/0wYSanNIw4sfiunRRQGd3Nxf5O0AefYDPR6TK+n0S8YrCLEdNza5IV9Y
         cFYMzadV7xphqccEKS5XUyLFwP8AYswQzX8votxkvVS7cJxqsWf2QKQg8xg8FB+EIbE6
         oMSXSsdmaHJQpXMQZpMYTu1glg+jQt7GG1L9ryTYsFKwoMlgv4tSsJ60qTtmrG5vpak8
         Fej5ExfJ2A0W94cPnfRQbBFNQ6uQQu+Ddlb/asmyEbp3BqpdZvr2fOOYN6VdUNGGdavc
         PQjw==
X-Forwarded-Encrypted: i=1; AJvYcCUqatffULzQrKmDMpHUYv+BQU+lKdrSEMMw3JVh/kXzkZ5G8m+kkMYjJtfTaZkiAhAJnTvO8jJYFBL2HurU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KOWs8o9JS6ukvb4/Oru/DQUtoV1cb+sMoBW2vgRxDfuSbhhV
	4VtYBm9iViNC6MKnV++xSw/9t2q+xsqNLn/LIbZsnY7HWy8jsMKx+t4RAA3Sic7B1Nn8qiZfnU0
	KfzRErHdPtxAkw9pKRy2iLN6xuj8qQT2K
X-Google-Smtp-Source: AGHT+IG4rWp5+D8dyd1zZOqMO+NCLnnwRUkmkhBqbJsFFdm7mjM1hn8keZjGjCDTMTmzjv/RPqMAxOWHYd2V+VLmGFc=
X-Received: by 2002:a05:622a:15cf:b0:460:8d74:3cb4 with SMTP id
 d75a77b69052e-461145b9384mr51566111cf.17.1729704245227; Wed, 23 Oct 2024
 10:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022185443.1891563-1-joannelkoong@gmail.com> <20241022185443.1891563-10-joannelkoong@gmail.com>
In-Reply-To: <20241022185443.1891563-10-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 23 Oct 2024 10:23:54 -0700
Message-ID: <CAJnrk1bwK7rTiQbBL=Q7sco-2yScsYf9y_kGwO-4THyQgZ48wQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] fuse: convert retrieves to use folios
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, willy@infradead.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:54=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> Convert retrieve requests to use folios instead of pages.
>
> No functional changes.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fuse/dev.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 9f860bd655a4..220b1bddb74e 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1728,7 +1728,7 @@ static void fuse_retrieve_end(struct fuse_mount *fm=
, struct fuse_args *args,
>         struct fuse_retrieve_args *ra =3D
>                 container_of(args, typeof(*ra), ap.args);
>
> -       release_pages(ra->ap.pages, ra->ap.num_pages);
> +       release_pages(ra->ap.folios, ra->ap.num_folios);
>         kfree(ra);
>  }
>
> @@ -1742,7 +1742,8 @@ static int fuse_retrieve(struct fuse_mount *fm, str=
uct inode *inode,
>         unsigned int num;
>         unsigned int offset;
>         size_t total_len =3D 0;
> -       unsigned int num_pages;
> +       unsigned int num_folios;
> +       unsigned int num_pages, cur_pages =3D 0;
>         struct fuse_conn *fc =3D fm->fc;
>         struct fuse_retrieve_args *ra;
>         size_t args_size =3D sizeof(*ra);
> @@ -1761,15 +1762,16 @@ static int fuse_retrieve(struct fuse_mount *fm, s=
truct inode *inode,
>         num_pages =3D (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
>         num_pages =3D min(num_pages, fc->max_pages);
>
> -       args_size +=3D num_pages * (sizeof(ap->pages[0]) + sizeof(ap->des=
cs[0]));
> +       args_size +=3D num_pages * (sizeof(ap->folios[0]) + sizeof(ap->fo=
lio_descs[0]));
>
>         ra =3D kzalloc(args_size, GFP_KERNEL);
>         if (!ra)
>                 return -ENOMEM;
>
>         ap =3D &ra->ap;
> -       ap->pages =3D (void *) (ra + 1);
> -       ap->descs =3D (void *) (ap->pages + num_pages);
> +       ap->folios =3D (void *) (ra + 1);
> +       ap->folio_descs =3D (void *) (ap->folios + num_folios);

Agh, I messed this up in the refactoring I did between v1 -> v2. This
should be ap->folios + num_pages. Will fix this in v3.

> +       ap->uses_folios =3D true;
>
>         args =3D &ap->args;
>         args->nodeid =3D outarg->nodeid;
> @@ -1780,7 +1782,7 @@ static int fuse_retrieve(struct fuse_mount *fm, str=
uct inode *inode,
>
>         index =3D outarg->offset >> PAGE_SHIFT;
>
> -       while (num && ap->num_pages < num_pages) {
> +       while (num && cur_pages < num_pages) {
>                 struct folio *folio;
>                 unsigned int this_num;
>
> @@ -1789,10 +1791,11 @@ static int fuse_retrieve(struct fuse_mount *fm, s=
truct inode *inode,
>                         break;
>
>                 this_num =3D min_t(unsigned, num, PAGE_SIZE - offset);
> -               ap->pages[ap->num_pages] =3D &folio->page;
> -               ap->descs[ap->num_pages].offset =3D offset;
> -               ap->descs[ap->num_pages].length =3D this_num;
> -               ap->num_pages++;
> +               ap->folios[ap->num_folios] =3D folio;
> +               ap->folio_descs[ap->num_folios].offset =3D offset;
> +               ap->folio_descs[ap->num_folios].length =3D this_num;
> +               ap->num_folios++;
> +               cur_pages++;
>
>                 offset =3D 0;
>                 num -=3D this_num;
> --
> 2.43.5
>

