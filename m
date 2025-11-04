Return-Path: <linux-fsdevel+bounces-66947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EE1C31044
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A94F34E59FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9F81EDA2C;
	Tue,  4 Nov 2025 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0D1kAcx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284BB14E2E2
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259801; cv=none; b=GSv3t0lNinTc7cqyQWx5DHcrRoC9QjYc0h7yNgrmGYklQtDl+89e/gpK3C8lGvyvMWdDvENUyXNfAJyg1B6o8NcQ3JfR9K9WrTjPD+vum2VZ7u/KsYXq3RABZaesVhmrYAUtwqOCm+MaIKvGhx+XjKWGkkTGm5i9KHi6kOW7zsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259801; c=relaxed/simple;
	bh=OY6wmS2cjaoU74ByE55r3CESyyslJw59xMwwDbCQcNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ubs4FThnRfn3D4wn3/Jxb2cddKxZabC6LUJGzIMGEcERXzL2fJ0CFCsJrjwVDuqGUKpDWONOOSbIfnmY2a/zTYduoAd9i6o6siRu1ixuxzGfZHudcODzqi02+PL6cH++ntYOZkh4/pTWFxWqJ4WAZcCZAIDYf+TtxMo3sdT9GE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0D1kAcx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-340cccf6956so1949127a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 04:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762259799; x=1762864599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuYa8Vyc5g36zBbzEp6ohHNgPOjM03c64dcRTIxk/XA=;
        b=e0D1kAcxX/U2JrPsU6OZoYyaStafkLiLKMsT4xfwfjtykF5wtNbe3WZJTO3BsLzqY3
         k1FpVVc4jeUoX6wQabLcMaozAJud6YY0SDId2ZIxAi4mxaSlR/7yzYza737NALtoamdM
         AvsVKHu6SxYAS5LDjDB9lCBLmLHVLWCK+83xQ8Sdbv74fdW0vYl96JadzvHRxklYsw7q
         SqcJ7+FcZ+u55vuyZQh0VkmkLqk1wPbyYMUv9kwKOHMSIn8uv5eu/0x4iiSQveQ4W6Nj
         H9aT0tsu8HNI1FL4+12ggVwrzv1N/lEUwb0IAFhtpFyvEIG5ZXDM3zv+3v2lzxA7NgMN
         CF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762259799; x=1762864599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuYa8Vyc5g36zBbzEp6ohHNgPOjM03c64dcRTIxk/XA=;
        b=cAz10yZJY/0mM14DRXeVeStNC811aYxyRJqommS3ZgZ8xI35lDqd2kGbyoWzsQHQFV
         Hl5c1jEu+H98Ghx/XvYBYZsOEH2HHOil73DfauXkgVVrJhIwZxwfQf4GEQf3aZy8Uk5r
         IfeBLdLIJVZUulNcbKbKyN196ysvnKxRuNwwy4Od9SiiaaJkZecEVZQgmADneIq8U0V6
         BcobCXS+dSM/ay9tAotQx0wR8zYNWd04QefrewDXBT5e6DZ+5GnT1p+dGpLv+DbNq2WL
         iNWS5QkHZVuXwEWiIzgUyHAjO24OhP3bnGJ/YoNgt/3+wQxZNbhyKicDDsCLSSLQQ+dz
         7qKw==
X-Forwarded-Encrypted: i=1; AJvYcCX7EUEk0kchmF0cOwm64/srIkytM+bXMvRI2waZR1GnM4Tmz3QTBQkb1oh5QEgWjvm/k40AD/B8yzkU58NV@vger.kernel.org
X-Gm-Message-State: AOJu0YzOye5xECIgBuf6UWYcfVS1yz3JS5skyNgynoOp2kD0nHldfbfI
	BN2Abo+iczr/IMOaE9KjB6Hkaak/vUE+LHWw6yND6ul/7FMQnBjR13EK
X-Gm-Gg: ASbGncvOUpDQ0vVoVA67foxPeK4PBd6uYQxdPuVF2rBn2JXf5woywoBQ8xa2WAKIra6
	JBv1+jUNawHJd5r9k3BnYt/Z4ObnrAxxzXJmMzYO1MhXwNf6WVfZ4ficJVz7YJql1Qk97T2Jk6J
	BE5Uh1DWjRiaFKxLnq8uomrWHdV0AiuKILM5G5768WHYQXI0PLapgpofpLnVtHT49kuumauzEIu
	0tZw0QdYiJ+CA8ZpCDgdDjugO8ZNQ+ZRCUo1d6mymxniaol6968Amtgh6V1KzhOvQBAjxIR4Lam
	9M4vBmB95XnlhY5DnD2TLQ4mZGJSJV8/GEbIPJLft8aZs3xxsgiXeWVI6NK88wgkkcBPCTcQbbz
	fIpOCEpzF30vse1tyQe2wGPy9P6qWwzrLgB6vBdxia8TpclZb+CMZYQOmr6ODsucMzBTObB5o2J
	iQ/cs7MQU+/7AhULaTyBY=
X-Google-Smtp-Source: AGHT+IEqu3D4nCBfCW/PW2rcdwd+c+X0hF9STm+2SPgeMcdKeUwLd7lODO/G7LNmaVev7hTJtyCaaQ==
X-Received: by 2002:a17:90b:3c89:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-3408305863fmr23514216a91.17.1762259799323;
        Tue, 04 Nov 2025 04:36:39 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599f14bbsm4565467a91.13.2025.11.04.04.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:36:39 -0800 (PST)
Message-ID: <ffc08b98-403c-4d29-abbd-b599c7c5e3d7@gmail.com>
Date: Tue, 4 Nov 2025 20:36:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] block: add __must_check attribute to
 sb_min_blocksize()
To: Christoph Hellwig <hch@infradead.org>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
 <20251103164722.151563-6-yangyongpeng.storage@gmail.com>
 <aQnd4-RRe4K_b4CA@infradead.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <aQnd4-RRe4K_b4CA@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 19:05, Christoph Hellwig wrote:
>> -extern int sb_min_blocksize(struct super_block *, int);
>> +extern int __must_check sb_min_blocksize(struct super_block *, int);
> 
> Please drop the pointless extern here, and spell out the parameter
> names.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks for the review. I'll send v6 and fix it.

Yongpeng,

