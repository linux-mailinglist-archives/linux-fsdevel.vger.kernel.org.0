Return-Path: <linux-fsdevel+bounces-32454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C82E9A5967
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 06:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2071C20CC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 04:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE9519938D;
	Mon, 21 Oct 2024 04:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="DvLE4SLp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03D2BB15
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729483584; cv=none; b=PwBQk5bbSfs0P89Y7aMaeJCFyS4O0KRtB1SENcTMe/JXYuIxTmqhUFZaHD1zvtVwyRkdAWnSYnK/87XsryAR3+8EwU9CFU2ZnV6b32p7BoQ5pKO+mWSPHbwn7aOByyfq8sC2AmAZi7+daW/x7lSZOyEyK3EW+XmXsZQfxlimw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729483584; c=relaxed/simple;
	bh=JY3VDCSJt6dsVa9Ba7wktraMc+CkhDXTN6FjudLw+Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgVUpYQa03tgHejKN9X97nPGdXqktPORf4mlfIfJgGeEh2uzSWU8ph71Qw/u+1d1wv2DrT91BSIIPrV4MXyar5XNpFQFiUz/u4IbSSBEJHP9p1iptX9qNVXtSQ5YQ7RPSAkq0yIuCB2qMQ3cdF/E4LWC2EpaKe7VfkEoURIn0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=DvLE4SLp; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-277e6002b7dso1369201fac.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Oct 2024 21:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1729483581; x=1730088381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+SOvE1LXr9Sxb0JRZUw0qYA4RKWSKM4BSSt0lCWJdoc=;
        b=DvLE4SLpEALAYE3U48rdUJcG7eNX3mcRo9x1o2dzOF7wy/PZ3w/PdrVAMUSD3UEOWG
         ma7fqOp8lfgOdyEkfAFTDUiqdkxQzab3e3MEDX2jlZH6TC6GrYzQjyxhE3xhGGzmsPb4
         D/pinbh8MJEq7e0WCQPfnYFqP4ld8EOmil7uOWWyJ48HfzR3v9+etRLvfxDdi5IHv1iK
         ilqiH1ZvBEyyyEiAmHVwglJDqzHcLWtCGi0aU61CxXJPVp9EC4C/LgWUyZHfbRnIhlRe
         qn+46yFdGGZMYlIzO3ketThyKXxriGB6z5zxhhQ5s+5KMj89iDrnuLvJLLCQqJGLB8/m
         J1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729483581; x=1730088381;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SOvE1LXr9Sxb0JRZUw0qYA4RKWSKM4BSSt0lCWJdoc=;
        b=hT6MIrvb/aWZ3RQksvwQDqH2z1cWOcHIsq+5ULGSKo++jrvXxK/8GJQsrRglUDqAQS
         INVBXMcvNMe6EAvWu8yzpElZlnG0FX6GnTVnMC5Dk6X8VPKLIzzASaV8i7FTidZmM9xL
         xqOJpkEe9yIOPDB6CKql6eXvG8A2+AMQ+MUjPrFgbgtZUvhXb27ehNIZgtMI24z27SIl
         tRmoPtMXflByn6qOkM/GPEDq4Q4p5+ALtp34+DLbPWbardxAcEHtJhreJ0mYEQ6WkKx9
         hpU6aX8/IZEMLyVFfa+cJ0C1fiYicquXQnWJOCZdOJO6V5OHztI1xRAbKYs0B0gW3e+E
         UAiw==
X-Forwarded-Encrypted: i=1; AJvYcCW//u6sPY5fLQubSxCnXxDVwooiaE+Q+Smynx+n+QOyMI4v8Zb3d4tQdOkjcFFzRng0vmWss0CMMN2H2Kia@vger.kernel.org
X-Gm-Message-State: AOJu0YzN8tkS7BeqbMuC8qnnp/L+pBFwTeHEaRpKSQKPd288/zcBovWd
	SgR0bFZaxBVjcVtfnhs7MHqJgIVu+sS4k1UpJLT016AELG0PYhXtzCOivTadAiA=
