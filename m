Return-Path: <linux-fsdevel+bounces-36787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1169E957F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D40281E0D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3157022B8D9;
	Mon,  9 Dec 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvmOrd4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6922A1FD;
	Mon,  9 Dec 2024 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749014; cv=none; b=MwyMcD9jpATpaYcR1MHXh0L/b2bNXCBK0S88MWAaAQ/f1z5rnFROYxTWV1A4Wo1b40+3uae7ReTh8BAJmJ5lJ/07gRdjH8PT0+zGOtFQPXEqCotbMxdzoiAEOEHbuHrSirDMlacDtHsq3gNmiLg6bs+vU20wdxF3nqJgX2WIvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749014; c=relaxed/simple;
	bh=TtR0POClH3vMSwJTdTsZxGxPIISz20iuULTCYIwCcHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7fg6Brcn87imEG/juQt60iBE4ZFUyIASnDTwwX5+6008Dc5yS/weO8/r0tiBAZ9ClFc1lUFW/Z5HmiJLCMQi47jIb4XRtAf1qbDnHmntxdCv2W1GHrcgA4Yx/kiy5VU2sORSsUHAbBzKZeVVLPeEE1yNRUAHtxNacFTFtqm0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvmOrd4t; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5401c37d8afso1231284e87.1;
        Mon, 09 Dec 2024 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733749011; x=1734353811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWVCxbrTVnf61GHy50t1nIO1WdXwoF1UvHG9EnxG6sQ=;
        b=BvmOrd4tn94NBIiacvmdNL+8Sda/3tUfBhnncSVQb6kqLHsJqe912hjVxkPtyFTxct
         yrHGOERY1o4MqO1vX6MW+rrGE/2jfKGtdWNz5O9liMSP1lSN82gr9dZKwPLbMzyFIYPW
         lFCLf1kEb6x9D0H685KIbLvg40O/WXKi1kjvzbeUj4IzaQN2dKEl4B8ecImRjBVuQ3zu
         ACJyKnz50WKD97/mfnDjrsdq+9jlipu6hzI3lDl3KxeCD5gn8nYvVrXtQcTYhlPtkQFd
         i4s/5jP7j2JkvaJ3zptabh6AdBzF7G3LfoyvJl1a90Hdsrfj9wq//E8lxu0uv21sFopq
         G6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749011; x=1734353811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWVCxbrTVnf61GHy50t1nIO1WdXwoF1UvHG9EnxG6sQ=;
        b=Um70u0XR895kdIvTuuJ3xA6aEkE+O9ihAfmSghi35POa4kC0Uls/HaufEGY++jQ3Ra
         e5kae83Ob0DKI1SEBaZlUF7hP6Dr6Iumu/4sVBcisiyICPJzyyf9knpv+4EynXj8BEUU
         d1TwPdfuAgwxiUJmyd6W6/DWiIl3U4A/JMW7gEi5JLDeVVBd7fzeCkCo9gFFQ6RMudxj
         tMvqd+DltBiPQaY8ie25reRxk3+Wm2OsB0270Xz7/HywtnAPKgury9zA8SQHyKX2ZOgT
         V2DobCjNJer8iZ0TKns9/5GsngvHX1TKcUvmwRCEUsoR36xCcl8BN0gnGWTMCMXfVo8w
         uwuw==
X-Forwarded-Encrypted: i=1; AJvYcCUU1FY+gGrOgYLWHmjaiq9ZYLTB+jXa5/wuiiXtVTEoPW6M+zpcI6KwFn6w/CpxPJdaO0AyUSaNjqlefhwwvw==@vger.kernel.org, AJvYcCV3Tn29fgowzQ/+g/Gz+B7BiJZA8C9/IUlSI9JLoxJnNuREr3PaqsKoMsVExjGg5mAc85CUqm3GaTQX@vger.kernel.org, AJvYcCWo43VDPMyk+vIS8THEaWZhw+R3ZcbxpaiBy8jIUdeteQb1LUwJlV5zlSs1WZr8Xj6RIonSzQbRfZq0sQ==@vger.kernel.org, AJvYcCXwTCRECwhvg3kVH3c8wqGpkZtylsW/VxXSGvn4nEHndYowFDt4qnYIl/wuF4CGneMB7gzjL+r7QOPuxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7iNkR/ozcfbdagGA1ibDrhS82IPh+3OcYIXx+SADGpDM2IYzX
	uSrikofMP+W8IxnvFNVvZXHOs0d+JAsMa+LfExAEiXE/p/hk+imnqiOG4A==
