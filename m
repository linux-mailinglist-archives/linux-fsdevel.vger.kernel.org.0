Return-Path: <linux-fsdevel+bounces-13131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70D86B8EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 21:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C1C3B245B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 20:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6155E099;
	Wed, 28 Feb 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PVVLEv1h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A42E3F7
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151492; cv=none; b=VVZYmn7fpgnCWPgWS6UOdcZEKt+uOvMc3dFFE76ofTeAHcmJVkZjQtwm7ZUooY3NqfduPUfC1YTq3tmkmaLth7S5HYuPz3l1jbH4iOjLH4ZKN0PzYjF3+7XwK7PBnu6Vc2XwZgD0m4es4i/+CTPHwL+4mz7DL4e5LzufwWU8JCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151492; c=relaxed/simple;
	bh=wIjorjf+a8nS35tbvS49i7dM5OoxSWe+N9nQjVgKErU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izMCmsEFa6Q8rKY5OutU5YeqKO26Uq8Sy+HICCnwQYxF1QUgQfUrzz7SIixVDyYXxbG8iRTLf6Trmpte8gscxPAtv3avXwwqYgqxjX+9By85a7zFrydk6RvWGeNxr9lwl/CUjc7nNt+eu4b4xnPaIY5JsPpozg/ZmS2DOVPvcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PVVLEv1h; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso248365866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 12:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709151488; x=1709756288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uASiwX56a9f95T/b0Ft7B7QcrUQnh9efeMVdOev27G8=;
        b=PVVLEv1hMgXDIU511o62dpd6PSd4JDWOKfLTbJUaCikGZjmL0CPfojtIX8+l21bwLU
         Blp8fDTlUhf7/wX5+tosZUD0Z6WyGNpT8nd1Y5JcpV+1i8467L/7hcsGbh77Mql3pESZ
         TXyTgewoTlWbpHXRiRtKpsoz55TFmZ2BzCSRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709151488; x=1709756288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uASiwX56a9f95T/b0Ft7B7QcrUQnh9efeMVdOev27G8=;
        b=hz/WrgKsBrT2e66spot4GMORabgKza0+faQQ8N5BPnczrZe/1/tUtyqCKzeiEmR5IT
         NUq+b7dwaPwYCNRJgoqVtbmHmA6r+dB1PIUDbEXuhhFAtIBZ7FR0Lsk4nwt+nNoe7ADS
         OJu2lXznAxqBtEmJw9c7N6j1JvZ1EGmvOPXmBFBB4rXMOfcBmCOFgBen52+eHxId2H5K
         CfsjyEdiGN+fwt/7usHX6Sme6A+gmTP3s9+JeiD25gucA8gLdf2FJOPLwu4V5cf1oTDI
         HGPKW+paOOlLoRfbC/PhdgOvBxjdbIEX2N3J+14+Itn/1T4F5p1cn45CpNi8IIbwNzp/
         IdDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQquRe6Im2pI53ib7gEfkreXgJOmh6HJccowhAAFge2t9Kumnv9Qlv0x3wBhJAnl+BsvPms1mGT286k84vzXJG27BXkqsujDTj9u8eGg==
X-Gm-Message-State: AOJu0YzB0uDtCGFu+6jw7lh1nqvNBl3tj07de+b3CR/nZEYDyCb4861K
	IjKyCxMmkv+cpwljtwUku2+XWFjpoVIQhYti7D/hSD0eXL+HWMS50r1BE9bF1NUi12xf+eU7Tlg
	sDLG6LA==
X-Google-Smtp-Source: AGHT+IEirOIZpZt9wjMZgkmbNLEj1SwYheU5l8hTmeZyZt6soixZO09MRl8bfGhMN7wBxxZdf5Qwiw==
X-Received: by 2002:a17:906:fb97:b0:a44:144e:3463 with SMTP id lr23-20020a170906fb9700b00a44144e3463mr427918ejb.7.1709151488326;
        Wed, 28 Feb 2024 12:18:08 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906c08300b00a3d1c0a3d5dsm2193842ejz.63.2024.02.28.12.18.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 12:18:07 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso248352966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 12:18:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3swFTd6GLEnOY+1eTi2cbLVZYg+UBDPb3SrNYe7Zn/6EPa6y53cvSZBc2sGxC8TrTgGZuoAOIjUb4A/OEuB7CAnmaOVbjtNa7yiTv7g==
