Return-Path: <linux-fsdevel+bounces-12673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3F18626BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 19:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA1C1C21011
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE64D5B0;
	Sat, 24 Feb 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Din/4q/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2271B4CE05
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708798836; cv=none; b=JHwRrphGsloWUjzSfMn+IaYx4zijBxnu//8gfJYMCWMz2OzzqZwn270tJJYy1Q0RyBQoRbGbeN4+TKWU6AJaZYemGH8+zvai2GleswKwM/liqxlmg8meKZvsuxGM7HT778KZbig337Kb1AEFymSIehK0UxZvWKNt88snCG4aCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708798836; c=relaxed/simple;
	bh=daqlDQREQputqykkVYjF3ZpUbGhkQqmJQbSypjZ+ZG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sh9Gg5LQ0X/ahgZgUxlwOkXQQHYGxa/ZDgrveLTTXBT5SrQUxpbGs8k+b6+e7l5jpiyPKLtzETe4RQ1Z2Zf3QeUsCubnjLmXnwNMOQlMBOlXCd96YI5QQJLypmZXKbgNdJiJyKZdqR4MGuvW4FC7QmamTu3Shr6Yg0TNzg0Rr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Din/4q/j; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3e706f50beso239209066b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 10:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708798832; x=1709403632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N3+t/XZyLVyYIW4d3qvzXnQMDuQBRtLknCNAnrQ0BaQ=;
        b=Din/4q/ji9chWOLp91r9urFMS0QiI2ZW+rm/qOx7VI25y5LftDpD1twdRR6rDFzy+8
         NCkOMISy5VOpKExUyiN/DYXPoYrcDvpHW9xhXI1aveSX3W4CYxEkXUFmaR/y93Cha1Rc
         2pX5VR+YWsZherdvMBAdobrGNbUPjvGjz0DxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708798832; x=1709403632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3+t/XZyLVyYIW4d3qvzXnQMDuQBRtLknCNAnrQ0BaQ=;
        b=fOBYZ43Ih/uGN8JOZ4jc9y8Wg3mxMmybIP4fOkXlqnNLqHGAuxifVwe8JtkXHp2JgK
         EUAxZoB0gCbFARzjcmYHLGO0SMWrmoTGixy0GbS0YhL8qvX770fz6Jt4ajNwh6TTbrR7
         Xo2DbwyuT+LKjLkj0smDEXsTg7r/ZnqH7u+sw/T0Os2zpxTQ4YbXz1Dv0ou8HYfvL7Jr
         2anbuDlReIoyzqrQyqIwybUdoezwpjNNq02drPChgs2x3rWnw6+OCkUYCgpf1uQrbSJG
         X37IlWeXz6MKOArKkIKyu3ym1Wo6DncuU6Eg1AUATvLFQFC6zNmO0+kk/4YD12JsLyg9
         otxw==
X-Forwarded-Encrypted: i=1; AJvYcCV7TVZ3YOrK7hCmxM60pjNDioI1GippBrM+wlrqsKnFD5Swiop2qZHQrf5xEMcldW3gJG2y8mUpllhExVUf110Q2LNB2nca/mjkBWluaA==
X-Gm-Message-State: AOJu0YywxjurGnhg5qaRXVDEspj0aJlYmjmCb7hvi09KV3xSrPrei+lk
	iRk3eljueqhDTI4ap0aof1M29YWfGWlqYCC0qUaHKahJRlGWwPeFZeGtWgWXZ9RcQxJrtB8OiTa
	vvFI=
X-Google-Smtp-Source: AGHT+IH39df+PXRcDLjGhzao6bxwA90Y8a94BHQ48cd9cz4BxPtqOsoI0ZudpGbKBvJDmZi57NsFlg==
X-Received: by 2002:a17:906:1ece:b0:a3e:a3c3:9658 with SMTP id m14-20020a1709061ece00b00a3ea3c39658mr1958423ejj.22.1708798832241;
        Sat, 24 Feb 2024 10:20:32 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id ju21-20020a170906e91500b00a3d5d8ff745sm794720ejb.144.2024.02.24.10.20.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 10:20:31 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e706f50beso239206666b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 10:20:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpm+mqdupiyYCStUVIX3INojLtwYRDLHx+Uh7JNhiu6ESU51Q7U3aWV+yeM/jtNi8ECHTqfLuz97sNexDi6aYdfrBIQC1+3detjq/+ag==
X-Received: by 2002:a17:906:565a:b0:a3e:6a25:2603 with SMTP id
 v26-20020a170906565a00b00a3e6a252603mr1930750ejr.33.1708798830732; Sat, 24
 Feb 2024 10:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
In-Reply-To: <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Feb 2024 10:20:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0_eGczsoTJska24Lf9Sk6VXUGrfHymcDZF_Q5ExQdxQ@mail.gmail.com>
Message-ID: <CAHk-=wj0_eGczsoTJska24Lf9Sk6VXUGrfHymcDZF_Q5ExQdxQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Feb 2024 at 09:31, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And (one) important part here is "nobody sane does that".  So
> benchmarking this is a bit crazy. The code is literally meant for bad
> actors, and what you are benchmarking is the kernel telling you "don't
> do that then".

Side note: one reason why the big hammer approach of "don't do that"
has worked so well is that the few loads that *do* want to do this and
have a valid reason to write large amounts of data in one go are
generally trivially translated to O_DIRECT.

For example, if you actually do things like write disk images etc,
O_DIRECT is lovely and easy - even trivial - to use. You don't even
have to write code for it, you can (and people do) just use 'dd' with
'oflag=direct'. So even trivial shell scripting has access to the
"don't do that then" flag.

In other words, I really think that Luis' benchmark triggers that
kernel "you are doing something actively wrong and stupid" logic. It's
not the kernel trying to optimize writeback. It's the kernel trying to
protect others from stupid loads.

Now, I'm also not saying that you should benchmark this with our
"vm_dirty_bytes" logic disabled. That may indeed help performance on
that benchmark, but you'll just hit other problem spots instead. Once
you fill up lots of memory, other problems become really big and
nasty, so you would then need *other* fixes for those issues.

If somebody really cares about this kind of load, and cannot use
O_DIRECT for some reason ("I actually do want caches 99% of the
time"), I suspect the solution is to have some slightly gentler way to
say "instead of the throttling logic, I want you to start my writeouts
much more synchronously".

IOW, we could have a writer flag that still uses the page cache, but
that instead of that

                balance_dirty_pages_ratelimited(mapping);

in generic_perform_write(), it would actually synchronously *start*
the write, that might work a whole lot better for any load that still
wants to do big streaming writes, but wants to also keep the page
cache component.

                Linus

