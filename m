Return-Path: <linux-fsdevel+bounces-30155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 772859871ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 12:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7609B2A8C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF90E1AD401;
	Thu, 26 Sep 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eYR8Jsqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1701F95C;
	Thu, 26 Sep 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347610; cv=none; b=lPSSOyb07qTucZBypmHI/oaw+6mMK8qKFn2doDvjOJ1y1k6WITRpPwLSw47AOAeO9mllQZ4gYp+wqL8ApXwir1ECQGsUTwer1dz+oi8IzVNtwtrq5TqOuQaSzW/mAwEMIh7ccMp9iq/L2s41V4DO85Iw+OK44tSVBJ9l3FtnPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347610; c=relaxed/simple;
	bh=c/eI5nnfbeDwNzWVyrDZhox1VEloJsRrqMJnVR48mnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTSN3iv0IxratFig5rASLaY6k4VLvFLpkg6TXV6B05LtMIXp2In3NtZG/udjA3tRddO3onv6cRSAQ4rhseKPyloT3p8cIYnZMa7JPUOkfZ6/HFjAiI+ZqztuXYu8kozP5o6fl8lvk7CUb9aynACx1FxlhkDN1HM/ntYAxdtltGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eYR8Jsqq; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727347597; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HAfK9a+C2cwA67W9H+QW9yoB06NuG9+8CGbAb5+/yLQ=;
	b=eYR8Jsqq9Wj8qR1qPDC9639NInmTM8LCU98vq2XiAW0yczkmG+pHv/gE3mYquCkZCnRh273Dnl/ztzV6M5P3APM3UNkNJgIa9NDor+IYlybnvKevJM64Sni80bvph2aWA+bzocJj4VHPrdGLwcBGv4zuBcL7apaHuzllOQ7XSpc=
Received: from 30.221.129.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFn33Oz_1727347595)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 18:46:36 +0800
Message-ID: <5f5e006b-d13b-45a5-835d-57a64d450a1a@linux.alibaba.com>
Date: Thu, 26 Sep 2024 18:46:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>
Cc: Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Gary Guo <gary@garyguo.net>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
 <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
 <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/26 17:51, Ariel Miculas wrote:
> On 24/09/26 04:25, Gao Xiang wrote:
>>
>>
>> On 2024/9/26 16:10, Ariel Miculas wrote:
>>> On 24/09/26 09:04, Gao Xiang wrote:
>>>>
>>
>>
>> ...
>>
>>>
>>> And here [4] you can see the space savings achieved by PuzzleFS. In
>>> short, if you take 10 versions of Ubuntu Jammy from dockerhub, they take
>>> up 282 MB. Convert them to PuzzleFS and they only take up 130 MB (this
>>> is before applying any compression, the space savings are only due to
>>> the chunking algorithm). If we enable compression (PuzzleFS uses Zstd
>>> seekable compression), which is a fairer comparison (considering that
>>> the OCI image uses gzip compression), then we get down to 53 MB for
>>> storing all 10 Ubuntu Jammy versions using PuzzleFS.
>>>
>>> Here's a summary:
>>> # Steps
>>>
>>> * I’ve downloaded 10 versions of Jammy from hub.docker.com
>>> * These images only have one layer which is in tar.gz format
>>> * I’ve built 10 equivalent puzzlefs images
>>> * Compute the tarball_total_size by summing the sizes of every Jammy
>>>     tarball (uncompressed) => 766 MB (use this as baseline)
>>> * Sum the sizes of every oci/puzzlefs image => total_size
>>> * Compute the total size as if all the versions were stored in a single
>>>     oci/puzzlefs repository => total_unified_size
>>> * Saved space = tarball_total_size - total_unified_size
>>>
>>> # Results
>>> (See [5] if you prefer the video format)
>>>
>>> | Type | Total size (MB) | Average layer size (MB) | Unified size (MB) | Saved (MB) / 766 MB |
>>> | --- | --- | --- | --- | --- |
>>> | Oci (uncompressed) | 766 | 77 | 766 | 0 (0%) |
>>> | PuzzleFS uncompressed | 748 | 74 | 130 | 635 (83%) |
>>> | Oci (compressed) | 282 | 28 | 282 | 484 (63%) |
>>> | PuzzleFS (compressed) | 298 | 30 | 53 | 713 (93%) |
>>>
>>> Here's the script I used to download the Ubuntu Jammy versions and
>>> generate the PuzzleFS images [6] to get an idea about how I got to these
>>> results.
>>>
>>> Can we achieve these results with the current erofs features?  I'm
>>> referring specifically to this comment: "EROFS already supports
>>> variable-sized chunks + CDC" [7].
>>
>> Please see
>> https://erofs.docs.kernel.org/en/latest/comparsion/dedupe.html
> 
> Great, I see you've used the same example as I did. Though I must admit
> I'm a little surprised there's no mention of PuzzleFS in your document.

