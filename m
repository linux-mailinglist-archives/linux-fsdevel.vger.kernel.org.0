Return-Path: <linux-fsdevel+bounces-55495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FDBB0AE0C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 06:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7F53A67CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 04:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6361FBEA2;
	Sat, 19 Jul 2025 04:46:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65212E7E;
	Sat, 19 Jul 2025 04:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752900399; cv=none; b=Q8L01UFGOsRJ3mKSvXYAA5OJUyi9WUNKkj5rUZ7lXQAx7v6zJcY4oHNB9Qwh06amxy7YWUFg1Yf8HS/QNtb6esRZ/HGVi0f3Ve/uZF0eMgaI+GfICy+xL3+HzopC/U8Uy3cRuEmiBLjJIv0u8d8fu2RJCRP/RO0NWjWMCOIfbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752900399; c=relaxed/simple;
	bh=EzYDRq5wTijNe9MYrXSJ6oM7/9aTk1mjfTUUpsIVSQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HbilZboHXus8OXprMNOzz7L89hA3a9JoW56R8JiK1jTk27ajjaeQTG7YufytUSocbVXcEaXYwpi/W3CZuXUVOdgjyhevdvYHWaQWpJzc8clVl/ljAX4jGnwqymWwlvAH2znbsdR6+pG75a+ZOfABcYBmCH0Ww8VhYZTC7Fq8OIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bkYvf0g0dz13MZG;
	Sat, 19 Jul 2025 12:43:42 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 989E5180B57;
	Sat, 19 Jul 2025 12:46:33 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Jul 2025 12:46:32 +0800
Message-ID: <3bec1e49-e833-4e51-8bf5-3fa7f3defa86@huawei.com>
Date: Sat, 19 Jul 2025 12:46:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Add additional checks for block devices during mount
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <jack@suse.com>, <brauner@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai3@huawei.com>, <yangerkun@huawei.com>
References: <20250719024403.3452285-1-wozizhi@huawei.com>
 <20250719041709.GI2580412@ZenIV>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <20250719041709.GI2580412@ZenIV>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2025/7/19 12:17, Al Viro 写道:
> On Sat, Jul 19, 2025 at 10:44:03AM +0800, Zizhi Wo wrote:
> 
>> mkfs.ext4 -F /dev/sdb
>> mount /dev/sdb /mnt
>> mknod /dev/test b 8 16    # [sdb 8:16]
>> echo 1 > /sys/block/sdb/device/delete
>> mount /dev/test /mnt1    # -> mount success
>>
>> Therefore, it is necessary to add an extra check. Solve this problem by
>> checking disk_live() in super_s_dev_test().
> 
> That smells like a wrong approach...  You are counting upon the failure
> of setup_bdev_super() after the thing is forced on the "no reuse" path,
> and that's too convoluted and brittle...
> 

Since this problem can only occur in the superblock reuse scenario, and
the .test function used in sget_fc() for bdev filesystems is
super_s_dev_test(), I considered adding an additional condition check
within that function.

I'm wondering if there's a better way to handle this...

Thanks,
Zizhi Wo

