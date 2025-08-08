Return-Path: <linux-fsdevel+bounces-57164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D897B1F09F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 00:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B27165126
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 22:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5DF2727E1;
	Fri,  8 Aug 2025 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KNljQvnm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD5219E8D
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754691113; cv=none; b=cv1PPgQRt7U6GSqwXbBWIxV5kftRkIEBnu/FbylA8cjJ8teCjCTTUzXuDOXZ7z17BQHi57HKDxmkn2n5paqpKEHX5dm15B9M4XJxKkuToJh0BG6a0ZlvVCKYngsMp71QTsE5ATUC2YAEz3dVan3mA20566ORbnfcblHxa7jcGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754691113; c=relaxed/simple;
	bh=sPot/QiJGx0ie2GqPuzcKoCFOI60aOBXfDEt5ep6Kl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Va4BOOK2sKe9EPcgR/cQBKiiaLLQdcfyMeVNI25oXCyKc2kZ4Md5VU3+weSKiH0EsY80ACxHqxrZXzYcCMhDiwJWq/AqQNEdOBYJ/6ArszUBQ0n+9b9pTWmZo1/YZTcxXgQGkhxorcJyGFMjwBdf+R52VOFS+auTPhE64WStmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KNljQvnm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b785a69454so1462106f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754691108; x=1755295908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vfp4XJviTGuQNIDYxaXXZY38lwfZr5BPome6oUUC1Fw=;
        b=KNljQvnmNTVxXm3LkWBnKj1BOzOvTLrIFWhq40frLzqh0T0/jP2KK3EXMCb1xv1U2b
         6EzEVczFRSQ1a9ffbcnjWBouU3i2/6NmrTGxskcNZRGLmlPv3zz9Iv57z/+KazvKzmsO
         tPtHk7HytvbZSuCE/1eDq0xDbkG+iBObQoyyhZTDwjn5kM+t6BWNeGgKMCi0+BoBYW8B
         i0M38+zmZyPtKdB/bJ49cVxc7htRhVcVNqRGeY2107pBpPST4R4twnheYy06uZ0iP0Bc
         TXuR+NQo25wR/OvymkiLYp99jBRZt/ikXyGQXc0V+I9s0u26gKnm77GckjlJ9ELEUeOa
         W45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754691108; x=1755295908;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfp4XJviTGuQNIDYxaXXZY38lwfZr5BPome6oUUC1Fw=;
        b=BMnqTyM2wxDyyPQmQoYs+QzaRW4xmAEMj4p9Z/kdH0kQKmHwBBUA4h6CUJ1mhAbfz3
         dR553aHIYDftVyY2NZj6Tt0lmu/7kUUiDZE3yMCCo2KREjRpqOdHNe36c+p6Bz8FfR1O
         7USIxRqsDQcN4ijkWTKRHdRS8YvUNsMhFJfWlziqfWz76C/RJAJfSuUp6A3DM1AChr/x
         tUH0NWSJ5DA61VnKdxR50l5JquLVkOpDH6OOdSRKuD1sAEdeUGvuK2mFseSg5Z8Ahf5I
         ZlrQxi1XFYIy5Wo7rGE5qRSPN/Vg2eW9TJ9Jb7FCMu2UKSdO/O1avNlMU1tTSN33vAVn
         tv3g==
X-Forwarded-Encrypted: i=1; AJvYcCVYzSBPe/43M+DcqXVpv1+VQGFkIo2Q5MfkqJa5iIXS/CtEJvAepCsU7gbIY5SYM4I2R7FuTJFNmPKqmh5P@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/Rgb8JfGl8+59/ctf2AXhtIU2a5DaKYH48JPkqY9yq+NxOc+
	LlOM/71Gv1w48l8Cq52SFVyKk2c/AbbG09320XwNCdfA6T5EWrnXAOTUlFe5pKq5IA0=
