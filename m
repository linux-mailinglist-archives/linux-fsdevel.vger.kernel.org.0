Return-Path: <linux-fsdevel+bounces-20078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFA48CDBCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 23:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5671F24938
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 21:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471A127E17;
	Thu, 23 May 2024 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1EJCUoFe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5980632
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499082; cv=none; b=IHbzTG/e3EwjOXNxnJENvZO9vWoJoLAyBf9dZsVFlet10SeM65Cf8Oz3btE+hTtg4G2y4T+dWA7tYl1EvCVOTVxIFVFw6POuMmDBlBbreTrc4gDtcdFRaotdx2ecE2RvIAGZEzCDqhpz0kr3VEuvchIiExmfgifKSkAFUsb0VGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499082; c=relaxed/simple;
	bh=E60KwS3yfBOzkwDT676+MM7o2Au2xZpAQhVcMH8quk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTxHsp8nCRTNyfDwDU/yzanneTO4yd/0fEf6hTnW4xgOce/rUz/Nb88IbCCVgbHGKJtD3lhOqEnTP8GbQ42e19iUO7w1OWbALeHS9Js1xp/nBrNyFB0vB7HmGidUx01+wo7xL7KaLF/YX26tlrmck+2hAo/qblTZgUyRsc8uB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1EJCUoFe; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2bf5bbacc32so43457a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 14:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716499080; x=1717103880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9x2cAYxI0ME8fv/6TArJaYakWUUv/hDKd/KCixzGcGs=;
        b=1EJCUoFean3bnHgKvXUnOX3TLVmm/BBxsxVr07pJaEDNZAzBuXKsLWDTR9Dz7rjiQ0
         XdXHvjvFtYY59M+Mao2Ung4emgC/TxKH2EhTVSz0DbaPz7AvSmM+iACmIa5Y7fvlh8OY
         gzB7gV6nVu194iR8tSgfpglaZgv9K5jR+j5ykpigpLcjQepI/3XGK7nnkiOh/wXT5xde
         jJpRohJ+MkxGrdiih2Lm5yQROq7MwglZc81M8TVMd6yxpYD5TB0/0Pd1s/Iw7gBwlykn
         7vGBVfO447ZHpZwox7YdSYB99lOecRMPbqphwPkOFakffaSICww344Ypf/1GgnRY16Hl
         Fd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499080; x=1717103880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9x2cAYxI0ME8fv/6TArJaYakWUUv/hDKd/KCixzGcGs=;
        b=iV9NeSZsKilCiVm7hnBnX1hpjjV/H5j+1pgbkv2qpdv1dNyxpAT/l5m+N+gGHOKJi5
         YcvX/lcOLkFxaWex55hLjmSgcI2+GKHKVFMXkptxi7+vDVdMP9tQd8eLdHIz6LusCWF0
         xu4uUFdXjhE68stITvOHGIkejmm8fr3+omezgOT9/oLY7/LFasZeKka2UdEgS/G0j2oA
         T7bNFjLwzbYC4eQLhXFOIDqzqw+HefAxg0qiZdGztqvgdc5CEj/sDOfXMeXj1/Vc/akU
         Lcv5rSkHV3Bi+1L/e90a/Ceu5AENZx7jWjP6Ep26U5PX2YIUKn6vPkfPwSsIs8uNtYLZ
         zfNg==
X-Forwarded-Encrypted: i=1; AJvYcCVdYIhxeh8Y5WPM4SJjoyhG9/qEToEsqUnz2RF0UzGA1GQI9X4fLf5KdvnEF0d9WcRElhZH8pCIIzDFfo9DmNoyfArDG11IlvWxMkmFOw==
X-Gm-Message-State: AOJu0Yzc05FXaA6ri4T8c237hIZKMsYCF5ENp+gRNhEEnMYUgu3G3zlN
	OLaz7r6+R/r6CMYOATEwpcLi9zaOBHzMc19vYo/dNieuEMSQ+M323KmpJf1lTFjzICv5CKabP/q
	Q
X-Google-Smtp-Source: AGHT+IFPqXNO2VTX9Iyl5b1hKWGjN4iFLAdSovpsW5p3GBc3XUAB5wletIeCTP0MBlktWknbXZLtlw==
X-Received: by 2002:a17:902:e801:b0:1f2:fbc8:643c with SMTP id d9443c01a7336-1f448f2e808mr5711575ad.3.1716499079957;
        Thu, 23 May 2024 14:17:59 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c1::1060? ([2620:10d:c090:400::5:32c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c96f26bsm346775ad.127.2024.05.23.14.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 14:17:59 -0700 (PDT)
Message-ID: <359117d3-20e3-4c1b-a426-8ec1391ffec4@kernel.dk>
Date: Thu, 23 May 2024 15:17:57 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: invalidating pages is still necessary when io
 with IOCB_NOWAIT
To: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
 Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20240513132339.26269-1-liuwei09@cestc.cn>
 <20240523130802.730d2790b8e5f691871575c0@linux-foundation.org>
 <Zk-w5n769fyZWTYC@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zk-w5n769fyZWTYC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 3:11 PM, Matthew Wilcox wrote:
> On Thu, May 23, 2024 at 01:08:02PM -0700, Andrew Morton wrote:
>> On Mon, 13 May 2024 21:23:39 +0800 Liu Wei <liuwei09@cestc.cn> wrote:
>>
>>> After commit (6be96d3ad3 fs: return if direct I/O will trigger writeback),
>>> when we issuing AIO with direct I/O and IOCB_NOWAIT on a block device, the
>>> process context will not be blocked.
>>>
>>> However, if the device already has page cache in memory, EAGAIN will be
>>> returned. And even when trying to reissue the AIO with direct I/O and
>>> IOCB_NOWAIT again, we consistently receive EAGAIN.
>>>
>>> Maybe a better way to deal with it: filemap_fdatawrite_range dirty pages
>>> with WB_SYNC_NONE flag, and invalidate_mapping_pages unmapped pages at
>>> the same time.
>>
>> Can't userspace do this?  If EAGAIN, sync the fd and retry the IO?
> 
> I don't think that it can, because the pages will still be there, even
> if now clean?  I think the idea was to punt to a worker thread which
> could sleep and retry without NOWAIT.  But let's see what someone
> involved in this patch has to say about the intent.

Right, the idea is that if you get -EAGAIN, a non-blocking attempt
wasn't possible. You'd need to retry from somewhere where you CAN block.
Any issuer very much can do that, whether it's in-kernel or not.

It'd be somewhat fragile to make assumptions on what can cause the
-EAGAIN and try to rectify them, and then try again with IOCB_NOWAIT.

-- 
Jens Axboe


