Return-Path: <linux-fsdevel+bounces-27485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB21961BFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0F01C2327B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 02:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A9549627;
	Wed, 28 Aug 2024 02:16:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5051B960;
	Wed, 28 Aug 2024 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811375; cv=none; b=hHNFIKH4ftQ/ezKDG3xbs+aOrGrLX/PzrpqEDnPYnzVE8cxsTY+d/puLC14nXq9Sn5U2/9Q72KvIhw5B4e51JhGERAOo6jXDirGgYbj2FpIrV9DxZfXkgeU1j9QYs1z9KSSiUUxpqBhbW5BM5RaAcsN4sQpJE7K4OIUHQugiygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811375; c=relaxed/simple;
	bh=oqJkFVJTgBRE+01WxC3nCa/dHf72LQPBAq6iu2kMxeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tVrVbtvcnGljr4xf6EXdhUjIK0h7ycOub7Ozq4o8r/VuM6nPDUmwLaOJRgxmem3mb2LjzQkdhK+NGZNxIOrE90gWRi/gtqgJorTD4zqefcGle0Fmni1FWpuj++SCJGiNzIW8D7/Dr/RaRuD7iT7ncC78UY64AxMvLt24W3WG0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtnzL24SgzpTtb;
	Wed, 28 Aug 2024 10:14:22 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id C0737180AE6;
	Wed, 28 Aug 2024 10:16:03 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 10:16:03 +0800
Message-ID: <365c0861-2ec9-4722-86ca-d59bf5643268@huawei.com>
Date: Wed, 28 Aug 2024 10:16:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>, Christian Brauner
	<brauner@kernel.org>
CC: <jack@suse.cz>, <viro@zeniv.linux.org.uk>, <gnoack@google.com>,
	<mic@digikod.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
 <20240827021300.GK6043@frogsfrogsfrogs>
 <1183f4ae-4157-4cda-9a56-141708c128fe@huawei.com>
 <20240827053712.GL6043@frogsfrogsfrogs>
 <20240827-abmelden-erbarmen-775c12ce2ae5@brauner>
 <20240827171148.GN6043@frogsfrogsfrogs>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240827171148.GN6043@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/28 1:11, Darrick J. Wong wrote:
> On Tue, Aug 27, 2024 at 11:22:17AM +0200, Christian Brauner wrote:
>> On Mon, Aug 26, 2024 at 10:37:12PM GMT, Darrick J. Wong wrote:
>>> On Tue, Aug 27, 2024 at 10:32:38AM +0800, Hongbo Li wrote:
>>>>
>>>>
>>>> On 2024/8/27 10:13, Darrick J. Wong wrote:
>>>>> On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
>>>>>> Many mainstream file systems already support the GETVERSION ioctl,
>>>>>> and their implementations are completely the same, essentially
>>>>>> just obtain the value of i_generation. We think this ioctl can be
>>>>>> implemented at the VFS layer, so the file systems do not need to
>>>>>> implement it individually.
>>>>>
>>>>> What if a filesystem never touches i_generation?  Is it ok to advertise
>>>>> a generation number of zero when that's really meaningless?  Or should
>>>>> we gate the generic ioctl on (say) whether or not the fs implements file
>>>>> handles and/or supports nfs?
>>>>
>>>> This ioctl mainly returns the i_generation, and whether it has meaning is up
>>>> to the specific file system. Some tools will invoke IOC_GETVERSION, such as
>>>> `lsattr -v`(but if it's lattr, it won't), but users may not necessarily
>>>> actually use this value.
>>>
>>> That's not how that works.  If the kernel starts exporting a datum,
>>> people will start using it, and then the expectation that it will
>>> *continue* to work becomes ingrained in the userspace ABI forever.
>>> Be careful about establishing new behaviors for vfat.
>>
>> Is the meaning even the same across all filesystems? And what is the
>> meaning of this anyway? Is this described/defined for userspace
>> anywhere?
> 
> AFAICT there's no manpage so I guess we could return getrandom32() if we
> wanted to. ;)
> 
> But in seriousness, the usual four filesystems return i_generation.
> That is changed every time an inumber gets reused so that anyone with an
> old file handle cannot accidentally open the wrong file.  In theory one
> could use GETVERSION to construct file handles (if you do, UHLHAND!)
> instead of using name_to_handle_at, which is why it's dangerous to
> implement GETVERSION for everyone without checking if i_generation makes
> sense.

I'm not sure if my understanding of you is correct. As my humble 
opinions, the ioctl is for returning information to the user, and it 
cannot rely on this information returned to the user to ensure the 
security. If the file system wants to be secure internally, it should 
decouple from the VFS layer interface, rather than just not implementing it.
For NFS, constructing a file handle is easy, you can successfully 
construct a file handle by capturing the nfs protocol packet even 
thought the i_generation is not exposed.

Thanks,
Hongbo
> 
> --D