X-Received: by 2002:a17:906:1b03:b0:a3f:cd6b:80fd with SMTP id
 o3-20020a1709061b0300b00a3fcd6b80fdmr266036ejg.7.1709151487098; Wed, 28 Feb
 2024 12:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area> <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com>
 <4uiwkuqkx3lt7cbqlqchhxjq4pxxb3kdt6foblkkhxxpohlolb@iqhjdbz2oy22>
 <CAHk-=wiMf=W68wKXXnONVc9U+W7mfuhuHMHcowoZwh0b6SXPNg@mail.gmail.com> <amsqvy3aq5mzyk7esf5mzzgdjl32gosq5fgphjv5qzp6r25dke@sadcguvzo26m>
In-Reply-To: <amsqvy3aq5mzyk7esf5mzzgdjl32gosq5fgphjv5qzp6r25dke@sadcguvzo26m>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2024 12:17:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgZAhEAK=POkKaUJP6_g4VUMUaiTM+PPH5jELy-JAyo8g@mail.gmail.com>
Message-ID: <CAHk-=wgZAhEAK=POkKaUJP6_g4VUMUaiTM+PPH5jELy-JAyo8g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 11:29, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> The more concerning sitution to me would be if breaking write atomicity
> means that we end up with data in the file that doesn't correspond to an
> total ordering of writes; e.g. part of write a, then write b, then the
> rest of write a overlaying part of write b.
>
> Maybe that can't happen as long as writes are always happening in
> ascending folio order?

So that was what my suggestion about just overlapping one lock at a
time was about - we always do writes in ascending order, and
contiguously (even if the data source obviously isn't necessarily some
contiguous thing).

And I think that's actually fundamental and not something we're likely
to get out of. If you do non-contiguous writes, you'll always treat
them as separate things.

Then just the "lock the next folio before unlocking the previous one"
would already give some relevant guarantees, in that at least you
wouldn't get overlapping writes where the write data would be mixed
up.

So you'd get *some* ordering, and while I wouldn't call it "total
ordering" (and I think with readers not taking locks you can't get
that anyway because readers will *always* see partial writes), I think
it's much better than some re-write model.

However, the "lock consecutive pages as you go along" does still have
the issue of "you have to be able to take a page fault in the middle".

And right now that actually depends on us always dropping the page
lock in between iterations.

This issue is solvable - if you get a partial read while you hold a
page lock, you can always just see "are the pages I hold locks on not
up-to-date?" And decide to do the read yourself (and mark them
up-to-date). We don't do that right now because it's simpler not to,
but it's not conceptually a huge problem.

It *is* a practical problem, though.

For example, in generic_perform_write(), we've left page locking on
writes to the filesystems (ie it's done by
"->write_begin/->write_end"), so I think in reality that "don't
release the lock on folio N until after you've taken the lock on folio
N+1" isn't actually wonderful. It has some really nasty practical
issues.

And yes, those practical issues are because of historical mistakes
(some of them very much by yours truly). Having one single "page lock"
was probably one of those historical mistakes. If we use a different
bit for serializing page writers, the above problem would go away as
an issue.

ANYWAY.

At least with the current setup we literally depend on that "one page
at a time" behavior right now, and even XFS - which takes the inode
lock shared for reading - does *not* do it for reading a page during a
page fault for all these reasons.

XFS uses iomap_write_iter() instead of generic_perform_write(), but
the solution there is exactly the same, and the issue is fairly
fundamental (unless you want to always read in pages that you are
going to overwrite first).

This is also one of the (many) reasons I think the POSIX atomicity
model is complete garbage. I think the whole "reads are atomic with
respect to writes" is a feel-good bedtime story. It's simplistic, and
it's just not *real*, because it's basically not compatible with mmap.

So the whole POSIX atomicity story comes from a historical
implementation background and ignores mmap.

Fine, people can live in that kind of "read and write without DIO is
special" fairy tale and think that paper standards are more important
than sane semantics. But I just am not a fan of that.

So I am personally perfectly happy to say "POSIX atomicity is a stupid
paper standard that has no relevance for reality". The read side
*cannot* be atomic wrt the write side.

But at the same time, I obviously then care a _lot_ about actual
existing loads. I may not worry about some POSIX atomicity guarantees,
but I *do* worry about real loads.

And I don't think real loads actually care about concurrent
overlapping writes at all, but the "I don't think" may be another
wishful feel-good bedtime story that isn't based on reality ;)

              Linus

