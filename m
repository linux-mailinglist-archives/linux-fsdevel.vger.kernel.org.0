Return-Path: <linux-fsdevel+bounces-53087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A643AE9EB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B18A188C00F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C462E613C;
	Thu, 26 Jun 2025 13:26:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA28228C2A4;
	Thu, 26 Jun 2025 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944409; cv=none; b=Fss7sSA1Lfv8ELMZAYACxDaprK8ynahRwJQaCOFkilMTIjGvYgslQ2/wVqozMgjN2dsjfH9jdpslT9BrgpTlxTnlDzJN7fj3vvhblnJK78MMkO165kDWl5GR+HfgVsh/hSVCEypB3oDJzXUoFXbe9EUK0oKAx5c2VygZfUneyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944409; c=relaxed/simple;
	bh=CyGDrpe8GEkycTL+oKVy2btEr37SdqQ/tvF8UAO4HPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpvYviNQg6dtQ0aKGnpdIn+q3vYjzvqXCwWRiqDZRVCHylupP0e6EqaXNr6z74tJ5cffKfLJn0etBWTNQn1W3jkbn0NhqByTct2257NlzelivXgsyHk0xIdwpjUSptl2Q+zy5nKeKpsDw4PmNmiu6+8I0JQ46AbBIvpEbnwR1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bSfbn18bQzYQtpD;
	Thu, 26 Jun 2025 21:26:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0DFE71A1924;
	Thu, 26 Jun 2025 21:26:44 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCH61+SSl1o4cnhQg--.25153S3;
	Thu, 26 Jun 2025 21:26:43 +0800 (CST)
Message-ID: <94de227e-23c1-4089-b99c-e8fc0beae5da@huaweicloud.com>
Date: Thu, 26 Jun 2025 21:26:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] ext4: enable large folio for regular file
To: "D, Suneeth" <Suneeth.D@amd.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-9-yi.zhang@huaweicloud.com>
 <f59ef632-0d11-4ae7-bdad-d552fe1f1d78@amd.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <f59ef632-0d11-4ae7-bdad-d552fe1f1d78@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH61+SSl1o4cnhQg--.25153S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Zw1DAr4rAr4xAFW5Cr1kAFb_yoWDCFy3pr
	1rJryUJryUAr1kGr18tr15JryUJr1UJw1UJry5JF1UAr1UJF10qr1UXr1jgF4UJr4kJr1U
	Xr1UJry7Z347ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hello Suneeth D!

On 2025/6/26 19:29, D, Suneeth wrote:
> 
> Hello Zhang Yi,
> 
> On 5/12/2025 12:03 PM, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Besides fsverity, fscrypt, and the data=journal mode, ext4 now supports
>> large folios for regular files. Enable this feature by default. However,
>> since we cannot change the folio order limitation of mappings on active
>> inodes, setting the journal=data mode via ioctl on an active inode will
>> not take immediate effect in non-delalloc mode.
>>
> 
> We run lmbench3 as part of our Weekly CI for the purpose of Kernel Performance Regression testing between a stable vs rc kernel. We noticed a regression on the kernels starting from 6.16-rc1 all the way through 6.16-rc3 in the range of 8-12%. Further bisection b/w 6.15 and 6.16-rc1 pointed me to the first bad commit as 7ac67301e82f02b77a5c8e7377a1f414ef108b84. The following were the machine configurations and test parameters used:-
> 
> Model name:           AMD EPYC 9754 128-Core Processor [Bergamo]
> Thread(s) per core:   2
> Core(s) per socket:   128
> Socket(s):            1
> Total online memory:  258G
> 
> micro-benchmark_variant: "lmbench3-development-1-0-MMAP-50%" which has the following parameters,
> 
> -> nr_thread:     1
> -> memory_size: 50%
> -> mode:     development
> -> test:        MMAP
> 
> The following are the stats after bisection:-
> 
> (the KPI used here is lmbench3.MMAP.read.latency.us)
> 
> v6.15 -                         97.3K
> 
> v6.16-rc1 -                         107.5K
> 
> v6.16-rc3 -                         107.4K
> 
> 6.15.0-rc4badcommit -                     103.5K
> 
> 6.15.0-rc4badcommit_m1 (one commit before bad-commit) - 94.2K

Thanks for the report, I will try to reproduce this performance regression on
my machine and find out what caused this regression.

Thanks,
Yi.

