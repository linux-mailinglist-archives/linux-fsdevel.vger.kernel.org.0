Return-Path: <linux-fsdevel+bounces-12686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CACB86287E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 00:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFCB1C21111
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 23:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D524E1CE;
	Sat, 24 Feb 2024 23:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F0pdNO3D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948C4DA0C
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708818071; cv=none; b=jVRvb1BhnucKfweyjGWZz0tzksopdKldL7HqCVx57hHwgJ1BmcB1qxnPE8IK5OgqHAJv9jnzdu39IiGIm5sjaa5ZJ9L4Y1T+teAcWGmLdkWqrpZMzVHDhS2XIsjTetvA9Vk8BQtloBWZ8VW1tkKhiKOBc6dRwaIVKiY6bwsZbtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708818071; c=relaxed/simple;
	bh=PSLEwwMVsxlk70ELrB28bL6Y6Xv4vZ04E3Bix5/9bgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtOemLZpdTNyvj2GxbL+ArzKY6BRpGfRPEy7y0K8f5olmf9s2DpDUl7BRpauFbSEQ0gXgv42HprplO7+WMWwCFtmwntWwsNVdbS4L/e6Z2I9KbSkbMV7+wg8vF6+TS/P+RfzKh71dKvsVa9FKFoDbeAuY8kf9CxsVmA2FM7Pwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F0pdNO3D; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512b3b04995so2092662e87.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 15:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708818067; x=1709422867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tn6hnRSUzCG2W9ifUDxK+evyzdzo2d3iCpPIutte+dk=;
        b=F0pdNO3Dv1i02ByDjtBH2SxSbF9AW8h2NGLjcVN3nyYTZrbQ0yBN687CmHIcaYHEfe
         9zORgktmK3RPLUFFNy2a4SoYOUKa+qwqI7J+llRgKuKwTZAfo8ad2CVy7Jd9GItYfIqf
         jYzDNsQLYcYQiJr6Osff0QH6zZzMXxDadptr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708818067; x=1709422867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tn6hnRSUzCG2W9ifUDxK+evyzdzo2d3iCpPIutte+dk=;
        b=CuhJkKrKnviG8ONWEyXfqYTjGX8MSrOmufDVpwZbhgHxYo3ycFh9j8HX35I0Sk3Y0M
         APSUgBM0L6MnkJVPJ/4Mtdz171kPrg+CHK6Jmi0MtsKCWBqeHBATDRkGJi9OajpRWICa
         qVTTQxQvsmiR1TzW/zjxvSNgu+CN8V31e5sslcwko2gPnr3ankKC4VV9lm+O7pcTg755
         w8T0sihlV8lHIDUoo8340bJsIE7r269p4JtIvCEyP6CWAFKSZKJTeislVK2go1S8UvN8
         p8ata9JzwBk8XsRA9O9xS31X/DhNx9yrGRmldNYSOnXnyExzA54iBOeRbMuE8/TBUBmh
         kLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOIHlEzC0QzNkn84YUG+5/aAXR7mX0ZbvMcML3t1ayilCGXfJbMGe5uIcnwcIbApH4YbexTfyZ+9V2MTAO+NbVaauL3mwG/D7AWyVMZQ==
X-Gm-Message-State: AOJu0YwYwNKOU/c2X8uSMSWunw8GsLgiwGTUO6zx/vDVOAO9h6SPiius
	oQS7GKX5/hKhJxQ0tH1hfY2L1CJoKnEza+TVp8Tpa527s/ALDQ6cZ3R2yWKA8ema/qWWVWRy9GO
	5wsU=
