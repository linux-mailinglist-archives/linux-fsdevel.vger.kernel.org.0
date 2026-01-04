Return-Path: <linux-fsdevel+bounces-72366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07219CF1395
	for <lists+linux-fsdevel@lfdr.de>; Sun, 04 Jan 2026 19:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACF62300D4AB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jan 2026 18:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB189313E09;
	Sun,  4 Jan 2026 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otFx3rCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DCD30FC27;
	Sun,  4 Jan 2026 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552877; cv=none; b=nFDjUFE+5ePtuKGyg6JMY3kDh6nqZX7OOW/odYcs56pjsiNppxkwBDkD24gS+qcfHxQpTzEdzeTiNroeZche1juHi2vuew+pSxKV3/qSXMmutT2wuBsWPsVO5orpaf2FcOTwXJScU9uiE2R95PvvqyKWSszOqllrXDdgiE9rulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552877; c=relaxed/simple;
	bh=5ckW21cSSSQDwyPudbOFi8bdZ2K9Gm5VSRg9b0IN2z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPlthES9rN6KBrqxHUh3lF5iYvMlipoWB3zS0Vq1HYtB/NIpFElFetcNvSnEkAz1M8qFzCftQd0zchXLEJPc0qvp+uzBaqx0ru889MTr8QrGf+4bKxfLkyl3ILFj38SlGdtGJiBWceaOBE5KKjxB3tPdPXr/HBelEhWH3zV32ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otFx3rCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD5FC4CEF7;
	Sun,  4 Jan 2026 18:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767552876;
	bh=5ckW21cSSSQDwyPudbOFi8bdZ2K9Gm5VSRg9b0IN2z4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=otFx3rCbfqeWsQ/hkeCrE6l/4QCl2MKwjMNEHyGyX64T17Qd+sifh1TJmmKBHvYEC
	 hflTn9bWskCb76Y0CLz7BPa72gSvtUl58oeghHQMrkS6AF9yrZbTmeLnQapyjyQZA0
	 0of++Cy/z6mKOJhFRTft2Yfx+tqhm3QK+0XdogprWkSKUHDLdyNRpNJ/O/DWNeGJSV
	 cHNIqwE9klCdiH+oysrzU7qyVTfYUfkDv/Cj3Okmx7usCowXPpiYVamlLWWv09u2C4
	 xQKfLBiUksCjBTvyrZO5+R0TGIWkntMXfFhNwllqDyEPeYB3Hr4K7Y3vBIXNMVKKdT
	 p+xKBzPKaKTIQ==
Message-ID: <9f9343f6-c714-4d2f-985b-e832c6960360@kernel.org>
Date: Sun, 4 Jan 2026 19:54:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: Andrew Morton <akpm@linux-foundation.org>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-mm@kvack.org, athul.krishna.kr@protonmail.com,
 j.neuschaefer@gmx.net, carnil@debian.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com>
 <20260103100310.7181968cda53b14def0455b3@linux-foundation.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <20260103100310.7181968cda53b14def0455b3@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/3/26 19:03, Andrew Morton wrote:
> On Sun, 14 Dec 2025 19:00:43 -0800 Joanne Koong <joannelkoong@gmail.com> wrote:
> 
>> Skip waiting on writeback for inodes that belong to mappings that do not
>> have data integrity guarantees (denoted by the AS_NO_DATA_INTEGRITY
>> mapping flag).
>>
>> This restores fuse back to prior behavior where syncs are no-ops. This
>> is needed because otherwise, if a system is running a faulty fuse
>> server that does not reply to issued write requests, this will cause
>> wait_sb_inodes() to wait forever.
>>
>> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
>> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
>> Reported-by: J. Neuschäfer <j.neuschaefer@gmx.net>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>
>> ..
>>
>> --- a/fs/fs-writeback.c
>> +++ b/fs/fs-writeback.c
>> @@ -2751,7 +2751,8 @@ static void wait_sb_inodes(struct super_block *sb)
>>   		 * do not have the mapping lock. Skip it here, wb completion
>>   		 * will remove it.
>>   		 */
>> -		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
>> +		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
>> +		    mapping_no_data_integrity(mapping))
>>   			continue;
> 
> It's not obvious why a no-data-integrity mapping would want to skip
> writeback - what do these things have to do with each other?
> 
> So can we please have a v2 which has a comment here explaining this to the
> reader?

Sorry for not replying earlier, I missed a couple of mails sent to my 
@redhat address due to @gmail being force-unsubscribed from linux-mm ...

Probably sufficient to add at the beginning of the commit:

"Above the while() loop in wait_sb_inodes(), we document that we must 
wait for all pages under writeback for data integrity. Consequently, if 
a mapping, like fuse, traditionally does not have data integrity 
semantics, there is no need to wait at all; we can simply skip these inodes.

So skip ..."

-- 
Cheers

David

