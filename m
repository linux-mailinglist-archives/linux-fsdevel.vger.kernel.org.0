Return-Path: <linux-fsdevel+bounces-52648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34165AE53B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 23:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C084A8406
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 21:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F329224B0D;
	Mon, 23 Jun 2025 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="RFIrprQo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF26222576
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715738; cv=none; b=SALt4+YGUjzbUeDnQv6VXn4nU7igNeIeva3a6fpGkt4T99rndfgzq91RP6gyZBIqN8+4Lu0lKZxZ9RZXRZBKSiHS/hRD+nd4g/92d0SAoa7AMlrZLHnynJpWuBVznqBxH/zDIFeQlNpPVAme39e+hHXsihRtEPsXv3q4Tr7uxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715738; c=relaxed/simple;
	bh=DsdA8p6fMi0EXta+h2G59IrZpD7tOMcrnb5T/xBTw48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWnROAfpJ75G2OTF8zCd6FknX2D+Fy+eDgUZGi/2py3YNVCiuPY/rL2hoN8bHJdrVs9cm1HJ46G0kQR9Wq4uPMlhHC71UIo9bE3Redo2UDcDlcpB5lmKO2YzhsNWNL5EW5683qqURzx3WJqP4mrga65yIuFQudbkhetdPFVSvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=RFIrprQo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22c33677183so42995875ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 14:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750715736; x=1751320536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMkt3sKHcTISfOfNYxfInls3GFiXE3FxPj4VgFFGQtw=;
        b=RFIrprQo+EuyEM0N8c7sIDleWGQ730695ZOw3k3FTIvXcAVZNKv+zdKI7JezR6aSWc
         jb91p/vDaRBem5NMqHwaohG6gRK1s7Qw/xo5mhP3J9dEw5Lj7DpszeOpFmbVrxIb0Pol
         eS4wEVpqAa7sei10KtX0j19Q9LKrABIer2fK0wjIWdSfSP82mmXg2gZ1bUCo5hztmLbF
         1LmDblJXIj6oyQ/igFlqT3mprG+bTPop75E3VSR42hTfaTw+4QQP9UYrtzDki8YX14ll
         WnEvNQgyNifwxoajVP3bNirhy8WTmO1+RHMC2+XCKTil9bwnJAvr7psweFuKdgJUhUyx
         bG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750715736; x=1751320536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMkt3sKHcTISfOfNYxfInls3GFiXE3FxPj4VgFFGQtw=;
        b=llX1t5CpZ2zsaKEy8L7Y6vIcxk3wgL7dULbx57Ye29u7CkdVdDJHxIqaTYk5FpE95j
         cJL1D0O4bqfaEfhqbczGIA2TtNrAdi1AOts661jJft4bZJLD3++lDNBqCOvgzHpwKDdy
         G2VYtWgnXSLvt3AlPGRs21kqSULISWBPAGqiCWfznl6EaqgSFK+XkbLPLQWBpDklYxNM
         aG/KtUr1EYNIekUOdcI4WYTyJDDP+r1fuh0be6geClbKwh/nPGb8xqltBYD5NGqkWLPA
         C59YmgReog+1BSoK/GVNzHOoPJvuK0N1DlPCHcJkC8uTE27EzWEsCd3wy1s+eEPvhzC0
         1ssA==
X-Forwarded-Encrypted: i=1; AJvYcCUKD32dU2Nc/KL9h12fj1T9EV0reoYol33ivhDPzapzx8wz8V3zzfr23TEGbd0McPPonk/u7MJC4TNF1wic@vger.kernel.org
X-Gm-Message-State: AOJu0YwwLCdOKALXGlLBXsHL4MfqUnTRc2QF+WyJetcNWMLv+bxCIxlX
	BwZ2rrRV6A6zMn6Fw1lZdM6o9TAFArOz9jh/dGJHXO8cB4V+LrfM3m0ORkC+dzC6BZ8=
X-Gm-Gg: ASbGncv1CJRaPn7KArRtkcQ+xADI3PJxznP8x23h6tCAec2EuB1mYQjx7KO8/FcpoTR
	Pi4M2xn4GpNvTTQZAfHyjDgLfDx/BwYap561wnIuSgLWShjvPrs8qfAdVFW8elCxdb7n60wcdZX
	fT6N4KM/egRR3SX7l+LW55+QSNX6D12p6tH0657OS5n94ZmBkW3fqbLqohrhkcKOCDHws0v3UZo
	7QL7NEKaQhxgZT4h1vlDntaAY64Vz7XXchqhC4a+498bgtZCvdk0la6Yu7lef8UG6pBah0wAX/g
	iZtdmVZ5jVS+1ZhX9CrEieb0PprQSNKyz2Yf1lX9slZ8vN/iFN2dNuYYrII1AqjYVsWSwBfvB4s
	4/0WcHjaohpEt/r/p6rjuXZAL61bcwQ==
