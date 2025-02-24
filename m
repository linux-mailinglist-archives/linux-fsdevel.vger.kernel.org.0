Return-Path: <linux-fsdevel+bounces-42389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577EEA416DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 09:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C46E7A2DDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDBA19E97C;
	Mon, 24 Feb 2025 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="U2/ocwjT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA26188704
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384324; cv=none; b=UHrRpjVWjAH/x0KK69hINStZWZ/7DIIAfe80vczNB4U37wta8fliRiL1Pfh3Re590gxWOmLDTlKWWtvKHiu30zxctjczU+WNhekjaQ/altfshJmEFPmls2hCVRAyW14z0RZkwDe0VRNAYujIGIYxvimZZK5hq9YDgv9ox1aMn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384324; c=relaxed/simple;
	bh=DSSp61QUIymzYrWYGlGupfHXP31daiD2lgNbLtACtSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYQxvV+lgejEFn5mSbPM+gCrV+cGHqFZA9kFHDBm5ZqC0h3wV02O/5Q9khTDl9EUDLeuYixD6VmQs+sUW9VZwyHEzxW2z/1gCfhJO0Q2Rzf3kGQRjkf5XGks8VmX/kxiCa4ZrLwtmebxRpiOh88Ol1bK7Y/r9kUfxubEFxRHr8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=U2/ocwjT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso8334043a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 00:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740384322; x=1740989122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVoA3KBTslaxKUJAlPiAwxSQFPk6ze1iD/cIE02/gTk=;
        b=U2/ocwjTO2UseaaNS6wNKjot/uPGEg0JVS1OZzS3FBiUnfLlB1aZ/rxhUFkxgaZrRr
         sVTYIFurtAOyiXU9vD8ve+9/y+PKzyPk15m9MprtD9UdqCwS2Dfjt6hwnhmWWa5uZNHM
         7U5lJMwCgNTcye80ru7FKPJNnaY2FgW9llabh6CCZCRb6vpEJEZIclgI4DEi/N7S4Xkz
         SPUbltreHAJ4RsCKAZ64mtA5hjVgz6ZhaY0qgdzWx/Q+IDD1vnqTbUvCkdBfU2BVXRnd
         c4my4dglAjH1B15FdRAErgH9mDc8Ek5YLp5FGGEgpScQIfJT29ISZU1Z+Ll1BP3kvZDH
         u1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740384322; x=1740989122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVoA3KBTslaxKUJAlPiAwxSQFPk6ze1iD/cIE02/gTk=;
        b=R8mAXJC/cPqud5yhgnxnrRwiWV5rZCNs3K1FyRD51hcfKa9dXt4/YrtpxpRCr59TDT
         PzubjsQKDBiPxdUTysOmQFbdcxRa5WKab88cb39J0xGSb5jF8DiL70TSpVff/5Oy+ps3
         AyxVwUPFW+ImtE2wdkaQ49jVVK3W4C3uRvbZm+zHtY0AFLTMVkL4evBk29PEX9rAqPF2
         cModni0OST9TfwZCLDlu24gS1ZhJi3MYvHsH9CDWVELcfPWWTBxnYTA+P3/RltaX55A3
         UJCIrjif62mMlFfQq8sBjqNCgRcYN8FJoX8Mnjjkim33JNNSy6bzEf+FPczKEhN31uNe
         gCtA==
X-Forwarded-Encrypted: i=1; AJvYcCWYJp0eBYeXmEmwHEduHi9pQhl/cvIJcOXxaYeF1iVGi6nabbw5Ug/CAbfnCq70FA4l8brH5amip8DG9W0g@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5KfWW222MXh5ODScdKzTSRKm1bgJXiGFhdptK49wtTvaLJt8r
	TMrnb69lMXIQM/JsQYg5jLYzv8M88mP++TvWaDIVC87l/5DM1nPwNPQLbQjjgC2mt+cK8GIDlW9
	sqLJU9wpC3hmG97hymu4U5pqrW7QIMu0NCj/0iJ5cnkJ1HjTaHrs+k8yI1b46+cpnWUtWXa58D/
	g0Wz6KFg03bBcko3KXpp/XZUAV0GH/qHa3ZBgcFTC7PnQnZlyCDRAnibdftuctMx62Miocf7JbK
	uFR6FhcpdZqohgDEFcDRr45fqW/3/PCGPKLrdpkwPXYM0TOU0yYjrfTluZuMQNi2tOhteSrAGjI
	OFCWpKuiJEh37DCNK0QPehB13+RLxhlaTDOtboTMYnuFHUBQUj7O15+HiYq581MT6o8X//Dvr6D
	ZVlJLsG4BWigJm/MJLia+T+dBSBuVxeGV2dZG7J15
