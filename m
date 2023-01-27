Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B14867E56E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 13:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjA0MiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 07:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjA0Mhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:37:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A651B743;
        Fri, 27 Jan 2023 04:37:52 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RC6weB007875;
        Fri, 27 Jan 2023 12:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=/HGpK5w0YRnQfXqXE9Rz18AAPUEQ1wQroFq184wksF4=;
 b=mo86gAFRbh4H80VNlMwJ3AqprL2nCtUUzkPZbNemSoGGd/Q1q1BdRTR7DwGxMyiHLi3Z
 iiG+uAgDvcqmAAmDYbaD24kjKaEitjyvtkfg31nRZG8ElL2PeVe0zh0MYFN+uKoKwJoR
 ddkiPIBb9SibYMEgdFwakM9tOhdkJ5rrvDm5O+jkve/DLtJvrhtKXduUcTPGIf7ZtCup
 IKzkBk1pQCjmNLqmDY5PVQA7B8VJfE6UaywZ9NcjQoH+FC7VSRsZ1P0RVaJE62nr51cR
 m8BynPv3WwJLPA9LtdnDNzHb2xpYmClBdnFjZM5oiQeqZVtd0nBqCDejCsJ710clQ53Z 7w== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nceb80qyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:37:47 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R0Bj9o001649;
        Fri, 27 Jan 2023 12:37:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n87p6ddsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:37:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RCbhgg47055338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 12:37:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D5C720043;
        Fri, 27 Jan 2023 12:37:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B971920040;
        Fri, 27 Jan 2023 12:37:41 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.40.88])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 12:37:41 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [RFC 00/11] multiblock allocator improvements
Date:   Fri, 27 Jan 2023 18:07:27 +0530
Message-Id: <cover.1674822311.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vdwjIEnzuAk609q8kpCygekUmFHf5875
X-Proofpoint-ORIG-GUID: vdwjIEnzuAk609q8kpCygekUmFHf5875
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270113
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TRACKER_ID autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset intends to improve some of the shortcomings of mb allocator
that we had noticed while running various tests and workloads in a
POWERPC machine with 64k block size.  

** Problems **

More specifically, we were seeing a sharp drop in performance when the
FS was highly fragmented (64K bs). We noticed that:

Problem 1: prefetch logic seemed to be skipping BLOCK_UNINIT groups
which was resulting in buddy and CR0/1 cache not being initialized for
these even though it could be done without any IO. (Not sure if there
was any history behind this design, do let me know if so).

Problem 2: With a 64K bs FS, we were commonly seeing cases where CR1
would correctly identify a good group but due to very high
fragmentation, complex scan would exit early due to ac->ac_found >
s_mb_max_to_scan, resulting in trimming of the allocated len.

Problem 3: Even though our avg free extent was say 4MB and original
request was merely 1 block of data, mballoc noramlization kept adding
PAs and requesting 8MB chunks. This led to almost all the requests
falling into slower CR 2 and with increased threads, we started seeing
lots of CR3 requests as well.

** How did we address them **

Problem 1 (Patch 8,9): Make ext4_mb_prefetch also call
ext4_read_block_bitmap_nowait() in case of BLOCK_UNINIT, so it can init
the BG and exit early without an IO. Next, fix the calls to
prefetch_fini so these newly init BGs can have their buddy initialised.

Problem 2 (Patch 7): When we come to complex_scan after CR1, my
understanding is that due to free/frag > goal_len, we can be sure that
there is atleast one chunk big enough to accomodate the goal request.
Hence, we can skip the overhead of mb_find_extent() other accounting for
each free extent and just process extents that are big enough.

Problem 3 (Patch 11): To solve this problem, this patchset implements a
new allocation criteria (CR1.5 or CR1_5 in code). The idea is that if
CR1 fails to find a BG, it will jump to CR1.5. Here the flow is as
follows:

  * We make an assumption that if CR1 has failed that means none of the
    currently cached BGs have a big enough continuous extent to satisfy
    our request In this case we fall to CR1.5.

  * In CR 1.5, we find the highest available free/frag BGs (from CR1
    lists) and trim the PAs to this order so that we can find 
    a BG without IO overhead of CR2. 
    
  * Parallely, prefetch will get in more groups in memory, and as more
    and more groups are cached, CR1.5 becomes a better replacement of
    CR2. This is because, for example, if all BGs are cahced and we
    couldn't find anything in CR0/1, we can assume that no BG has a big
    enough continuous free extent and hence CR1.5 can directly trim and
    find the next biggest extent we could get. In this scenario, without
    CR1.5, we would have continued scanning in CR2 which would have
    most probably trimmed the request after scanning for ~200 extents.
    
CR1.5 results in improved allocation speed at the cost of slightly increased
trimming of the len of blocks allocated. 

** Performance Numbers **

Unless stated otherwise, these numbers are from fsmark and fio tests with 64k
BS, 64K pagesize on 100Gi nvme0n1 with nodelalloc. There tests were performed
after the FS was fragmented till Avg Fragment Size == 4MB.

* Test 1: Writing ~40000 files of 64K each in a single directory (64 threads, fsmark)
* Test 2: Same as Test 1 on a 500GiB pmem device with dax
* Test 3: 5Gi write with mix of random and seq writes (fio)
* Test 4: 5Gi sequential writes (fio)

Here:
e = extents scanned
c = cr0 / cr1 / cr1.5 / cr2 / cr3 hits

