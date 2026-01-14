Return-Path: <linux-fsdevel+bounces-73810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C62AD211BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 20:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA5E6303B793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354534EEE9;
	Wed, 14 Jan 2026 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLRvN7z+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21F19C540
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420389; cv=none; b=cMmvJHr1eyg1Vv5pmcHQN0sy2aV/eCIt8Y3WxWVaKfqmu6J0QMPj814agqBv7F/5CCES4mm9y7YaRMIMh1TIsD5dbS5ZvWxz5m7+GhXnTq6Mca6Xk/XdAsiJKtpc6wUiDDKr/fxzNahqWi2IDRHE6lacbAbNOaos0+riWoaHn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420389; c=relaxed/simple;
	bh=MIz/ortPvgFOayO+jZ0XG4aTEMkgS0AZfYG0bkWhG4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BD4XvE3QhxBmC+lQjJoAjsCcQgw7U7iM4frqnguYyqyV8QxDLJ9pydlex97AHm7+tZo/qgOKg/mUQY/1o/e81LCGmz/ZCp1aPQW7b2+mXGiwn0ljXdE77OTnOXvPAxQqfzD9C4RIaqaOEntMbNNXotgdcpzj8L9BgCwRjW8wxLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLRvN7z+; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4f822b2df7aso2271901cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 11:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768420387; x=1769025187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prDbSZqW3QTmQu9D6qANpELqH+cUJSCkjx9wpjHq2yY=;
        b=jLRvN7z+VRyipIH2J5eVOxjWG+Ratil7SgL9l9KdOvxGArWdASBi4RA2wF2pbynRmX
         SAJhqRLWfNfWNRWrnvsoHM5fLnb3N97CZNneN8pqoQIOoJ99GHNx1k5aBly4rCfEHZg5
         6MG1Fj7r/bvWOlvEm2NuDB76a1TN7+p8pXlJETawGb+3qJ+Nbs8NBfEEtUAHFA/FBtii
         Nx9GkmHRxK7uRXNHRzGtf8ZhfOFz8R/PIg5Bcvh9NPOnnFKiWAriLHbuEtj7astj+vZG
         Sc5jT1BvEqIlpqaVmrBin9CjpOR6df7EQN4bv/0KLSBZzAHKdV+WvC7RjmcwOdqmQi6P
         KILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420387; x=1769025187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prDbSZqW3QTmQu9D6qANpELqH+cUJSCkjx9wpjHq2yY=;
        b=PdfbWcaCEOgbf4+wTRIFiALW05rqAjXltjVEPKPXfZC/v7P8//Pcjjih6Bx28+L4eb
         yEX6zvhlpwSqMnffBQ3p8g2ZwmK+4pKCQqFDsgUm7APsDEHuZR5H0mhsjSdkPNfiwqEn
         D1lkuo3ZWKaJmUqSwNVZpdk80qqp9q8XF0mdbatNvSOzVfzZnvXo1OMGG56QjZC8RefZ
         U/wyDjT+yIYM9utk8xDJcpL/WwklMbYn2K74mI47YuMoE1Nu2ZbpeAkXT/pWbHyD3hTg
         ywYoE/jjz9Q0fz+v7KGlIldJZdH6upQDDKB8IvwYdeqDduxQf0xVg71NXN5kgRn2yVUB
         kgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzR9i9A4EbY6N3eHGOWebz3SVH1CcrtQQI0UxsWOLXOnrFxfWVCrCyP0n6dmrnM6oTV+KGkbVugoYn7g7m@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnJuj1bH5LREghzC8gp8tRpH+2WNRNFbPX8gG+WkxrC48LpS6
	7sXBreEzciUziz2w2LIwAY1Znicm5uOyLDVHJmfYZI6tgrkfRDfQADp6tPuQu+jENakhIAw7jXg
	uAen3RN+P1sdnURWdmZEk/+u4X1KGWp4=
