Return-Path: <linux-fsdevel+bounces-34092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AECB9C2583
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 20:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841481C21ABF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58A61AA1EA;
	Fri,  8 Nov 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qKZ2Tar+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE73F1A9B4A
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093939; cv=none; b=SEYkbE9SplGVbfkgXiivCHlP3qacd7IPq9KHs07dsRNUMCJ3zPN0qzV77RkWKSafDG37WwFHFjW4Qp1vMAWQoXbTJjWe8n7RskFvPUrB/zzcmmdKWTbpWnVZqUy1yIAN4q2NTqtk6Tj4RC51jXaEcp50tlgmN2H4THrJGjoNTq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093939; c=relaxed/simple;
	bh=MyD+tWxXFPgtNeJfGDjD4UfEb6QCKSOtoP60UxHsfTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBVNn9qU4VtaaF22QmqZNxTuR6Hn3AynCAw4UBtyvb5l/WzB109P87nT5w6mSrRV9JuRH3Na99TYQRxgiCbFhtAMDXsGuqOFLk7AkzRIoe7T5g5NrWMiuEr15Sp8xwvKFMAed/wLXMtjuMmRAyraWN4rFVfUySV2G2JMNfDF5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qKZ2Tar+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso1868207b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 11:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731093937; x=1731698737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnt+jRFiZc1qVM1+yhnD5tvt36dLhBCo8c5G+kNMovs=;
        b=qKZ2Tar+HZbSxKSvP6Ocq1viEx5ncpolmaf7/vQNd9zFd3WAoSXlj/d03fmtdDzJXV
         NVcV6UW8tT7NTeBTgtDbRX2oMNw+XC7EhxRioi5jFczblSYVkiY8uinG0Wz9an9L7RQH
         BWU+kZSNLxlES8NNhiKvJOjYwmtizhDcj+M9cA12O5iI6s9xj3gsl2ZJSn4mxUPsbBL/
         Jy7EYGUmMnZpEc6/9cytdueOOG9by3yLfTJuGBJ607MohKaziphQlK1AMd6MYHcNQkhn
         6UCJ6rSsyEGafM41HBuSxoN2Wn8WsA9NdqDHfmhBhDLNO4oQ6KFjxnSRplx3vaZOLGVP
         m/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093937; x=1731698737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnt+jRFiZc1qVM1+yhnD5tvt36dLhBCo8c5G+kNMovs=;
        b=cNAnADj4teGVs8VStLw4cGWKyMlIV9rUazKReL4rBvVX4bb7AEhuEgwzh4uG3sEMw1
         a20Fr5CA8FdI7ZINJaInRA2qf6fWeC2t7ADwtJKP1r2pSRP/u+Om9nbjdtYwyJwBGQkA
         QbcSf2LeUhGdRO0uuf2fxt9d9p1OcmRmabIe4ct6b6p90EwqQMe2XbXJhTKeEOtSkT9w
         22zDgrSBr5ybmGAHMisUh5mhsrTgC3hkw+wH8noHr1LMDX+a4M2xRX7Wj70e0OI8Wdhl
         IdLQRr9cHqI4bx09Z2mHPn13Ff/R6dwyApoh/NvptqIK5svfRvFq/S9VG+rYSKeghj0R
         A0eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPOS18abNYM+xtm/LXKGmO3w8yPaMOeWVVKvbytKyhAmDKSVaCO7olWO3zwCBLW0rwPfRAY7gPriBZKJLR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+40tY8wdP5+TdmHnev/sMFNTHSNcBG2CooWO4/ZYNt5ek1XAg
	wkS2bnCOR7am/nzMosvv3tDNQK2cFJ0UqGs6SA2hW5jclFIgseWVkVNJZwBm4dI=
X-Google-Smtp-Source: AGHT+IELEroo6SHxpKCnpbZ7JYNo7XRYyZE04sY+1b30p170Yv7UDZgTSZ5/8jsynrXJsUDAnW5RlQ==
X-Received: by 2002:a05:6a00:3a07:b0:71e:7b8a:5953 with SMTP id d2e1a72fcca58-7241338bdecmr5664070b3a.24.1731093936935;
        Fri, 08 Nov 2024 11:25:36 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860a97sm4286553b3a.27.2024.11.08.11.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 11:25:36 -0800 (PST)
Message-ID: <07a6549a-6bbf-4e09-9e3b-128e779882a1@kernel.dk>
Date: Fri, 8 Nov 2024 12:25:35 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] fs: add read support for RWF_UNCACHED
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-9-axboe@kernel.dk>
 <Zy5Zb8Twe7QBkHMh@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zy5Zb8Twe7QBkHMh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 11:33 AM, Matthew Wilcox wrote:
> On Fri, Nov 08, 2024 at 10:43:31AM -0700, Jens Axboe wrote:
>> +++ b/mm/swap.c
>> @@ -472,6 +472,8 @@ static void folio_inc_refs(struct folio *folio)
>>   */
>>  void folio_mark_accessed(struct folio *folio)
>>  {
>> +	if (folio_test_uncached(folio))
>> +		return;
>>  	if (lru_gen_enabled()) {
> 
> This feels like it might be a problem.  If, eg, process A is doing
> uncached IO and process B comes along and, say, mmap()s it, I think
> we'll need to clear the uncached flag in order to have things work
> correctly.  It's a performance problem, not a correctness problem.

I'll take a look, should be fine to just unconditionally clear it
here. uncached is a hint after all. We'll try our best to honor it,
but there will be cases where inline reclaim will fail and you'll
get cached contents, particularly if you mix uncached and buffered,
or uncached and mmap.

-- 
Jens Axboe


