Return-Path: <linux-fsdevel+bounces-17446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F6A8ADB6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 03:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17C91C210A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 01:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BD31172C;
	Tue, 23 Apr 2024 01:15:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F8EE57E;
	Tue, 23 Apr 2024 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713834929; cv=none; b=KVM553NoaFAx+84Inup9IqZ9CsrcW86mzAdBDq2N86kBKSaXgmGuTxiPdyAf+M1admyikprW0ZTvcjWD8Ulksci2UHaY2WCWatFNlGz9TzsU1jNJgEKirnxradrVpolP/fSAczI0CDc7FL+gfc0Zj8C3mpeuka/n7mqVoPpGDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713834929; c=relaxed/simple;
	bh=vJvnUU5F0EtGJV+PqP1PFDfhLv+WzdP7ZGV4C8OuObg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fdyFw2uyen0PvCDqt7xWq6+s8PcpkO+cd7tY/DKIMNhUm41mpqQ5GdCeVmt7r8XtqWXHqcJHWuNyhXPim0jtvVNFlM4nztP6xCZSqEjncT+4r/V4L+Wj/+eolCvkoYIWSadg/WUJnEkwcLrcDinWIpBTzKrCDQlg+BJlqJ+FUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNkgc5SLkz4f3m6Z;
	Tue, 23 Apr 2024 09:15:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DF6131A016E;
	Tue, 23 Apr 2024 09:15:17 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgCXsQqkCydmICrVKg--.12730S2;
	Tue, 23 Apr 2024 09:15:17 +0800 (CST)
Subject: Re: [PATCH v4 2/4] writeback: support retrieving per group debug
 writeback stats of bdi
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
 bfoster@redhat.com, dsterba@suse.com, mjguzik@gmail.com,
 dhowells@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240422164808.13627-1-shikemeng@huaweicloud.com>
 <20240422164808.13627-3-shikemeng@huaweicloud.com>
 <ZiatOJDzICT9e6pi@slm.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <7e8d85c0-8b36-9c47-1411-f7077e5c0cd8@huaweicloud.com>
Date: Tue, 23 Apr 2024 09:15:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZiatOJDzICT9e6pi@slm.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCXsQqkCydmICrVKg--.12730S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4Uur4DAr4fuF43Kr4xXrb_yoW8WFy7pF
	4xAw18trW8X3409F12k3WxWr90vayDXFy5X3s7Cry7JrsxKr15tr9Ig3yYvFn8ZF93ZF95
	JanIvryktw1vyw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



on 4/23/2024 2:32 AM, Tejun Heo wrote:
> Hello,
> 
> On Tue, Apr 23, 2024 at 12:48:06AM +0800, Kemeng Shi wrote:
>> Add /sys/kernel/debug/bdi/xxx/wb_stats to show per group writeback stats
>> of bdi.
>>
>> Following domain hierarchy is tested:
>>                 global domain (320G)
>>                 /                 \
>>         cgroup domain1(10G)     cgroup domain2(10G)
>>                 |                 |
>> bdi            wb1               wb2
>>
>> /* per wb writeback info of bdi is collected */
>> cat /sys/kernel/debug/bdi/252:16/wb_stats
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
>> WbCgIno:                 4094
>> WbWriteback:            54432 kB
>> WbReclaimable:         766080 kB
>> WbDirtyThresh:        3094760 kB
>> WbDirtied:            1656480 kB
>> WbWritten:             837088 kB
>> WbWriteBandwidth:      132772 kBps
>> b_dirty:                    1
>> b_io:                       1
>> b_more_io:                  0
>> b_dirty_time:               0
>> state:                      7
>> WbCgIno:                 4135
>> WbWriteback:            15232 kB
>> WbReclaimable:         786688 kB
>> WbDirtyThresh:        2909984 kB
>> WbDirtied:            1482656 kB
>> WbWritten:             681408 kB
>> WbWriteBandwidth:      124848 kBps
>> b_dirty:                    0
>> b_io:                       1
>> b_more_io:                  0
>> b_dirty_time:               0
>> state:                      7
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Maybe it'd be useful to delineate each wb better in the output? It's a bit
> difficult to parse visually. Other than that,
Sorry for this. A blank line was added at end of each wb in this patch but I
forgot to update the changelog.
As there is some kunit build problem reported, I will correct changelog with
the fix to build problem.
Thanks a lot for review.

Kemeng
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 


