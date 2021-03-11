Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC7B336BCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 06:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCKF57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 00:57:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61432 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229684AbhCKF56 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 00:57:58 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12B5ciPx013765;
        Thu, 11 Mar 2021 00:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5Z5sjaq/iiYvSnzuxuu/J+RJmXgr9rlV3ccwYQ3seTc=;
 b=GbjdYo6Djz+CNVXGV0gw80iHx8eCfQ/lrs5XpM312ayjh0+gU18bVFhsDZQ3lxIGhYs4
 NKgJfRc6qZ+r+ASbQrgUFmTIPrivvWtRYdF2sRWD3e8VBSWjwZQVeOND8ylAKXlAOpMW
 i85GFgwYw7TEk3EZP16WHTv1k97CoGT0OcQvFKtQiI9vI9q4t+owsTHpiEZFwOdtUqXG
 BH0xYURlAMy3hDMBYKYeB8afCeXIsayvgZUG9YzTN1CIgXK4u1bKPqCpul2jcO3uRBMR
 5le4ZwTIdOaBBZufi/g2eISzravr88uOEAvWnQS2vy2eFj6uyx8a0HJt5YOXV1rNhmj/ XQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774kyv5x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 00:57:55 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12B5mEpY011099;
        Thu, 11 Mar 2021 05:57:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 376mb0s34h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 05:57:53 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12B5vaBf25755992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 05:57:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6CCD4C046;
        Thu, 11 Mar 2021 05:57:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D52F24C04E;
        Thu, 11 Mar 2021 05:57:50 +0000 (GMT)
Received: from [9.199.38.114] (unknown [9.199.38.114])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Mar 2021 05:57:50 +0000 (GMT)
Subject: Re: [PATCH] iomap: Fix negative assignment to unsigned sis->pages in
 iomap_swapfile_activate
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, anju@linux.vnet.ibm.com
References: <b39319ab99d9c5541b2cdc172a4b25f39cbaad50.1614838615.git.riteshh@linux.ibm.com>
 <20210304172631.GD7267@magnolia>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <56a8a746-8716-701e-11a1-aa8d6af726c1@linux.ibm.com>
Date:   Thu, 11 Mar 2021 11:27:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210304172631.GD7267@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_01:2021-03-10,2021-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103110031
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/4/21 10:56 PM, Darrick J. Wong wrote:
> On Thu, Mar 04, 2021 at 11:51:26AM +0530, Ritesh Harjani wrote:
>> In case if isi.nr_pages is 0, we are making sis->pages (which is
>> unsigned int) a huge value in iomap_swapfile_activate() by assigning -1.
>> This could cause a kernel crash in kernel v4.18 (with below signature).
>> Or could lead to unknown issues on latest kernel if the fake big swap gets
>> used.
>>
>> Fix this issue by returning -EINVAL in case of nr_pages is 0, since it
>> is anyway a invalid swapfile. Looks like this issue will be hit when
>> we have pagesize < blocksize type of configuration.
>>
>> I was able to hit the issue in case of a tiny swap file with below
>> test script.
>> https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/scripts/swap-issue.sh
> 
> Can you turn this into a dangerous-group fstest, please?

Yes, I am already on it.

> 
>> kernel crash analysis on v4.18
>> ==============================
>> On v4.18 kernel, it causes a kernel panic, since sis->pages becomes
>> a huge value and isi.nr_extents is 0. When 0 is returned it is
>> considered as a swapfile over NFS and SWP_FILE is set (sis->flags |= SWP_FILE).
>> Then when swapoff was getting called it was calling a_ops->swap_deactivate()
>> if (sis->flags & SWP_FILE) is true. Since a_ops->swap_deactivate() is
>> NULL in case of XFS, it causes below panic.
> 
> Does the same reasoning apply to upstream?

Tested this on upstream. It causes a kernel crash with below signature.



[  186.061504] __swap_info_get: Bad swap offset entry 00000003
[  186.061635] __swap_info_get: Bad swap offset entry 00000043
[  186.061724] __swap_info_get: Bad swap offset entry 00000003
[  186.068492] __swap_info_get: Bad swap offset entry 00000001
[  186.071704] __swap_info_get: Bad swap offset entry 00000043
<...>
[  453.756321] Faulting instruction address: 0xc0000000005b6c50
cpu 0x6: Vector: 300 (Data Access) at [c00000002a8b6f80]
     pc: c0000000005b6c50: __mark_inode_dirty+0x40/0x870
     lr: c0000000006435b0: iomap_set_page_dirty+0x170/0x1b0
     sp: c00000002a8b7220
    msr: 8000000000009033
    dar: 28
  dsisr: 40000000
   current = 0xc00000000c839800
   paca    = 0xc00000003fff7800   irqmask: 0x03   irq_happened: 0x01
     pid   = 4635, comm = stress
