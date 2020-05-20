Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEEB1DAABF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 08:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgETGlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 02:41:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbgETGlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 02:41:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04K6WW2x075620;
        Wed, 20 May 2020 02:41:01 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 314rxd24xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 02:41:01 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04K6eqTe003282;
        Wed, 20 May 2020 06:40:59 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 313xehk2qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 06:40:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04K6euGd65470584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 06:40:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 337DFA4060;
        Wed, 20 May 2020 06:40:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E01AA4054;
        Wed, 20 May 2020 06:40:54 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.188.115])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 May 2020 06:40:54 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv5 0/5] Improve ext4 handling of ENOSPC with multi-threaded use-case
Date:   Wed, 20 May 2020 12:10:31 +0530
Message-Id: <cover.1589955723.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_02:2020-05-19,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 cotscore=-2147483648 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200051
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello All,

Please note that these patches are based on top of mballoc cleanup series [2]
which is also pending review. :)

v4 -> v5:
1. Removed ext4_lock_group() from fastpath and added that in the retry attempt,
so that the performance of fastpath is not affected.

v3 -> v4:
1. Splitted code cleanups and debug improvements as a separate patch series.
2. Dropped rcu_barrier() approach since it did cause some latency
in my testing of ENOSPC handling.
3. This patch series takes a different approach to improve the multi-threaded
ENOSPC handling in ext4 mballoc code. Below mail gives more details.


Background
==========
Consider a case where your disk is close to full but still enough space
remains for your multi-threaded application to run. Now when this application
threads tries to write (e.g. sparse file followed by mmap write or
even fallocate multiple files) in parallel, then with current code of
ext4 multi-block allocator, the application may get an ENOSPC error in some
cases. Examining disk space at this time, we see there is sufficient space
remaining for your application to continue to run.

Additional info:
============================
1. Our internal test team was easily able to reproduce this ENOSPC error on 
   an upstream kernel with 2GB ext4 image, with 64K blocksize. They didn't try
   above 2GB and reprorted this issue directly to dev team. On examining the
   free space when the application gets ENOSPC, the free space left was more
   then 50% of filesystem size in some cases.

2. For debugging/development of these patches, I used below script [1] to
   trigger this issue quite frequently on a 64K blocksize setup with 240MB
   ext4 image.


Summary of patches and problem with current design
==================================================
There were 3 main problems which these patches tries to address and hence
improve the ENOSPC handling in ext4's multi-block allocator code.

1. Patch-2: Earlier we were considering the group is good or not (means
   checking if it has enough free blocks to serve your request) without taking
   the group's lock. This could result into a race where, if another thread is
   discarding the group's prealloc list, then the allocation thread will not
   consider those about to be free blocks and will fail will return that group
   is not fit for allocation thus eventually fails with ENOSPC error.

2. Patch-4: Discard PA algoritm only scans the PA list to free up the
   additional blocks which got added to PA. This is done by the same thread-A
   which at 1st couldn't allocate any blocks. But there is a window where,
   once the blocks were allocated (say by some other thread-B previously) we
   drop the group's lock and then checks to see if some of these blocks could
   be added to prealloc list of the group from where we allocated some blocks.
   After that we take the lock and add these additional blocks allocated by
   thread-B to the PA list. But say if thread-A tries to scan the PA list
   between this time interval then there is possibilty that it won't find any
   blocks added to the PA list and hence may return ENOSPC error.
   Hence this patch tries to add those additional blocks to the PA list just
   after the blocks are marked as used with the same group's spinlock held.
   
3. Patch-3: Introduces a per cpu discard_pa_seq counter which is increased
   whenever there is block allocation/freeing or when the discarding of any
   group's PA list has started. With this we could know when to stop the
   retrying logic and return ENOSPC error if there is actually no free space
   left.
   There is an optimization done in the block allocation fast path with this
   approach that, before starting the block allocation, we only sample the
   percpu seq count on that cpu. Only when the allocation fails and discard
   couldn't free up any of the blocks in all of the group's PA list, that is
   when we sample the percpu seq counter sum over all possible cpus to check
   if we need to retry.


Testing:
=========
Tested fstests with default bs of 4K and bs == PAGESIZE ("-g auto")
No new failures were reported with this patch series in this testing.

NOTE:
1. This patch series is based on top of mballoc code cleanup patch series
posted at [2].

References:
===========
[v3]: https://lkml.kernel.org/linux-ext4/cover.1588313626.git.riteshh@linux.ibm.com/
[1]: https://github.com/riteshharjani/LinuxStudy/blob/master/tools/test_mballoc.sh
[2]: https://lkml.kernel.org/linux-ext4/cover.1589086800.git.riteshh@linux.ibm.com/


Ritesh Harjani (5):
  ext4: mballoc: Add blocks to PA list under same spinlock after allocating blocks
  ext4: mballoc: Refactor ext4_mb_discard_preallocations()
  ext4: mballoc: Introduce pcpu seqcnt for freeing PA to improve ENOSPC handling
  ext4: mballoc: Refactor ext4_mb_good_group()
  ext4: mballoc: Use lock for checking free blocks while retrying

 fs/ext4/ext4.h              |   2 +
 fs/ext4/mballoc.c           | 247 ++++++++++++++++++++++++++----------
 include/trace/events/ext4.h |   3 +-
 3 files changed, 185 insertions(+), 67 deletions(-)

-- 
2.21.0

