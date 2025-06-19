Return-Path: <linux-fsdevel+bounces-52152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086A8ADFD11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 07:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3089E17A97D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 05:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB33242938;
	Thu, 19 Jun 2025 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C+5bmw2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BA1241CB6
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311688; cv=none; b=EeCsK3U+piSqOnc4XB0pyx3GrPG8iFMUCWves5plax6gnCw3m0K4ng9u+c2+oYjwnZKCIk4Ggd8KQOK6PeLcywovh4+i5oF3ZX8daCRc1mXJEtsFgYxMmdiLXcOv3r8kqpnHJMupMzRZIps5LxqKk28kWs8274hTvnbLISU2vSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311688; c=relaxed/simple;
	bh=LK/kMbdNJhgpXmf2BGnAGKd0QN7jHvtOpbE/3Ht30Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4aoS30pmL6JsJyVwnjU9dIOceOd5H/1zdz7aCu/MpeQG/D47Np7xqrzz5kCdkjrqJVS5jpiscaQ1lKAAemrp667yTMAWUZWuK8zvDqIu5dOvXWs+1L9ALU9LTnkADqU5Y9YMG8bnHZM+Zfx9/WL6wd/9WgMKETca15s4405rUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C+5bmw2b; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so974334f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 22:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750311683; x=1750916483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q9Jptih0CGcCWmNh7johSvgsRzEMulNVyMDIMzTGZkU=;
        b=C+5bmw2btttzpA1eZehcYg335MKiJTY7z11LMRn7VnOk1etXab5FJl5N5ZEDpazWh7
         YxIiB/Q/eJtqNfKqEqEgRVXo8x6ScNMfp7RGqqUbW2bGDoOVj0Nz79P8oXbuoVNwVgKR
         Y+yejk6ssQbrpQqNknO2ozdncpaifUKAKu4HQOl59AXVzJ6SVl4riEXefS0EcJPAvnjO
         e4TyeJCjK1HJRqllCaF2V67NQTWjHz09KoBi3KYFf8j12q3UeODSrUDtFF4XteglMCzn
         8GY1MSmKY/3swoOYmKmaHJqQkX7HRUPEvaEARx1wr0ex5RQ0rdvOmZZooirpO/hSZY9H
         +OXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750311683; x=1750916483;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9Jptih0CGcCWmNh7johSvgsRzEMulNVyMDIMzTGZkU=;
        b=FxWVHbilRRki71brJT1zF4BE/Y1hFPVXxigtHS0S+OsjEqDWfShYVOQ0IxDuoKpBhV
         2S22OLmYmjuk9DwNo7WEbq6dPVOO0zOV/Sx2TNFsH/omPw98OU0ZrKJNrIFfVeayUS4r
         P3S+m68FEymyQHSAQrkeXoSIb4TCq2giWhhwtkPYOxvn9f9IlzcQXIL1bO/+FDjrQL9n
         Dck3puFd7/r+00+0ldtgERUI5XSSc3BnK6PaHqNydO/TKp8nzND+9GaiVPuxvaot3LFO
         k18S14JNsLsx7FlOOe31KJZjCVpn5UIsK0LLgLDFo5/aqIQnGFWsi2NJ5H+8jQ/lCIHI
         nSpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIkNhXTLbULSJ0JEASYTxppUwbvERj1W0f+UduhYW627yPkqPPr8Gy4rtSjkujhJJyQWhPa9IKj0/Vpt59@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4pon5mrXTlim4Vg0vP1ikXJ/x7NCW+fCNkOGhdw0s+FOr+amu
	TkMRWtP6iBFcE8S+BjZYLlIx0Tx9wud/uKPIW8ppZwjEk2eyEYiYAqbCCsqPrTIBNGjPjImK1nl
	oBHsT
X-Gm-Gg: ASbGncv1DK1S1QjiWt2+i7k4oUBksazSkRpL2tQ2HT99DGPfESUM+DASIDD4dtYWDL+
	USFSGBgRzv9oo60hvjA1DH65iccIPxvSttD7C6csFX0732nOVnrynmchMNV64LeAIdQ3n+u8JFQ
	4Qerv9T1ZEWSpuEe8M9YGmH01beAX5a8V7GbrXfnjsCW9DU0xDCgFUg6QkTRCgJiiT1tyPX2szk
	iqyp7HJgMqldta671Rmu6KU0N0ke8HA4r7x19wjvbPeuBWy7xGq9/mfk4nOaIIKwZ31+k5ed/rh
	x172WfLhk6j9KJvYZz8mTo0B+6XWmsJteFcTDNA+obiL61ZUB9aJUJFVLhlWsrFvqPdvo2kIIz/
	i9/YQIXlNYBWuOw==
X-Google-Smtp-Source: AGHT+IEeCetJMzITvQTSEH8d9WGCjV3RVQtVEL7I79j4l30JcTvecr2dZYhDSZ+qs9Pc9ll6tx3egA==
X-Received: by 2002:a05:6000:2b04:b0:3a4:f722:a46b with SMTP id ffacd0b85a97d-3a6c971ce5emr1124590f8f.15.1750311682860;
        Wed, 18 Jun 2025 22:41:22 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a226ff3sm1172760a91.8.2025.06.18.22.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 22:41:22 -0700 (PDT)
Message-ID: <f1cc6120-0410-4c69-b5ec-19194508148a@suse.com>
Date: Thu, 19 Jun 2025 15:11:16 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: Convert test_find_delalloc() to use a folio
To: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250613190705.3166969-1-willy@infradead.org>
 <20250613190705.3166969-2-willy@infradead.org>
 <aFN62U-Fx4RZGj6Q@casper.infradead.org>
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
In-Reply-To: <aFN62U-Fx4RZGj6Q@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/19 12:20, Matthew Wilcox 写道:
> On Fri, Jun 13, 2025 at 08:07:00PM +0100, Matthew Wilcox (Oracle) wrote:
>> @@ -201,17 +200,16 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
>>   	 *           |--- search ---|
>>   	 */
>>   	test_start = SZ_64M;
>> -	locked_page = find_lock_page(inode->i_mapping,
>> +	locked_folio = filemap_lock_folio(inode->i_mapping,
>>   				     test_start >> PAGE_SHIFT);
>> -	if (!locked_page) {
>> -		test_err("couldn't find the locked page");
>> +	if (!locked_folio) {
>> +		test_err("couldn't find the locked folio");
>>   		goto out_bits;
>>   	}
>>   	btrfs_set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL);
>>   	start = test_start;
>>   	end = start + PAGE_SIZE - 1;
>> -	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
>> -					 &end);
>> +	found = find_lock_delalloc_range(inode, locked_folio, &start, &end);
>>   	if (!found) {
>>   		test_err("couldn't find delalloc in our range");
>>   		goto out_bits;
> 
> Hm.  How much do you test the failure paths here?  It seems to me that
> the 'locked_folio' is still locked at this point ...

Yep, you're right, the error paths here should have the folio unlocked
(all the error handling after fielmap_lock_folio()).

It's just very rare to have a commit that won't pass selftest pushed to 
upstream.

Mind to fix it in another patch or you wish us to handle it before your 
series?

Thanks,
Qu

> 
>> @@ -328,8 +323,8 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
>>   		dump_extent_io_tree(tmp);
>>   	btrfs_clear_extent_bits(tmp, 0, total_dirty - 1, (unsigned)-1);
>>   out:
>> -	if (locked_page)
>> -		put_page(locked_page);
>> +	if (locked_folio)
>> +		folio_put(locked_folio);
> 
> And here we put it without unlocking it, which should cause the page
> allocator to squawk at you.
> 
> 


