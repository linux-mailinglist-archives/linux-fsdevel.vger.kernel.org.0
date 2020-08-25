Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773AC2518AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 14:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgHYMhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 08:37:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60682 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726374AbgHYMhQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:37:16 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PCXm25037207;
        Tue, 25 Aug 2020 08:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=wVyG37sejAuGZH8iqPCXOVAlO+CpTvU/uUL/nBXgU8M=;
 b=q+7d0oKeKn6NPfHpT/vbefOl8r6RERE9un9wZxOgxm8J7A8Z8xpuLJhMRAoXSUOBd6BB
 TI6eM2pSBqZ87BJPLz9IcNAHePQOY98v6wGzoQGFUMTfEcy96E4QKk39zZepnTXnLSPh
 lzAxVTyM3bNsEMidKNhVwIbe1ZyqXe0NEd1xqR7YbGAtMo863i0XRvrfAk1GIbj1Aybh
 tBk1s8Ed2Y5sqzF49/KaIuLZsNJDmQ5UEv9NqPhGxmZsScxRWSO+o1KjQvQQeTa0WHv3
 LrOS0b+imEpLYYRobAyMa5kv2nVrHYo0K9q3i2I8Gqxklf3bRycs76piZ8M/ivPvZ/Of GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334yt64t59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 08:37:09 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07PCZwv8043492;
        Tue, 25 Aug 2020 08:37:08 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334yt64syr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 08:37:08 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07PCRlqU018400;
        Tue, 25 Aug 2020 12:36:53 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 332ujkue5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 12:36:53 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07PCZL2466519352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 12:35:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70DF2AE056;
        Tue, 25 Aug 2020 12:36:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AA34AE045;
        Tue, 25 Aug 2020 12:36:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.157])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 12:36:50 +0000 (GMT)
Subject: Re: [PATCH] iomap: iomap_bmap should accept unwritten maps
To:     Yuxuan Shui <yshuiv7@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
References: <20200505183608.10280-1-yshuiv7@gmail.com>
 <20200505193049.GC5694@magnolia>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 25 Aug 2020 18:06:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200505193049.GC5694@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200825123650.3AA34AE045@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_03:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250092
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/6/20 1:00 AM, Darrick J. Wong wrote:
> On Tue, May 05, 2020 at 07:36:08PM +0100, Yuxuan Shui wrote:
>> commit ac58e4fb03f9d111d733a4ad379d06eef3a24705 moved ext4_bmap from
>> generic_block_bmap to iomap_bmap, this introduced a regression which
>> prevents some user from using previously working swapfiles. The kernel
>> will complain about holes while there is none.
>>
>> What is happening here is that the swapfile has unwritten mappings,
>> which is rejected by iomap_bmap, but was accepted by ext4_get_block.
> 
> ...which is why ext4 ought to use iomap_swapfile_activate.

I tested this patch (diff below), which seems to be working fine for me
for straight forward use case of swapon/swapoff on ext4.
Could you give it a try?

<log showing ext4_iomap_swap_activate path kicking in>
swapon  1283 [000]   438.651028:     250000 cpu-clock:pppH:
	ffffffff817f7f56 percpu_counter_add_batch+0x26 (/boot/vmlinux)
	ffffffff813a61d0 ext4_es_lookup_extent+0x1d0 (/boot/vmlinux)
	ffffffff813b8095 ext4_map_blocks+0x65 (/boot/vmlinux)
	ffffffff813b8d4b ext4_iomap_begin_report+0x10b (/boot/vmlinux)
	ffffffff81367f58 iomap_apply+0xa8 (/boot/vmlinux)
	ffffffff8136d1c3 iomap_swapfile_activate+0xb3 (/boot/vmlinux)
	ffffffff813b51a5 ext4_iomap_swap_activate+0x15 (/boot/vmlinux)
	ffffffff812a3a27 __do_sys_swapon+0xb37 (/boot/vmlinux)
	ffffffff812a40f6 __x64_sys_swapon+0x16 (/boot/vmlinux)
	ffffffff820b760a do_syscall_64+0x5a (/boot/vmlinux)
	ffffffff8220007c entry_SYSCALL_64+0x7c (/boot/vmlinux)
	    7ffff7de68bb swapon+0xb (/usr/lib/x86_64-linux-gnu/libc-2.30.so)
	66706177732f756d [unknown] ([unknown])

<shows that swapfile(which I setup using fallocate) has some used bytes>
$ swapon -s
Filename                                Type            Size    Used 
Priority
/home/qemu/swapfile-test                file            2097148 42312   -2


@Jan/Ted/Darrick,

I am not that familiar with how swap subsystem works.
So, is there anything else you feel is required apart from below changes
for supporting swap_activate via iomap? I did test both swapon/swapoff
and see that swap is getting used up on ext4 with delalloc mount opt.

As I see from code, iomap_swapfile_activate is mainly looking for
extent mapping information of that file to pass to swap subsystem.
And IIUC, "ext4_iomap_report_ops" is meant exactly for that.
Same as how we use it in ext4_fiemap().


diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6eae17758ece..1e390157541d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3614,6 +3614,13 @@ static int ext4_set_page_dirty(struct page *page)
  	return __set_page_dirty_buffers(page);
  }

+static int ext4_iomap_swap_activate(struct swap_info_struct *sis,
+				    struct file *file, sector_t *span)
+{
+	return iomap_swapfile_activate(sis, file, span,
+				       &ext4_iomap_report_ops);
+}
+
  static const struct address_space_operations ext4_aops = {
  	.readpage		= ext4_readpage,
  	.readahead		= ext4_readahead,
@@ -3629,6 +3636,7 @@ static const struct address_space_operations 
ext4_aops = {
  	.migratepage		= buffer_migrate_page,
  	.is_partially_uptodate  = block_is_partially_uptodate,
  	.error_remove_page	= generic_error_remove_page,
+	.swap_activate 		= ext4_iomap_swap_activate,
  };

  static const struct address_space_operations ext4_journalled_aops = {
@@ -3645,6 +3653,7 @@ static const struct address_space_operations 
ext4_journalled_aops = {
  	.direct_IO		= noop_direct_IO,
  	.is_partially_uptodate  = block_is_partially_uptodate,
  	.error_remove_page	= generic_error_remove_page,
+	.swap_activate 		= ext4_iomap_swap_activate,
  };

  static const struct address_space_operations ext4_da_aops = {
@@ -3662,6 +3671,7 @@ static const struct address_space_operations 
ext4_da_aops = {
  	.migratepage		= buffer_migrate_page,
  	.is_partially_uptodate  = block_is_partially_uptodate,
  	.error_remove_page	= generic_error_remove_page,
+	.swap_activate 		= ext4_iomap_swap_activate,
  };

  static const struct address_space_operations ext4_dax_aops = {
@@ -3670,6 +3680,7 @@ static const struct address_space_operations 
ext4_dax_aops = {
  	.set_page_dirty		= noop_set_page_dirty,
  	.bmap			= ext4_bmap,
  	.invalidatepage		= noop_invalidatepage,
+	.swap_activate 		= ext4_iomap_swap_activate,
  };

  void ext4_set_aops(struct inode *inode)
