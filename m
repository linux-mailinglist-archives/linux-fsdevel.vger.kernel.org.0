Return-Path: <linux-fsdevel+bounces-12743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C7D866844
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 03:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0710FB20CDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 02:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF41EED4;
	Mon, 26 Feb 2024 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sw1u7eqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBA817
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708914889; cv=none; b=SZmPdDEp+tyD9HIa+ZuGypIBtf2MxHspS96cW0gP/21PccEK8fwNl86uV3HfKc6yOK3huswPSB273vvxJ0dvAQQau0mMY10pFjxGQdG5R4Mj+VTMUdbp18FIqTODZa80x2abdloIwtCrQj83/omu8R0nEGNlju55FDNk9EZGQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708914889; c=relaxed/simple;
	bh=vMtEpnklzu+sHY1WYzRE932e4cLQ2NSmSa7KYZmvp4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPSGtS7WCk5uEf3AqHIbgP9wi0qvlJSV4fSXvc+k9KOw+6xkQ/ggoS94T3yrnvZBIpXdBHhBL+HFqMBSVzeGSqLZmMNwtsJmwBKFACWFM+sWY9sgI+iQxSc/X/42xE1P81pkcKpHsVBWaC9xNYfuyOrsOk0jY8QWcGjCi9LMAfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sw1u7eqj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso398496766b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 18:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708914885; x=1709519685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OqNRWTy0P8CmYFL5DyLB1MrNOJdjhuOOEAc3K/VmsrE=;
        b=Sw1u7eqjGDH1FYmxhPv0wodavIt8G3dgIxemH9lsJWvKUkeClODk23dBY+YHppHFo5
         bPSqbTDJkcJxRirO4yruArsuZJQy6MtY6JsQZPkR5unuhWJpYULtpRmxyK2QJoqlQVUi
         tdihIqORZkMniuSsUKZ5t5hkCHfBQ6D6a4L1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708914885; x=1709519685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqNRWTy0P8CmYFL5DyLB1MrNOJdjhuOOEAc3K/VmsrE=;
        b=KaWe54Pxg8WohW4803EyZhDL/9XrFwpyAYKbLPkfLIkhqy9I+i58NTvy58W6wtPFpA
         fTTJzQVeiF8c2lkNnr4TNlU9hDnyQl/29M8BYgR4Gp/RwgwXi6pu2hdXlmouanjgy94L
         n7g4HU0SYU3gdPbvqFHmT8Pmi6Gf4JD1ul5toVTco0Y86ifr3vtGT0fGVJHZnlVys3ok
         aVaadUKL6Srecbu2m5b3Y+q/OtkXruPwmLnBWMPzjIIs/DE0HbiubZwl7zMr1+irRihT
         bTgYF42pY671AcwBtVSzPgytpJCAdvGzZX4q3m6ox/SHe3binhrXFvaMydLwjjvfcUB3
         iwog==
X-Forwarded-Encrypted: i=1; AJvYcCU6bieek3xsd/Mm+kKTD4EgqH3SlDKAPQU0mnKPxHjovbjnuCrda5m5QCeM00i75bJVvMBY66vP/aGPl1xc8V+NAE/XS2XkpwAXuou5lw==
X-Gm-Message-State: AOJu0Yz48mdHUMBppGhrES585KRTTni8PXo7sCNtsdbLpf0OTjcxMJr1
	MWfesbeu0dSlJwO6kG6keLU1r08cfe6BHU+s3d1GXQ42blarH8qRVCXyAkxaTP3m2Z7J08xqhnO
	hQcoqFg==
X-Google-Smtp-Source: AGHT+IFyXsHtEW2nL5S3HFeJenhZ/XozC2YkZc0/3lWh4YvuCHPqNJdm0g0F5UVSNXyAF3sndcWGQg==
X-Received: by 2002:a17:906:4685:b0:a43:5ec9:cd48 with SMTP id a5-20020a170906468500b00a435ec9cd48mr633102ejr.18.1708914885632;
        Sun, 25 Feb 2024 18:34:45 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id vh6-20020a170907d38600b00a42f7e08e9asm1772192ejc.222.2024.02.25.18.34.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 18:34:44 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so1382153a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 18:34:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4KuCRf4+RN19YLJgRoUALxETydthFpEg/799EuZ1QuO9RaFPDIWfkXbqLhCT0Yg55In+KU9qlcnthTuEDkqujEBpgT+PCQBVCRgwxhQ==
X-Received: by 2002:a17:906:b798:b0:a41:3d8b:80d with SMTP id
 dt24-20020a170906b79800b00a413d8b080dmr4244517ejb.37.1708914883747; Sun, 25
 Feb 2024 18:34:43 -0800 (PST)
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
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com> <sfh6bvpihpbtwb7tgdkrhfd333qcxrqmvl52s5v5gbdpd2hvwl@p7aoxxndqk75>
In-Reply-To: <sfh6bvpihpbtwb7tgdkrhfd333qcxrqmvl52s5v5gbdpd2hvwl@p7aoxxndqk75>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Feb 2024 18:34:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjmUQN4vZJAotcHHPcoEMV7OutKWJc1dtrDXErdxTMgcA@mail.gmail.com>
Message-ID: <CAHk-=wjmUQN4vZJAotcHHPcoEMV7OutKWJc1dtrDXErdxTMgcA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 17:58, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> According to my reading just now, ext4 and btrfs (as well as bcachefs)
> also don't take the inode lock in the read path - xfs is the only one
> that does.

Yeah, I should have remembered that detail - DaveC has pointed it out
at some point how other filesystems don't actually honor the whole
"all or nothing visible to read".

And I was actually wrong about the common cases like ext2 - they use
generic_file_write_iter(), which does take that inode lock, and I was
confused with generic_perform_write() (which does not).

It was always the read side that didn't care, as you point out. It's
been some time since I looked at that.

But as mentioned, nobody has actually ever shown any real interest in
caring about the lack of POSIX technicality.

> I think write vs. write consistency is the more interesting case; the
> question there is does falling back to the inode lock when we can't lock
> all the folios simultaneously work.

I really don't think the write-write consistency is all that
interesting either, and it really does hurt.

If you're some toy database that would love to use buffered writes on
just a DB file, that "no concurrent writes" can hurt a lot. So then
people say "use DIO", but that has its own issues...

There is one obvious special case, and I think it's the primary one
why we end up having that inode_lock: O_APPEND or any other write
extending the size of the file.

THAT one obviously has to work right, and that's the case when
multiple writers actually do want to get write-write consistency, and
where it makes total sense to serialize them all.

That's the one case that even DIO cares about.

In the other cases, it's hard to argue that "one or the other wins the
whole range" is seriously hugely better than "one or the other wins at
some granularity". What the hell are you doing overlapping write
ranges for if you have a "one or the other" mentality?

Of course, maybe in practice it would be fine to do the "lock all the
folios, with the fallback being the inode lock" - and we could even
start with "all" being a pretty small number (perhaps starting with
"one" ;^).

                Linus

