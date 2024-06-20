Return-Path: <linux-fsdevel+bounces-22028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C349111D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 21:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C431C21892
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 19:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5381B4C43;
	Thu, 20 Jun 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KtKdoKGo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA2024B26;
	Thu, 20 Jun 2024 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910612; cv=none; b=s/2sDAzkSGXhC2QtDyCF3FC60cw/YfPTRQMSi9c2aXgf9xRBSYW5sNY7e8o2omNFOC5F1z27YW8wgnPN2wyOcx2S4i05hOpp/7pPjU0zl7nigsu2Qox6sWJ0X9SnPNga9L6oUs2C2I1D0VEqMb8ohqwfg5Wcmy17hv+umXTQ1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910612; c=relaxed/simple;
	bh=/bZO7KBfc1icR2aYLxz8pBdXer6KXEPsVMDJbOg/XA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GI780qevwpXVpSD2huncA05tFOeMhkKGC75ceuxA++AWQye5bI21C/tnVAeu03sm4x2opRPlwSftvR+ogIYUJsLnu9YbYGIr0d3qR9NzUn/KHSRqGLmWlyaT5Xcc4eE5S+P/8vdS2c14a4D/ynoTtCvWUdI+H456a9N88IAjFoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KtKdoKGo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id AE71520B7004;
	Thu, 20 Jun 2024 12:10:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE71520B7004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718910610;
	bh=EB16k8E5Dq1wrCvj7jANLEEY8d68lGEG/tqRU0fokDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KtKdoKGo9qhs+Po3kvp/pEKlnQvMyzHhcHHRbWTrYVu9MLKXowoSxvH8j7ZYo2/FV
	 i1FYLslX5/r2GNjOr1ZmBGO1wvVYbA0OKh+VYI7gVyouTZc7Rb4WmiPcLpHe2B0+X0
	 v9BUyOkl9M5a5FTmBkgBHouZ9O/cSbVmMNtmSw7c=
Message-ID: <1465b0a4-6a99-45d5-b170-7d2e470f555d@linux.microsoft.com>
Date: Thu, 20 Jun 2024 12:10:10 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] binfmt_elf, coredump: Log the reason of the failed
 core dumps
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 akpm@linux-foundation.org, apais@linux.microsoft.com, ardb@kernel.org,
 brauner@kernel.org, jack@suse.cz, keescook@chromium.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, nagvijay@microsoft.com, oleg@redhat.com,
 tandersen@netflix.com, vincent.whitchurch@axis.com, viro@zeniv.linux.org.uk,
 apais@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
 vdso@hexbites.dev
References: <20240617234133.1167523-1-romank@linux.microsoft.com>
 <20240617234133.1167523-2-romank@linux.microsoft.com>
 <20240618061849.Vh9N3ds2@linutronix.de>
 <c4644f2c-fad3-4d98-8301-acdc0ff2f3a6@linux.microsoft.com>
 <87sexakkvu.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <87sexakkvu.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/2024 2:21 PM, Eric W. Biederman wrote:
> Roman Kisel <romank@linux.microsoft.com> writes:
> 
>> On 6/17/2024 11:18 PM, Sebastian Andrzej Siewior wrote:
>>> On 2024-06-17 16:41:30 [-0700], Roman Kisel wrote:
>>>> Missing, failed, or corrupted core dumps might impede crash
>>>> investigations. To improve reliability of that process and consequently
>>>> the programs themselves, one needs to trace the path from producing
>>>> a core dumpfile to analyzing it. That path starts from the core dump file
>>>> written to the disk by the kernel or to the standard input of a user
>>>> mode helper program to which the kernel streams the coredump contents.
>>>> There are cases where the kernel will interrupt writing the core out or
>>>> produce a truncated/not-well-formed core dump.
>>> How much of this happened and how much of this is just "let me handle
>>> everything that could go wrong".
>> Some of that must be happening as there are truncated dump files. Haven't run
>> the logging code at large scale yet with the systems being stressed a lot by the
>> customer workloads to hit all edge cases. Sent the changes to the kernel mail
>> list out of abundance of caution first, and being ecstatic about that: on the
>> other thread Kees noticed I didn't use the ratelimited logging. That has
>> absolutely made me day and whole week, just glowing :) Might've been a close
>> call due to something in a crash loop.
> 
> Another reason you could have truncated coredumps is the coredumping
> process being killed.
> 
> I suspect if you want reasons why the coredump is truncated you are
> going to want to instrument dump_interrupted, dump_skip and dump_emit
> rather than their callers.  As they don't actually report why the
> failed.
I'll add logging there as well, thanks for the great idea!

> 
> Are you using systemd-coredump?  Or another pipe based coredump
> collector?  It might be the dump collector is truncating things.
There is a collector program set via core_pattern so that the core dump 
is streamed to its standard input. That is a very simple memcpy-like 
bytes-in..bytes-out code. It logs how many bytes it receives and how 
many bytes it writes, and no bytes are lost in this path. Of the system 
itself, it is built out of the latest stable LTS kernel and a small user 
land, not based on any distribution and packet management. One might say 
it resembles an appliance.

> 
> Do you know if your application uses io_uring?  There were some weird
> issues with io_uring and coredumps that were causing things to get
> truncation at one point.  As I recall a hack was put in the coredump
> code so that it worked but maybe there is another odd case that still
> needs to be handled.
Couldn't appreciate the pointer more! There are cases when the user land 
reaches out to io_uring, not the work horse though.

>>
>> I think it'd be fair to say that I am asking to please "let me handle (log)
>> everything that could go wrong", ratelimited, as these error cases are present
>> in the code, and logging can give a clue why the core dump collection didn't
>> succeed and what one would need to explore to increase reliability of the
>> system.
> 
> If you are looking for reasons you definitely want to instrument
> fs/coredump.c much more than fs/binfmt_elf.c.  As fs/coredump.c is the
> code that actually performs the writes.
Understood, thank you very much!

> 
> One of these days if someone is ambitious we should probably merge the
> coredump code from fs/binfmt_elf.c and fs/binfmt_elf_fdpic.c and just
> hardcode the coredump code to always produce an elf format coredump.
> Just for the simplicity of it all.
I've had loads of experience with collecting and analyzing ELF core dump 
files, including a tool that parses machine state, rebuilds the 
necessary Linux kernel structures and produces ELF core dump files for 
the user land processes from that. Perhaps I could embark on that 
ambitious journey if no one else has time :)

> 
> Eric

-- 
Thank you,
Roman

