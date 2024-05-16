Return-Path: <linux-fsdevel+bounces-19571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3434F8C72C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 10:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E88281EC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 08:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BE212EBFE;
	Thu, 16 May 2024 08:27:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFE76C76;
	Thu, 16 May 2024 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848055; cv=none; b=k6VBcxmthZa6n8HHxFU/5joIrZwcb04pXZ0vsSaB69CYP9m8rdLlxTBKIgEu5KpgIkEoG5NifCnrE0FbWimNC/1B8jF8VvhL4LpH9OmSvI1wtSvlmaFD2odvFqbu6lqVPDLh77i+ht1wREgACaM+U4lrz1Wq4VH1dELX7yKuTa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848055; c=relaxed/simple;
	bh=Fa3tCa+nHTX5GaUek5DQjejgVE5UyfDOFzTBnbAZZgQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WYd1o5mteRp6hPuHUxqGHvKtTvmibBGabvja/ZMUscaNboOa1GEBO/2wazSZFvdK6MsI6FpFBNE7CKv6YnGzuJRD3OKIXda6L4nsTQXfMNIpDOXLye0lAoB4570oyWx/+c71BR/HEAlKygPT7WnFcj1W9WlrNRMiybkKZ/vJd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vg39h3dg3z4f3jYN;
	Thu, 16 May 2024 16:27:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 381E41A10BC;
	Thu, 16 May 2024 16:27:29 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAnmAttw0VmcIZ6NA--.39916S3;
	Thu, 16 May 2024 16:27:27 +0800 (CST)
Subject: Re: [PATCH] ext4/jbd2: drop jbd2_transaction_committed()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240513072119.2335346-1-yi.zhang@huaweicloud.com>
 <20240515002513.yaglghza4i4ldmr5@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <f0eb115d-dd10-e156-9aed-65b7f479f008@huaweicloud.com>
Date: Thu, 16 May 2024 16:27:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240515002513.yaglghza4i4ldmr5@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnmAttw0VmcIZ6NA--.39916S3
X-Coremail-Antispam: 1UD129KBjvJXoWxArWxCw4fAr1xXry8Jw47Arb_yoW5Aw43pF
	W0k3W2gr4kZ34I9r40qa17ZFW0yws5Ja48XrsxXwsaga1UG3s7KrW7tFyavFyDtFs5Ww4U
	XF4S9rn7Kryj937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/15 8:25, Jan Kara wrote:
> On Mon 13-05-24 15:21:19, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> jbd2_transaction_committed() is used to check whether a transaction with
>> the given tid has already committed, it hold j_state_lock in read mode
>> and check the tid of current running transaction and committing
>> transaction, but holding the j_state_lock is expensive.
>>
>> We have already stored the sequence number of the most recently
>> committed transaction in journal t->j_commit_sequence, we could do this
>> check by comparing it with the given tid instead. If the given tid isn't
>> smaller than j_commit_sequence, we can ensure that the given transaction
>> has been committed. That way we could drop the expensive lock and
>> achieve about 10% ~ 20% performance gains in concurrent DIOs on may
>> virtual machine with 100G ramdisk.
>>
>> fio -filename=/mnt/foo -direct=1 -iodepth=10 -rw=$rw -ioengine=libaio \
>>     -bs=4k -size=10G -numjobs=10 -runtime=60 -overwrite=1 -name=test \
>>     -group_reporting
>>
>> Before:
>>   overwrite       IOPS=88.2k, BW=344MiB/s
>>   read            IOPS=95.7k, BW=374MiB/s
>>   rand overwrite  IOPS=98.7k, BW=386MiB/s
>>   randread        IOPS=102k, BW=397MiB/s
>>
>> After:
>>   verwrite:       IOPS=105k, BW=410MiB/s
>>   read:           IOPS=112k, BW=436MiB/s
>>   rand overwrite: IOPS=104k, BW=404MiB/s
>>   randread:       IOPS=111k, BW=432MiB/s
>>
>> CC: Dave Chinner <david@fromorbit.com>
>> Suggested-by: Dave Chinner <david@fromorbit.com>
>> Link: https://lore.kernel.org/linux-ext4/493ab4c5-505c-a351-eefa-7d2677cdf800@huaweicloud.com/T/#m6a14df5d085527a188c5a151191e87a3252dc4e2
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> I agree this is workable solution and the performance benefits are nice. But
> I have some comments regarding the implementation:
> 
>> @@ -3199,8 +3199,8 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>>  	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
>>  
>>  	if (journal) {
>> -		if (jbd2_transaction_committed(journal,
>> -			EXT4_I(inode)->i_datasync_tid))
>> +		if (tid_geq(journal->j_commit_sequence,
>> +			    EXT4_I(inode)->i_datasync_tid))
> 
> Please leave the helper jbd2_transaction_committed(), just make the
> implementation more efficient. 

Sure.

> Also accessing j_commit_sequence without any
> lock is theoretically problematic wrt compiler optimization. You should have
> READ_ONCE() there and the places modifying j_commit_sequence need to use
> WRITE_ONCE().
> 

Thanks for pointing this out, but I'm not sure if we have to need READ_ONCE()
here. IIUC, if we add READ_ONCE(), we could make sure to get the latest
j_commit_sequence, if not, there is a window (it might becomes larger) that
we could get the old value and jbd2_transaction_committed() could return false
even if the given transaction was just committed, but I think the window is
always there, so it looks like it is not a big problem, is that right?

Thanks,
Yi.


