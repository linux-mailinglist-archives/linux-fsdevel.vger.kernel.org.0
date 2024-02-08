Return-Path: <linux-fsdevel+bounces-10757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058E484DCE5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1669286BB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1066D1C2;
	Thu,  8 Feb 2024 09:26:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8456D1BC;
	Thu,  8 Feb 2024 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384380; cv=none; b=R+1smdhYHt74cR00sD142GZxEcjx7FbKmeM+63xt6v2oJ5mmAbJzGBDv5qhp7gcXcR+8USgxkzZK9wApRXucyMlwdC+EFZ/nkvTPVQk+O50nx+ly8qpMvRBt5njV418QSOR9/PFuV6k0j3i4R7l0ebuFjX4XoeLGO0dhq3dKGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384380; c=relaxed/simple;
	bh=DsVRU/FjB3HlukFPBJodnTPT4IPtlfjRSWue5tbmGg8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ErFoZfAObhdYps/RwprSWbjv3OeRKlcUrGNu9rfaptavi59cVBvzlIMJM47pz1eYWmwINudnibRVrhh9UXS855O+MmizNd6zXyDTrR2NluBupFaeBnzFuf9EMBhk72iNTu1nag9OF14Hb7shiykNOjDC0jPFUM6rjnqOUMc6zXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TVs6r5Gl4z4f3jZD;
	Thu,  8 Feb 2024 17:26:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8ADA41A016E;
	Thu,  8 Feb 2024 17:26:15 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgCXZg8ynsRlPIJlDQ--.2557S2;
	Thu, 08 Feb 2024 17:26:12 +0800 (CST)
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
 <a747dc7d-f24a-08bd-d969-d3fb35e151b7@huaweicloud.com>
 <ZbgR5-yOn7f5MtcD@slm.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <ad794d74-5f58-2fed-5a04-2c50c8594723@huaweicloud.com>
Date: Thu, 8 Feb 2024 17:26:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZbgR5-yOn7f5MtcD@slm.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCXZg8ynsRlPIJlDQ--.2557S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF48AF17urWrJr15uFW5Awb_yoW7Ww1xpF
	ZrJr1kGwsrGFn7CrsF9Fy09rWvvw4xGa45Jr9Fv34qgF1agFyUK39xZayvgry7CFnxXFy2
	y3WrAr9agryqv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 1/30/2024 5:00 AM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jan 24, 2024 at 10:01:47AM +0800, Kemeng Shi wrote:
>> Hi Tejun, thanks for reply. For cgroup wb, it will belongs to a global wb
>> domain and a cgroup domain. I agree the way how we calculate wb's threshold
>> in global domain as you described above. This patch tries to fix calculation
>> of wb's threshold in cgroup domain which now is wb_calc_thresh(mdtc->wb,
>> mdtc->bg_thresh)), means:
>> (wb bandwidth) / (system bandwidth) * (*cgroup domain threshold*)
>> The cgroup domain threshold is
>> (memory of cgroup domain) / (memory of system) * (system threshold).
>> Then the wb's threshold in cgroup will be smaller than expected.
>>
>> Consider following domain hierarchy:
>>                 global domain (100G)
>>                 /                 \
>>         cgroup domain1(50G)     cgroup domain2(50G)
>>                 |                 |
>> bdi            wb1               wb2
>> Assume wb1 and wb2 has the same bandwidth.
>> We have global domain bg_thresh 10G, cgroup domain bg_thresh 5G.
>> Then we have:
>> wb's thresh in global domain = 10G * (wb bandwidth) / (system bandwidth)
>> = 10G * 1/2 = 5G
>> wb's thresh in cgroup domain = 5G * (wb bandwidth) / (system bandwidth)
>> = 5G * 1/2 = 2.5G
>> At last, wb1 and wb2 will be limited at 2.5G, the system will be limited
>> at 5G which is less than global domain bg_thresh 10G.
>>
>> After the fix, threshold in cgroup domain will be:
>> (wb bandwidth) / (cgroup bandwidth) * (cgroup domain threshold)
>> The wb1 and wb2 will be limited at 5G, the system will be limited at
>> 10G which equals to global domain bg_thresh 10G.
>>
>> As I didn't take a deep look into memory cgroup, please correct me if
>> anything is wrong. Thanks!
>>> Also, how is this tested? Was there a case where the existing code
>>> misbehaved that's improved by this patch? Or is this just from reading code?
>>
>> This is jut from reading code. Would the case showed above convince you
>> a bit. Look forward to your reply, thanks!.
> 
> So, the explanation makes some sense to me but can you please construct a
> case to actually demonstrate the problem and fix? I don't think it'd be wise
> to apply the change without actually observing the code change does what it
> says it does.
Hi Tejun, sorry for the delay as I found there is a issue that keep triggering
writeback even the dirty page is under dirty background threshold. The issue
make it difficult to observe the expected improvment from this patch. I try to
fix it in [1] and test this patch based on the fix patches.
Run test as following:

