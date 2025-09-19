Return-Path: <linux-fsdevel+bounces-62254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D209FB8AD68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 19:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B5EA03601
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C376322A0F;
	Fri, 19 Sep 2025 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAUgVkn6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37930BB9A
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304715; cv=none; b=YIldvg4BzaiTbOIr4ZpNKygEdnhakBjbNER4qL3PS5JVMh34Jxxcx2wNFSv+DCuKQ/1iGTODKWi4/nhhYjBYRukA9d0Mo+H1hX8yj81ZXHxt50llhIZL/OxGnGmZtaWRo9dkyHhPACYq4vEHiTLc0WJ8/7pGR4nKtjEbNjlTMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304715; c=relaxed/simple;
	bh=38Gs1Qar33XAo1Y7OS66uYvLqXMX9a7h0GZW0uT6IT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCy0bh6XFwVE8o82nJFAIKtG78BdEXk4pj4yUJiYbOTtc9IJCfPTjpLZ7vqiQdMCEptLk+CYCTwuXBT8MOahyCr7nYS3mbMCB9UBoQZejOyrmsJDUSPWUsx5qB+dn2G7OHdqhS5E9R8fk49XLe/7EtJl+V1IiWttRPhqg9fgSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAUgVkn6; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b61161dd37so15947451cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 10:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758304713; x=1758909513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKiAXDkgrX2LUhD4TKk8v5QGpSKY+EpT1ETvTouA6rM=;
        b=RAUgVkn6+ALoQ7bm9NktTxKD4MtFhDkRZbPkjbKVNgh6f1b/Ti6L+dxlX8HBLxF6MQ
         eg6b1wm6zmGouG7khVZxVAzLFtdHpovQaAFnkm7obdnX9X7EDaJ9SVyR3wDhbVTFLcrb
         RlyXZdxpSaK46afYxtAZNbSeyjLrrlT+BK8I6cap9Vd6CF6LcY17Gc11c9+13dfiJK/V
         09IWOojy221xl3LgdPIj4cFcBoZZduF072lkLTEGCKwyx3nJHLdNJA9XWJyq4q1Ig7ER
         cTIPGvboG8zpy70+QqHkvnWDliEbF6BoJBYlYtUspPHcSYHEYIG1z+uZeWxkdzH9xnji
         YLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304713; x=1758909513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKiAXDkgrX2LUhD4TKk8v5QGpSKY+EpT1ETvTouA6rM=;
        b=RLPKoD0qwqeilqQc2n2xHO/uZUztGIfv/bbIKcaRa2WtNXjSCQokJ2b/lkRqXhIKl3
         c70/HoI4nu/71WR2C0WZDHiWrJwUD4T4K/Nt8Ph1jzmGEupTPrL2y/Tq4e8U1OeuaSZA
         il93F2g/u4rkQkmdUj931W3oD9mWytZBXSiK1U8WL0sBummlk1gTLm4OPjiRkGTq28Ka
         vj40hjFGSvQWD6VjYxYzdJGYhvtZWIaZuI9/LR6KTcu2tj5d/fPYpoETisat/HsD2bZM
         G1sNXOFW/IX4sCvFvxzGKvEXTBdDQhlDTbIuzPGd/2WeC5+8DpP9rtWiKLjUc6iwYL9R
         LvwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiSKWVXg+C1ARhqj3SIN8sm5RzTGHIE9pRJ1sHWsOs24TdR/UDQ53zfLVdHzLwUGRXJ9VtogvSQUK+NK2Z@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ8svsX78+qyhvola8rV6untWRCLmZ7Cq+I+vIrXqBESR8SM04
	7SslIX1Gzle4RGXj928Jf9bQWQut3nuGG3fzCq1pwKRHxNa/woDbSAl4wAIusYs6/W0P30KmXtM
	b0VOw17CaX4blmMjlzsuuOGYFmHv1ODs=