> 
> I also ran the micro-benchmark with tools/testing/perf record and following is the output from tools/testing/perf diff b/w the bad commit and just one commit before that.
> 
> # ./perf diff perf.data.old  perf.data
> No kallsyms or vmlinux with build-id da8042fb274c5e3524318e5e3afbeeef5df2055e was found
> # Event 'cycles:P'
> #
> # Baseline  Delta Abs  Shared Object            Symbol
> 
>            >
> # ........  .........  ....................... ....................................................................................................................................................................................>
> #
>                +4.34%  [kernel.kallsyms]        [k] __lruvec_stat_mod_folio
>                +3.41%  [kernel.kallsyms]        [k] unmap_page_range
>                +3.33%  [kernel.kallsyms]        [k] __mod_memcg_lruvec_state
>                +2.04%  [kernel.kallsyms]        [k] srso_alias_return_thunk
>                +2.02%  [kernel.kallsyms]        [k] srso_alias_safe_ret
>     22.22%     -1.78%  bw_mmap_rd               [.] bread
>                +1.76%  [kernel.kallsyms]        [k] __handle_mm_fault
>                +1.70%  [kernel.kallsyms]        [k] filemap_map_pages
>                +1.58%  [kernel.kallsyms]        [k] set_pte_range
>                +1.58%  [kernel.kallsyms]        [k] next_uptodate_folio
>                +1.33%  [kernel.kallsyms]        [k] do_anonymous_page
>                +1.01%  [kernel.kallsyms]        [k] get_page_from_freelist
>                +0.98%  [kernel.kallsyms]        [k] __mem_cgroup_charge
>                +0.85%  [kernel.kallsyms]        [k] asm_exc_page_fault
>                +0.82%  [kernel.kallsyms]        [k] native_irq_return_iret
>                +0.82%  [kernel.kallsyms]        [k] do_user_addr_fault
>                +0.77%  [kernel.kallsyms]        [k] clear_page_erms
>                +0.75%  [kernel.kallsyms]        [k] handle_mm_fault
>                +0.73%  [kernel.kallsyms]        [k] set_ptes.isra.0
>                +0.70%  [kernel.kallsyms]        [k] lru_add
>                +0.69%  [kernel.kallsyms]        [k] folio_add_file_rmap_ptes
>                +0.68%  [kernel.kallsyms]        [k] folio_remove_rmap_ptes
>     12.45%     -0.65%  line                     [.] mem_benchmark_0
>                +0.64%  [kernel.kallsyms]        [k] __alloc_frozen_pages_noprof
>                +0.63%  [kernel.kallsyms]        [k] vm_normal_page
>                +0.63%  [kernel.kallsyms]        [k] free_pages_and_swap_cache
>                +0.63%  [kernel.kallsyms]        [k] lock_vma_under_rcu
>                +0.60%  [kernel.kallsyms]        [k] __rcu_read_unlock
>                +0.59%  [kernel.kallsyms]        [k] cgroup_rstat_updated
>                +0.57%  [kernel.kallsyms]        [k] get_mem_cgroup_from_mm
>                +0.52%  [kernel.kallsyms]        [k] __mod_lruvec_state
>                +0.51%  [kernel.kallsyms]        [k] exc_page_fault
> 
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>   fs/ext4/ext4.h      |  1 +
>>   fs/ext4/ext4_jbd2.c |  3 ++-
>>   fs/ext4/ialloc.c    |  3 +++
>>   fs/ext4/inode.c     | 20 ++++++++++++++++++++
>>   4 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 5a20e9cd7184..2fad90c30493 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -2993,6 +2993,7 @@ int ext4_walk_page_buffers(handle_t *handle,
>>                        struct buffer_head *bh));
>>   int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>>                   struct buffer_head *bh);
>> +bool ext4_should_enable_large_folio(struct inode *inode);
>>   #define FALL_BACK_TO_NONDELALLOC 1
>>   #define CONVERT_INLINE_DATA     2
>>   diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
>> index 135e278c832e..b3e9b7bd7978 100644
>> --- a/fs/ext4/ext4_jbd2.c
>> +++ b/fs/ext4/ext4_jbd2.c
>> @@ -16,7 +16,8 @@ int ext4_inode_journal_mode(struct inode *inode)
>>           ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
>>           test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
>>           (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
>> -        !test_opt(inode->i_sb, DELALLOC))) {
>> +        !test_opt(inode->i_sb, DELALLOC) &&
>> +        !mapping_large_folio_support(inode->i_mapping))) {
>>           /* We do not support data journalling for encrypted data */
>>           if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
>>               return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
>> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
>> index e7ecc7c8a729..4938e78cbadc 100644
>> --- a/fs/ext4/ialloc.c
>> +++ b/fs/ext4/ialloc.c
>> @@ -1336,6 +1336,9 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>>           }
>>       }
>>   +    if (ext4_should_enable_large_folio(inode))
>> +        mapping_set_large_folios(inode->i_mapping);
>> +
>>       ext4_update_inode_fsync_trans(handle, inode, 1);
>>         err = ext4_mark_inode_dirty(handle, inode);
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 29eccdf8315a..7fd3921cfe46 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4774,6 +4774,23 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
>>       return -EFSCORRUPTED;
>>   }
>>   +bool ext4_should_enable_large_folio(struct inode *inode)
>> +{
>> +    struct super_block *sb = inode->i_sb;
>> +
>> +    if (!S_ISREG(inode->i_mode))
>> +        return false;
>> +    if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
>> +        ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
>> +        return false;
>> +    if (ext4_has_feature_verity(sb))
>> +        return false;
>> +    if (ext4_has_feature_encrypt(sb))
>> +        return false;
>> +
>> +    return true;
>> +}
>> +
>>   struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>>                 ext4_iget_flags flags, const char *function,
>>                 unsigned int line)
>> @@ -5096,6 +5113,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>>           ret = -EFSCORRUPTED;
>>           goto bad_inode;
>>       }
>> +    if (ext4_should_enable_large_folio(inode))
>> +        mapping_set_large_folios(inode->i_mapping);
>> +
>>       ret = check_igot_inode(inode, flags, function, line);
>>       /*
>>        * -ESTALE here means there is nothing inherently wrong with the inode,
> 
> ---
> Thanks and Regards,
> Suneeth D


