Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C9326F54D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 07:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgIRFJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 01:09:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbgIRFJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:09:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08I51mRR135967;
        Fri, 18 Sep 2020 01:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=kux50PGtBlRry0m2L8U0dh/ano+EFsjjRDmFGJCo9gU=;
 b=dImclmEPrEuTF8dNosE0wSCedfuV6H2/L0dLJXzNVSMGhS0+XPNb5Ix4R3kpFfcwKHQE
 J7PMOGxOWC6Q6NRoO/zazh4i6P6TVAhz5VjBa+znUPqxsif4lWDpPNxbMUSRBuzqyYPd
 71OzAiqD553HItvT985zZQpH0tjhHNts3SOnJuWsDtdExEe8t3iUhM0rsYLgJ8Vqo2WN
 kXEcdFkgbPl+R/RXmgM7ZaCIBJm1GlyeVhdVbZJYCLGl2a8uzcBnM7z8NYOjFarU+LYQ
 7vY4fxq884rAhLKky1OoJgwtAYzRbc3Elm7Y2d/aBhHmzYyKY8N7/ne6TschxNrwctQt 4Q== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33mn791n1h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 01:09:00 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08I4vXEx019953;
        Fri, 18 Sep 2020 05:06:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 33k6f2hemn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 05:06:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08I56dRh28639632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 05:06:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3F85A405F;
        Fri, 18 Sep 2020 05:06:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 447FBA405C;
        Fri, 18 Sep 2020 05:06:38 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.45.180])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Sep 2020 05:06:38 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, dan.j.williams@intel.com,
        anju@linux.vnet.ibm.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 0/1] Optimize ext4 file overwrites - perf improvement
Date:   Fri, 18 Sep 2020 10:36:34 +0530
Message-Id: <cover.1600401668.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_02:2020-09-16,2020-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=792
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180037
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

v2 -> v3
1. Switched to suggested approach from Jan to make the approach general
for all file writes rather than only for DAX.
(So as of now both DAX & DIO should benefit from this as both uses the same
iomap path. Although note that I only tested performance improvement for DAX)

Gave a run on xfstests with -g quick,dax and didn't observe any new
issues with this patch.

In case of file writes, currently we start a journal txn irrespective of whether
it's an overwrite or not. In case of an overwrite we don't need to start a
jbd2 txn since the blocks are already allocated.
So this patch optimizes away the txn start in case of file (DAX/DIO) overwrites.
This could significantly boost performance for multi-threaded writes
specially random writes (overwrite).
Fio script used to collect perf numbers is mentioned below.

Below numbers were calculated on a QEMU setup on ppc64 box with simulated
pmem (fsdax) device. 

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

I think that the spinlock contention problem in slab alloc path could be optimized
on PPC in general, will look into it seperately. But I could still see the
perf improvement of close to ~2x on QEMU setup on x86 with simulated pmem device
with the patched_kernel v/s vanilla_kernel with same fio workload.

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
[v2]: https://lkml.org/lkml/2020/8/22/123

Ritesh Harjani (1):
  ext4: Optimize file overwrites

 fs/ext4/inode.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

-- 
2.26.2

