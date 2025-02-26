Return-Path: <linux-fsdevel+bounces-42679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C06A4608F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 14:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EF43ACC21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 13:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4763921D3C7;
	Wed, 26 Feb 2025 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="davWuDSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E42192EE;
	Wed, 26 Feb 2025 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575957; cv=none; b=NqeBfQq1HRAYdDLpMpeh/QP9Pp/JKjgCWWdBoWGacen6vOdYG6Uh8wNEv2Y/mMBYkwnRYoI0XmHws/UysgOw1zQ4G9dFTc8xo3grY2L0VgyzcUxB+BHHAGJYoEcRBHHVy2iJxkHoN5mMFfKRBeqadseTxbXTVXfkGl5+084So34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575957; c=relaxed/simple;
	bh=YOOQzCfz+RVMuVYtyvfzzXeE4eMqRdtBbY+l6e/+iq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0uRnHaADAJc/agr70LYpIDcYRIaNhXpikrHADCYFJdkI+ZQf6Eef6t0JA6grUxjppsh6k9gwkd0e4h45VgDvUgLDqqCnP1rkpB1xvY24M5K3TmB/EDEcgA3/FKPUCXDwgv19DPujIE5pM5Ztco14BRW6vSbKXZ630MXaBWlbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=davWuDSw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ded69e6134so11145025a12.0;
        Wed, 26 Feb 2025 05:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740575954; x=1741180754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7etPXwgBDrVOOvGd5qWXXdpTXS9fCWERnwFu20Cifs=;
        b=davWuDSwpVz4jbYcwdD3MhYFcO3flmYrHCClAY6JUQ71vvxG2d/Ze7YoJm1i3eLCWL
         EJcENi1VD42ysb3kMbIn3QmtzZR3ThXgzbmRGS00WY+W1royi3ornxmOMHSbIq8Z5mzt
         qTDJHkH8UAiSIk8Naslt1GbgBvfBWjYrkcQ6CTh9/3muEyui3vK2L1l/x26mx5xmHNmo
         +nXUG3LayZPwSplIJE+msnVzp+EFqo2YXxk469Jydq56xD4FM6IY5GbaMhN3XyPisRyj
         OYPOheCOs65QqExRUducaVkY0y8vph65l/1dUpnlxShnicSWKbxvPQhtrgJ07TzITUWE
         uRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740575954; x=1741180754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7etPXwgBDrVOOvGd5qWXXdpTXS9fCWERnwFu20Cifs=;
        b=xMi9enP8SiBk9+DrxgawrzhTUzKquhLgZLdvrrzZx8Huikea/DzouwTWASkuhgkI8K
         iYTzEuWzqPL8Yw1jtWvYpuOiiA+i/aEVOmV9tliQoCYLzfFa0elnvhs2yFW1nuYWnxg3
         ubMSfV44Gtibokg8govYZ/aYb8w5qR3r8te1JRKZPc5EdComHwwHDi8DBVYcPpfMn2Tv
         3mku1JNzHS4GNhbTMToDqU0jmetDnrtqS52Mcbk/zvFEev+z/e6wPL0dw1mZGIvcGKWS
         AxQMSB1kIA49Rc9r13v6Jw+TdJ5agWOl+DuKB6+dopeVTKhtbRwUciUHbO7pZQQrxVxN
         qQnA==
X-Forwarded-Encrypted: i=1; AJvYcCVRwllfhPtIriF2uhP5OUQGfQ121uSZHSjTMQ0JNFvAiX/U9rQL4gOwEK8oKOiwfgmvqcF2Z5sKT+7a1tVO@vger.kernel.org, AJvYcCX6FfS0hDxybTBa/f97tIKr9OMnWGIMAzN8D7TLJ7LEe15EOxKbMh+/xHzTuPrVvz/l1XWkm+DUvAITOVBp@vger.kernel.org
X-Gm-Message-State: AOJu0YxvNlizyuQLTKZzJb+7MxJD8foGhjM3rG86EhZFj6UcB0UXHo1X
	OaKnbdN7JIVYNojL51ijeQFqO/F1CgLoAwj/zg8TakmkQEp5E4MYH3sjO947
