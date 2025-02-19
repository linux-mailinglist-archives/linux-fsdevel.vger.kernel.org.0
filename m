Return-Path: <linux-fsdevel+bounces-42083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B610AA3C4FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679F6189D04A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760FC1FE444;
	Wed, 19 Feb 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="amoyWiAd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC41FA267
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982320; cv=none; b=Aw4lS8UTHOgo3YBEgkguZe8NqtjN5B6GmYXx/G/yy65MH6XK4MrlOzT7VUHr1mRZ3oXYefHz949QV7XhMH2V2vEYsIdwnSgLOuh0y8nE1xwWRaqfadZoVzQVXCTMbjMsOf2zJ7sBtFRqofPhW9Hme0QCPmAP/OMaZ/GAR4HCcww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982320; c=relaxed/simple;
	bh=BLb3NN4Wc3NjC9QD2aqtccuB2Nrk8sU0QdbLHt38a14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOJJopBphWTkdqO0MHzauq2CxeWt28SVFuprIR9UNOucPrpbkxNTQbhqwBVa+t73asG93/fgi74Cl/RzT0gEaT45Lo4e4tbdpkTlV9QrpEY4sbv7Z0AQYSRf3oUYJJ8+tnyuaN+AihD1Vs3OuDuoGdjNebBOR9Mg8fZqZf0DhS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=amoyWiAd; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-854a682d2b6so508859739f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739982318; x=1740587118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5K4FEOaAuj8ZRtiYP0BTVitcPLRr2Kq/PgjSQHr4YSI=;
        b=amoyWiAdkYTuzw89o0ZTwWEJ+a6WhcsnAzwGpynpD6JH1XL+CYXOxTGwNoGu7567pu
         uKsI3zA5Cq+MjhjZVOCoq2jEpyuHTuL9y1pJrHtQpPhT6wphh5VBUw87+liLQjyi3rOO
         Wtdtjd6o1UQCqoa9YvJMDeRuePdAW5vBKfNU3kKpiJZGMfTFXcFsvvf9H7SHWOGok0CQ
         NAK8H+F5E/j2aX4FmD5Y4Q8wW15TbEfDnjkmffJrq/tkUrSgp36dgMrMueRyLCms1zar
         7nX8vdNLP1ex+nT7Od8LzoFCFj0BOYa+TNLj1SezZe4mSXVmbDbQ2PuA0TFCPbeVdh5c
         SQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982318; x=1740587118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5K4FEOaAuj8ZRtiYP0BTVitcPLRr2Kq/PgjSQHr4YSI=;
        b=DNgR4l2TOr/RpQLnRzbcAfSf69csEqseaVFW+NZsnkgUd/VUU8tjLA8opZ3MVOSwMU
         fDBoOcGwIaesLEaKspGXAJ2c347K2h634hEGWhQTELzu7o36iPpI8vbxzDwQBw3P7s32
         VxxvvA89RBxKSJHM5PxBlToUE//vIlxSNny95CDgc7nhXVAEoHAmDa40yqLPbzl2XGv0
         9SzNqqzi8rBcr0ovPj7hd0qdxpbEMES7VhMZv12SD7vQpz1iE7FP6MFBy/fpI+LO02Io
         UKgdBJEzTxi9cbM0JTouSrroiUouRIHkVkS+DI+D6lhskyWk28GwFxFq2HY7xwbTPfqL
         I4nw==
X-Forwarded-Encrypted: i=1; AJvYcCUFbJREeL18FiHasQX8KXln4P9OXSUhhcTX4flhAZjoAYS0IXlkWc07kEbyp8zMoCuG7KXWezkTvkPJf4QQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvekbd5fcJtzlA052nKvvBTkbJ/++J6ejE2wI34LLkcTXhM3yF
	6IorfetdupBdvCTShMZ7berbt7HvTA9/IXyjcybYrxcudwbRD+LDEgemnC6GPdktJK8AqfBa262
	A
X-Gm-Gg: ASbGncu+As81/IFmlXxHfNzIia+fkx347c6TkxWVnmnvmjsYZLgtxMPRJYcHcIInARR
	1skjQxq79Wpf1Vm/qEbHbZ4LGWc1E8Kjrrdp6L2o9NV6rhFG77k0WroL1Dwh1VhBsO0//ISFWAZ
	VYjgDvtRxLDSAmQPUHM+RSAg6eypmbgT9eOo9N6wZnafzmLgu6aV8J00yfp6Ou5y8zrE8ocSJHx
	dQmsm2N9NdMuQjaguYNupypv/zxeCS/urHXrq0cwUtOV51GET57Ta9s6+UqszRLYYgoCOIJSKfF
	V5LtXpi3miw=
X-Google-Smtp-Source: AGHT+IGzDMxDRSO7tIzCZYHTeRIrYyJDa2dEbxHA0GLL6as5GUtS88pFw3LkO+acUE2TeDls0mZXYQ==
X-Received: by 2002:a05:6602:6d11:b0:855:670a:e687 with SMTP id ca18e2360f4ac-855b396d596mr408445639f.3.1739982317377;
        Wed, 19 Feb 2025 08:25:17 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee903b9375sm1887506173.54.2025.02.19.08.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:25:16 -0800 (PST)
Message-ID: <64379346-a39b-4903-b861-0e25e9e79821@kernel.dk>
Date: Wed, 19 Feb 2025 09:25:16 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/filemap: fix miscalculated file range for
 filemap_fdatawrite_range_kick()
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
 <20250218120209.88093-2-jefflexu@linux.alibaba.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250218120209.88093-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 5:02 AM, Jingbo Xu wrote:
> iocb->ki_pos has been updated with the number of written bytes since
> generic_perform_write().
> 
> Besides __filemap_fdatawrite_range() accepts the inclusive end of the
> data range.

Fix looks good, this got introduced because the logic got moved into
generic_write_sync() rather than being a separate helper.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

