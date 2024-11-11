Return-Path: <linux-fsdevel+bounces-34240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063AC9C4062
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF49A28208F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E2719EEBF;
	Mon, 11 Nov 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1/ItSrzL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A5019D078
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334233; cv=none; b=CXjczbn3H94igo7ZrvjTliApYdrdkHx1LuO9BslBQdG0CKqYTAsjXeNDeJmu9NIL8dVdVvjdxiF6YyvlWKHENYAWGXWX4b8ouyCoZLeSSOBjJ6MS/kk6BlvPZABEWefg2Yjty8NjBGOvKrLct5TWJ1sTKxi4iD5APR2a6EpS8MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334233; c=relaxed/simple;
	bh=s3SjlHY0gQLeWz+fe3YXImw8K8xBA6OljdHuJgwO7DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A67Lpb+LQ+w/Rt6PAfDNJfu0WcFofL8OrIn8UkV4hnhB3GBILlkQ9RHHmkLPR2DhewO0xyfE4vqJLCm03F4/OxNwisMbXTdmpdPwOCqTehx99KtOZpl09T2mxzIVwpfRMHQwp16pdtiQM95H2SUT11g426RHKPXUpK+IBfEFVaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1/ItSrzL; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71811c7eb8dso2239050a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 06:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731334229; x=1731939029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RR8G4tGz1/ZWQm/cJgyX8Guo+mbUwgdFHXxMj5CZNcA=;
        b=1/ItSrzLkya1eeC6DU63Xce18ybmb0XbSjinfpd0uBwhVO1FoFTRIeYiZmd0Txq2Uq
         y3EYW+pgqQvTcCBgc4AFXBxoOWX15YgI/V8MVNMZAYA+bOiFnn7QuiSq5hP+bf3k3r8e
         gDkFYZzC+OzLfIRAviBesqJlTQrOeW1wyTSk/7O5K+IxLysd8v3MjCkrHMWpnv3gkORu
         xG/5M0okOgLtJQRqVklTZRdu70b/OLuJb2mvCiUjmSWlOcltw5mX/SXCwIqiRpEplf6L
         /rVScF7I3JgHwlv0RtPEFCJL2o3Gdz1SDClmgUd2j3Thb+jAka2cQOjKUVcoDR4Xr/gi
         VtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731334229; x=1731939029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RR8G4tGz1/ZWQm/cJgyX8Guo+mbUwgdFHXxMj5CZNcA=;
        b=rP+TA4Q/CZ6Z57g/mv5GJL3jk0HGm+DtCFcBgumkL8bLHvODVaBtVOxHLM8VPhxI5G
         qiilrQlyTITEs/5QBxqqkWe4xHFJkcVZOgQZFH8yRqsxMYSnrJ5iik8/Hv4uLILQqXlc
         YSI1a6H/cFHo28cNPaLlPHkJFYM8XOIcQXir1Q5Vf5+n9lKueMeYep+XxZuruRhwM8G1
         GZ8SoCx045IWM1zC35ZM7g1t2jESPzQSN5swQl4jgC9DG9WmwKnEMLKm9SOH2dMxEX6o
         v80haUL7q1SJ4sIasKVRSl+03XaAlwSg+oVtgHgu+doWt8vMoOklXyE9GGCzaFe9ttVT
         G+oA==
X-Forwarded-Encrypted: i=1; AJvYcCVOQOPg9A3tFClh5FXVmV1oduZkQziCVfpP8SjKrld+yrFTQjbTYpefkJ+g4NHNA+Yl94V1yAhLErACYqox@vger.kernel.org
X-Gm-Message-State: AOJu0YyGm5SyJPOlBoTM6JpZh8DZKbrPkP2rdcR6qVyhegNFIt5r5y6D
	KJUCVzyzsexWPapWzqlgzh9aB5oQAbriNlKwMd5pc4cg3DKf6Ba6FaTSKhCFH8c=
X-Google-Smtp-Source: AGHT+IH/bAmex7oAGDPGL0QoO97Ag/PQKboG/Z+2TurnDxMOC7Dm6AqazaeLI4frZAHmUiSqsXNYwA==
X-Received: by 2002:a05:6830:6509:b0:718:9989:efac with SMTP id 46e09a7af769-71a1c23c804mr10236365a34.18.1731334229599;
        Mon, 11 Nov 2024 06:10:29 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a1081078fsm2259797a34.25.2024.11.11.06.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:10:29 -0800 (PST)
Message-ID: <42d612bc-cd3e-46cf-b8d3-50b7c01a9b93@kernel.dk>
Date: Mon, 11 Nov 2024 07:10:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] fs: add read support for RWF_UNCACHED
To: Stefan Metzmacher <metze@samba.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-9-axboe@kernel.dk>
 <dbcad551-bf66-406b-a6cd-b8047d1cbace@samba.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <dbcad551-bf66-406b-a6cd-b8047d1cbace@samba.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 6:04 AM, Stefan Metzmacher wrote:
> Hi Jens,
> 
>> If the same test case is run with RWF_UNCACHED set for the buffered read,
>> the output looks as follows:
>>
>> Reading bs 65536, uncached 0
>>    1s: 153144MB/sec
>>    2s: 156760MB/sec
>>    3s: 158110MB/sec
>>    4s: 158009MB/sec
>>    5s: 158043MB/sec
>>    6s: 157638MB/sec
>>    7s: 157999MB/sec
>>    8s: 158024MB/sec
>>    9s: 157764MB/sec
>>   10s: 157477MB/sec
>>   11s: 157417MB/sec
>>   12s: 157455MB/sec
>>   13s: 157233MB/sec
>>   14s: 156692MB/sec
>>
>> which is just chugging along at ~155GB/sec of read performance. Looking
>> at top, we see:
>>
>>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>> 7961 root      20   0  267004      0      0 S  3180   0.0   5:37.95 uncached
>> 8024 axboe     20   0   14292   4096      0 R   1.0   0.0   0:00.13 top
>>
>> where just the test app is using CPU, no reclaim is taking place outside
>> of the main thread. Not only is performance 65% better, it's also using
>> half the CPU to do it.
> 
> Do you have numbers of similar code using O_DIRECT just to
> see the impact of the memcpy from the page cache to the userspace
> buffer...

I don't, but I can surely generate those. I didn't consider them that
interesting for this comparison which is why I didn't do them, O_DIRECT
reads for bigger blocks sizes (or even smaller block sizes, if using
io_uring + registered buffers) will definitely have lower overhead than
uncached and buffered IO. Copying 160GB/sec isn't free :-)

For writes it's a bit more complicated to do an apples to apples
comparison, as uncached IO isn't synchronous like O_DIRECT is. It only
kicks off the IO, doesn't wait for it.

-- 
Jens Axboe

