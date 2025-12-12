Return-Path: <linux-fsdevel+bounces-71214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C585ACB9BB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 21:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4824304DA0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 20:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886CE30C60E;
	Fri, 12 Dec 2025 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kMcM4LWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA602D59F7
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570258; cv=none; b=tSJMI8mwpv8foXKqPmUYOHGUrfyZEpJkcsZWA9kLpwSNM5hurfV7O8kDY5bGi5jq7BXnSjpu2Q/qYsdkjfucBQkVotO28l7GT2+kZAcncqX4xLcScQ8/4Tk2Z2s6XNAtuooDIjXsCzZC0EoYr0w7tC2Jc/IgIGZ38um2cgiAIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570258; c=relaxed/simple;
	bh=4gfCtO9+aoCvqYEay1XZJUUI1s50LzgL381O6T7z7FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfW6hGVCImRjQE1D7f/HTaIhGJuvhVocIdSjnq5/mP6zMtf4erXfjIE+yNea6noOjotOPINvebTzjqD2fjZRLyajMnROOq53rmt0WKLoTiVqxkgm/J1R4CoGcnztHdDqgL3SRWPb/Gv1+5HckGiY7GTSfQALJOpn6Amih+UwLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kMcM4LWP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29f30233d8aso9016755ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 12:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765570255; x=1766175055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gsVed5WgXtZPXSfJ2PXjLRbNCmFwRAyF31OH8siBSJw=;
        b=kMcM4LWPOOW5aofuFjI2DOpQEcNRY9pNxIjsXTaODIbDPKMC5FNcR7RvUO9eXo7mUq
         6BsGnJ80Xlb32jsfGAp+kCt1gImNMKb/QKdXHMJzk3bvdv8jJhbJphheaDpf4gyuL5OG
         HydGJQiIETyM9h3gNatOuE/XUa43fmZn6KP8wz9r5te3Ta0LYeDWaXyvX2hZGRTaXuXg
         /iNRw/JmobBVs/4eJJRU3EsIFK6gjThqYZOWcBvyjw/thYYPRJAIm93s1R1dBxjNosQg
         yLY2UQskQxlKMiLFwHf+C19An1ecALJSPCTKVzeWTZrQ5wRsmfgnj+Hjun9X4HRLWPjc
         cWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765570255; x=1766175055;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsVed5WgXtZPXSfJ2PXjLRbNCmFwRAyF31OH8siBSJw=;
        b=QbLvSK9eAQafGDAMTVTVhtokFm2D7Zmx0WJRnL4V1zg8005k7nEAGyfyYlVk7lw9p0
         Yn0NG4FHWvStY0NmWXXU6TYKdUCsuRsdkzLYO2uElfwLwMbldzHiF9PTz83y/TDsvkh5
         Qw12eJEi5mWW9lRA8SqVqTf5OTXbj9b3dWwSHV4Hu+gKE84ye4r1sIU+GDwlNfHo/8sg
         lPMqWn9iixbT5k/s9EXBy67aFQ/AXulXf4jhJAG6p7LHpvrdNqUyrs7GVvw5+tji2Zpq
         p/SnH+x3Vtpb1Qa7pJ5SSd3mTV+6xLYLLXnfrwwv8cmnd/BCcwTN/JnVYyBAyoBVV3d9
         VtIg==
X-Forwarded-Encrypted: i=1; AJvYcCUv2+sTU1s2vzkrHwVeDpMiN9K4JSlOEDvGPqoaVgn3k4WelgcXfH089MguTXUt9Smewr6fQwgY4W62xTCf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw659nmGRFEywHTspjKvIm+Imv3kA2D/pD6FNpI04jhIBmd7ytD
	4a5QaCKGhEz2BH05zaUSjuygm4un0vYG7rDPWYicBePULlHDa7NMukSl4ePE8nh1Msk=
X-Gm-Gg: AY/fxX5SSv4MMVTcL6SyDGJTkcNsiqfh0ato6pQXRA2DmfJbM+bYjg3sxbQZMBOPY6t
	0gLQ8EEnnPK2hurnuyA7hp8XHGVdAOiBFA7qos/oYpDh+Ss5tDz424v0aYFbULiafJSK4/UoZiO
	5AxQM0rFvogOhSsutqlKW7MieWfQmRQhfhUact8j+jKj9vgDLHDzCB3fxERuT0f0zYmmAv5FCtL
	CryaEr7sbbAEYPdkGJ02931CjGF8CBMG+GbEZIEcRqkZawHREBu7nHyEMwaQZJbXyXgD9l7SBeW
	LbjmCIJ7t3SnMy/4a8yAUwBZukE+a33rH1S8y9wW88ky5UbyCXKPyqiainPtxkdbK7pU54bqDRQ
	5lF9CMfamG4jb6mgSyjMtr40yXx29TeZpQcaRVS+Zjy9kW06dRk6YZ0dFpTk2RMum1SNc+nThDy
	uxTdWg/BJmubxypDpxlHS65J9OidX7E43HahaO5B/9TVV/u5d3FA==
X-Google-Smtp-Source: AGHT+IH4YKlBbDeLqTy95z05gm75S6dqOblA2F2FrB859WtV1ZEekn7/gpBPyoL8TMFo+3JpfAzaQQ==
X-Received: by 2002:a17:902:f688:b0:29f:29a8:608b with SMTP id d9443c01a7336-29f29a861cemr19807075ad.13.1765570255065;
        Fri, 12 Dec 2025 12:10:55 -0800 (PST)
Received: from [172.20.4.188] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d38c7fsm62825655ad.39.2025.12.12.12.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 12:10:54 -0800 (PST)
Message-ID: <2729b31b-ba58-4f32-b71a-75bd07524ac8@kernel.dk>
Date: Fri, 12 Dec 2025 13:10:50 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 03/11] block: move around bio flagging helpers
To: Pavel Begunkov <asml.silence@gmail.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 tushar.gohad@intel.com, Keith Busch <kbusch@kernel.org>,
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
 <4ed581b6-af0f-49e6-8782-63f85e02503c@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <4ed581b6-af0f-49e6-8782-63f85e02503c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/25 6:08 PM, Pavel Begunkov wrote:
> On 12/4/25 10:43, Christoph Hellwig wrote:
>> On Sun, Nov 23, 2025 at 10:51:23PM +0000, Pavel Begunkov wrote:
>>> We'll need bio_flagged() earlier in bio.h in the next patch, move it
>>> together with all related helpers, and mark the bio_flagged()'s bio
>>> argument as const.
>>>
>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>
>> Looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> Maybe ask Jens to queue it up ASAP to get it out of the way?
> 
> I was away, so a bit late for that. I definitely wouldn't
> mind if Jens pulls it in, but for a separate patch I'd need
> to justify it, and I don't think it brings anything
> meaningful in itself.

I like getting prep stuff like that out of the way, and honestly the
patch makes sense on its own anyway as it's always nicer to have related
code closer together.

-- 
Jens Axboe

