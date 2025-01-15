Return-Path: <linux-fsdevel+bounces-39314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F6AA12932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 17:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AAE3A36D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E7E16DEA0;
	Wed, 15 Jan 2025 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Apkm6Xpi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9615B14B;
	Wed, 15 Jan 2025 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959968; cv=none; b=LCN5Q69lHg6+KZIXa0rZ36mxZnY348BdndK5FzPdNlvmHm+pm/CylydDwSrRtmevnbs//xG4vFLOzuVj548E2+9TenLg4jlVrWlUGkQMcDhsytnlk3r+BnY5A4UPjKzAZHoCxJ9aiqbEwMQc3Cf+i4QIHYgCivjscWvKNAuoYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959968; c=relaxed/simple;
	bh=PbkBpyIDexbuurPvfMRdrNZ+cnNqJRtGKEusduQy/yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVRXmM/DcKKETw0DgUE/7sFDgxekegTXoebySyzxr+w3Cx0xHpvWYJU59xF6Tvu20D4Wnn2jCIbdPbHp3niWaeRagSS9bQA/w5Ks1z9PZihBm8DccIW5J/bBi33RmYY2MuoQcugsJNyBFF/Z4TmdkkiS3ZWWFFSadKZ08aAMOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Apkm6Xpi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215770613dbso86010555ad.2;
        Wed, 15 Jan 2025 08:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736959966; x=1737564766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OWa1legH6BGRarIfhhVIacdJPMo2926WEjTBZMjiIcs=;
        b=Apkm6XpiS2WZRdaSQFJzyeXqudXa0Nk614/qbdklhuz+cJ9/Vm52O1ehMBFU0lWIcP
         y/2dQnmxcbUjvFmFbQOQwVVkkJ82p8aNxAzPvmp5BXF9TmUfHdSIk5hhcXhlI/i4m/a/
         exfZkBK1j/vpkn1vvV+5D1HNKSvTohZOlrR7NAb+ChoPjAx86Oav7iWRcj7TJy6IlzAC
         aT1b7dE8K6CbhKYRl7SNddBN0tHYDpszBqMPcgUzJPlduGQimdCY3fimcGxi+mbDF0mS
         4P2B0kXDoYVh96+IJ795O5A2ZinY3Fv68Hh/882+Fi5kskzny9U1C27sQV5RGScyvMrz
         +zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736959966; x=1737564766;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWa1legH6BGRarIfhhVIacdJPMo2926WEjTBZMjiIcs=;
        b=EeydjRFueJg36M7qZRIyZRVgDox0j9cj7QZWUpHffjfVxZJV8cC40XonMXoaZdRNgF
         r3CWU5vD0gnkCZpRBzbxf992WqDb/iOwHuzLZfWwVTYv95YGHWXMaF8Th3KBAx/UfPT9
         ByfWXFrxGiABfhShWqj/anDpzh9C3l+qaEsUTPTloBq3RFiejN4YrFK0Hh9zQHVXi7ly
         30SIXiMsdcyTg2QZdbJKc1T/LBAjhlNQSuQUxCROagVHj+17uULou5YlChUea1su0BGP
         P7hG8da8Ig5QVwu+iY02tFOxIMLE2necvPbe1jTSxVm9mQyWeL8f7Tm4Jm06/OGwAY7P
         XNtg==
X-Forwarded-Encrypted: i=1; AJvYcCVxeR0xBne/9nTE0hFqRH6EPPL7yW+V0BFDNKpuUIcV8+8b4DGaT8ht5RHOElR5V76Kab3w9mNHqCuZ+7XM@vger.kernel.org, AJvYcCWd8JTR2vYvla/Aq+WuDnbZNHb49fxjACUZs5AOFyib2B+RsRkFK/QCHcCjdNvhGTjpk5UO6VBnC/Utd4wd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VCo4BGp6MDt3LZKLmRAZnCqd5gP7fCTU4KypKimbr7NUGz6h
	TO6GV5u9VEBbvvt/Dws5hbExY07k278bjkaRaaNviuNfHWFEUHjB
