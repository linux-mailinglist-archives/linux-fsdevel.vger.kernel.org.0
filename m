Return-Path: <linux-fsdevel+bounces-39063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AFEA0BD30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 17:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CDB1889AB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0BC1FBBF3;
	Mon, 13 Jan 2025 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU8eo0Ml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8F514A4D1
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785508; cv=none; b=aFV+Gj8eSYSVM9e3z1OckaQacX7HbXYqNAtnYijrIV/ma4NKW7Vb9iITSiu3YjkCmbF6agEapW3CpiRThShVGGtUHT9ZJJQ1qgLq7A3/bViHxorBzA5p0/se4LizLYjJwS6xD+SrkIyP0OHikF9k+dgUafuz5nsBwqb/eYvY6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785508; c=relaxed/simple;
	bh=LWCUhE6qRac4v5NNdRon+8rEi7kvW+EoMeYL1gMCuK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8fa3F5sUdR9Nox7dmxcQpI8lVZNe0pZtHdxHpYbMUcFmB62965xvsPPhE8oJ/y0ZmtW9SRT8WzyLah9FIVb6OGr9GP+Pl/4qpKpRPsy9kWNHFbi+9gyATS/8TZN76v45a2p3nL3RA6F8pJPWQhaGFEGqMEuhB2j2COlfFKAmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LU8eo0Ml; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736785505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWCUhE6qRac4v5NNdRon+8rEi7kvW+EoMeYL1gMCuK0=;
	b=LU8eo0MlrGPy2QwbVBYhbwuVZeKjiJlddvCqisc0jxqBiMlmoRiFBFkPB/gsXbnw3Gok6+
	vgX0zc1GbbZwauo4lQjVKLHz6qNUpfeoJ4TkdCduAt31bQbggtFmuyqEKpIJRm8qx9yhCx
	v0wPxxYpElAgh51ve0yPlr/hY3LEDjU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-DB_jwMusN5-MMBNr43LpFA-1; Mon, 13 Jan 2025 11:25:04 -0500
X-MC-Unique: DB_jwMusN5-MMBNr43LpFA-1
X-Mimecast-MFC-AGG-ID: DB_jwMusN5-MMBNr43LpFA
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216728b170cso84155875ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 08:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736785503; x=1737390303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWCUhE6qRac4v5NNdRon+8rEi7kvW+EoMeYL1gMCuK0=;
        b=BemegB9I91GzlwaJ9xq+1YeBMo7t20/TpKNGhXYwAfS5EOKVQ89qwPdjHB0SCKOw5I
         sRC95g5usXLKPE2dKzPGpb4HRIw5blSlXRqbAZBva3kJIIoQQg2DwueT1+eaxUQOggHc
         GfWmqIYY2kYluf3KsK1W10+TPa+9Nhla41qzhgrxKpkZJRkk7hQopETxb8duZMnaQYCI
         ha7/8H608YqH05Hpc5HJE6jCo1JVvk7FqC0NKjUSdZrXXZIaUxn34fkoId5IrpKfs2UK
         I6TDlxOE4i+VnikYVC/Qdpq/Ah5WDSUpawUZL7mOriOWpkqpg3mnjFsirQ1w1Qg3edmB
         Mmlg==
X-Forwarded-Encrypted: i=1; AJvYcCUg+39dEyIfcl3p7m1RaOeF9IeBGvszDmxe/K8VfOMcJqMZUw9hvQYMylNaVEpyyCwEuJ6uF7mVePwOxlhS@vger.kernel.org
X-Gm-Message-State: AOJu0YyVQqyca4LuR83xmipW6SHQvefIezaUW9XfRclEyH0FJcdHdlkH
	5W0RAjn+psUjDo6FdzhtofxXOWcYJ5VNc4sUxyUtneT8+yBrd+ECIfvskVpRs1sqk6gZl41cQNu
	ehx0KbIfvsrk9GBCQvOWr/KwJ3mqWoEcdYHaVsWvLXPYjUAYRt4s1/kN2G6R6+v4YvL9s/IiTWX
	ltAwXlPR3IaTrDPjk+T2eN383LE5bHeJ9CeFUsjw==
X-Gm-Gg: ASbGncuPU8Fe327wyVD2GAiauW8sHuJiKZ3mfXu43L3m1Iikua1p602wU53Gn2ENZ5Q
	m1vrepD5OffeVq35JnGzPjQtQsusDcaZlpcv/
X-Received: by 2002:a17:902:ecc5:b0:215:7dbf:f3de with SMTP id d9443c01a7336-21a83f5e4e5mr326959875ad.28.1736785503247;
        Mon, 13 Jan 2025 08:25:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0jUlx8LbipayI4T0xGE2BAcW+hI504rIz1zUuL1evo3KxMbXqucm99OrrMJgJ+Hjr+D71qSHHJbbelVmGJgA=
X-Received: by 2002:a17:902:ecc5:b0:215:7dbf:f3de with SMTP id
 d9443c01a7336-21a83f5e4e5mr326959515ad.28.1736785502970; Mon, 13 Jan 2025
 08:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn> <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn> <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn> <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
In-Reply-To: <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 13 Jan 2025 17:24:51 +0100
X-Gm-Features: AbW1kvbcavtL6uBmJAkF4VNFZU3Xvdt54cbg-SQZf3tWJEbZi3OHIXZdU6LM7HY
Message-ID: <CAHc6FU7Tng3OLB367Uo8aXRjPEfhCJiMOEUawhd3_bbHUPiVpw@mail.gmail.com>
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, gfs2@lists.linux.dev, 
	Kun Hu <huk23@m.fudan.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 4:41=E2=80=AFPM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
> Hi Jan,
>
> Am Fr., 10. Jan. 2025 um 18:18 Uhr schrieb Kun Hu <huk23@m.fudan.edu.cn>:
> > > Thanks. Based on the crash report and the reproducer it indeed looks =
like
> > > some mixing of iomap_folio_state and buffer heads attached to a folio
> > > (iomap_folio_state is attached there but we end up calling
> > > __block_write_begin_int() which expects buffer heads there) in GFS2. =
GFS2
> > > guys, care to have a look?
> > >
> >
> > Thanks to Jan.
> >
> > Hi Andreas,
> >
> > It seems that iomap_write_begin is expected to handle I/O directly base=
d on folio, rather than entering the buffer head path. Is it possible that =
GFS2 incorrectly passes data related to buffer head to iomap_write_begin?
> >
> > Could you please help us to check the exact cause of the issue?
>
> 32generated_program.c memory maps the filesystem image, mounts it, and
> then modifies it through the memory map. It's those modifications that
> cause gfs2 to crash, so the test case is invalid.

Ah, I misread, the memory map is distinct from the filesystem. So
forget about disabling CONFIG_BLK_DEV_WRITE_MOUNTED not working.

Thanks,
Andreas


