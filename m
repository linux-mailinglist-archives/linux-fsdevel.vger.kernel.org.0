Return-Path: <linux-fsdevel+bounces-70106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4CAC90B30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 04:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B853AACAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 03:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77D29D260;
	Fri, 28 Nov 2025 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N1b4EZr6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9D288C08
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764299258; cv=none; b=JYTySt6R+0r5ShaYEk4wf7sNQvXlLedntm6aTcUfO/UH9uwyeGTFgb5/Jtc7eBIqsS8XAR8GAkznvHLDqQ3AYyFq7Fq4HKkJ57zz4ysKHKjdcHKeIxtacc4Q7aPhUy9u5ijETubkRTgPjh/b/W6oQFPYiriR75cjhX86UHMtAio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764299258; c=relaxed/simple;
	bh=rDordQGhNOH5SttwVsuuKdo/CtICKy8hwBJCgwlGLs4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RuuCmy9msZXbKlq1elJG3gjuTuJvbsipiLe86teJHfVAqiNBknxolODzaxdyjpY2ZiAABNVIZwnORG8qWgkt6h8WVLL4oPEfbRQKtCQtUiGiwRjRy6dQ6bMThMSFyheI5aWkLcrFwUdhKnbHGc5o96KRWKOIMcTpssH3DJTIt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N1b4EZr6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477a1c28778so15118875e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 19:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764299254; x=1764904054; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpCyz/9P22tV8fDaOVWWRCa2r5LmOB5jCS8opHK9hyc=;
        b=N1b4EZr6U7VFQUwhlDFv2hWI8n1IYcUOhxtZ71F1HJ89xusJmAADdRxuQkSaPUlyEY
         QQk9CJaze+IEBl/UYOkUAlFQxe8LGH28y8fNilMWXwcX8aHgnmxzoHktohmXw2IaRJii
         oCHyKx/zBSZZOwPyYjIYt5GsBllRnh3yDiR9qrVXn6reUMeFA/gRwfzEnjn8anzILfRl
         LOIJOsjktHyzBL0soP+HwMBcKcdOWNk5pDOVwauf6biIr9w6Dqb48hy4rdyCYV7WhE48
         64/uH06vK3AC8kG7Q4Dbn61Kyi9iLGcZetzXW0ViA0fhif65Ct4/rjBzLf/P51KI8eJ3
         C0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764299254; x=1764904054;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpCyz/9P22tV8fDaOVWWRCa2r5LmOB5jCS8opHK9hyc=;
        b=p/jdXvhbuZ0MAlectNxT45DcrhxNVg6KVlRV4LZvnUMygtro4hF7Nuaa2FZQfH3kA2
         aaYu8Bo75umj4rMhSj5b5Q07Zd7DmQz8dOTxnOTvne1ci22J3oYYLHEw3+iRsXDgDzMe
         ei6fmUO6I2aaajT1bv8ESiaVWWlPq4xzMKDSUwtVYI0vvAG1qzDWc/1wsGvhkKjt3lTB
         Zin+w3FtpgVNGKIZ+STIkWPSTnv6Pte4h6H/9dHKEHU0nF9KwQIz7HjDQNyP+eLg7DQF
         zpV9BmptP5RBPxnELzHgjA+8BbPE8Yv3JLegQVMu6IJRRPrT0aETwrydhB0bn/fyYxW4
         ywpw==
X-Forwarded-Encrypted: i=1; AJvYcCUrfhBkqnxZTaTvxNapkAr1HauRGz56j8GS1iwD9a+qmuoFAUTZcWOTdIWRhvs1PwjpkG63mw9wJlPXFmdI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Cp1paN7BmHtOYa+ekpgnCdC2iE+3dM1aNy5g+U5njriUVEhY
	qmptn0DP7bVQMyk7YqqS8JpMQbKO7Mag9PO0wtRoXlqEGSnH/gJI0NprD9xguiK8Pw8=
X-Gm-Gg: ASbGncuaQppglLBfo94w89wFlciJdHbXwPighIBn1CFnvV+kgWMnU1EXpBc00qGzL+B
	eJO/e8mMQliaWl/QxmybngTtnioQkIuLWWhIsB1Tzr3kwx55fIE3gnYPOTxXGNi3DZKQpXr7YNS
	VSrEPESPVyNnxs5tDz6edxovPRmr1m9XT2uSdCAKb1gOEL+MFgeYSB5ytYlvq9uIHV/y3Jd8KV8
	Z+rKbkTZAsw0n+uZ/T7pNhUzbGLfrtKxfd6SH1RStaLL64tB66LVD0XE4Ret61noqPDAya0SzLW
	o/gMpcW6SVIbG8C02LTm2f3VKHenEjzPG7S9ioxWprFvS9fKuSNSqH5UCIvTs9RQrTb9817fbP6
	IJOdvSioQKxPY2/ys0MgHu7JYbQpp4bJ886Vll854Km8eRtL6VkLUGIdesiPf+/zf0hPmVyLYK9
	1WIAuUfC1aSadTwTLnGsN93TkfZGqfaZzb/FR0tgg=
