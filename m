Return-Path: <linux-fsdevel+bounces-15975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1470B896521
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 08:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F1B1C21C58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 06:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49935490C;
	Wed,  3 Apr 2024 06:56:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9C46F067;
	Wed,  3 Apr 2024 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127394; cv=none; b=SY/SbSRxFExtiVdGv/62eUKO6cWQkjWaFjOBiGMKy1+zxSHx37oPNYCtPSuA2OYgeQ8F7+Gx/hSHzykPGSxJjpsNTxkjWuVrIaN2gD9QKtGd8zH4TiTyHXUzlBcNK9W8wsvqBHrjwlQaXgcfhTV833TyTuMQT+yWZoEHLnwtbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127394; c=relaxed/simple;
	bh=M2/HbdCSYKxjX0JQZfhKLCikOiHHQZAP56IhdnhJVfs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JvaeKiISFWB6bmfkA0RUn5ZYADmcC+B7ZqWHqeJAMCZO9J1jmKvQiwBZshqDGG+SlPriW+XAVpy8ouSGLOG2PkdKRWftzr2ZcIINuky+/5BgkudXUTZ0fM7C559MFnUtAe8lHvsTTTv8AcniShug2Sgqu9+SM2CTPrdW0adEaC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V8bBP0z0bz4f3jLY;
	Wed,  3 Apr 2024 14:56:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 821371A0176;
	Wed,  3 Apr 2024 14:56:21 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgA39p2S_QxmsaQcIw--.36319S2;
	Wed, 03 Apr 2024 14:56:20 +0800 (CST)
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
 bfoster@redhat.com, tj@kernel.org, dsterba@suse.com, mjguzik@gmail.com,
 dhowells@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <6d83cf77-a0eb-3ee7-78f2-dae45562a6aa@huaweicloud.com>
Date: Wed, 3 Apr 2024 14:56:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgA39p2S_QxmsaQcIw--.36319S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFW8uryfZr15Kr4kKryrXrb_yoWrtw4kpF
	Z5A3W5tr48Zr1xArnaka4aqryYy3y0qFy3Xr97ZFWIyrn0gF15tFykW3yFyF15Zr9xAry3
	ZrsxZrykKr1vvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/29/2024 3:24 AM, Kent Overstreet wrote:
> On Wed, Mar 27, 2024 at 11:57:45PM +0800, Kemeng Shi wrote:
>> v1->v2:
>> -Send cleanup to wq_monitor.py separately.
>> -Add patch to avoid use after free of bdi.
>> -Rename wb_calc_cg_thresh to cgwb_calc_thresh as Tejun suggested.
>> -Use rcu walk to avoid use after free.
>> -Add debug output to each related patches.
>>
>> This series tries to improve visilibity of writeback. Patch 1 make
>> /sys/kernel/debug/bdi/xxx/stats show writeback info of whole bdi
>> instead of only writeback info in root cgroup. Patch 2 add a new
>> debug file /sys/kernel/debug/bdi/xxx/wb_stats to show per wb writeback
>> info. Patch 4 add wb_monitor.py to monitor basic writeback info
>> of running system, more info could be added on demand. Rest patches
>> are some random cleanups. More details can be found in respective
>> patches. Thanks!
>> This series is on top of patchset [1].
>>
>> [1] https://lore.kernel.org/lkml/20240123183332.876854-1-shikemeng@huaweicloud.com/T/#mc6455784a63d0f8aa1a2f5aff325abcdf9336b76
> 
> Not bad
> 
Hi Kent,
> I've been trying to improve our ability to debug latency issues - stalls
> of all sorts. While you're looking at all this code, do you think you
> could find some places to collect useful latency numbers?
I would like to do it to collect more useful info for writeback.
> 
> fs/bcachefs/time_stats.c has some code that's going to be moving out to
> lib/ at some point, after I switch it to MAD; if you could hook that up
> as well to a few points we could see at a glance if there are stalls
> happening in the writeback path.
I see that Tejun recommend to use bpf. I don't know much about bpf and
new approach in time_stats.c. For me personly, I think that it's better
to use the new approach after the work of moving code to lib/ is merged.
Then I would like to submit a patchset to discuss of using it in writeback.
Would this make sense to you. Look forward to your reply!