Why I need to mention and even try PuzzleFS here (there are too many
attempts why I need to try them all)?  It just compares to the EROFS
prior work.

> 
>>
>> 	                Total Size (MiB)	Average layer size (MiB)	Saved / 766.1MiB
>> Compressed OCI (tar.gz)	282.5	28.3	63%
>> Uncompressed OCI (tar)	766.1	76.6	0%
>> Uncomprssed EROFS	109.5	11.0	86%
>> EROFS (DEFLATE,9,32k)	46.4	4.6	94%
>> EROFS (LZ4HC,12,64k)	54.2	5.4	93%
>>
>> I don't know which compression algorithm are you using (maybe Zstd?),
>> but from the result is
>>    EROFS (LZ4HC,12,64k)  54.2
>>    PuzzleFS compressed   53?
>>    EROFS (DEFLATE,9,32k) 46.4
>>
>> I could reran with EROFS + Zstd, but it should be smaller. This feature
>> has been supported since Linux 6.1, thanks.
> 
> The average layer size is very impressive for EROFS, great work.
> However, if we multiply the average layer size by 10, we get the total
> size (5.4 MiB * 10 ~ 54.2 MiB), whereas for PuzzleFS, we see that while
> the average layer size is 30 MIB (for the compressed case), the unified
> size is only 53 MiB. So this tells me there's blob sharing between the
> different versions of Ubuntu Jammy with PuzzleFS, but there's no sharing
> with EROFS (what I'm talking about is deduplication across the multiple
> versions of Ubuntu Jammy and not within one single version).

Don't make me wrong, I don't think you got the point.

First, what you asked was `I'm referring specifically to this
comment: "EROFS already supports variable-sized chunks + CDC"`,
so I clearly answered with the result of compressed data global
deduplication with CDC.

Here both EROFS and Squashfs compresses 10 Ubuntu images into
one image for fair comparsion to show the benefit of CDC, so
I believe they basically equal to your `Unified size`s, so
the result is

			Your unified size
	EROFS (LZ4HC,12,64k)  54.2
	PuzzleFS compressed   53?
	EROFS (DEFLATE,9,32k) 46.4

That is why I used your 53 unified size to show EROFS is much
smaller than PuzzleFS.

The reason why EROFS and SquashFS doesn't have the `Total Size`s
is just because we cannot store every individual chunk into some
seperate file.

Currently, I have seen no reason to open arbitary kernel files
(maybe hundreds due to large folio feature at once) in the page
fault context.  If I modified `mkfs.erofs` tool, I could give
some similar numbers, but I don't want to waste time now due
to `open arbitary kernel files in the page fault context`.

As I said, if PuzzleFS finally upstream some work to open kernel
files in page fault context, I will definitely work out the same
feature for EROFS soon, but currently I don't do that just
because it's very controversal and no in-tree kernel filesystem
does that.

Thanks,
Gao Xiang