X-Gm-Gg: ASbGnctWN68PrjxnQ8wcTPqO1CqJ1I4BN0Oyp5Uv8eHyGG18zxetTFOwI8Kiz+y0UkL
	9D3+b3pEdiZZE9BVjqoSgzO/+qaQXRU/RECMVo6s/sX00E8YluY/0zyhUfNx1HklU1ZN7VqmUOQ
	oqqHPY9wCmMEaJxfS0uX2RYGpkZ6p46hNDFOoB0bZ7rxq8P1AFm6UxUInVt2ppxwBt57qJAkLL8
	I4GvKmYFwz5ZqRsE/o28uQb1977VXWc+W1Y/9Hw0HydVPOlksUWXWe4AkPphPFzY9mMOxNJgKuo
	yhbXDlUa/A2ZMkuW433y09CM1dDN8AnryW8FFDv78A==
X-Google-Smtp-Source: AGHT+IHqBLfninfSL3VmmxUVBX05PXkRJTuu1fJsyzAppjdDOMU7oA/onvkL+RxvktUOetKMpdZmdQ==
X-Received: by 2002:a17:907:1c17:b0:ab6:dbd2:df78 with SMTP id a640c23a62f3a-abeeef44c16mr369316666b.35.1740575953186;
        Wed, 26 Feb 2025 05:19:13 -0800 (PST)
Received: from f (cst-prg-92-183.cust.vodafone.cz. [46.135.92.183])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d5c4dasm329187866b.68.2025.02.26.05.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:19:12 -0800 (PST)
Date: Wed, 26 Feb 2025 14:18:59 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, 
	Manfred Spraul <manfred@colorfullife.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, 
	Neeraj.Upadhyay@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224142329.GA19016@redhat.com>

On Mon, Feb 24, 2025 at 03:24:32PM +0100, Oleg Nesterov wrote:
> On 02/24, Sapkal, Swapnil wrote:
> > Whenever I compare the case where was_full would have been set but
> > wake_writer was not set, I see the following pattern:
> >
> > ret = 100 (Read was successful)
> > pipe_full() = 1
> > total_len = 0
> > buf->len != 0
> >
> > total_len is computed using iov_iter_count() while the buf->len is the
> > length of the buffer corresponding to tail(pipe->bufs[tail & mask].len).
> > Looking at pipe_write(), there seems to be a case where the writer can make
> > progress when (chars && !was_empty) which only looks at iov_iter_count().
> > Could it be the case that there is still room in the buffer but we are not
> > waking up the writer?
> 
> I don't think so, but perhaps I am totally confused.
> 
> If the writer sleeps on pipe->wr_wait, it has already tried to write into
> the pipe->bufs[head - 1] buffer before the sleep.
> 
> Yes, the reader can read from that buffer, but this won't make it more "writable"
> for this particular writer, "PAGE_SIZE - buf->offset + buf->len" won't be changed.

While I think the now-removed wakeup was indeed hiding a bug, I also
think the write thing pointed out above is a fair point (orthogonal
though).

The initial call to pipe_write allows for appending to an existing page.

However, should the pipe be full, the loop which follows it insists on
allocating a new one and waits for a slot, even if ultimately *there is*
space now.

The hackbench invocation used here passes around 100 bytes.

Both readers and writers do rounds over pipes issuing 100 byte-sized
ops.

Suppose the pipe does not have space to hold the extra 100 bytes. The
writer goes to sleep and waits for the tail to move. A reader shows up,
reads 100 bytes (now there is space!) but since the current buf was not
depleted it does not mess with the tail. 

The bench spawns tons of threads, ensuring there is a lot of competition
for the cpu time. The reader might get just enough time to largely
deplete the pipe to a point where there is only one buf in there with
space in it. Should pipe_write() be invoked now it would succeed
appending to a page. But if the writer was already asleep, it is going
to insist on allocating a new page.

As for the bug, I don't see anything obvious myself.

However, I think there are 2 avenues which warrant checking.

Sapkal, if you have time, can you please boot up the kernel which is
more likely to run into the problem and then run hackbench as follows:

1. with 1 fd instead of 20:

/usr/bin/hackbench -g 16 -f 1 --threads --pipe -l 100000 -s 100

2. with a size which divides 4096 evenly (e.g., 128):

/usr/bin/hackbench -g 1 -f 20 --threads --pipe -l 100000 -s 128

