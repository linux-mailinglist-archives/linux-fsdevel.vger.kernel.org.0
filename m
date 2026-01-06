Return-Path: <linux-fsdevel+bounces-72543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA73CFADA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 21:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0245A308FEAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 19:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77C5352F86;
	Tue,  6 Jan 2026 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEK7fZu2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22BC352943
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767729079; cv=none; b=dcg92+125INCFExlSuJvd/Vwnrcwxr5fsMFM1BdVRuzXpbp+PFFw232ToYpa8G7wKSTcbZGkNKjSLuca5AhnSO0xSOFJ98TBaHmDctBip3yQsor113KAFunVHJgZWudgYZUzW2CRvWoQxrNfAgHieP2P5YRlwCEzGJ6b9sJkGdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767729079; c=relaxed/simple;
	bh=lHxyhw/2ECuTZwsuxRhqHF7q0GnOP8IQA1gLR0EAaao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmpeE2l91d3Tq5AtQSpjAyLVgg23FoGWadTJMHAXfRHH4CcRp4FMfavr9re2cDRg2s20WXuMjlIDgmjUatXrrl5yHFySgvvF4mBkgNO0Y6B9Du8iyvymvGyeTjqOAUX8DGyXHBef7rx87NJn7oavIgKc+iuEM1+23Of/HyuNCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEK7fZu2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so991093f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767729076; x=1768333876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovZgk8PxCrhilP9ak1FB2YkidalwKuZZczfXtCx59dw=;
        b=GEK7fZu22juEKoMqHTh/UIQCo4vg9eUE/aRaG+aroaUaGX1Hv5Cti0Y8ZBvTn83WIQ
         Ls+PanyNnhvdqk4FkLhAPaSlTOMwHvQz0BAyeT46JdzUNDy6AbV6rTyI/gF9J9ltRxQ5
         qQKtY3ADsKUoiiqQuAc6iLAaXHHQj3APDu8qfY6CGTwfxULvFgzUt0Yx6iWD2Tv+wqgC
         0iUtJpjmjpcH+67hgqPw65J/VOliFYZs/vyoD43mZ6bjoPWMORsVyYRgj5Nn+oeG3FUP
         GSN1QGMlv/7TY0n7L1xX9WelJRxvHniTArdGNPMX0jolb1OSs70TS64tYQr0nq7zMfY1
         ugBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767729076; x=1768333876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovZgk8PxCrhilP9ak1FB2YkidalwKuZZczfXtCx59dw=;
        b=ObxKqiM01ARZtcjfKzsFNzQHfDKLb+PYLKuGGBnc371afBRzRquETdQaJCWaxdJFAJ
         6pLCuZ7xjexx1tGymLqFUaN7FP0LUG0Boea/uyZ42jFfWtVs3XOsL8VLaJHvI+f5r6WJ
         fNkvWTOnHNJf3x7wGDgPqwSR9858nQfu2bq8omAwxB9p+bbmqzpeddLa1X5NtsFNEimc
         kAZ3+hwPO6Fus8Bv5JhzBxLCevgOT5TThy5cHNmKduy6i9FC6UqOS7SMkkiizjew3yk7
         IbAQOqjlpBwokhm5SOepHY74Rmdermm3xl2TNDO/ic/gaUfdRrxM8kCS8ELWG0Mr6kj8
         XnOA==
X-Forwarded-Encrypted: i=1; AJvYcCUyl70CO5APa4eXFBqSWhry0gOs/5rgnzydXXL+nPLosW82lwreHlK8Z+U/f/zBf4A8E86iyUGrRHTpfnry@vger.kernel.org
X-Gm-Message-State: AOJu0YyEb1kU/6MOGYL+384uksk5X0ozTt7kL8jN/MyvNFcg0aa1gWg1
	4kbjskx7I403WYRQKo7OX9PkwLZDwWj/MrVTgeGaBdYoNQN8NB9F5GWB
