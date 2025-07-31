Return-Path: <linux-fsdevel+bounces-56443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5095B17628
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 20:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD162565A8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C174246765;
	Thu, 31 Jul 2025 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKbEt48x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66923244683;
	Thu, 31 Jul 2025 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987445; cv=none; b=kQFoC1bt2HEM7D7f4AH0FHFSn8P8lPqAYexyDOI2hsrstMem7xPKdnXuHFhtXYXWBslXVNVBW+/g3nQK9K1jegXHWXQnH/pNtq1ZpW1ccnfMe7lR7teSGIoUeZsCvqEaBP6Lq/nOB4L2QI8hakD9bd8TIMEt4Z6oHzmgcZTOlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987445; c=relaxed/simple;
	bh=tOlKv+rrqN8To+nBSfkJkq09zspUm1W/xy9Q+MCRv7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSHF2cXJ2e6kAGgQijGc/hFZwG7sJOk7WmdUqO9EL2mJOo5j4ClLXT3Dt4mExSeo8BYsKEo5Pf3oJ/skeFSAOhbjpkTe38il8BISIJvhprOKv5V+rQdKE7kaswI029u1GcMk9/5pLmvpN5QnuJ0glL4NJ+MNE4uXAHUhtLUf4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKbEt48x; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab7384b108so14162421cf.0;
        Thu, 31 Jul 2025 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753987443; x=1754592243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWFqYWagfMR599n+3OklK/FNUCb6LoOeJiS/8Fkl7VE=;
        b=JKbEt48xcIvkzhSlZvi2GHxKmpQrnPPw7UoF3KUVxCkhySBamKW7f0I0Bgedi1Q2I6
         GKQYl3+VyanPBErqxczS4nyHzf955B8XeW2/25PFHRZGQ4hT43uuFdgomTeDt1nX0HAA
         /A23/BeNtthzHOyOXC18Bzj1R6gE6Hka4Ii+uRcp0mT4zTUaZFqd/00vBNE06YCN3lER
         LLNwHO5wNS9zJ2FWg3m+/i7CnYHSeBa5gnw+Y+k7nl3ZdWeWqbJVfoxP9ZBfnGkCyr5Z
         Bz8j+I/DMA+GeK3CANMCR+7kTWU10P5O9H3fYYBmBKntO0hSxvI25DLKxHnHYcnZChrR
         jmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753987443; x=1754592243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWFqYWagfMR599n+3OklK/FNUCb6LoOeJiS/8Fkl7VE=;
        b=voQlHWgXis3dOcHOM5qBNH7Ottei+hWstXnyTP57t8VQNnqTpCZH5cCWoZguEr5heK
         rNGavxxEaNj87ucS4rYZKR4hP0DcMzF9dDsirNMnQZnCgAYPa1vVUyOc5wPvyT6PoAMx
         g6AxfymD0squ3ydunGq4gdN/h+BS1AUnqXoqELhPkCc86IgOuBOZLRzvlgZJJinrociA
         0IoiRL992dorbLKcLVKk6u0EhxdYl9dOOYQf5j+TvkNw3OP7IdZroqSN3ZGHf9yyeq1H
         5tJijQwZnQM12Dyu0w3Ue3rSNGOy2UnM/snS4ZdWdzCi34liNL/uCgR0z+ZwMrzLqaz+
         8rpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjBhytHdkErdW29gpZ2Cx4bMenE587EO0dyS72DjrSIBWb/3CamlefniFpBLNh4Ks3pw5s+IvglG+L@vger.kernel.org, AJvYcCVV3LOJ4BC5bfxqONHGJDs+/18RfjS86ed1kuWyU9N/A5DlbwbreNmnBXiIGu6CHDexCGhRYqHjqc7gAV9F@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOQ5QNxJ6ZduNOPmGiQCG235vlN1x/TbvipP6rbt/2ppL+V9y
	eTw7OI09C+igL/tNK9NFTI2ELzqmTLtOlRU5wy1xckYcHofDFqOGDiV1ShCr4i0AAv4C5pCab64
	4HN93cYv0EZt+V/6mx6diYKA1a7ARfig=
X-Gm-Gg: ASbGncszCT+VM5AKd/mrTL3r42G3QaJ1HUJ8gvvBy7bmjizGooYLbIRPQia5X8R47ZO
	XWnQsBNTTuW3wcBn9AyqncJ0i+FTyw0G7ap6pKVEiEzG/5/nxf2p9WpcUwkoBQfLAKEK9l1VEwP
	w1ZL4Bxm/u09jdInWoaQSRe/MSv/wltuJCyfBkW1XtLDY3mxEsN1lRPvhnvaR2BOw9FCtSQrnw1
	ssHhdE=
X-Google-Smtp-Source: AGHT+IHhmBCqS24+8APnTa5CCpdzZoO0Ss4gHmN8YdL9USrYxqpqCeTk85bpPFY2B5ZsPWcuDuGL6f99NahYgIphCkU=
X-Received: by 2002:ac8:5dc6:0:b0:4ab:701c:aa35 with SMTP id
 d75a77b69052e-4aedbc739c2mr132504291cf.39.1753987442924; Thu, 31 Jul 2025
 11:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org> <20250728-fsverity-v1-1-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-1-9e5443af0e34@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 31 Jul 2025 11:43:52 -0700