X-Gm-Gg: ASbGnctttJpsv1kmJuOAnii+DYJX44I8Sn7B/t05Rw/riY3sM24hbYo0H/33/qgObb7
	e0K7MpJDUzMKMLQ5Kolv1UPRHAw9maQ9IE5jWQyOwsyYw5jxStxqWK6Rl8N9r9+TiSQs+r5Iu26
	zu6+jwB1Y5JFRqFqZG6voddiCi8lbbexAC0ZbjsXAsI/G8vM9dOwpo1Xt/oa7oaXWjtCqYOrDnD
	JoHabC/48Hm916OD2y7NRthkum1Xvsj/Z+2Z/vJpSaWkCxh5EjOZZmeCRYxYYbyBHbekw4cQrg2
	m/MN6vpskX3JfAInQlLqXD8mLBJhcwbFyGfddX9fmVq7YU9inC7KJ20Q3Lkp4i4pBFu2/QENFcT
	3xC9YrboDdgIJjkHSTRguyodZ5g3MV1QYR1ruAMnTB2ylF3TF3rYii8VSM64n
X-Google-Smtp-Source: AGHT+IFIxLKMLKj0aUzzhwq3MMNuW4vixZGGnupJ71Z/AHI1G3sTObVSeFAVOad94beA9NPbKPu3+g==
X-Received: by 2002:a05:6000:1ac6:b0:3b7:7749:aa92 with SMTP id ffacd0b85a97d-3b900b6ab1emr3552969f8f.58.1754691108438;
        Fri, 08 Aug 2025 15:11:48 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm21219043b3a.42.2025.08.08.15.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 15:11:47 -0700 (PDT)
Message-ID: <035ad34e-fb1e-414f-8d3c-839188cfa387@suse.com>
Date: Sat, 9 Aug 2025 07:41:43 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ext4 iomap warning during btrfs/136 (yes, it's from btrfs test
 cases)
To: Theodore Ts'o <tytso@mit.edu>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <9b650a52-9672-4604-a765-bb6be55d1e4a@gmx.com>
 <4ef2476f-50c3-424d-927d-100e305e1f8e@gmx.com>
 <20250808121659.GC778805@mit.edu>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <20250808121659.GC778805@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/8 21:46, Theodore Ts'o 写道:
> On Fri, Aug 08, 2025 at 06:20:56PM +0930, Qu Wenruo wrote:
>>
>> 在 2025/8/8 17:22, Qu Wenruo 写道:
>>> Hi,
>>>
>>> [BACKGROUND]
>>> Recently I'm testing btrfs with 16KiB block size.
>>>
>>> Currently btrfs is artificially limiting subpage block size to 4K.
>>> But there is a simple patch to change it to support all block sizes <=
>>> page size in my branch:
>>>
>>> https://github.com/adam900710/linux/tree/larger_bs_support
>>>
>>> [IOMAP WARNING]
>>> And I'm running into a very weird kernel warning at btrfs/136, with 16K
>>> block size and 64K page size.
>>>
>>> The problem is, the problem happens with ext3 (using ext4 modeule) with
>>> 16K block size, and no btrfs is involved yet.
> 
> 
> Thanks for the bug report!  This looks like it's an issue with using
> indirect block-mapped file with a 16k block size.  I tried your
> reproducer using a 1k block size on an x86_64 system, which is how I
> test problem caused by the block size < page size.  It didn't
> reproduce there, so it looks like it really needs a 16k block size.
> 
> Can you say something about what system were you running your testing
> on --- was it an arm64 system, or a powerpc 64 system (the two most
> common systems with page size > 4k)?  (I assume you're not trying to
> do this on an Itanic.  :-)   And was the page size 16k or 64k?

The architecture is aarch64, the host board is Rock5B (cheap and fast 
enough), the test machine is a VM on that board, with ovmf as the UEFI 
firmware.

The kernel is configured to use 64K page size, the *ext3* system is 
using 16K block size.

Currently I tried the following combination with 64K page size and ext3, 
the result looks like the following

- 2K block size
- 4K block size
   All fine

- 8K block size
- 16K block size
   All the same kernel warning and never ending fsstress

- 32K block size
- 64K block size
   All fine

I am surprised as you that, not all subpage block size are having 
problems, just 2 of the less common combinations failed.

And the most common ones (4K, page size) are all fine.

Finally, if using ext4 not ext3, all combinations above are fine again.

So I ran out of ideas why only 2 block sizes fail here...

Thanks,
Qu

> 
> Thanks,
> 
> 					- Ted
> 


