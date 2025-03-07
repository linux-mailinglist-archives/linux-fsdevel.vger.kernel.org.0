Return-Path: <linux-fsdevel+bounces-43462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EC3A56DBE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 17:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9086F178097
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD9C23CF12;
	Fri,  7 Mar 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vyKWQTtb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9D21CC7B
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365153; cv=none; b=HWep9BPjZW2UU4rWAbRj8AmjsRL2e8K5Y48168hy76NNc/+fuevbfHVWg7PrJs100ow4Rj+5ejE9AdjL3jmHhbUjX/VtlwQjMkaIxl+AiffMWgkfD9OfYqBHDkXu817w3qC1X4BPBidc2rgkylx68oFnL5bYyq3NaGfqz4pZPA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365153; c=relaxed/simple;
	bh=xaiQsJdBQxlDeOtm+4O7NGV7vcMhAxgto+N2EHIhGcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVgpibp8BubHcbCAgvwUVUkZlcfHTxZtnknWFoiODgpzxdqT0q8HiqMpLB+bZmiqEGVwp0/BdpJgj5sNuvq25LytQ3DtGlrXcXYRX3MB/kE8d+MuF8r8wJO9lb0chgnDok7sRESedaczwvmWKR0Y4A4k2Hm/Wgh4IJaisKM0k9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vyKWQTtb; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85b20330706so21800939f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Mar 2025 08:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741365151; x=1741969951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxZG4GvpT+foDYYOqA5R+bdl7vVryacA7OvSQ2kb2w8=;
        b=vyKWQTtbd+945VUGfTn6XAMQm/6HQ368a4Tj1GmAbPPrQIKUSy5VPauOL1P/JqKwsw
         wrvSvXpPDmCBEwpu4Ys8ioo84qayGxXnWaRuCF5Ji6ZjQ2IXZ6mPH9GghKDzjYIHP86q
         H3pS2bbupyf2c73WUD0nDRp1zhXEEEdHvTOpq3atvXSFxySqaFaVO10gcjAUZ1qzK3tN
         d7TugjBBhF6J57AItd5uIhbIonefOjvl2WHj2ZzAOo9vYy9eVeUxwuIV8mSqw5HFuS9h
         LkPvDd1C5I9bLkAmVqnlaaoYSubpeOegb8IQbRbHqVSPX0HC1aIZ4q7E52VidnLfK9yA
         WN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365151; x=1741969951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxZG4GvpT+foDYYOqA5R+bdl7vVryacA7OvSQ2kb2w8=;
        b=tDEfLTpElggsmiWmh03hqufTK1Od3ItwnzSrAet+uDmhJWMECuXTLNKCf3/w3RBHc1
         QsCjPo/j/f1Qg7txgSrQVkDF9ehMtktifP+76CoeXqOFhHTKEDH4QBzLRyOWUzl8jruw
         6/N8mifjHYQKzYJvxQKvVu7SrH6rhvO2B6iLNRHofOqKLRBisEti1DmDpV3q9YHHeBBK
         PQ3ww54gXcyqYYx2g3CDJJGIkosBA15B0vKyjfAK7KzYqrKxBT9VPdV4yOZNF8hg+KVt
         Nlu3zP2ybLbrz1uV9ty5tHU5F8Os6kuggSAaoz6DheLKVE1R0RW85rfKB+LZvmTwvBgr
         CLPg==
X-Forwarded-Encrypted: i=1; AJvYcCXeFkYpabWLtGZsUzSVAPkIQY5m4IQBk5ZaZ5gEi+bjIgBqT4mVOiHpeVMIMoaV5U5bT2+c2XU6zc5hmX07@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/T3Cjar2C8MqP1MDxK//e2aNhMAI+eoJmHAG/2COVqx3MeEpe
	sNkNF9eNZji6sQTjFpRp6Gz7Wabcbhb3YejpEvcekpGoQa6kkG4P0lWCyiILIpk=
X-Gm-Gg: ASbGncuXhnawtDYimCdxiQSpaYo49XDd/wtEwzwpQ1ypDyQGYg+mFuUX8CxDSulBBG8
	/n4/EE1GX7rc/k+SShqcJ5VlKXZGRPAVFNeUDUEvy83I9joGFrwWquEuPq+u2vfx1HWSkVm+zUn
	fw15JIA0KwJKK9c2B/eNGjHp+Q+B0x6khgXsHvZnIUM0DCB+UMZ5J2AMo5S2CbL2XkVdQPV/5vo
	G34q+Z1OsaCXYV+h2tZFsGDhYwAPGYcWfCv9V96czqfWTQl+j726hDULs/hB42/0WpxC44tSJ4y
	BsKo2yrWa5ueCLMcpIHso43kAabvRGymHT3YWFDg
X-Google-Smtp-Source: AGHT+IHrkCLjuVHj+BJlje4EuU1N2OofbZGNyuXaZNfL0mggj9MLt+HfmyCGFOKlxxG5IOS/M2005w==
X-Received: by 2002:a05:6602:3a09:b0:855:cca0:ed2c with SMTP id ca18e2360f4ac-85b1d0d5b8dmr500795539f.10.1741365151234;
        Fri, 07 Mar 2025 08:32:31 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f20a06a6a7sm995329173.134.2025.03.07.08.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 08:32:30 -0800 (PST)
Message-ID: <5a0ddd31-8df1-40d7-8104-30aa89a35286@kernel.dk>
Date: Fri, 7 Mar 2025 09:32:29 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: support filename refcount without atomics
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, audit@vger.kernel.org
References: <20250307161155.760949-1-mjguzik@gmail.com>
 <fa3bbf2c-8079-4bdf-b106-a0641069080b@kernel.dk>
 <CAGudoHGina_OHsbP_oz5UAtXKoKQqhv-tB6Ok63rRQHThPuy+Q@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGudoHGina_OHsbP_oz5UAtXKoKQqhv-tB6Ok63rRQHThPuy+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 9:25 AM, Mateusz Guzik wrote:
> On Fri, Mar 7, 2025 at 5:18?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> +static inline void makeatomicname(struct filename *name)
>>> +{
>>> +     VFS_BUG_ON(IS_ERR_OR_NULL(name));
>>> +     /*
>>> +      * The name can legitimately already be atomic if it was cached by audit.
>>> +      * If switching the refcount to atomic, we need not to know we are the
>>> +      * only non-atomic user.
>>> +      */
>>> +     VFS_BUG_ON(name->owner != current && !name->is_atomic);
>>> +     /*
>>> +      * Don't bother branching, this is a store to an already dirtied cacheline.
>>> +      */
>>> +     name->is_atomic = true;
>>> +}
>>
>> Should this not depend on audit being enabled? io_uring without audit is
>> fine.
>>
> 
> I thought about it, but then I got worried about transitions from
> disabled to enabled -- will they suddenly start looking here? Should
> this test for audit_enabled, audit_dummy_context() or something else?
> I did not want to bother analyzing this.

Let me take a look at it, the markings for when to switch atomic are not
accurate - it only really needs to happen for offload situations only,
and if audit is enabled and tracking. So I think we can great improve
upon this patch.

> I'll note though this would be an optimization on top of the current
> code, so I don't think it *blocks* the patch.

Let's not go with something half-done if we can get it right the first
time.

-- 
Jens Axboe

