Return-Path: <linux-fsdevel+bounces-47270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9539CA9B210
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 17:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC46F9A1F34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BAD1DDC1E;
	Thu, 24 Apr 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ICqPP8ay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C541DACB8
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508153; cv=none; b=W8jeSERACf1hTknrwuftUe7XSIghd6BQp7uF7gRNKsGVT9uYynKLw8eBDq0lm1sdkPigA0hxiX/tf0kdW7896wGuZuy1+FySSDS+DcX3Lr5j7JME4k+FwfovuvJKmVg5bQU1SoQVVGxgZs5Bdw6XsJf+NmTNZGEXzSdHinumOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508153; c=relaxed/simple;
	bh=RWljwkvFpoc6EAiHefhey+4fy6z+A4N3IJcyKZ9CQ8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o56L/qV6p1oceb9rdPe3AKEPihJQIeZQ7u1gJCmxSyK03JkjRLjSzMpdKdhtMyjg6SEJXCZaItgr3QlzWz/ytJQ/wryXqLkchiqEHv8zbPtCzzoDeFKT2p2CY6cLnWHHzozEO/Y4upZLXJu50gj84x9BJL+WtRbO3dXgkPzxGrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ICqPP8ay; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d91db4f0c3so5794475ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745508150; x=1746112950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmCX/oOcvrNdDEnAxMn0eyeoPuQt/o60LQX66Sq9Cq4=;
        b=ICqPP8ayllFDpZRNSbbwvPlZ2AUDjhVdzdzHLhMn/v4mJftGW4qrMpMZUWF3BDHpMV
         /o5AO3yKbApQuVaHzHIvkH2CGzT4YZp7CJDY7wsRpyueHpURSK/U+0bJ9spxlLHY/Ny3
         2l+UQZtonSE/POn12p83NR9h4r6A97fJ2zTEvsk+3T+xM84fQfTvuiG3g+dVesrWUU/c
         KIFgL94Bd6juwP5kM/xLnukXVybnBLmzCsCvIaFExtPLWdPBmYRXccqHphuyzVpplXVN
         Viacif6VkFCxIm22NfbuimWI8kd9cAzZ5lXkBUHKIxACFk3DIJr3S2paWid34cBdTJRV
         OEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745508150; x=1746112950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmCX/oOcvrNdDEnAxMn0eyeoPuQt/o60LQX66Sq9Cq4=;
        b=ByU7XjoszBlYt7bUVwSUlnjln6Hq1PDvXr7uwcXXMKVQe3uGoNGyk3KvxED1cL3WgI
         2JLypagFj0XnR8lCLFMZOAWiknCb0uhsD+3l+y+T1w2gmlqXfjf4jxEWJa2PV8kBINA/
         gIH6YOT8u4Ty5hiVvKUsZh1Fn9C4C50oj19R19sJ/TBK2rOiyPSR94Dgu2KYjecUzlhi
         VqohQ/kEAF4d3Rbm1IozZoEnm0zHTeCGj/tIcAg5BvpthS+slYxtWBDTZ7lko9Mlr5nx
         zsjBc7Ajv7TgKz+5Fa9dlhQL8GlELQtJWkMXRmuqiy0CPLSg+AhV1qM2PVvr0mUcXCsZ
         haWw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5tambLH15vY79O0O2AMfq4C4SeFuFojkEBPL2kdc6oyul7p4LY+Q9DJrdhtrNodSGdNVZtaPO1YKR7VO@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFuU14enHmjuNJ8sZ/oUGHPmOwy8dHdEmJyUUFcAgAZXcRKb+
	gV5dUTK0XZrs5Q75DeMUxXDn1KbcqFe12H82o9yd3odl0/Gcj4MtZIbb6V3Hpmopz3XUdrx1o3W
	l