X-Google-Smtp-Source: AGHT+IEGIAm6NwEioPr92X4+JUJ/mqfOblef6gOLE+XED99+0Cy3/tTdoQ9fhjT5p2xFNyAUB5AioQ==
X-Received: by 2002:a05:6871:6ab:b0:288:5c55:dfd5 with SMTP id 586e51a60fabf-2892c544d6fmr8131966fac.31.1729483580764;
        Sun, 20 Oct 2024 21:06:20 -0700 (PDT)
Received: from [192.168.1.24] (174-21-168-99.tukw.qwest.net. [174.21.168.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1313988sm1893185b3a.22.2024.10.20.21.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 21:06:20 -0700 (PDT)
Message-ID: <38c76d27-1657-4f8c-9875-43839c8bbe80@davidwei.uk>
Date: Sun, 20 Oct 2024 21:06:18 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 00/15] fuse: fuse-over-io-uring
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, Amir Goldstein <amir73il@gmail.com>,
 Ming Lei <tom.leiming@gmail.com>, Josef Bacik <josef@toxicpanda.com>
References: <20241016-fuse-uring-for-6-10-rfc4-v4-0-9739c753666e@ddn.com>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20241016-fuse-uring-for-6-10-rfc4-v4-0-9739c753666e@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-10-15 17:05, Bernd Schubert wrote:
[...]
> 
> The corresponding libfuse patches are on my uring branch,
> but need cleanup for submission - will happen during the next
> days.
> https://github.com/bsbernd/libfuse/tree/uring
> 
> Testing with that libfuse branch is possible by running something
> like:
> 
> example/passthrough_hp -o allow_other --debug-fuse --nopassthrough \
> --uring --uring-per-core-queue --uring-fg-depth=1 --uring-bg-depth=1 \
> /scratch/source /scratch/dest
> 
> With the --debug-fuse option one should see CQE in the request type,
> if requests are received via io-uring:
> 
> cqe unique: 4, opcode: GETATTR (3), nodeid: 1, insize: 16, pid: 7060
>     unique: 4, result=104
> 
> Without the --uring option "cqe" is replaced by the default "dev"
> 
> dev unique: 4, opcode: GETATTR (3), nodeid: 1, insize: 56, pid: 7117
>    unique: 4, success, outsize: 120

Hi Bernd, I applied this patchset to io_uring-6.12 branch with some
minor conflicts. I'm running the following command:

$ sudo ./build/example/passthrough_hp -o allow_other --debug-fuse --nopassthrough \
--uring --uring-per-core-queue --uring-fg-depth=1 --uring-bg-depth=1 \
/home/vmuser/scratch/source /home/vmuser/scratch/dest
FUSE library version: 3.17.0
Creating ring per-core-queue=1 sync-depth=1 async-depth=1 arglen=1052672
dev unique: 2, opcode: INIT (26), nodeid: 0, insize: 104, pid: 0
INIT: 7.40
flags=0x73fffffb
max_readahead=0x00020000
   INIT: 7.40
   flags=0x4041f429
   max_readahead=0x00020000
   max_write=0x00100000
   max_background=0
   congestion_threshold=0
   time_gran=1
   unique: 2, success, outsize: 80

I created the source and dest folders which are both empty.

I see the following in dmesg:

[ 2453.197510] uring is disabled
[ 2453.198525] uring is disabled
[ 2453.198749] uring is disabled
...

If I then try to list the directory /home/vmuser/scratch:

$ ls -l /home/vmuser/scratch
ls: cannot access 'dest': Software caused connection abort

And passthrough_hp terminates.

My kconfig:

CONFIG_FUSE_FS=m
CONFIG_FUSE_PASSTHROUGH=y
CONFIG_FUSE_IO_URING=y

I'll look into it next week but, do you see anything obviously wrong?

