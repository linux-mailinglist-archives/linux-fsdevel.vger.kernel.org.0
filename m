Return-Path: <linux-fsdevel+bounces-18746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4DB8BBEB0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 00:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C50E1F2188D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 22:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC884DFA;
	Sat,  4 May 2024 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxkYNDnx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BC43AC0C;
	Sat,  4 May 2024 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714860819; cv=none; b=XDmawf68TeY6WHVbCjSjL+mqgTTsc1rFGBHPeAq3xv8Az2JEjuQ5UtPphDutPWlYC7zuG5NiCKTX1SjKco3qyPOLQCdacCly2K52sSL61Vbis7ngU3AslvA7089SYI9eHVb5ao6Z+10nAfBZo+lodBgUO7oPWVGkIxU8LZO4iJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714860819; c=relaxed/simple;
	bh=+bKYM7oK9MxJEWHIqHgavPy2YCwpLmxgKmFnVCuqWpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZTnZzBU160Er7Qf4hqhUfX/Qi5g7svQppNra4Nl6wWK5x5HFZU3ju7eGnefqQHqAxDk2RuYDv77qBUmxns+bnOAIgNlu9VbcvSW3NipUU30kIbatIQsh5VzoOz0BjERB6GD+X2pjW4+dRR/cuwQx7BjMMVdARpoeZ5wwp0V5GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxkYNDnx; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so489670a12.0;
        Sat, 04 May 2024 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714860817; x=1715465617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9unkjuVShUEk/iPiPG7EPoKRZdQZGGq2FXrz5dixV4=;
        b=gxkYNDnxovK2McyUoynA74OO5a+7EzqcQORuXu3P7BFT2UTh8An+mtT/8jIIrjZ9k7
         0+lUQ+DYoV4havUea3J2PC+uNU++SxQVnHRr2UykiycnQEpTiexiANcBy4ed5JKKWdpo
         tXolgOQZnIXBgKebcPWIBBl+0jhAyyXx5Nvgid7dgU08hXs2+mRRYvsUH4vQkjUaXNDo
         ynqdfS/FM8Ro44xqKXeKpjQXQ33SXMX7EvD4OQ0iqK11vjHb9GeQIescgB37PUdT/fsR
         VvzNB3YJJ433qTJsGqPxTCKS0HY9hs/u6A6WfbVcmcg/KgA8Kq0EBLe/1HWgaG+h5v76
         ATJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714860817; x=1715465617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9unkjuVShUEk/iPiPG7EPoKRZdQZGGq2FXrz5dixV4=;
        b=qZcVsG2/MfSRiu9W2+G+5lRedWVKcLFkmu9aYifd60tjMKHpI40gK/x4zs6ZmuwZen
         meQ/09TmSfK8GzKZPhQibccDIU8ecL+H0UTIbQoTox2nuOhNzQ7iHwDLDSjRW/IljkZO
         kkPLho7j3xmRI2VZ2UNvtPmE0HhFng8JnIdH7FVjkzkFb7/qMeJxb86JljTS70IGRf9j
         RuXBMFXpF7z6FRn8WLe7QaTW9jQe20UlsmoJlRSMzNkJbFUxqqwLpZH3eVtHVhYnf5J0
         oMNQxyqplcwVLn8DHJ68wM4kGvOpkN9LEuco6QxEnNRa4XNvddgFI/c1amS2cDQ9kSMv
         pumg==
X-Forwarded-Encrypted: i=1; AJvYcCV5bTxFTP1etFWl4Z6tI6qwb0Ud2vY16GeO9PT0YB+ZvRMX9brYuxeOjkmMih0IQy9vubqxS1FnjSKRbR2KLjFhMDRY3NGch7ihzBK835DyqMds6yHxLA1M6Qp3hy0/qLZ6L8sQ/DvvjWcoL5iRetPQw66MAJgZuyj8R3FZe6VvZA==
X-Gm-Message-State: AOJu0YwR5RJHiMtzzsy21uZ2CHd9ovCkR6z6s9NHCfBiAwBR83WtGXac
	NUDPKb9YwLmD68UzVCbunnY2swvTv/bNoKYdXQtvmFTIysz2ZxWBTOff7CKdrPSIbgmIMatrf7R
	KSAK0u+7cp/lwannyeVoYlOuWxxA=
