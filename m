Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148DC24E71E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgHVLe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 07:34:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbgHVLe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 07:34:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07MBXEwI005639;
        Sat, 22 Aug 2020 07:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=tOcXy4AzQuL9Qo4u7ZepORRtUTr9o6FF4+jnIrdHYok=;
 b=ps7Ws0329FtS7qUJNTl5g1cQOPSFThZdb7s/O3f2PD7XHYpAPqbQd6TVLLTT8it4uXjI
 Oeu1zp0VviMTYW5bKm6ji8339B6tOI33QlZZkIKSOi1xBkCz/7SQU5zk4dg57STO0daf
 4qt1jHZfxxiI/axgj2WoosOFGfAmoZSn94HMzcVcpHVfwM0yK8PE7fnIGF6CG4uYkO6v
 Uk7oEs0LW7CBMb/xuJPOFgSa9f91TBfuvnBepk2B4PLCDn0Vm+QFjAHGOyC7wzlyVc1o
 GTsNmPtAtgnhpcdMbdV9D4cnzs5yp5Ek3jztwIvxYyeCes83WZPwGtP49SBc0k6c0fn4 JA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 332xnpuny7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Aug 2020 07:34:50 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07MBVRgK026871;
        Sat, 22 Aug 2020 11:34:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 332ujkrb5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Aug 2020 11:34:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07MBYjGN30212422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Aug 2020 11:34:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 698FB52051;
        Sat, 22 Aug 2020 11:34:45 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.217])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 03B775204E;
        Sat, 22 Aug 2020 11:34:43 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu,
        Dan Williams <dan.j.williams@intel.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 0/3] Optimize ext4 DAX overwrites
Date:   Sat, 22 Aug 2020 17:04:34 +0530
Message-Id: <cover.1598094830.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-22_07:2020-08-21,2020-08-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=821 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008220125
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

RFC -> v2
1. Addressed comments from Jan.
2. Added xfstests results in cover letter.

In case of dax writes, currently we start a journal txn irrespective of whether
it's an overwrite or not. In case of an overwrite we don't need to start a
jbd2 txn since the blocks are already allocated.
So this patch optimizes away the txn start in case of DAX overwrites.
This could significantly boost performance for multi-threaded writes
specially random writes (overwrite).
Fio script used to collect perf numbers is mentioned below.

Below numbers were calculated on a QEMU setup on ppc64 box with simulated
pmem device. 

Didn't observe any new failures with this patch in xfstests "-g quick,dax"

Performance numbers with different threads - (~10x improvement)
==========================================

vanilla_kernel(kIOPS) (randomwrite)
 60 +-+------+-------+--------+--------+--------+-------+------+-+   
     |        +       +        +        +**      +       +        |   
  55 +-+                                 **                     +-+   
     |                          **       **                       |   
     |                          **       **                       |   
  50 +-+                        **       **                     +-+   
     |                          **       **                       |   
  45 +-+                        **       **                     +-+   
     |                          **       **                       |   
     |                          **       **                       |   
  40 +-+                        **       **                     +-+   
     |                          **       **                       |   
  35 +-+               **       **       **                     +-+   
     |                 **       **       **               **      |   
     |                 **       **       **      **       **      |   
  30 +-+      **       **       **       **      **       **    +-+   
     |        **      +**      +**      +**      **      +**      |   
  25 +-+------**------+**------+**------+**------**------+**----+-+   
              1       2        4        8       12      16            
                                     Threads                                   
patched_kernel(kIOPS) (randomwrite)
  600 +-+-----+--------+--------+-------+--------+-------+------+-+   
      |       +        +        +       +        +       +**      |   
      |                                                   **      |   
  500 +-+                                                 **    +-+   
      |                                                   **      |   
      |                                           **      **      |   
  400 +-+                                         **      **    +-+   
      |                                           **      **      |   
  300 +-+                                **       **      **    +-+   
      |                                  **       **      **      |   
      |                                  **       **      **      |   
  200 +-+                                **       **      **    +-+   
      |                         **       **       **      **      |   
      |                         **       **       **      **      |   
  100 +-+               **      **       **       **      **    +-+   
      |                 **      **       **       **      **      |   
      |       +**      +**      **      +**      +**     +**      |   
    0 +-+-----+**------+**------**------+**------+**-----+**----+-+   
              1        2        4       8       12      16            
                                    Threads                                   
fio script
==========
[global]
rw=randwrite
norandommap=1
invalidate=0
bs=4k
numjobs=16 		--> changed this for different thread options
time_based=1
ramp_time=30
runtime=60
group_reporting=1
ioengine=psync
direct=1
size=16G
filename=file1.0.0:file1.0.1:file1.0.2:file1.0.3:file1.0.4:file1.0.5:file1.0.6:file1.0.7:file1.0.8:file1.0.9:file1.0.10:file1.0.11:file1.0.12:file1.0.13:file1.0.14:file1.0.15:file1.0.16:file1.0.17:file1.0.18:file1.0.19:file1.0.20:file1.0.21:file1.0.22:file1.0.23:file1.0.24:file1.0.25:file1.0.26:file1.0.27:file1.0.28:file1.0.29:file1.0.30:file1.0.31
file_service_type=random
nrfiles=32
directory=/mnt/

[name]
directory=/mnt/
direct=1

NOTE:
======
1. Looking at ~10x perf delta, I probed a bit deeper to understand what's causing
this scalability problem. It seems when we are starting a jbd2 txn then slab
alloc code is observing some serious contention around spinlock.

Even though the spinlock contention could be related to some other
issue (looking into it internally). But I could still see the perf improvement
of close to ~2x on QEMU setup on x86 with simulated pmem device with the
patched_kernel v/s vanilla_kernel with same fio workload.

perf report from vanilla_kernel (this is not seen with patched kernel) (ppc64)
=======================================================================

  47.86%  fio              [kernel.vmlinux]            [k] do_raw_spin_lock
             |
             ---do_raw_spin_lock
                |
                |--19.43%--_raw_spin_lock
                |          |
                |           --19.31%--0
                |                     |
                |                     |--9.77%--deactivate_slab.isra.61
                |                     |          ___slab_alloc
                |                     |          __slab_alloc
                |                     |          kmem_cache_alloc
                |                     |          jbd2__journal_start
                |                     |          __ext4_journal_start_sb
<...>

2. This problem was reported by Dan Williams at [1]

Links
======
[1]: https://lore.kernel.org/linux-ext4/20190802144304.GP25064@quack2.suse.cz/T/

Ritesh Harjani (3):
  ext4: Refactor ext4_overwrite_io() to take ext4_map_blocks as argument
  ext4: Extend ext4_overwrite_io() for dax path
  ext4: Optimize ext4 DAX overwrites

 fs/ext4/ext4.h  |  2 ++
 fs/ext4/file.c  | 28 ++++++++++++++++++----------
 fs/ext4/inode.c | 11 +++++++++--
 3 files changed, 29 insertions(+), 12 deletions(-)

-- 
2.25.4

