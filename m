Return-Path: <linux-fsdevel+bounces-27567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A99C9626A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08A7284D01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7CE175548;
	Wed, 28 Aug 2024 12:14:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8D174EEB;
	Wed, 28 Aug 2024 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847241; cv=none; b=lS4cTmf+eGp/cZ8/+Jf2qHAZgaR9nfx0YjS23hDmcmmNQsh5aHqH+xJt+2eykVUR3LWNmlbEyDhCr5vBeBGrVfirQA4CVywQKzwB144JyOAfNtUoZjzOpLpdWJkQH+3UNFKRwq0pvnpVpj2aqcqYDDU0syFTDTiZ8GlYiRZSIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847241; c=relaxed/simple;
	bh=dU187dYOW7qQ9lMNgd+KRfGR8rnmGNvCzNc+RZKg4q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fW5dIlmsuD0V94v7MQVD0YXQBgeEbrrPcMsL9z2Uzt9bdP3a5kngnkThf61GAs68BErijFIcbJgPcAO8PyfEmlpF4FKM0rTtOeYDo8+XxtM68i46enN8HpMKjRzpccOUB9KDyEEXLyikmAx4QR9IFGAtJE1LoDDQ3Zz97IAJVhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wv3Gz0mn5z4f3lXB;
	Wed, 28 Aug 2024 20:13:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 146F01A166B;
	Wed, 28 Aug 2024 20:13:57 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4WCFM9mYnbTCw--.37858S3;
	Wed, 28 Aug 2024 20:13:55 +0800 (CST)
Message-ID: <b003bb7c-7af0-484f-a6d9-da15b09e3a96@huaweicloud.com>
Date: Wed, 28 Aug 2024 20:13:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module
 exits
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev,
 jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>, stable@kernel.org,
 Gao Xiang <xiang@kernel.org>, Baokun Li <libaokun@huaweicloud.com>
References: <20240826113404.3214786-1-libaokun@huaweicloud.com>
 <20240828-fuhren-platzen-fc6210881103@brauner>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240828-fuhren-platzen-fc6210881103@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHL4WCFM9mYnbTCw--.37858S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urWDGry8JFW7Zw1rGFykXwb_yoW8uF1rpa
	4kZ34fGr1DJryUJa1ftw4jqF4UZrs8JF13Kr1xGr18Z3WYyr1ktF109FW5uF9FkryFkw4j
	q3WUt3sYkr1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUFjjgDUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAJBWbO4BkSpQAAso

On 2024/8/28 19:22, Christian Brauner wrote:
> On Mon, 26 Aug 2024 19:34:04 +0800, libaokun@huaweicloud.com wrote:
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

Hi Christian,


Thank you for applying this patch!

I just realized that the parentheses are in the wrong place here,
could you please help me correct them?
>> Therefore use remove_proc_subtree instead() of remove_proc_entry() to
^^ remove_proc_subtree() instead

Regards, Baokun

> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
>
> [1/1] netfs: Delete subtree of 'fs/netfs' when netfs module exits
>        https://git.kernel.org/vfs/vfs/c/0aef59b3eabb


