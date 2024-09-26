Return-Path: <linux-fsdevel+bounces-30168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F549874F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 15:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E02835A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 13:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FA513049E;
	Thu, 26 Sep 2024 13:58:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255576036;
	Thu, 26 Sep 2024 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359110; cv=none; b=r7gvkuTCPlTwPFAS6nwEFyZipGFOK5TnmxMbzfO/Nn+cbToZzcDd3784KzdtRiT58D6VpQIo3qt0JcUHmNAeCd4IlwL4iZqYfKyk2nCEAhrKpg7d35fPfZBm44JWu4LQLcJvtZg72Fzs50jVqKPx12JqpbvXj43SeMfgEmQPYXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359110; c=relaxed/simple;
	bh=03IWg7hthrX9YAFa4mhsvQw+NMi35KFaWCirLsTNyiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K4qDG5yZ1ziV0K0CE+00qeqQCQXC/MeCIvGEaVje1cDo9oBjW6wP2TaR7M47A1mmjWWgww/h84SlLNijAJRFaa3kF5qJwaraEyV/dQfrHV7XPbTk4pudy2ovKZVlswVOxhExWoRtIshEf6Vh++rSkv6MaTOBWzNnYkna9vo5Ej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XDw7s3VYSz1HJpM;
	Thu, 26 Sep 2024 21:54:33 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 38A40180019;
	Thu, 26 Sep 2024 21:58:25 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.174) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 21:58:24 +0800
Message-ID: <941f8157-6515-40d3-98bd-ca1c659ef9e0@huawei.com>
Date: Thu, 26 Sep 2024 21:58:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
CC: Jan Kara <jack@suse.cz>, <tytso@mit.edu>, <stable@vger.kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>, =?UTF-8?Q?St=C3=A9phane_Graber?=
	<stgraber@stgraber.org>, Christian Brauner <brauner@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, Wesley Hershberger
	<wesley.hershberger@canonical.com>, Yang Erkun <yangerkun@huawei.com>
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3>
 <CAEivzxfjnKq2fgCfYwhZukAO-ZfoUiC5n0Y5yaUpuz-y7kDf+g@mail.gmail.com>
 <dcda93dd-f2ef-4419-ae73-7d3c55b5df8f@huawei.com>
 <CAEivzxdnAt3WbVmMLpb+HCBSrwkX6vesMvK3onc+Zc9wzv1EtA@mail.gmail.com>
 <4ce5c69c-fda7-4d5b-a09e-ea8bbca46a89@huawei.com>
 <CAEivzxekNfuGw_aK2yq91OpzJfhg_RDDWO2Onm6kZ-ioh3GaUg@mail.gmail.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <CAEivzxekNfuGw_aK2yq91OpzJfhg_RDDWO2Onm6kZ-ioh3GaUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/9/26 19:32, Aleksandr Mikhalitsyn wrote:
>>> Question to you and Jan. Do you guys think that it makes sense to try
>>> to create a minimal reproducer for this problem without Incus/LXD involved?
>>> (only e2fsprogs, lvm tools, etc)
>>>
>>> I guess this test can be put in the xfstests test suite, right?
>>>
>>> Kind regards,
>>> Alex
>> I think it makes sense, and it's good to have more use cases to look
>> around some corners. If you have an idea, let it go.
> Minimal reproducer:
>
> mkdir -p /tmp/ext4_crash/mnt
> EXT4_CRASH_IMG="/tmp/ext4_crash/disk.img"
> rm -f $EXT4_CRASH_IMG
> truncate $EXT4_CRASH_IMG --size 25MiB
> EXT4_CRASH_DEV=$(losetup --find --nooverlap --direct-io=on --show
> $EXT4_CRASH_IMG)
> mkfs.ext4 -E nodiscard,lazy_itable_init=0,lazy_journal_init=0 $EXT4_CRASH_DEV
> mount $EXT4_CRASH_DEV /tmp/ext4_crash/mnt
> truncate $EXT4_CRASH_IMG --size 3GiB
> losetup -c $EXT4_CRASH_DEV
> resize2fs $EXT4_CRASH_DEV
>
Hi Alex,

This replicator didn't replicate the issue in my VM, so I took a deeper
look. The reproduction of the problem requires the following:

o_group = flexbg_size * 2 * n;
o_size = (o_group + 1) * group_size;
n_group: [o_group + flexbg_size, o_group + flexbg_size * 2)

Take n=1,flexbg_size=16 as an example:
                                                  last:47
|----------------|----------------|o---------------|--------------n-|
                                   old:32 >>>           new:62

Thus the replicator can be simplified as:

img=test.img
truncate -s 600M $img
mkfs.ext4 -F $img -b 1024 -G 16 264M
dev=`losetup -f --show $img`
mkdir -p /tmp/test
mount $dev /tmp/test
resize2fs $dev 504M


-- 
Cheers,
Baokun


