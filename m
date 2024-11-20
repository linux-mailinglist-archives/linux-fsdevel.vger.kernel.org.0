Return-Path: <linux-fsdevel+bounces-35265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6F89D34F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5AB281EAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4ED172BA9;
	Wed, 20 Nov 2024 08:03:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A05336D;
	Wed, 20 Nov 2024 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089805; cv=none; b=rEjQRjtuEAypOTZ25cXYrpOF/f/C1cC09Ugu1Adw9QdcR87N8oUbKhlBnuzsAh2/sMUA9T4Z4G46u7LwgGo+rGkqRO9C0goqbSDva6T1skB5OZKJbDwag7DU5KclhpdxPGYGuc4e4HUnQgIOXpLQE/1PKjHAZ5/cVYSzw2SWutk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089805; c=relaxed/simple;
	bh=nqgC0cPXoYJzqBRCSq9D/qW+M6MsqPlW7/FYjk2xTHk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lJzodYhIAKjaK0QUWUQoIjcSA00fS3TgcFOUw9KNhv8qqxVssHkddQQ4QqMC8qSaZtOxnXM1NJdqh+eB24UckWQVu8v33ypmudExmnLLqpwdKwPkz9yKR/xkfaRKyYIxhuTUg4Huqocnbxbt0lOWbqqsOajbSn0/0f6qm/Adq3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XtYkw5DLgz4f3kK4;
	Wed, 20 Nov 2024 16:03:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2E4E51A0359;
	Wed, 20 Nov 2024 16:03:18 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgDXtsPElz1n3Kv4CA--.63612S2;
	Wed, 20 Nov 2024 16:03:18 +0800 (CST)
Subject: Re: [PATCH v2] mm/page-writeback: Raise wb_thresh to prevent write
 blocking with strictlimit
To: Jim Zhao <jimzhao.ai@gmail.com>, jack@suse.cz
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org
References: <20241119114444.3925495-1-jimzhao.ai@gmail.com>
 <20241119122922.3939538-1-jimzhao.ai@gmail.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <5584d4d5-73c8-2a12-f11e-6f19c216656b@huaweicloud.com>
Date: Wed, 20 Nov 2024 16:03:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241119122922.3939538-1-jimzhao.ai@gmail.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDXtsPElz1n3Kv4CA--.63612S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyxGFy8GrWfCFW3ArWxXrb_yoWxGFW5pF
	W7J3W3AFWUJr4I9rsxZFy8Wr12qrs2qrW2gF9rA34Yvrn8Cry7Jr1IkFsYyFy8AFy7GF1r
	Za1YqF97WryqkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 11/19/2024 8:29 PM, Jim Zhao wrote:
> Thanks, Jan, I just sent patch v2, could you please review it ?
> 
> And I found the debug info in the bdi stats. 
> The BdiDirtyThresh value may be greater than DirtyThresh, and after applying this patch, the value of BdiDirtyThresh could become even larger.
> 
> without patch:
> ---
> root@ubuntu:/sys/kernel/debug/bdi/8:0# cat stats
> BdiWriteback:                0 kB
> BdiReclaimable:             96 kB
> BdiDirtyThresh:        1346824 kB
> DirtyThresh:            673412 kB
> BackgroundThresh:       336292 kB
> BdiDirtied:              19872 kB
> BdiWritten:              19776 kB
> BdiWriteBandwidth:           0 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> 
> with patch:
> ---
> root@ubuntu:/sys/kernel/debug/bdi/8:0# cat stats
> BdiWriteback:               96 kB
> BdiReclaimable:            192 kB
> BdiDirtyThresh:        3090736 kB
> DirtyThresh:            650716 kB
> BackgroundThresh:       324960 kB
> BdiDirtied:             472512 kB
> BdiWritten:             470592 kB
> BdiWriteBandwidth:      106268 kBps
> b_dirty:                     2
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> 
> 
> @kemeng, is this a normal behavior or an issue ?
Hello, this is not a normal behavior, could you aslo send the content in
wb_stats and configuired bdi_min_ratio.
I think the improper use of bdi_min_ratio may cause the issue.

