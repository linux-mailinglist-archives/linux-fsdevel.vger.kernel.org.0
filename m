Return-Path: <linux-fsdevel+bounces-14954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E17885559
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 09:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730091F21D53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736C6995F;
	Thu, 21 Mar 2024 08:13:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2AB56450;
	Thu, 21 Mar 2024 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008782; cv=none; b=Y8VONTSAb9ixhXc5Ze9jqV1vN9wvTFOoSbogGvYVh6i1E+U3mCtTJgm3bfPYvxsZ0IXQLdgVTPYzh3roGy1LhUfwChXYLJGGTSp4RvxA4SxNQYvLmXTApOxUCeavYLntLoWUtkDFoJt/vxyaM+tQkpLc12c0E0H+q5fuSDFvP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008782; c=relaxed/simple;
	bh=FkAdzwcMeQLFzLGB1YGZSL1vSZ1on4dbpbSvVflmwwU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uBsYyTGpcuNyuSY0/gCZg+/omIYauz59XzJygTaZxb0Rqf3a/9QQwNGyt8YifH5zKvJ/qj4YJDfjLmvg0y8M7dGpxwhhyZx7hEN7LlJ7bOrsyBJgU4dci6PJQl+TnLwO+4aW3EQGGbTOg+FUipJfW5BWkH1trLF/3RiKPVrONvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V0dVn3NJHz4f3jcr;
	Thu, 21 Mar 2024 16:12:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7E1FB1A0172;
	Thu, 21 Mar 2024 16:12:55 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgCHoQoE7PtlB3B5Hg--.2097S2;
	Thu, 21 Mar 2024 16:12:54 +0800 (CST)
Subject: Re: [PATCH 0/6] Improve visibility of writeback
To: Jan Kara <jack@suse.cz>
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, bfoster@redhat.com, dsterba@suse.com,
 mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320172240.7buswiv7zj2m5odg@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <44e3b910-8b52-5583-f8a9-37105bf5e5b6@huaweicloud.com>
Date: Thu, 21 Mar 2024 16:12:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240320172240.7buswiv7zj2m5odg@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCHoQoE7PtlB3B5Hg--.2097S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1xGry7CF47XF4rWF15urg_yoW5tF4Dpa
	95Cw1Utr48Z34xArsakF1aqryYy3yUXFy3Xr92vFWxCrn0gr15trWvg3yFy3W5ZrZxAFy3
	JFsxZryvqr4vvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/21/2024 1:22 AM, Jan Kara wrote:
> On Wed 20-03-24 19:02:16, Kemeng Shi wrote:
>> This series tries to improve visilibity of writeback. Patch 1 make
>> /sys/kernel/debug/bdi/xxx/stats show writeback info of whole bdi
>> instead of only writeback info in root cgroup. Patch 2 add a new
>> debug file /sys/kernel/debug/bdi/xxx/wb_stats to show per wb writeback
>> info. Patch 4 add wb_monitor.py to monitor basic writeback info
>> of running system, more info could be added on demand. Rest patches
>> are some random cleanups. More details can be found in respective
>> patches. Thanks!
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
> 
> So I'm wondering: Are you implementing this just because this looks
> interesting or do you have a real need for the functionality? Why?
Hi Jan, I added debug files to test change in [1] which changes the way how
dirty background threshold of wb is calculated. Without debug files, we could
only monitor writeback to imply that threshold is corrected.
In current patchset, debug info has not included dirty background threshold yet,
I will add it when discution of calculation of dirty background threshold in [1]
is done.
The wb_monitor.py is suggested by Tejun in [2] to improve visibility of writeback.
The script is more convenient than trace to monitor writeback behavior of the running
system.

Thanks

[1] https://lore.kernel.org/lkml/a747dc7d-f24a-08bd-d969-d3fb35e151b7@huaweicloud.com/
[2] https://lore.kernel.org/lkml/ZcUsOb_fyvYr-zZ-@slm.duckdns.org/
> 
> 								Honza
> 


