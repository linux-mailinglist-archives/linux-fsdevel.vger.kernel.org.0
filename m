Return-Path: <linux-fsdevel+bounces-40454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DF3A23753
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 23:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2985B7A374D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC16B1B87DA;
	Thu, 30 Jan 2025 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="unbgh1eG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B343987D
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738276815; cv=none; b=YrXmFF9JSXLNVb6BbzKvqi8xxPj4ivxTXFvf5CbUxjyl9PYrqcQMJ+85PZtvVLAfdhOH3ZKZTOsH3hHIV4G9PBbEneJ9pfRHNNOfGWWz30E80u/EEHcBR9cDCgMYhp2x2RcSUgxFHssLJq7pviDP/M+iXDqw8Dmy9ZeQI3/MyJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738276815; c=relaxed/simple;
	bh=/xmtAIi+Gic70PlfOU2/it6S5SJ181lW+hojsfW/Zn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8+Xs288NYpGYRa7+tB9tRhYWvKuDpmYymWfGXZmYvUJRf1TMAK7cZsTEWz5LKNaao8WoqhKpsZsy+MyJhauodJl0T0te3RzRfJ5vqNwfxt1pGpgWCvBC7Wa5amRr+nicU8YdHwG5ZZS3vMUtZ1mE8QYlQVhvvttr+XxlpQArTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=unbgh1eG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so2365786a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 14:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738276813; x=1738881613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=99gvy7HNxTIGDfawMmDwoHuX+F4tR3KBo57dn0qAtok=;
        b=unbgh1eGU4HcxpnEs4Cme0HS6HjjjKOk4lO9/m2G+SViR99Fq6qPCP+PG16pjzs+4E
         81jZi05vQclZVIB0u612ztutsP8DQBxqvHTmIzY9X6uGnw5PJPt15MXAaPwMXOVXKRAd
         jfCF/SGGmUUGAycsBBth2/jPrlvSnP1J5BNdmMBe2jQIlS1WYdS9IZIHfde7yszilWSW
         EgXViPDN9YPhL+W8ppd4CBdspeswKNJlU+ggn8jJdg06V5X/5O2A1D58bBdN1QVF/pYu
         6z/nTctiBK7LxU46AJrp3CRLC5xmbkzrcbqKFAm1HpebhscJZy5/wGVC9bxsJaZuNvWy
         rFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738276813; x=1738881613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99gvy7HNxTIGDfawMmDwoHuX+F4tR3KBo57dn0qAtok=;
        b=YnoZbbP2QVNCzKtKkwSCHFNKkBe2gdB657p7eMavK/Eg0e5tRhQjO3kH8/H5dII6+v
         WnX8dk0KFz0Tjd9V5fk2tPu6B1Bb0DhCJ0W+0dz26TZ/7pFg0z3RMOZrH5WJxluQYavq
         VXgSEAlrBzzyTFEvAB3OWSyGb77MoTpoTHTrBcs9Wflj6I1BJ/dmjdXLP3rGT+4Jo27n
         lXCKG1HlzYABWfQc+yo41fUy3Ig1b4y4PWX4r3vitOsxTIUScGCz2t/w55Z2SOxHVpSj
         l8o61WaJi3QZvxqbz7y38kk6O500ZYtkcJEPwDQKJDuIAnkTR/1R5kXbXKeriQB8PXSn
         EhtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRjcK6rILOMk6yc+64vKgABfGfCnt7fCFpb74PfZufLp9jYZIV7zNv/mDEHqAYlF7zbv+yBhFY5en4gAhe@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4m5L1y1YBz9U0AMhg/MOG76r0aBzrHhp8AXByc7LwgB0pHoL
	avufcFczDtkLJrtzf2QbOfJTaiCbAcFefzuaDIMfK9T7W9kZodEjrNDblD1XWdM=
X-Gm-Gg: ASbGncuU/WaqJ8z85erbOzRtJes2GIxSEFipWfv7o8xoqtvciUuBIzmssnjEwr7A2Fr
	blw+BMWP/eFa9+/KivIf+Vsb1ujFp5qHMO9X3KNUqp84YUk6D5a1Fa/5IHsCZw5qTpXbiqKocqA
	S4wyFVw9cL8Z+WV4X1WP0kbleFYii3GMBesP9iK4HOiG5ceEWf21fG+gejKxHjIIXiNTausWp0z
	DxjNk803rcDS3AOigoemhpyvVbwEiUqMeDaNA46+AjhC/2/IanetPKLJFejuDCs/TiJaoIkv4bI
	hbW0qcyh2mhNSVq+glGDepObQuMkzLjR7+wEIRJ8SJP+lgdCZ18diQ==