Thanks,
Kemeng
> 
> Thanks,
> Jim Zhao
> 
> 
>> With the strictlimit flag, wb_thresh acts as a hard limit in
>> balance_dirty_pages() and wb_position_ratio().  When device write
>> operations are inactive, wb_thresh can drop to 0, causing writes to be
>> blocked.  The issue occasionally occurs in fuse fs, particularly with
>> network backends, the write thread is blocked frequently during a period.
>> To address it, this patch raises the minimum wb_thresh to a controllable
>> level, similar to the non-strictlimit case.
>>
>> Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
>> ---
>> Changes in v2:
>> 1. Consolidate all wb_thresh bumping logic in __wb_calc_thresh for consistency;
>> 2. Replace the limit variable with thresh for calculating the bump value,
>> as __wb_calc_thresh is also used to calculate the background threshold;
>> 3. Add domain_dirty_avail in wb_calc_thresh to get dtc->dirty.
>> ---
>>  mm/page-writeback.c | 48 ++++++++++++++++++++++-----------------------
>>  1 file changed, 23 insertions(+), 25 deletions(-)
>>
>> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>> index e5a9eb795f99..8b13bcb42de3 100644
>> --- a/mm/page-writeback.c
>> +++ b/mm/page-writeback.c
>> @@ -917,7 +917,9 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
>>                                     unsigned long thresh)
>>  {
>>       struct wb_domain *dom = dtc_dom(dtc);
>> +     struct bdi_writeback *wb = dtc->wb;
>>       u64 wb_thresh;
>> +     u64 wb_max_thresh;
>>       unsigned long numerator, denominator;
>>       unsigned long wb_min_ratio, wb_max_ratio;
>>
>> @@ -931,11 +933,27 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
>>       wb_thresh *= numerator;
>>       wb_thresh = div64_ul(wb_thresh, denominator);
>>
>> -     wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
>> +     wb_min_max_ratio(wb, &wb_min_ratio, &wb_max_ratio);
>>
>>       wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
>> -     if (wb_thresh > (thresh * wb_max_ratio) / (100 * BDI_RATIO_SCALE))
>> -             wb_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
>> +
>> +     /*
>> +      * It's very possible that wb_thresh is close to 0 not because the
>> +      * device is slow, but that it has remained inactive for long time.
>> +      * Honour such devices a reasonable good (hopefully IO efficient)
>> +      * threshold, so that the occasional writes won't be blocked and active
>> +      * writes can rampup the threshold quickly.
>> +      */
>> +     if (thresh > dtc->dirty) {
>> +             if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT))
>> +                     wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 100);
>> +             else
>> +                     wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 8);
>> +     }
>> +
>> +     wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
>> +     if (wb_thresh > wb_max_thresh)
>> +             wb_thresh = wb_max_thresh;
>>
>>       return wb_thresh;
>>  }
>> @@ -944,6 +962,7 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
>>  {
>>       struct dirty_throttle_control gdtc = { GDTC_INIT(wb) };
>>
>> +     domain_dirty_avail(&gdtc, true);
>>       return __wb_calc_thresh(&gdtc, thresh);
>>  }
>>
>> @@ -1120,12 +1139,6 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
>>       if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
>>               long long wb_pos_ratio;
>>
>> -             if (dtc->wb_dirty < 8) {
>> -                     dtc->pos_ratio = min_t(long long, pos_ratio * 2,
>> -                                        2 << RATELIMIT_CALC_SHIFT);
>> -                     return;
>> -             }
>> -
>>               if (dtc->wb_dirty >= wb_thresh)
>>                       return;
>>
>> @@ -1196,14 +1209,6 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
>>        */
>>       if (unlikely(wb_thresh > dtc->thresh))
>>               wb_thresh = dtc->thresh;
>> -     /*
>> -      * It's very possible that wb_thresh is close to 0 not because the
>> -      * device is slow, but that it has remained inactive for long time.
>> -      * Honour such devices a reasonable good (hopefully IO efficient)
>> -      * threshold, so that the occasional writes won't be blocked and active
>> -      * writes can rampup the threshold quickly.
>> -      */
>> -     wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8);
>>       /*
>>        * scale global setpoint to wb's:
>>        *      wb_setpoint = setpoint * wb_thresh / thresh
>> @@ -1459,17 +1464,10 @@ static void wb_update_dirty_ratelimit(struct dirty_throttle_control *dtc,
>>        * balanced_dirty_ratelimit = task_ratelimit * write_bw / dirty_rate).
>>        * Hence, to calculate "step" properly, we have to use wb_dirty as
>>        * "dirty" and wb_setpoint as "setpoint".
>> -      *
>> -      * We rampup dirty_ratelimit forcibly if wb_dirty is low because
>> -      * it's possible that wb_thresh is close to zero due to inactivity
>> -      * of backing device.
>>        */
>>       if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
>>               dirty = dtc->wb_dirty;
>> -             if (dtc->wb_dirty < 8)
>> -                     setpoint = dtc->wb_dirty + 1;
>> -             else
>> -                     setpoint = (dtc->wb_thresh + dtc->wb_bg_thresh) / 2;
>> +             setpoint = (dtc->wb_thresh + dtc->wb_bg_thresh) / 2;
>>       }
>>
>>       if (dirty < setpoint) {
>> --
>> 2.20.1
> 


