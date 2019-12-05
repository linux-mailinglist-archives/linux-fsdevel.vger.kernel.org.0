Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0167C113BE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 07:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfLEGqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 01:46:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725953AbfLEGqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:46:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB56gPDM017479
        for <linux-fsdevel@vger.kernel.org>; Thu, 5 Dec 2019 01:46:34 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wpuy4j83x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 01:46:34 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 5 Dec 2019 06:46:32 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Dec 2019 06:46:29 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB56kSQJ55574718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Dec 2019 06:46:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93853A4040;
        Thu,  5 Dec 2019 06:46:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0C32A404D;
        Thu,  5 Dec 2019 06:46:26 +0000 (GMT)
Received: from dhcp-9-199-159-163.in.ibm.com (unknown [9.199.159.163])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Dec 2019 06:46:26 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com, joseph.qi@linux.alibaba.com
Subject: [PATCHv4 0/3] Fix inode_lock sequence to scale performance of DIO mixed R/W workload
Date:   Thu,  5 Dec 2019 12:16:21 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120506-4275-0000-0000-0000038B9168
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120506-4276-0000-0000-0000389F357E
Message-Id: <20191205064624.13419-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050052
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes from RFCv3 => PATCHv4
1. Dropped patch-2 which introduced ext4_ilock/iunlock API based on discussion.
Now the lock/unlock decision is open coded in ext4_dio_write_iter() &
ext4_dio_write_checks().

2. Addressed review comments from Jan on last 2 patches.

Please note that apart from all the conditions mentioned in patch-3 there is
still an existing race. It is between ext4_page_mkwrite & DIO read in parallel.
This is discussed in detail at [7].
Since that race exist even before this patch series and is not caused
due to this patch series, I plan to address that after these patches are merged.
It is to ensure proper testing/review and to not club too many things in one go.

These patches are tested again with "xfstests -g auto". There were no new
failures except the known one.


Background (copied from previous with some edits)
=================================================

These are ilock patches which helps improve the current inode lock scalabiliy
problem in ext4 DIO mixed read/write workload case. The problem was first
reported by Joseph [1]. This should help improve mixed read/write workload
cases for databases which use directIO.

These patches are based upon upstream discussion with Jan Kara & Joseph [2].

The problem really is that in case of DIO overwrites, we start with
a exclusive lock and then downgrade it later to shared lock. This causes a
scalability problem in case of mixed DIO read/write workload case. 
i.e. if we have any ongoing DIO reads and then comes a DIO writes,
(since writes starts with excl. inode lock) then it has to wait until the
shared lock is released (which only happens when DIO read is completed). 
Same is true for vice versa as well.
The same can be easily observed with perf-tools trace analysis [3].

This patch series (Patch-3) helps fix that situation even without
dioread_nolock mount opt. This is inline with the discussions with Jan [4].
More details about this are mentioned in commit msg of patch 2 & 3.

These patches are based on the top of Ted's ext4 master tree.

Patch description
=================
Patch-1: Fixes ext4_dax_read/write inode locking sequence for IOCB_NOWAIT

Patch-2: Starts with shared inode lock in case of DIO instead of exclusive inode
lock. This patchset helps fix the reported scalablity problem. But this fixes it
only for dioread_nolock mount option.

Patch-3: In this we get away with dioread_nolock mount option condition
to check for shared locking. This patch commit msg describe in
detail about why we don't need excl. lock even without dioread_nolock.

Git tree
========
https://github.com/riteshharjani/linux/tree/ext4-ilock-PATCHv4

Testing
=======
Completed xfstests -g auto with default mkfs & mount opts.
No new failures except the known one without these patches.


Performance results
===================
Collected some performance numbers for DIO sync mixed random read/write
workload w.r.t number of threads (ext4) to check for scalability.
The performance historgram shown below is the percentage change in
performance by using this ilock patchset as compared to vanilla kernel.


FIO command:
fio -name=DIO-mixed-randrw -filename=./testfile -direct=1 -iodepth=1 -thread \
-rw=randrw -ioengine=psync -bs=$bs -size=10G -numjobs=$thread \
-group_reporting=1 -runtime=120

