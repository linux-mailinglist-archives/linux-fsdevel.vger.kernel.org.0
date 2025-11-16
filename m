Return-Path: <linux-fsdevel+bounces-68602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB4CC61087
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 06:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0ABDD244DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 05:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A0123717F;
	Sun, 16 Nov 2025 05:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="b/3Tk1wU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ABA223DC1
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Nov 2025 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763271836; cv=none; b=GU22lROxo7VW7nOj6z1dEOXkyVNk7Ol4D5myR4C0ohK79igUIYWJTq5cxYZxjXnskH++NFh8hgPxnRRWsPXKMLIVx0mxc2vI2Ovnp2FU1qGgdJIRh6eK8fZmgK27vVxe+etpNSFBiRVa8V08mmUuqBmihs2hQMFHoJbo0PSHSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763271836; c=relaxed/simple;
	bh=eoJw2Efup2w2YVsLo4aqrneZqPKDdsmFPYUMFj/63dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1LKUTXDXLe9khobbEIHuncYzOBvmMSnys6WnzZlL9uI9wN+zlpvwnIC8Gybh50FHaTBNsQoK2nlsYzgNtqSzJpjtptVmfp//cle+hi3i+8UafD2nX1oqT63u6qFk9Beu5maruu2NGdk1bVWwiMDKssIjkvTz5aYlyhipEi3WEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=b/3Tk1wU; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-641e942242cso1422707d50.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 21:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1763271834; x=1763876634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sirh6NDYx1jXZksmc9REBWYgPRZY1FFJRO7s3p+KRfI=;
        b=b/3Tk1wU/TcVah99K5wf/VdYDDv+w3oxTExwdNSS5oCknraSSSYiwaKDaSjtCn7ubo
         OZSu9bDkm+uwEJKtxk2aFQklWA13n8BeTIjVxb3HwvScW+tjOz6+cFRjYe5p0o3z1bXN
         34Xk3hQDNgrbQ0rLs6OpJOJMsH7OvIdI6mcgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763271834; x=1763876634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sirh6NDYx1jXZksmc9REBWYgPRZY1FFJRO7s3p+KRfI=;
        b=KyfWuhZzu1wUaRFPYesJm7/53/lcSkiGEvFU23OyBAJO0q5+zGIS1/JmrndWdNPLZg
         3DFu7Y6C+Lq0X1YwG0U518jucXnvem1VD01k1GSYo5eupoumfff9SJwcOITw4jpNY0rO
         xfR9gWzxTkNmVa1TXAyx9dD4J50pOswv8SxZ3biToyb4hkQpS1F+jtcX00eDvCnp5MYB
         TmkX7n515wSUKeDHFUPYaz7ag7xs1H+ZG74KEcK9OCq8OJE65D6zl3s7f3yTqYwG76+B
         O4SztIybedkgbE3hZbkFivyrUM2icIq11Tur/wfLX5yNGJjx5wOSiYv7yQ4+hfcxqkhP
         iGbw==
X-Forwarded-Encrypted: i=1; AJvYcCW8LnbqdJNLkgq4yOquiBjtCj472jxMDTaFA02TwZVJYC3/thni+J0pR4RYoyWXvRBmGC/7Tyk5v2PhPurV@vger.kernel.org
X-Gm-Message-State: AOJu0YyNfnocATtyVZLqSh4SJrUFMI7njwRUMKnI6l1+B/J/fo0y196C
	ym8HwIz5Zxg1X32x4sWxEluT/X+wM5HGivHngO96GVCIbSvs/tXOnq11hyg+7vnTAbB+P26/8ZI
	rjJvmcVgh/topYRdvNDFS0LCp+cBmz8Qsw++w7ow6Pg==
X-Gm-Gg: ASbGncs6Zhdh78Wn5c+V2nxejeE0yisqLhP3cDMvYskEUqZQCv4fKx8vSKXnD9+4864
	m0Q1KlvXOoSeG8KYSFfwRbzKyk9RjCvHsXMnQV9WD8tZXaJlekMYfmdvOLw3YbsSyPrcXw3aBd5
	sV+OsC0awmX6tSyQKZVROP/ewoSyNE2xcefARzHsaAJLi8KVvDmXBb/n+hQgB5hGKJ4EsxM9Pr4
	CUGg2TGdUqYxZUzLoiz8+5EBMF42XZ6ktcRLwGSrnVyq2u6SdM++xqftar3C2+oP1WbvPYh5bGN
	Tay1ktLGvOVubG1LJJfGMTGVI5uHIg==
X-Google-Smtp-Source: AGHT+IE+5DA78oTs53xtft4SWvilkCaz3ny9tzlKa2iQLr6n4dDJdZ1qZa1fVJLBqkojTcs9rHz8X3gNdwixSxrbVqw=
X-Received: by 2002:a05:690e:4296:20b0:636:d63e:5c1f with SMTP id
 956f58d0204a3-641e7681ef6mr5755482d50.49.1763271834121; Sat, 15 Nov 2025
 21:43:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114193729.251892-1-ssranevjti@gmail.com> <aReUv1kVACh3UKv-@casper.infradead.org>
In-Reply-To: <aReUv1kVACh3UKv-@casper.infradead.org>
From: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Date: Sun, 16 Nov 2025 11:13:42 +0530
X-Gm-Features: AWmQ_blIHXWGYcdl0Doxe099dF8-mjHoCOkxYkSY-L1Qbxh_adlvYQhe5rWPRrM
Message-ID: <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in do_read_cache_folio()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, eddyz87@gmail.com, 
	andrii@kernel.org, ast@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, 
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 2:14=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Nov 15, 2025 at 01:07:29AM +0530, ssrane_b23@ee.vjti.ac.in wrote:
> > When read_cache_folio() is called with a NULL filler function on a
> > mapping that does not implement read_folio, a NULL pointer
> > dereference occurs in filemap_read_folio().
> >
> > The crash occurs when:
> >
> > build_id_parse() is called on a VMA backed by a file from a
> > filesystem that does not implement ->read_folio() (e.g. procfs,
> > sysfs, or other virtual filesystems).
>
> Not a fan of this approach, to be honest.  This should be caught at
> a higher level.  In __build_id_parse(), there's already a check:
>
>         /* only works for page backed storage  */
>         if (!vma->vm_file)
>                 return -EINVAL;
>
> which is funny because the comment is correct, but the code is not.
> I suspect the right answer is to add right after it:
>
> +       if (vma->vm_file->f_mapping->a_ops =3D=3D &empty_aops)
> +               return -EINVAL;
>
> Want to test that out?
Thanks for the suggestion.
Checking for
    a_ops =3D=3D &empty_aops
is not enough. Certain filesystems for example XFS with DAX use
their own a_ops table (not empty_aops) but still do not implement
->read_folio(). In those cases read_cache_folio() still ends up with
filler =3D NULL and filemap_read_folio(NULL) crashes.
Since build_id_parse() only works for true page-backed mappings, I think th=
e
most reliable fix is to fail even earlier in _build_id_parse() before
we even reach the filemap path:

    if (!vma->vm_file->f_mapping->a_ops->read_folio)
        return -EINVAL;

This catches XFS+DAX and any other filesystem that lacks ->read_folio,
and it fails fast at the correct layer rather than deeper in mm/filemap.

I think this is the right approach. I=E2=80=99ll send a v2 shortly.