X-Gm-Gg: ASbGnctKaHloPyimjrS0ujjshpXLA9hLrEenF1nAYpLc1HPfL9y//ppH2uIeD9YMPJa
	CYVtWLwYXM7txnaP+oE9xzHW1y8Av/ILi+2dcfoO04KfptmsfoOZIenc5VmrQHNsf08Z7Zg42MW
	9rywr9FX77Gvr8gvep6pE3InXy2H1e7HAeQdV5MvqNl2j+QprzWwT5R3bFz7FTIS2dEAawThQhr
	NMEAjrgQAIPNk1i8UuIjbZyxN6NSTnHwucYVb7CDjRP6W3kS0DP6vdZX7hOk5lb/vewKwM4UIro
	QojTqKkLltPpKpBY
X-Google-Smtp-Source: AGHT+IGJP+qDi++rMu9YDBxju5NqTXgzk9eSdqcEvXa9AgotuNX4C1hJ3WINefmjNBbADlez0VnW4A==
X-Received: by 2002:a05:6512:3b0d:b0:53e:335b:4348 with SMTP id 2adb3069b0e04-54024113004mr128559e87.40.1733749010712;
        Mon, 09 Dec 2024 04:56:50 -0800 (PST)
Received: from ?IPV6:2001:6b0:1:1041:f9b4:5409:8dcc:9750? ([2001:6b0:1:1041:f9b4:5409:8dcc:9750])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e6b4c051esm732384e87.70.2024.12.09.04.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 04:56:49 -0800 (PST)
Message-ID: <604c3501-f134-4a6e-ad41-ace84c2fd902@gmail.com>
Date: Mon, 9 Dec 2024 13:56:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/19] fsnotify: generate pre-content permission event
 on page fault
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
 linux-fsdevel@vger.kernel.org, amir73il@gmail.com, brauner@kernel.org,
 torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, sraithal@amd.com
References: <cover.1731684329.git.josef@toxicpanda.com>
 <aa56c50ce81b1fd18d7f5d71dd2dfced5eba9687.1731684329.git.josef@toxicpanda.com>
 <5d0cd660-251c-423a-8828-5b836a5130f9@gmail.com>
 <20241209123137.o6bzwr35kumi2ksv@quack3>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20241209123137.o6bzwr35kumi2ksv@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024-12-09 13:31, Jan Kara wrote:
> Hello!
> 
> On Sun 08-12-24 17:58:42, Klara Modin wrote:
>> On 2024-11-15 16:30, Josef Bacik wrote:
>>> FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
>>> on the faulting method.
>>>
>>> This pre-content event is meant to be used by hierarchical storage
>>> managers that want to fill in the file content on first read access.
>>>
>>> Export a simple helper that file systems that have their own ->fault()
>>> will use, and have a more complicated helper to be do fancy things with
>>> in filemap_fault.
>>>
>>
>> This patch (0790303ec869d0fd658a548551972b51ced7390c in next-20241206)
>> interacts poorly with some programs which hang and are stuck at 100 % sys
>> cpu usage (examples of programs are logrotate and atop with root
>> privileges).
>>
>> I also retested the new version on Jan Kara's for_next branch and it behaves
>> the same way.
> 
> Thanks for report! What is your kernel config please? I've just fixed a
> bug reported by [1] which manifested in the same way with
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=n.
> 
> Can you perhaps test with my for_next branch I've just pushed out? Thanks!
> 
> 								Honza

My config was attached, but yes, I have 
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=n. I tried the tip by Srikanth Aithal 
to enable it and that resolved the issue.

Your new for_next branch resolved the 
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=n case for me.

Thanks,
Klara Modin

