Return-Path: <linux-fsdevel+bounces-46848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93445A95799
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 22:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD923A49F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0681EF0AA;
	Mon, 21 Apr 2025 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gb1Xxx4D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F01E04BD
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745268826; cv=none; b=Z+h3l2fCWgjDG1cR1F+VH+Et3JQaEWb5yjywVKkO7awFTLCIjTGEUKe87yozmDKSOhaZbH4YmIBQfz413BmDkfPTG6EmH3D2vXJoCuT4KiLR5KN0AaoJ4V9WzCxuU3+AwPkpynAX3Tc1KIBPBY7aLX1sKtZ50JYyKyw19HgUZjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745268826; c=relaxed/simple;
	bh=uLBwTqXQoexLBnNCz3Cg0anWoUKCBqdw1G0JK1RAZvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDvxobehIQaCfkjJwJoL0+C6b4QlMz+pqRpbRBYQjpp0PZslYVCxWEALl1+ZpCJwhqtBaa04TjhaL//oHBNMPgwRypLkvgSD1rBoXo2B7N1Z5K8tHmoGzWt0q2mzA1yNwGAFMLL6Hmau90kYZkPEok/krYll0TT6uulf+PZDtzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gb1Xxx4D; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85b5e49615aso403618539f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745268824; x=1745873624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGyMbdplm0VqgEXwZTM797av09Qdwt4xl1Ent3Qyi/Y=;
        b=gb1Xxx4D8q8NyHuFASShNuNqJCqeKAmrIB7Bvq6UzIwLzy/XDeJNgAPmybc4v7gkgH
         MpfTDiLRmHGH+ij9xc5znd4UNCihciQXk3qRcZXeMv3PhHWpFGMtsM3YlvUdRAZfAh1C
         VqSPN6s2ymV5jX/fRd31vv4MzIaSu8S+jHsYpw50QqdNGO7ygfBuqTikdzjXIBisjtKo
         5nVm5rElL5pFGdbfbKc6N1t6If155AUlHhhM3KzDuGvuFMkgOhV26P5xg7Rs6K10yZhS
         vublx3V7Vm0Yg3qXA3+pUaTKW2y9JBiniBmSKKLfqoRuIlHHpuD/Ysc98PZg79kQcEMA
         5uPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745268824; x=1745873624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGyMbdplm0VqgEXwZTM797av09Qdwt4xl1Ent3Qyi/Y=;
        b=DBZ7YKU7oidTozbPYoyp88HMFiTgEBtcAyRqkE+U7Wfpzsc1I1RGlnlUcIQoqoswBW
         p/QD4Me6TvWdaCHETRDJ4jrmrgR9TVgNaYibBN5kDeB9pWf3uhNI9CzUWZ2SOskJtWcV
         97YFiKvxOWOPuZz4P9EfKBJnm7Y9+QXW1w3wiI9c62dQMRchRSysZKCV74lgV6r5gbmD
         xpxQ5mR6tH/t5qgNMH3XNsEchR/h4ovcqAK33i9FB6wHB01uwwSZThjMViY50DiH1tSp
         iNlHxZY2h9Tz1oNF1X9pM3SgaSTxF5O4IyCsCrWvNzGeW37fp87RDsigOu18K4Yvt4mV
         5iKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRCgRkZL7tCo6zJvYXm3UKtJ5p0W6h2+ub7zVwkjnUEVYs3/y6xz52BAYSTwP0NRDCxrCovV666s18ZHuO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08DLrvg3HUCdypzF9aBTQcvUXRKTALaJncGS7UUXRgUbx0zGw
	EOynk68k4qOF1r2oEaKY26ldryWhz2ODX+CW9rh5LHNocwhfVJRtZddIYaSWAS0=
X-Gm-Gg: ASbGncvnHYvGiHP1dqpv6COcEgZUmkk4d9hQcBls9/7kOKCGuWLs5DAWhRTXn67cqTP
	kuZdZDspCfigHew4pkkypvXzNMdFQdk1nwPdvgxrkqo57cWkzVgodQueIYUFy2HXr1ZyH+mIejL
	Ae6ePpaZP+961nrPnyKAJ75yF/RABh2cTzAVTJdH57e6kp/Qy4zJfL4gsi25ikZ1Y4rGvV0q7G7
	Lj8oUhBE6dnLD+U3E9dYAs/Po3A5+SbRExnG4Vgd/Ij03JGIGneCsQhvQnhm7VL4foCyeo3sgHq
	5B3FM3QdrYQ+/r3nTLKqYXSZ8PsyoV9CMeK6PAgLF5Bd5ZU=
X-Google-Smtp-Source: AGHT+IHvDgGfgDUOOapB200WZpV48HaZ8dVbhYH++As1bmXpZNufg6G1tVLq51Z1vXwqN7Cc8UQGrQ==
X-Received: by 2002:a05:6e02:3002:b0:3d8:20a3:5603 with SMTP id e9e14a558f8ab-3d88eda87bfmr139248725ab.2.1745268823944;
        Mon, 21 Apr 2025 13:53:43 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d821d1d700sm19572275ab.12.2025.04.21.13.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 13:53:43 -0700 (PDT)
Message-ID: <c6bcce15-647c-4de8-aa01-6cd3ec5bf904@kernel.dk>
Date: Mon, 21 Apr 2025 14:53:42 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET V2] block/xfs: bdev page cache bug fixes for 6.15
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, shinichiro.kawasaki@wdc.com,
 linux-mm@kvack.org, mcgrof@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, willy@infradead.org, hch@infradead.org,
 linux-block@vger.kernel.org
References: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
 <8cb99c46-d362-4158-aa1e-882f7e0c304a@kernel.dk>
 <98e7e90e-0ebe-4cbc-96f3-ce7f536d8884@kernel.dk>
 <20250421205116.GF25700@frogsfrogsfrogs>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250421205116.GF25700@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/25 2:51 PM, Darrick J. Wong wrote:
> On Mon, Apr 21, 2025 at 02:26:54PM -0600, Jens Axboe wrote:
>> On 4/21/25 2:24 PM, Jens Axboe wrote:
>>> On 4/21/25 11:18 AM, Darrick J. Wong wrote:
>>>> Hi all,
>>>>
>>>> Here are a handful of bugfixes for 6.15.  The first patch fixes a race
>>>> between set_blocksize and block device pagecache manipulation; the rest
>>>> removes XFS' usage of set_blocksize since it's unnecessary.
>>>>
>>>> If you're going to start using this code, I strongly recommend pulling
>>>> from my git trees, which are linked below.
>>>>
>>>> With a bit of luck, this should all go splendidly.
>>>> Comments and questions are, as always, welcome.
>>>
>>> block changes look good to me - I'll tentatively queue those up.
>>
>> Hmm looks like it's built on top of other changes in your branch,
>> doesn't apply cleanly.
> 
> Yeah, I'm still waiting for hch (or anyone) to RVB patches 2 and 3.

Maybe I wasn't 100% clear, but what I mean is that patches 1 and 2 don't
apply to the upstream kernel, as they are sitting on top of other
patches that block block/bdev.c in your tree. So even if acked, they
can't go in as-is. Well they can, I'd just have to hand apply them.
Which isn't the end of the world, but the dependency wasn't clear (to
me, at least) in the sent out patches.

-- 
Jens Axboe