X-Google-Smtp-Source: AGHT+IH7kyl9ysYQF/CgmoL9h1C0Cxvzu/JuyG42DgrFoEsKVBDHDDB9F2A7sEg1ahP0OclCgHXPLgibAOa4yjF3s7Q=
X-Received: by 2002:a17:90a:d709:b0:2a5:be1a:6831 with SMTP id
 y9-20020a17090ad70900b002a5be1a6831mr14208459pju.19.1714860817143; Sat, 04
 May 2024 15:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-6-andrii@kernel.org>
 <2024050425-setting-enhance-3bcd@gregkh>
In-Reply-To: <2024050425-setting-enhance-3bcd@gregkh>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 4 May 2024 15:13:25 -0700
Message-ID: <CAEf4BzbiTQk6pLPQj=p9d18YW4fgn9k2V=zk6nUYAOK975J=xg@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 8:32=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote:
> > I also did an strace run of both cases. In text-based one the tool did
> > 68 read() syscalls, fetching up to 4KB of data in one go.
>
> Why not fetch more at once?
>

I didn't expect to be interrogated so much on the performance of the
text parsing front, sorry. :) You can probably tune this, but where is
the reasonable limit? 64KB? 256KB? 1MB? See below for some more
production numbers.

> And I have a fun 'readfile()' syscall implementation around here that
> needs justification to get merged (I try so every other year or so) that
> can do the open/read/close loop in one call, with the buffer size set by
> userspace if you really are saying this is a "hot path" that needs that
> kind of speedup.  But in the end, io_uring usually is the proper api for
> that instead, why not use that here instead of slow open/read/close if
> you care about speed?
>

I'm not sure what I need to say here. I'm sure it will be useful, but
as I already explained, it's not about the text file or not, it's
about having to read too much information that's completely
irrelevant. Again, see below for another data point.

> > In comparison,
> > ioctl-based implementation had to do only 6 ioctl() calls to fetch all
> > relevant VMAs.
> >
> > It is projected that savings from processing big production application=
s
> > would only widen the gap in favor of binary-based querying ioctl API, a=
s
> > bigger applications will tend to have even more non-executable VMA
> > mappings relative to executable ones.
>
> Define "bigger applications" please.  Is this some "large database
> company workload" type of thing, or something else?

I don't have a definition. But I had in mind, as one example, an
ads-serving service we use internally (it's a pretty large application
by pretty much any metric you can come up with). I just randomly
picked one of the production hosts, found one instance of that
service, and looked at its /proc/<pid>/maps file. Hopefully it will
satisfy your need for specifics.

# cat /proc/1126243/maps | wc -c
1570178
# cat /proc/1126243/maps | wc -l
28875
# cat /proc/1126243/maps | grep ' ..x. ' | wc -l
7347

You can see that maps file itself is about 1.5MB of text (which means
single-shot reading of its entire contents is a bit unrealistic,
though, sure, why not). The process contains 28875 VMAs, out of which
only 7347 are executable.

This means if we were to profile this process (and normally we profile
entire system, so it's almost never single /proc/<pid>/maps file that
needs to be open and processed), we'd need *at most* (absolute worst
case!) 7347/28875 =3D 25.5% of entries. In reality, most code will be
concentrated in a much smaller number of executable VMAs, of course.
But no, I don't have specific numbers at hand, sorry.

It matters less whether it's text or binary (though binary undoubtedly
will be faster, it's strange to even argue about this), it's the
ability to fetch only relevant VMAs that is the point here.

>
> thanks,
>
> greg k-h

