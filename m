Return-Path: <linux-fsdevel+bounces-20561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 423B68D51FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634FF1C21EE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 18:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670BC4D8D2;
	Thu, 30 May 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cAoLJkyX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3B4D8CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094941; cv=none; b=JULD12WxGTBn9AemnY4QVJ2k6iqsijiiNTL6gdyovU0ereir+Z0svw8QCEd3+IvPbotck7w9j5myhcHndURU2WDJ7xcGO3b28fxgs9cPkD6kTbGN2kvVkVrqVvPNWoZr9tgkdaIPr3cUv+qH5n5Y0FedJ60E8FErRqOcjkC/PaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094941; c=relaxed/simple;
	bh=YrIlTt2M7V2kzaaysZUXCyYilSAzOjMVnTtaVWrUgEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCBVEpVeQMG3mnbSTTUFrEWpWp3fGTBuHu6Cp7f2Nlv0iy/o6vjLkD5s50qPi+TfGZhYz4WJ5/tXw1jxRq9G+Hn0lJw13PoIobLDvnaWIcsrfK85+1NyicFM5JX5Etr+6FOOBkxEAZAroJF77MvUU6TDd2orNzwzpKFhcQ1lvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cAoLJkyX; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d1b6b6b2c5so92781b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717094938; x=1717699738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qj91sQI6EjJYpeXTBf/M3Dbys55/PvPs3bNPhSHmdDY=;
        b=cAoLJkyXLnruQJsOwn/pBAf9M21QBr/jMmY6p2t2B5/iVlbwckDYdUJIuVgX1PRQlS
         xRnv4OBYYAlTjR9532sBHJt3zCuMcLQLPpcAyy5CLyIlU2KCZaDrfInp7iolBXUb6sOp
         XPMbxsNLTSkRbGP5pHnM+IdcMmd6gv5wwm5t31bxXLrATxdvOcNjTSNHVvAEp+3/ry6F
         f9YICTPc1Cr86+no7aZX+syLbc7JO+ORr8lnLBMBUJLBkDc0MmmcYazkh2SvaPB762Rz
         AedKWAyhaWxjDqM0S5x87nssdNnxp2rOt6IqJj/tN+3Xy5f6GjlIX8Hrw9IVK0Gj61uK
         yqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717094938; x=1717699738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qj91sQI6EjJYpeXTBf/M3Dbys55/PvPs3bNPhSHmdDY=;
        b=gnK3F5hcik5NN3pF7720q3O6EeI1og2Z1eyjYoK1P9B5JNNQr7iRUafdUeZy7CIiuh
         tGfp3489m+7K/7T2zV1U/I14tVkrbXGQ8fiGwr06o3pOKqj2gqvFa9P2LN6lzMDnemEN
         NIwNU2//WSh4DWZVT0EaxVdjklBzZY7mFpArYpl6Wu1MfdemyVuCFPb3BENO2Nl0yg5U
         ZOB3/MZb45s5II4Kapwdbmm9dPe1PQptRkEoJsNq30L92Gd893S+dYZoIPRATLxc6TyG
         8wxY9QZNya3O2F/VjTSdKLcnWE6/9RMRWvy8zPa9gYTi9vXyzP+sTRTNGakOG0B/rKCA
         l93w==
X-Forwarded-Encrypted: i=1; AJvYcCWnvyj2YyDU3lI49/BWftHzuNjyVDY/foeuc8LDHj1o/Sy/JSsJFE5cjduydLmLoUdTHHTdvZovKLWqhWeVo9gZAVxq8+YqjiWKCZfHwg==
X-Gm-Message-State: AOJu0YxTPcO14iOkv1LtoTioOMJ0VVTwwOQqMxBL8LQ3m8EEpYskxhJu
	O/DTwpH+pDsNoU9nLd1cEfvKYZglIfJKpvdwnOFsViV/7wERE7IDwWvKPHsYagU=