X-Google-Smtp-Source: AGHT+IHMcASB0KggOCUf9K0Lv67abZ/TFhrn/fm384fDoQ/BBMYSeRFN7Xj4SPw5JzdQLsTyeb16kw==
X-Received: by 2002:a05:600c:6287:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-47904acae83mr108347555e9.1.1764299254468;
        Thu, 27 Nov 2025 19:07:34 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40ab6bsm29840775ad.21.2025.11.27.19.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 19:07:33 -0800 (PST)
Message-ID: <4c0c1d27-957c-4a6f-9397-47ca321b1805@suse.com>
Date: Fri, 28 Nov 2025 13:37:29 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 zfs-devel@list.zfsonlinux.org
From: Qu Wenruo <wqu@suse.com>
Subject: Ideas for RAIDZ-like design to solve write-holes, with larger fs
 block size
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

With the recent bs > ps support for btrfs, I'm wondering if it's 
possible to experiment some RAIDZ-like solutions to solve RAID56 
write-holes problems (at least for data COW cases) without traditional 
journal.

Currently my idea looks like this:

- Fixed and much smaller stripe data length
   Currently the data stripe length is fixed for all btrfs RAID profiles,
   64K.

   But will change to 4K (minimal and default) for RAIDZ chunks.

- Force a larger than 4K fs block size (or data io size)
   And that fs block size will determine how many devices we can use for
   a RAIDZ chunk.

   E.g. with 32K fs block size, and 4K stripe length, we can use 8
   devices for data, +1 for parity.
   But this also means, one has to have at least 9 devices to maintain
   the this scheme with 4K stripe length.
   (More is fine, less is not possible)


But there are still some uncertainty that I hope to get some feedback 
before starting coding on this.

- Conflicts with raid-stripe-tree and no zoned support
   I know WDC is working on raid-stripe-tree feature, which will support
   all profiles including RAID56 for data on zoned devices.

   And the feature can be used without zoned device.

   Although there is never RAID56 support implemented so far.

   Would raid-stripe-tree conflicts with this new RAIDZ idea, or it's
   better just wait for raid-stripe-tree?

- Performance
   If our stripe length is 4K it means one fs block will be split into
   4K writes into each device.

   The initial sequential write will be split into a lot of 4K sized
   random writes into the real disks.

   Not sure how much performance impact it will have, maybe it can be
   solved with proper blk plug?

- Larger fs block size or larger IO size
   If the fs block size is larger than the 4K stripe length, it means
   the data checksum is calulated for the whole fs block, and it will
   make rebuild much harder.

   E.g. fs block size is 16K, stripe length is 4K, and have 4 data
   stripes and 1 parity stripe.

   If one data stripe is corrupted, the checksum will mismatch for the
   whole 16K, but we don't know which 4K is corrupted, thus has to try
   4 times to get a correct rebuild result.

   Apply this to a whole disk, then rebuild will take forever...

   But this only requires extra rebuild mechanism for RAID chunks.


   The other solution is to introduce another size limit, maybe something
   like data_io_size, and for example using 16K data_io_size, and still
   4K fs block size, with the same 4K stripe length.

   So that every writes will be aligned to that 16K (a single 4K write
   will dirty the whole 16K range). And checksum will be calculated for
   each 4K block.

   Then reading the 16K we verify every 4K block, and can detect which
   block is corrupted and just repair that block.

   The cost will be the extra space spent saving 4x data checksum, and
   the extra data_io_size related code.


- Way more rigid device number requirement
   Everything must be decided at mkfs time, the stripe length, fs block
   size/data io size, and number of devices.

   Sure one can still add more devices than required, but it will just
   behave like more disks with RAID1.
   Each RAIDZ chunk will have fixed amount of devices.

   And furthermore, one can no longer remove devices below the minimal
   amount required by the RAIDZ chunks.
   If going with 16K blocksize/data io size, 4K stripe length, then it
   will always require 5 disks for RAIDZ1.
   Unless the end user gets rid of all RAIDZ chunks (e.g. convert
   to regular RAID1* or even SINGLE).

- Larger fs block size/data io size means higher write amplification
   That's the most obvious part, and may be less obvious higher memory
   pressure, and btrfs is already pretty bad at write-amplification.

   Currently page cache is relying on larger folios to handle those
   bs > ps cases, requiring more contigous physical memory space.

   And this limit will not go away even the end user choose to get
   rid of all RAIDZ chunks.


So any feedback is appreciated, no matter from end users, or even ZFS 
developers who invented RAIDZ in the first place.

Thanks,
Qu

