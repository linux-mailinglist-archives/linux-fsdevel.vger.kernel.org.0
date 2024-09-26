Return-Path: <linux-fsdevel+bounces-30174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CC59875BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 16:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810E21C21334
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250B115098E;
	Thu, 26 Sep 2024 14:35:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC4914D703;
	Thu, 26 Sep 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361310; cv=none; b=kLGeJvkKqQIK4BmCetCMjiwMGCa2rC1BxKbN3I8zT2UMkeNfBPIcCmYiDJjfTK+VOMn9WJWfO9TJQa73d+exbWAVJ0OZolTVRskSCkAxxAPLPYZn1aJNgIhGsi7nGHLBjIcD8iEB1VQ/KWr7fh/i9mhTpWuFvQJjb8bYzcCaqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361310; c=relaxed/simple;
	bh=p5wbQk35AoSwQfh8OuKiZhP3/jLjrczCZQmoWXzavQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j9h5/gxhjrNR0DKggaZndC3o7xL6sum+vMfm3PF3B0Xn3vENsSGz8v7W0kcDgRnna8sE6dE6r5xnqfc/p/4KsA1DebuXh+pAkM+dsp8XZzxmW4nxSwY5gSnzR9C27UFw7stBejIF7EtLsfOnYjvHoSK/dXAK7WGt11RN9Qjm+HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XDx2f3XVXz1ymPg;
	Thu, 26 Sep 2024 22:35:06 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AA58180019;
	Thu, 26 Sep 2024 22:35:04 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.174) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 22:35:03 +0800
Message-ID: <9aa773bd-44e8-4e4b-9628-dfbd3bd0a2af@huawei.com>
Date: Thu, 26 Sep 2024 22:35:03 +0800
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
 <941f8157-6515-40d3-98bd-ca1c659ef9e0@huawei.com>
 <CAEivzxcR+yy1HcZSXmRKOuAuGDnwr=EK_G5mRgk4oNxEPMH_=A@mail.gmail.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <CAEivzxcR+yy1HcZSXmRKOuAuGDnwr=EK_G5mRgk4oNxEPMH_=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/9/26 22:19, Aleksandr Mikhalitsyn wrote:
> On Thu, Sep 26, 2024 at 3:58 PM Baokun Li <libaokun1@huawei.com> wrote:
>> On 2024/9/26 19:32, Aleksandr Mikhalitsyn wrote:
>>>>> Question to you and Jan. Do you guys think that it makes sense to try
>>>>> to create a minimal reproducer for this problem without Incus/LXD involved?
>>>>> (only e2fsprogs, lvm tools, etc)
>>>>>
>>>>> I guess this test can be put in the xfstests test suite, right?
>>>>>
>>>>> Kind regards,
>>>>> Alex
>>>> I think it makes sense, and it's good to have more use cases to look
>>>> around some corners. If you have an idea, let it go.
>>> Minimal reproducer:
>>>
>>> mkdir -p /tmp/ext4_crash/mnt
>>> EXT4_CRASH_IMG="/tmp/ext4_crash/disk.img"
>>> rm -f $EXT4_CRASH_IMG
>>> truncate $EXT4_CRASH_IMG --size 25MiB
>>> EXT4_CRASH_DEV=$(losetup --find --nooverlap --direct-io=on --show
>>> $EXT4_CRASH_IMG)
>>> mkfs.ext4 -E nodiscard,lazy_itable_init=0,lazy_journal_init=0 $EXT4_CRASH_DEV
>>> mount $EXT4_CRASH_DEV /tmp/ext4_crash/mnt
>>> truncate $EXT4_CRASH_IMG --size 3GiB
>>> losetup -c $EXT4_CRASH_DEV
>>> resize2fs $EXT4_CRASH_DEV
>>>
>> Hi Alex,
>>
>> This replicator didn't replicate the issue in my VM, so I took a deeper
>> look. The reproduction of the problem requires the following:
> That's weird. Have just tried once again and it reproduces the issue:
>
> root@ubuntu:/home/ubuntu# mkdir -p /tmp/ext4_crash/mnt
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
> mke2fs 1.47.0 (5-Feb-2023)
> Creating filesystem with 6400 4k blocks and 6400 inodes
>
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (1024 blocks): done
> Writing superblocks and filesystem accounting information: done
>
> resize2fs 1.47.0 (5-Feb-2023)
> Filesystem at /dev/loop4 is mounted on /tmp/ext4_crash/mnt; on-line
> resizing required
> old_desc_blocks = 1, new_desc_blocks = 1
I can see why, on my side I mkfsed a 25M sized disk, and the ext4
block size is 1024 by default, whereas on your side it's 4096.
I set the block size to 4096 and it also reproduced the issue.

Thanks for your feedback!


Cheers,
Baokun