X-Google-Smtp-Source: AGHT+IH/ueycfG01DmrmKAdhYAvpLehb+ghEBCq6rFuZEg/5rJ9gBkxafqjxeeJ0p2MmYxjDyJf+MA==
X-Received: by 2002:a19:4307:0:b0:511:6a0b:1035 with SMTP id q7-20020a194307000000b005116a0b1035mr1881433lfa.17.1708818066717;
        Sat, 24 Feb 2024 15:41:06 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id cx7-20020a170907168700b00a4316384159sm261277ejd.224.2024.02.24.15.41.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 15:41:05 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3e72ec566aso255449766b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 15:41:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfzbqJCxx15A/uqWgNkcFR14NTCUr0xb90VgfEICEzl+OvkCzuhWWvgKA6nM/NOVPmwY0Fva2CG+KyIxwy3MUF5ZRQAreNZM2q/yn9zQ==
X-Received: by 2002:a17:906:3593:b0:a3f:10e8:ae2b with SMTP id
 o19-20020a170906359300b00a3f10e8ae2bmr2172770ejb.54.1708818065004; Sat, 24
 Feb 2024 15:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <CAHk-=wj0_eGczsoTJska24Lf9Sk6VXUGrfHymcDZF_Q5ExQdxQ@mail.gmail.com>
 <CAHk-=wintzU7i5NCVAUY_es6_eo8Zpt=mD0PAyhFd0aCu65WfA@mail.gmail.com> <bb2e87d7-a706-4dc8-9c09-9257b69ebd5c@meta.com>
In-Reply-To: <bb2e87d7-a706-4dc8-9c09-9257b69ebd5c@meta.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Feb 2024 15:40:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgeaMU_zY95QM+KUO1RmiuykbKgKVyBi9G1pH_kPgO9kQ@mail.gmail.com>
Message-ID: <CAHk-=wgeaMU_zY95QM+KUO1RmiuykbKgKVyBi9G1pH_kPgO9kQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Chris Mason <clm@meta.com>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Feb 2024 at 14:58, Chris Mason <clm@meta.com> wrote:
>
> For teams that really more control over dirty pages with existing APIs,
> I've suggested using sync_file_range periodically.  It seems to work
> pretty well, and they can adjust the sizes and frequency as needed.

Yes. I've written code like that myself.

That said, that is also fairly close to what the write-behind patches
I pointed at did.

One issue (and maybe that was what killed that write-behind patch) is
that there are *other* benchmarks that are actually slightly more
realistic that do things like "untar a tar-file, do something with it,
and them 'rm -rf' it all again".

And *those* benchmarks behave best when the IO is never ever actually
done at all. And unlike the "write a terabyte with random IO", those
benchmarks actually approximate a few somewhat real loads (I'm not
claiming they are good, but the "create files, do something, then
remove them" pattern at least _exists_ in real life).

For things like block device write for a 'mkfs' run, the whole "this
file may be deleted soon, so let's not even start the write in the
first place" behavior doesn't exist, of course. Starting writeback
much more aggressively for those is probably not a bad idea.

> From time to time, our random crud that maintains the system will need a
> lot of memory and kswapd will saturate a core, but this tends to resolve
> itself after 10-20 seconds.  Our ultra sensitive workloads would
> complain, but they manage the page cache more explicitly to avoid these
> situations.

You can see these things with slow USB devices with much more obvious
results. Including long spikes of total inactivity if some system
piece ends up doing a "sync" for some reason. It happens. It's very
annoying.

My gut feel is that it happens a lot less these days than it used to,
but I suspect that's at least partly because I don't see the slow USB
devices very much any more.

> Ignoring widly slow devices, the dirty limits seem to work well enough
> on both big and small systems that I haven't needed to investigate
> issues there as often.

One particular problem point used to be backing devices with wildly
different IO throughput, because I think the speed heuristics don't
necessarily always work all that well at least initially.

And things like that may partly explain your "filesystems work better
than block devices".  It doesn't necessarily have to be about
filesystems vs block devices per se, and be instead about things like
"on a filesystem, the bdi throughput numbers have had time to
stabilize".

In contrast, a benchmark that uses soem other random device that
doesn't look like a regular disk (whether it's really slow like a bad
USB device, or really fast like pmem), you might see more issues. And
I wouldn't be in the least surprised if that is part of the situation
Luis sees.

              Linus