X-Gm-Gg: ASbGncv7jCU3+jdRjl/2WlyKU1EfDPzOVsLOjhadYZBwrfGQSW86vRSK3ihLo8NdCy6
	+ge6NVijCaGape/zcRIdLIsyz71/WhcA2J5uMZat8BKpMvmkbQHM90454mB6uZr/MbM2zJyndnH
	LgPXUI5H3bje2F6gTVJzOHyIVcfenPqTq8BzrdkiyU3rOg7c7HlDKBm9R6xC5S6MIPcvraX7Oh8
	mIAXVE9jCxcTYK+Mcuke1Btjs0X+oiPF54f1PBlxFP0ARNJn/s0PKzdcmZiIxblwuAb12nI5q/g
	nYm3BZsoVfp/MlAM7owe1b0pcNgV5ooZEuZnbuDkeuZb31k=
X-Google-Smtp-Source: AGHT+IEMJLQ6alo/SeAQVIhLk2MPC52fNge1ln6vSauIlwzfyiVyMfKC2I2QO6XMfahKn9L+ZuL2Sg==
X-Received: by 2002:a05:6e02:1a25:b0:3d8:975:b825 with SMTP id e9e14a558f8ab-3d93038f94bmr35105055ab.5.1745508150445;
        Thu, 24 Apr 2025 08:22:30 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d9314f5fabsm2937385ab.36.2025.04.24.08.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 08:22:29 -0700 (PDT)
Message-ID: <26fa8c43-7e7c-4610-bbf5-031f3e07eb74@kernel.dk>
Date: Thu, 24 Apr 2025 09:22:29 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org>
 <c68882dd-067b-4d16-8fb8-28bfdd51e627@kernel.dk>
 <20250424151113.GB840@cmpxchg.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250424151113.GB840@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 9:11 AM, Johannes Weiner wrote:
> On Thu, Apr 24, 2025 at 08:54:40AM -0600, Jens Axboe wrote:
>> On 4/24/25 8:03 AM, Johannes Weiner wrote:
>>> On Wed, Apr 23, 2025 at 05:37:06PM -0600, Jens Axboe wrote:
>>>> userfaultfd may use interruptible sleeps to wait on userspace filling
>>>> a page fault, which works fine if the task can be reliably put to
>>>> sleeping waiting for that. However, if the task has a normal (ie
>>>> non-fatal) signal pending, then TASK_INTERRUPTIBLE sleep will simply
>>>> cause schedule() to be a no-op.
>>>>
>>>> For a task that registers a page with userfaultfd and then proceeds
>>>> to do a write from it, if that task also has a signal pending then
>>>> it'll essentially busy loop from do_page_fault() -> handle_userfault()
>>>> until that fault has been filled. Normally it'd be expected that the
>>>> task would sleep until that happens. Here's a trace from an application
>>>> doing just that:
>>>>
>>>> handle_userfault+0x4b8/0xa00 (P)
>>>> hugetlb_fault+0xe24/0x1060
>>>> handle_mm_fault+0x2bc/0x318
>>>> do_page_fault+0x1e8/0x6f0
>>>
>>> Makes sense. There is a fault_signal_pending() check before retrying:
>>>
>>> static inline bool fault_signal_pending(vm_fault_t fault_flags,
>>>                                         struct pt_regs *regs)
>>> {
>>>         return unlikely((fault_flags & VM_FAULT_RETRY) &&
>>>                         (fatal_signal_pending(current) ||
>>>                          (user_mode(regs) && signal_pending(current))));
>>> }
>>>
>>> Since it's an in-kernel fault, and the signal is non-fatal, it won't
>>> stop looping until the fault is handled.
>>>
>>> This in itself seems a bit sketchy. You have to hope there is no
>>> dependency between handling the signal -> handling the fault inside
>>> the userspace components.
>>
>> Indeed... But that's generic userfaultfd sketchiness, not really related
>> to this patch.
> 
> Definitely, it wasn't meant as an objection to the patch. The bug just
> highlights a fairly subtle dependency chain between signals and
> userfault handling that users of the feature might not be aware of.
> Sorry if I was being unclear.

It was more for the clarification for others, I know that you're well
aware of that!

All good, I'll send out a v2 with the Fixes tag adjusted, just to make
it easier on everyone.

-- 
Jens Axboe

