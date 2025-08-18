Return-Path: <linux-fsdevel+bounces-58210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F3B2B2AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 22:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE5F561FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0122737E3;
	Mon, 18 Aug 2025 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2ZsNTs0+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F9271462
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549778; cv=none; b=SwF4xP9qGytKn6UBf2nUx7rswHkC18ZkqWo5xtoBLcCSky58xvotxl3Ovk++oYlr54t3f+ZunfD/LJpCpOQ9lx0m44cn39Jjw0TAsXOBWRLBbs7061rJCl7sxaaMAApOJ7/zVXwLYWxLuw5G3CBPFm1Ma+n07JON7411UPgEJEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549778; c=relaxed/simple;
	bh=xcRhqrtnt1tMRpk74abDPEHOwtTCJMPQBi4qr3vXQBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+e1KAi1RH3RVNMegNCCwsMYIZZDaVtQRjZ/Pa2aO+hWBfaueYk56L8QmIUzmoUr9v6dGgJKkbYH79mqTFiHSHemNqKRoPsEobQrjt09ztGFFE0f6GJxKe9CQ7ytuXepK4a8f0AeJLVtDqzMOeG1AC0/BhxqwKcIzfoie734ur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2ZsNTs0+; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4360056a2adso604695b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 13:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755549776; x=1756154576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NHuipRaHUViNyMWtT/RF9yQ8D7EPRscQGwUmEz/0mc=;
        b=2ZsNTs0+tPhDla0Z1oHswqZ8kQQCYDi/T4AujusMEcOMTiXeHCZ4vta/S6k7/fqHMC
         TgzkP27BGOZtvWVw94uDiaTxKqbfC+oaX4EA+RA4/IyJ7oDUzjyJIAmTBbnxqD5E7qqA
         zRKJ+Kxhy+RqFTwR0WbwBNjszQQOVmNcnGWrFDqIID7aCbKcpATg9UUIHUWaH7IHJWkb
         sWBdTUIxaTsWJgY0dAUZCmJc2PbNr5cQgZqJ/l0P3DBRpJL3hKBkc5mkCgKGYGwNoont
         7wDRlKP0Rd4BKU4619EN+TZIWvhc0WP0/Lo7ql/r3HrINgiG5YQE4xCJfwtuDmyU8kEO
         B2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755549776; x=1756154576;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NHuipRaHUViNyMWtT/RF9yQ8D7EPRscQGwUmEz/0mc=;
        b=uRU7BxAd9AnS9LGiFEmDwM3OEnQXvonKttBq1GZmWSDv6mwW3QSOxuKyt0qDqOAQ3S
         ZFCfSUnVR7K/7dl+vknuJrDgT1eWOhik3G5NGbpER6dmyY42Sm4o45v+LeT36cJvX+i8
         NIwu/w5K3n1VfwnCfIRue7l9lGmGsMmwe4RZhG/SpIaw4HT9T3AbrMnDzOUt3vFFlRMg
         rx8gDEQ66MR4cy4Pdm+7gHQrtqVmPzZhea16Z9mGJm7WMIcNjMR3nC6ctq/wfZqDktac
         etWRiY1MWtd/9nEaMAwLWC7LPU3EqTGCLJ8A46i3tKCdy/NJGTjjp2Zdqv57Fhrl+VLv
         3o8w==
X-Forwarded-Encrypted: i=1; AJvYcCUOQup7Ijh5x0bG0d3ZbqKeHDuBtF0BgaFwr0UXcMez0/vj1w9zVT6JqtbBCPiN5xrlHz5MEAIvFH90Id++@vger.kernel.org
X-Gm-Message-State: AOJu0YzndWsLC3dsV2uBLs3q8SuWyDVwJRQwUaFWF7gpWRQXgrWSAt8f
	fQjyHQWsQvRtEOcC+w9yF7TXvsnn199AIKRFYeUgcNW2Nai1WMcyc0TUF9mV6xO016E=