/* make background writeback easier to observe */
echo 300000 > /proc/sys/vm/dirty_expire_centisecs
echo 100 > /proc/sys/vm/dirty_writeback_centisecs
/* enable memory and io cgroup */
echo "+memory +io" > /sys/fs/cgroup/cgroup.subtree_control

/* run fio in group1 with shell */
cd /sys/fs/cgroup
mkdir group1
cd group1
echo 10G > memory.high
echo 10G > memory.max
echo $$ > cgroup.procs
mkfs.ext4 -F /dev/vdb
mount /dev/vdb /bdi1/
fio -name test -filename=/bdi1/file -size=800M -ioengine=libaio -bs=4K -iodepth=1 -rw=write -direct=0 --time_based -runtime=60 -invalidate=0

/* run another fio in group2 with another shell */
cd /sys/fs/cgroup
mkdir group2
cd group2
echo 10G > memory.high
echo 10G > memory.max
echo $$ > cgroup.procs
mkfs.ext4 -F /dev/vdc
mount /dev/vdc /bdi2/
fio -name test -filename=/bdi2/file -size=800M -ioengine=libaio -bs=4K -iodepth=1 -rw=write -direct=0 --time_based -runtime=60 -invalidate=0

Before the fix we got (result of three tests):
fio1
  WRITE: bw=1304MiB/s (1367MB/s), 1304MiB/s-1304MiB/s (1367MB/s-1367MB/s), io=76.4GiB (82.0GB), run=60001-60001msec
  WRITE: bw=1351MiB/s (1417MB/s), 1351MiB/s-1351MiB/s (1417MB/s-1417MB/s), io=79.2GiB (85.0GB), run=60001-60001msec
  WRITE: bw=1373MiB/s (1440MB/s), 1373MiB/s-1373MiB/s (1440MB/s-1440MB/s), io=80.5GiB (86.4GB), run=60001-60001msec
fio2
  WRITE: bw=1134MiB/s (1190MB/s), 1134MiB/s-1134MiB/s (1190MB/s-1190MB/s), io=66.5GiB (71.4GB), run=60001-60001msec
  WRITE: bw=1414MiB/s (1483MB/s), 1414MiB/s-1414MiB/s (1483MB/s-1483MB/s), io=82.8GiB (88.0GB), run=60001-60001msec
  WRITE: bw=1469MiB/s (1540MB/s), 1469MiB/s-1469MiB/s (1540MB/s-1540MB/s), io=86.0GiB (92.4GB), run=60001-60001msec

After the fix we got (result of three tests):
fio1
  WRITE: bw=1719MiB/s (1802MB/s), 1719MiB/s-1719MiB/s (1802MB/s-1802MB/s), io=101GiB (108GB), run=60001-60001msec
  WRITE: bw=1723MiB/s (1806MB/s), 1723MiB/s-1723MiB/s (1806MB/s-1806MB/s), io=101GiB (108GB), run=60001-60001msec
  WRITE: bw=1691MiB/s (1774MB/s), 1691MiB/s-1691MiB/s (1774MB/s-1774MB/s), io=99.2GiB (106GB), run=60036-60036msec
fio2
  WRITE: bw=1692MiB/s (1774MB/s), 1692MiB/s-1692MiB/s (1774MB/s-1774MB/s), io=99.1GiB (106GB), run=60001-60001msec
  WRITE: bw=1681MiB/s (1763MB/s), 1681MiB/s-1681MiB/s (1763MB/s-1763MB/s), io=98.5GiB (106GB), run=60001-60001msec
  WRITE: bw=1671MiB/s (1752MB/s), 1671MiB/s-1671MiB/s (1752MB/s-1752MB/s), io=97.9GiB (105GB), run=60001-60001msec
I also add code to print the pages written in writeback and pages written in
writeback reduce a lot and are rare after this fix.

[1] https://lore.kernel.org/linux-fsdevel/20240208172024.23625-2-shikemeng@huaweicloud.com/T/#u
> 
> Thanks.
> 


