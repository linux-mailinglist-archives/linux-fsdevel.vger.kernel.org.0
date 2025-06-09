Return-Path: <linux-fsdevel+bounces-51078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A7AD2A8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 01:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA1B17082D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 23:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA2622D7B8;
	Mon,  9 Jun 2025 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYzj1qq6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F69148857;
	Mon,  9 Jun 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749511827; cv=none; b=BZXNuruRoPiSiqOUbEokQVhaKp8MSVzHoKsRapyIGMRI58Xb7w8UvEndgvcwzPjOU8a82Hdv9rj090sJWHBf7Q97Y1v+u4bINFF9UhcAWWzwVIgF97E+BwQnccLur686PdnSBrJoyy0Fe6amHmPMqY04A0m5X2wXRCwMjqwAQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749511827; c=relaxed/simple;
	bh=eO8UJyYDVmv+TCicgMEV4Sagy+MUrJJIFq/47rMFL5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqUNasTuUujNeOv2qNx67/Ky9r0HAm0dnffL2WLYYjT/JczA6/9m4a/Bbq1PxhStYZUafIiz6oV58PGiO4zG+3HfX+4UGfqX4il3FnqrQNu7Rr1CsurfNX7vMyZA/ynply5XsDj8T07F6IrEzplzV8zgHPzk0njUDXxyHDeBNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYzj1qq6; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a43cbc1ab0so59351851cf.0;
        Mon, 09 Jun 2025 16:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749511825; x=1750116625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=441wzke0m7h0QnPox4aWTz4vA1S1gdBW2nEkKBTpzr8=;
        b=iYzj1qq6kbZvLGOU+hoJZgcjgxXXsGpFDH3BPctwL3EGSHdHrz1dBoSJw9DSdX2Auy
         W92XQ/qfHT2Oym0KGaHGXN3y2Oxmh9Rpqii+70uCEYkOJg9oPhRRy7gA6jXqN2kCB6Dg
         cKvuqkQ/CagTqIpetm6plK6fat7pU5dEzXLhEOogFvIPE1ORp8JFZjQI6u+n6cRj33S5
         sq2itfV7Qjy1Ct9sh3QmYWnnPrkuLU4Ll6CtGyPWY+YdX67H57T3oKEOvdlBNDzo4vj6
         wJEOIMsI/oVTtLKn59ZGwjk/waVt4EZKnkodxqlPlWdtwcWqhNNnikAu+k8eMIMw9drO
         AI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749511825; x=1750116625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=441wzke0m7h0QnPox4aWTz4vA1S1gdBW2nEkKBTpzr8=;
        b=i1/v9hsCjiA8bnSg/Qx0rGR/0COh4xvQJL5SkXG9GbhCkrHaBIOIN0uhNkWKCJF3vz
         TEfSLz6Y2uCskKsQc4z+T5MC98NCrFXzMctIkoulNgByrcjgnx+LrsXmC7x2MkOKGcHq
         Z43Y/XNiajeNYa0+oG4QS9G9NHee6VwgPz77qRzWH6E3Q2lGB8coltgv+5jFYmy0BiVS
         732KzGV6cuBY0GRNgdxLiM0tCWiN1FuKWQVm4f72x1jMlgHEyfnkWPFQbLXRs7Hib0XD
         /tmC+wZdrC/sgwzCAelkAFqQm86bHfwgYh66Jm7nHMYyfuurO6f6McPIvbXkimABw8Cb
         2sPA==
