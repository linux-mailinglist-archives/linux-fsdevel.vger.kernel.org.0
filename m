Return-Path: <linux-fsdevel+bounces-49175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 942F2AB8F52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 20:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8C01BC2E67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 18:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAC726982D;
	Thu, 15 May 2025 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SS8iPPp4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F4746E
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335042; cv=none; b=qNdd8SepeKRSeQWI0snJgstzKoF5+oVwFD9tOYF+u3iLgo5WFloMF/bhHqdsX/jU7HujanKu+sjzFB3wfFJ5bfNuxo/5uOCpgOpucqKuLXL4bvwCDd1qMfxrGBRY9/gQUq8Pe+klh4i3fMAJ/4/v7rudjGN2O9pA2B3AtSM4vHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335042; c=relaxed/simple;
	bh=YWgkPlfMXzNwWae5wSFH5BLpARfI/pne6c2aW0De5l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2KBiGPS3ekUxHV8EyhsaXJ688GXRtUFtrA/PvT2VpkzkDg//oHsDDvt4IyzjMxbfyhAMVA2kmADEGfU5s0pBvDW8yPWZS/AwlehVy7OMs7PS44x6E9+OAwP9P1ohBxpCt29w2VJ1KgLVWnQUkKfkThElFzgU43LshcaoWmbciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SS8iPPp4; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-477282401b3so14559971cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747335040; x=1747939840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4C1JA3YgP/djpifeVRF5u6tPJ4zGLSaG41ADkM++4Q=;
        b=SS8iPPp4arCksxI5bU50Faoi0ikZDgLnoxxLXIGz4RBiSY9Z1386gV5BKB52Isw/QJ
         ySnpfr/i8vPCyZsFUtwipJTo7gjGRwpyVYR7VNNBLc8Se1AI2FHQmwkFyBEQGopZFxrg
         +cX3HyYFVd6KZLMT5W06QVWXkEDvLLP35wRiX3Gi4kG9gRd9ohJcVUn8Pcqdv+q2zoOV
         nUp9dMBbl3A7RRfuIybeJw0I65MvPv7kERkO1BrkBc3Fdy/kvpdHriZuuUGpYCqRuSF3
         wRMCpXl8D4SDVqPI/GCcwc2u2bUJcLuB7OIpqTY0BJ1mWT5P6bdAovkRsy1uqQZFPYPt
         XjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747335040; x=1747939840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4C1JA3YgP/djpifeVRF5u6tPJ4zGLSaG41ADkM++4Q=;
        b=F94VNYoraBExK4phWfJGr6pyRBlaYJDduW9Bnu5Lk2uTjsAZNh4Gzxk37JNYqLboGs
         I9mIe/j5lf7Kj3xoni/6iiiUU+ZkNbSoGEBbMCZ22MZh64RM4of+JY96+scVx7QBkaTO
         EI/wqhjFijA+1vNsV3yUFA8gIsgu82SPoKu27lxKJijTTu/H1yvBHUr9eRtVOrLLO+d5
         /XTlpdHF7kxP7JBLrT6joM/hxU7WBDdpxFHQFwQlenIwOo8mpmxBNju4CsHHFtNUWmpm
         cVbOBFx049rGQbncDYQX6uH70q6F3QfM/Vg5rLB+B7/jZWvtDFpSVzJ/cVQaGfZOQ35L
         9ZGg==
X-Forwarded-Encrypted: i=1; AJvYcCX5wvGgoyvqZdcBHG9CUb5/MESTLpWo9EIowSJfGP4No2QnlbRTbi1az6mhWfLRXeGfzgNIyuHHVJVhWA3A@vger.kernel.org
X-Gm-Message-State: AOJu0YxQpda9LJB69lb24Lo5LnTjdzeXBAuWrNZPI5Uof79dtS16BjTE
	h1BTmfFGPxhEBhKo4Dpxe0vYU8MOGHzQLYphJKbR7Tw0g8Fj099vXMh6dSQTb6+4o0/bSa87HCJ
	me1JwIjK4x0NYxdI5VbooDs/w/UzTdwg=
X-Gm-Gg: ASbGncsQPItWlPI1FH3h625JRtrG0+1+m30CB0JsubY6pEGKmI5xSxexdtU50XxpmTY
	KqP8qA+yVsY1PB4hUzolVWD4G4uGUHamAMP6FZPL9uAmjEb31UawJ6aVHBZ8WV9tTX8QRDnP2h6
	vuxA6mzI3nAcLebwsq/d9Fc3agh4wn5Jth
X-Google-Smtp-Source: AGHT+IEXm6E3U45o6HZumLcb2tEphcbItosQl9ZL0RIxzpPPqTpKdVKpNXJPRFAv80P0YtY4N6EgT4+7yjMa1pCNHZk=
X-Received: by 2002:a05:622a:1c0a:b0:476:fd53:287 with SMTP id
 d75a77b69052e-494ae4557b7mr9313841cf.44.1747335039725; Thu, 15 May 2025
 11:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512225840.826249-1-joannelkoong@gmail.com>
 <20250512225840.826249-2-joannelkoong@gmail.com> <aCPhbVxmfmBjC8Jh@casper.infradead.org>
 <CAJnrk1baSrQ__HxYDv99JpZr4FtXKDrjFfEw5AoUfVnM4ZJMNw@mail.gmail.com> <aCVMB8R8mo0aPWM9@casper.infradead.org>
In-Reply-To: <aCVMB8R8mo0aPWM9@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 15 May 2025 11:50:29 -0700
X-Gm-Features: AX0GCFud65U2aQfkGnRnQRgWRjuGEHPhXo65ByinvpTZSzgImys48orCibhghbQ
Message-ID: <CAJnrk1bnKtZgt2KGp8_JZmGkNkanYXMQS4CPsEv5Rh8TnfO+aw@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] fuse: support copying large folios
To: Matthew Wilcox <willy@infradead.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jlayton@kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 7:06=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, May 14, 2025 at 03:59:50PM -0700, Joanne Koong wrote:
> > On Tue, May 13, 2025 at 5:18=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > > kmap_local_folio() only maps the page which contains 'offset'.
> > > following what the functions in highmem.h do, i'd suggest something
> > > like:
> > >
> > >                 if (folio) {
> > >                         void *mapaddr =3D kmap_local_folio(folio, off=
set);
> > >                         void *buf =3D mapaddr;
> > >
> > >                         if (folio_test_highmem(folio) &&
> > >                             size > PAGE_SIZE - offset_in_page(offset)=
)
> > >                                 size =3D PAGE_SIZE - offset_in_page(o=
ffset);
> > >                         offset +=3D fuse_copy_do(cs, &buf, &count);
> > >                         kunmap_local(mapaddr);
> > >
> > Ahh okay, I see, thanks. Do you think it makes sense to change
> > kmap_local_folio() to kmap all the pages in the folio if the folio is
> > in highmem instead of the caller needing to do that for each page in
> > the folio one by one? We would need a kunmap_local_folio() where we
> > pass in the folio so that we know how many pages need to be unmapped,
> > but it seems to me like with large folios, every caller will be
> > running into this issue, so maybe we should just have
> > kmap_local_folio() handle it?
>
> Spoken like someone who hasn't looked into the implementation of
> kmap_local at all ;-)
>
> Basically, this isn't possible.  There's only space for 16 pages to be
> mapped at once, and we might want to copy from one folio to another, so
> we'd be limited to a maximum folio order of 8.  Expanding the reserved
> space for kmap is hard because it's primarily used on 32-bit machines
> and we're very constrained in VA space.

Ah okay, I see, thanks.

