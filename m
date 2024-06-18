Return-Path: <linux-fsdevel+bounces-21891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B63A90D7C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 17:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F009DB2BC01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34854D5BF;
	Tue, 18 Jun 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="swQgC/68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95ED4C3C3;
	Tue, 18 Jun 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725770; cv=none; b=Oph713jMMwXqdnA4QHJBakf6BvJRIM6xI9tt5InILddij6L6yKU7OfT8ZfqxO+/6PmM70zfQDYG8x2F5zR4g2gQe0wd+zzHUJXh3jeTyJVF9TrPCWm+YeOOEU0ox3uZkvCGYhg5cDHJsyNUMoNQ/ziUKjcDjR7ycinPlkpUpZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725770; c=relaxed/simple;
	bh=VDAmMvtOB2//h0zeWT/JYq9ZAZddvptKZ08sdo2hLOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5i7Lb0SPb7xx52ztdSmYZO/QnWwsK+msqlOR5R+vPcVvv7nMjf+QFqipFFwpy12vUPL7Z5Y3mhzTBp1QNT4Fv/wOie0mViYk2kgSSlY7RAUC2fDnXXADUVf7slyeWlM1y3irj0XXnHL9VSrciGrQN+rDbEtT8O3r42dA+aaA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=swQgC/68; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D1DB20B7004;
	Tue, 18 Jun 2024 08:49:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D1DB20B7004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718725768;
	bh=tX2N35H3fv6NeRdhpyR+cJNtoGziZpdk/cgSbaToEsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=swQgC/68sz1D7Dfg/1aePI2cIVOlg3Ha1InwP6XMzD0fxH3G96AcP787s9wS/JSU5
	 ueAd6M/bSSYuH48oEzrGCHAMvdZuc5pbsTygCqLcFFTjw31t1ebaaPdVacODf4zY1j
	 ZzfM/Q3UPibpBXGhndLcgTpjWgvFyVkWWAxKzhkM=
Message-ID: <63cf9746-204e-4b04-8bd4-a43a2e7a6cc3@linux.microsoft.com>
Date: Tue, 18 Jun 2024 08:49:29 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] binfmt_elf, coredump: Log the reason of the failed
 core dumps
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, apais@linux.microsoft.com, ardb@kernel.org,
 bigeasy@linutronix.de, brauner@kernel.org, ebiederm@xmission.com,
 jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, nagvijay@microsoft.com, oleg@redhat.com,
 tandersen@netflix.com, vincent.whitchurch@axis.com, viro@zeniv.linux.org.uk,
 apais@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
 vdso@hexbites.dev
References: <20240617234133.1167523-1-romank@linux.microsoft.com>
 <20240617234133.1167523-2-romank@linux.microsoft.com>
 <202406171649.8F31EAFE@keescook>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <202406171649.8F31EAFE@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/2024 4:52 PM, Kees Cook wrote:
> On Mon, Jun 17, 2024 at 04:41:30PM -0700, Roman Kisel wrote:
>> Missing, failed, or corrupted core dumps might impede crash
>> investigations. To improve reliability of that process and consequently
>> the programs themselves, one needs to trace the path from producing
>> a core dumpfile to analyzing it. That path starts from the core dump file
>> written to the disk by the kernel or to the standard input of a user
>> mode helper program to which the kernel streams the coredump contents.
>> There are cases where the kernel will interrupt writing the core out or
>> produce a truncated/not-well-formed core dump.
> 
> Hm, I'm all for better diagnostics, but they need to be helpful and not
> be a risk to the system. All the added "pr_*()" calls need to use the
> _ratelimited variant to avoid a user inducing massive spam to the system
> logs. And please standardize the reporting to include information about
> the task that is dumping. Otherwise the logging isn't useful for anyone
> reading it. Something that includes pid and task->comm at the very
> least. :)
Appreciate your suggestions very much! Rate-limiting has definitely 
slipped off my mind, my bad. Will also fix the reporting format to make 
it useful.

> 
> For example, see report_mem_rw_reject() in
> https://lore.kernel.org/lkml/20240613133937.2352724-2-adrian.ratiu@collabora.com/
Thanks, that's awesome!

> 
> -Kees
> 

-- 
Thank you,
Roman

