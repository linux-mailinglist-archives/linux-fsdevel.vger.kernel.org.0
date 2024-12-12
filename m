Return-Path: <linux-fsdevel+bounces-37221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277D39EFC28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 20:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6E216B829
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F60019F462;
	Thu, 12 Dec 2024 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GgW4/Jxo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7004618FDA9
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030871; cv=none; b=GxTWdMs0yFfTrdyuQbys9xZ2B4rz8uL0mIOrHiv+N14338IqW1tfcxBwaEFdm01fahc8YXXFvPZvVth/C4+wnJqOlaaGZQFN7nQlpQKDEIuXZimwnwfAAZpK7FL2/fMt5tNRbBeWSZIU+3fXSUXktEt/wTXnrh2LKKILyeY9mhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030871; c=relaxed/simple;
	bh=OCFrN8A/54R45OTnZwGJY+8g7Zjs0cTKD5uHci1NrPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROcRI+gaFDPhIS5YBL+5ph5ysXCNZStmHdit0mwRmXdOyqTQCy9X4qSRsPerPhN0sll2FjbkiHRoGRAo9d4QY87zIsAD48dhkhR1OAoKSIDNyCKFeDHLVpzPGqDPrwMvhwepw40r/pUXsDBBlf5AduxdB0A2Pjub4DAXLN2mNZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GgW4/Jxo; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83eb38883b5so33571539f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 11:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734030865; x=1734635665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P71yijEvoyRvd06GWA6PrfgjeJ3IYLqfiQZ66UscmdE=;
        b=GgW4/JxovBk9uarB1fbNBo6Ph9efMfRtrucZXfjiUXuHAuSXK7P2BTDoQ5PksQXvfc
         3EmcA94k6hY/qiFjxozPFTumuR8sDMiwBV6Aj7QsSLqH+sAW76PttpqrrC54PzRpT5xg
         7FlkM3aWFh8e67CuMFcXKDaHIirX4Qq8u3zkHWBXb5LVwOnV0sZo2GPMkbCdKbQ/wb1n
         jimF40n7nY1n/8kt6YgynDDEjTXHX1cjUXXd1MYQXoC+QL9sOxgqq9ydLrC28e23pgL6
         GcFicCWGUyj3hBMw2BbupLJy7i14oPyvTbbTW6LchfjvqqC+kfZ4wzGqkNQ9av1uJ+QC
         jazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734030865; x=1734635665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P71yijEvoyRvd06GWA6PrfgjeJ3IYLqfiQZ66UscmdE=;
        b=PeVd7GaSstn9HMtXu7Gl9hpQJ7W7KkbhePAUgc7sFq34upPIqICuZLwYSz+D2ohR3M
         KPDSaXKDhmxvKOlitlphmRt/+Ovp44JPpgfcTCnh4w1/Y35o3rQxLoNHc+QAWtEDl0YO
         nVAIVuOfdqe1X3JF4FetcSFeaWzVnDl2p1ol5i+itVo6u+zQaYrwvZFd82F5h/GgJ2E0
         lxbrjky1ryg0GDkwunXq1aqloBcN8KcVDw6+Tz8Y2s7XYJ3F/ZK/MnZLiuhnbz4T0spj
         4XxE+YnfJ0dBbBOwPSS6mBO/g/qNfQ1FM8/iNFbQgBTQwJln/qiXW9IPN2PwjkR6qfPH
         759A==
X-Forwarded-Encrypted: i=1; AJvYcCVwuNE0oFZXRcZ7PCefSd9dbMrbjCGE81rwNc2XENN/gOL/M7ZptmVdhv4S3JD4wNz4+D2Pe9sSszXBrVsc@vger.kernel.org
X-Gm-Message-State: AOJu0YzLeHvHVKF+p8Il4HWxYqGM3pnXkB4bscXgMzynJoJKWkz/GxCZ
	9OJhMukYZJxCbcKRFtMdwAvfL+iakF+Dmdl9KXxEMj7q+h8hGRKC+gTJjoIV33M=
X-Gm-Gg: ASbGncvubdFZ2p7drr4VgJ0fE9OxsGh5IUeFcOprmsSwAAf8RGvTnn7xqQezaQbURdS
	QOw0HsyXSgZ8GQtkPaBfEffK/ZP5Wzk9Ev4fRZCusfCj/kFA3luiQDdBqLEOOZNO2b8gRlU3QP1
	QrkepfEgWjlpCu86MulWdJFSpkx1C2HQcmSCfZjEmkJTNqdtoL/rZBl0FAoyqns9wG1EpMnyP2o
	U9KBd7DI8aH/AWA1Y6JxrJqybRI4rE/N6Gv+egZ65F/BdB7fUqy
X-Google-Smtp-Source: AGHT+IH7GBfExI9wU+7qWQ3YTNxevsUxlvzl9LcEv9ut7SVSJCkeqJHQFqGroUa4jGgptMxzux+NqA==
X-Received: by 2002:a05:6602:485:b0:843:daae:e16d with SMTP id ca18e2360f4ac-844e8822360mr3443739f.6.1734030865486;
        Thu, 12 Dec 2024 11:14:25 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844d3d47507sm76877839f.27.2024.12.12.11.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 11:14:24 -0800 (PST)
Message-ID: <383d3adc-e939-44b2-9110-4db9b4477401@kernel.dk>
Date: Thu, 12 Dec 2024 12:14:23 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong"
 <djwong@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, kirill@shutemov.name, bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
 <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
 <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
 <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
 <20241204055241.GA7820@frogsfrogsfrogs> <Z1gh0lCqkCoUKHtC@infradead.org>
 <04e11417-cf68-4014-a7f7-e51392352e9d@kernel.dk>
 <2f79ff03-48ee-54bf-b928-e9519b3edfc7@gentwo.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2f79ff03-48ee-54bf-b928-e9519b3edfc7@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 9:59 AM, Christoph Lameter (Ampere) wrote:
> On Thu, 12 Dec 2024, Jens Axboe wrote:
> 
>> On 12/10/24 4:11 AM, Christoph Hellwig wrote:
>>> On Tue, Dec 03, 2024 at 09:52:41PM -0800, Darrick J. Wong wrote:
>>>> <shrug> RWF_DONTCACHE, to match {I,DCACHE}_DONTCACHE ? ;)
>>>>
>>>> They sound pretty similar ("load this so I can do something with it,
>>>> evict it immediately if possible") though I wouldn't rely on people
>>>> outside the kernel being familiar with the existing dontcaches.
>>>
>>> FYI, another word for dontcache.  uncached just has too many conotations
>>> in the kernel context.
>>
>> Sure, we can go with DONTCACHE instead. Only thing I don't like about
>> that is that you can use uncached as a verb and adjective, eg talking
>> about uncached IO. Talking about dontcached IO sounds pretty weird.
>>
>> As I've said previously in this and other threads, I don't feel too
>> strongly about the in-kernel naming, I care more about the exposed
>> name. And uncached does seem to be the most descriptive and most
>> easily understandable by users.
> 
> The page is cached while the operation is ongoing. "Transitory" would be
> more accurate and it is a new term that was not used with pages before.

Like I mentioned earlier, the fact that it's cached for the duration of
the operation is more of an implementation detail that developers need
not worry about. What's important is that it's not cached AFTER. I still
feel UNCACHED is the best description, but I'll change it to DONTCACHE
for the next version just to avoid the overlap with other in-kernel
uses.

-- 
Jens Axboe

