Return-Path: <linux-fsdevel+bounces-37969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4E29F9697
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 17:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A74B165A5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD4321A44D;
	Fri, 20 Dec 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1/tkvL8E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D221A430
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712130; cv=none; b=NGf936K4qo6TJC+vW8cCgJVEIg24W9Wo5RgGsl5EOX1iYthgNZX6sg6U5PD9voGLf74p5igzdcLElg0wRuxX3sbi8TLl5804AuH5p6YETXIgOMZHVsIhM+xBBrjhs1gWEk+rL2fTP9kPsQt6ZtVdI37EkBEl7uzLIoH6QKFLnoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712130; c=relaxed/simple;
	bh=wErxbGiQwQOV0/BMRhEpLT1uL19MMH7WFbB/s76KBCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBTEnQt2nJ4EyflR8DCWW3c8U1yFZQpg1f6+nAHbs+KgQ1PnWGM4pk5KR5fx0OwdVUDAgm/8dZhdCAgCZeP9BS3dBSn7F5gymVnSBnmo3BAHujRTdWpFFuZGivzTu0Llu4HxU+4UkRVdbll9QPVnkPBk2DeKMafhmMxIfbHJH9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1/tkvL8E; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a7d690479eso14923645ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 08:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734712128; x=1735316928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lTrx6c6/GBb7W3eg60/efo35JCfQ6mibVMPttQjcE6k=;
        b=1/tkvL8ESt0o2h81srIFXlTtmTzQe3UjG6/ntassfo2XmUpzL1Pl7A3bUvqeAKTpMt
         GFIhPzUaL3xgKimUzoHNJz4MCRR+6Dwthbegtvh9XlsuX7azH39HuEfOztTto4AOrgkC
         LGRHdj2vPNisI/Ab6Tb2xPM9pHXEbX8b7raeyQXnIus85qzbS/PsCDPW5tbCQetI0CBy
         dXgtpmtJCB8T+/1DklY+rKgX/fESyZW1KM9CkarGWarOMiegjf2Ce+QwapVuLIrdooiI
         NNbABjwtsBt40V3ly/YM2GU5u9zGk+ylaVSyFIqbkxomjPkAv48ONamtT9jNIJdhRSTS
         q3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734712128; x=1735316928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTrx6c6/GBb7W3eg60/efo35JCfQ6mibVMPttQjcE6k=;
        b=ig1yfU4DD4OAQeJFLIoBZHY5LXz/oQV1g6oo90kv19FzMvoDWdGb8C5PZsJQgtbGtq
         XEOWgACvQphX6pppOyfWHbo4DSy4ZHx708VWJrqd3FHR5F/WrIYGOZUxec4AuB0x3dmu
         pr/wDpsF/Locgs61M0Q0QkcwjL8GqaaXqWbWGixgxvWqMhES80XfMn2rsWS4+jrPGdcx
         YXztHmmRGCPnUZBLk+3e0MxkeKqTi0X2UiqQmdVflt4ZD3jZXSaZr9Xo4bGZDRMxbkUg
         y6/2y+cXAulZgrtu+lsCUV7y8eWkIzDGHT9nGgBfdzusewDvu8hElOSWXsoRLg/xuM5B
         yiTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJOEPHJYiqqP9iBGGoEPBQuO8b2nJ7hZBsivK8nslLD8r8Xqsg3hUAVjkRDxwIYzYXnVu2369m1cW3lfYi@vger.kernel.org
X-Gm-Message-State: AOJu0YzskwbogYkfZdrCZ1yEF2TPJV/tVn8zhUUsCvPSLTcaF32xioN8
	7EpaJc+j8epcieOLSnsr3h2/fWDvUpAW5UCGwCsDgmC5i4vBf7Q9R0rOglmp/fI=
X-Gm-Gg: ASbGncsSPMdDuxXFd1aCCZptRTj7trQlj5Pf13UlesYMDxVl25v837Obgumjj7PWvKe
	5WIw3r36EajtKUuvgn5Fo3AvYuKfN6sG1Dqj48rXHA0q9mcLbp9NKVTUxdjtzf+LqxXTXEMirge
	sx8yi1lMAaKJyNK3bhj991AVcRONS3wIEKBdGcPw/r8aVPPhYBxOoSyPoPAuSJWr7Vw+2slows8
	a5kO/8WVhhGVNdh9h9z0px6lFRL5GOHW4fN4v3FFK+FeSHWHtoz
X-Google-Smtp-Source: AGHT+IE946EUyT5HojL8viAlIugGNg08DKK/RMd+Co2dM+HvmIIHoy9fivtm1RgK4iLbzGr2AWIINw==
X-Received: by 2002:a05:6e02:16c8:b0:3a7:d84c:f2b0 with SMTP id e9e14a558f8ab-3c2d277f25cmr42718565ab.8.1734712127998;
        Fri, 20 Dec 2024 08:28:47 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66f47sm868587173.40.2024.12.20.08.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 08:28:46 -0800 (PST)
Message-ID: <5cb98ddb-744a-4fc8-b793-9dbe56e16f35@kernel.dk>
Date: Fri, 20 Dec 2024 09:28:46 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] mm/truncate: add folio_unmap_invalidate() helper
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, kirill@shutemov.name,
 bfoster@redhat.com
References: <20241220154831.1086649-1-axboe@kernel.dk>
 <20241220154831.1086649-7-axboe@kernel.dk>
 <Z2WZoBUIM2YAr0DZ@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z2WZoBUIM2YAr0DZ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 9:21 AM, Matthew Wilcox wrote:
> On Fri, Dec 20, 2024 at 08:47:44AM -0700, Jens Axboe wrote:
>> +int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
>> +			   gfp_t gfp)
>>  {
>> -	if (folio->mapping != mapping)
>> -		return 0;
>> +	int ret;
>> +
>> +	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>>  
>> -	if (!filemap_release_folio(folio, GFP_KERNEL))
>> +	if (folio_test_dirty(folio))
>>  		return 0;
>> +	if (folio_mapped(folio))
>> +		unmap_mapping_folio(folio);
>> +	BUG_ON(folio_mapped(folio));
>> +
>> +	ret = folio_launder(mapping, folio);
>> +	if (ret)
>> +		return ret;
>> +	if (folio->mapping != mapping)
>> +		return -EBUSY;
> 
> The position of this test confuses me.  Usually we want to test
> folio->mapping early on, since if the folio is no longer part of this
> file, we want to stop doing things to it, rather than go to the trouble
> of unmapping it.  Also, why do we want to return -EBUSY in this case?
> If the folio is no longer part of this file, it has been successfully
> removed from this file, right?

It's simply doing what the code did before. I do agree the mapping check
is a bit odd at that point, but that's how
invalidate_inode_pages2_range() and folio_launder() was setup. We can
certainly clean that up after the merge of these helpers, but I didn't
want to introduce any potential changes with this merge.

-EBUSY was the return from a 0 return from those two helpers before.

-- 
Jens Axboe

