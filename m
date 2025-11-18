Return-Path: <linux-fsdevel+bounces-69016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB9FC6B77F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 20:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C877035820D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 19:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4BC2E8B98;
	Tue, 18 Nov 2025 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gio1JkrR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFB2DE6E9
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494731; cv=none; b=PFyOJNWqmbOysyPDkcOb/kVNkL9jIu+e+prTLcwby6m2FzYv5US8uPYFfREhBAeJUz6YykEOvv/yxtbmUuTP7RxXnhu3/VZ0KzX7H+IlSVfMKfaEwsvBZk5QtvqUb+MS7hwa5R/ms0mLco8LCKd1dhCiqLw79fc91C9MBMGVHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494731; c=relaxed/simple;
	bh=8o/mKyv3A3lFC7y0XtOvzYtcPxEWOuachx5Hy4zXOOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mj/mDbiHIqXb0JEwZa03FMKcXxno0kxIOCxuvEfYrmR1Xq642DPYyxe8RVKwlnNjiuYkkWnNbIm9c5rc4A5c/T5gYF/n3B4EC/61s8PIVyjMGuV/9RsGANirT5cUnPK0vKOaRvDTjGFgMUn6ujQaXKv8zeNXfO0hqBmZS7E9ywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gio1JkrR; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-343806688c5so6339058a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 11:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763494729; x=1764099529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xP8obOsgLV+Mi7QU5SctjthhRGiNVWVhn+AWfuje1og=;
        b=gio1JkrRtXa0JWCCqwBGY4AUvzlRNAG4qW+qsdqiI8DSwBPqBmU7bIzVw+lMg2hYjz
         ohwVIYI1amhnS7ZBiLxw3q5H039FWvlX4NPVIY6PUftmfymkNj5RpLUcspLIloP/a1Af
         /3+H1RvemGSRpEJ59kFESK0EpUTLCHSzyP668sNwgZgi+y6IN97XzGPep2xz9A4bdq46
         mvN2i5X+ZOXAzVop2e+o0J4fQXvwe6B3pzWu8dg8NTP/4/gJO9lwGPjTGnQBgnH+rYcJ
         vf9hIXJBnl2RMd3mXuSDkvJjdgIfDLS5lg1uZ82G8KrqXjw4YQTIV66LHxPA+bBMswEn
         Phcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763494729; x=1764099529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xP8obOsgLV+Mi7QU5SctjthhRGiNVWVhn+AWfuje1og=;
        b=f/dnnNRG8zb59YgyFv783wwGieCBeFvSp5hA7HFO+O0Bn6R8RffnX9/7F3Zn/evW4T
         cs9+Y9wqhbnabeEh6AFpq238RveXisK1zg1T20qvrfeliC+MfK3a8u0Va1xU3sVch4ID
         vMjFmLv9q/azrRQnKL1/R6piL23Yx6eyIrdVrsVF58DGTBYRjbfaS1RxCkZPNKnNxn6f
         zQQpnep3F6ZEqBuOpZkr8CoDLb8r0uUyERrQLaNFZyYPS30b1pTVzR4IQPq8dwFMRfb2
         oMf7OQqc0O8GK5ROLhehcno9VGfarlPXdaDzAv57vDdOYwxXmTrewoPAP1E2EWQsAfku
         MqQA==
X-Forwarded-Encrypted: i=1; AJvYcCXmG5d/3vSsQ0FxKkyvNq39cdSKasJU3Zoy8pZLBeWj1CD++OTL0g+Zfbi1JLJR6aXebCDR0Q43aYreOg1M@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cLduroVQcjN7xHPPEdNoQfbjGrhFkwJ8nRglBNhFeAhoyM1o
	/sZITINZhtARtTPEBcbUFiAIciw949yale62ZtZYexx873S5h25U63S916r5Ft5LpCi5n2I2Ymn
	fkzJg0NBrVL/GX3uzq75vziNzdLrrTtE=
X-Gm-Gg: ASbGncvLfMIb/bvE8a3nU4DZi/OTdgozPrXTcVp+ApYtEf+Fh0IsCUH6UsLdEDor3SR
	yVSWDF+1aQIgqXweL3D9s5ArqS0sWHkgw2slZqS1Rqa5/5DngfoO+kCXpH+kuPtYkptAF6sdVO2
	M2BZCySRnIaE8FBcnLKaB2rvB7MfgmONNiKDEqfGI7hWiTSewh9fKWggZjAXW7AxDKQWd/yQ0Uw
	VmfvQBe5/5Q4lSjST72A/tSKSyN9IrZIPDyqIKxGnM9A3+jMLBh9CsaoZJl+q5TO+4CXkyo3Hns
	FFRVPbeP/a7wb3i2LER6eA==
