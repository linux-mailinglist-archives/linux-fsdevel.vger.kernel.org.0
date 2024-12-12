Return-Path: <linux-fsdevel+bounces-37182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EC39EEE0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92773188C4F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B59F21E0AE;
	Thu, 12 Dec 2024 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RFEH025H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F9B225A5B
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018406; cv=none; b=ZyIZ9yNH1NJNe8YokohS8WA1lhAOypb2yL4NBGLntNm7dC7AeT3amqWW7YniCTvqMtq6bcLnlBLe4oDfAIgRZDqf8ULYh5uzUnop4YNFIRyltgWfqdKXWrtp7KAF97VJwOdO+e15ye8cwySGbSdAO+ku1VgAwoafdBn0t2ZfXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018406; c=relaxed/simple;
	bh=Ac/lH1N8Vwnk3NvD4ByTPUBIHOz/Uhxzw21Ss9+dQoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYJaTc6aI9ghPobMezfSsDSb6UVIcmCYWdFFtdTyQ1KZxVx0WThmKaV33DN2fGM/jSGq6pRiT1XFwKNReyFgccr5Bjh/4eUvt6tFC2j1D8tM70edL5j7k33Dow5QByPN3O8LzxVYCVQDOXXXJ9awmgYc9UYKyCfANH0S+DtlxJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RFEH025H; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8442ec2adc7so26349539f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 07:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734018403; x=1734623203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tO8UEzJ4vRcwe2Pe8Itytncx4R9qJI/GK3O9fbQd828=;
        b=RFEH025H2ZIDuJmmbq+qp1qKV9wrEseWZpu5O/kvEWFv/e1g8rXhAHtOdJfSeanNAi
         rZoyQFjTSjGlmV0BZS7TC5/OUiAOeIwDAe23ektmVORCZy5DVhyzXy7emiK3gX4VCn9q
         r8wHwmx9NErjjKLLH01scm6kdg47wvi0sy4xsThunDREHOfKL8bcE83Itcfey4OeuMSl
         jc/lbWHEg3BC++Su8gLGllq3bHIjvmp3Ui4dMHu4zTsEXVPMFdCc0M0wt3SkGWYkiaG2
         uH3P9UF46xqt5awlHa71wh3Ja2lfXERKY4q9ATTwm/pWWHtAG1vs6Bvg+4Z/yURl8hM8
         znIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018403; x=1734623203;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tO8UEzJ4vRcwe2Pe8Itytncx4R9qJI/GK3O9fbQd828=;
        b=t+BfMcTXR+6sfySLQC78AJ4Z8NDOz/BFrvTWOMAhUcUdXUWjcJfGflWpiCEZ7Hld9q
         Ltggmz7GMs9A9VFevBbd7ppmqgNiaXB468WUkyjoY+vUiiQpmcIIqDGtHuQnwn8+IP7P
         b3o/1qxuudh8s0ZW9xRVGYGh2rva0uW1VNfpXotMQlhTgqfOI/1BogfKQTOINh090Pxz
         8VOGmlv8e2A8r/4SkSGEQsiBx1hNjMAMFHE/qYJ8PnjQHJLUHtvhRf8jaC1rb1k/VW2V
         jPkkKB7qs+XiTw6qhgTsCem6Fok0z6uHutjJDmXftPNheDmrMiWQYtPZ7BaQDUr6f4cc
         1sfw==
X-Forwarded-Encrypted: i=1; AJvYcCXT/yeyQgsPDq6bcVVmT5YYR+Gn/y8PgPDK5aYJEtFO2IoZ4GAmacMlEuE1zta2qVQ60Zzwwhtp6Tux5h0d@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8tOcWYE5UvU+2sUVxMtsGnFc3xk7odlC3AXtppNFN7SMBqbQy
	6ltzqcu/GQxlZ4Hw83xAXRN447qG501K7P3yIPiGaEhSZNcLaAz/jDacV6WI3lM=
X-Gm-Gg: ASbGncueH+lJ37U4SpUhkxZcfBil4WkyBzsajqtvp35YAV4jTltFTTfcstHsHlcb/G0
	FWilAFGBa9ziwsvmiQEJWaZckDyrz7B3cQ/mNOJgqLhH7nU4PMqFEpoiJ9dFQKOj8sDuEhyTuq4
	IS9n//lC1qOXZRsoESngpaRdZ3kxbgfD31gXFzwjmvxpN6VXldlGp8BkAxTCoJhmEmxaOuFy6aI
	0BXL2/TGy7JZkzYhHkXqWsGxy7NOmZs25j8cc4k0fbSI4jF6WJC
X-Google-Smtp-Source: AGHT+IEWOOfyZauproNpLzyqbWskkA8C5m2JWmRRDzC2lEgVYvSQEsLpIBT1S8N7zYh/eZTxtW0sVQ==
X-Received: by 2002:a05:6602:3404:b0:843:eca9:a050 with SMTP id ca18e2360f4ac-844e560bb23mr72779339f.1.1734018403424;
        Thu, 12 Dec 2024 07:46:43 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844d44183d4sm66027039f.51.2024.12.12.07.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:46:42 -0800 (PST)
