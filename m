Return-Path: <linux-fsdevel+bounces-13015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5D486A2C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FA7287DCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 22:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21BA55C07;
	Tue, 27 Feb 2024 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I2SNzG3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5755C01
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073993; cv=none; b=sXB+VaP8oYKW5cT1V+sZ1/QzN7SVj8tTQTvoSF3E00YWWEXBtxhWnt8ex9tO0z/NpZBcuD0FNqAAJa2ZdH8y3XMt697+1zJjgcKB2vZ6DMJeUIMxWmE+IOcIlwgco1Fq14quMbtrcLGjTlWR4UdIEJ8dN3ZsxR7nAyJ4tY+IwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073993; c=relaxed/simple;
	bh=SgMG8zrBM4kz/qvumdCBREVR5iHJ0y5R4OzaYhAIgvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHfrttu9V2depjVLjpb1WCMRkQzPQHEhRigwA5FLe9mWLyk3LV1vJ503x+LOvTcSok0VwuUZlAUNCtfrvjvaQDDBxQLhaRpDP9YprB5ILCvldfivgqe4ARy+bUxKHmUVPWRp+Lf2ri4qa5oanDJ/98vdhyuscE5EB2PZFfIokXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I2SNzG3g; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28a6cef709so733514066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 14:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709073989; x=1709678789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jki/jdCfzFxbFgKg5OpDwmRv+Vr2+fnyhqCG7F3VOE8=;
        b=I2SNzG3gbBYSa1aL+a7xOLlwgg/IjnWraVnKxJc+GDndqfxJKiU2eKKGPo2Sdc8DMQ
         pmNW0Sbe693/VAa5eGe7GMFo/Y/S5WmzMfrkJl3darqjKZpP98AQhXaqGHVSn4918MZl
         1W5nzGemqspBdSqDJby+5t/RsIcPPhGTAaqFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709073989; x=1709678789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jki/jdCfzFxbFgKg5OpDwmRv+Vr2+fnyhqCG7F3VOE8=;
        b=n5nHEHSHn8CQZr7f1QaO46BoLy7BcKB8U+idt4mB7DVbaEZQKn9vQrlggt0JeBo/PZ
         EMhGjNMLjq90pENOuF/0aaKmIzKjQXIIulDtEoy/Z9CY1eaOTouxbiw3NSEUWgoQ0XJv
         MtCEUKEsI/urink4eBfbiIiEvLqKeQuI7PmVtHRO+QtzAh6A9yqCqyOpu9wEqOlhnN+6
         jl31MFH2r3DKbjmi7P3l5cOt1oNpBh7XOY0pFssnKqjtnZeYmnmeYUMqy6lXt0LS+RXu
         DuNcwQ2R3IxByE5dJiZoSIi+HpBvrM6+LQ/tswv33A4bBS/pOHGOJ5l32I79mhtrD7R/
         qlQA==
X-Forwarded-Encrypted: i=1; AJvYcCULvaOl4ntgU6PD9TIMtWmJF1lVGRpy4RyOYAoXm/S+kVkW/auIfiImWKyswUB8/WdtepmLhQ0YmKzTHedrXDbG16nAhNyrYsPlEMm1qQ==
X-Gm-Message-State: AOJu0YyPh46pn7pyokF3E2imhT7/GiUFAFvIBC37mGTvdIMcZ5y0yxeq
	8U6w58a2Dgguzw5mfJ5Fe8kShQOlLzGZuoHYYcYFcLyBixooPCySFM89np3qbcOJaeTzIlKjYyc
	3Nrwwjg==
X-Google-Smtp-Source: AGHT+IEeZsP49aXneYrDDcX/KA6FI0FxXVgzkep6wEnC+bIx0rcPU5CvgOwR/6X6q3ObfKhjnH0/Nw==
X-Received: by 2002:a17:906:b15a:b0:a3f:5e8c:8a34 with SMTP id bt26-20020a170906b15a00b00a3f5e8c8a34mr8024051ejb.9.1709073989483;
        Tue, 27 Feb 2024 14:46:29 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id vk2-20020a170907cbc200b00a3d9a94b13fsm1194262ejc.136.2024.02.27.14.46.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 14:46:28 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so6583011a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 14:46:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUs+09pzOyQ+NXgsFExh4wPwBNuJ0qZbeuKHSCF4A1oUWIDIRgJai9VYKQt7kkgOMZ0I7FaK5Vsp/uZ2Lyijlb8dlHClvQAQWyFItzaMw==
X-Received: by 2002:a17:907:101b:b0:a3f:2c1:9887 with SMTP id
 ox27-20020a170907101b00b00a3f02c19887mr7538560ejb.21.1709073988145; Tue, 27
 Feb 2024 14:46:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area> <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
In-Reply-To: <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2024 14:46:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com>
Message-ID: <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 14:21, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> ext4 code doesn't do that. it takes the inode lock in exclusive mode,
> just like everyone else.

Not for dio, it doesn't.

> > The real question is how much of userspace will that break, because
> > of implicit assumptions that the kernel has always serialised
> > buffered writes?
>
> What would break?

Well, at least in theory you could have concurrent overlapping writes
of folio crossing records, and currently you do get the guarantee that
one or the other record is written, but relying just on page locking
would mean that you might get a mix of them at page boundaries.

I'm not sure that such a model would make any sense, but if you
*intend* to break if somebody doesn't do write-to-write exclusion,
that's certainly possible.

The fact that we haven't given the atomicity guarantees wrt reads does
imply that nobody can do this kinds of crazy thing, but it's an
implication, not a guarantee.

I really don't think such an odd load is sensible (except for the
special case of O_APPEND records, which definitely is sensible), and
it is certainly solvable.

For example, a purely "local lock" model would be to just lock all
pages in order as you write them, and not unlock the previous page
until you've locked the next one.

That is a really simple model that doesn't require any range locking
or anything like that because it simply relies on all writes always
being done strictly in file position order.

But you'd have to be very careful with deadlocks anyway in case there
are other cases of multi-page locks. And even without deadlocks, you
might end up having just a lot more lock contention (nested locks can
have *much* worse contention than sequential ones)

There are other models with multi-level locking, but I think we'd like
to try to keep things simple if we change something core like this.

               Linus

