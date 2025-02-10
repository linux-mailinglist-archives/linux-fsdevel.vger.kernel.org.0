Return-Path: <linux-fsdevel+bounces-41348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84419A2E302
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D414A1886F33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 04:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1440147C71;
	Mon, 10 Feb 2025 04:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DVgMklNk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA143179
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 04:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739160134; cv=none; b=WLs0DZZiuwH45onSoclXAABvU2+lQAWsfxvavIPo85De5n5qfYvWA5GcNZsB0O1eY7r5AeCS6hn5hgN25ED7RKtyo6HRvbM1dwWtkIz0eR8eCJG2RfR6C3vn42j+nPZKWxUW/J1STJg119I9Z8Xfs13s3jr3P556k0g3Wh/yrw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739160134; c=relaxed/simple;
	bh=V1gHYxlRZwOtXwh5cWQDZ6vYR1cPh/F6/eq2664MFAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQ2ArDzLzXufbn7yjym72ep21QaKKKZYUY0kdgn0knynf8M5CAEG5rdsYCHLKIeXQOIPLkPejQZqqAmyWEfARBiSrX0h0C2ANvbJOfMKu+4pQISDG/aA+7Tt1sO29MYXEJlpkY1SPmBOkRzfZa7dQcHrvnWkvIpT6IHFsCBUkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DVgMklNk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f2f386cbeso71428005ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 20:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739160132; x=1739764932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtudIaJrlV9+v+a4GztkZlJrja+3+VYAJxLE17w4gMw=;
        b=DVgMklNkyi3RzDVEU4+QBj2UUsqjcW8ZrcWl8CyyYWZie9x4r/SLP5OzUItcsd0Fse
         q6TOQHuSrWr+tDVaOeWwS3Mol0fCDEZKLAUNvcWlYQyzbGeNeP+Kv3ZH8I6aOQ7VH/x8
         F+a/xvLyiPmcXW2e5yDAWjU7hnlJ/cKvY0XKkj72VXEjKlOxxaltGEffLoKxrtB3Pk3c
         xTpW7Lrv4U0r4Mx/OD/tYuot+d8NVtJAfoAM654aciWMQzg7da9xioWiZb/Hc6geFoEH
         lbBdeFN39HVWPWjO2zWZdGpqAAzt76jc2x27m05SU51LQHRWqJixHGCHcg+8LJ6p8sg6
         j2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739160132; x=1739764932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtudIaJrlV9+v+a4GztkZlJrja+3+VYAJxLE17w4gMw=;
        b=YeLB3xvWW15oZWQUBQOEEITorLYmCJJivYSD0jKalc/pOvRDI1dKt39HaJ8x0yQ1hG
         /MOnKNDHJU3rRajIp/wvCT9iMeQn+VMIOJTQPklGqITzrKDqDf6jpXQzYI/MFU/WvmwL
         4H2Ljlk216sLQmaNnHcxbD/gKBc4ZCjRMafAxnHoFRAI0an1vWuFdua20WqeOlldZERI
         mDGjZAyzaDyJLpjg2Vc6Lmf1nCqfiojuqtZ+Ym1zPQIvJHTZDF5fIHLspMJ5kqIyEauX
         NUD2c9B76y4RCt38sQsLKdgqquBtjpfmf+2nTqmXczhlsTBYnxTXpds0CV8T0uVJXNNe
         aPMw==
X-Forwarded-Encrypted: i=1; AJvYcCVvX+w26DNIhy9CdTg6UCa8RpGxAjz6k/OgfVWZ8TRI6jlegp/DEkYbe5dcxBUO0tOkIXiAUzmW4D+jL73u@vger.kernel.org
X-Gm-Message-State: AOJu0YyhLLhYpRNS+aRQrzehFCWpRuW5b2hbAiQX8DIAT+N6xYFHe2HR
	Un2DcYToyP/ZLMHc925Yr7d3b04xZ6LS6gE4tNNnEZlTlYojPIO2cf3GkgPukk8=
X-Gm-Gg: ASbGncvNHR4dQxMx2ofe2iJoKNzj7ekSiv9Vbz2aM+tJYr9g+5b6SqtV9LgLgaF/wrV
	1TuizcGAFyGcqmbjG5+muDl7WvbNeWyvn/WcjSHnhidvPeCAvIsn0sy8NOhhVUf6euAuxY9+7yW
	LSuMKsFtXHRNlZ8bJ3b3QpLG32kUbBW/Or7GHuDvNjF62gJw40n/IFqA8CWoqqV2UzRUZOygXGd
	cTw5bp4l0iJvzgKaLAk60kaDTlSLbaRP3kMAeVc7EhC0e1vNnHE0BKH7xSx6eje1M6Y7k3NLjit
	RfLnCnu0DFkz3oPpKgyghHrdMdouDbmqhcJDqknR/w==
X-Google-Smtp-Source: AGHT+IHDZevKRajdC/lklzPziPy9kXC733VsLZEiWZ4pWlV+ji2X8xq5FA7UbqgOwRGAkOcuxzs5QQ==
X-Received: by 2002:a05:6a20:2d27:b0:1ed:9abe:c663 with SMTP id adf61e73a8af0-1ee03a41b09mr20947824637.10.1739160132024;
        Sun, 09 Feb 2025 20:02:12 -0800 (PST)
Received: from [10.84.150.121] ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51af7a221sm6777377a12.75.2025.02.09.20.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 20:02:11 -0800 (PST)
Message-ID: <8c71f41e-3733-4100-ab55-1176998ced29@bytedance.com>
Date: Mon, 10 Feb 2025 12:02:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xfs/folio splat with v6.14-rc1
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Christian Brauner
 <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>
References: <20250207-anbot-bankfilialen-acce9d79a2c7@brauner>
 <20250207-handel-unbehagen-fce1c4c0dd2a@brauner>
 <Z6aGaYkeoveytgo_@casper.infradead.org>
 <2766D04E-5A04-4BF6-A2A3-5683A3054973@nvidia.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <2766D04E-5A04-4BF6-A2A3-5683A3054973@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zi,

On 2025/2/10 11:35, Zi Yan wrote:
> On 7 Feb 2025, at 17:17, Matthew Wilcox wrote:
> 
>> On Fri, Feb 07, 2025 at 04:29:36PM +0100, Christian Brauner wrote:
>>> while true; do ./xfs.run.sh "generic/437"; done
>>>
>>> allows me to reproduce this fairly quickly.
>>
>> on holiday, back monday
> 
> git bisect points to commit
> 4817f70c25b6 ("x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64").
> Qi is cc'd.
> 
> After deselect PT_RECLAIM on v6.14-rc1, the issue is gone.
> At least, no splat after running for more than 300s,
> whereas the splat is usually triggered after ~20s with
> PT_RECLAIM set.

The PT_RECLAIM mainly made the following two changes:

1) try to reclaim page table pages during madvise(MADV_DONTNEED)
2) Unconditionally select MMU_GATHER_RCU_TABLE_FREE

Will ./xfs.run.sh "generic/437" perform the madvise(MADV_DONTNEED)?

Anyway, I will try to reproduce it locally and troubleshoot it.

Thanks!

> 
> --
> Best Regards,
> Yan, Zi

