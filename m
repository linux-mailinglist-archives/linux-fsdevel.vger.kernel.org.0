Return-Path: <linux-fsdevel+bounces-51376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3778DAD63A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 01:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66EE2C025F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 23:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D786F219A8D;
	Wed, 11 Jun 2025 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rzwkas8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB19C13D;
	Wed, 11 Jun 2025 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749683338; cv=none; b=OhjGaR4g66j7nI3DhyDQSoUVGF9l9/HPc8d4jGhPhlHK7pf5OnqrL05btKBkv8zeAbaciagSIfWTTqsO6DoiMI1gjVMjsX8JMufQLTDo6zZgQv5l/ImuzjNYHaslPWWgWoCVNN+CY3MOdWZVEyvy0IiINQZqaPnbqB6DURK7KKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749683338; c=relaxed/simple;
	bh=hDoQYVJFh4F12PjnMjcnr6tPU7818NrVp4deQ0m2a24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ncznutiuk1bATAIX7x//Ko6J9iZO95PNII86qmsyxJCk2ola/rc1qKhCR5ngGyyP4EA83M5gO9TxfUedmE2uX+pxtwNB+RF5LnIQUlnJpIEUmWqpwAEl7IKM19SvTNbYdpmxh61xzIa+AmjJjl9pywIQFPY/5wldXOtX/UrIOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rzwkas8s; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a6f6d07bb5so4415901cf.2;
        Wed, 11 Jun 2025 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749683335; x=1750288135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2JuQOwBnHb9c1sBFy1lTJagtGJIItytWiSEh7sLGds=;
        b=Rzwkas8s2gXF9d74LX2Ijx+swkJO7kY/I7ZgGOKWWLlYXCU70DLOTXjL13HU11m8th
         B1jeYdsQtOO9HkHYsUDNTJ83WjO2bDQkj/PSW7fi3FsBbEkrqxUDNmOpow1hzDYzZvoe
         GgfuFZM5tPTpvAXuj6Z1C1XiHLVGjvdCfms9DdHMBMgHGnGagcqti7dfi80gnMkJOufx
         oLN+9AogjQ8HmxMkjVeWVVlhuG2A24jlMdLo4gX+qJO0WPTTST4XyU/+QqnKprd3P7At
         FA3njMjAvEwNDvKfAJh6ae/slm+cAGeaAkqOCh+svlAeKeZ74U2De6ayJE98GSUoAtDK
         hwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749683335; x=1750288135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2JuQOwBnHb9c1sBFy1lTJagtGJIItytWiSEh7sLGds=;
        b=RtnUguc9ZAqvO7yoeTG8tU68yF6wRsWLx/dTNLw6wzqtz9jAYDIDmcTwEtMN/QFX2b
         9shvRG2Omm1V6syZGi62qQ+oZh61u9u8o7DsU9yp6wrYDiY145fMzZBhAPO62OIvrqu/
         krXyMIae7FXkOfmfoV8L9c/bswJlG1UVVC2j6ZkamlsDpRZxwHyEClJzf47Y5T2vjyF/
         1S7LRNLo8a5fKQyTJwohW6Gkt0KgTDA81WMCfHOTeqTt8GoW29QzuKRuB8BRQe1os2o9
         FacUwLtU2gzdQIFSpMf306O++pdvVN4ODSTTmOl5j0MyQmiH2Wf+xumLkOhoY13eUO7n
         cTzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0CCDtG0ThYiad7wm31YvHdU9EuOX6dT/kiEI4crdtsIqpIgO8qPGKqjpnfS1OYWgYeXljVmwFErX0aMGR@vger.kernel.org, AJvYcCXHVgtaAviznp87hdQxsaQjEpjBKzpR/awekIv5L0KrC81hJw1lZkVp2bP6g3cWHCBkq/xKB3cGdZh6@vger.kernel.org
X-Gm-Message-State: AOJu0YzbzJbYxRLYVovOpCJaBUtNk/kew60ZQisj2YDO+nTMmudztpc2
	VP0xHdk8c6xmPdL1MNIETuIbqtC0xO+pp4m6cvVB8bdcNZWXXnCIRrtgJCHt/wJaZeWW954ELnM
	6JfAopPC8RmJzZmECNOVbXHYiZKWhA9g=
X-Gm-Gg: ASbGnctK6I8XoPmBD2FZsRENfwbI4bL7Cz71sUIacWOXx8AjcwAzoKB3YdsnrelpS3k
	UO7Pl8VUIqWNLOsBCgfBwKa3B6XWa4EUHmR9+2xWTZ/lkEe39vWGn36vlAm114aODZrZPKp4iJd
	Zhg4V06bKtl1VgBDkyi5RMUY/kxOEY7w+KtWN9VgWMeSiYut4n7Zcc3xc3qCk=
