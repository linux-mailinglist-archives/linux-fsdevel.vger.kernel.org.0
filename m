Return-Path: <linux-fsdevel+bounces-41145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C7FA2B8B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 03:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59C016346D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 02:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D81215098F;
	Fri,  7 Feb 2025 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="al1g90ek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB8A364D6
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894247; cv=none; b=XnXE/VvWvY4JgXjQLPvylaVDxnK99p85HJExKHPIQFhhAE+gEYOXAq/eJJNnm27j09Si/dZ0qmkbDqpdcohEDS5p6NqoUmz4YHuXdLqrX0LmuscX+8ntlZszZ0TSqvEmG+1eJU7tfrpQ4odq8NQnQkVdxgogzs+HqDuE4q56ybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894247; c=relaxed/simple;
	bh=85oV5cF6V2NSws6FXmKkDfur5P+4/NH8XHC+nBcwiM0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SXEnBvGUboCVN/iZXT1UjqMthI0pQDIPRLb6q7E0W9ZIHxpGG2lq2b5oKgrUL8PwkCinkzwg3XKsjUGwAGp5EGXeS/lGbfzt6OkHo85hTwVDcV4OkNgy6J+Z3nzQ7+k4IOIBKDTTIMNmCzQ/JTHztg2z2bCkQIGw5VFB8dCt378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=al1g90ek; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f441791e40so2237761a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2025 18:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738894245; x=1739499045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wrtn6ymnI4hT9ie/YMebv62I+eFqjWT7unTv9c962cQ=;
        b=al1g90ek7txMKyaEygiODkAgusv0yLOEzsCB4a0heNJJCucaDRquc9h7iitdBCv4KR
         XKlJNLQOF8oDGGANR+Z2wcfcyvkzZynLQ/7tCAw6aSaDtXDTrDpfJ2F1oicXs+n1AOCB
         B4Rq03jUWWpmKtZ5jR0VqjZ8Q+kqlISLa3RUmqxgoSzEoRSEW4bodD7OwPvEEWS+W0IK
         MC+q+NBPLKuTRy+pJGdf5Vjuu1XPuF/mmCCpD6XwVVKxFndZeIJsRMbpTS9WLGYxDuLV
         gMoH+Ns8QYwdLJgLzpXDWTmTvFxSJ7PN7Wc3cPKFRGZE/1qf7GNDx3Ct8jtxSqMUBqpA
         28PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738894245; x=1739499045;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrtn6ymnI4hT9ie/YMebv62I+eFqjWT7unTv9c962cQ=;
        b=o7gg+Hb7DjeaR3SIPL+lGeW6H3fS747tOawQRPsIwbozNV7aEqN3iSfxZLAwQO5E0l
         pEip7juKQwVpf6TrTyVlYqRh+reFOixMCKDlVgkK3+ygn+hPloTuXitGmRCjgb9BP4iI
         H6XpQHtxPuf5m8RX9okqs3o+0ZBLor1MpEGkD89ikfH2KRpps4Z6oqHXC1mimZpic2OX
         l4e6++FWqBLhS0046eKHA1+LOaTAD+4T1ys8+wWxyQ6ZZ/bB1DvKNV0vwlpTpNS0jCag
         XRH1cJ1X9KH1sh9yVYVmcEumute2bz16uEndhVLHzYA5LvlWX5YOth7wjkAtAZC6TLHY
         0jtg==
X-Forwarded-Encrypted: i=1; AJvYcCX64ZcpkbyrBl2i2kB2vDeDOxSbpOtmRYFc5NKJn21gi0MexToKrTDaogCNw+lsBDZMWdJiSYhykSRJPZLa@vger.kernel.org
X-Gm-Message-State: AOJu0YzAYlVjQpBfCxF5dABTHjGVr0IasckQCIbP/wIkqQiwER3vbDCh
	D3jXnf8SgKsPm77tEIyCWYBwzzhMRQ3vCts/KHmNcBfyKuURHflx5i4pzM5YPP0=