X-Google-Smtp-Source: AGHT+IHbUlYrucmmF9XjhmWF9isXDD+m/37YkplygqjmokxIqPGnedPafoQdzIBxFjmB9bTZJe8VSg==
X-Received: by 2002:a05:6870:5489:b0:250:7a11:1ef6 with SMTP id 586e51a60fabf-2507a11226cmr1773123fac.4.1717094938468;
        Thu, 30 May 2024 11:48:58 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91049a713sm66428a34.0.2024.05.30.11.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 11:48:57 -0700 (PDT)
Message-ID: <ed8f667b-7aa3-41b8-bb98-3f52a674d765@kernel.dk>
Date: Thu, 30 May 2024 12:48:56 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/19] fuse: fuse-over-io-uring
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrei Vagin <avagin@google.com>, io-uring@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Josef Bacik <josef@toxicpanda.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <5mimjjxul2sc2g7x6pttnit46pbw3astwj2giqfr4xayp63el2@fb5bgtiavwgv>
 <8c3548a9-3b15-49c4-9e38-68d81433144a@fastmail.fm>
 <9db5fc0c-cce5-4d01-af60-f28f55c3aa99@kernel.dk>
 <tpdo6jfuhouew6stoy7y7sy5dvzphetqic2tzf74c47vr7s5qi@c5ttwxatvwbi>
 <360b1a11-252d-48d9-a680-eda879b676a5@kernel.dk>
 <ioqqlwed5pzaucsfwbnroun5rd2l3loqo53slmc5vos2ha5njm@5aqt6kglccx4>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ioqqlwed5pzaucsfwbnroun5rd2l3loqo53slmc5vos2ha5njm@5aqt6kglccx4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/24 11:58 AM, Kent Overstreet wrote:
> On Thu, May 30, 2024 at 11:28:43AM -0600, Jens Axboe wrote:
>> I have addressed it several times in the past. tldr is that yeah the
>> initial history of io_uring wasn't great, due to some unfortunate
>> initial design choices (mostly around async worker setup and
>> identities).
> 
> Not to pick on you too much but the initial history looked pretty messy
> to me - a lot of layering violations - it made aio.c look clean.

Oh I certainly agree, the initial code was in a much worse state than it
is in now. Lots of things have happened there, like splitting things up
and adding appropriate layering. That was more of a code hygiene kind of
thing, to make it easier to understand, maintain, and develop.

Any new subsystem is going to see lots of initial churn, regardless of
how long it's been developed before going into upstream. We certainly
had lots of churn, where these days it's stabilized. I don't think
that's unusual, particularly for something that attempts to do certain
things very differently. I would've loved to start with our current
state, but I don't think years of being out of tree would've completely
solved that. Some things you just don't find until it's in tree,
unfortunately.

> I know you were in "get shit done" mode, but at some point we have to
> take a step back and ask "what are the different core concepts being
> expressed here, and can we start picking them apart?". A generic
> ringbuffer would be a good place to start.
> 
> I'd also really like to see some more standardized mechanisms for "I'm a
> kernel thread doing work on behalf of some other user thread" - this
> comes up elsewhere, I'm talking with David Howells right now about
> fsconfig which is another place it is or will be coming up.

That does exist, and it came from the io_uring side of needing exactly
that. This is why we have create_io_thread(). IMHO it's the only sane
way to do it, trying to guesstimate what happens deep down in a random
callstack, and setting things up appropriately, is impossible. This is
where most of the earlier day io_uring issues came from, and what I
referred to as a "poor initial design choice".

>> Those have since been rectified, and the code base is
>> stable and solid these days.
> 
> good tests, code coverage analysis to verify, good syzbot coverage?

3x yes. Obviously I'm always going to say that tests could be better,
have better coverage, cover more things, because nothing is perfect (and
if you think it is, you're fooling yourself) and as a maintainer I want
perfect coverage. But we're pretty diligent these days about adding
tests for everything. And any regression or bug report always gets test
cases written.

-- 
Jens Axboe