X-Google-Smtp-Source: AGHT+IGToaqlmYUs+Qrz7Ss8GzmJPyzM7MGftBIFeGRD1jS1maqU/x5UTqxvnX1wzC90/vprKwfdh4dS62O2KX8vWC4=
X-Received: by 2002:a05:622a:559a:b0:4a4:2e99:3a91 with SMTP id
 d75a77b69052e-4a724253ab3mr12633701cf.11.1749683335285; Wed, 11 Jun 2025
 16:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-3-joannelkoong@gmail.com> <aEZm-tocHd4ITwvr@infradead.org>
 <CAJnrk1Z-ubwmkpnC79OEWAdgumAS7PDtmGaecr8Fopwt0nW-aw@mail.gmail.com>
 <aEeo7TbyczIILjml@infradead.org> <aEgyu86jWSz0Gpia@infradead.org>
 <CAJnrk1b6eB71BmE_aOS77O-=77L_r5pim6GZYg45tUQnWChHUg@mail.gmail.com>
 <aEkARG3yyWSYcOu6@infradead.org> <CAJnrk1b8edbe8svuZXLtvWBnsNhY14hBCXhoqNXdHM6=df6YAg@mail.gmail.com>
 <CAJnrk1au_grkFx=GT-DmbqFE4FmXhyG1qOr0moXXpg8BuBdp1A@mail.gmail.com> <20250611185039.GI6179@frogsfrogsfrogs>
In-Reply-To: <20250611185039.GI6179@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 11 Jun 2025 16:08:42 -0700
X-Gm-Features: AX0GCFt_L9SMpFeFtx8J6FU0F505zRU5lVzW17w1Zf0JlXpyh_OhP0zcA5k1Pqs
Message-ID: <CAJnrk1YcMvDZ6=xyyJcZ_LcAPu_vrU-mRND4+dpTLb++RUy9bw@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:50=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Wed, Jun 11, 2025 at 11:33:40AM -0700, Joanne Koong wrote:
> > On Tue, Jun 10, 2025 at 11:00=E2=80=AFPM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> > >
> > > On Tue, Jun 10, 2025 at 9:04=E2=80=AFPM Christoph Hellwig <hch@infrad=
ead.org> wrote:
> > > >
> > > > On Tue, Jun 10, 2025 at 01:13:09PM -0700, Joanne Koong wrote:
> > > >
> > > > > For fuse at least, we definitely want granular reads, since reads=
 may
> > > > > be extremely expensive (eg it may be a network fetch) and there's
> > > > > non-trivial mempcy overhead incurred with fuse needing to memcpy =
read
> > > > > buffer data from userspace back to the kernel.
> > > >
> > > > Ok, with that the plain ->read_folio variant is not going to fly.
> > > >
> > > > > > +               folio_lock(folio);
> > > > > > +               if (unlikely(folio->mapping !=3D inode->i_mappi=
ng))
> > > > > > +                       return 1;
> > > > > > +               if (unlikely(!iomap_validate(iter)))
> > > > > > +                       return 1;
> > > > >
> > > > > Does this now basically mean that every caller that uses iomap fo=
r
> > > > > writes will have to implement ->iomap_valid and up the sequence
> > > > > counter anytime there's a write or truncate, in case the folio ch=
anges
> > > > > during the lock drop? Or were we already supposed to be doing thi=
s?
> > > >
> > > > Not any more than before.  It's is still option, but you still
> > > > very much want it to protect against races updating the mapping.
> > > >
> > > Okay thanks, I think I'll need to add this in for fuse then. I'll loo=
k
> > > at this some more
> >
> > I read some of the thread in [1] and I don't think fuse needs this
> > after all. The iomap mapping won't be changing state and concurrent
> > writes are already protected by the file lock (if we don't use the
> > plain ->read_folio variant).
> >
> > [1] https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.di=
saster.area/
>
> <nod> If the mapping types don't change between read/write (which take
> i_rwsem in exclusive mode) and writeback (which doesn't take it at all)
> then I don't think there's a need to revalidate the mapping after
> grabbing a folio.  I think the other ways to avoid those races are (a)
> avoid unaligned zeroing if you can guarantee that the folios are always
> fully uptodate; and (b) don't do things that change the out-of-place
> write status of pagecache (e.g. reflink).
>
Awesome, thanks for verifying

I'll submit v2 rebased on top of the linux tree (if fuse is still
behind mainline) after Christoph sends out his patch

> --D