X-Gm-Gg: ASbGncukY942PkhY63BRkc+oipEdPGnvJeIA+aOiPf4BbncDGCNyF9lC+Z9EyCatxii
	DjMzQeeEEjCfkbUP7z6C6HI+xLSvmZ2KQq/BkrUkgN/qHmwCEgmaI4sPn2UxA3WObZj2hEJh73R
	hPiMEYe8lVqmrXjXq0DPhSplFeMb457Wr2ElTAqTC0GthTQPLZrhW3ferBEwD6navwDvtgvjne3
	d6Tmij1ON8Vs2grEx+Tl3tTVT94npAKG05hktz6
X-Google-Smtp-Source: AGHT+IG5Mo3h/1ff88PwcUapAIlS2YVGSiLxAR3AL07FsknEHK18lG+gFQCk2zfPCcdMXf1hLVttPVUfviUqt89STrs=
X-Received: by 2002:ac8:7f4f:0:b0:4b5:fc2a:f37c with SMTP id
 d75a77b69052e-4c074b076d7mr48411081cf.74.1758304712602; Fri, 19 Sep 2025
 10:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-13-joannelkoong@gmail.com> <aMKzG3NUGsQijvEg@infradead.org>
 <CAJnrk1Z2JwUKKoaqExh2gPDxtjRbzSPxzHi3YdBWXKvygGuGFA@mail.gmail.com>
 <CAJnrk1YmxMbT-z9SLxrnrEwagLeyT=bDMzaONYAO6VgQyFHJOQ@mail.gmail.com> <aM1w77aJZrQPq8Hw@infradead.org>
In-Reply-To: <aM1w77aJZrQPq8Hw@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 19 Sep 2025 10:58:20 -0700
X-Gm-Features: AS18NWA4Ectn5ref1Zm-F0jRvHV38iLjidkioHaeJy9w2W9ibGS--sEYKpZ7E2Y
Message-ID: <CAJnrk1bKijv8cce+NdLV-bOvdU=HdZEb5M=pE5KhqCWX0dAOWA@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] iomap: add bias for async read requests
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 8:04=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Sep 16, 2025 at 12:14:05PM -0700, Joanne Koong wrote:
> > > I think you're right, this is probably clearer without trying to shar=
e
> > > the function.
> > >
> > > I think maybe we can make this even simpler. Right now we mark the
> > > bitmap uptodate every time a range is read in but I think instead we
> > > can just do one bitmap uptodate operation for the entire folio when
> > > the read has completely finished.  If we do this, then we can make
> > > "ifs->read_bytes_pending" back to an atomic_t since we don't save one
> > > atomic operation from doing it through a spinlock anymore (eg what
> > > commit f45b494e2a "iomap: protect read_bytes_pending with the
> > > state_lock" optimized). And then this bias thing can just become:
> > >
> > > if (ifs) {
> > >     if (atomic_dec_and_test(&ifs->read_bytes_pending))
> > >         folio_end_read(folio, !ret);
> > >     *cur_folio_owned =3D true;
> > > }
> > >
> >
> > This idea doesn't work unfortunately because reading in a range might f=
ail.
>
> As in the asynchronous read generats an error, but finishes faster
> than the submitting context calling the atomic_dec_and_test here?
>
> Yes, that is possible, although rare.  But having a way to pass
> that information on somehow.  PG_uptodate/folio uptodate would make

We could use the upper bit of read_bytes_pending to track if any error
occurred, but that still means if there's an error we'd miss marking
the ranges that were successfully read in as uptodate. But that's a
great point, maybe that's fine since that should not happen often
anyways.

> sense for that, but right now we expect folio_end_read to set that.
> And I fail to understand the logic folio_end_read - it should clear
> the locked bit and add the updatodate one, but I have no idea how
> it makes that happen.
>
I think that happens in the folio_xor_flags_has_waiters() ->
xor_unlock_is_negative_byte() call, which does an xor using the
PG_locked/PG_uptodate mask, but the naming of the function kind of
obfuscates that.

