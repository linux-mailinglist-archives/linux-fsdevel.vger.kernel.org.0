Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F45251EBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 20:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgHYSBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 14:01:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12622 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726158AbgHYSBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:01:01 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PHvvVm041766;
        Tue, 25 Aug 2020 14:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=QF834FreGkDHcIWyxN1Ql2/p3YIsVDE1LAH3TxBVi6g=;
 b=qAwe2DLl8i8LAakhP4OAXdxPFTzWNmXS80O4R1bbHAzqPa0TBupwJpwhkwvH+1576zUa
 R9b9GaBbquf24iUdhREx9fmN23JdkhvXrN/4jAfXJ2MzpcWQk/2P/7EEBVS/xAH/zZxb
 mMwKVBnsvLCR14UyrxNGBdQRLK7MmUv0F05JAX4++AY8dT/iNMBpXW7nDdzMtjVTeVjv
 eZizf6Od53ZeIFkSVsXKf97oJuBc5TWpQkV/gkvjHR/T+9EfGU5Eg3HKyGASn537mPip
 WfPM39HdzUT6ebNa42itrw6JQb8+RzEi3Ww0MF3RoH7oHS0VGqDjXRMpU0bQ70l+SDkY Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3357grr1d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 14:00:53 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07PHwf7E042987;
        Tue, 25 Aug 2020 14:00:53 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3357grr1ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 14:00:53 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07PHvNGp004746;
        Tue, 25 Aug 2020 18:00:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 332uk8j8n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 18:00:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07PI0nJC21627144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 18:00:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F73C11C052;
        Tue, 25 Aug 2020 18:00:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3F6011C050;
        Tue, 25 Aug 2020 18:00:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.157])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 18:00:47 +0000 (GMT)
Subject: Re: [PATCH] iomap: iomap_bmap should accept unwritten maps
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Yuxuan Shui <yshuiv7@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
References: <20200505183608.10280-1-yshuiv7@gmail.com>
 <20200505193049.GC5694@magnolia>
 <20200825123650.3AA34AE045@d06av26.portsmouth.uk.ibm.com>
 <20200825154933.GF6090@magnolia>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 25 Aug 2020 23:30:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200825154933.GF6090@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200825180047.A3F6011C050@d06av25.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_08:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250129
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/25/20 9:19 PM, Darrick J. Wong wrote:
> On Tue, Aug 25, 2020 at 06:06:49PM +0530, Ritesh Harjani wrote:
>>
>>
>> On 5/6/20 1:00 AM, Darrick J. Wong wrote:
>>> On Tue, May 05, 2020 at 07:36:08PM +0100, Yuxuan Shui wrote:
>>>> commit ac58e4fb03f9d111d733a4ad379d06eef3a24705 moved ext4_bmap from
>>>> generic_block_bmap to iomap_bmap, this introduced a regression which
>>>> prevents some user from using previously working swapfiles. The kernel
>>>> will complain about holes while there is none.
>>>>
>>>> What is happening here is that the swapfile has unwritten mappings,
>>>> which is rejected by iomap_bmap, but was accepted by ext4_get_block.
>>>
>>> ...which is why ext4 ought to use iomap_swapfile_activate.
>>
>> I tested this patch (diff below), which seems to be working fine for me
>> for straight forward use case of swapon/swapoff on ext4.
>> Could you give it a try?
>>
>> <log showing ext4_iomap_swap_activate path kicking in>
>> swapon  1283 [000]   438.651028:     250000 cpu-clock:pppH:
>> 	ffffffff817f7f56 percpu_counter_add_batch+0x26 (/boot/vmlinux)
>> 	ffffffff813a61d0 ext4_es_lookup_extent+0x1d0 (/boot/vmlinux)
>> 	ffffffff813b8095 ext4_map_blocks+0x65 (/boot/vmlinux)
>> 	ffffffff813b8d4b ext4_iomap_begin_report+0x10b (/boot/vmlinux)
>> 	ffffffff81367f58 iomap_apply+0xa8 (/boot/vmlinux)
>> 	ffffffff8136d1c3 iomap_swapfile_activate+0xb3 (/boot/vmlinux)
>> 	ffffffff813b51a5 ext4_iomap_swap_activate+0x15 (/boot/vmlinux)
>> 	ffffffff812a3a27 __do_sys_swapon+0xb37 (/boot/vmlinux)
>> 	ffffffff812a40f6 __x64_sys_swapon+0x16 (/boot/vmlinux)
>> 	ffffffff820b760a do_syscall_64+0x5a (/boot/vmlinux)
>> 	ffffffff8220007c entry_SYSCALL_64+0x7c (/boot/vmlinux)
>> 	    7ffff7de68bb swapon+0xb (/usr/lib/x86_64-linux-gnu/libc-2.30.so)
>> 	66706177732f756d [unknown] ([unknown])
>>
>> <shows that swapfile(which I setup using fallocate) has some used bytes>
>> $ swapon -s
>> Filename                                Type            Size    Used
>> Priority
>> /home/qemu/swapfile-test                file            2097148 42312   -2
>>
>>
>> @Jan/Ted/Darrick,
>>
>> I am not that familiar with how swap subsystem works.
>> So, is there anything else you feel is required apart from below changes
>> for supporting swap_activate via iomap? I did test both swapon/swapoff
>> and see that swap is getting used up on ext4 with delalloc mount opt.
>>
>> As I see from code, iomap_swapfile_activate is mainly looking for
>> extent mapping information of that file to pass to swap subsystem.
>> And IIUC, "ext4_iomap_report_ops" is meant exactly for that.
>> Same as how we use it in ext4_fiemap().
> 
> <nod> The swap code doesn't even care about the file offsets, it just
> wants the physical mappings, and it only wants to find real and
> unwritten mappings (i.e. no holes, delalloc, or shared extents).
> 
> So ... I think it's ok to use the same iomap ops as fiemap.
> 
> FWIW the xfs version uses xfs_read_iomap_ops for reads, readahead,
> fiemap, and swapfiles, so this is ... probably fine, especially if it
> passes the swap group fstests. :)
> 

Ohh yes, thanks. :)
I tested "-g swap" fstests and those were fine.
For completion sake, I will go through generic_swapfile_activate()
just to confirm that nothing is missed.
Will try and spin a formal patch early next week -(in LPC this week)

-ritesh
