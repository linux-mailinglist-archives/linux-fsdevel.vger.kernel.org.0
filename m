Return-Path: <linux-fsdevel+bounces-56060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8861B1287C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 03:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096C11CC5873
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 01:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DC71C8604;
	Sat, 26 Jul 2025 01:42:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36D381BA;
	Sat, 26 Jul 2025 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753494168; cv=none; b=lEfrnGX6ev6a2AFQ0OncOiTZSEJx+S5X5SixRciISR8X95ISAx+ogVVrrkdGbEybB5Cv0EbiIe+6frC++DQALQtI7a56nnzOOI4EHVRkirS8F4eoetTg8E6Bj+pfO8b2sfpT4EXAexE1EwAtfu94tFiUmQEOKQ3pdwSNcszr3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753494168; c=relaxed/simple;
	bh=ABFfoAOBAwyUcqf0zDKRUV3PwNapelhvIFjQcwXU3nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRBUGTs0g8iYNKPJJl1Gs/JH5ih2jtqA2dhPx6yqnx4Tfusw9csSmZSJMtfCfcGHzx2F3jBYFOaoEDp/pepOdfVWhJybsPy7Hfg6I7Y64PgBw3MymGj1Z1m/bmmp1GK7OCyI6f3FB5HPKTe9PL+BQZbjmUNcZcZq9laylITfo+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bpnYb4H5szKHMZv;
	Sat, 26 Jul 2025 09:42:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5FA491A06D7;
	Sat, 26 Jul 2025 09:42:42 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXkxONMoRoIEsFBg--.41753S3;
	Sat, 26 Jul 2025 09:42:39 +0800 (CST)
Message-ID: <2f53f9a8-380a-4fe4-8407-03d5b4e78140@huaweicloud.com>
Date: Sat, 26 Jul 2025 09:42:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix crash on test_mb_mark_used kunit tests
To: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, linux@roeck-us.net, yi.zhang@huawei.com,
 libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250725021654.3188798-1-yi.zhang@huaweicloud.com>
 <av5necgeitkiormvqsh75kvgq3arjwxxqxpqievulgz2rvi3dg@75hdi2ubarmr>
 <20250725131541.GA184259@mit.edu>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250725131541.GA184259@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXkxONMoRoIEsFBg--.41753S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1xAr15KrWDKrW5KF4Durg_yoW5tFW3pa
	y7W3WYkFWkKF4xuaykuw48uFyaya95Ar1UCr9xW34UA3yvgry0gF1Sya1YvFn0grZYgF1j
	vF42yrWrG3WDAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/7/25 21:15, Theodore Ts'o wrote:
> On Fri, Jul 25, 2025 at 01:06:18PM +0200, Jan Kara wrote:
>>> This patch applies to the kernel that has only merged bbe11dd13a3f
>>> ("ext4: fix largest free orders lists corruption on mb_optimize_scan
>>> switch"), but not merged 458bfb991155 ("ext4: convert free groups order
>>> lists to xarrays").
>>
>> Hum, I think it would be best to just squash this into bbe11dd13a3f and
>> then just rebase & squash the other unittest fixup to the final commit when
>> we have to rebase anyway. Because otherwise backports to stable kernel will
>> quickly become rather messy.
> 
> What I ended up doing was to add a squashed combination of these two
> commits and dropped it in before the block allocation scalabiltity
> with the following commit description:
> 
>     ext4: initialize superblock fields in the kballoc-test.c kunit tests
>     
>     Various changes in the "ext4: better scalability for ext4 block
>     allocation" patch series have resulted in kunit test failures, most
>     notably in the test_new_blocks_simple and the test_mb_mark_used tests.
>     The root cause of these failures is that various in-memory ext4 data
>     structures were not getting initialized, and while previous versions
>     of the functions exercised by the unit tests didn't use these
>     structure members, this was arguably a test bug.
>     
>     Since one of the patches in the block allocation scalability patches
>     is a fix which is has a cc:stable tag, this commit also has a
>     cc:stable tag.
>     
>     CC: stable@vger.kernel.org
>     Link: https://lore.kernel.org/r/20250714130327.1830534-1-libaokun1@huawei.com
>     Link: https://patch.msgid.link/20250725021550.3177573-1-yi.zhang@huaweicloud.com
>     Link: https://patch.msgid.link/20250725021654.3188798-1-yi.zhang@huaweicloud.com
>     Reported-by: Guenter Roeck <linux@roeck-us.net>
>     Closes: https://lore.kernel.org/linux-ext4/b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net/
>     Tested-by: Guenter Roeck <linux@roeck-us.net>
>     Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> Then in the commit "ext4: convert free groups order lists to xarrays"
> which removed list_head, I modified it to remove the linked list
> initialization from mballoc-test.c, since that's the commit which
> removed those structures.
> 

Thank you for revising this series. This way, it will be less likely
to miss this fix when merging into the LTS branch.

> In the future, we should try to make sure that when we modify data
> structures to add or remove struct elements, that we also make sure
> that kunit test should also be updated.

Yes, currently in the Kunit tests, the initialization and maintenance
of data structures are too fragmented and fragile, making it easy to
overlook during modifications. In the future, I think we should provide
some general interfaces to handle the initialization and
deinitialization of those data structures.

> To that end, I've updated the
> kbuild script[1] in xfstests-bld repo so that "kbuild --test" will run
> the Kunit tests.  Hopefully reducing the friction for running tests
> will encourage more kunit tests to be created and so they will kept
> under regular maintenance.
> 
> [1] https://github.com/tytso/xfstests-bld/blob/master/kernel-build/kbuild
> 

That would be great! Then we won't miss Kunit tests again, and it
will also make those tests more useful. :-)

Best Regards,
Yi.


