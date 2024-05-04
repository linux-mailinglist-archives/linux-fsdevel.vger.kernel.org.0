Return-Path: <linux-fsdevel+bounces-18734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EFD8BBCEA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 17:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708AB28226C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB1E56B79;
	Sat,  4 May 2024 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pk5o2wu6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D616F4502E
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 May 2024 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714838048; cv=none; b=fe1HJe8tfDQU7vb4nB+5yL7mGW+J2SBOA/wialIdvlcSFioto1GTZaOp7vel9yVCJ6J4wLOqSozIulv37LBog3FF5Dd5JoiJJ6hFNJnGC5PJQzf44/5qQiHj9KK+5o+2i4gyfxj9ERccVcjHKcVYGR4xu2/upDh7PRaTOENaomI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714838048; c=relaxed/simple;
	bh=/aq2jAO4DmSNrNoBrUEE3/qpOKGIfIhWERou7A/I/9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zba09Yfk7aIv86kot/eHguyiJzBbBW8zpe48XfLC636jXkwsgSoM/GdZA1hbBKc+2d48dmc07GbnYRpqR7pUkqUeVU/oi+BEebryIrN6qK6pZlSH2Qfu5YDW+dhy+JV8PQicWAmQ50aOmurLwTKiYTFGZsKE+olLRm4Kdhy3Xzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pk5o2wu6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso124464366b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714838045; x=1715442845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kZo6ArVOf5NVi3NAdVYQGqHRs84wzKq7YB5CfjfJdNw=;
        b=Pk5o2wu6ylkaml0n6irgR+hnwmSMMhEvT/ppILJjg+eTVkaTgWi4GbkvBuCyg5FnvQ
         O8VWJuo+jANYfUPXScgrqxsikan+o1pfz9aD8O4Or+rujOgbZBqcd8riHSsK/V7y/Iop
         K0TzPRQzUEP8vLcZr7iiSwo8fZ/sIFKPykW1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714838045; x=1715442845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZo6ArVOf5NVi3NAdVYQGqHRs84wzKq7YB5CfjfJdNw=;
        b=Fdau9lvFpLzlZQgJNl1L+7c04bCbMxxLIFkZ8zE0piRh3lGGxDNn6HVuL3Bi68wTFH
         6LgBxBjTeyhjL6w2dMyQmiGKY/iVk2IMFlh4j4a7jJmzCEBCQoSd/xtcXffXzHq8qYwn
         31z3dN8qE9IvIGpRccnW97yE9etuTmSfxkDwkQe2wO9ClWp6+OE8Tlk2rsyRoXICror5
         2lc6YvV4TLYFK7Uq8U7NM41iZ1GMn9YKB1Yi7oB8r+2K4xNJZyPNVoq5jDtkUkEccgob
         elF75SJOPY/Z12FXuMHlEJd8p1JR8A4mSXHTWsqFKv3FePgefVzuHGdyiBJr8XMTe33V
         YIBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeYcN5lFKO23C82/AOhLcJf9klKPbl4Q6DtJhiDC6jqJtL5940jFR8cQanFTTFn5SXXKVf6xFAp5Lya9u+lQxFXEV2U+PyMXSa0OIoBw==
X-Gm-Message-State: AOJu0YzJQEarA44NkYkCZnQ8eFoIFr0piqqS1T0Yv7JTj6VuIb0iXe7h
	HPnT0srN5P4qqiiqTPtYLdBFc5aTw3pFKc7dEF8j9EPbPklckeiUkdJQBLtyts7N+AydVLUlmwt
	2ozxO9Q==
X-Google-Smtp-Source: AGHT+IGeYb8R232OcX99M8oxK/TPQJDwJfu/RtgUSF0er2K7xBi1VCrE+PtLbzAYXFmRzLnpHd/+QA==
X-Received: by 2002:a17:906:71d2:b0:a58:871f:8eb0 with SMTP id i18-20020a17090671d200b00a58871f8eb0mr4177031ejk.7.1714838045177;
        Sat, 04 May 2024 08:54:05 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id o3-20020a1709064f8300b00a58ea7cfeedsm3054811eju.62.2024.05.04.08.54.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 08:54:04 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a0e4b773so128276166b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 08:54:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUL3UiddZMuHBvrj8FKl5fCNa0WUBfMQiMLM06EQE3kIPPbYbd63HGsykFS/vcnMAE1Waui8L61zyzrbUVtR70afzBguhxGDq1TFpgD/w==
X-Received: by 2002:a17:906:a842:b0:a58:5ee1:db43 with SMTP id
 dx2-20020a170906a84200b00a585ee1db43mr3389515ejb.23.1714838043724; Sat, 04
 May 2024 08:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wirxPSQgRV1u7t4qS1t4ED7w7OeehdUSC-LYZXspqa49w@mail.gmail.com>
In-Reply-To: <CAHk-=wirxPSQgRV1u7t4qS1t4ED7w7OeehdUSC-LYZXspqa49w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 May 2024 08:53:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrSSNYVzTHNFDNGag_xcKuv=RaQUX8+n29kkic39DRuQ@mail.gmail.com>
Message-ID: <CAHk-=whrSSNYVzTHNFDNGag_xcKuv=RaQUX8+n29kkic39DRuQ@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org, axboe@kernel.dk, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 May 2024 at 08:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And maybe it's even *only* dma-buf that does that fget() in its
> ->poll() function. Even *then* it's not a dma-buf.c bug.

They all do in the sense that they do

  poll_wait
    -> __pollwait
     -> get_file (*boom*)

but the boom is very small because the poll_wait() will be undone by
poll_freewait(), and normally poll/select has held the file count
elevated.

Except for epoll. Which leaves those pollwait entries around until
it's done - but again will be held up on the ep->mtx before it does
so.

So everybody does some f_count games, but possibly dma-buf is the only
one that ends up expecting to hold on to the f_count for longer
periods.

             Linus

