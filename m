Return-Path: <linux-fsdevel+bounces-16309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB4089AE15
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 04:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE3D1C2142D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 02:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0F51876;
	Sun,  7 Apr 2024 02:35:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AFC368;
	Sun,  7 Apr 2024 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712457305; cv=none; b=VGj0h5YksmgPc2NJ12STrY4B+lLKzoZg39L1tNFZKMSoGpFOnqUI6Iz4AX4QTJxOTLgo1eoP46zD2nkrscWeyNvb8Qr1ESrmeK/mJGTPdwwWxQF4otGfw+ekxABj4zjy2Jgcbt/mb70vYkeW8IYQz12+P9hZFh6VMiTY6NJlUYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712457305; c=relaxed/simple;
	bh=SWREo/nBZXvgB2zgCoPK4Y5gHANbbzKi4Y3tdR2HHvE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IMDfKuISmluCV+WQXpyL5+Et8GmgipI5X9Z5PjAmcpK0T1vEEexfm3cCDa870k0nO9pYJXOKsNwv+ldVg3ra87hGXb1npVLilgfYI9qbDtJ8dPKTcBL0SVnVF2AcxLJ2dONtCG2FqkY63mcz4zWoG6w0UUhWevWtaLJgAq43MYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBxC21hKCz4f3l8Z;
	Sun,  7 Apr 2024 10:34:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8E0B81A08E9;
	Sun,  7 Apr 2024 10:34:58 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFQBhJm93s1JQ--.14469S3;
	Sun, 07 Apr 2024 10:34:58 +0800 (CST)
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
To: Al Viro <viro@zeniv.linux.org.uk>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240406194206.GC538574@ZenIV> <20240406202947.GD538574@ZenIV>
 <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
 <20240407015149.GG538574@ZenIV>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
Date: Sun, 7 Apr 2024 10:34:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240407015149.GG538574@ZenIV>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFQBhJm93s1JQ--.14469S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw15ZrWrJF4kAr18uFy3Arb_yoW8Cr1kp3
	90gFWYkrWDGr1j93s2vw47Ar1Fyw17Aw18GFyxXryYkrW5Wr9a9rW0yrs8uF1UCrs7WayU
	ZFyjq3s5Gwn8A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/04/07 9:51, Al Viro Ð´µÀ:
> On Sun, Apr 07, 2024 at 09:18:20AM +0800, Yu Kuai wrote:
> 
>> Yes, patch 23-26 already do the work to remove the field block_device
>> and convert to use bdev_file for iomap and buffer_head.
> 
> What for?  I mean, what makes that dummy struct file * any better than
> struct block_device *?  What's the point?
> 
> I agree that keeping an opened struct file for a block device is
> a good idea - certainly better than weird crap used to carry the
> "how had it been opened" along with bdev.  But that does *not*
> mean not keeping ->s_bdev around; we might or might not find that
> convenient, but it's not "struct block_device is Evil(tm), let's
> exorcise".
> 
> Why do we care to do anything to struct buffer_head?  Or to
> struct bio, for that matter...

Other than raw block_device fops, other filesystems can use the opened
bdev_file directly for iomap and buffer_head, and they actually don't
need to reference block_device anymore. The point here is that whether
we want to keep a special handling for block_device fops or not. There
are two proposes now:

- one is from Christian to keep using block_device for block_device
fops, in order to do that, a new flag and some special handling is added
to iomap and buffer_head. See the patch from last version [1].

- one is from this patchset, allocate a *dummy* bdev_file just for iomap
and buffer_head to access bdev and bd_inode.

I personally prefer the later one, that's why there is a new version,
however, what do I know? That will depend on how people think.

[1] 
https://lore.kernel.org/all/20240222124555.2049140-20-yukuai1@huaweicloud.com/
Thanks,
Kuai

> 
> I'm not saying that parts of the patchset do not make sense on
> their own, but I don't understand what the last part is all
> about.
> 
> Al, still going through that series...
> .
> 


