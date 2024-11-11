Return-Path: <linux-fsdevel+bounces-34244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C069C4174
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DD1B2304D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBCF1A01DD;
	Mon, 11 Nov 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Pk5AIIoc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B5142E77
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337526; cv=none; b=ACNkxtb9HAEK74dDCWQlPB18pouW+X/IOYuLCwARSM1zGmojmMqT7T/I8w0NTsoAlq1LR8yAZC51E2JrNPX13Wk4Nu9NxvQwdSF+w4BZcmthUx1vHJJi4F1XlhzC/AojL76IG+q4/ox9hT64JVdZyZZ7sTlNJPhWteVyfUotdg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337526; c=relaxed/simple;
	bh=pLCBWyOsezbkGbKj20wKcVS9Rh7859sxQ8iqgYIhwsk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iZKTRgy32yuFpHAPOGuBCsZjTVvCkIFxY+a1L+/36EV27O/1lWa4XDngXRwXQO+LjgMfwzZtGVhQKOLwOSoDW2v6dNvOMW6ouPQPd884y4ZLYyRWNq0Vw16isvIOsUF28/AKrE8jQwVLCaD3EGxu+2y4qSXXlqJoMsmFD+flMC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Pk5AIIoc; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e5f968230bso1879460b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 07:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731337523; x=1731942323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FANAFwLPA6uDqavKV1Ik7k6rIhcZlXUpeawJn43pCcQ=;
        b=Pk5AIIocAqFuw/NP+bFB+ao672vk2LV5UOBozrznBZ3WlA+a8Zjl5ySF5v9rfFkwH8
         RAiGGsr9ZDLhex3eOaQtnwBVftJ7J9o0pQNhBGyB43P6n7zemjg07xppUV3SHgbQ9/H+
         iXTETe/O34BashTVMMC48c+KRfCI/Ub+PWSu6p/h9hAgABIgckY8ctj25woeWfvz/EYo
         sUA8HNDDrTyPbnQI8reeI9xk2lvIR/SFJnDWpGpVbBMFQS6Okm3t/zmbPvK7k6/P2BdH
         q9S+Yg/7fIRjE5DMb983Ewg56p3uOkb4SmCtkooMxHCp8KnX4EfmM5tRgdIOF9vHPDK+
         zmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731337523; x=1731942323;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FANAFwLPA6uDqavKV1Ik7k6rIhcZlXUpeawJn43pCcQ=;
        b=ALXZfHq/FuqrxtvUlCNW8zYTq/IK6k8anH+eevzgJ/krRx6Asb76w2k+Xe9kl5imzI
         YmRzqAU7reQNqvVxcDbBGzFESuvKoVGQiicI0gRCmPOJ7bqthrnR4fWMp7gS20Psn8NB
         RmgmL6V0zz7S9DTcmo3VYe84CX8I7ncC/ea8uXRiTYkcRslDHlTD8N507QvKRcShKqUE
         D9VyAXgXLB8v7h4ZqFj/RH/QFKD7QbwnwukK3+9NmiA1+AP3AdQsOJhByHyX+OcswXoQ
         +YN/Anv2XIAOe8cAQE/QfukzmLh1yJxGDzhD4/B+Ju1zKmbSmkEeaurbJT/LFLekvCxs
         NFSg==
X-Forwarded-Encrypted: i=1; AJvYcCVqcaY2yv+QFuIaV3YfEa6FPPBZPhq+J7HsOiHn2tTTURbADvhlBKQX7vnhZo+Qi54tcoVPNBbM8geE6CXm@vger.kernel.org
X-Gm-Message-State: AOJu0YyJyxpxsbPVc+WB/tjiXxLTs3InYsLGuyQcBhAobDl753L6eyBN
	GfrelZtFHGt5HBTk2EyJdnvUlDdfMss68GmgIX1edXa3YySpjy45ZEmtZuSppBo=
X-Google-Smtp-Source: AGHT+IF4w0LezImfqUcdRk269iIRvUC3rDvyBtvyPDo1aUTBP1jSwl4AHjLVgkaGbGSvT/MFoIohTQ==
X-Received: by 2002:a05:6808:1919:b0:3e6:ccc:2d91 with SMTP id 5614622812f47-3e794721891mr10371106b6e.29.1731337523644;
        Mon, 11 Nov 2024 07:05:23 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78ccb845csm2096711b6e.28.2024.11.11.07.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 07:05:22 -0800 (PST)
Message-ID: <76edefe6-fb20-4169-8cbe-d8b864b04c7a@kernel.dk>
Date: Mon, 11 Nov 2024 08:05:21 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v4] Uncached buffered IO
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Metzmacher <metze@samba.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <63af3bba-c824-4b2c-a670-6329eeb232aa@samba.org>
 <00c51f80-7033-44a0-b007-ca36842e35a5@kernel.dk>
Content-Language: en-US
In-Reply-To: <00c51f80-7033-44a0-b007-ca36842e35a5@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 7:08 AM, Jens Axboe wrote:
> On 11/11/24 5:55 AM, Stefan Metzmacher wrote:
>> Hi Jens,
>>
>> I'm wondering about the impact on memory mapped files.
>>
>> Let's say one (or more) process(es) called mmap on a file in order to
>> use the content of the file as persistent shared memory.
>> As far as I understand pages from the page cache are used for this.
>>
>> Now another process uses RWF_UNCACHED for a read of the same file.
>> What happens if the pages are removed from the page cache?
>> Or is the removal deferred based on some refcount?
> 
> For mmap, if a given page isn't in page cache, it'll get faulted in.
> Should be fine to have mmap and uncached IO co-exist. If an uncached
> read IO instantiates a page, it'll get reaped when the data has been
> copied. If an uncached IO hits an already existing page (eg mmap faulted
> it in), then it won't get touched. Same thing happens with mixing
> buffered and uncached IO. The latter will only reap parts it
> instantiated to satisfy the operation. That doesn't matter in terms of
> data integrity, only in terms of the policy of uncached leaving things
> alone it didn't create to satisfy the operation.
> 
> This is really no different than say using mmap and evicting pages, they
> will just get faulted in if needed.

Turns out that was nonsense, as per Kiril's comments on the other thread.
For pages that are actually mapped, we'll have to skip the invalidation
as it's not safe to do so.

-- 
Jens Axboe


