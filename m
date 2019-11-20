Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 376021032AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 06:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfKTFAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 00:00:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725263AbfKTFAi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 00:00:38 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAK4vVs6051549
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 00:00:36 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wcf35fgdf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 00:00:36 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 20 Nov 2019 05:00:34 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Nov 2019 05:00:31 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAK50UeZ47710246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 05:00:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B4EFA4069;
        Wed, 20 Nov 2019 05:00:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0E9DA4057;
        Wed, 20 Nov 2019 05:00:27 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.63.56])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Nov 2019 05:00:27 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: [RFCv3 0/4] ext4: Introducing ilock wrapper APIs & fixing i_rwsem scalablity prob. in DIO mixed-rw
Date:   Wed, 20 Nov 2019 10:30:20 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112005-4275-0000-0000-000003836F76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112005-4276-0000-0000-00003896E602
Message-Id: <20191120050024.11161-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_08:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200045
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are ilock patches which helps improve the current inode lock scalabiliy
problem in ext4 DIO mixed read/write workload case. The problem was first
reported by Joseph [1]. These patches are based upon upstream discussion
with Jan Kara & Joseph [2].

The problem really is that in case of DIO overwrites, we start with
a exclusive lock and then downgrade it later to shared lock. This causes a
scalability problem in case of mixed DIO read/write workload case. 
i.e. if we have any ongoing DIO reads and then comes a DIO writes,
(since writes starts with excl. inode lock) then it has to wait until the
shared lock is released (which only happens when DIO read is completed). 
Same is true for vice versa as well.
The same can be easily observed with perf-tools trace analysis [3].

This patch series (Patch-4) helps fix that situation even without
dioread_nolock mount opt. This is inline with the discussions with Jan [4].
More details about this are mentioned in commit msg of patch 3 & 4.

These patches are based on the top of Ted's ext4 master tree.

Patch description
=================
Patch-1: Fixes ext4_dax_read/write inode locking sequence for IOCB_NOWAIT

Patch-2: Introduces ext4_ilock/unlock APIs for use in next patches
Mainly a wrapper function for inode_lock/unlock.

Patch-3: Starts with shared iolock in case of DIO instead of exclusive iolock
This patchset helps fix the reported scalablity problem. But this Patch-3
fixes it only for dioread_nolock mount option.

Patch-4: In this we get away with dioread_nolock mount option condition
to check for shared locking. But we still take excl. lock for data=journal or
non-extent mode or non-regular file. This patch commit msg describe in
detail about why we don't need excl. lock even without dioread_nolock.

Git tree
========
https://github.com/riteshharjani/linux/tree/ext4-ilock-RFC-v3

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

-ritesh


Ritesh Harjani (4):
  ext4: fix ext4_dax_read/write inode locking sequence for IOCB_NOWAIT
  ext4: Add ext4_ilock & ext4_iunlock API
  ext4: start with shared iolock in case of DIO instead of excl. iolock
  ext4: Move to shared iolock even without dioread_nolock mount opt

 fs/ext4/ext4.h    |  33 ++++++
 fs/ext4/extents.c |  16 +--
 fs/ext4/file.c    | 252 +++++++++++++++++++++++++++++++++-------------
 fs/ext4/inode.c   |   4 +-
 fs/ext4/ioctl.c   |  16 +--
 fs/ext4/super.c   |  12 +--
 fs/ext4/xattr.c   |  17 ++--
 7 files changed, 246 insertions(+), 104 deletions(-)

-- 
2.21.0

