Return-Path: <linux-fsdevel+bounces-15510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE3B88F9F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 09:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431BF2934BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AAC5491D;
	Thu, 28 Mar 2024 08:24:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B5224D0;
	Thu, 28 Mar 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614246; cv=none; b=nVOAfxDyCYc9MsCU0VRk+3U/mGOHwVIdD2po60rYCjhZV+/YgCBrylJL5iMFLLzt7dskXbhhTk6QVOeuFtJHRlA7R9zNlxlgCQ/+I+xIAD0SagP3X7G3CPkmDWM9GCjMuWbDFO3TuaPgE+1kqKFIWmiua+zOHX1wCV2lWYBMT5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614246; c=relaxed/simple;
	bh=3wXLtibn6+YJL74upJjhVxc8aFa7QOdx6HvjY210UyA=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CB/YPJJiFR1ycJ/UOevRyP/fHNFSCm1oDKTh95d4WNT6VRKVObtkD7aKMinthURqNlUX7uhiSjhTfVHjlmpb8LNGf9DBFpkxOY0+pque23MAgTAR98A+eKG/dEbr6g0+HKJb+qJf3oarnWqtqlL1r078i1F0gFSskPCmrvvp/bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V4xQH2QN1z4f3nbv;
	Thu, 28 Mar 2024 16:23:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7D0161A0572;
	Thu, 28 Mar 2024 16:23:59 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgCn+mwcKQVm6yfcIQ--.6069S2;
	Thu, 28 Mar 2024 16:23:58 +0800 (CST)
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, jack@suse.cz, bfoster@redhat.com, tj@kernel.org,
 dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <20240327104010.73d1180fbabe586f9e3f7bd2@linux-foundation.org>
 <05bae65c-99fa-34f2-43e6-9a16f7d1ddc7@huaweicloud.com>
Message-ID: <2695c070-6490-172a-e735-521f6412aa74@huaweicloud.com>
Date: Thu, 28 Mar 2024 16:23:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <05bae65c-99fa-34f2-43e6-9a16f7d1ddc7@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn+mwcKQVm6yfcIQ--.6069S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrykZrW3WF4rJw45Wr1DAwb_yoW5AFyUpa
	95Can8Kry7CF1xJwnakan2yw12qws8ta17G3sxXr1fAFW29FyvvrZ29rWY9F1UAwsFkFy2
	qFsrWFyvvw1qy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/28/2024 9:59 AM, Kemeng Shi wrote:
> 
> on 3/28/2024 1:40 AM, Andrew Morton wrote:
>> On Wed, 27 Mar 2024 23:57:45 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>>
>>> This series tries to improve visilibity of writeback.
>>
>> Well...  why?  Is anyone usefully using the existing instrumentation? 
>> What is to be gained by expanding it further?  What is the case for
>> adding this code?
>>
>> I don't recall hearing of anyone using the existing debug
>> instrumentation so perhaps we should remove it!
> Hi Andrew, this was discussed in [1]. In short, I use the
> debug files to test change in submit patchset [1]. The
> wb_monitor.py is suggested by Tejun in [2] to improve
> visibility of writeback.
> I use the debug files to test change in [1]. The wb_monitor.py is suggested by Tejun
> in [2] to improve visibility of writeback.
>>
>> Also, I hit a build error and a pile of warnings with an arm
>> allnoconfig build.
With arm allnoconfig build on uptodated mm-unstable branch, I don't
hit any build error but only some warnings as following:
...
mm/page-writeback.c: In function ¡®cgwb_calc_thresh¡¯:
mm/page-writeback.c:906:13: warning: ¡®writeback¡¯ is used uninitialized in this function [-Wuninitialized]
  906 |  mdtc.dirty += writeback;
      |  ~~~~~~~~~~~^~~~~~~~~~~~
In file included from ./include/linux/kernel.h:28,
                 from mm/page-writeback.c:15:
./include/linux/minmax.h:46:54: warning: ¡®filepages¡¯ is used uninitialized in this function [-Wuninitialized]
   46 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
      |                                                      ^
mm/page-writeback.c:898:16: note: ¡®filepages¡¯ was declared here
  898 |  unsigned long filepages, headroom, writeback;
      |                ^~~~~~~~~
In file included from ./include/linux/kernel.h:28,
                 from mm/page-writeback.c:15:
./include/linux/minmax.h:46:54: warning: ¡®headroom¡¯ is used uninitialized in this function [-Wuninitialized]
   46 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
      |                                                      ^
mm/page-writeback.c:898:27: note: ¡®headroom¡¯ was declared here
  898 |  unsigned long filepages, headroom, writeback;
      |                           ^~~~~~~~
...

The only reason I can think of is that I also apply patchset [1]
for build. I mentioned patchset [1] in cover letter but I forgot
to notify the dependency to the patchset.
If this is the reason to blame for buidl error, I will send a new
set based on mm-unstable in next version.

Thanks,
Kemeng

[1] https://lore.kernel.org/lkml/20240123183332.876854-1-shikemeng@huaweicloud.com/T/#mc6455784a63d0f8aa1a2f5aff325abcdf9336b76
>>
> Sorry for this, I only tested on x86. I will look into this and
> fix the build problem in next version.
> 
> [1] https://lore.kernel.org/lkml/44e3b910-8b52-5583-f8a9-37105bf5e5b6@huaweicloud.com/
> [2] https://lore.kernel.org/lkml/a747dc7d-f24a-08bd-d969-d3fb35e151b7@huaweicloud.com/
> [3] https://lore.kernel.org/lkml/ZcUsOb_fyvYr-zZ-@slm.duckdns.org/
> 


