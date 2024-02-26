Return-Path: <linux-fsdevel+bounces-12846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8713D867E17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 18:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141271F2D11E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B550612EBFA;
	Mon, 26 Feb 2024 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ItR2wiFC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1012C800
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967876; cv=none; b=kpuGsrhCw6L86XEzYOuASaqDM7HaR7Z2FhzGQRcO2BWcGp+lEKxHBzq87jLuzy4+5pbGC6WWzMa6KPE1NlfhQ+xM1+bff28tLt8cRln6vHCNHuUcjUV0sNVGSK4nEYN03DjOeaECF0NzGDHK1wVJS383DnT+DiC/zTBkIwk3LWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967876; c=relaxed/simple;
	bh=r8EBnLNTiWB1b5wyzBJTF/g42NOpy0uknOtcjVUxuKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzMsiXNa4Dxz8FaoNKRJvthD+4Q40oeRB+goalh/HI5s9gED63rduID1xpLa8aiiK+RKZx7ZFjrYEcmDEqfyIBrvaBwwMJsDWB5QV3ACy7mWjMelUP81gvrLoNAHH17Sj4NzqPp2r31Sw5d7UsDJMOvPMct2i4XHFjOQAMxeurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ItR2wiFC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so327376566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 09:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708967872; x=1709572672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tWVtevA9wXVF2B05HUcL+aeuhxeDRR1ZXitsqO3GeN0=;
        b=ItR2wiFC6Mp6kgXPboHiC9JIhk7zCGjOauki1rZAYQaBxffB24Yi7bInPgidDLU/8T
         TvegrXtPyyJmlYG1TTpu1m1bZrbzV2/uhvL9pjxw94On/bs105ZLqrzP0sjlQCoZ2GGe
         5E/bsv6kMthOatyxAn8IrxCe0lAYY2EUjEsE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967872; x=1709572672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWVtevA9wXVF2B05HUcL+aeuhxeDRR1ZXitsqO3GeN0=;
        b=tldZxDcCXshY51OkXDZ0QPLuIbvlTG1O5vIlSMEWhTMtSxJ/OZy/6dVDcruRyzKhaz
         u2rQ7YJu5PL0CrzPMpQd1h1tbg/uttO8BAjjXUYELFLPi9F9wmqYqJpIESowh9hTQrX9
         l/FlJU1BVptfrlViWqFXZMY4AyFUx7H98JpWbB4T9HaMH8Pge/mLYR1r60oPhIafFeH5
         bqXhR4Q8Z7YsI97P2DerakOAhVhsxbswrWyvKX/DqpFSXXi4LXV2KRpjRGYZO2EjjigK
         +K6Ac8wKImGF3VGQWoTSHojkp8Y3/H6TKH7Ts6KXTWCljsuRfo/Jmh/aV1KJzbUeG21w
         a/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOH0QGTPkaVJe78ZzAHremfhIAGr25Qd2UbVvQZCI2QBG3dGArBpcMXWaVicDHxXQKqYKAhLLObwSs4l3H43U3VArqVVfdr7VqOZFaHg==
X-Gm-Message-State: AOJu0Yzrem8vnA0WBnNVyVYQQ0alblYP7JVJyb/MDtcjH7VSyWztzPVP
	nUR5xdRbo+IfUbqdULbl8taeaWVWte4/Vt8GMFCz67ZbHGGTGLnTnCV9K+5KvbyUc8GbFCQZMrl
	/gBodbA==
X-Google-Smtp-Source: AGHT+IEvATD4zvSgG3WdUth2a5hEOvh+NOpyk7qiY/Qb9oCTl2womrNncXOgcti0gSzFnV7/OrELSw==
X-Received: by 2002:a17:906:318d:b0:a40:4711:da21 with SMTP id 13-20020a170906318d00b00a404711da21mr4662009ejy.37.1708967871972;
        Mon, 26 Feb 2024 09:17:51 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id gs8-20020a170906f18800b00a3f8f0ab293sm2632357ejb.147.2024.02.26.09.17.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:17:51 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so327372166b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 09:17:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1vRn7YPYcA4sZWB7mY6KklipVzxZfIiyEkhpu4PJ74HC551iQeGuvhfWbVKV094IhYCh7zxTRjcIIry9xtfGkEapUFogcGSbGDVurZQ==
X-Received: by 2002:a17:906:c350:b0:a43:82d0:38f4 with SMTP id
 ci16-20020a170906c35000b00a4382d038f4mr1318140ejb.11.1708967870938; Mon, 26
 Feb 2024 09:17:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org> <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org> <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com> <Zdv8dujdOg0dD53k@duke.home>
In-Reply-To: <Zdv8dujdOg0dD53k@duke.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Feb 2024 09:17:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
Message-ID: <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Al Viro <viro@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 18:49, Al Viro <viro@kernel.org> wrote:
>
> Uh?  __generic_file_write_iter() doesn't take inode lock, but
> generic_file_write_iter() does.

Yes, as I replied to Kent later, I mis-remembered the details
(together with a too-quick grep). It's the reading side that just
doesn't care, and which causes us to not actually give the POSIX
guarantees anyway.

>  O_APPEND handling aside, there's
> also file_remove_privs() in there and it does need that lock.

Fair enough, but that's such a rare special case that it really
doesn't merit the lock on every write.

What at least the ext4 the DIO code does is something like "look at
the write position and the inode size, and decide optimistically
whether to take the lock shared or not". Then it re-checks it after
potentially taking it for a read (in case the inode size has changed),
and might decide to go for a write lock after all..

And I think we could fairly trivially do something similar on the
regular write side. Yes, it needs to check SUID/SGID bits in addition
to the inode size change, I guess (I don't think the ext4 dio code
does, but my quick grepping might once again be incomplete).

Anyway, DaveC is obviously also right that for the "actually need to
do writeback" case, our writeback is currently intentionally
throttled, which is why the benchmark by Luis shows that "almost two
orders of magnitude" slowdown with buffered writeback. That's probably
mainly an effect of having a backing store with no delays, but still..

However, the reason I dislike our write-side locking is that it
actually serializes even the entirely cached case.

Now, writing concurrently to the same inode is obviously strange, but
it's a common thing for databases. And while all the *serious* ones
use DIO, I think the buffered case really should do better.

Willy - tangential side note: I looked closer at the issue that you
reported (indirectly) with the small reads during heavy write
activity.

Our _reading_ side is very optimized and has none of the write-side
oddities that I can see, and we just have

  filemap_read ->
    filemap_get_pages ->
        filemap_get_read_batch ->
          folio_try_get_rcu()

and there is no page locking or other locking involved (assuming the
page is cached and marked uptodate etc, of course).

So afaik, it really is just that *one* atomic access (and the matching
page ref decrement afterwards).

We could easily do all of this without getting any ref to the page at
all if we did the page cache release with RCU (and the user copy with
"copy_to_user_atomic()").  Honestly, anything else looks like a
complete disaster. For tiny reads, a temporary buffer sounds ok, but
really *only* for tiny reads where we could have that buffer on the
stack.

Are tiny reads (handwaving: 100 bytes or less) really worth optimizing
for to that degree?

In contrast, the RCU-delaying of the page cache might be a good idea
in general. We've had other situations where that would have been
nice. The main worry would be low-memory situations, I suspect.

The "tiny read" optimization smells like a benchmark thing to me. Even
with the cacheline possibly bouncing, the system call overhead for
tiny reads (particularly with all the mitigations) should be orders of
magnitude higher than two atomic accesses.

           Linus