X-Google-Smtp-Source: AGHT+IGIN29KV1YBd6M2+FDnT2jaGx9K3hVgEGgQ0bWegri+hFBPPmvpSZt8YPHO3OtedUZXS8ulEQ==
X-Received: by 2002:a17:903:19e6:b0:235:225d:3087 with SMTP id d9443c01a7336-237d98fa35dmr183164635ad.30.1750715736410;
        Mon, 23 Jun 2025 14:55:36 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:14f8:5a41:7998:a806? ([2620:10d:c090:500::7:1665])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83ce2e3sm92824915ad.60.2025.06.23.14.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 14:55:36 -0700 (PDT)
Message-ID: <f966d568-f47d-499a-b10e-5e3bf0ed9647@davidwei.uk>
Date: Mon, 23 Jun 2025 14:55:32 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/17] fuse: fuse-over-io-uring.
To: Bernd Schubert <bernd@bsbernd.com>, "xiaobing.li"
 <xiaobing.li@samsung.com>, bschubert@ddn.com, kbusch@kernel.org
Cc: amir73il@gmail.com, asml.silence@gmail.com, axboe@kernel.dk,
 io-uring@vger.kernel.org, joannelkoong@gmail.com, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, tom.leiming@gmail.com,
 kun.dou@samsung.com, peiwei.li@samsung.com, xue01.he@samsung.com,
 cliang01.li@samsung.com, joshi.k@samsung.com
References: <aFLbq5zYU6_qu_Yk@kbusch-mbp>
 <CGME20250620014432epcas5p30841af52f56e49e557caef01f9e29e52@epcas5p3.samsung.com>
 <20250620013948.901965-1-xiaobing.li@samsung.com>
 <7f7f843e-f1ad-4c1c-ad4b-00063b1b6624@bsbernd.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <7f7f843e-f1ad-4c1c-ad4b-00063b1b6624@bsbernd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-23 14:36, Bernd Schubert wrote:
> 
> 
> On 6/20/25 03:39, xiaobing.li wrote:
>> On Wed, Jun 18, 2025 at 09:30:51PM -0600, Keith Busch wrote:
>>> On Wed, Jun 18, 2025 at 03:13:41PM +0200, Bernd Schubert wrote:
>>>> On 6/18/25 12:54, xiaobing.li wrote:
>>>>>
>>>>> Hi Bernd,
>>>>>
>>>>> Do you have any plans to add zero copy solution? We are interested in
>>>>> FUSE's zero copy solution and conducting research in code.
>>>>> If you have no plans in this regard for the time being, we intend to
>>>>>   submit our solution.
>>>>
>>>> Hi Xiobing,
>>>>
>>>> Keith (add to CC) did some work for that in ublk and also planned to
>>>> work on that for fuse (or a colleague). Maybe Keith could
>>>> give an update.
>>>
>>> I was initially asked to implement a similar solution that ublk uses for
>>> zero-copy, but the requirements changed such that it won't work. The
>>> ublk server can't directly access the zero-copy buffers. It can only
>>> indirectly refer to it with an io_ring registered buffer index, which is
>>> fine my ublk use case, but the fuse server that I was trying to
>>> enable does in fact need to directly access that data.
>>>
>>> My colleauge had been working a solution, but it required shared memory
>>> between the application and the fuse server, and therefore cooperation
>>> between them, which is rather limiting. It's still on his to-do list,
>>> but I don't think it's a high priority at the moment. If you have
>>> something in the works, please feel free to share it when you're ready,
>>> and I would be interested to review.
>>
>> Hi Bernd and Keith,
>>
>> In fact, our current idea is to implement a similar solution that ublk uses
>> for zero-copy. If this can really further improve the performance of FUSE,
>> then I think it is worth trying.
>> By the way, if it is convenient, could you tell me what was the original
>> motivation for adding io_uring, or why you want to improve the performance
>> of FUSE and what you want to apply it to?
> 
> At DDN we have mainly a network file system using fuse - the faster it
> runs the better. But we need access to the data for erasure,
> compression, etc. Zero-copy would be great, but I think it is
> unrealistic that application would change their API just for fuse to get
> the coorporating model that David suggests (at least in our case).

Similar for us at Meta.

I have been toying with an idea of a solution that does not need (major)
client change and does not depend on FUSE io_uring. I think if it works
then it will be more broadly applicable and useful.

I'll have something to share soon.

David

> 
> 
> Thanks,
> Bernd