Thanks,
Kemeng
> 
>>
>> Following domain hierarchy is tested:
>>                 global domain (320G)
>>                 /                 \
>>         cgroup domain1(10G)     cgroup domain2(10G)
>>                 |                 |
>> bdi            wb1               wb2
>>
>> /* all writeback info of bdi is successfully collected */
>> # cat /sys/kernel/debug/bdi/252:16/stats:
>> BdiWriteback:              448 kB
>> BdiReclaimable:        1303904 kB
>> BdiDirtyThresh:      189914124 kB
>> DirtyThresh:         195337564 kB
>> BackgroundThresh:     32516508 kB
>> BdiDirtied:            3591392 kB
>> BdiWritten:            2287488 kB
>> BdiWriteBandwidth:      322248 kBps
>> b_dirty:                     0
>> b_io:                        0
>> b_more_io:                   2
>> b_dirty_time:                0
>> bdi_list:                    1
>> state:                       1
>>
>> /* per wb writeback info is collected */
>> # cat /sys/kernel/debug/bdi/252:16/wb_stats:
>> cat wb_stats
>> WbCgIno:                    1
>> WbWriteback:                0 kB
>> WbReclaimable:              0 kB
>> WbDirtyThresh:              0 kB
>> WbDirtied:                  0 kB
>> WbWritten:                  0 kB
>> WbWriteBandwidth:      102400 kBps
>> b_dirty:                    0
>> b_io:                       0
>> b_more_io:                  0
>> b_dirty_time:               0
>> state:                      1
>> WbCgIno:                 4284
>> WbWriteback:              448 kB
>> WbReclaimable:         818944 kB
>> WbDirtyThresh:        3096524 kB
>> WbDirtied:            2266880 kB
>> WbWritten:            1447936 kB
>> WbWriteBandwidth:      214036 kBps
>> b_dirty:                    0
>> b_io:                       0
>> b_more_io:                  1
>> b_dirty_time:               0
>> state:                      5
>> WbCgIno:                 4325
>> WbWriteback:              224 kB
>> WbReclaimable:         819392 kB
>> WbDirtyThresh:        2920088 kB
>> WbDirtied:            2551808 kB
>> WbWritten:            1732416 kB
>> WbWriteBandwidth:      201832 kBps
>> b_dirty:                    0
>> b_io:                       0
>> b_more_io:                  1
>> b_dirty_time:               0
>> state:                      5
>>
>> /* monitor writeback info */
>> # ./wb_monitor.py 252:16 -c
>>                   writeback  reclaimable   dirtied   written    avg_bw
>> 252:16_1                  0            0         0         0    102400
>> 252:16_4284             672       820064   9230368   8410304    685612
>> 252:16_4325             896       819840  10491264   9671648    652348
>> 252:16                 1568      1639904  19721632  18081952   1440360
>>
>>
>>                   writeback  reclaimable   dirtied   written    avg_bw
>> 252:16_1                  0            0         0         0    102400
>> 252:16_4284             672       820064   9230368   8410304    685612
>> 252:16_4325             896       819840  10491264   9671648    652348
>> 252:16                 1568      1639904  19721632  18081952   1440360
>> ...
>>
>> Kemeng Shi (6):
>>   writeback: protect race between bdi release and bdi_debug_stats_show
>>   writeback: collect stats of all wb of bdi in bdi_debug_stats_show
>>   writeback: support retrieving per group debug writeback stats of bdi
>>   writeback: add wb_monitor.py script to monitor writeback info on bdi
>>   writeback: rename nr_reclaimable to nr_dirty in balance_dirty_pages
>>   writeback: define GDTC_INIT_NO_WB to null
>>
>>  include/linux/writeback.h     |   1 +
>>  mm/backing-dev.c              | 203 ++++++++++++++++++++++++++++++----
>>  mm/page-writeback.c           |  31 ++++--
>>  tools/writeback/wb_monitor.py | 172 ++++++++++++++++++++++++++++
>>  4 files changed, 378 insertions(+), 29 deletions(-)
>>  create mode 100644 tools/writeback/wb_monitor.py
>>
>> -- 
>> 2.30.0
>>
> 