X-Gm-Gg: AY/fxX6Pt9eWQY12rYHTe14UbNDXmwG0i/hAGm2pjBlurUjX2wOKTVZOtUwiWUaEInD
	PKZkL8hmy0f/cm6yxbw5lZGBYVWpt/zXW2JjbP96VpNOHt1NIE8VylVQs7Il0Cutj5XUSNqb6kL
	VRKptbbf7d5FVDQ9yxK1ZfhvHH+jujfOqREOSNblhietrIc+B18f4cjLErrbf3PyDDwcuzLx/Az
	DUMBmK+d9KniG9yZs8o+PVuYs9CW9BF3t+WvEeWMW4i0BDrnDi9tHUsr+BpmrA8ub6O/Q==
X-Received: by 2002:ac8:5a48:0:b0:501:b1be:c31b with SMTP id
 d75a77b69052e-501b1bec54dmr9772011cf.14.1768420386653; Wed, 14 Jan 2026
 11:53:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114180255.3043081-1-joannelkoong@gmail.com> <aWfk7T4sCjAhOVZ9@casper.infradead.org>
In-Reply-To: <aWfk7T4sCjAhOVZ9@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 14 Jan 2026 11:52:54 -0800
X-Gm-Features: AZwV_QiCQtQ9ucytGcywD9CtrSaoEWOr4Q167tdfZZaerbnV4lz4cIXWcZf7bkI
Message-ID: <CAJnrk1awyskKaoSTznzwLg3bS64asPqH4c50iLKqANRe-eMK5Q@mail.gmail.com>
Subject: Re: [PATCH] iomap: fix readahead folio refcounting race
To: Matthew Wilcox <willy@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 10:48=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Wed, Jan 14, 2026 at 10:02:55AM -0800, Joanne Koong wrote:
> > readahead_folio() returns the next folio from the readahead control
> > (rac) but it also drops the refcount on the folio that had been held by
> > the rac. As such, there is only one refcount remaining on the folio
> > (which is held by the page cache) after this returns.
> >
> > This is problematic because this opens a race where if the folio does
> > not have an iomap_folio_state struct attached to it and the folio gets
> > read in by the filesystem's IO helper, folio_end_read() may have alread=
y
> > been called on the folio (which will unlock the folio) which allows the
> > page cache to evict the folio (dropping the refcount and leading to the
> > folio being freed) by the time iomap_read_end() runs.
> >
> > Switch to __readahead_folio(), which returns the folio with a reference
> > held for the caller, and add explicit folio_put() calls when done with
> > the folio.
>
> No.  The direction we're going in is that there's no refcount held at
> this point.  I just want to get this ANCK out before Christian applies
> the patch; I'll send a followup with a better fix imminently.

Sounds good, thanks for taking a look. I'll keep an eye out for your patch.

Thanks,
Joanne
>
> > Fixes: d43558ae6729 ("iomap: track pending read bytes more optimally")
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index fd9a2cf95620..96fab015371b 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -588,10 +588,11 @@ static int iomap_readahead_iter(struct iomap_iter=
 *iter,
> >               if (ctx->cur_folio &&
> >                   offset_in_folio(ctx->cur_folio, iter->pos) =3D=3D 0) =
{
> >                       iomap_read_end(ctx->cur_folio, *cur_bytes_submitt=
ed);
> > +                     folio_put(ctx->cur_folio);
> >                       ctx->cur_folio =3D NULL;
> >               }
> >               if (!ctx->cur_folio) {
> > -                     ctx->cur_folio =3D readahead_folio(ctx->rac);
> > +                     ctx->cur_folio =3D __readahead_folio(ctx->rac);
> >                       if (WARN_ON_ONCE(!ctx->cur_folio))
> >                               return -EINVAL;
> >                       *cur_bytes_submitted =3D 0;
> > @@ -639,8 +640,10 @@ void iomap_readahead(const struct iomap_ops *ops,
> >       if (ctx->ops->submit_read)
> >               ctx->ops->submit_read(ctx);
> >
> > -     if (ctx->cur_folio)
> > +     if (ctx->cur_folio) {
> >               iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
> > +             folio_put(ctx->cur_folio);
> > +     }
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_readahead);
> >
> > --
> > 2.47.3
> >
> >

