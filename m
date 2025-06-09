Return-Path: <linux-fsdevel+bounces-51074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93640AD297E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 00:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646E71891828
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 22:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F78A223DC4;
	Mon,  9 Jun 2025 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfBTiy4q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF51EF091;
	Mon,  9 Jun 2025 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509122; cv=none; b=Nvg4yJJ03i4JYAAD35jc2uTUvVQRmc57ISnLPMuCbI+wCVrxWGrwTGBVpBOt/1o0BIv5TkYhnmeXkJzVseE/or9X7HrnrqlsApzgNf0dfsoAXuA/8Y1EgQ/50wdSnzU0z8ayh1y7WsIrpCtjyZWyLVxWpku3OLo/0WAuRqbMKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509122; c=relaxed/simple;
	bh=fYgAiSm9+mbNLYV1rcD4MkKT4CGCFht3BYnOHMgY1vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hjb60MSgRfZWQhW6b0aOsE+qjgnXXcjPC/oPxYLk6att8JPaJy7r56yBPuL+qTN+iFNhQ604yxz8kYm2qNJ3Pb4/EeC3ixcoEIeyce9RST10USGCaBYpEj/YZuhwkdmn5G7S5PIfjpT7ADReE9asMBq1eTe/8Xe8Bs0Ji347rBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfBTiy4q; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a43d2d5569so63067371cf.0;
        Mon, 09 Jun 2025 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749509116; x=1750113916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFFj3N73ZzyeSS7oO8kYozgzqeDAPSsxF2b526LrF/w=;
        b=PfBTiy4q3zugX3H/CoNcvYdHT54kqd2rguwx9blxlRsW2zxTVs/Js+ed9Uhm/vFixP
         DVb5O7kBSP3owOCGSXSuBn/qDGXXwjegmhGW/y6l851V0c+zDJma4ai8iY+1q3hHbzoS
         Tvmcuc/ciqH/5aMYUzq1PJPTarsN1BqVy+gubzYhDlqE9XsvVFHWZZ/K5wdFyRTbHfDo
         2hmYaQDTipW3I+FjkTdnSDpVXUYc1yq/1tUsePIP0VpfeGSJ2r/Y3PxYK4+lan0zelGl
         Qm4KGmmfTmqCLKYOzux7gvrl4TpStq/3+mB83J/nnY0ghBEXiogZ26y5woQoFMZ3Y7SK
         2lIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509116; x=1750113916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFFj3N73ZzyeSS7oO8kYozgzqeDAPSsxF2b526LrF/w=;
        b=EcvdRRxJwWeQLp/SMW8bdAUNehy2R5j9oFMZ4JfiKq6BqI6OFrA1Rq7NzZmOdJRSUE
         emPd89slvRse4MjO459vIQ0iLUAzsSDUnsqaXrsG5aQ5GaZjgtHBjIv0aPaxy/X4jhuP
         lZpvitRUGSBaMJTAvSorIQbriTfdilFvgi2kE1js1qtOVPrdT4SIfA8iU7tOovUQWAnu
         oxU3w3HK9dVu8RhQNqUUqHVR6o42T9913EuAZvYM2G5s6EWr02PBil1C3AwjsHzZBC7e
         U5Lg8TQymz8WQTw/bC4FmC1v85kN9aprGit1qNuP/BOtxCgYzWn648Tvl8GdPdUrTWsp
         sfig==
X-Forwarded-Encrypted: i=1; AJvYcCVDEYBTMCH1zPTILmQUPUMzUwSfmawDLkbxE9UfYwqy340KZMlOv1R9RgT69N6/9okykMpHA64+jtoV0CPZ@vger.kernel.org, AJvYcCWYgD02JOwYrqBK/KLd6ndwtWraoNzymqimtXP6E68OUnY4kLY4C25vZhxFldi62sNYlsHLqGjiC+DN@vger.kernel.org
X-Gm-Message-State: AOJu0YxLd0Q2L/M1ZvAYFVmcKWReQWqZTKHbFPb98HVxWzQ/YlhIkmf9
	eZ4GQCig96IyBIT0B32n/idTJ9veKZEklyvHtIdruWykAksY1l2MIEmmThcxkUDYgFIAnXF9f9a
	neEyjaU4PLZrbKqyZQdyBlKY+K65rkwU=
