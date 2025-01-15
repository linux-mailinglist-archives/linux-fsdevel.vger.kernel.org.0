Return-Path: <linux-fsdevel+bounces-39310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76CDA128EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 17:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081D2166FE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506B9166F3A;
	Wed, 15 Jan 2025 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXqeAMQn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEFD155A4E;
	Wed, 15 Jan 2025 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959308; cv=none; b=kyYLHvScTDEGFMBmV/o6+yWZpCJGHrcPoQwLqPAW/J8zzn7lzJHQdkpAUiVoFxHcOT/iUXs+jL08Y4TI2OyBpbBLG4w2Xlc8AUzf/eouf7zBgWnY3Y1vByImhwTzZ2IgvY4yi4+jUN6upfEO88psHWZFnCAz5fOGkySHPDyuXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959308; c=relaxed/simple;
	bh=o+O1KkgOCfZSHPMlSeqwiqCCZ+HlT8GgtbGWqlgblCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQNAYq29IFFr2Pfi6SOYIA9X6ZnnBe443PFAeFgjQBwFEPZjo8ndGJrgPfTyHVt8i45XDqJ7B1+2ytMiDuqJmVoMvMyS6KlVD4nLJfO/uARbhmSXeeGxzkSXbrXdQD+sQTk97Jg9ovD8AM3INbCfjxwmL28LzidwvNlReyCd9oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXqeAMQn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215770613dbso85847695ad.2;
        Wed, 15 Jan 2025 08:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736959306; x=1737564106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vp92K/CnscuW1Z8Iv1vO69wSCVbFsnQzXlMk7515To4=;
        b=IXqeAMQn7HVlvZnejhkBiSLrZjcTJyni8dK95Dp8SagVT90U6ECkFL6+bHcHdUhNwn
         015uuhNhswBd5jaMdKKK8hj6NmOwuI5GbHlCAq0kTI+hklBYqm4HNos1DJz/KfyHIGz0
         SfmP82BOPTjmZ3fPv+q77mvuouLKOpIt8boEb9ULzIQB2d6nEK2siNCOkEAUac0eCLmN
         aRm6dRNGeou9v/D7LMETA681JDYHLukJvl+w1i65Od/TqJ0UEAFHefXRvNkP5zSiayz7
         Zro5O/2tY+b4UxliE0o18ORKub2efFYGcbk+k7Ao8sWG5E+yWhlbI/5CQYC9cYquGZzq
         YU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736959306; x=1737564106;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp92K/CnscuW1Z8Iv1vO69wSCVbFsnQzXlMk7515To4=;
        b=YS82llIwVG/WMVwAiloIdNbbR05OLRt53nZnzHO246yvweP3MctcGjMWXjENJx9+6X
         eE1pjH+lmsqxFD+SSaNLa9+DUwzra6vHK/80szJBiSCeGIHpmgC2TWJ96QGbeRqUW0i6
         bFSSQ++fskHBKHz4SNr23iCs2t9jQ016+jEQlBh4+RhOJeZZcdMbE7xVxhTzyaOOar21
         nxIsovUhC0y6qjXQZdGwUOHXXIjY4dQJQOlV6iwJDtpqEdao6onxRMBHlpe29MqsUALn
         pMT5245jXahmstjLI18LJIZ78iMJ8UgvwsTWNKcMZatUEE6n2RYnGtW48C6Z5ma5npZa
         0RRg==
X-Forwarded-Encrypted: i=1; AJvYcCUKcUqpXMIWOqj35U4X1qW4/3x5tUtmX0ihjatTMG66soNP4/xiMaakg3Bv57r82l2Bh413S2J8CmmXnMX7@vger.kernel.org, AJvYcCVARXgnCevsu37cMWyQ0GNhXY84D6xV2kWCfphBxFl0djHLmKgFvFGUpLnigYAf73Ft1AJ7ein0vekFC2fe@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXrgWl2NhKFso0FL+wvzKnpdNBhS6R6iILOgXX7V/o9++9nGq
	AZENuZzgfurFIGqU9sjy4EN3oOBqFKSuJH9aTK8Swm08FEx8yMhl
X-Gm-Gg: ASbGncsRqdMPQ556iynysSGTSUvJkqLxD6zFVic/1ZHkr4/1hwM3N6sIflSJwSMeelL
	uA0pTvmfP5K1DueTZmhUKn87Dju68Zcd3yH+XTaENymfOhN60v0/gFcrx8IsYpzsbiEOQvpaneU
	76uwsLB3ahih3rfc2ZWPtCcoqX4SRxilsDgo8K++Ua0KK3BYlsRro4GhIDkh+kszp4qm8aBDwJa
	ufM8uGr+K+THPE2NDy7ZEVMA19nSTeBd5MQi3CDbHSduLauwD94/aPIc2hH4EaGyxYCNhx4aWcW
	dj1ctXhwT50Pa2dG+QfRoPlIwx/+tw==
