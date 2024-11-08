Return-Path: <linux-fsdevel+bounces-34094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 045C69C258A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 20:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C146E283C71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4ED1AA1F3;
	Fri,  8 Nov 2024 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r/8jhKZt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48762233D6B
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093996; cv=none; b=gxHpJJmty5ZMBwjDLAESYeYaAi1WTWcFCYrRHTnMO+Fiq8KXR9tETCRophpA0q8C+ufoRSDf3CEHgYUCCUZH37P0zHxRuTFA6tneSV0Dg/67KfhRgWa/XhACxUbwb/JyMomwEiT4VrtWHcTnVpdTuWpwNIi8EKsuiiwbB3K3SVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093996; c=relaxed/simple;
	bh=33UbHbLKPpEwiyTVv36SF1QwVT9hVHQNqM5/3cP4sYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuWQOK96RhUyUa6QUjKkTK90QtI1+xTKcO7FXONmmOGMMtSQUyhejxbDV3B165KNq9lKCo55eILIVxSeS5VL4IVI0dOJW4r/D7zgbhTPWFi8U9lC8RUW/yZ7+Q8x/BzOJd15ve3TJ3mRhBIcceexA4TJKgpxCXW72lpyZinzy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r/8jhKZt; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e5fef69f2eso1555504b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 11:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731093994; x=1731698794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agqhAPagizBXPK2hVPeT+VJofGCRxLOLIbcGDBqo4DI=;
        b=r/8jhKZt/VCQOt1POBP7GPThd1VKrrVvEdF/xqwTOORfXJegcg+ZvrSHSoPa3uG3NN
         c7IrzA0eZU2nQFVKyAVo3EIWejfrNcYJG9f1Tsw7oRYSBEkj5PAebtrdEoA0qrs22aqH
         R/mpkU9KcWJ5rxANdDUOS4hEN/jlVF7RNctpEwhZqh6jUlMaZvWaEfAf2ZQRfh88qcJp
         EebGvwgfbGoUNFtbHuHBTZuWgehrThYpTL/o53J37fVvBYGsB2r+Tn08f4sTUk3qkCrH
         I0dRxsKwTwnl8b9eDsxKqyeTrwjeFphRrZzqkq5hgpsPylA5Pf0BR0n/606tDEMVVpex
         VecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093994; x=1731698794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agqhAPagizBXPK2hVPeT+VJofGCRxLOLIbcGDBqo4DI=;
        b=RTFsQMr/Yd5SXUzi6DZOB1selW89Lvj1HQTaVqLQ40v3o1cQ8FS2l8MyzDkk2ANR44
         2mcS+q2sn+X4uqiHmRHcPJUpWDDwbLCO87Yy7AVeiWsa3S6G7odj5N/xZTPXD8zmnruT
         PoiEDmnGfgWP1+FX8VhYRmmtHY40qzFyEyleuqwlk1sc36ijDxTMcfKFfhZmoCPMn2Wg
         WlXDcqC5EUYiPDvc4izE3nQSmHCVYtvPCMpGkqSW9ctgxU15K+ZFX2eyn87MVdIpCyx3
         dzHcOHtBGDjbj9zUXfAPIQOrpmW7Pko28KeGL06CAxEhHItPRiw07VTi2TB6FisqnzKS
         T7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFqaHBn4poW5pFmyP0cDgIwzxyUFl3g6KG2QOVXIUvn7PDbtuxi4VkqWgYGEr9iu8x44Vhvd8gP8C80s6T@vger.kernel.org
X-Gm-Message-State: AOJu0YyQNuSj5hvBEoY5qshQrp/6RGCSF9fqC8OFSlJJECji2aFISyO7
	Dg+viNECOl3zuHBam7LEs11p6RspQyTU5GuKcL4mf7pgq1lC95tl7ifmxQmVeHU=
X-Google-Smtp-Source: AGHT+IFuE6qpV/r1tyq6OqSn95Xx492UVUc2q5pIHqiwaOotZ114pdhQNU8Qog2j6qdVD8wuXOnlmA==
X-Received: by 2002:a05:6870:af83:b0:288:851a:d562 with SMTP id 586e51a60fabf-29560008f6fmr4367258fac.5.1731093994467;
        Fri, 08 Nov 2024 11:26:34 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f4884cbsm3886867a12.3.2024.11.08.11.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 11:26:33 -0800 (PST)
Message-ID: <45ac1a3c-7198-4f5b-b6e3-c980c425f944@kernel.dk>
Date: Fri, 8 Nov 2024 12:26:32 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] iomap: make buffered writes work with RWF_UNCACHED
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-12-axboe@kernel.dk>
 <Zy5cmQyCE8AgjPbQ@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zy5cmQyCE8AgjPbQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 11:46 AM, Matthew Wilcox wrote:
> On Fri, Nov 08, 2024 at 10:43:34AM -0700, Jens Axboe wrote:
>> +++ b/fs/iomap/buffered-io.c
>> @@ -959,6 +959,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>>  		}
>>  		if (iter->iomap.flags & IOMAP_F_STALE)
>>  			break;
>> +		if (iter->flags & IOMAP_UNCACHED)
>> +			folio_set_uncached(folio);
> 
> This seems like it'd convert an existing page cache folio into being
> uncached?  Is this just leftover from a previous version or is that a
> design decision you made?

I'll see if we can improve that. Currently both the read and write side
do drop whatever it touches. We could feasibly just have it drop
newly instantiated pages - iow, uncached just won't create new persistent
folios, but it'll happily use the ones that are there already.

-- 
Jens Axboe


