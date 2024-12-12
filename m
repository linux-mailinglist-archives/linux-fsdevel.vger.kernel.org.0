Return-Path: <linux-fsdevel+bounces-37160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288B99EE6BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C760F282CCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8840C212B2A;
	Thu, 12 Dec 2024 12:32:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33046259484;
	Thu, 12 Dec 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006745; cv=none; b=GVGxpiEzz3dUKUuXe7tHAfK2xxeTHffrt6rpprl7gRWZ5b7mGow4OY0vpqaKPqoKKDSGw8W742W+X5BUM/n2uFBUJXxCTSrkpOVeLdFlQfxtLE9vNLPEy0fBw1RjYHMazxI0jcJgG1Of0BOJzFkZpApHSaWI59pXrEaWGwBwKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006745; c=relaxed/simple;
	bh=N/Cc42N0MATihxVxCc7tOZ3NIAkLZvLaJF5Azbh1yV8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hhO1TDSsj8RuRLf1hKnEOEROYobL/bWxoCmmjsz/eXcCE0X/qUZEMnn8RCvfWmVCOFe8zxNOPWrdKtdUgitCgUWivOpFpGfGsI/h2wBbe23j0oT8+eijN9yhlgGSqMoQeb+7UfgYc0INSz4/Tw2HAmX0tBmTAbOyBdD3D5y8IAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y8Bg65xjqz4f3jqY;
	Thu, 12 Dec 2024 20:32:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2624F1A0196;
	Thu, 12 Dec 2024 20:32:17 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgB3ILLP11pn2HUgEQ--.44978S2;
	Thu, 12 Dec 2024 20:32:17 +0800 (CST)
Subject: Re: [PATCH v2] mm/page-writeback: Raise wb_thresh to prevent write
 blocking with strictlimit
To: Jim Zhao <jimzhao.ai@gmail.com>
Cc: jack@suse.cz, akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org
References: <5584d4d5-73c8-2a12-f11e-6f19c216656b@huaweicloud.com>
 <20241121080531.567995-1-jimzhao.ai@gmail.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <4ff421cd-fffd-550c-4598-b79c633621eb@huaweicloud.com>
Date: Thu, 12 Dec 2024 20:32:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241121080531.567995-1-jimzhao.ai@gmail.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB3ILLP11pn2HUgEQ--.44978S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy5CFy3Ar4Dtr18ur1fCrg_yoW5tFy7p3
	y7JanFyw4UA3s2yrsI9as7XrWqv340q345XFWkA34Uur9a9r15Arn5KryrAF1DXFZI9ry8
	XFs0934xXr1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 11/21/2024 4:05 PM, Jim Zhao wrote:
>> on 11/19/2024 8:29 PM, Jim Zhao wrote:
>>> Thanks, Jan, I just sent patch v2, could you please review it ?
>>>
>>> And I found the debug info in the bdi stats.
>>> The BdiDirtyThresh value may be greater than DirtyThresh, and after applying this patch, the value of BdiDirtyThresh could become even larger.
>>>
>>> without patch:
>>> ---
>>> root@ubuntu:/sys/kernel/debug/bdi/8:0# cat stats
>>> BdiWriteback:                0 kB
>>> BdiReclaimable:             96 kB
>>> BdiDirtyThresh:        1346824 kB
>>> DirtyThresh:            673412 kB
>>> BackgroundThresh:       336292 kB
>>> BdiDirtied:              19872 kB
>>> BdiWritten:              19776 kB
>>> BdiWriteBandwidth:           0 kBps
>>> b_dirty:                     0
>>> b_io:                        0
>>> b_more_io:                   0
>>> b_dirty_time:                0
>>> bdi_list:                    1
>>> state:                       1
>>>
>>> with patch:
>>> ---
>>> root@ubuntu:/sys/kernel/debug/bdi/8:0# cat stats
>>> BdiWriteback:               96 kB
>>> BdiReclaimable:            192 kB
>>> BdiDirtyThresh:        3090736 kB
>>> DirtyThresh:            650716 kB
>>> BackgroundThresh:       324960 kB
>>> BdiDirtied:             472512 kB
>>> BdiWritten:             470592 kB
>>> BdiWriteBandwidth:      106268 kBps
>>> b_dirty:                     2
>>> b_io:                        0
>>> b_more_io:                   0
>>> b_dirty_time:                0
>>> bdi_list:                    1
>>> state:                       1
>>>
>>>
>>> @kemeng, is this a normal behavior or an issue ?
>> Hello, this is not a normal behavior, could you aslo send the content in
>> wb_stats and configuired bdi_min_ratio.
>> I think the improper use of bdi_min_ratio may cause the issue.
> 
> the min_ratio is 0
> ---
> root@ubuntu:/sys/class/bdi/8:0# cat min_bytes
> 0
> root@ubuntu:/sys/class/bdi/8:0# cat min_ratio
> 0
> root@ubuntu:/sys/class/bdi/8:0# cat min_ratio_fine
> 0
> 
> wb_stats:
> ---
> 
> root@ubuntu:/sys/kernel/debug/bdi/8:0# cat stats
> BdiWriteback:                0 kB
> BdiReclaimable:            480 kB
> BdiDirtyThresh:        1664700 kB
> DirtyThresh:            554900 kB
> BackgroundThresh:       277108 kB
> BdiDirtied:              82752 kB
> BdiWritten:              82752 kB
> BdiWriteBandwidth:      205116 kBps
> b_dirty:                     6
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> root@ubuntu:/sys/kernel/debug/bdi/8:0# cat wb_stats
...
> 
> WbCgIno:                  416
> WbWriteback:                0 kB
> WbReclaimable:            288 kB
> WbDirtyThresh:         554836 kB
> WbDirtied:              47616 kB
> WbWritten:              47424 kB
> WbWriteBandwidth:         168 kBps
> b_dirty:                    1
> b_io:                       0
> b_more_io:                  0
> b_dirty_time:               0
> state:                      5
> 
...
> WbCgIno:                 3186
> WbWriteback:                0 kB
> WbReclaimable:             96 kB
> WbDirtyThresh:         554788 kB
> WbDirtied:               1056 kB
> WbWritten:               1152 kB
> WbWriteBandwidth:         152 kBps
> b_dirty:                    1
> b_io:                       0
> b_more_io:                  0
> b_dirty_time:               0
> state:                      5
...
> WbCgIno:                   72
> WbWriteback:                0 kB
> WbReclaimable:              0 kB
> WbDirtyThresh:         554836 kB
> WbDirtied:                 96 kB
> WbWritten:                192 kB
> WbWriteBandwidth:           4 kBps
> b_dirty:                    1
> b_io:                       0
> b_more_io:                  0
> b_dirty_time:               0
> state:                      5
Hi Jim,
Sorry for late reply.
The dirty thresh of these three groups is as high as dirty thresh
of whole bdi which is unusual. In __wb_calc_thresh, we calculate
dirty thresh of group by (numerator / denominator) * (thresh of
whole bdi) roughly, so (numerator / denominator) of these three
groups is 1. However, the sum of (numerator / denominator) of
all groups is suppose to be 1.
In fprop_fraction_percpu, we know numerator and denominator are
retrieved from percpu_counter, I think it's because of percpu
counter errors make this happen. Do we cat wb_stats and stats
when writeback load is low. If so, it's likely caused by percpu
counter errors .


> ubuntu24.04 desktop + kernel 6.12.0
> default cgroups, not configured manually.
> 
> ---
> Thanks
> Jim Zhao
> 


