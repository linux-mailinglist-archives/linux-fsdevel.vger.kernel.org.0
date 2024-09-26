Return-Path: <linux-fsdevel+bounces-30157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9DC987253
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 13:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDAF7B28E65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CFC1AE867;
	Thu, 26 Sep 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZwKdOoMi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E221AD402;
	Thu, 26 Sep 2024 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727348716; cv=none; b=Js6I4n1GF0jOAnBaxBMAzh72PC6vS2Oadm3vQLbNOWkxEXQLP6XRfWLDYm/v7muTjj6QUTayy+LkO/xtqxyYZ90YCxqAbZWhXili/3PmlHWK/LjOArh4HmcNbfVnkid2ZzIk8Hf/y4lajf1gWMMrr7wP0p/utqdSHX4aRKSvVxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727348716; c=relaxed/simple;
	bh=bkJC81GBHAErkhha5D68RQjOHRXZVAxhw5Z1FSzxMwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfKk7R0r0ViLFDZTUAi7K/MJrGPVEPwja0vNu/SPd/eFqJY/O9u4aDSU4Kmm/E7jjxrDAUvWmzKPm85v03u7+xDKo68GiBF/jwS280/jPDB+f0IavmbYrqKtgDL0fk7S1i1MsYZaepk89DT0HA6I5z8snZZkaY8mlifvjYgSA6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZwKdOoMi; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727348704; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aHeUnsZb95rwTMK+/+jFnDz4f7VKp5e98rBcltas9nc=;
	b=ZwKdOoMi/A/KQLMkgyk4V+gVJbPvUxLUd2Fnf3cL19PNOtcSLyFgOeRa5d9hS67M7ovGeXY/Id4z+jVVSfjVzqqgSE4qZWNjnxwLS8hvX0zOMyNP8pWHzNRy0GoSciGPbFQZl3E92jXjPITJT7Of5Bw77kxFY1FcFzpSHUBAoaE=
Received: from 30.221.129.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFnDrBz_1727348703)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 19:05:03 +0800
Message-ID: <b89eec22-e79e-41a1-af0c-7d1251a5f0c3@linux.alibaba.com>
Date: Thu, 26 Sep 2024 19:05:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>
Cc: Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Benno Lossin <benno.lossin@proton.me>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
References: <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
 <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
 <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
 <5f5e006b-d13b-45a5-835d-57a64d450a1a@linux.alibaba.com>
 <20240926110151.52cuuidfpjtgwnjd@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240926110151.52cuuidfpjtgwnjd@amiculas-l-PF3FCGJH>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/26 19:01, Ariel Miculas wrote:

..

> 
>> I believe they basically equal to your `Unified size`s, so
>> the result is
>>
>> 			Your unified size
>> 	EROFS (LZ4HC,12,64k)  54.2
>> 	PuzzleFS compressed   53?
>> 	EROFS (DEFLATE,9,32k) 46.4
>>
>> That is why I used your 53 unified size to show EROFS is much
>> smaller than PuzzleFS.
>>
>> The reason why EROFS and SquashFS doesn't have the `Total Size`s
>> is just because we cannot store every individual chunk into some
>> seperate file.
> 
> Well storing individual chunks into separate files is the entire point
> of PuzzleFS.
> 
>>
>> Currently, I have seen no reason to open arbitary kernel files
>> (maybe hundreds due to large folio feature at once) in the page
>> fault context.  If I modified `mkfs.erofs` tool, I could give
>> some similar numbers, but I don't want to waste time now due
>> to `open arbitary kernel files in the page fault context`.
>>
>> As I said, if PuzzleFS finally upstream some work to open kernel
>> files in page fault context, I will definitely work out the same
>> feature for EROFS soon, but currently I don't do that just
>> because it's very controversal and no in-tree kernel filesystem
>> does that.
> 
> The PuzzleFS kernel filesystem driver is still in an early POC stage, so
> there's still a lot more work to be done.

I suggest that you could just ask FS/MM folks about this ("open
kernel files when reading in the page fault")  first.

If they say "no", I suggest please don't waste on this anymore.

Thanks,
Gao Xiang

> 
> Regards,
> Ariel
> 
>>
>> Thanks,
>> Gao Xiang