X-Google-Smtp-Source: AGHT+IHgyOemxtdmjl2Wh5yzfKZLW/+OLECB3oHCCC6H9TCj375njznMOdV+kghbjISc0pXTNZk11Q==
X-Received: by 2002:a05:6a00:4486:b0:729:597:4faa with SMTP id d2e1a72fcca58-72d21fb1d72mr41332490b3a.16.1736959305824;
        Wed, 15 Jan 2025 08:41:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405493acsm9294034b3a.28.2025.01.15.08.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 08:41:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0e5dc5f1-c2c2-4893-902b-4677c21a38c0@roeck-us.net>
Date: Wed, 15 Jan 2025 08:41:43 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic
 into __wb_calc_thresh
To: Jan Kara <jack@suse.cz>
Cc: Jim Zhao <jimzhao.ai@gmail.com>, akpm@linux-foundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241121100539.605818-1-jimzhao.ai@gmail.com>
 <a0d751f8-e50b-4fa5-a4bc-bccfc574f3bb@roeck-us.net>
 <b4m3w6wuw3h6ke7qlvimly7nok4ymjvnej2vx3lnds3vysyopr@6b5bnifyst24>
 <64a44636-16ec-4a10-aeb6-e327b7f989c2@roeck-us.net>
 <mqe2boksd5ztaz7xyabyp4sbtufxthcnrbwrjayghe4hpfbp4w@wjqsm467sjp5>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <mqe2boksd5ztaz7xyabyp4sbtufxthcnrbwrjayghe4hpfbp4w@wjqsm467sjp5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/25 08:07, Jan Kara wrote:
> On Tue 14-01-25 07:01:08, Guenter Roeck wrote:
>> On 1/14/25 05:19, Jan Kara wrote:
>>> On Mon 13-01-25 15:05:25, Guenter Roeck wrote:
>>>> On Thu, Nov 21, 2024 at 06:05:39PM +0800, Jim Zhao wrote:
>>>>> Address the feedback from "mm/page-writeback: raise wb_thresh to prevent
>>>>> write blocking with strictlimit"(39ac99852fca98ca44d52716d792dfaf24981f53).
>>>>> The wb_thresh bumping logic is scattered across wb_position_ratio,
>>>>> __wb_calc_thresh, and wb_update_dirty_ratelimit. For consistency,
>>>>> consolidate all wb_thresh bumping logic into __wb_calc_thresh.
>>>>>
>>>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>>>> Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
>>>>
>>>> This patch triggers a boot failure with one of my 'sheb' boot tests.
>>>> It is seen when trying to boot from flash (mtd). The log says
>>>>
>>>> ...
>>>> Starting network: 8139cp 0000:00:02.0 eth0: link down
>>>> udhcpc: started, v1.33.0
>>>> EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2
>>>> udhcpc: sending discover
>>>> udhcpc: sending discover
>>>> udhcpc: sending discover
>>>> EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2
>>>
>>> Thanks for report! Uh, I have to say I'm very confused by this. It is clear
>>> than when ext2 detects the directory corruption (we fail checking directory
>>> inode 363 which is likely /etc/init.d/), the boot fails in interesting
>>> ways. What is unclear is how the commit can possibly cause ext2 directory
>>> corruption.  If you didn't verify reverting the commit fixes the issue, I'd
>>> be suspecting bad bisection but that obviously isn't the case :-)
>>>
>>> Ext2 is storing directory data in the page cache so at least it uses the
>>> subsystem which the patch impacts but how writeback throttling can cause
>>> ext2 directory corruption is beyond me. BTW, do you recreate the root
>>> filesystem before each boot? How exactly?
>>
>> I use pre-built root file systems. For sheb, they are at
>> https://github.com/groeck/linux-build-test/tree/master/rootfs/sheb
> 
> Thanks. So the problematic directory is /usr/share/udhcpc/ where we
> read apparently bogus metadata at the beginning of that directory.
> 
>> I don't think this is related to ext2 itself. Booting an ext2 image from
>> ata/ide drive works.
> 
> Interesting this is specific to mtd. I'll read the patch carefully again if
> something rings a bell.
> 

Interesting. Is there some endianness issue, by any chance ? I only see the problem
with sheb (big endian), not with sh (little endian). I'd suspect that it is an
emulation bug, but it is odd that the problem did not show up before.

Guenter