Linux version 5.12.0-rc1-00021-g23cdd4c7150 (riteshh@ltctulc6a-p1) (gcc 
(Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu) 
2.30) #64 SMP Wed Mar 10 23:35:37 CST 2021
enter ? for help
[c00000002a8b7280] c0000000006435b0 iomap_set_page_dirty+0x170/0x1b0
[c00000002a8b72b0] c0000000004d1f1c swap_set_page_dirty+0xec/0x140
[c00000002a8b72e0] c000000000427e94 set_page_dirty+0x1b4/0x2d0
[c00000002a8b7310] c0000000004d3458 add_to_swap+0x178/0x1d0
[c00000002a8b7350] c000000000444238 shrink_page_list+0xe78/0x2120
[c00000002a8b7450] c000000000447580 shrink_inactive_list+0x2b0/0x640
[c00000002a8b7530] c000000000448b80 shrink_lruvec+0x710/0x7b0
[c00000002a8b7660] c0000000004491a4 shrink_node+0x584/0x8e0
[c00000002a8b7720] c0000000004497f8 do_try_to_free_pages+0x2f8/0x5d0
[c00000002a8b77d0] c00000000044bdac try_to_free_pages+0x29c/0x440
[c00000002a8b78a0] c0000000004c4bec 
__alloc_pages_slowpath.constprop.86+0x66c/0x11e0
[c00000002a8b7a70] c0000000004c5a7c __alloc_pages_nodemask+0x31c/0x500
[c00000002a8b7b00] c0000000004f2724 alloc_pages_vma+0x2b4/0x320
[c00000002a8b7b70] c00000000048d2c4 __handle_mm_fault+0xb54/0x1810
[c00000002a8b7ca0] c00000000048e2d0 handle_mm_fault+0x350/0x4c0
[c00000002a8b7d00] c00000000009c354 ___do_page_fault+0x9a4/0xd30
[c00000002a8b7db0] c00000000009c714 __do_page_fault+0x34/0x90
[c00000002a8b7de0] c0000000000a5c48 do_hash_fault+0x48/0x90
[c00000002a8b7e10] c000000000008994 data_access_common_virt+0x194/0x1f0





> 
>> Panic signature on v4.18 kernel:
>> =======================================
>> root@qemu:/home/qemu# [ 8291.723351] XFS (loop2): Unmounting Filesystem
>> [ 8292.123104] XFS (loop2): Mounting V5 Filesystem
>> [ 8292.132451] XFS (loop2): Ending clean mount
>> [ 8292.263362] Adding 4294967232k swap on /mnt1/test/swapfile.  Priority:-2 extents:1 across:274877906880k
>> [ 8292.277834] Unable to handle kernel paging request for instruction fetch
>> [ 8292.278677] Faulting instruction address: 0x00000000
>> cpu 0x19: Vector: 400 (Instruction Access) at [c0000009dd5b7ad0]
>>      pc: 0000000000000000
>>      lr: c0000000003eb9dc: destroy_swap_extents+0xfc/0x120
>>      sp: c0000009dd5b7d50
>>     msr: 8000000040009033
>>    current = 0xc0000009b6710080
>>    paca    = 0xc00000003ffcb280   irqmask: 0x03   irq_happened: 0x01
>>      pid   = 5604, comm = swapoff
>> Linux version 4.18.0 (riteshh@xxxxxxx) (gcc version 8.4.0 (Ubuntu 8.4.0-1ubuntu1~18.04)) #57 SMP Wed Mar 3 01:33:04 CST 2021
>> enter ? for help
>> [link register   ] c0000000003eb9dc destroy_swap_extents+0xfc/0x120
>> [c0000009dd5b7d50] c0000000025a7058 proc_poll_event+0x0/0x4 (unreliable)
>> [c0000009dd5b7da0] c0000000003f0498 sys_swapoff+0x3f8/0x910
>> [c0000009dd5b7e30] c00000000000bbe4 system_call+0x5c/0x70
>> --- Exception: c01 (System Call) at 00007ffff7d208d8
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   fs/iomap/swapfile.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
>> index a648dbf6991e..67953678c99f 100644
>> --- a/fs/iomap/swapfile.c
>> +++ b/fs/iomap/swapfile.c
>> @@ -170,6 +170,15 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
>>   			return ret;
>>   	}
>>
>> +	/*
>> +	 * In case if nr_pages is 0 then we better return -EINVAL
>> +	 * since it is anyway an empty swapfile.
>> +	 */
>> +	if (isi.nr_pages == 0) {
>> +		pr_warn("swapon: Empty swap-file\n");
> 
> The swapfile might not be empty, it's just that we couldn't find even a
> single page's worth of contiguous space in the whole file.  I would
> suggest:
> 
> 	/*
> 	 * If this swapfile doesn't contain even a single page-aligned
> 	 * contiguous range of blocks, reject this useless swapfile to
> 	 * prevent confusion later on.
> 	 */
> 	if (isi.nr_pages == 0) {
> 		pr_warn("swapon: Cannot find a single usable page in file.\n");
> 		return -EINVAL;
> 	}
> 
> --D

Sure. I will update it with above comments and resend a v2.
Will also update the status of latest kernel crash signature in the 
commit msg in v2.

-ritesh