X-Gm-Gg: ASbGncurM5XxFQRDsPF4uakMWUPnuE6QSw8wpiNjcSF90vyIlUdLKeLEjSrm/LKfKyW
	G0YKcInS5XMtMGaP9KHRQLl1K3054t5AgdTM/xsp6MnrLfVqney8Do/YLViAZA09lQN9sPDMMAf
	KdXX2WbuPWt7xPJWWNDJ625x2U
X-Google-Smtp-Source: AGHT+IFtdbQ6U/YKuWHB7yqDwwuNE/bSc7IlcjqeG5sANxT1TCSNg1dNn8Tz99FJjQDWn5yBteVeobg3lGuJU2hNAM0=
X-Received: by 2002:a17:90b:4ec6:b0:2ee:ad18:b309 with SMTP id
 98e67ed59e1d1-2fce779bc1fmr18989604a91.3.1740384005725; Mon, 24 Feb 2025
 00:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223235719.66576-1-raphaelsc@scylladb.com> <Z7vyEdJ3SqjFkE9q@casper.infradead.org>
In-Reply-To: <Z7vyEdJ3SqjFkE9q@casper.infradead.org>
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Date: Mon, 24 Feb 2025 04:59:48 -0300
X-Gm-Features: AWEUYZkvHapCZa_nWwzLdLpvhKFl_jgkyrG-YnMTBsTUmmQGjHUIcJRbVqK-hSE
Message-ID: <CAKhLTr0UA42AC2yCyFtDbFoS34vvg05EVnf5J4MSit_Sr7JETw@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, djwong@kernel.org, 
	Dave Chinner <david@fromorbit.com>, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Mon, Feb 24, 2025 at 1:14=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Feb 23, 2025 at 08:57:19PM -0300, Raphael S. Carvalho wrote:
> > This is likely a regression caused by 66dabbb65d67 ("mm: return an ERR_=
PTR
> > from __filemap_get_folio"), which performed the following changes:
> >     --- a/fs/iomap/buffered-io.c
> >     +++ b/fs/iomap/buffered-io.c
> >     @@ -468,19 +468,12 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate=
);
> >     struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
> >     {
> >             unsigned fgp =3D FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STA=
BLE | FGP_NOFS;
> >     -       struct folio *folio;
> >
> >             if (iter->flags & IOMAP_NOWAIT)
> >                     fgp |=3D FGP_NOWAIT;
> >
> >     -       folio =3D __filemap_get_folio(iter->inode->i_mapping, pos >=
> PAGE_SHIFT,
> >     +       return __filemap_get_folio(iter->inode->i_mapping, pos >> P=
AGE_SHIFT,
> >                             fgp, mapping_gfp_mask(iter->inode->i_mappin=
g));
> >     -       if (folio)
> >     -               return folio;
> >     -
> >     -       if (iter->flags & IOMAP_NOWAIT)
> >     -               return ERR_PTR(-EAGAIN);
> >     -       return ERR_PTR(-ENOMEM);
> >     }
>
> We don't usually put this in the changelog ...
>
> > Essentially, that patch is moving error picking decision to
> > __filemap_get_folio, but it missed proper FGP_NOWAIT handling, so ENOME=
M
> > is being escaped to user space. Had it correctly returned -EAGAIN with =
NOWAIT,
> > either io_uring or user space itself would be able to retry the request=
.
> > It's not enough to patch io_uring since the iomap interface is the one
> > responsible for it, and pwritev2(RWF_NOWAIT) and AIO interfaces must re=
turn
> > the proper error too.
> >
> > The patch was tested with scylladb test suite (its original reproducer)=
, and
> > the tests all pass now when memory is pressured.
> >
> > Signed-off-by: Raphael S. Carvalho <raphaelsc@scylladb.com>
>
> Instead, we add:
>
> Fixes: 66dabbb65d67 (mm: return an ERR_PTR from __filemap_get_folio)

Thanks, will fix it in v2.

>
> > ---
> >  mm/filemap.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 804d7365680c..b06bd6eedaf7 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1986,8 +1986,15 @@ struct folio *__filemap_get_folio(struct address=
_space *mapping, pgoff_t index,
> >
> >               if (err =3D=3D -EEXIST)
> >                       goto repeat;
> > -             if (err)
> > +             if (err) {
> > +                     /*
> > +                      * Presumably ENOMEM, either from when allocating=
 or
> > +                      * adding folio (this one for xarray node)
> > +                      */
>
> I don't like the comment.  Better to do that in code:
>

Initially I was doing exactly what you proposed above, but after
reading do_read_cache_folio() and the patch the introduces the
regression, which transforms failure to get a folio (a NULL) with
FGP_NOWAIT into NOAGAIN, I decided to do this, but it's indeed better
to remove assumptions. Not ideal for the long run. Will change in v2.
thanks.

