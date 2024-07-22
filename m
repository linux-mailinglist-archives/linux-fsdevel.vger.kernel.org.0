Return-Path: <linux-fsdevel+bounces-24093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2CB939447
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 21:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCE71C20C2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 19:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805A17106F;
	Mon, 22 Jul 2024 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K0WwCs2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A301BF54;
	Mon, 22 Jul 2024 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676819; cv=none; b=c6GJpt6gU1DYzLZTyoSDPGeCPQc658tspd5VqXkIfjjZwSR2HBO1uLeZLsRPe8ADC6DT6v7XQ+Pyrc+AS9dv6zxZMbh9d7poGBuc5GihK7TJAd1PXSb6YceTw8ion7qh8+kKfERkldrClvQxImLQMP23H5lBWjoFNApWKl1Tj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676819; c=relaxed/simple;
	bh=V3RdNCLfqTzl4phmPklsYaC0g1NAJZTTX9RtkweFi4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RH/ZdYjKHtPbjdBGVYeD41lpADGtg3DBQg2uERtfLH3luUQ8T1RTJ13R1zcUe9FkJv1uHqVAjwLB+oXfmirpDBcOq8q5a3EUkldxOpcBZIyL3ntDzekQcnr3xi87SCgYaWjHGe6+9M47u257206yFfdetmXSmjO5FoYaUYIdVuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K0WwCs2F; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3A29F20B7165;
	Mon, 22 Jul 2024 12:33:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A29F20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721676817;
	bh=iJVrpP7xI5TjeNlTtrzs9oyrSA2ufOMqSutgFuOLvmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K0WwCs2Fg3A5Ob7+LH/0y+sxt6WB/DG7QQa3d7L3SicJ/FjQvKaNsQN19Zku5M9I5
	 kKtPDRQHH3pJE46MjiIHVqpS5Zy0e4ChFsUhXB47xpU/jWoTgWvQM5K0tsz6FVllTC
	 iScxaBmjFiB3VYolDNXaDnI0Pp0uPgbh8HI583SQ=
Message-ID: <fa6a6ba2-c920-477c-8145-a437f18a79a0@linux.microsoft.com>
Date: Mon, 22 Jul 2024 12:33:38 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] binfmt_elf, coredump: Log the reason of the failed
 core dumps
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, apais@linux.microsoft.com, ardb@kernel.org,
 bigeasy@linutronix.de, brauner@kernel.org, ebiederm@xmission.com,
 jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, nagvijay@microsoft.com, oleg@redhat.com,
 tandersen@netflix.com, vincent.whitchurch@axis.com, viro@zeniv.linux.org.uk,
 apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240718182743.1959160-1-romank@linux.microsoft.com>
 <202407191026.DC2644DD88@keescook>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <202407191026.DC2644DD88@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/19/2024 10:26 AM, Kees Cook wrote:
> On Thu, Jul 18, 2024 at 11:27:23AM -0700, Roman Kisel wrote:
>> A powerful way to diagnose crashes is to analyze the core dump produced upon
>> the failure. Missing or malformed core dump files hinder these investigations.
>> I'd like to propose changes that add logging as to why the kernel would not
>> finish writing out the core dump file.
>>
>> To help in diagnosing the user mode helper not writing out the entire coredump
>> contents, the changes also log short statistics on the dump collection. I'd
>> advocate for keeping this at the info level on these grounds.
>>
>> For validation, I built the kernel and a simple user space to exercize the new
>> code.
>>
>> [V3]
>>    - Standartized the existing logging to report TGID and comm consistently
>>    - Fixed compiler warnings for the 32-bit systems (used %zd in the format strings)
>>
>> [V2]
>>    https://lore.kernel.org/all/20240712215223.605363-1-romank@linux.microsoft.com/
>>    - Used _ratelimited to avoid spamming the system log
>>    - Added comm and PID to the log messages
>>    - Added logging to the failure paths in dump_interrupted, dump_skip, and dump_emit
>>    - Fixed compiler warnings produced when CONFIG_COREDUMP is disabled
>>
>> [V1]
>>    https://lore.kernel.org/all/20240617234133.1167523-1-romank@linux.microsoft.com/
>>
>> Roman Kisel (2):
>>    coredump: Standartize and fix logging
>>    binfmt_elf, coredump: Log the reason of the failed core dumps
>>
>>   fs/binfmt_elf.c          |  48 +++++++++----
>>   fs/coredump.c            | 150 +++++++++++++++++++++++++++------------
>>   include/linux/coredump.h |  30 +++++++-
>>   kernel/signal.c          |  21 +++++-
>>   4 files changed, 188 insertions(+), 61 deletions(-)
> 
> This looks good to me! I'll put this in -next once the merge window
> closes. Thanks!
> 
Kees, thank you for your guidance!

> -Kees
> 

-- 
Thank you,
Roman