X-Google-Smtp-Source: AGHT+IHjQ5qI54V48OaD9lOMuf97MRj94VnLpjJI2NcKNfYtXCw0gbO/k0nfKsSQ9TEAtm7URf1eXdHMpVdLUVZFnJg=
X-Received: by 2002:a17:90b:58ef:b0:343:7714:4ca6 with SMTP id
 98e67ed59e1d1-343fa62be93mr16554523a91.22.1763494728613; Tue, 18 Nov 2025
 11:38:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114193729.251892-1-ssranevjti@gmail.com> <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org> <20251117164155.GB196362@frogsfrogsfrogs>
 <aRtjfN7sC6_Bv4bx@casper.infradead.org> <CAEf4BzZu+u-F9SjhcY5GN5vumOi6X=3AwUom+KJXeCpvC+-ppQ@mail.gmail.com>
 <aRxunCkc4VomEUdo@infradead.org> <aRySpQbNuw3Y5DN-@casper.infradead.org> <20251118161220.GE196362@frogsfrogsfrogs>
In-Reply-To: <20251118161220.GE196362@frogsfrogsfrogs>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 18 Nov 2025 11:38:36 -0800
X-Gm-Features: AWmQ_bk9sXea8jL7B_XWSvq1NtCko5Jbx6_OaVtFvyVo8HnLwKRsCuuE1XHa0Cc
Message-ID: <CAEf4BzYkPxUcQK2VWEE+8N=U5CXjtUNs6GfbfW2+GoTDebk19A@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in do_read_cache_folio()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>, akpm@linux-foundation.org, 
	shakeel.butt@linux.dev, eddyz87@gmail.com, andrii@kernel.org, ast@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 8:12=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Nov 18, 2025 at 03:37:09PM +0000, Matthew Wilcox wrote:
> > On Tue, Nov 18, 2025 at 05:03:24AM -0800, Christoph Hellwig wrote:
> > > On Mon, Nov 17, 2025 at 10:45:31AM -0800, Andrii Nakryiko wrote:
> > > > As I replied on another email, ideally we'd have some low-level fil=
e
> > > > reading interface where we wouldn't have to know about secretmem, o=
r
> > > > XFS+DAX, or whatever other unusual combination of conditions where
> > > > exposed internal APIs like filemap_get_folio() + read_cache_folio()
> > > > can crash.
> > >
> > > The problem is that you did something totally insane and it kinda wor=
ks
> > > most of the time.
> >
> > ... on 64-bit systems.  The HIGHMEM handling is screwed up too.
> >
> > > But bpf or any other file system consumer has
> > > absolutely not business poking into the page cache to start with.
> >
> > Agreed.
> >
> > > And I'm really pissed off that you wrote and merged this code without
> > > ever bothering to talk to a FS or MM person who have immediately told
> > > you so.  Let's just rip out this buildid junk for now and restart
> > > because the problem isn't actually that easy.
> >
> > Oh, they did talk to fs & mm people originally and were told NO, so the=
y
> > sneaked it in through the BPF tree.
> >
> > https://lore.kernel.org/all/20230316170149.4106586-1-jolsa@kernel.org/
> >
> > > > The only real limitation is that we'd like to be able to control
> > > > whether we are ok sleeping or not, as this code can be called from
> > > > pretty much anywhere BPF might run, which includes NMI context.
> > > >
> > > > Would this kiocb_read() approach work under those circumstances?
> > >
> > > No.  IOCB_NOWAIT is just a hint to avoid blocking function calls.
> > > It is not guarantee and a guarantee is basically impossible.
> >
> > I'm not sure I'd go that far -- I think we're pretty good about not
> > sleeping when IOCB_NOWAIT is specified and any remaining places can
> > be fixed up.
> >
> > But I am inclined to rip out the buildid code, just because the
> > authors have been so rude.
>
> Which fstest actually checks the functionality of the buildid code?
> I don't find any, which means none of the fs people have a good signal
> for breakage in this, um, novel file I/O path.

We have plenty of build ID tests in BPF selftest that validate this
functionality:

  - tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
  - tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
  - tools/testing/selftests/bpf/prog_tests/build_id.c

This functionality is exposed to BPF (and PROCMAP_QUERY, which has its
own mm selftests), so that's where we test this. So we'll know at the
very least when trees merge that something is broken.

>
> --D

