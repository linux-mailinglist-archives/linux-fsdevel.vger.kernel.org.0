Return-Path: <linux-fsdevel+bounces-69653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 620B3C8035B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 12:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E009F4E3786
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F372FDC3C;
	Mon, 24 Nov 2025 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il6R7Iw0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DD826ED49
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983811; cv=none; b=Vn376AZopRJdvpGRv0daqWh3z4ttR9fpIE/scd1fvogpJIlDYL/Zj5aAIk++HwBAwnbcV7oGCqEunmFKSE5WvAc79YE9dQzi6WSCJafqadPsV2GSeDFNWo1HUPcD0wAZg5sQU8JM/cDrYhdtJoZaabZiulEUgJ1Zd7ZXkiGqB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983811; c=relaxed/simple;
	bh=B6c4Rha0j7ElsnG2lldQikR/5+CIYYmoxpK8FQj5Yvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmqGZKEghMw9i23WlOKBDL4WGojTRPqo5zePmKwSwev49sYPaS9t10LhgSRm/dfyueAOQqpX6oe45JZP3ocOjPZo/Yc97hdnmhl9Ya91CxvguBVEO/FAjNB45gJem7eQBkKLooX93mrmA/10Hd7ftAhaigEEkxVMDNQGbZWpuPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il6R7Iw0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47774d3536dso32166395e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 03:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763983807; x=1764588607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FIrNcMo3OIORc59oYq11M7V6LWyQ4cuR88/fqcwGDYI=;
        b=il6R7Iw0Zo1ugXnoYsdVIa5PeY3EJutXCTy2qfnvp4Y7P2EQaxAPQNlUyCU0FyzPqe
         qm1ddhlRIFGey1mqV/PAIwD9VD/1g5IEJJ2OY1y5Ed0DK1pDpmExF3t8Vn9fCCBycxe9
         8ca3bOUEE6aoiCx9FqOnGExGunEML1XTgoh45CY63zrHfd5um4HOLxJOVeq18JLYPFoA
         53MmubmKqyTHbsD/C9g0a1H3ddxQPmgfAxvPwj3s3UFGSJf89teXvj7IcKzYm4wPC/1K
         DiT/AUWvhSB5yE0FY9Md+O2f0EUfipJgMj6Vp77foFQb9lizcNMx+S3hyanevFJg5kSb
         uIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763983807; x=1764588607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIrNcMo3OIORc59oYq11M7V6LWyQ4cuR88/fqcwGDYI=;
        b=TSyIcz6KMddMlelZsJM5nPDLEi0E8UpTCQZjHpmNbEZp9mCkpxESXJMU6EfPv+GStB
         MkWWPdAEsquAOQbgkvj4LdiBj86LlIBPi1NJ7uFebD6me1v5ZPe3iYOpwbz8hEX5Z6H9
         w7csVSdbksvkhrFgCxEUeEcLfprMgHn5LpsmVA+dQfpNzXv34d6SfYJQI3UVUpPqTDh6
         VApqblpViA4deoDnKs1NJM07EH23ullsJaZT9LHziet8RaRzMEEozTsWyEY3J3cJXVBG
         1D718uOLnxjA0KccCdFmH+yPOmmtmZXGj/qrCO5yTmaRKWDGUsx8WEYOHs6B261xfSsP
         P6rA==
X-Forwarded-Encrypted: i=1; AJvYcCXJtnly8ky9jC4tLF2zFG4VZCAB25xK6YpX8xgZRGxSm4xp90jLKXm9/dWjINnJTSRnXGSu/Z4uB9UYugnP@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQRJNr8NB8Gy/oU0Nx1wvnCvR14W0rTDuareulyhsQSjmick7
	OyCwIo71kE+bwoTMisRhn1U+MNvbQyja67suKOgxxhpPslB0l84exPd7
X-Gm-Gg: ASbGncsEzZRNYrrO7LNnY2zcMff9PcPhjT+ERs975iYOz28FXOxTlxQkhxHGkHRf25g
	VFpORxMbTeeEJggjmC8IWArZWMAbCVFehgeZbHYU5bc64j4ksRJiZhu+IhwhUpFAqwrq2cSkptx
	hCHBsc8phvRzuyozDk1288py3f7fnNt1zLMiy4GDiq6uOI0xemMReHBn7fprFZod8ZdurfeLEki
	cQKLVlF7rXisWfpZbsBVEYnqgUK79t15m7hhe2OQM5uo8it5p2yhSnkPDcRz+dqM9QztyjphoWs
	n1YMCkYvr+bQZ3ho/5HhR0imarVJIZWv/23TvwzUel5mVHJNFJkuH6IalItpw9daGwVMVwsIDpU
	yK7+v7UmxlYNlVdsYcd62sEURM0+V1NLL0SBFSUOG6EE6QQFcvVCsAZoieuTukf5WGdKC96s4Ok
	l4rJxor7UB70oiIT3u3L56lSHEPwuBDeX12uuq4A1/rOCTxupDwWmhvumuonNEnoR85cRyBbzo
X-Google-Smtp-Source: AGHT+IH4rhfkRALzBtaC9gdxzf7gjncNKNUbJLJsQNk7iBQd1pjAZr0TQJP790c1nQt2gF0ktavqUA==
X-Received: by 2002:a05:600c:1d14:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-477c026ed62mr113061345e9.0.1763983807185;
        Mon, 24 Nov 2025 03:30:07 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e432sm27351895f8f.9.2025.11.24.03.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 03:30:06 -0800 (PST)
Message-ID: <905ff009-0e02-4a5b-aa8d-236bfc1a404e@gmail.com>
Date: Mon, 24 Nov 2025 11:30:01 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 00/11] Add dmabuf read/write via io_uring
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <fd10fe48-f278-4ed0-b96b-c4f5a91b7f95@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <fd10fe48-f278-4ed0-b96b-c4f5a91b7f95@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/25 10:33, Christian König wrote:
> On 11/23/25 23:51, Pavel Begunkov wrote:
>> Picking up the work on supporting dmabuf in the read/write path.
> 
> IIRC that work was completely stopped because it violated core dma_fence and DMA-buf rules and after some private discussion was considered not doable in general.
> 
> Or am I mixing something up here?

The time gap is purely due to me being busy. I wasn't CC'ed to those private
discussions you mentioned, but the v1 feedback was to use dynamic attachments
and avoid passing dma address arrays directly.

https://lore.kernel.org/all/cover.1751035820.git.asml.silence@gmail.com/

I'm lost on what part is not doable. Can you elaborate on the core
dma-fence dma-buf rules?

> Since I don't see any dma_fence implementation at all that might actually be the case.

See Patch 5, struct blk_mq_dma_fence. It's used in the move_notify
callback and is signaled when all inflight IO using the current
mapping are complete. All new IO requests will try to recreate the
mapping, and hence potentially wait with dma_resv_wait_timeout().

> On the other hand we have direct I/O from DMA-buf working for quite a while, just not upstream and without io_uring support.

Have any reference?

-- 
Pavel Begunkov