X-Google-Smtp-Source: AGHT+IF1aj+X6bEut9rmnVa2uRkwuaGmzri5vD7oRY/p5fNntcbicDZrAZcN1OJnMarAqaUoEKaXEA==
X-Received: by 2002:a17:90b:288a:b0:2ee:d35c:3996 with SMTP id 98e67ed59e1d1-2f83ac8371amr12362329a91.31.1738276812900;
        Thu, 30 Jan 2025 14:40:12 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:18cb:90d0:372a:99ae? ([2620:10d:c090:500::7:ba76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21edc84fcb7sm4903785ad.205.2025.01.30.14.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 14:40:12 -0800 (PST)
Message-ID: <9872aaae-d6dd-4d62-a9c2-12938628a4ae@davidwei.uk>
Date: Thu, 30 Jan 2025 14:40:10 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] FUSE io_uring zero copy
Content-Language: en-GB
To: Keith Busch <kbusch@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 Bernd Schubert <bschubert@ddn.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
 Joanne Koong <joannelkoong@gmail.com>
References: <dc3a5c7d-b254-48ea-9749-2c464bfd3931@davidwei.uk>
 <Z5v7uJF7TPPEe6TI@kbusch-mbp>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <Z5v7uJF7TPPEe6TI@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-01-30 14:22, Keith Busch wrote:
> On Thu, Jan 30, 2025 at 01:28:55PM -0800, David Wei wrote:
>> Hi folks, I want to propose a discussion on adding zero copy to FUSE
>> io_uring in the kernel. The source is some userspace buffer or device
>> memory e.g. GPU VRAM. The destination is FUSE server in userspace, which
>> will then either forward it over the network or to an underlying
>> FS/block device. The FUSE server may want to read the data.
>>
>> My goal is to eliminate copies in this entire data path, including the
>> initial hop between the userspace client and the kernel. I know Ming and
>> Keith are working on adding ublk zero copy but it does not cover this
>> initial hop and it does not allow the ublk/FUSE server to read the data.
> 
> If the server side has to be able to access the data for whatever
> reason, copying does appear to be the best option for compatibility. But
> if the server doesn't need to see the data, it's very efficient to reuse
> the iov from the original IO without bringing it into a different
> process' address space.

For a write operation, the server may want to optionally _read_ the
data. Does this force pages to be pulled into the cache anyway so we may
as well copy? If so - then I can look into removing this read
requirement, which then makes it possible to use your work ublk zero
copy. That is, make whoever generating the data to do the work that FUSE
server was going to do _before_ shoving it into the zero copy data
pipeline.

> 
>> My idea is to use shared memory or dma-buf, i.e. the source data is
>> encapsulated in an mmap()able fd. The client and FUSE server exchange
>> this fd through a back channel with no kernel involvement. The FUSE
>> server maps the fd into its address space and registers the fd with
>> io_uring via the io_uring_register() infra. When the client does e.g. a
>> DIO write, the pages are pinned and forwarded to FUSE kernel, which does
>> a lookup and understands that the pages belong to the fd that was
>> registered from the FUSE server. Then io_uring tells the FUSE server
>> that the data is in the fd it registered, so there is no need to copy
>> anything at all.
>>
>> I would like to discuss this and get feedback from the community. My top
>> question is why do this in the kernel at all? It is entirely possible to
>> bypass the kernel entirely by having the client and FUSE server exchange
>> the fd and then do the I/O purely through IPC.
> 
> This kind of sounds like "paravirtual" features, in that both sides need
> to cooperate to make use of the enhancement. Interesting thought that if
> everyone is going this far to bypass memory copies, it doesn't look like
> much more of a heavy lift to just bypass the kernel too. There's
> probably value in retaining the filesystem semantics, though.

Right, sorry I didn't phrase well in my initial email. I _want_ to put
it in the kernel because I want it to be in the open and I want it to be
generically useful to others. But _is it_ generically useful enough to
codify it in the kernel? I have one use case in mind but I think it
would be a bad kernel API if it _only_ worked for my case! That's why I
want to lead a discussion on this at LSFMMBPF to gather feedback.

