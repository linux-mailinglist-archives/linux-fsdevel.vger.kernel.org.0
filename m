Return-Path: <linux-fsdevel+bounces-17380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE808AC60F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 09:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DE11F21321
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 07:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A59553E02;
	Mon, 22 Apr 2024 07:53:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393A537E3;
	Mon, 22 Apr 2024 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772404; cv=none; b=sUDfDUK2WeNi0y6gCoa/C6GUAwD1tu8HhNDzmLPrVXjRbWPBMpO6Xcf1JWD2WvfTlcf9l8isVfFFT1sXxHmEUP56h+0BAwo5r/tYB05FoGzc4QY8n2GgFc5Oltl8s9jRbeK/BQa8i4/Wq/W6xwfEwOlSXYOe76QXRrtLeRMXWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772404; c=relaxed/simple;
	bh=9ERXhCIJypAi+WymLqmCJZ5+j0H9jGVmRhExosMBV88=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YKsitvbsFlHcRFtMLtKwTgQo07MBXxnS38O8MXXf/w2NbqIppA0BQGJ+a953t7MktU4PzikwhoIzYu6220+Csjgd0CI0QVVbuZDSp7lVLttbuNTmeZxnZB20Yizl6VoApWupys/LToqrCrri1BumpVsKfE/LqwS1Cp+SFLWTqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNHYM2blrz4f3lWH;
	Mon, 22 Apr 2024 15:53:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 763921A0568;
	Mon, 22 Apr 2024 15:53:20 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgA3kfRRFyZmPFqLKw--.43190S2;
	Mon, 22 Apr 2024 15:53:20 +0800 (CST)
Subject: Re: [ATCH v3 0/4] Improve visibility of writeback
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
 bfoster@redhat.com, tj@kernel.org
Cc: dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240422160539.3340-1-shikemeng@huaweicloud.com>
Message-ID: <75341abe-8ab6-a712-2b42-66897d847e57@huaweicloud.com>
Date: Mon, 22 Apr 2024 15:52:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240422160539.3340-1-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgA3kfRRFyZmPFqLKw--.43190S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyrGF4UXFW8uw17tr1rtFb_yoWrJr1UpF
	Z3Aw13Kw1UZr9rArn3Ca42qr15t3y0qa47Xr9rZrW2vwn0grn8tF95W34UAr15Ar93Aryx
	AFsxZry8Gr1q9F7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAF
	wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 4/23/2024 12:05 AM, Kemeng Shi wrote:
Forget to fix a build warning, please ignore this series. Sorry for the
noise.
> v2->v3:
> -Drop patches to protect non-exist race and to define GDTC_INIT_NO_WB to
> null.
> -Add wb_tryget to wb from which we collect stats to bdi stats.
> -Create wb_stats when CONFIG_CGROUP_WRITEBACK is no enabled.
> -Add a blank line between two wb stats in wb_stats.
> 
> v1->v2:
> -Send cleanup to wq_monitor.py separately.
> -Add patch to avoid use after free of bdi.
> -Rename wb_calc_cg_thresh to cgwb_calc_thresh as Tejun suggested.
> -Use rcu walk to avoid use after free.
> -Add debug output to each related patches.
> 
> This series tries to improve visilibity of writeback. Patch 1 make
> /sys/kernel/debug/bdi/xxx/stats show writeback info of whole bdi
> instead of only writeback info in root cgroup. Patch 2 add a new
> debug file /sys/kernel/debug/bdi/xxx/wb_stats to show per wb writeback
> info. Patch 3 add wb_monitor.py to monitor basic writeback info
> of running system, more info could be added on demand. Patch 4
> is a random cleanup. More details can be found in respective
> patches. Thanks!
> 
> Following domain hierarchy is tested:
>                 global domain (320G)
>                 /                 \
>         cgroup domain1(10G)     cgroup domain2(10G)
>                 |                 |
> bdi            wb1               wb2
> 
> /* all writeback info of bdi is successfully collected */
> cat stats
> BdiWriteback:             4704 kB
> BdiReclaimable:        1294496 kB
> BdiDirtyThresh:      204208088 kB
> DirtyThresh:         195259944 kB
> BackgroundThresh:     32503588 kB
> BdiDirtied:           48519296 kB
> BdiWritten:           47225696 kB
> BdiWriteBandwidth:     1173892 kBps
> b_dirty:                     1
> b_io:                        0
> b_more_io:                   1
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> 
> /* per wb writeback info of bdi is collected */
> cat /sys/kernel/debug/bdi/252:16/wb_stats
> WbCgIno:                    1
> WbWriteback:                0 kB
> WbReclaimable:              0 kB
> WbDirtyThresh:              0 kB
> WbDirtied:                  0 kB
> WbWritten:                  0 kB
> WbWriteBandwidth:      102400 kBps
> b_dirty:                    0
> b_io:                       0
> b_more_io:                  0
> b_dirty_time:               0
> state:                      1
> 
> WbCgIno:                 4208
> WbWriteback:            59808 kB
> WbReclaimable:         676480 kB
> WbDirtyThresh:        6004624 kB
> WbDirtied:           23348192 kB
> WbWritten:           22614592 kB
> WbWriteBandwidth:      593204 kBps
> b_dirty:                    1
> b_io:                       1
> b_more_io:                  0
> b_dirty_time:               0
> state:                      7
> 
> WbCgIno:                 4249
> WbWriteback:           144256 kB
> WbReclaimable:         432096 kB
> WbDirtyThresh:        6004344 kB
> WbDirtied:           25727744 kB
> WbWritten:           25154752 kB
> WbWriteBandwidth:      577904 kBps
> b_dirty:                    0
> b_io:                       1
> b_more_io:                  0
> b_dirty_time:               0
> state:                      7
> 
> The wb_monitor.py script output is as following:
> ./wb_monitor.py 252:16 -c
>                   writeback  reclaimable   dirtied   written    avg_bw
> 252:16_1                  0            0         0         0    102400
> 252:16_4284             672       820064   9230368   8410304    685612
> 252:16_4325             896       819840  10491264   9671648    652348
> 252:16                 1568      1639904  19721632  18081952   1440360
> 
>                   writeback  reclaimable   dirtied   written    avg_bw
> 252:16_1                  0            0         0         0    102400
> 252:16_4284             672       820064   9230368   8410304    685612
> 252:16_4325             896       819840  10491264   9671648    652348
> 252:16                 1568      1639904  19721632  18081952   1440360
> ...
> 
> Kemeng Shi (4):
>   writeback: collect stats of all wb of bdi in bdi_debug_stats_show
>   writeback: support retrieving per group debug writeback stats of bdi
>   writeback: add wb_monitor.py script to monitor writeback info on bdi
>   writeback: rename nr_reclaimable to nr_dirty in balance_dirty_pages
> 
>  include/linux/writeback.h     |   1 +
>  mm/backing-dev.c              | 174 +++++++++++++++++++++++++++++-----
>  mm/page-writeback.c           |  27 +++++-
>  tools/writeback/wb_monitor.py | 172 +++++++++++++++++++++++++++++++++
>  4 files changed, 345 insertions(+), 29 deletions(-)
>  create mode 100644 tools/writeback/wb_monitor.py
> 