+─────────+───────────────────────────────────+────────────────────────────────+
|         | Unpatched                         | Patched                        |
+─────────+───────────────────────────────────+────────────────────────────────+
| Test 1  | 6866 files/s                      | 13527 files/s                  |
|         | e: 8,188,644                      | e: 1,719,725                   |
|         | c: 381 / 330 / - / 4779 / 35534   | c: 381/ 280 / 33299/ 1000/ 6064|
+─────────+───────────────────────────────────+────────────────────────────────+
| Test 2  | 6927 files/s                      | 8422 files/s                   |
|         | e: 8,055,911                      | e: 261,268                     |
|         | cr: 1011 / 999 / - / 6153 / 32861 | c: 1721 / 1210 / 38093 / 0 / 0 |
+─────────+───────────────────────────────────+────────────────────────────────+
| Test 3  | 387 MiB/s                         | 443 MiB/s                      |
+─────────+───────────────────────────────────+────────────────────────────────+
| Test 4  | 3139 MiB/s                        | 3180 MiB/s                     |
+─────────+───────────────────────────────────+────────────────────────────────+

The numbers of same tests with 4k bs 64k pagesize are:

+─────────+────────────────────────────────────+────────────────────────────────+
|         | Unpatched                          | Patched                        |
+─────────+────────────────────────────────────+────────────────────────────────+
| Test 1  | 21618 files/s                      | 23528 files/s                  |
|         | e: 8,149,272                       | e: 223,013                     |
|         | c: 34 / 1380 / - / 5624 / 34710    | 34 / 1341 / 40387 / 0 / 0      |
+─────────+───────────────────────────────────+─────────────────────────────────+
| Test 2  | 30739 files/s                      | 30946 files/s                  |
|         | e: 7,742,853                       | e: 2,176,475                   |
|         | c: 1131 / 2244 / - / 3914 / 34468  | c: 1596/1079/28425/1098/8547   |
+─────────+───────────────────────────────────+─────────────────────────────────+
| Test 3  | 200 MiB/s                          | 186MiB/s                       |
+─────────+───────────────────────────────────+─────────────────────────────────+
| Test 4  | 621 MiB/s                          | 632 MiB/s                      |
+─────────+────────────────────────────────────+────────────────────────────────+

** Some Observations **

1. In the case of highly fragmented 64k blocksize most of the performance is
lost since we hold the BG lock while scanning a block group for best extent.
As our goal len is 8MB and we only have 4MB blocks, we are taking a long time
to scan causing other threads to wait on the BG lock. This can be seen in perf
diff of unpatched vs patched:

    83.14%    -24.89%  [kernel.vmlinux]            [k] do_raw_spin_lock

Using lockstat and perf call graph I was able to confirm that this lock was the
BG lock taken in ext4_mb_regular_allocator, contending with other processes trying
to take the same BG's lock in ext4_mb_regular_allocator() and __ext4_new_inode()


2. Currently, I do see some increase in fragmentation. Below are the
e2freefrag results after Test 1 with 64k BS:

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Unpatched:

Min. free extent: 128 KB
Max. free extent: 8000 KB
Avg. free extent: 4096 KB
Num. free extent: 12630

HISTOGRAM OF FREE EXTENT SIZES:
Extent Size Range :  Free extents   Free Blocks  Percent
  128K...  256K-  :             1             2    0.00%
  256K...  512K-  :             1             6    0.00%
  512K... 1024K-  :             4            48    0.01%
    1M...    2M-  :             5           120    0.01%
    2M...    4M-  :         11947        725624   85.31%
    4M...    8M-  :           672         83796    9.85%

Patched:

Min. free extent: 64 KB
Max. free extent: 11648 KB
Avg. free extent: 2688 KB
Num. free extent: 18847

HISTOGRAM OF FREE EXTENT SIZES:
Extent Size Range :  Free extents   Free Blocks  Percent
   64K...  128K-  :             1             1    0.00%
  128K...  256K-  :             2             5    0.00%
  256K...  512K-  :             1             5    0.00%
  512K... 1024K-  :           297          3909    0.48%
    1M...    2M-  :         11221        341065   42.13%
    2M...    4M-  :          4940        294260   36.35%
    4M...    8M-  :          2384        170169   21.02%
    8M...   16M-  :             1           182    0.02%

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

3. I was hoping to get some feedback on enabling prefetch of BLOCK_UNINIT
BGs and any history on why we disabled it.

-------------------------------------

Since these changes are looking good to me from my end, so posting for a
feedback from ext4 community.  

(gcexfstests -c all quick went fine with no new failures reported)

Any thoughts/suggestions are welcome!! 

Regards,
Ojaswin

Ojaswin Mujoo (8):
  ext4: Convert mballoc cr (criteria) to enum
  ext4: Add per CR extent scanned counter
  ext4: Add counter to track successful allocation of goal length
  ext4: Avoid scanning smaller extents in BG during CR1
  ext4: Don't skip prefetching BLOCK_UNINIT groups
  ext4: Ensure ext4_mb_prefetch_fini() is called for all prefetched BGs
  ext4: Abstract out logic to search average fragment list
  ext4: Add allocation criteria 1.5 (CR1_5)

Ritesh Harjani (IBM) (3):
  ext4: mballoc: Remove useless setting of ac_criteria
  ext4: Remove unused extern variables declaration
  ext4: mballoc: Fix getting the right group desc in
    ext4_mb_prefetch_fini

 fs/ext4/ext4.h    |  23 +++-
 fs/ext4/mballoc.c | 284 +++++++++++++++++++++++++++++++++-------------
 fs/ext4/mballoc.h |  27 ++++-
 fs/ext4/super.c   |  11 +-
 fs/ext4/sysfs.c   |   2 +
 5 files changed, 255 insertions(+), 92 deletions(-)

-- 
2.31.1

