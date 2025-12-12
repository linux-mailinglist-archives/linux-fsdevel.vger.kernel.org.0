Return-Path: <linux-fsdevel+bounces-71173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 908FFCB7848
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 02:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D86D30443FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 01:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C4C26FDA8;
	Fri, 12 Dec 2025 01:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKxg3U0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD827280C
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765501716; cv=none; b=oCLQNzOm59eULojfwpvjt20wlzBHJnRT/Gx5/LLr2paIj6OU+48u/NWaUhRLLp59aTdGFTbIVylhRU5iFX3Am7RUhFX0FcU8HphsHi++ArU7jhJX0PYxREuoOiYaA0G6FdxLVCOw5cOaR9b1yHUojf8ZwmmpRezJwIUfXDgv+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765501716; c=relaxed/simple;
	bh=T/uGYT0SJe840sWccGe0oOkDVXgjgves/JkBSYKKuaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv0LZ/peafbblAVHReCga9oywH5uuDOIdXTbM5P4DI2ncx00yk38lwnqZf+ETcz3h93iIWKuH/0pZozI9TcY4WM5GVZ2fqCAqh1il60pfBqZ8JSFK49QHusvrfiUWyZ6ZrEjzJo+53nlHoQkTkrTbk87HuAlQ7Q9ZX6+bcr5+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKxg3U0L; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso712575a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 17:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765501715; x=1766106515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBdi/oDzvSWIXA9titZw8xt1yZ2pS2N9m++Fybej/Mo=;
        b=RKxg3U0L+gQDfA/UF/katxt26B8A3RWZV2awt7e75CtiQy7DttKXsbemS4xsAHv/oI
         gTTV/ibbVqkVG84zGcSgPqvAzdPb3oXJLKq3VEirgcaG5TrVYFIyp2xtcjBYov4ZS93p
         y5FpDoqFiUNvoP15rZ2LONn9BI3e8cwrzKujMlzx8WwW97mSXrOD5tFNS1fH3cXgw6Xp
         5gHSC16dcycMNlj8t4kzNhanvGj+01P0FZbOPrzGRlpoHxRvM3Hrrv2GbUSQSznJBzMC
         wigBgu8KX6O1YuTgc+xkGxoUX0jABJXpwquL5l8Wgr+FvawvqHlOvCNBrkFA/rg94Pdz
         WoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765501715; x=1766106515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBdi/oDzvSWIXA9titZw8xt1yZ2pS2N9m++Fybej/Mo=;
        b=t6Ik+0eO0/XZ9++qzr+aZehbUrrYMk7UyVvuJP5AlcISYkYvYSReoWQBFuhZULMB8u
         nS9HWnXWPoMEsBWxYMSYduff0a9U69auPKT3PkI6qoW3wpqtOUO9aFsZt+tpja6ZU8LH
         k2EfaxPNsIw6ghHQH4OcRPNaUyGD814wbWiNEHXjOIUgt0JcPMeTj0WMEdjkpAMUJ/0j
         bXXUWqAzc19OjMR6hEJ0xbiu6Xy5UhZrZbm7yalWcLzvDcknlzasgeZ27C5R3iFm4JV2
         QgUfy+8ZwgxSZe4oyTSq86jk/XW9nfNaoTy20BHgsJk/7Zj/ZULCMxyqt9XFgLsNmnQ6
         wlgA==
X-Forwarded-Encrypted: i=1; AJvYcCWpPnakn6NUQxYiTAEANtUtRAPx37ZEoMsdawm+hA+WyVVwr4qxHh1j4XghivTiJJizOJBjCz0cefEIdIWY@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHErY0Tuhl/hgw+3gtwpiaJLMjELnWR/7WchEnEJ5KVX0ifKC
	X/mj8q5HOYoHWuPPTmYNakWV6p9MjO2vukfLbdyIwCUN/JCbC7MW6oxK
X-Gm-Gg: AY/fxX7EABVcXI/x6pom1VGbIh9C0Nj8MbkJPyRk/K5M4OUvTMCei+xcYrfQydnzZzY
	p/Su/Np/6cNZE9/DcduLi6JEMTY33LN/CV0csRw84N1FaMgPsuSf4uisOLxBeBjuGlGU40jC3oQ
	HEZvGiHxuf/3vnLJ3XFGBcML3sPUEwU6ZQlKLRhWOXXB3MyTPMgQH/gVj4fDr8nCB8NoE/1stYr
	RQS9FqMeJf2gxdPyu1F+nnX3wodmRuVDRFFRbeUBiZA6Y94MDda0E75bo1OEMgocFtcNA0i3zhN
	9z4RK1/jUB1em+0n2/GHLq5PYDXGTrxXIyCaghWy8w2k0WzGrboZ8OS45RwOVn6Q1yKYx8wqqFE
	k+ohzVZf5s/WXym4KjIikxHYMWTiRblJxK6vKogvVIQvbIlEaIpN1Hj70iyBVwsLHqb9bfs/iJY
	gMzAwOwGd1+xFKNp7Mky3hhUVM+8fU+F6LqJ0dpdHvbStNwtr3NEkDldEw+21z8+O7KnY16zv1F
	FRN5mLLBeSkK+XeDeDomKH6x0CV5kLKh8MZ5Osl2BuY49UPrnU=
X-Google-Smtp-Source: AGHT+IGFHKJf8QGiqR5uvpYaapCUZkmkibIutIZLTj7GFDM1IGCQKgJEzHKd26M9n65r0qbsOVsfhw==
X-Received: by 2002:a17:90b:4c:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-34abd6e0220mr546380a91.12.1765501714653;
        Thu, 11 Dec 2025 17:08:34 -0800 (PST)
Received: from [10.200.8.97] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3ba59bsm167302a91.7.2025.12.11.17.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 17:08:29 -0800 (PST)
Message-ID: <4ed581b6-af0f-49e6-8782-63f85e02503c@gmail.com>
Date: Fri, 12 Dec 2025 01:08:34 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 03/11] block: move around bio flagging helpers
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <6cb3193d3249ab5ca54e8aecbfc24086db09b753.1763725387.git.asml.silence@gmail.com>
 <aTFl290ou0_RIT6-@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aTFl290ou0_RIT6-@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 10:43, Christoph Hellwig wrote:
> On Sun, Nov 23, 2025 at 10:51:23PM +0000, Pavel Begunkov wrote:
>> We'll need bio_flagged() earlier in bio.h in the next patch, move it
>> together with all related helpers, and mark the bio_flagged()'s bio
>> argument as const.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Maybe ask Jens to queue it up ASAP to get it out of the way?

I was away, so a bit late for that. I definitely wouldn't
mind if Jens pulls it in, but for a separate patch I'd need
to justify it, and I don't think it brings anything
meaningful in itself.

-- 
Pavel Begunkov


