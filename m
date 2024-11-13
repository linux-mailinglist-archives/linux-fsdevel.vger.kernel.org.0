Return-Path: <linux-fsdevel+bounces-34649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C89C7369
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B8CB36211
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BC220409B;
	Wed, 13 Nov 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x/Ru2AZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73705200CAF
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506845; cv=none; b=JatlZV0YTUXp2WANsmVORC1GRp1qottfMGiHTVZu0E/aLlZL7ZzWn6+VF2BPxCEptfVziV7CWsMm2Dfe+KltQ2kW61a2DuiNLEFMfKtX04WZoQtCmY3RNFZqKBDFvDPYtckB1+/fcw5Jy3vU3qjPjTAFYAjjZfb1uC8wZB5ybQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506845; c=relaxed/simple;
	bh=ykh+gbXXjUPYIb0/IDp+NZWtxDsg78jTSltiMDxCiP4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=unxpmbzPcIcirA+uuLZME+AUsAFel5KODUBQ7gzZN29Qbq358jsxJOM22TLZREeLWyJEWGgELSB9KD2GU0a6aH09QI6bLdotqK8LXFv+dpevqV0DXsUfYjNDydHPeGzPzZlMDu6J31FwOQPbopnMArwuzVuJmeOO0uK8/aiZx0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x/Ru2AZs; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-28862804c9dso427555fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 06:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731506841; x=1732111641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C7W+yd2pa7dbAq2BPJ7ZVQ3S890XNBOMrajqML3cc6g=;
        b=x/Ru2AZs+B6HVBItb0dwyPIXrvILulKExUQTlvjuqZUo6FstrNDUTGntOFKUyva+sO
         FXRNqmvwBlv+N6sR/cqu51ga8u803o2DygizRSG9nSg+R2JgPZnNKCE7so5/omwP24wd
         d8Tl2edy6WBab9PUMrJ0SMG0t/upmko6iVogDcna1EqMjmUtbFnlcLOSEftxPtmexiIQ
         WY1K6RNX12nWNSuJL4lFcIJgwqODcinbAuMuq12zctXIcLgT0Kso3Zd5kYTHOuuZBFSJ
         V8Q4ZBxtj90TbZYizD9LfVommFAtjG3uMOO2fPWBuUlI5DYtcL5KFduduRhFE+wNnO1R
         b1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731506841; x=1732111641;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7W+yd2pa7dbAq2BPJ7ZVQ3S890XNBOMrajqML3cc6g=;
        b=XPw1x9EwqaYPNBohBBCr5h7AuH2Zoqnekn4cFzCaiWg+jbSwyoZfgzWyHspA9zfHZq
         OaifzVA8cOWdFUxWoKLsJU+yo+NoFirxVUr+FmeahWXf4+jsJgZR99/bXBxctGR4+l3Z
         RQfMZbnciLwkaTdTW6vpsQ5xpeEx8zkFifrqYdW40fOBoxzcdFRyU54J5PUSqXG8LGvh
         B5i8l3G20UVBo2CBs50JDGmIgpDZaRGVWHhAqKKHszj0IkVkmAa7pZl/55W5eUG9Kzf4
         xabVp1U3kg7TgpiWKJtcdjConxXJEq1TAX+ZYas0fIBJJ72pDD4I6aBHo6IdPu7HtMl4
         QHRg==
X-Forwarded-Encrypted: i=1; AJvYcCVgHMBp/m/h0GSomHECdLMbJGPeZT3M0yRqUbXDfWKcLQrafi/m3vSPvtrj82JzdU9Emr9TstUtqL3Fvw63@vger.kernel.org
X-Gm-Message-State: AOJu0YwgVIZ2oTfns5U/6EDE+xopCEeUaY5iSjgzTx8xKl/Ed6gcTgSq
	we0mNUetA3nQM76GZD5Du1OgVFiW2ONZemlaJBpH1R0CQlqh5hcWdVSX6TI8PU8=
X-Google-Smtp-Source: AGHT+IEhQtwJqw8FYkoHlxC5JPevShyCoOPyIG4UY1W3uspVlh/+ActuzVEUskOUpaeDpHYJeA9Tgw==
X-Received: by 2002:a05:6870:198d:b0:27b:a693:fa11 with SMTP id 586e51a60fabf-2955c59baebmr11328407fac.19.1731506841530;
        Wed, 13 Nov 2024 06:07:21 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e8f5f81esm714501fac.20.2024.11.13.06.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 06:07:20 -0800 (PST)
Message-ID: <27cd53e0-981e-42f0-b965-e9e2cf3d5894@kernel.dk>
Date: Wed, 13 Nov 2024 07:07:19 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
From: Jens Axboe <axboe@kernel.dk>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
 linux-kernel@vger.kernel.org, willy@infradead.org
References: <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
 <ZzLkF-oW2epzSEbP@infradead.org>
 <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk> <ZzOEzX0RddGeMUPc@bfoster>
 <7a4ef71f-905e-4f2a-b3d2-8fd939c5a865@kernel.dk>
 <3f378e51-87e7-499e-a9fb-4810ca760d2b@kernel.dk> <ZzOiC5-tCNiJylSx@bfoster>
 <b1dcd133-471f-40da-ab75-d78ea9a8fa4c@kernel.dk> <ZzOu9G3whgonO8Ae@bfoster>
 <f26d1d04-3dfb-40d3-b878-9c731459650d@kernel.dk> <ZzO4wUTNQk-Hh-sT@bfoster>
 <d74ea306-29d6-4829-9b3f-d76dfac0b912@kernel.dk>
Content-Language: en-US
In-Reply-To: <d74ea306-29d6-4829-9b3f-d76dfac0b912@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 1:25 PM, Jens Axboe wrote:
>>>>>> BTW, I should have also mentioned that fsx is also useful for longer
>>>>>> soak testing. I.e., fstests will provide a decent amount of coverage as
>>>>>> is via the various preexisting tests, but I'll occasionally run fsx
>>>>>> directly and let it run overnight or something to get the op count at
>>>>>> least up in the 100 millions or so to have a little more confidence
>>>>>> there isn't some rare/subtle bug lurking. That might be helpful with
>>>>>> something like this. JFYI.
>>>>>
>>>>> Good suggestion, I can leave it running overnight here as well. Since
>>>>> I'm not super familiar with it, what would be a good set of parameters
>>>>> to run it with?
>>>>>
>>>>
>>>> Most things are on by default, so I'd probably just go with that. -p is
>>>> useful to get occasional status output on how many operations have
>>>> completed and you could consider increasing the max file size with -l,
>>>> but usually I don't use more than a few MB or so if I increase it at
>>>> all.
>>>
>>> When you say default, I'd run it without arguments. And then it does
>>> nothing :-)
>>>
>>> Not an fs guy, I never run fsx. I run xfstests if I make changes that
>>> may impact the page cache, writeback, or file systems.
>>>
>>> IOW, consider this a "I'm asking my mom to run fsx, I need to be pretty
>>> specific" ;-)
>>>
>>
>> Heh. In that case I'd just run something like this:
>>
>> 	fsx -p 100000 <file>
>>
>> ... and see how long it survives. It may not necessarily be an uncached
>> I/O problem if it fails, but depending on how reproducible a failure is,
>> that's where a cli knob comes in handy.
> 
> OK good, will give that a spin.

Ran overnight, no issues seen. Just terminated the process. For funsies,
I also added RWF_UNCACHED support to qemu and had the vm booted with
that as well, to get some host side testing too. Everything looks fine.
This is running:

https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.7

which is the current branch.

-- 
Jens Axboe