X-Forwarded-Encrypted: i=1; AJvYcCUq2cAYluu7DaKPuiQrg/fP/6f35z7phcZxQAhj0J+3Lv8GBF8kUVz05A+QXnMHqOhHiCSQelkxDPiNQrKd@vger.kernel.org, AJvYcCXH6hAg0MDszhc2BywbUd/ggjVsAGQ71NFUx7wPvqruOU7NXgUjZ12lZycx5mVVQMpTvCrKmv4JE/EH@vger.kernel.org
X-Gm-Message-State: AOJu0YzAfv1q4VXivwNjD06uHrkDicdisGc9anDzZvt7WJtEky5JTYTF
	djmghvacf9p4RSG0nk1dLeoYzBT03ny9TQja3EOf/MJBOY9fJr36Gmf53GB4I9GFO1RsE/1Vq5E
	Zjeahk1M2To14EFdC7FI7PPfeCgSZB+U=
X-Gm-Gg: ASbGnctrvrEYyYI91wMzaSlJXf9+ogA0VtqfsCR/XsQo8WWzz2h8ico0MbR68mu5O72
	phToWyVwrHD/r1YxXVj0wreoR82K/GlqwXS3uB6iv5cEwQmsckkK3cyyu9JmLdFiz1dpbWIGMoK
	7F5xm98YXmyKsE3RBQQqUcgz31w1IpGv6IsomyCXMYRrE=
X-Google-Smtp-Source: AGHT+IFEIWexygg62qWuDyptKiYkc/u6Wuxb9dwjudAlth+vhWBku1lS0ShdCgdujHNm+eOORJgf4L9wG4fkNJpeRiw=
X-Received: by 2002:a05:622a:2517:b0:476:add4:d2a9 with SMTP id
 d75a77b69052e-4a5b9e54347mr254445681cf.30.1749511824867; Mon, 09 Jun 2025
 16:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-6-joannelkoong@gmail.com> <aEZoau3AuwoeqQgu@infradead.org>
In-Reply-To: <aEZoau3AuwoeqQgu@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Jun 2025 16:30:14 -0700
X-Gm-Features: AX0GCFuVvltAvH6tgTcp9ofUkrRrDKszkCMK9ghv0PRj4o_yyqom2V9Di6AmiBU
Message-ID: <CAJnrk1ZT08U808k=4b23pKfXCub7wLv97feG_xbaJp81pBtdOQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
To: Christoph Hellwig <hch@infradead.org>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 9:52=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Fri, Jun 06, 2025 at 04:38:00PM -0700, Joanne Koong wrote:
> > Add iomap_writeback_dirty_folio() for writing back a dirty folio.
> > One use case of this is for folio laundering.
>
> Where "folio laundering" means calling ->launder_folio, right?

Yes. I'll change the wording to "laundering folios" to make this more clear=
.
>
> > @@ -1675,7 +1677,8 @@ static int iomap_writepage_map(struct iomap_write=
page_ctx *wpc,
> >        * already at this point.  In that case we need to clear the writ=
eback
> >        * bit ourselves right after unlocking the page.
> >        */
> > -     folio_unlock(folio);
> > +     if (unlock_folio)
> > +             folio_unlock(folio);
> >       if (ifs) {
> >               if (atomic_dec_and_test(&ifs->write_bytes_pending))
> >                       folio_end_writeback(folio);
>
> When writing this code I was under the impression that
> folio_end_writeback needs to be called after unlocking the page.
>
> If that is not actually the case we can just move the unlocking into the
> caller and make things a lot cleaner than the conditional locking
> argument.

I don't think we can move this into the caller of ->writeback_folio()
/ ->map_blocks(). iomap does some preliminary optimization checking
(eg skipping writing back truncated ranges) in
iomap_writepage_handle_eof() which will unlock the folio if succesful
and is called separately from those callbacks. As well it's not clear
for the caller to know when the folio can be unlocked (eg if the range
being written back / mapped is the last range in that folio).
>
> > +int iomap_writeback_dirty_folio(struct folio *folio, struct writeback_=
control *wbc,
> > +                             struct iomap_writepage_ctx *wpc,
> > +                             const struct iomap_writeback_ops *ops)
>
> Please stick to the usual iomap coding style:  80 character lines,
> two-tab indent for multiline function declarations.  (Also in a few
> other places).

Will do.
>
>