X-Gm-Gg: AY/fxX4VsyKDFMj40PDEGvjJpXcDiQUHAKAee9VJSUZX+iBzqreLf1a1nB3LDu/NDJX
	j2j8/3al615jqSduuWp+ZMc5PMu3fyzU+FGgQFw+QHyt0oasXO08IrbzKwGO4WksUHdz2IdM3J0
	bHIw6ZNUFuJdurp7S/sn9EButTx0pbAWUboa0QFpSXS2q6TpMoFcnwCHtXfxDOGUeiZY06TjKxx
	16gPqYOdSKi/368sBapk1UytQo44wFZxVDD1Zj8P9AkgaEw5bSKMqAUQ5StFktKphCdFmWaZRUc
	OkQSP+23ko8/Ws0rMink2BTT1JZA2dscY3tesquyDrSFrftoKMN5SXA9XG90FJ8xoIYOGHOEwsX
	9oouBkg++wBWPwu8aLymBVIqLanCfckUfyKHiQsMmAZ/I8E1GR116ekd8Vq/6J4OPHwSB3x0yKI
	OO/OROzUW6y7CX/NYVXZUOtVNgwQgsEwBsudqnhaUeuL/rJbeG2QIQoY6SP2UdbtyprkWED0kKE
	Inf2beNqJhKPx271IVHdUlvZ/BsmuV/umDZZyhjw7NBWDtk9gupb+Z5zr0x1ORQ
X-Google-Smtp-Source: AGHT+IFFym+HTWb6WhRU4bKfzHds67XbzvjVQ0ncM7+fS6yOVWLogcdaslK7a3BF15xU4e7GXQY5lg==
X-Received: by 2002:a5d:5f51:0:b0:430:fdb8:8510 with SMTP id ffacd0b85a97d-432c3790ca4mr333772f8f.24.1767729076041;
        Tue, 06 Jan 2026 11:51:16 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e19bfsm6241105f8f.18.2026.01.06.11.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 11:51:15 -0800 (PST)
Message-ID: <a96e327d-3fef-4d08-87e9-c65866223967@gmail.com>
Date: Tue, 6 Jan 2026 19:51:12 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 01/11] file: add callback for pre-mapping dmabuf
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com>
 <7b2017f4-02a3-482a-a173-bb16b895c0cb@amd.com>
 <20251204110709.GA22971@lst.de>
 <0571ca61-7b17-4167-83eb-4269bd0459fe@amd.com>
 <20251204131025.GA26860@lst.de> <aVnFnzRYWC_Y5zHg@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aVnFnzRYWC_Y5zHg@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/4/26 01:42, Ming Lei wrote:
> On Thu, Dec 04, 2025 at 02:10:25PM +0100, Christoph Hellwig wrote:
>> On Thu, Dec 04, 2025 at 12:09:46PM +0100, Christian König wrote:
>>>> I find the naming pretty confusing a well.  But what this does is to
>>>> tell the file system/driver that it should expect a future
>>>> read_iter/write_iter operation that takes data from / puts data into
>>>> the dmabuf passed to this operation.
>>>
>>> That explanation makes much more sense.
>>>
>>> The remaining question is why does the underlying file system / driver
>>> needs to know that it will get addresses from a DMA-buf?
>>
>> This eventually ends up calling dma_buf_dynamic_attach and provides
>> a way to find the dma_buf_attachment later in the I/O path.
> 
> Maybe it can be named as ->dma_buf_attach()?  For wiring dma-buf and the
> importer side(nvme).
> 
> But I am wondering why not make it as one subsystem interface, such as nvme
> ioctl, then the whole implementation can be simplified a lot. It is reasonable
> because subsystem is exactly the side for consuming/importing the dma-buf.

It's not an nvme specific interface, and so a file op was much more
convenient. And ioctls for registering it into io_uring would also be
problematic. I simplified some of the layering for the next version,
but most of the complexity comes from handling in blk-mq-dma-token.h,
it'd be same even if made nvme specific. In fact, I had it all first
in nvme but then had to move to block/ because of sleeping.

-- 
Pavel Begunkov