X-Gm-Gg: ASbGncuKbCghBJPgurYzz6/YnIo1E4EXBqKPiRIlbj3oTsDCiKbPjc4iMgEGa/lACPY
	VkO8308yOPsBOxOJ9yXp5s/1V+9haPov6+k4Gwn84ixFkiNv1NqGeNi9KhW6fDP4tEDWqarfqL0
	JVFkMgJkknc7WV6yEV4mDbKvfgSu6FSZ28KgQyDf8JOXo=
X-Google-Smtp-Source: AGHT+IEefy2DjrcrpIx6xmoglQJdOEA6hBHSxaRtr3H55pBw3C1ISIdkEqrxjhIbVJPqkiJr8/k85FqfWpIVcTZEBvM=
X-Received: by 2002:a05:622a:229c:b0:476:875e:516d with SMTP id
 d75a77b69052e-4a5b9d92ac2mr210707191cf.36.1749509116219; Mon, 09 Jun 2025
 15:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-4-joannelkoong@gmail.com> <aEZpcWGYssJ2OpqL@infradead.org>
In-Reply-To: <aEZpcWGYssJ2OpqL@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Jun 2025 15:45:05 -0700
X-Gm-Features: AX0GCFsr-eKdOAmV_AYFU8UfPuN1fdAn7eT9UY4YqoDzlhxle0am81l7VjcLdXI
Message-ID: <CAJnrk1asVKKakBOmXghU22fWiZu4D+PDKVM6z5fMbbFNCzP5dQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] iomap: add buffered write support for IOMAP_IN_MEM iomaps
To: Christoph Hellwig <hch@infradead.org>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 9:56=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> > -static int iomap_read_folio_sync(loff_t block_start, struct folio *fol=
io,
> > -             size_t poff, size_t plen, const struct iomap *iomap)
> > +static int iomap_read_folio_sync(const struct iomap_iter *iter, loff_t=
 block_start,
> > +                              struct folio *folio, size_t poff, size_t=
 plen)
> >  {
> > -     return iomap_bio_read_folio_sync(block_start, folio, poff, plen, =
iomap);
> > +     const struct iomap_folio_ops *folio_ops =3D iter->iomap.folio_ops=
;
> > +     const struct iomap *srcmap =3D iomap_iter_srcmap(iter);
> > +
> > +     if (folio_ops && folio_ops->read_folio_sync)
> > +             return folio_ops->read_folio_sync(block_start, folio,
> > +                                               poff, plen, srcmap,
> > +                                               iter->private);
> > +
> > +     /* IOMAP_IN_MEM iomaps must always handle ->read_folio_sync() */
> > +     WARN_ON_ONCE(iter->iomap.type =3D=3D IOMAP_IN_MEM);
> > +
> > +     return iomap_bio_read_folio_sync(block_start, folio, poff, plen, =
srcmap);
>
> I just ran into this for another project and I hated my plumbing for
> this.  I hate yours very slightly less but I still don't like it.
>
> This is really more of a VM level concept, so I  wonder if we should
> instead:
>
>  - add a new read_folio_sync method to the address space operations that
>    reads a folio without unlocking it.

imo I hate this more. AFAIU, basically fuse will be the only one
actually needing/using this?
Though it's a more intensive change, what about just expanding the
existing address space operations ->read_folio() callback to take in
an offset, length, and a boolean for whether the folio should be
unlocked after the read?

>  - figure out if just reading the head/tail really is as much of an
>    optimization, and if it it pass arguments to it to just read the
>    head/tail, and if not skip it.
>

