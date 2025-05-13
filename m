Return-Path: <linux-fsdevel+bounces-48801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B55AB4B55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 07:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A9C1B431AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 05:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC401F5435;
	Tue, 13 May 2025 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rRc0yack"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8E1EB1B5
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747115213; cv=none; b=aOJf5ASJOVfCSHfoeBCNcfC0i9v7oGtfllSCNqhpdKbhmOjGCRiLVe+ACY8fpExbeE1qapWi79l5Hc3bcnePigh9yxwEf1G2fWjMpgslEsWShcS5zjgOS8eoITmrJrCd+9AtexyUIENrmj3ihbltsUrqoYp/43KPqd3Kny2Z2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747115213; c=relaxed/simple;
	bh=rk0Q7zX1O5k6KtyJK/DSflLmfY+NdEWdfExE3WQXLhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpTxQv49rNAnMs7SRjjNl11xAWF2kjJVqbKL0Kh2sTCsXtszwouZ75SO5HIIjyyXCp0svE+qVrS/4f73a0llKSnJeCnB5uFoFMwqPUSRc7SAcvZRDZXrVtWETKB4608fvwGT3HUHN9yspcqvSbQRreOjOxYSKjuKGJwnLzeDQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rRc0yack; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2da3b3bb560so4106598fac.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 22:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747115208; x=1747720008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk0Q7zX1O5k6KtyJK/DSflLmfY+NdEWdfExE3WQXLhg=;
        b=rRc0yackWkqRsKVF5/BlS0n0SnK9Ihr68iAhBZXMDu6ySVfxgFNLNMuZtWley7M/KZ
         qCpY/qBITcc9x7pRfgXGZeLnp4jRpVZl/Ho/f/HRdXJqIKR90vnaw/5pOM9pj9Y/KQ7E
         KHOumgJ7v3BfSwdxLsxuB4nJ7dWk+A+FDTnd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747115208; x=1747720008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rk0Q7zX1O5k6KtyJK/DSflLmfY+NdEWdfExE3WQXLhg=;
        b=OpBXYY53o8CmeF+P45lWMXYz4+Mr1vzl3pBxvAspR1ZhRiokDNfjk5OWiQnI09pDHn
         96mghLcz3tacZNxibmWIXRz7PNhsR8FzoKisUnGPCEaMzYfTLgALNhBEwD1wqxs58xJg
         YstPc0grhpN4GG66iQEgu9mhJb2mWNjzGz887T6trqSYQyeYK7/R+PyGuMTzGEb4Vw00
         elZW0AL+SjjovtyHlajt7PHq9cSFmeBCTvYy3xKdu+YPrXYKHKGvaWnWkBkD1wzCDw36
         glEuRt2OPPr8U0TTeoOEHmsFZEsdLRfp0YypGkAaMUjQUs7KKmxiTveElGsF5EZQSngI
         dfYQ==
X-Gm-Message-State: AOJu0Yyj26p25T6P7qUOD4Lchd8L8i6g720Pw53JHNgNT5e4L0qX0XDe
	Lhp7OJjN04zvUFYK2gX4U92NQ/kTHawhiooEu72ND8BlhEis5xlAB+ne6Voa0k3emkZDeDkmjjD
	LjcdfdybXzasF2BxO9N3x7hxc0tNdJPitwpGbqdF8H0N+Eeaf
X-Gm-Gg: ASbGncs5Oxjde5Iko9rnbPZaP7BO0msHcyww1STb/+zWYsOpDLhmn4LWy2e2ONJ9QdF
	vcceiMBbw/2KSkJq4MQA97Jb3ekfOkrdneLW86ad+HoPlgpgk4PVUFXBXtJdK4KgngwI647z1vS
	DI/UNqNVnieWX9qk3lK1ueu3VD166HE9A=
X-Google-Smtp-Source: AGHT+IF8pUh2sJGyLXuoYqh5MoOFXTnXHFiBDGTBYsJL4/80dMp8j7ZodHcUkvEIx+3kyx0cSmyChdo66C9a4U+xh+I=
X-Received: by 2002:a05:622a:4c83:b0:494:58a3:d40b with SMTP id
 d75a77b69052e-49458a3d82fmr222102581cf.5.1747115198006; Mon, 12 May 2025
 22:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422235607.3652064-1-joannelkoong@gmail.com>
 <CAJfpegsc8OHkv8wQrHSxXE-5Tq8DMhNnGWVpSnpu5+z5PBghFA@mail.gmail.com> <CAJnrk1ZXBOzMB69vyhzpqZWdSmpSxRcJuirVBVmPd6ynemt_SQ@mail.gmail.com>
In-Reply-To: <CAJnrk1ZXBOzMB69vyhzpqZWdSmpSxRcJuirVBVmPd6ynemt_SQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 13 May 2025 07:46:27 +0200
X-Gm-Features: AX0GCFt8kO_1qBWERtbB1kfZFIREHdJ-Q0JN63cf5kFgeAUPdfc_EMUIuyax7hs
Message-ID: <CAJfpegsqCHX759fh1TPfrDE9fu-vj+XWVxRK6kXQz5__60aU=w@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use splice for reading user pages on servers
 that enable it
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	jlayton@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 May 2025 at 21:03, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Wed, May 7, 2025 at 7:45=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Wed, 23 Apr 2025 at 01:56, Joanne Koong <joannelkoong@gmail.com> wro=
te:
> >
> > > For servers that do not need to access pages after answering the
> > > request, splice gives a non-trivial improvement in performance.
> > > Benchmarks show roughly a 40% speedup.
> >
> > Hmm, have you looked at where this speedup comes from?
> >
> > Is this a real zero-copy scenario where the server just forwards the
> > pages to a driver which does DMA, so that the CPU never actually
> > touches the page contents?
>
> I ran the benchmarks last month on the passthrough_ll server (from the
> libfuse examples) with the actual copying out / buffer processing
> removed (eg the .write_buf handler immediately returns
> "fuse_reply_write(req, fuse_buf_size(in_buf));".

Ah, ok.

It would be good to see results in a more realistic scenario than that
before deciding to do this.

Thanks,
Miklos

