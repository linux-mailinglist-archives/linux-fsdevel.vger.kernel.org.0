Return-Path: <linux-fsdevel+bounces-69790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 270B1C84FB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 13:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42E244E9444
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2325331CA5B;
	Tue, 25 Nov 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9x+YP9E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055742D8363
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074112; cv=none; b=DW6VcjSvHyhVwKQ50O5OMZcc7+5rPDAT/Nm69YfrPxbJx3PZmubEOUD/arUMXlnyoDM8VeAMoKuTjEp364SvsSYF1GJtu9E177mHHJ5ttMwE5YfNOLo5CTKhX6X4v9tJBONTDV+ratnmbWomefOVhlBHkWc8ONpu+GBUw+7lot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074112; c=relaxed/simple;
	bh=9KhMQtglvgwFLq0EERoB1DGsMk7bVLgsTiRTkQIulec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrmkjB4/yaR37trl74eBjzp8YSA44bcMnCQNUOdFnZaTnVFbJSJGiDxQib76T1fFuTX9OF3cnUF/dh/tgMWw/LtWQJlKqzkI9j/6IO+r2q9pl7Pcm/6CUbJPmA3J4Cx0gsxluuIIy22JuxJHp/FpdSipIIZKixpjWqTm6i9Ffx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9x+YP9E; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso33082485e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 04:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764074109; x=1764678909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=siB9qFjab8fX+nGosH2txh4HIYoNVo3aqhU42WS03o0=;
        b=P9x+YP9EXEnC7MMe0F5kk8o8F2AB7xaZa3E5RBDar3rlAchOZ1QM38zsIjtdEMifEG
         +3hXpND37T/LymWCB8VBxtGVRlPmm1kjRs4JlZm7WwVdlyfNz34bjzaDAwU2hbzWk2r4
         +FC5ikpPr/GNlJ2R/6WgiDYkS28IpAopY4azIg/V1BXMSzBFaDQ2gJ0YRLLUbTaOUiuy
         8ulPp6kL5/nmLgahc60VtlvC/WdwEuyYxJwlYlvCnwAdC00hO6zjNlDm7HmKnnfRxJvA
         WJIhjwxihIeragaJP9AetoGmnIjR7ceg95L66JS6cZzekSQdp680VNlYWm1JHvdwoWIq
         1bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764074109; x=1764678909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siB9qFjab8fX+nGosH2txh4HIYoNVo3aqhU42WS03o0=;
        b=CKyi8TYPKF19jDLdWCKtNv9h14078+wcNhs7DevmGWs5wtG8ubIJ4d/QJ4WDsY0Phy
         BdurusVBRLJi6LqmEIov9f6p/1oYHifIynPTbIqX9MXUKjLiRoq0aNOWer/qWbQmqmtD
         z2mjAX+BJYLZpVy2vv7FSR/4zTC0A4qAU89nigngYizs6h3cPW11cD+PTPmUaMTOgMLg
         snMSzQmm9AErs3u2dJmA1h3/5551rgp2I/2e67NLdTPo5vywG0SM92/7EMNCW0MkMJCk
         sutuwRWZhj/221wo9NioqD4Ddyy6iqBdUnC2Bni3grBY/rUC019kcky/65hXf6rH/OTO
         l0FA==
X-Forwarded-Encrypted: i=1; AJvYcCXjgX+7TJ0uls0Lj7Ye2InuAxQgwAw0vfgZQIzvqAb7rx2V+1YNB1oOM5aTRVWY09iSeys/DpKSghA0U/JX@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcfuTOGWv5ReST+9JhOc1oASYB+kioGi09/y42NWhHoShH+uK
	fOFakY6notPGwX5Ghmv+2qZ+66P4qYRPn8d6tUTfEfixkq0mZ6rry0r/
X-Gm-Gg: ASbGncsc+qf5ZQgfkqKSEhqvOcQDxiaGCrxEe+tG47KgJ1IVyyfNakpvFP75Wba55u4
	cpZIjyWchuQyFYBsaaRCEkPCjwBoZ4CkopbXQKDRgWnKVXnJIoRpH6ety+Y8BIt2/qeKCpT1Wim
	IOcpR5iZA4IzB7K6L6P+foFb957JQpB/hZ4tyKMOZ2x2ut8crNg6oPL6gStWgVfvapLZWfsBsMM
	4jcXESJi+3RbnZzpKxCaq3+ea25Fkgj2x21oxBY5sS7ODjiwHeHCfW83Ul3+h/6MO0UhoX5PqEL
	OnpoAIAhAuEMGjd7dkHyAOhmCcK+wk8XiBhfXxrFVzfc0gql2VmBkvvgqjl2vczb9i8u1g5pS8S
	jWlSt+6M3rGaWieNThyFsfqkrVxI4YIsx7aCJ2YMyR4X7ARaOL9SsOpf1FVqc1P4zBkEM4OX6Nw
	UHvF4V5eVfUWop+E8nahhXo0q4i7poZdkSm0KnU9fq0U6OSabbQpDEBoPq47Kzrw==
X-Google-Smtp-Source: AGHT+IGiAByXWX/VuXJ575rRIj6bTeEbAlnebab6FY0vB4jAmRqS6rohlKvvoUgeChvVCplBX1c2lg==
X-Received: by 2002:a05:600c:1d1b:b0:477:9671:3a42 with SMTP id 5b1f17b1804b1-477c1133e4bmr159739175e9.35.1764074109236;
        Tue, 25 Nov 2025 04:35:09 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb919bsm33941871f8f.34.2025.11.25.04.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 04:35:08 -0800 (PST)
Message-ID: <1f8b5e97-1f3c-46f8-8328-449c159b7d66@gmail.com>
Date: Tue, 25 Nov 2025 12:35:06 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 00/11] Add dmabuf read/write via io_uring
To: Anuj gupta <anuj1072538@gmail.com>
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
 <CACzX3Au7PW2zFFLmtNgW10wq+Kp-bp66GXUVCUCfS4VvK3tDYw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3Au7PW2zFFLmtNgW10wq+Kp-bp66GXUVCUCfS4VvK3tDYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/25 13:35, Anuj gupta wrote:
> This series significantly reduces the IOMMU/DMA overhead for I/O,
> particularly when the IOMMU is configured in STRICT or LAZY mode. I
> modified t/io_uring in fio to exercise this path and tested with an
> Intel Optane device. On my setup, I see the following improvement:
> 
> - STRICT: before = 570 KIOPS, after = 5.01 MIOPS
> - LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
> - PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS
> 
> The STRICT/LAZY numbers clearly show the benefit of avoiding per-I/O
> dma_map/dma_unmap and reusing the pre-mapped DMA addresses.

Thanks for giving it a run. Looks indeed promising, and I believe
that was the main use case Keith was pursuing. I'll fix up the
build problems for v3

-- 
Pavel Begunkov


