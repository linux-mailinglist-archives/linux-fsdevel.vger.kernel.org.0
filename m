Return-Path: <linux-fsdevel+bounces-8637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC619839E81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40B81C23BA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DED1C16;
	Wed, 24 Jan 2024 02:02:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F471841;
	Wed, 24 Jan 2024 02:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061726; cv=none; b=ioTWzCeMk9ro5cfI69PpklN0iAWUBxmPZ3w7Z1deVeD5/4KOL/NBjdpmYyhiWx4KmK1G0ChNOcJn9uH8GtUiRvcE9tVpY0TNEZJP//+LA2s2CktZNcfhWvgYR+jdhtGFTy+hFvT64O7LPs13RSTqg+EBEDxH6y3rhn+2I05fEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061726; c=relaxed/simple;
	bh=SEPWJ8KgQvsmRUWmz4Zz8rIbbyoKhc90M56sFjY+iRc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kqbcoW1M+b/LGcTQhtSUCYszefan1O0BkmLdONuQvkdZtaL2o1dHz11/QJM5gsCpaF9x0128VHAryv5GfM6T/UbcknlUlAovbZrdcAMHjAz8WEJf0rwif0bgHC2dl4oV9Wc281PtWEC1vOfshkzvrXTBEcdY9nGNDtXnB0GIhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TKRz139rnz4f3js8;
	Wed, 24 Jan 2024 10:01:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5D19E1A0232;
	Wed, 24 Jan 2024 10:01:53 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgBXdQ6Lb7Bl6CknBw--.43192S2;
	Wed, 24 Jan 2024 10:01:49 +0800 (CST)
Subject: Re: [PATCH 2/5] mm: correct calculation of cgroup wb's bg_thresh in
 wb_over_bg_thresh
To: Tejun Heo <tj@kernel.org>
Cc: willy@infradead.org, akpm@linux-foundation.org,
 hcochran@kernelspring.com, mszeredi@redhat.com, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240123183332.876854-1-shikemeng@huaweicloud.com>
 <20240123183332.876854-3-shikemeng@huaweicloud.com>
 <ZbAk8HfnzHoSSFWC@slm.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <a747dc7d-f24a-08bd-d969-d3fb35e151b7@huaweicloud.com>
Date: Wed, 24 Jan 2024 10:01:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZbAk8HfnzHoSSFWC@slm.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXdQ6Lb7Bl6CknBw--.43192S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1fJw18Gr4xGF4ktFykAFb_yoW5GrW5pF
	Z7JrnFyw4DXFs7JFZrKa92qrW0q3y0yF13Xas0kr1UGrnxGF95Kr4ava1Dury5CrnxJr1F
	yFsxGrykXrWqyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 1/24/2024 4:43 AM, Tejun Heo wrote:
> On Wed, Jan 24, 2024 at 02:33:29AM +0800, Kemeng Shi wrote:
>> The wb_calc_thresh will calculate wb's share in global wb domain. We need
>> to wb's share in mem_cgroup_wb_domain for mdtc. Call __wb_calc_thresh
>> instead of wb_calc_thresh to fix this.
> 
> That function is calculating the wb's portion of wb portion in the whole
> system so that threshold can be distributed accordingly. So, it has to be
> compared in the global domain. If you look at the comment on top of struct
> wb_domain, it says:
> 
> /*
>  * A wb_domain represents a domain that wb's (bdi_writeback's) belong to
>  * and are measured against each other in.  There always is one global
>  * domain, global_wb_domain, that every wb in the system is a member of.
>  * This allows measuring the relative bandwidth of each wb to distribute
>  * dirtyable memory accordingly.
>  */
> 
Hi Tejun, thanks for reply. For cgroup wb, it will belongs to a global wb
domain and a cgroup domain. I agree the way how we calculate wb's threshold
in global domain as you described above. This patch tries to fix calculation
of wb's threshold in cgroup domain which now is wb_calc_thresh(mdtc->wb,
mdtc->bg_thresh)), means:
(wb bandwidth) / (system bandwidth) * (*cgroup domain threshold*)
The cgroup domain threshold is
(memory of cgroup domain) / (memory of system) * (system threshold).
Then the wb's threshold in cgroup will be smaller than expected.

Consider following domain hierarchy:
                global domain (100G)
                /                 \
        cgroup domain1(50G)     cgroup domain2(50G)
                |                 |
bdi            wb1               wb2
Assume wb1 and wb2 has the same bandwidth.
We have global domain bg_thresh 10G, cgroup domain bg_thresh 5G.
Then we have:
wb's thresh in global domain = 10G * (wb bandwidth) / (system bandwidth)
= 10G * 1/2 = 5G
wb's thresh in cgroup domain = 5G * (wb bandwidth) / (system bandwidth)
= 5G * 1/2 = 2.5G
At last, wb1 and wb2 will be limited at 2.5G, the system will be limited
at 5G which is less than global domain bg_thresh 10G.

After the fix, threshold in cgroup domain will be:
(wb bandwidth) / (cgroup bandwidth) * (cgroup domain threshold)
The wb1 and wb2 will be limited at 5G, the system will be limited at
10G which equals to global domain bg_thresh 10G.

As I didn't take a deep look into memory cgroup, please correct me if
anything is wrong. Thanks!
> Also, how is this tested? Was there a case where the existing code
> misbehaved that's improved by this patch? Or is this just from reading code?
This is jut from reading code. Would the case showed above convince you
a bit. Look forward to your reply, thanks!.
> 
> Thanks.
> 


