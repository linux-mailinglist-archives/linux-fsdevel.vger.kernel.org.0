Return-Path: <linux-fsdevel+bounces-38343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B83F9FFFD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 21:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336EB162A51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67081B6CF4;
	Thu,  2 Jan 2025 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pfO1ILJT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4DE8F58
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735848752; cv=none; b=uM7iU1jtLrMSszYPsPFfvVAYPa1/1tJMd8+6XidfFVLhqWs718W+iOPyKHzhB0r852R39ZCRFRB4L/a6L+BPHk6hLxwMeMxGiMNG0OGylx2yL738ktVMvaYW7ixywbbrY09wdB3Chmc9+psHPjWFdztnPnTB1YXhUQCaqKXEmcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735848752; c=relaxed/simple;
	bh=k1BiPny32Vdcy39cfGCcTfQtxejWNWV0QmLJ9stcBX0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VhJFplx/U7F43NXQEhv9aZ4PfjzXOsfV8e2gXEJbUGoV4MPGjdRvp65uGVBQOjuVCc+8y8yMtApvAje108hXDznqFxsDc7BOInCh91FVDNydbJE7ttaKF292DkRAfRBMDqxAVJTOKIoJwrM7R4KEk49hyBvFNut+6h9mqkqVhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pfO1ILJT; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844e9b8b0b9so934020939f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2025 12:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735848749; x=1736453549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v2UPZHRZRRh2ttfhUjF6HZBoXRk72xT/3w5rhEqqtEw=;
        b=pfO1ILJTL0fzKmMHxcVibOheO0IPhmRZD9vBOvvgkv+u723eU8PauZla7u0iNM6qZh
         LOjIDB7xTYz+32JaoB4QY41nj5/yc5saS6kfVNCAmCls80qVM4kDPZfLyP01UhJFXsJC
         o8qx1qgRq9909z+kBifvYyd8SWIlEpyKEfQPKSWazcb29K3ArZUQhD8yxNK7KkAQPUyj
         Rr9TBydCY4ghOXq+G1X4CmM4kJpOH7je2A0MK1M5OG4IuE44h07Dyf3xhTYND17BctUV
         YvOOrK/7gpByV3TTBESZsBALT/Rye655MCmojCJS7mmoFansXHdk+T11eDnsAORcB51P
         VQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735848749; x=1736453549;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2UPZHRZRRh2ttfhUjF6HZBoXRk72xT/3w5rhEqqtEw=;
        b=Eivr9xQxDJJINPvv0UciPH5Ob8kPXeZ+em2HBlnBedB91H3XD5DOg7Ihw8UTyulUG5
         bDuz+VvxfoH4hGix/PoPy7uKiUNZyKISC1Qh/FJ93ske+n309CE/LBnczPiPTvLQk6TE
         L0QX2SnUEIJM88Zy/lRKxWGNe2OdGf2spKJXiWl17dfbEfD9GacbDcYci49/woOgtIrD
         U/1FKnkRk54nUQFwwl6MD+pDoQpKdgDnF25jwnfFDBIMBzrnHb3WodlI6tuZNFIKxbv9
         +AUoFh3IKMhMfvLdX3Cx0ZXU1u520jWQQ9nT3w/jGxKA0NiSH0vGHIWMrFtUnjVDiQEb
         NeEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvsez3mIL2hM2odXnrekt1JEB+5LzUdefVXfRSrCTvLhJMvr7MET4QWvO0Eg3++EgeMYpn1MSx8ZqLSFs7@vger.kernel.org
X-Gm-Message-State: AOJu0YzSJ9YVHtNfBWr2Vu33Nf8jDmprkftDnvRuDs7e7/16wMsq0t8K
	OlbSpWIl6WWZez9AAmcC5u1lyWAwpALTkxLbs5Ch4vLR8kGTbpXztstFVDYsxb4=
X-Gm-Gg: ASbGncth+aMMGp8p2UjG5/H1GFaKNd+oxhc9633slhDIVLi4jktRSO3i86l9izNxsr+
	JKP2wUZoDaecHtvdvZY5Q5sGmtYtE9QOkEfNifUgwRv2PcpfW/iEpZZKV50co+PXyxHoT/vq9tg
	TyATH8vPkQnnJXuAApt2J4mPRH6PMWx1iYswzUmjDTolmVknGL5YWuDnm896RR+JaLu8uaS692U
	nlNPitz/TQCCK8yXBhLN2PnWKIEtqceeVEQxVBJqU4TGH1sgvHx0w==
X-Google-Smtp-Source: AGHT+IEYlb99o+N5pvNX82iwMSNOKAxLdsrEbVqa3Z0i9O3bTDsJaWg1lIWWOB2JxeZcRAFbxYbMjw==
X-Received: by 2002:a05:6602:14d5:b0:83a:b500:3513 with SMTP id ca18e2360f4ac-8499e4ee9a6mr4443687939f.8.1735848748939;
        Thu, 02 Jan 2025 12:12:28 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf64f29sm7341845173.43.2025.01.02.12.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 12:12:28 -0800 (PST)
Message-ID: <abc8ea22-e6ad-49b7-83b9-d71839c2d785@kernel.dk>
Date: Thu, 2 Jan 2025 13:12:27 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] mm/truncate: add folio_unmap_invalidate() helper
From: Jens Axboe <axboe@kernel.dk>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, kirill@shutemov.name,
 bfoster@redhat.com
References: <20241220154831.1086649-1-axboe@kernel.dk>
 <20241220154831.1086649-7-axboe@kernel.dk>
 <Z2WZoBUIM2YAr0DZ@casper.infradead.org>
 <5cb98ddb-744a-4fc8-b793-9dbe56e16f35@kernel.dk>
Content-Language: en-US
In-Reply-To: <5cb98ddb-744a-4fc8-b793-9dbe56e16f35@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 9:28 AM, Jens Axboe wrote:
> On 12/20/24 9:21 AM, Matthew Wilcox wrote:
>> On Fri, Dec 20, 2024 at 08:47:44AM -0700, Jens Axboe wrote:
>>> +int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
>>> +			   gfp_t gfp)
>>>  {
>>> -	if (folio->mapping != mapping)
>>> -		return 0;
>>> +	int ret;
>>> +
>>> +	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>>>  
>>> -	if (!filemap_release_folio(folio, GFP_KERNEL))
>>> +	if (folio_test_dirty(folio))
>>>  		return 0;
>>> +	if (folio_mapped(folio))
>>> +		unmap_mapping_folio(folio);
>>> +	BUG_ON(folio_mapped(folio));
>>> +
>>> +	ret = folio_launder(mapping, folio);
>>> +	if (ret)
>>> +		return ret;
>>> +	if (folio->mapping != mapping)
>>> +		return -EBUSY;
>>
>> The position of this test confuses me.  Usually we want to test
>> folio->mapping early on, since if the folio is no longer part of this
>> file, we want to stop doing things to it, rather than go to the trouble
>> of unmapping it.  Also, why do we want to return -EBUSY in this case?
>> If the folio is no longer part of this file, it has been successfully
>> removed from this file, right?
> 
> It's simply doing what the code did before. I do agree the mapping check
> is a bit odd at that point, but that's how
> invalidate_inode_pages2_range() and folio_launder() was setup. We can
> certainly clean that up after the merge of these helpers, but I didn't
> want to introduce any potential changes with this merge.
> 
> -EBUSY was the return from a 0 return from those two helpers before.

Any further concerns with this? Trying to nudge this patchset forward...
It's not like there's a lot of time left for 6.14.

-- 
Jens Axboe