Used fioperf tool [5] for collecting this performance scores.

Below shows the performance benefit hist with this ilock patchset in (%)
w.r.t vanilla kernel for mixed randrw workload (for 4K block size).
Notice, the percentage benefit increases with increasing number of
threads. So this patchset help achieve good scalability in the mentioned
workload. Also this gives upto ~140% perf improvement in 24 threads mixed randrw
workload with 4K burst size.
The performance difference can be even higher with high speed storage
devices, since bw speeds without the patch seems to flatten due to lock
contention problem in case of multiple threads.
[Absolute perf delta can be seen at [6]]


		Performance benefit (%) data randrw (read)-4K
		    (default mount options)
  160 +-+------+-------+--------+--------+-------+--------+-------+------+-+
      |        +       +        +        +       +        +       +        |
  140 +-+ 							   **    +-+
      |                                                    **      **      |
  120 +-+                                         **       **      **    +-+
      |                                           **       **      **      |
  100 +-+                                **       **       **      **    +-+
      |                                  **       **       **      **      |
   80 +-+                                **       **       **      **    +-+
      |                                  **       **       **      **      |
      |                          **      **       **       **      **      |
   60 +-+                        **      **       **       **      **    +-+
      |                          **      **       **       **      **      |
   40 +-+                        **      **       **       **      **    +-+
      |                 **       **      **       **       **      **      |
   20 +-+               **       **      **       **       **      **    +-+
      |                 **       **      **       **       **      **      |
    0 +-+       **      **       **      **       **       **      **    +-+
      |        +       +        +        +       +        +       +        |
  -20 +-+------+-------+--------+--------+-------+--------+-------+------+-+
               1       2        4        8      12       16      24
	       		Threads


		Performance benefit (%) data randrw (write)-4K
		     (default mount options)
  160 +-+------+-------+--------+--------+-------+--------+-------+------+-+
      |        +       +        +        +       +        +       +        |
  140 +-+ 							   **    +-+
      |                                                    **      **      |
  120 +-+                                         **       **      **    +-+
      |                                           **       **      **      |
  100 +-+                                **       **       **      **    +-+
      |                                  **       **       **      **      |
   80 +-+                                **       **       **      **    +-+
      |                                  **       **       **      **      |
      |                          **      **       **       **      **      |
   60 +-+                        **      **       **       **      **    +-+
      |                          **      **       **       **      **      |
   40 +-+                        **      **       **       **      **    +-+
      |                 **       **      **       **       **      **      |
   20 +-+               **       **      **       **       **      **    +-+
      |                 **       **      **       **       **      **      |
    0 +-+       **      **       **      **       **       **      **    +-+
      |        +       +        +        +       +        +       +        |
  -20 +-+------+-------+--------+--------+-------+--------+-------+------+-+
               1       2        4        8      12       16      24
			Threads

Previous version
================
v3: https://www.spinics.net/lists/linux-ext4/msg68649.html
v2: https://www.spinics.net/lists/kernel/msg3262531.html
v1: https://patchwork.ozlabs.org/cover/1163286/

References
==========
[1]: https://lore.kernel.org/linux-ext4/1566871552-60946-4-git-send-email-joseph.qi@linux.alibaba.com/
[2]: https://lore.kernel.org/linux-ext4/20190910215720.GA7561@quack2.suse.cz/
[3]: https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/ext4/perf.report
[4]: https://patchwork.ozlabs.org/cover/1163286/
[5]: https://github.com/riteshharjani/fioperf
[6]: https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/ext4/diff_ilock_v3_default_dio_randrw_4K.txt
[7]: https://www.spinics.net/lists/linux-ext4/msg68659.html

-ritesh

Ritesh Harjani (3):
  ext4: fix ext4_dax_read/write inode locking sequence for IOCB_NOWAIT
  ext4: Start with shared i_rwsem in case of DIO instead of exclusive
  ext4: Move to shared i_rwsem even without dioread_nolock mount opt

 fs/ext4/file.c | 196 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 144 insertions(+), 52 deletions(-)

-- 
2.21.0