Message-ID: <6e6475c2-7a5f-4742-b4ae-e1eef5f2c508@kernel.dk>
Date: Thu, 12 Dec 2024 08:46:41 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
To: Bharata B Rao <bharata@amd.com>
Cc: bfoster@redhat.com, clm@meta.com, hannes@cmpxchg.org,
 kirill@shutemov.name, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241210094842.204504-1-bharata@amd.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20241210094842.204504-1-bharata@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 2:48 AM, Bharata B Rao wrote:
> Hi Jens,
> 
> I ran a couple of variants of FIO to check how this patchset affects the
> FIO numbers. My other motivation with this patchset is to check if it
> improves the scalability issues that were discussed in [1] and [2].
> But for now, here are some initial numbers.

Thanks for testing!

> Also note that I am using your buffered-uncached.8 branch from
> https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.8 that has
> changes to enable uncached buffered IO for EXT4 and block devices.
> 
> In the below reported numbers,
> 'base' means kernel from buffered-uncached.8 branch and
> 'patched' means kernel from buffered-uncached.8 branch + above shown FIO change
> 
> FIO on EXT4 partitions
> ======================
> nvme1n1     259:12   0   3.5T  0 disk 
> ??nvme1n1p1 259:13   0 894.3G  0 part /mnt1
> ??nvme1n1p2 259:14   0 894.3G  0 part /mnt2
> ??nvme1n1p3 259:15   0 894.3G  0 part /mnt3
> ??nvme1n1p4 259:16   0 894.1G  0 part /mnt4
> 
> fio -directory=/mnt4/ -direct=0 -thread -size=3G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
> fio -directory=/mnt3/ -direct=0 -thread -size=3G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
> fio -directory=/mnt1/ -direct=0 -thread -size=3G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
> fio -directory=/mnt2/ -direct=0 -thread -size=3G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
> 
> Four NVME devices are formatted with EXT4 and four parallel FIO instances
> are run on them with the options as shown above.
> 
> FIO output looks like this:
> 
> base:
>    READ: bw=1233MiB/s (1293MB/s), 1233MiB/s-1233MiB/s (1293MB/s-1293MB/s), io=4335GiB (4654GB), run=3600097-3600097msec
>   WRITE: bw=529MiB/s (554MB/s), 529MiB/s-529MiB/s (554MB/s-554MB/s), io=1858GiB (1995GB), run=3600097-3600097msec
>    READ: bw=1248MiB/s (1308MB/s), 1248MiB/s-1248MiB/s (1308MB/s-1308MB/s), io=4387GiB (4710GB), run=3600091-3600091msec
>   WRITE: bw=535MiB/s (561MB/s), 535MiB/s-535MiB/s (561MB/s-561MB/s), io=1880GiB (2019GB), run=3600091-3600091msec
>    READ: bw=1235MiB/s (1294MB/s), 1235MiB/s-1235MiB/s (1294MB/s-1294MB/s), io=4340GiB (4660GB), run=3600094-3600094msec
>   WRITE: bw=529MiB/s (555MB/s), 529MiB/s-529MiB/s (555MB/s-555MB/s), io=1860GiB (1997GB), run=3600094-3600094msec
>    READ: bw=1234MiB/s (1294MB/s), 1234MiB/s-1234MiB/s (1294MB/s-1294MB/s), io=4337GiB (4657GB), run=3600093-3600093msec
>   WRITE: bw=529MiB/s (554MB/s), 529MiB/s-529MiB/s (554MB/s-554MB/s), io=1859GiB (1996GB), run=3600093-3600093msec
> 
> patched:
>    READ: bw=1400MiB/s (1469MB/s), 1400MiB/s-1400MiB/s (1469MB/s-1469MB/s), io=4924GiB (5287GB), run=3600100-3600100msec
>   WRITE: bw=600MiB/s (629MB/s), 600MiB/s-600MiB/s (629MB/s-629MB/s), io=2110GiB (2266GB), run=3600100-3600100msec
>    READ: bw=1395MiB/s (1463MB/s), 1395MiB/s-1395MiB/s (1463MB/s-1463MB/s), io=4904GiB (5266GB), run=3600148-3600148msec
>   WRITE: bw=598MiB/s (627MB/s), 598MiB/s-598MiB/s (627MB/s-627MB/s), io=2102GiB (2257GB), run=3600148-3600148msec
>    READ: bw=1385MiB/s (1452MB/s), 1385MiB/s-1385MiB/s (1452MB/s-1452MB/s), io=4868GiB (5227GB), run=3600136-3600136msec
>   WRITE: bw=594MiB/s (622MB/s), 594MiB/s-594MiB/s (622MB/s-622MB/s), io=2087GiB (2241GB), run=3600136-3600136msec
>    READ: bw=1376MiB/s (1443MB/s), 1376MiB/s-1376MiB/s (1443MB/s-1443MB/s), io=4837GiB (5194GB), run=3600145-3600145msec
>   WRITE: bw=590MiB/s (618MB/s), 590MiB/s-590MiB/s (618MB/s-618MB/s), io=2073GiB (2226GB), run=3600145-3600145msec
> 
> FIO on block devices
> ====================
> nvme1n1     259:12   0   3.5T  0 disk 
> ??nvme1n1p1 259:13   0 894.3G  0 part 
> ??nvme1n1p2 259:14   0 894.3G  0 part 
> ??nvme1n1p3 259:15   0 894.3G  0 part 
> ??nvme1n1p4 259:16   0 894.1G  0 part 
> 
> fio -filename=/dev/nvme1n1p4 -direct=0 -thread -size=800G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
> fio -filename=/dev/nvme1n1p2 -direct=0 -thread -size=800G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
> fio -filename=/dev/nvme1n1p1 -direct=0 -thread -size=800G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
> fio -filename=/dev/nvme1n1p3 -direct=0 -thread -size=800G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
> 
> Four instances of FIO are run on four different NVME block devices
> with the options as shown above.
> 
> base:
>    READ: bw=8712MiB/s (9135MB/s), 8712MiB/s-8712MiB/s (9135MB/s-9135MB/s), io=29.9TiB (32.9TB), run=3600011-3600011msec
>   WRITE: bw=3734MiB/s (3915MB/s), 3734MiB/s-3734MiB/s (3915MB/s-3915MB/s), io=12.8TiB (14.1TB), run=3600011-3600011msec
>    READ: bw=8727MiB/s (9151MB/s), 8727MiB/s-8727MiB/s (9151MB/s-9151MB/s), io=30.0TiB (32.9TB), run=3600005-3600005msec
>   WRITE: bw=3740MiB/s (3922MB/s), 3740MiB/s-3740MiB/s (3922MB/s-3922MB/s), io=12.8TiB (14.1TB), run=3600005-3600005msec
>    READ: bw=8701MiB/s (9123MB/s), 8701MiB/s-8701MiB/s (9123MB/s-9123MB/s), io=29.9TiB (32.8TB), run=3600004-3600004msec
>   WRITE: bw=3729MiB/s (3910MB/s), 3729MiB/s-3729MiB/s (3910MB/s-3910MB/s), io=12.8TiB (14.1TB), run=3600004-3600004msec
>    READ: bw=8706MiB/s (9128MB/s), 8706MiB/s-8706MiB/s (9128MB/s-9128MB/s), io=29.9TiB (32.9TB), run=3600005-3600005msec
>   WRITE: bw=3731MiB/s (3913MB/s), 3731MiB/s-3731MiB/s (3913MB/s-3913MB/s), io=12.8TiB (14.1TB), run=3600005-3600005msec
> 
> patched:
>    READ: bw=1844MiB/s (1933MB/s), 1844MiB/s-1844MiB/s (1933MB/s-1933MB/s), io=6500GiB (6980GB), run=3610641-3610641msec
>   WRITE: bw=790MiB/s (828MB/s), 790MiB/s-790MiB/s (828MB/s-828MB/s), io=2786GiB (2991GB), run=3610642-3610642msec
>    READ: bw=1753MiB/s (1838MB/s), 1753MiB/s-1753MiB/s (1838MB/s-1838MB/s), io=6235GiB (6695GB), run=3641973-3641973msec
>   WRITE: bw=751MiB/s (788MB/s), 751MiB/s-751MiB/s (788MB/s-788MB/s), io=2672GiB (2869GB), run=3641969-3641969msec
>    READ: bw=1078MiB/s (1130MB/s), 1078MiB/s-1078MiB/s (1130MB/s-1130MB/s), io=3788GiB (4068GB), run=3600007-3600007msec
>   WRITE: bw=462MiB/s (484MB/s), 462MiB/s-462MiB/s (484MB/s-484MB/s), io=1624GiB (1743GB), run=3600007-3600007msec
>    READ: bw=1752MiB/s (1838MB/s), 1752MiB/s-1752MiB/s (1838MB/s-1838MB/s), io=6234GiB (6694GB), run=3642657-3642657msec
>   WRITE: bw=751MiB/s (788MB/s), 751MiB/s-751MiB/s (788MB/s-788MB/s), io=2672GiB (2869GB), run=3642622-3642622msec
> 
> While FIO on FS shows improvement, FIO on block shows numbers going down.
> Is this expected or am I missing enabling anything else for the block option?

The fs side looks as expected, that's a nice win. For the bdev side, I
deliberately did not post the bdev patch for enabling uncached buffered
IO on a raw block device, as it's just a hack for testing. It currently
needs punting similar to dirtying of pages, and it's not optimized at
all. We really need the raw bdev ops moving fully to iomap and not being
dependent on buffer_heads for this to pan out, so the most likely
outcome here is that raw bdev uncached buffered IO will not really be
supported until the time that someone (probably Christoph) does that
work.

I don't think this is a big issue, can't imagine buffered IO on raw
block devices being THAT interesting of a use case.

-- 
Jens Axboe

