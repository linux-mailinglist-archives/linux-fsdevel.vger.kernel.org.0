Return-Path: <linux-fsdevel+bounces-27566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D0E96269B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6312843A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938DD17623C;
	Wed, 28 Aug 2024 12:11:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6941741F8;
	Wed, 28 Aug 2024 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847107; cv=none; b=dAajmPFkYDwJtyLteotuJ5Mj8ks5n0TYSbNt1fW2EoZyJGi5py9PK6bw7+w56vqqewp9X5RPpqOPNClBG/0tmXbSGDwT/sNzSwd0mZa5WR9uwgB5DcutTIbJtXAHI5GAUu5/kCRBOA4BvgHcuNn7HoFNbFM/veFiHp8rNtJ7lQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847107; c=relaxed/simple;
	bh=L96hpiUj9zz6eO2waJt6dvD456qimUKMeemG2ho+jRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFW8xO9T2by1qwdXyC/fFL/XYQN6S+7AVvW1zKvxPDXv04oz43wsythmcNw0bYxcvkmKI76J4FtrYIp2CZJ8EiX2pUmtR5JmMTjZIYX++Gk8XhLpuMWBtT7I2SuSxV3YznhA5Mgr/qb60nh0ATGOtCCgRA7RyFFzyjr4gy0izv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wv3DG4lF8z4f3nT8;
	Wed, 28 Aug 2024 20:11:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 22FE81A018D;
	Wed, 28 Aug 2024 20:11:42 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4X7E89mFlHTCw--.41618S3;
	Wed, 28 Aug 2024 20:11:41 +0800 (CST)
Message-ID: <89b6b6ae-f805-43be-86ca-d3fb06ad8fec@huaweicloud.com>
Date: Wed, 28 Aug 2024 20:11:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module
 exits
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev, jlayton@kernel.org, hsiangkao@linux.alibaba.com,
 jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
 brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 stable@kernel.org, Baokun Li <libaokun@huaweicloud.com>
References: <20240826113404.3214786-1-libaokun@huaweicloud.com>
 <952423.1724841455@warthog.procyon.org.uk>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <952423.1724841455@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHr4X7E89mFlHTCw--.41618S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry7Kw4xZr1xGFykXFy5Jwb_yoW8Ww4rpa
	4ku34xCr18WryUJF4fJw1jvr4UZF4UGF1UJ3s7Gr1UJ3W7Aw18X3WF9F45AF9FkF1UAF45
	t3WUtr1vyr1UZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUOv38UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAJBWbO4BkSYgABsu

Hi David,

On 2024/8/28 18:37, David Howells wrote:
> libaokun@huaweicloud.com wrote:
>
>> In netfs_init() or fscache_proc_init(), we create dentry under 'fs/netfs',
>> but in netfs_exit(), we only delete the proc entry of 'fs/netfs' without
>> deleting its subtree. This triggers the following WARNING:
>>
>> ==================================================================
>> remove_proc_entry: removing non-empty directory 'fs/netfs', leaking at least 'requests'
>> WARNING: CPU: 4 PID: 566 at fs/proc/generic.c:717 remove_proc_entry+0x160/0x1c0
>> Modules linked in: netfs(-)
>> CPU: 4 UID: 0 PID: 566 Comm: rmmod Not tainted 6.11.0-rc3 #860
>> RIP: 0010:remove_proc_entry+0x160/0x1c0
>> Call Trace:
>>   <TASK>
>>   netfs_exit+0x12/0x620 [netfs]
>>   __do_sys_delete_module.isra.0+0x14c/0x2e0
>>   do_syscall_64+0x4b/0x110
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> ==================================================================
>>
>> Therefore use remove_proc_subtree instead() of remove_proc_entry() to
>> fix the above problem.
>>
>> Fixes: 7eb5b3e3a0a5 ("netfs, fscache: Move /proc/fs/fscache to /proc/fs/netfs and put in a symlink")
>> Cc: stable@kernel.org
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Should remove_proc_entry() just remove the entire subtree anyway?
Yeah, in general, when we remove a proc entry, we don't care if it has
subtrees. But I'm not sure if there are certain scenarios where entries
must be removed in a certain order .
>
> But you can add:
>
> 	Acked-by: David Howells <dhowells@redhat.com>
>
> David

Thanks for your ack!

-- 
With Best Regards,
Baokun Li


