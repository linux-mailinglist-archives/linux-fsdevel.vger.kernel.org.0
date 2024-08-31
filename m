Return-Path: <linux-fsdevel+bounces-28100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3089E966FAA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 08:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612311C21AF0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 06:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B6915381C;
	Sat, 31 Aug 2024 06:11:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490E14E2CB;
	Sat, 31 Aug 2024 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725084679; cv=none; b=m0MR1+WK4jdAE2HLtGUfou72oZpGQLFGNAQoVLOEERFAxFp9+tLHLufLbohFwNoAqhbyt7UH0oIq+aGS8ksOq7o8h7j+Jt58ITS4Nzl/QVNdcv7VTmZ7Y5SBmSMAn+mCo2eji/sAqo6xc5V0orZHwAAQtaZ+J+T0JDskp7CmB/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725084679; c=relaxed/simple;
	bh=NtpvYfmopz5JdH2cK1r0qoz0Tg4YE8vwrc+W2d0/49Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F6X5Za43gCv9mscAR7nwUDEpBPEiZPUYf+IXzY82NMdLb68WTCMNkr5tyQRYGC+qx06hEIfXds4VGWYU7hL3IC7AxbYwQ1+BBTrKntfg5u/XNuMD7nWj8xfn92Mqrq2UK+P6xWNMomQ3sCkU5VrweIyLR0pxt3URUNZVjdHolcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wwl525dJQz4f3jZQ;
	Sat, 31 Aug 2024 14:11:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D7C9D1A07B6;
	Sat, 31 Aug 2024 14:11:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgBXzIL8s9Jm9wbYDA--.52424S3;
	Sat, 31 Aug 2024 14:11:10 +0800 (CST)
Subject: Re: [PATCH] buffer: Associate the meta bio with blkg from buffer page
To: Tejun Heo <tj@kernel.org>, Haifeng Xu <haifeng.xu@shopee.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tytso@mit.edu,
 yi.zhang@huaweicloud.com, yukuai1@huaweicloud.com,
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240828033224.146584-1-haifeng.xu@shopee.com>
 <ZtIfgc1CcG9XOu0-@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9cae20f9-aa6a-77da-8978-b4cfb7b0cb73@huaweicloud.com>
Date: Sat, 31 Aug 2024 14:11:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZtIfgc1CcG9XOu0-@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXzIL8s9Jm9wbYDA--.52424S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4UWw18KrW7tF17GFyUJrb_yoW8Zr1fpF
	Z5KFW7AF4DJay7CF12va4avFyFvFs7Xw45CFWUJw1avFW5Gw1Ygry7Z3y5uF4UAF9rWr1S
	vr4UKFWxuF1jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Tejun!

ÔÚ 2024/08/31 3:37, Tejun Heo Ð´µÀ:
> Hello, Haifeng.
> 
> On Wed, Aug 28, 2024 at 11:32:24AM +0800, Haifeng Xu wrote:
> ...
>> The filesystem is ext4(ordered). The meta data can be written out by
>> writeback, but if there are too many dirty pages, we had to do
>> checkpoint to write out the meta data in current thread context.
>>
>> In this case, the blkg of thread1 has set io.max, so the j_checkpoint_mutex
>> can't be released and many threads must wait for it. However, the blkg from
>> buffer page didn' set any io policy. Therefore, for the meta buffer head,
>> we can associate the bio with blkg from the buffer page instead of current
>> thread context.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>   fs/buffer.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/fs/buffer.c b/fs/buffer.c
>> index e55ad471c530..a7889f258d0d 100644
>> --- a/fs/buffer.c
>> +++ b/fs/buffer.c
>> @@ -2819,6 +2819,17 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
>>   	if (wbc) {
>>   		wbc_init_bio(wbc, bio);
>>   		wbc_account_cgroup_owner(wbc, bh->b_page, bh->b_size);
>> +	} else if (buffer_meta(bh)) {
>> +		struct folio *folio;
>> +		struct cgroup_subsys_state *memcg_css, *blkcg_css;
>> +
>> +		folio = page_folio(bh->b_page);
>> +		memcg_css = mem_cgroup_css_from_folio(folio);
>> +		if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
>> +		    cgroup_subsys_on_dfl(io_cgrp_subsys)) {
>> +			blkcg_css = cgroup_e_css(memcg_css->cgroup, &io_cgrp_subsys);
>> +			bio_associate_blkg_from_css(bio, blkcg_css);
> 
> I think the right way to do it is marking the bio with REQ_META and
> implement forced charging in blk-throtl similar to blk-iocost.

This is the exact thing I did in the code I attached in the other
thread, do you take a look?

https://lore.kernel.org/all/97fc38e6-a226-5e22-efc2-4405beb6d75b@huaweicloud.com/

Thanks,
Kuai
> 
> Thanks.
> 


