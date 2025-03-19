Return-Path: <linux-fsdevel+bounces-44455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E153A6946A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 17:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0733819C32B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C11DF248;
	Wed, 19 Mar 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y+r2+hEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B11AC43A
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400452; cv=none; b=H4cvMJXcbJc/9M0E0bz/aMqLtJ6kZuqHjx7E28m/N7Q7RCxT02PZzp+lR0Aw1l1u0doytbJiULiEsah/AAAjRczU6E/1jUg6YUIL4n5A789OvCDvlWwAmYsW2/rfngQP0IwJlFaTLom35gJrFu6gGVBB/9ZYJGNklEM0l5nxPyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400452; c=relaxed/simple;
	bh=n24KzPzMfIDbuu7S5CaFyw0UePwN7haHff4RjRQuRy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tm9DxORHnGN56Ifr1PwyE6NvdhOlp7lpX+AlwTw+99jl649uZAICSmQU5snjMAPeMKbiIm6iY4hovwpz8cLqmYh3037VGKPzWvC/nkNFTkNnes5acY+603GSh3Qxq4hP2hIIDuNTEekzx5Rdu0fdJQh2WAnpwNeuLxHAaM6U/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y+r2+hEf; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85df99da233so225165339f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742400450; x=1743005250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ija8XGDNXdwDWcF7Obpxn5AkOPtI89VS3WVbcU/kpys=;
        b=y+r2+hEfjU2Zz7ALNOq5svFqzJiE9cuXQdmJA+P20x3ThNxa4mu8TtLObqNVlmroGR
         OlmZyYGQuf90qEw4W3uFuM+qnOHzzxc8ucTo7UpOKYtNKkyBbOReAsQhAQo3E/IP7leE
         E9wx4qFx45Oa2aV/2THQw+dab2TirOSA0A+EQ6K560wTR4bka8wphawWRyI/d1vJFHr+
         qzQXF+jXmP7T7oWdIYtu4AfbRAkJbRlbzJRgprCtUulnirrdugfhtvRDW6HS5GWmBfRc
         krNJStKgc3sx9SLXZLXnd0wZOcaGEL7gXh4wuw7XqjLN2dft+wd5LxMmSpHgutBnovf3
         PLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400450; x=1743005250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ija8XGDNXdwDWcF7Obpxn5AkOPtI89VS3WVbcU/kpys=;
        b=Val6pgeSx3T10XaWh6OSyD9gy09puBHTxO9Arj/Er9JYStJUwwkpP94FL4DdR0acLS
         VRZm1GUosw2x+VXXY+8Ft+OajmmCFzk36uJ3zoAYCQs/sOxaABHtMJ3CHuSHS7DPbJ18
         Br7yPRkV0wUaSIyAXLh4yXAurHD/sa8mMje4ch66KQwORaFFFSrC05nl8Uc/fuMZvloZ
         vZdWpbRNx5zHxG6X72i90ThoinhWJfS2gZpMRKMPffqHBIA5IYr9wKyMBXa8lTo0HLZz
         cZhjvcTqUGE9ms2ek+R7rGkw4siKMMOVHZWN5/0+rfS1TR1teaqcY5BFmSJPjkMcEHyY
         cdEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIRlQV2Vvd8oi5KGGi74Cur5YNDaOQGFXSr4ApXzy3SSKVGMPmSB7M3byUaL5HELtZKCeqRSbV1CKtKz6j@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNUmzLLzoRRrGsqEm42ysv+78BTIev4jKCmt8igNsU7yAA/Gq
	i2vUeEtf1NuUszfuU0SIgi1Kh8ejBaDSpfTOtckDLnd5bSkS7k+OWdyjGOsgnqQ=
X-Gm-Gg: ASbGncuSiOs8j8p78SkEeT/JL9/0qkepVcQ4OmvMsKy9PFRKGPumGDgyWiyRj+UcjYt
	1hiUijxsLCcBi2PkZHU1OAZTTSd5FwUidNVpVpewzIiZQ3PebxkIschmXRFkGQmt1pEazZ2dDRY
	JoXcE45TO9KmflcpfJJVCz0z4dFcnSGuWysIg2lHw/jylQbaLM6pc0YDv8Pi7Yvq3RyBGJW6a7c
	I6njS/0fC6DfqRH7YiAYVb6VePH2N3ocRZiEIjoj3gjQ9xrkZrPORUtlG90/CMKooOEcymjeNzo
	JxNA7nMNU5SIPT6k7Z14c0cgq6F38ySWSNiBh1AVRE2a2fy/V74=
X-Google-Smtp-Source: AGHT+IFDBCFWtf4DEWZHOAZhQMfKg6BVxtB70LM/11gT5po4hUy91hL9GfbCfrY2dAmweb9btJ2fRg==
X-Received: by 2002:a05:6e02:1d1d:b0:3d4:3aba:e5ce with SMTP id e9e14a558f8ab-3d586bb9f32mr38295495ab.20.1742400449657;
        Wed, 19 Mar 2025 09:07:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263719730sm3269768173.36.2025.03.19.09.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 09:07:29 -0700 (PDT)
Message-ID: <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
Date: Wed, 19 Mar 2025 10:07:27 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, linux-fsdevel@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com,
 arnd@arndb.de, brauner@kernel.org, akpm@linux-foundation.org,
 tglx@linutronix.de, jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:32 AM, Joe Damato wrote:
> On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
>> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
>>> One way to fix this is to add zerocopy notifications to sendfile similar
>>> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
>>> extensive work done by Pavel [1].
>>
>> What is a "zerocopy notification" 
> 
> See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
> sendmsg and passes MSG_ZEROCOPY a completion notification is added
> to the error queue. The user app can poll for these to find out when
> the TX has completed and the buffer it passed to the kernel can be
> overwritten.
> 
> My series provides the same functionality via splice and sendfile2.
> 
> [1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html
> 
>> and why aren't you simply plugging this into io_uring and generate
>> a CQE so that it works like all other asynchronous operations?
> 
> I linked to the iouring work that Pavel did in the cover letter.
> Please take a look.
> 
> That work refactored the internals of how zerocopy completion
> notifications are wired up, allowing other pieces of code to use the
> same infrastructure and extend it, if needed.
> 
> My series is using the same internals that iouring (and others) use
> to generate zerocopy completion notifications. Unlike iouring,
> though, I don't need a fully customized implementation with a new
> user API for harvesting completion events; I can use the existing
> mechanism already in the kernel that user apps already use for
> sendmsg (the error queue, as explained above and in the
> MSG_ZEROCOPY documentation).

The error queue is arguably a work-around for _not_ having a delivery
mechanism that works with a sync syscall in the first place. The main
question here imho would be "why add a whole new syscall etc when
there's already an existing way to do accomplish this, with
free-to-reuse notifications". If the answer is "because splice", then it
would seem saner to plumb up those bits only. Would be much simpler
too...

-- 
Jens Axboe

