Return-Path: <linux-fsdevel+bounces-37105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90099ED8F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0ED1188EFC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 21:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FB71F2C3D;
	Wed, 11 Dec 2024 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmAz78Z/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62231F2C35
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952913; cv=none; b=Er9V+pT16xs31MsOMIEH6eS6NDeAK7iMiVK3IdLzA612VZ+fqO+ril/NIF4Fe+DcJnC1HT6tPP7Qwfq0nPuYiGDohpa3sjvFSG9MiYR9TNuvovKY4wJZ1CBB6hVye9Ew/TNL0fbAxdF5ZiAFfcOJUEaAGBNd/ffGJZLHftehWNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952913; c=relaxed/simple;
	bh=2AhOaNRP5d22zvgPxXWOZUQp2eXOYUMy1UTfc+AC0mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kE1tH6c2dmOtcpqeM9ZPqq7ACwZECyNjrPhwm9xZFqafiIAqFq9zOG+5KJKKHNZxzH1tUC+JmbI5lWUykpUypCtjL4dA9+Rr8JiLE8aWpqIiEMPBkeFdYIloOI/oA7X/RbwzdjwDUuQnxueVof39ahyZj4AKBDYqVLG1jcZi/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmAz78Z/; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467745731fdso18435501cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 13:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733952911; x=1734557711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5QpC9E2IEnSkNy/eQNx6WQ/LQ8HE8lT525d0r/E9nI=;
        b=PmAz78Z/OYjobTc2VpmlWWMAeTcVZ21QzvPnOeXSKNYiizcpjsj9lphtp7enFpriaA
         MsgBArwPKhvZKI37Sq+qKoGHLIi5FTKZVJofzAQlQ4F9MfiPEEH4hCav1b7TL3rzRVtM
         gR1vWjPNh/s+I7+GCfpZ8hKTD069MQL5u+bLHVF5ovlY7ma7RneYR3cKVdczbeXqEbVZ
         RUK4w0bn88VvOBCqP35336yL6UyagqL6SjkDSAOHcCTKj7yQ+FESdxMotSIH9uLS5UfI
         U0Yk+tnyxFrec9VmZnPaRbeAM59d7xdOHbOfVKSDW6z/O/z5v80Ui41ITxUv56e2GpqQ
         ZZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952911; x=1734557711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5QpC9E2IEnSkNy/eQNx6WQ/LQ8HE8lT525d0r/E9nI=;
        b=fAclmXGCZ4Tq5GHiaoD5xUUnsOukxcp0P5T7XjalsVjBuPBfgDvDzqdgVSAn2C/YF4
         7RykZ/x30zrh9lEf7ggFMvaiR9TSQP+5zhQadI0iQ8Q5Imw5xxDGxfFeC1famAnSLdYx
         zZxcn22KN1y7yVqRj0ZAN2Pl8h5xOK7OdfvnqXaL42lDeudftEeybb1xcMh1IFTLxX0h
         qtR7pb/vjgFweijaGniugaeLR3pwEqogmwoDL++GKdLq4tk2kDDcNgQ98zLPuPGSSvNU
         KiBbq7L8crrLFIupD0Hs6b0tJtWwqSb0Pr3RYWKrd2xn4WKgZPaqtSClgRi6i+LUIKCm
         Bw9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9ePK9dHuzX4KikoRdadlWQLpN24mlG4lrsIrZyk0hUtWHziliHsgq/oq6bI0Y3bGut9xPp9RornZMoDHn@vger.kernel.org
X-Gm-Message-State: AOJu0YyQHJezrQ+V74aRkDNXCU8cjYCvqA6Do3SpSrinjlLvqeR/AndU
	xQyDK7tOv7ZyUUWr7PaeQuWnwFIS7JW9BFNFg33yqK1zSYyv2WkyvGlLeh/h5TeXwOTygGh0nyB
	ySdcdivr4jwNULnlYfBr5P93Dysw=
X-Gm-Gg: ASbGncsm/vcAXKYj9oHVh30KaWogpmxkjcCvFF/hHFIUp8E28JXEP12WC94zlec0Qgb
	1xNy0wo7LGYwyXQf5C+61AP5HkEKKOSUGmrLOhk7NJTDbWPrLnQc=
X-Google-Smtp-Source: AGHT+IGZ4rtx7UMIW5VsORa2IBcV8lkrzb47mqnOTPufdIPIi497fNlDcIE32ua58ZEFAJUjuPE6+mToloTT1JLNvUA=
X-Received: by 2002:a05:622a:1188:b0:467:882d:e7c6 with SMTP id
 d75a77b69052e-4679624a7bdmr15791841cf.34.1733952910800; Wed, 11 Dec 2024
 13:35:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
 <20241125220537.3663725-11-joannelkoong@gmail.com> <20241209155042.GB2843669@perftesting>
 <Z1cSy1OUxPZ2kzYT@casper.infradead.org> <CAJnrk1YYeYcUxwrojuDFKsYKG5yK-p_Z9MkYBuHTavNrRfR-PQ@mail.gmail.com>
 <Z1oAEr6WFh6cSerU@casper.infradead.org>
In-Reply-To: <Z1oAEr6WFh6cSerU@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 11 Dec 2024 13:35:00 -0800
Message-ID: <CAJnrk1ZhBKNi5dBPi9kHK9Jvn1XDLMJpA3k596z1pfpJenyHQA@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] fuse: support large folios for direct io
To: Matthew Wilcox <willy@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:11=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Dec 11, 2024 at 01:04:45PM -0800, Joanne Koong wrote:
> > On Mon, Dec 9, 2024 at 7:54=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> > >
> > > On Mon, Dec 09, 2024 at 10:50:42AM -0500, Josef Bacik wrote:
> > > > As we've noticed in the upstream bug report for your initial work h=
ere, this
> > > > isn't quite correct, as we could have gotten a large folio in from =
userspace.  I
> > > > think the better thing here is to do the page extraction, and then =
keep track of
> > > > the last folio we saw, and simply skip any folios that are the same=
 for the
> > > > pages we have.  This way we can handle large folios correctly.  Tha=
nks,
> > >
> > > Some people have in the past thought that they could skip subsequent
> > > page lookup if the folio they get back is large.  This is an incorrec=
t
> > > optimisation.  Userspace may mmap() a file PROT_WRITE, MAP_PRIVATE.
> > > If they store to the middle of a large folio (the file that is mmaped
> > > may be on a filesystem that does support large folios, rather than
> > > fuse), then we'll have, eg:
> > >
> > > folio A page 0
> > > folio A page 1
> > > folio B page 0
> > > folio A page 3
> > >
> > > where folio A belongs to the file and folio B is an anonymous COW pag=
e.
> >
> > Sounds good, I'll fix this up in v3. Thanks.
>
> Hm?  I didn't notice this bug in your code, just mentioning something
> I've seen other people do and wanted to make suree you didn't.  Did I
> miss a bug in your code?

Hi Matthew,

I believe I'm doing this too in this patchset with these two lines:

len =3D min_t(ssize_t, ret, folio_size(folio) - folio_offset);
...
i +=3D DIV_ROUND_UP(start + len, PAGE_SIZE);
(where i is the index into the array of extracted pages)

where I incorrectly assume the entire folio is contiguously
represented in the next set of extracted pages so I just skip over
those.

Whereas what I need to do is check every page that was extracted to
see if it does actually belong to the same folio as the previous page
and adjust the length calculations accordingly.

Thanks for flagging this.