X-Gm-Features: Ac12FXxuG9VYtsh9H3COp6V24MyEeFZcljh_lSDrbHaWBLofpef5AmKZCKzspPg
Message-ID: <CAJnrk1ambrfq-bMdTSgj=pPrGW6GA1Jgwjvx8=sy8SVR67=bJA@mail.gmail.com>
Subject: Re: [PATCH RFC 01/29] iomap: add iomap_writepages_unbound() to write
 beyond EOF
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
	ebiggers@kernel.org, hch@lst.de, Andrey Albershteyn <aalbersh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 1:31=E2=80=AFPM Andrey Albershteyn <aalbersh@redhat=
.com> wrote:
>
> From: Andrey Albershteyn <aalbersh@redhat.com>
>
> Add iomap_writepages_unbound() without limit in form of EOF. XFS
> will use this to write metadata (fs-verity Merkle tree) in range far
> beyond EOF.
>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/iomap/buffered-io.c | 51 +++++++++++++++++++++++++++++++++++++++-----=
------
>  include/linux/iomap.h  |  3 +++
>  2 files changed, 43 insertions(+), 11 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3729391a18f3..7bef232254a3 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1881,18 +1881,10 @@ static int iomap_writepage_map(struct iomap_write=
page_ctx *wpc,
>         int error =3D 0;
>         u32 rlen;
>
> -       WARN_ON_ONCE(!folio_test_locked(folio));
> -       WARN_ON_ONCE(folio_test_dirty(folio));
> -       WARN_ON_ONCE(folio_test_writeback(folio));
> -
> -       trace_iomap_writepage(inode, pos, folio_size(folio));
> -
> -       if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> -               folio_unlock(folio);
> -               return 0;
> -       }
>         WARN_ON_ONCE(end_pos <=3D pos);
>
> +       trace_iomap_writepage(inode, pos, folio_size(folio));
> +
>         if (i_blocks_per_folio(inode, folio) > 1) {
>                 if (!ifs) {
>                         ifs =3D ifs_alloc(inode, folio, 0);
> @@ -1956,6 +1948,23 @@ static int iomap_writepage_map(struct iomap_writep=
age_ctx *wpc,
>         return error;
>  }
>
> +/* Map pages bound by EOF */
> +static int iomap_writepage_map_eof(struct iomap_writepage_ctx *wpc,
> +               struct writeback_control *wbc, struct folio *folio)
> +{
> +       int error;
> +       struct inode *inode =3D folio->mapping->host;
> +       u64 end_pos =3D folio_pos(folio) + folio_size(folio);
> +
> +       if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> +               folio_unlock(folio);
> +               return 0;
> +       }
> +
> +       error =3D iomap_writepage_map(wpc, wbc, folio);
> +       return error;
> +}
> +
>  int
>  iomap_writepages(struct address_space *mapping, struct writeback_control=
 *wbc,
>                 struct iomap_writepage_ctx *wpc,
> @@ -1972,9 +1981,29 @@ iomap_writepages(struct address_space *mapping, st=
ruct writeback_control *wbc,
>                         PF_MEMALLOC))
>                 return -EIO;
>
> +       wpc->ops =3D ops;
> +       while ((folio =3D writeback_iter(mapping, wbc, folio, &error))) {
> +               WARN_ON_ONCE(!folio_test_locked(folio));
> +               WARN_ON_ONCE(folio_test_dirty(folio));
> +               WARN_ON_ONCE(folio_test_writeback(folio));
> +
> +               error =3D iomap_writepage_map_eof(wpc, wbc, folio);
> +       }
> +       return iomap_submit_ioend(wpc, error);
> +}
> +EXPORT_SYMBOL_GPL(iomap_writepages);
> +
> +int
> +iomap_writepages_unbound(struct address_space *mapping, struct writeback=
_control *wbc,
> +               struct iomap_writepage_ctx *wpc,
> +               const struct iomap_writeback_ops *ops)
> +{
> +       struct folio *folio =3D NULL;
> +       int error;
> +
>         wpc->ops =3D ops;
>         while ((folio =3D writeback_iter(mapping, wbc, folio, &error)))
>                 error =3D iomap_writepage_map(wpc, wbc, folio);
>         return iomap_submit_ioend(wpc, error);
>  }
> -EXPORT_SYMBOL_GPL(iomap_writepages);
> +EXPORT_SYMBOL_GPL(iomap_writepages_unbound);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 522644d62f30..4a0b5ebb79e9 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -464,6 +464,9 @@ void iomap_sort_ioends(struct list_head *ioend_list);
>  int iomap_writepages(struct address_space *mapping,
>                 struct writeback_control *wbc, struct iomap_writepage_ctx=
 *wpc,
>                 const struct iomap_writeback_ops *ops);
> +int iomap_writepages_unbound(struct address_space *mapping,
> +               struct writeback_control *wbc, struct iomap_writepage_ctx=
 *wpc,
> +               const struct iomap_writeback_ops *ops);
>

Just curious, instead of having a new api for
iomap_writepages_unbound, does adding a bitfield for unbound to the
iomap_writepage_ctx struct suffice? afaict, the logic between the two
paths is identical except for the iomap_writepage_handle_eof() call
and some WARN_ONs - if that gets gated behind the bitfield check, then
it seems like it does the same thing logically but imo is more
straightforward to follow the code flow of. But maybe I"m missing some
reason why this wouldn't work?

>  /*
>   * Flags for direct I/O ->end_io:
>
> --
> 2.50.0
>
>

