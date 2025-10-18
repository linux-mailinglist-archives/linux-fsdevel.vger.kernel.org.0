Return-Path: <linux-fsdevel+bounces-64582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E978BED700
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D5F19A453F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 17:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1EB253F12;
	Sat, 18 Oct 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ChBpaXwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735251D7999
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810232; cv=none; b=DNzZYwa1umEIJ1BvJp6HkkRg9ne0KRpOz4kcdFTbow6JUnbcQh9HckeCgMu8javr59Ef3VRZ1pQ2c/uj3rjcajhVvXj+zc+/oWF6wb3R0yR1595xSnB572EFeyHO+vMJJB/whYzNZBr9G7kOTL9cBsVSGSoyQOgp3viKjGKqhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810232; c=relaxed/simple;
	bh=+0NDnqm96mv6VJBmnJDP9J8W2eqsuwjSNKSIB/4f6gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVV7idYL3hotcKzdY7yAg0f3oUreFYIjGfscGpe/s/9c31CVyFZe4acJO1FZCTsR3Pvi59ipm9z2WXeSLdsTfqjId+6YHmPeYC41fj1FGavwVIMNpm2td0uyY82/ncY1lz3yh+xJjvf6iom1r17R5BuySNA9xDetjQL6Sh+h60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ChBpaXwX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso5261336a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760810227; x=1761415027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lrPVFS9Dd045lBN8JzZ3YytOba9ttGQFMrMdfscWZIk=;
        b=ChBpaXwXL79aJn3v+TkM978CDRiGZVFtGpu4qpnAuPfN9IeWF3h6iZws2lkuqSbRKD
         /5GQkdYvkoHn361RvvrV9q+qVrgAqOpDjcfF9OFF+AmwylOOLwRIG1aOZFhB66+hdhec
         q9+QojN5phIOH3gPnq8GXOpOQtaSZot1iyFeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760810227; x=1761415027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrPVFS9Dd045lBN8JzZ3YytOba9ttGQFMrMdfscWZIk=;
        b=gMiUQpba9HEdcX0Bad+7adJ2zhfpmeS4su7e2co9UkvN1JGTVc8m5qCJE33taP7lVj
         CV1S9DsIT7DwEzairVdLBIPmdKInLSN5XlIm96+lcAYaCxLnhjqsQarWj8y7y79FyM/H
         06XFBRLAa0/Nbt8NtzhQS6Ed5H2N1f+dqUXzCbsShhj+DD17Nqy92Zci+4DHQqFOlk7q
         XmQmvJ++3CrPsVgKn2svYOYcUA70jPcjev3thhbmIZU+EJLnviAbdBs8JpztrbCRfNf4
         ob4VtYkvo71pSahLNdwntNs38u7s2whHxbFso93sWE/nXVSy/OTqqZvzvpQ4E30p4IUi
         FB4g==
X-Forwarded-Encrypted: i=1; AJvYcCVIjj8wAJARmMnUyyT6mvcHzmtBmxzwG8OynfFeO0rjGHT7VuICR7XKwbwzc4PTRWGPX7Ggm2sjdiurZe22@vger.kernel.org
X-Gm-Message-State: AOJu0YwHG87N5mUdzRnvY+r5WLae+arYuJsU4LZecr/hs7WnPcmNmrDd
	P6NmJTMdbKz2XYD2ptV5UTqxGeUTPtR8b9LjU8wVHGqaxe3fs1DyU6WfrKBGUAB0aaqLAvmB+lr
	YFJIF/10=
X-Gm-Gg: ASbGnct0gsVCGmlL1ENy/iZnNxDj8VkHZJI+U7FNVqLaausahOmP52kdZHM6tojfhCe
	NeAi8KGOaOGDKF9Kaq7bM7UEsaGN+O5HUA2YXPDDgp3OzzTR1VUcrbQUNKcYwTP8hoi+ofmXM12
	Jyk1th8jcS7FzlideOkkfhLOwKvj5QyQ5w9bNdNdMA8V9PLEzkzZ/9YLe6Vr70bSYVrXQzdJ7ar
	kv9le1Kp+cPqUnQ3qvwOeJJRGM5P8vFKqON2y7oIsUa9tWRd6IdBp8dyksXRVa9G7tO/G7ipuWS
	AeZY10N4i9kDQOmykWBSqmnkGNE96aYOky+wxFWAyOuqHRifRLqtKdiZwIoxrIn3Nfol8jJDIFL
	E5MEvnhpmJ0xfXedBmVy70U0qSjFOwUAAGBiO14WoMMASViYFA/Mau5Y6LAu05Dkj6gncw34wcn
	oMUygzzBW0vLEKHJMQCNJEGkCoYoD4CVVSqW7LVWlGcXOjzFyMSn8SryPb3MN+
X-Google-Smtp-Source: AGHT+IFKbKdUA0mSr5E2/5h7DpoMZxRMg2dxdzuFrh+ApQ7KM1OQ2q+oRKIuoQqwn7QM2hkMiQrlvg==
X-Received: by 2002:a05:6402:40c5:b0:637:e4d1:af00 with SMTP id 4fb4d7f45d1cf-63c1f677665mr7035226a12.10.1760810227343;
        Sat, 18 Oct 2025 10:57:07 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4869746asm2515715a12.0.2025.10.18.10.57.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 10:57:06 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c31c20b64so2686110a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 10:57:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSpGip7M2afIQ3x8vJ7NMT4b2SJJ9S/okLEqsfTBN2L34RKsrZt+MwPJjrSsKoBPRLUI4tpKofm6shFObg@vger.kernel.org
X-Received: by 2002:a05:6402:524c:b0:639:1ee3:4e83 with SMTP id
 4fb4d7f45d1cf-63c1f64f094mr7116093a12.8.1760810225989; Sat, 18 Oct 2025
 10:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name>
In-Reply-To: <20251017141536.577466-1-kirill@shutemov.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 Oct 2025 07:56:48 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgijo0ThKoYZeypuZb2YHCL_3vdyzjALnONdQoubRmN3A@mail.gmail.com>
X-Gm-Features: AS18NWBhMhgs4_s15aKV87bAatc3jK6By6Ho8BjAuIc9dhonJUNbnDV1fLJr0qc
Message-ID: <CAHk-=wgijo0ThKoYZeypuZb2YHCL_3vdyzjALnONdQoubRmN3A@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 04:15, Kiryl Shutsemau <kirill@shutemov.name> wrote:
>
> To address this issue, introduce i_pages_delete_seqcnt, which increments
> each time a folio is deleted from the page cache and implement a modified
> page cache lookup protocol for short reads:

So this patch looks good to me, but to avoid the stack size warnings,
let's just make FAST_READ_BUF_SIZE be 768 bytes or something like
that, not the full 1k.

It really shouldn't make much of a difference, and we do have that
stack size limit check for a reason.

And obviously

> --- a/fs/inode.c
> +++ b/fs/inode.c
> +       seqcount_spinlock_init(&mapping->i_pages_delete_seqcnt,
> +                              &mapping->i_pages->xa_lock);

will need to use '&mapping->i_pages.xa_lock', since mapping->i_pages
is the embedded xarray, not a pointer to it.

But I do think the patch looks quite good.

               Linus

