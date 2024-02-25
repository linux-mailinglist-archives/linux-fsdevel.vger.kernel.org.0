Return-Path: <linux-fsdevel+bounces-12734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4D4862DE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 00:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4F51C20CF3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 23:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891751BC4A;
	Sun, 25 Feb 2024 23:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F5N6htCp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3D1BC36
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708904769; cv=none; b=s9Vp9h3N3GmKbySmpVp1IFrxly7o5pgmu+/Urh3uvaCxioJvE1HWrPqjmVPGxJipJ0BjkmR5gGAa10t01+qdklJFWblGYm6ScwEq64bkWU03EYPIKmV5ClgUemnLLa2ZAYvfPibatYtEnNMd7ihZ8Yt4Yyw/9cM27QyYExpfn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708904769; c=relaxed/simple;
	bh=AIUqNaM4f63lC9NITAkghKqDHcz4hjhFW9k3dkaCnMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+XsxIo6G0lSfdstKpfqCOJwIOn3RHPafaBvonJRoVynA1R9wNcwEbIU5xq6F3Njz8YpN2V68JkzzvYT4VrzDyxSktLq1GKZAYYTgUZ5qrzMjoK+x1sec4pE5e7sLsIw8qNMg89IcHNLKo8aDNTipnDmRgnLDakIhVzIK1fnh6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F5N6htCp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e6f79e83dso255064366b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 15:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708904766; x=1709509566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t8oDS6s3s30y5Ly/yXVA1Qyh4YWmD7GBpwbREpcwfoc=;
        b=F5N6htCpH1KoYPc1nyvPv6HDACjtzCuRlL6Wu8PDgQQS/iVSNHP4yL5IawITSzusBB
         re96Z5jgZRH1mexQmb5IIiyNIelsjbsxLdm+2/Yr70VSg8qgx4RXEqiQ56apQTntX6tV
         TFezSZdPWPfiGQA6jlqWb5h9iIuHoR0Y+dAY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708904766; x=1709509566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8oDS6s3s30y5Ly/yXVA1Qyh4YWmD7GBpwbREpcwfoc=;
        b=vBNrcOYozjNdz1JGyviBIQe5f02MSNt7GE0ScWBK7LxRIRk2uvdKoKjL1iN3bd4Qof
         32IavQwgzt11S2vWv7uh2noh+wE7PkUdg5ao9cTNxCgf6jyqKFTO+c93+Bwf9UM1CIyH
         vYOX4Egkb1WKNNyvVpiivSnqejLKvEkZARwl8Ezw0vRErsnzjlHUkYL7XeZytEnuT+eN
         DLj2pzhxyTa3kmumgtlL9kj7Ajzpv7JFqcfxWzCI9xFi0mKTs1KDzcM4jeIHbZUQCHj/
         XIMnUYhR9JEGgn5sTFno0AlHk0FFwMQQfD2u0CL8fxknVUVTvd3ltyTW+9eG+xHi9GKh
         CMTA==
X-Forwarded-Encrypted: i=1; AJvYcCWJLsWmj2l3JEnV5TgQxPUb2iFa5P8ZS6w/p6d6aSBPtEW0oN0Lc9eKqLRiY3ttzJ/voIZktDCNIq1/YuODbyy9cIE2gS8HhSkB+BNUYA==
X-Gm-Message-State: AOJu0Yym90ifx2dEhAv81Fccs0ojYRAcSiB9CYjeVQmN9uo4YRtBFgOu
	JIlnZwPTRH/lnMUa4I2xw/j3PArdsy46UhCOstnsRBs32BTC+vB922PS8qhcGHbSKXq/rU6zmk0
	p7b48ZA==
X-Google-Smtp-Source: AGHT+IEK0ogc+uqamLR+UZL3b7A5JaMN7p5ThU+tSyfY9DJ4URjhbhmCoKYi/r0CkIcMoEeNA4o4CQ==
X-Received: by 2002:a17:906:d287:b0:a3e:69d7:3514 with SMTP id ay7-20020a170906d28700b00a3e69d73514mr3492307ejb.26.1708904766037;
        Sun, 25 Feb 2024 15:46:06 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906304400b00a3ee2530a11sm1866763ejd.194.2024.02.25.15.46.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 15:46:05 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a293f2280c7so340728466b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 15:46:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlx0cqzBwc+tvZM1N9m/anCMO7VDpL4Pwukz9QBSUAY1PdzwuDTjX439zLlSKF0M2xt0A+wcrKU9BFQe7uGhoU3EM+EnQVRJQu3982og==
X-Received: by 2002:a17:906:6701:b0:a3f:6717:37ae with SMTP id
 a1-20020a170906670100b00a3f671737aemr3748388ejp.69.1708904764619; Sun, 25 Feb
 2024 15:46:04 -0800 (PST)
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
 <Zduto30LUEqIHg4h@casper.infradead.org>
In-Reply-To: <Zduto30LUEqIHg4h@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Feb 2024 15:45:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
Message-ID: <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 13:14, Matthew Wilcox <willy@infradead.org> wrote:
>
> Not artificial; this was a real customer with a real workload.  I don't
> know how much about it I can discuss publically, but my memory of it was a
> system writing a log with 64 byte entries, millions of entries per second.
> Occasionally the system would have to go back and look at an entry in the
> last few seconds worth of data (so it would still be in the page cache).

Honestly, that should never hit any kind of contention on the page cache.

Unless they did something else odd, that load should be entirely
serialized by the POSIX "atomic write" requirements and the
"inode_lock(inode)"  that writes take.

So it would end up literally being just one cache miss - and if you do
things across CPU's and have cachelines moving around, that inode lock
would be the bigger offender in that it is the one that would see any
contention.

Now, *that* is locking that I despise, much more than the page cache
lock.  It serializes unrelated writes to different areas, and the
direct-IO people instead said "we don't care about POSIX" and did
concurrent writes without it.

That said, I do wonder if we could take advantage of the fact that we
have the inode lock, and just make page eviction take that lock too
(possibly in shared form).

At that point, you really could just say "no need to increment the
reference count, because we can do writes knowing that the mapping
pages are stable".

Not pretty, but we could possibly at least take advantage of the
horrid other ugliness of the inode locking and POSIX rules that nobody
really wants.

              Linus

