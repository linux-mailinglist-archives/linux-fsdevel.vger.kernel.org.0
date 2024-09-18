Return-Path: <linux-fsdevel+bounces-29662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBE297BE12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A621C20F64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC011BBBE0;
	Wed, 18 Sep 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YOZ3EmUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC81BB6B7
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670446; cv=none; b=bDUC+c79rQSaZEkx93hiJeMvfumr1SQlFbrqdfPuaBArc4KInZWN9V3QR7lbb6WyIwSUPUvSaUYGOzGZVauJCI0SPAB80/BsXeYq/TdGNnqVzotWiO+rCwer3TBwHREAxYwjgNkUfe45ylINNeUudb6n6noZycToWXpP1BjP97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670446; c=relaxed/simple;
	bh=mT3ohME7te8T2As9CrdpUmPIESVaDC3Cl9Dhcw5IwvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyDCdMkdWUepV6vOeuB8m4+VL8vp3z3UGJ0jT14Yx1LtGXJZKxhp/JjSkir7s7FdhqfS3Pt6AaAhCG5HQnxKKDGvRFaoGXFcUEQSzHXGcDH7kKS09NKYoNO2ftf19aDiScsyo+yMOmmHxrNEWYgDvfcpKcGaRIjMDPi7UlxLLqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YOZ3EmUA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso153795666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726670442; x=1727275242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2t1ItWJ3ig5qNarueJWrYx/kj01x5BbGfjJ8rjmQF4o=;
        b=YOZ3EmUAHuwfXxwzhpRVXt2qPmai1CjLEGASDLsCO8K+KIcS7JQaP5Mx0zNEZuHhiA
         qsFq1rsdaiG0iL4tC+4kYNnpJGlSXghjVSHtpwl8OCl0W3n6kJUNUosn/pX+oHoN5vXa
         CVFxrci325pvbFahhkSOvbExYZkVq35+seyz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726670442; x=1727275242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2t1ItWJ3ig5qNarueJWrYx/kj01x5BbGfjJ8rjmQF4o=;
        b=kz5jm4t4TWZGRFnGXzgTE2StqLGA7NOiCJ5Nzvd8QJw/1pIum6AgLdk/te/oU/tdEf
         nWgBVRrKwp/Yhwvk3MtCkCDgGlJvqH5EbeStBOic3AOgZaJ03Zi6f4uj9Im6vGlsDUrp
         nVUoYNSkhN4F/Z2Gc3JxnphdGvTvHQgShBh1NkxV3EqTncWodyPnIN3rpjvSDzgryFS8
         wOtbi87k14FY7PzD8PuQoobZ1kQxu2y8MEZdMViqofiivUnlmF8TvBh5KeWhnCRpiulq
         CVfNnzZEP61PpfQHhqq1Xwc9g7uhZ8Kp89YTad8uvPkCX00psZ+MUzg3XebgLQ97doc0
         3z2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZKH4ka3oIlWqY1twsIxtdfIH/wpJWO1lHRb3n6h623XgFRsUiHYmjvRfmE30l+hJT4h+/r7BkkA/jSe/L@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+WE81vLffSX387TKUUKnDe9QkT59LXxeKWB2/idR7DJ7oqQR
	jEjb9zH9b5xi6XB9945t2RpoImnBWe8Ug+iS07v92ih9YjvUIqMqHkmpKj/tMY2XsvmL3tsXCsU
	qj4nOjA==
X-Google-Smtp-Source: AGHT+IHAF220tcZ/123NeNMcyYXBjdR0QpSHm+LMPvuVvVRWp5jrudsY6zJqzy/oQ04PzyJrJVZEOQ==
X-Received: by 2002:a17:906:6a19:b0:a8d:ee9:3888 with SMTP id a640c23a62f3a-a8ffae3b788mr2551635366b.32.1726670442160;
        Wed, 18 Sep 2024 07:40:42 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061330c73sm593038866b.208.2024.09.18.07.40.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 07:40:23 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso1810981a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 07:40:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8GikJ4eHVYk109Ive1lHi9cyWianndV8sDNyd+Iqucdq3jt6hX55SP9fveGfkjuuQB6B9ebW+nMcm6V1L@vger.kernel.org
X-Received: by 2002:a05:6402:2189:b0:5c4:178a:7162 with SMTP id
 4fb4d7f45d1cf-5c4178a7270mr24593373a12.19.1726670413894; Wed, 18 Sep 2024
 07:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zud1EhTnoWIRFPa/@dread.disaster.area> <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com> <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com> <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk> <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org> <CAHk-=wjix8S7_049hd=+9NjiYr90TnT0LLt-HiYvwf6XMPQq6Q@mail.gmail.com>
 <Zurfz7CNeyxGrfRr@casper.infradead.org>
In-Reply-To: <Zurfz7CNeyxGrfRr@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Sep 2024 16:39:56 +0200
X-Gmail-Original-Message-ID: <CAHk-=whNqXvQywo305oixS-xkofRicUD-D+Nh-mLZ6cc-N3P5w@mail.gmail.com>
Message-ID: <CAHk-=whNqXvQywo305oixS-xkofRicUD-D+Nh-mLZ6cc-N3P5w@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 16:12, Matthew Wilcox <willy@infradead.org> wrote:
>
>
> That's actually OK.  The first time around the loop, we haven't walked the
> tree, so we start from the top as you'd expect.  The only other reason to
> go around the loop again is that memory allocation failed for a node, and
> in that case we call xas_nomem() and that (effectively) calls xas_reset().

Well, that's quite subtle and undocumented. But yes, I see the
(open-coded) xas_reset() in xas_nomem().

So yes, in practice it seems to be only the xas_split_alloc() path in
there that can have this problem, but maybe this should at the very
least be very documented.

The fact that this bug was fixed basically entirely by mistake does
say "this is much too subtle".

Of course, the fact that an xas_reset() not only resets the walk, but
also clears any pending errors (because it's all the same "xa_node"
thing), doesn't make things more obvious. Because right now you
*could* treat errors as "cumulative", but if a xas_split_alloc() does
an xas_reset() on success, that means that it's actually a big
conceptual change and you can't do the "cumulative" thing any more.

End result: it would probably make sense to change "cas_split_alloc()"
to explicitly *not* have that "check xas_error() afterwards as if it
could be cumulative", and instead make it very clearly have no history
and change the semantics to

 (a) return the error - instead of having people have to check for
errors separately afterwards

 (b) do the xas_reset() in the success path

so that it explicitly does *not* work for accumulating previous errors
(which presumably was never really the intent of the interface, but
people certainly _could_ use it that way).

             Linus

