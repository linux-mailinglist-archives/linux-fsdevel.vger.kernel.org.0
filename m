Return-Path: <linux-fsdevel+bounces-17283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF678AA9E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 10:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78C61F22D06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2C14EB5E;
	Fri, 19 Apr 2024 08:14:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB28A55;
	Fri, 19 Apr 2024 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514497; cv=none; b=WkmQdZnLEK+WS02XmTEZzIji2XF293bPSJpspYdt8kH2j+4hbHU0wDjmJPqOXfM7ut0yQa82xTZ1yPwBjzGD7KXYy6wFPb14MKJquzNBhG38r1X+UPwAoiCIo+7u5XViOEulzPKKC7JTstdQCJGdteNuC4EG0Jgjb3rtcToXD5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514497; c=relaxed/simple;
	bh=oFL++jQKoc5OIkNRR7zRzPuCLaMahie017AaPrS2TVk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FWbYXjpwpi2ngY3Dqkz0JO1r20zJ0kAd3+7NBbU+OteB3QdYbn7lYYOkZyMzwpndq8HaEES+KmBYeOarsBIVXckew6WmctaW+NKNaroz09n5DYSjAggja5u7jxUhxb12oFRz6fVsmELAkxAuTOqILM+G0F3dgfJQhuRkRk12tnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VLS9c1Nftz4f3knt;
	Fri, 19 Apr 2024 16:14:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 73C851A016E;
	Fri, 19 Apr 2024 16:14:51 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RH5JyJmdbiGKQ--.20192S3;
	Fri, 19 Apr 2024 16:14:51 +0800 (CST)
Subject: Re: [PATCH v4 6/9] iomap: don't increase i_size if it's not a write
 operation
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240320110548.2200662-1-yi.zhang@huaweicloud.com>
 <20240320110548.2200662-7-yi.zhang@huaweicloud.com>
 <87edb13ms8.fsf@debian-BULLSEYE-live-builder-AMD64>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <4dd51853-1707-8d5f-1286-baa3126c162b@huaweicloud.com>
Date: Fri, 19 Apr 2024 16:14:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87edb13ms8.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAX6RH5JyJmdbiGKQ--.20192S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWxGr17tF43KF4UXr4UCFg_yoW8XrWfpF
	WfW3WIqrs5Kr1xtF9rXr15X3WrZF45Xry3uFyUGrW5AFnxAF4fJFs2grWDZrWUtayDAw1F
	qw4kuFZ8Jry5urJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/4/19 14:07, Chandan Babu R wrote:
> On Wed, Mar 20, 2024 at 07:05:45 PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Increase i_size in iomap_zero_range() and iomap_unshare_iter() is not
>> needed, the caller should handle it. Especially, when truncate partial
>> block, we should not increase i_size beyond the new EOF here. It doesn't
>> affect xfs and gfs2 now because they set the new file size after zero
>> out, it doesn't matter that a transient increase in i_size, but it will
>> affect ext4 because it set file size before truncate. So move the i_size
>> updating logic to iomap_write_iter().
>>
> 
> This patch causes generic/522 to consistently fail when using the following
> fstest configuration,
> 
> TEST_DEV=/dev/loop16
> TEST_LOGDEV=/dev/loop13
> SCRATCH_DEV_POOL="/dev/loop5 /dev/loop6 /dev/loop7 /dev/loop8 /dev/loop9 /dev/loop10 /dev/loop11 /dev/loop12"
> MKFS_OPTIONS='-f -m reflink=1,rmapbt=1, -i sparse=1, -lsize=1g'
> MOUNT_OPTIONS='-o usrquota,grpquota,prjquota'
> TEST_FS_MOUNT_OPTS="$TEST_FS_MOUNT_OPTS -o usrquota,grpquota,prjquota"
> TEST_FS_MOUNT_OPTS="-o logdev=/dev/loop13"
> SCRATCH_LOGDEV=/dev/loop15
> USE_EXTERNAL=yes
> LOGWRITES_DEV=/dev/loop15
> 

Sorry for the regression, I didn't notice this issue last time I ran
this test. It looks like the 004 patch doesn't work for some cases.
I can reproduce it on my machine now, and I'll take a look at this
and fix it soon.

Thanks,
Yi.