X-Gm-Gg: ASbGncvOsid0hpOyw8ah2ajCNRgy6doW0dAEA7TRKOPa4AGoXK+XCvHb0a8KSOR6Exs
	NCuTVKIXpa40LimqY91TmKObobLMaqB9yFmLgxtf1QvronQXrNKVvYWUM/yQIeGV9tmgYJXC6dp
	UTyqaII4ybgdrf3tr2f6FXQF2iJ8WhhnIdRWw1OUN5zI3ifr/iwE5fTQczWQEFnsDXAmNap0AUV
	Pyb7z00P1VEtVn2R0M9XnUb7RK7WT6rD/J5XCVOSCrWugJVYW+Rq+zNOuwAFkaZvrnt0RhL74q3
	1VATEJOO5FFN8EuSICA=
X-Google-Smtp-Source: AGHT+IED6nFo6H074AJuhOtMYSXpOXdUkpmYhSpqQBdpa1JFuuWjqrALp7FNFtJ0H14tydVKaEmmfQ==
X-Received: by 2002:a17:90b:1910:b0:2ee:aed2:c15c with SMTP id 98e67ed59e1d1-2fa243e39bemr2068007a91.28.1738894245044;
        Thu, 06 Feb 2025 18:10:45 -0800 (PST)
Received: from [10.1.123.46] ([50.247.56.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36511846sm19816265ad.37.2025.02.06.18.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 18:10:44 -0800 (PST)
Message-ID: <53210a1a-973c-4e36-8955-4cb5bbf660d6@davidwei.uk>
Date: Thu, 6 Feb 2025 19:10:43 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Wei <dw@davidwei.uk>
Subject: Re: [LSF/MM/BPF TOPIC] FUSE io_uring zero copy
To: Ming Lei <ming.lei@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 Bernd Schubert <bschubert@ddn.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
 Joanne Koong <joannelkoong@gmail.com>
References: <dc3a5c7d-b254-48ea-9749-2c464bfd3931@davidwei.uk>
 <Z6LMpdbqiHSY5W9v@fedora>
Content-Language: en-GB
In-Reply-To: <Z6LMpdbqiHSY5W9v@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-02-04 18:27, Ming Lei wrote:
> Hello David,
> 
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
> Not sure get the point, it depends on if the kernel buffer is initialized,
> and you can't read data from one uninitialized kernel buffer.
> 
> But if it is userspace or device buffer, the limit may be relaxed.

When a client does a DIO write() to a FUSE filefd, the pages are pinned
by the kernel and then passed to FUSE kernel. It is possible to then
send these to the FUSE server, but it cannot read the data, only pass it
onwards.

> 
>>
>> My idea is to use shared memory or dma-buf, i.e. the source data is
>> encapsulated in an mmap()able fd. The client and FUSE server exchange
>> this fd through a back channel with no kernel involvement. The FUSE
>> server maps the fd into its address space and registers the fd with
> 
> This approach need client code modification, which isn't generic and
> can't cover existed posix applications.

Yes, the fd exchange is not POSIX. But we could encode the API using say
io_uring cmd if it is seen to be generically useful.

> 
> There could be too many client processes, does this way really scale?

For zero copy there is a cutover point where it performs better than
copying. The trade off is between memcpy and the overheads of setting up
zero copy. In this case, the client is required to be long lived and
ideally the same shmfd is shared across multiple transactions. So the
overhead is paid once and then amortised over multiple transactions.

> 
>> io_uring via the io_uring_register() infra. When the client does e.g. a
>> DIO write, the pages are pinned and forwarded to FUSE kernel, which does
> 
> BTW, fuse supports write zero copy already, just read zero copy isn't
> supported.

Could you clarify exactly which direction and how much of the data path
"zero copy" covers?

> 
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
> IMO, client code modification may not be accepted for existed applications.

That's up to userspace. I don't think we need to limit ourselves to "no
userspace code changes" or "POSIX only".

> 
> 
> Thanks,
> Ming
> 