X-Gm-Gg: ASbGncv4ZFgSMFOwNAF/1/Bio7j2zF0m0Oi5LKmTFcv8e/IVZ/jjSlQntfT4M4m33+9
	MeJxfIWsKchz+WbvbHMUAW4SI+Tv9L29gnWVdUnR7ndBvzS/M7EE1FimuPVotQS9GbyaFf4K0P6
	KbtEfxcB+G3vNS7jHBdKqODCJcNIW1eaM9Z48cVbMt6KnAXTyxPxAGGUE1WNEPzUZWiMSiXuVT+
	S/EKMw1mvwtCEueDYF//OdTlCEc+ld4Ayp7KrPoFXqblduJkHMCgxZT0f5+S8C2ojJGy9xm8qbo
	nFGjZn18q4zRzOx5nZ7hTETQjtWEdvdusVLnxekQDz0JJFpu6+dAJ3XJBRO6klRRF3XcXzx+1lq
	Y0bwWG7NeQ2UwHM7S/VbRX/HMuvVWfQ==
X-Google-Smtp-Source: AGHT+IGPhtuFN4Dzph6D1atIUw0DIFb/7njiZN34Nya1860YPD6PWiMY42VBGEzk96pHMoNDcC84pw==
X-Received: by 2002:a05:6808:1523:b0:41e:9fd0:bd2c with SMTP id 5614622812f47-436da4b17c5mr80262b6e.18.1755549775951;
        Mon, 18 Aug 2025 13:42:55 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94998c2asm2737262173.51.2025.08.18.13.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 13:42:55 -0700 (PDT)
Message-ID: <af82ddad-82c1-4941-a5b5-25529deab129@kernel.dk>
Date: Mon, 18 Aug 2025 14:42:54 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RWF_DONTCACHE documentation
To: Alejandro Colomar <alx@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-man@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
References: <aD28onWyzS-HgNcB@infradead.org>
 <cb062be5-04e4-4131-94cc-6a8d90a809ac@kernel.dk>
 <a8a96487-99d9-442d-bf05-2df856458b39@kernel.dk>
 <sxmgk5dskiuq6wdfmdffsk4qtd42dgiyzwjmxv22xchj5gbuls@sln3lw6x2fkh>
 <409ec862-de32-4ea0-aae3-73ac6a59cc25@kernel.dk>
 <dargd4lgdazaqxrw7gz6drrzzgonn34qllkcgei4uxs6ft7jbz@avkuehcbaok6>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <dargd4lgdazaqxrw7gz6drrzzgonn34qllkcgei4uxs6ft7jbz@avkuehcbaok6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/25 10:01 PM, Alejandro Colomar wrote:
> Hi Jens,
> 
> On Mon, Aug 11, 2025 at 11:25:52AM -0600, Jens Axboe wrote:
>>> Other than this comments, the text looks good to me.  Thanks!
>>
>> I kind of walked away from this one as I didn't have time or motivation
>> to push it forward. FWIW, if you want to massage it into submission
>> that'd be greatly appreciated. I'm not a regular man page contributor
>> nor do I aim to be, but I do feel like we should this feature
>> documented.
> 
> I understand your lack of interest in writing quality man(7) source code
> if that means iterations of patches.  However, you may find the build

It's not really lack of interest, it's just that there's only so much
time and the idea of a back and forth on documentation isn't high on the
list :-)

> system helpful to find some of the most obvious mistakes by yourself.
> This might help you in future patches.
> 
> 	$ make lint-man build-all -R
> 	TROFF		.tmp/man/man2/readv.2.cat.set
> 	an.tmac:.tmp/man/man2/readv.2:316: style: .IR expects at least 2 arguments, got 1
> 	an.tmac:.tmp/man/man2/readv.2:395: style: .IR expects at least 2 arguments, got 1
> 	make: *** [/srv/alx/src/linux/man-pages/man-pages/contrib/share/mk/build/catman/troff.mk:66: .tmp/man/man2/readv.2.cat.set] Error 1
> 	make: *** Deleting file '.tmp/man/man2/readv.2.cat.set'

I'll remember for next time!

> Here's a diff with all the issues I raised fixed.  Please add a commit
> message, and I'll apply it.

Beautiful, thank you! Maybe paste the same section into writev.2 as
well? For commit message, something ala

man/man2/readv.2: document RWF_DONTCACHE

Add a description of the RWF_DONTCACHE IO flag, which tells the kernel
that any page cache instantiated by this IO, should be dropped when the
operation has completed.

?

-- 
Jens Axboe

