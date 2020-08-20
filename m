Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0431624B90B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 13:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgHTLhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 07:37:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730790AbgHTLgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:36:48 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KB3UlD136298;
        Thu, 20 Aug 2020 07:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=k7KfW0RZAjPIFH/IRXudnl5GCxnyZfPjYnmTz1S/C5Y=;
 b=S6S/ND16urnI16ekC35Bzim6ncR9qjSNgBt1bQCUxuLhulf81CqteDAov5rK0Ni37LiP
 yV4TUjgZ93y/cbhvLuDk5ydNxpp3klztxCn6SHypliuaMi/aGQD8gPVcBT3XH82Rnzmo
 IBoj4l8qR0VJRORlP1hO6gC0qsMV2FdkoLRcTwUuYAtai32QUaS4strshSYKyEMAlem/
 OstswIVmO34E953Y+tQdVcaT1sU/7f9X50NiWUP9F/TNw2PawHNKFr+v3lBQ5FuLbgye
 okW6m/foRGI2J9iJeb9HZE0f/YDXv6yqt4zkb8urvmeVaYL1iFFfmy2/eqo9jmnfEOP8 pA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3317ab369v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 07:36:43 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07KBW3hb019650;
        Thu, 20 Aug 2020 11:36:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 330tbvsseu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 11:36:41 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07KBadUD26804618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 11:36:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17C1CA4051;
        Thu, 20 Aug 2020 11:36:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD2F5A4059;
        Thu, 20 Aug 2020 11:36:37 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Aug 2020 11:36:37 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 0/1] Optimize ext4 DAX overwrites
Date:   Thu, 20 Aug 2020 17:06:27 +0530
Message-Id: <cover.1597855360.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_02:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=825 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008200093
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In case of dax writes, currently we start a journal txn irrespective of whether
it's an overwrite or not. In case of an overwrite we don't need to start a
jbd2 txn since the blocks are already allocated.
So this patch optimizes away the txn start in case of DAX overwrites.
This could significantly boost performance for multi-threaded random write
(overwrite). Fio script used to collect perf numbers is mentioned below.

Below numbers were calculated on a QEMU setup on ppc64 box with simulated
pmem device.

Performance numbers with different threads - (~10x improvement)
==========================================

vanilla_kernel(kIOPS)
 60 +-+---------------+-------+--------+--------+--------+-------+------+-+   
     |                 +       +        +        +**      +       +        |   
  55 +-+                                          **                     +-+   
     |                                   **       **                       |   
     |                                   **       **                       |   
  50 +-+                                 **       **                     +-+   
     |                                   **       **                       |   
  45 +-+                                 **       **                     +-+   
     |                                   **       **                       |   
     |                                   **       **                       |   
  40 +-+                                 **       **                     +-+   
     |                                   **       **                       |   
  35 +-+                        **       **       **                     +-+   
     |                          **       **       **               **      |   
     |                          **       **       **      **       **      |   
  30 +-+               **       **       **       **      **       **    +-+   
     |                 **      +**      +**      +**      **      +**      |   
  25 +-+---------------**------+**------+**------+**------**------+**----+-+   
                       1       2        4        8       12      16            
                                     Threads                                   
patched_kernel(kIOPS)
  600 +-+--------------+--------+--------+-------+--------+-------+------+-+   
      |                +        +        +       +        +       +**      |   
      |                                                            **      |   
  500 +-+                                                          **    +-+   
      |                                                            **      |   
      |                                                    **      **      |   
  400 +-+                                                  **      **    +-+   
      |                                                    **      **      |   
  300 +-+                                         **       **      **    +-+   
      |                                           **       **      **      |   
      |                                           **       **      **      |   
  200 +-+                                         **       **      **    +-+   
      |                                  **       **       **      **      |   
      |                                  **       **       **      **      |   
  100 +-+                        **      **       **       **      **    +-+   
      |                          **      **       **       **      **      |   
      |                +**      +**      **      +**      +**     +**      |   
    0 +-+--------------+**------+**------**------+**------+**-----+**----+-+   
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

2. Kept this as RFC, since maybe using the ext4_iomap_overwrite_ops,
will be better here. We could check for overwrite in ext4_dax_write_iter(),
like how we do for DIO writes. Thoughts?

3. This problem was reported by Dan Williams at [1]

Links
======
[1]: https://lore.kernel.org/linux-ext4/20190802144304.GP25064@quack2.suse.cz/T/

Ritesh Harjani (1):
  ext4: Optimize ext4 DAX overwrites

 fs/ext4/ext4.h  | 1 +
 fs/ext4/file.c  | 2 +-
 fs/ext4/inode.c | 8 +++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.25.4

