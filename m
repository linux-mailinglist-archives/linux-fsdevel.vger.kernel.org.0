Return-Path: <linux-fsdevel+bounces-18868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B04198BD8D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 03:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE1E1F233A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 01:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932111C3D;
	Tue,  7 May 2024 01:16:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4915A4;
	Tue,  7 May 2024 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715044613; cv=none; b=C5BU8oe8nfXnlYGk9BGgPRZeUfO+xsetWdcj9P4ctNPbQUrwMCa1SJksPHRGLDmssfSlZukd5suE5zfX/XaCQG7cn5OjlJq0MPGdGMBqkFXELA1BdZKSBR03WJpMP8dNxZo8xqGfb8qnoGGIWysppk/hs22st1mlbDhewDp5ecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715044613; c=relaxed/simple;
	bh=99cYruSyZU2CFPO8xUaVBG1Rqh5I2RFwQOvbkm7MFo8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TCfRhqxJrH7R7Z2lx133aOXxpR73cGBg/gW0vlK5OaJdNweeLzAyoVoqaKcwLly0ip6kvfvSH+oKOy7p043z6bS5DLxZ5sgh5vEU3MoMjlvr8LFImGc2Pa5dMDnENKZEKJadUvODaIA32QF87E5Fi+eTXkZbtJgALxvFSfx4FBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VYL2l4b4xz4f3mJ1;
	Tue,  7 May 2024 09:16:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6C0DF1A08D9;
	Tue,  7 May 2024 09:16:41 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgDXGRP3gDlmE2ndLw--.2612S2;
	Tue, 07 May 2024 09:16:41 +0800 (CST)
Subject: Re: [PATCH v2 2/4] mm: correct calculation of wb's bg_thresh in
 cgroup domain
To: Jan Kara <jack@suse.cz>
Cc: willy@infradead.org, akpm@linux-foundation.org, tj@kernel.org,
 hcochran@kernelspring.com, axboe@kernel.dk, mszeredi@redhat.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240425131724.36778-1-shikemeng@huaweicloud.com>
 <20240425131724.36778-3-shikemeng@huaweicloud.com>
 <20240503093056.6povgn2shvqzpedj@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <12bf104e-aeac-67a5-6e5a-bc7bdbfe4d79@huaweicloud.com>
Date: Tue, 7 May 2024 09:16:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240503093056.6povgn2shvqzpedj@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDXGRP3gDlmE2ndLw--.2612S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1Uur15CF4ruryrWw4kZwb_yoWrWF17pF
	WkJF12yr48Jr1xCrsIgayqqry8Jw4ftFW7XF9xt347tr13GF18KF17CFs0gFW5AF13GFWf
	ZFsxu3s7Xr1Dt3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/


Hi Jan,
on 5/3/2024 5:30 PM, Jan Kara wrote:
> On Thu 25-04-24 21:17:22, Kemeng Shi wrote:
>> The wb_calc_thresh is supposed to calculate wb's share of bg_thresh in
>> global domain. To calculate wb's share of bg_thresh in cgroup domain,
>> it's more reasonable to use __wb_calc_thresh in which way we calculate
>> dirty_thresh in cgroup domain in balance_dirty_pages().
>>
>> Consider following domain hierarchy:
>>                 global domain (> 20G)
>>                 /                 \
>>         cgroup domain1(10G)     cgroup domain2(10G)
>>                 |                 |
>> bdi            wb1               wb2
>> Assume wb1 and wb2 has the same bandwidth.
>> We have global domain bg_thresh > 2G, cgroup domain bg_thresh 1G.
>> Then we have:
>> wb's thresh in global domain = 2G * (wb bandwidth) / (system bandwidth)
>> = 2G * 1/2 = 1G
>> wb's thresh in cgroup domain = 1G * (wb bandwidth) / (system bandwidth)
>> = 1G * 1/2 = 0.5G
>> At last, wb1 and wb2 will be limited at 0.5G, the system will be limited
>> at 1G which is less than global domain bg_thresh 2G.
> 
> This was a bit hard to understand for me so I'd rephrase it as:
> 
> wb_calc_thresh() is calculating wb's share of bg_thresh in the global
> domain. However in case of cgroup writeback this is not the right thing to
> do. Consider the following domain hierarchy:
> 
>                 global domain (> 20G)
>                 /                 \
>           cgroup1 (10G)     cgroup2 (10G)
>                 |                 |
> bdi            wb1               wb2
> 
> and assume wb1 and wb2 have the same bandwidth and the background threshold
> is set at 10%. The bg_thresh of cgroup1 and cgroup2 is going to be 1G. Now
> because wb_calc_thresh(mdtc->wb, mdtc->bg_thresh) calculates per-wb
> threshold in the global domain as (wb bandwidth) / (domain bandwidth) it
> returns bg_thresh for wb1 as 0.5G although it has nobody to compete against
> in cgroup1.
> 
> Fix the problem by calculating wb's share of bg_thresh in the cgroup
> domain.
Thanks for improving the changelog. As this was merged into -mm and
mm-unstable tree, I'm not sure if a new patch is needed. If there is
anything I should do, please let me konw. Thanks.

> 
>> Test as following:
>> /* make it easier to observe the issue */
>> echo 300000 > /proc/sys/vm/dirty_expire_centisecs
>> echo 100 > /proc/sys/vm/dirty_writeback_centisecs
>>
>> /* run fio in wb1 */
>> cd /sys/fs/cgroup
>> echo "+memory +io" > cgroup.subtree_control
>> mkdir group1
>> cd group1
>> echo 10G > memory.high
>> echo 10G > memory.max
>> echo $$ > cgroup.procs
>> mkfs.ext4 -F /dev/vdb
>> mount /dev/vdb /bdi1/
>> fio -name test -filename=/bdi1/file -size=600M -ioengine=libaio -bs=4K \
>> -iodepth=1 -rw=write -direct=0 --time_based -runtime=600 -invalidate=0
>>
>> /* run fio in wb2 with a new shell */
>> cd /sys/fs/cgroup
>> mkdir group2
>> cd group2
>> echo 10G > memory.high
>> echo 10G > memory.max
>> echo $$ > cgroup.procs
>> mkfs.ext4 -F /dev/vdc
>> mount /dev/vdc /bdi2/
>> fio -name test -filename=/bdi2/file -size=600M -ioengine=libaio -bs=4K \
>> -iodepth=1 -rw=write -direct=0 --time_based -runtime=600 -invalidate=0
>>
>> Before fix, the wrttien pages of wb1 and wb2 reported from
>> toos/writeback/wb_monitor.py keep growing. After fix, rare written pages
>> are accumulated.
>> There is no obvious change in fio result.
>>
>> Fixes: 74d369443325 ("writeback: Fix performance regression in wb_over_bg_thresh()")
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Besides the changelog rephrasing the change looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
>> ---
>>  mm/page-writeback.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>> index 2a3b68aae336..14893b20d38c 100644
>> --- a/mm/page-writeback.c
>> +++ b/mm/page-writeback.c
>> @@ -2137,7 +2137,7 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
>>  		if (mdtc->dirty > mdtc->bg_thresh)
>>  			return true;
>>  
>> -		thresh = wb_calc_thresh(mdtc->wb, mdtc->bg_thresh);
>> +		thresh = __wb_calc_thresh(mdtc, mdtc->bg_thresh);
>>  		if (thresh < 2 * wb_stat_error())
>>  			reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
>>  		else
>> -- 
>> 2.30.0
>>


