Return-Path: <linux-fsdevel+bounces-31285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76893994302
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 10:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87F01C208B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 08:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE31C2DB8;
	Tue,  8 Oct 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gEHmTwMX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD81C2447
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377315; cv=none; b=WM+2SnuV8YALHFRKgvN50CSnJUUSmO/QzL7ca3w07aai2IASImwg/4Fv1pf5HvP0WMwUTyiyqKtCqt1T5pU2Np+ySUjlxxm95DIllipzKqHf5EGzd1ZKyfxtiAI3swru1Qc/XuKVpWnDaZcmmLDk5sMT3k2RZ/zD7ORIKHllJAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377315; c=relaxed/simple;
	bh=E63uzgAgXUDHWhpT/ft/mYho9ddyK6q2dIwtOXwLmB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNwHcG3sMBOwnLFQ42GxW1hXrp7k/R7WxDREXdXdTRW+i3HeQFxKhFkYSppa62Xgin8PZF1dUv67gR/ONW2PqA9ntsVedWZv8emnBuM3AaEH61GxNkAAL4vi0yS6bbDtpLibfjxa5dLPY8x2olwvCKmxza0xwCerfvbscKs02bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gEHmTwMX; arc=none smtp.client-ip=47.90.199.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728377297; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0NyW6bEkcTAV3r2ZXDGCX9ZEqYnZHArarZL+caGXqFU=;
	b=gEHmTwMXfhm1fSdjn4J1yf0DWDJ7U0T2eb+gDm2fNRp+x/KuMb3Sja6xQ+Or887+BFIIc2p4uxkolhOC3Ip4UIVA9fQKn8yigcZPz4hE60Vts6wmvx4Pd+An7U6xG/3mRBsLfv158CvTtH3YbhJC3qedkWtfpxaSi00PhAqe75g=
Received: from 30.221.129.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGcMdA8_1728377295)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 16:48:16 +0800
Message-ID: <e164898b-0094-4e66-a462-4302d56a8f71@linux.alibaba.com>
Date: Tue, 8 Oct 2024 16:48:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incorrect error message from erofs "backed by file" in 6.12-rc
To: Christian Brauner <brauner@kernel.org>
Cc: Allison Karlitskaya <allison.karlitskaya@redhat.com>,
 Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com>
 <bb781cf6-1baf-4a98-94a5-f261a556d492@linux.alibaba.com>
 <20241007-zwietracht-flehen-1eeed6fac1a5@brauner>
 <b9565874-7018-46ef-b123-b524a1dffb21@linux.alibaba.com>
 <20241008-blicken-ziehharmonika-de395b6dd566@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241008-blicken-ziehharmonika-de395b6dd566@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/8 16:46, Christian Brauner wrote:
> On Tue, Oct 08, 2024 at 10:13:31AM GMT, Gao Xiang wrote:
>> Hi Christian,
>>
>> On 2024/10/7 19:35, Christian Brauner wrote:
>>> On Sat, Oct 05, 2024 at 10:41:10PM GMT, Gao Xiang wrote:
>>
>> ...
>>
>>>>
>>>> Hi Christian, if possible, could you give some other
>>>> idea to handle this case better? Many thanks!
>>
>> Thanks for the reply!
>>
>>>
>>> (1) Require that the path be qualified like:
>>>
>>>       fsconfig(<fd>, FSCONFIG_SET_STRING, "source", "file:/home/lis/src/mountcfs/cfs", 0)
>>>
>>>       and match on it in either erofs_*_get_tree() or by adding a custom
>>>       function for the Opt_source/"source" parameter.
>>
>> IMHO, Users could create names with the prefix `file:`,
>> it's somewhat strange to define a fixed prefix by the
>> definition of source path fc->source.
>>
>> Although there could be some escape character likewise
>> way, but I'm not sure if it's worthwhile to work out
>> this in kernel.
>>
>>>
>>> (2) Add a erofs specific "source-file" mount option. IOW, check that
>>>       either "source-file" or "source" was specified but not both. You
>>>       could even set fc->source to "source-file" value and fail if
>>>       fc->source is already set. You get the idea.
>>
>> I once thought to add a new mount option too, yet from
>> the user perpertive, I think users may not care about
>> the source type of an arbitary path, and the kernel also
>> can parse the type of the source path directly... so..
>>
>>
>> So.. I wonder if it's possible to add a new VFS interface
>> like get_tree_bdev_by_dev() for filesystems to specify a
>> device number rather than hardcoded hard-coded source path
>> way, e.g. I could see the potential benefits other than
>> the EROFS use case:
>>
>>   - Filesystems can have other ways to get a bdev-based sb
>>     in addition to the current hard-coded source path way;
>>
>>   - Some pseudo fs can use this way to generate a fs from a
>>     bdev.
>>
>>   - Just like get_tree_nodev(), it doesn't strictly tie to
>>     fc->source too.
>>
>> Also EROFS could lookup_bdev() (this kAPI is already
>> exported) itself to check if it uses get_tree_bdev_by_dev()
>> or get_tree_nodev()... Does it sounds good?  Many thanks!
> 
> Sounds fair to me.

Okay, thanks! Let me submit patches for this.

Thanks,
Gao Xiang