X-Gm-Gg: ASbGncsKpp8YvZZ3eO0gLjY2nz4yVmQoRU1WL+Pp3Gi9w6XbrZmCfMNPrAM3w55gvpa
	LIna2QcnC4Yskxc2yKqjF9Z6UprZ4Cgri9wkkhfKXzp50rqoT7q8yEvezzP9xXEhDVI5Ek+0Mi4
	u94I+GsKdpvGzKm81+f4RBK/WTacGirBvJm/Bxn2r4kPM5wLVVjZIYMTEa00FY9bw4zU4yHEFaU
	WipQCn64s0bYz5itpuD4jvT6AqlpyPIrA9NWdawnOpaUGjtNuXqXcVViiT2mDfvconNwnwt0Odt
	YvVX0glb85WrS3w4nYVYxENNjoh9lQ==
X-Google-Smtp-Source: AGHT+IG+9x/+4ny/Ei1cGAgDsLOt92iTMeyjIvt7gKL8KQQeFD52KLjoPDVmClNZM6wxsUCLoLE4zw==
X-Received: by 2002:a17:903:24e:b0:216:794f:6d7d with SMTP id d9443c01a7336-21a83ffc1fcmr479062195ad.48.1736959965986;
        Wed, 15 Jan 2025 08:52:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219302sm84817715ad.149.2025.01.15.08.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 08:52:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <885e0ae3-1d2e-43c7-a32b-f29871fc6b4b@roeck-us.net>
Date: Wed, 15 Jan 2025 08:52:43 -0800
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
 <pir6qmj2la57tvjkan5wbhjnji6tw27w45axseqcgfx4zzvz44@3mthcpyjomgw>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <pir6qmj2la57tvjkan5wbhjnji6tw27w45axseqcgfx4zzvz44@3mthcpyjomgw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/25 08:28, Jan Kara wrote:
> On Wed 15-01-25 17:07:36, Jan Kara wrote:
>> On Tue 14-01-25 07:01:08, Guenter Roeck wrote:
>>> On 1/14/25 05:19, Jan Kara wrote:
>>>> On Mon 13-01-25 15:05:25, Guenter Roeck wrote:
>>>>> On Thu, Nov 21, 2024 at 06:05:39PM +0800, Jim Zhao wrote:
>>>>>> Address the feedback from "mm/page-writeback: raise wb_thresh to prevent
>>>>>> write blocking with strictlimit"(39ac99852fca98ca44d52716d792dfaf24981f53).
>>>>>> The wb_thresh bumping logic is scattered across wb_position_ratio,
>>>>>> __wb_calc_thresh, and wb_update_dirty_ratelimit. For consistency,
>>>>>> consolidate all wb_thresh bumping logic into __wb_calc_thresh.
>>>>>>
>>>>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>>>>> Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
>>>>>
>>>>> This patch triggers a boot failure with one of my 'sheb' boot tests.
>>>>> It is seen when trying to boot from flash (mtd). The log says
>>>>>
>>>>> ...
>>>>> Starting network: 8139cp 0000:00:02.0 eth0: link down
>>>>> udhcpc: started, v1.33.0
>>>>> EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2
>>>>> udhcpc: sending discover
>>>>> udhcpc: sending discover
>>>>> udhcpc: sending discover
>>>>> EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2
>>>>
>>>> Thanks for report! Uh, I have to say I'm very confused by this. It is clear
>>>> than when ext2 detects the directory corruption (we fail checking directory
>>>> inode 363 which is likely /etc/init.d/), the boot fails in interesting
>>>> ways. What is unclear is how the commit can possibly cause ext2 directory
>>>> corruption.  If you didn't verify reverting the commit fixes the issue, I'd
>>>> be suspecting bad bisection but that obviously isn't the case :-)
>>>>
>>>> Ext2 is storing directory data in the page cache so at least it uses the
>>>> subsystem which the patch impacts but how writeback throttling can cause
>>>> ext2 directory corruption is beyond me. BTW, do you recreate the root
>>>> filesystem before each boot? How exactly?
>>>
>>> I use pre-built root file systems. For sheb, they are at
>>> https://github.com/groeck/linux-build-test/tree/master/rootfs/sheb
>>
>> Thanks. So the problematic directory is /usr/share/udhcpc/ where we
>> read apparently bogus metadata at the beginning of that directory.
> 
> Ah, the metadata isn't bogus. But the entries in the directory are
> apparently byte-swapped (little vs big endian). Is the machine actually
> little or big endian?
> 

sheb is big endian. I only see the problem there, not with the little endian
emulation. But that uses a different root file system. As I just mentioned
in the other reply, it might well be an emulation bug, but it is odd that your
patch would be required to expose that.

Guenter


