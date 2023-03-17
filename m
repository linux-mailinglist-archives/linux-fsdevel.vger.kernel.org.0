Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91F16BE3DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 09:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjCQIil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 04:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCQIiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:38:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAE3E1FD6;
        Fri, 17 Mar 2023 01:37:46 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H7MLCa027486;
        Fri, 17 Mar 2023 08:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=fHYJ2FcqStx8KejTFNl8E4hu3VpXDFgLdEcCnfgQzSo=;
 b=mu7DHyYh2CjYqlWyEHMjWLLWzYQQVQ7EnpNQSk0MhsQz3rz/rR4ZoXBSi22PZeUfWdMT
 +IqAAtnFhKpv9J+1cP8vB8+O0iiTs8GZix7sahqSusAvHHt6a1IIod6xiY+JJUcUHRum
 Q6Q7NSubJbVkMMXu1KbCliMbomttAuJE+Co1w/YyMPxkHwi6yj3fMWArY5npxr8EOL4V
 zXOWwnmdbt2ndPjz8tbS3mcjpUh1mapyI3OsiFKTDJdQpNBz3PUhOTtibYyKcf/WfTOc
 Y2VIAUdD7czX+NctxWQIwA38YBrMU1fyXNoVMC+m8fpCAraybf6GiRZC0xFTZ2QAGnrT Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pckrrj21d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:37:24 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32H7tLTq006723;
        Fri, 17 Mar 2023 08:37:24 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pckrrj20r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:37:24 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32H1Y4qQ008119;
        Fri, 17 Mar 2023 08:37:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3pbsmrhhw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:37:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32H8bJDG17040096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 08:37:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5386720F51;
        Fri, 17 Mar 2023 08:37:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2A9420F5C;
        Fri, 17 Mar 2023 08:37:16 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.91.202])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Mar 2023 08:37:16 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>
Subject: [PATCH v5 0/9] ext4: Convert inode preallocation list to an rbtree
Date:   Fri, 17 Mar 2023 14:07:04 +0530
Message-Id: <cover.1679042083.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vrqSB7DuWw2_qb2wg-YM0BH4qrgz0xfG
X-Proofpoint-GUID: Oux7oEw3THsMSKsQ5ZWO20w1X6GkAiCL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_04,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1011
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series aim to improve the performance and scalability of
inode preallocation by changing inode preallocation linked list to an
rbtree. I've ran xfstests quick on this series and plan to run auto group
as well to confirm we have no regressions.

** Shortcomings of existing implementation **

Right now, we add all the inode preallocations(PAs) to a per inode linked
list ei->i_prealloc_list. To prevent the list from growing infinitely
during heavy sparse workloads, the length of this list was capped at 512
and a trimming logic was added to trim the list whenever it grew over
this threshold, in patch 27bc446e2. This was discussed in detail in the
following lore thread [1].

[1] https://lore.kernel.org/all/d7a98178-056b-6db5-6bce-4ead23f4a257@gmail.com/

But from our testing, we noticed that the current implementation still
had issues with scalability as the performance degraded when the PAs
stored in the list grew. Most of the degradation was seen in
ext4_mb_normalize_request() and ext4_mb_use_preallocated() functions as
they iterated the inode PA list.

** Improvements in this patchset **

To counter the above shortcomings, this patch series modifies the inode
PA list to an rbtree, which:

- improves the performance of functions discussed above due to the
  improved lookup speed.
  
- improves scalability by changing lookup complexity from O(n) to
  O(logn). We no longer need the trimming logic as well.

As a result, the RCU implementation was needed to be changed since
lockless lookups of rbtrees do have some issues like skipping
subtrees. Hence, RCU was replaced with read write locks for inode
PAs. More information can be found in Patch 7 (that has the core
changes).

** Performance Numbers **

Performance numbers were collected with and without these patches, using an
nvme device. Details of tests/benchmarks used are as follows:

Test 1: 200,000 1KiB sparse writes using (fio)
Test 2: Fill 5GiB w/ random writes, 1KiB burst size using (fio)
Test 3: Test 2, but do 4 sequential writes before jumping to random
        offset (fio)
Test 4: Fill 8GB FS w/ 2KiB files, 64 threads in parallel (fsmark)

+──────────+──────────────────+────────────────+──────────────────+──────────────────+
|          |            nodelalloc             |              delalloc               |
+──────────+──────────────────+────────────────+──────────────────+──────────────────+
|          | Unpatched        | Patched        | Unpatched        | Patched          |
+──────────+──────────────────+────────────────+──────────────────+──────────────────+
| Test 1   | 11.8 MB/s        | 23.3 MB/s      | 27.2 MB/s        | 63.7 MB/s        |
| Test 2   | 1617 MB/s        | 1740 MB/s      | 2223 MB/s        | 2208 MB/s        |
| Test 3   | 1715 MB/s        | 1823 MB/s      | 2346 MB/s        | 2364 MB/s        |
| Test 4   | 14284 files/sec  | 14347 files/s  | 13762 files/sec  | 13882 files/sec  |
+──────────+──────────────────+────────────────+──────────────────+──────────────────+

In test 1, we almost see 100 to 200% increase in performance due to the high number
of sparse writes highlighting the bottleneck in the unpatched kernel. Further, on running
"perf diff patched.data unpatched.data" for test 1, we see something as follows:

     2.83%    +29.67%  [kernel.vmlinux]          [k] _raw_spin_lock
												...
               +3.33%  [ext4]                    [k] ext4_mb_normalize_request.constprop.30
     0.25%     +2.81%  [ext4]                    [k] ext4_mb_use_preallocated

Here we can see that the biggest different is in the _raw_spin_lock() function
of unpatched kernel, that is called from `ext4_mb_normalize_request()` as seen
here:

    32.47%  fio              [kernel.vmlinux]            [k] _raw_spin_lock
            |
            ---_raw_spin_lock
               |          
                --32.22%--ext4_mb_normalize_request.constprop.30

This is coming from the spin_lock(&pa->pa_lock) that is called for
each PA that we iterate over, in ext4_mb_normalize_request(). Since in rbtrees,
we lookup log(n) PAs rather than n PAs, this spin lock is taken less frequently,
as evident in the perf. 

Furthermore, we see some improvements in other tests however since they don't
exercise the PA traversal path as much as test 1, the improvements are relatively
smaller. 

** Summary of patches **

- Patch 1-5: Abstractions/Minor optimizations
- Patch 6: Change bex lstart adjustment logic to avoid overflow from goal
- Patch 7: Split common inode & locality group specific fields to a union
- Patch 8: Core changes to move inode PA logic from list to rbtree
- Patch 9: Remove the trim logic as it is not needed

** Changes since PATCH v3 [4] **
- ./checkpatch fixes
- Picked up RVBs by Ritesh and Jan
- Rebased over ted/dev which includes Kemeng's mballoc cleanup v3 patches [5]

** Changes since PATCH v3 [2] **
- Patch 6 fixes a bug in current best extent adjustment logic by
  introducing a new logic.
- Patch 8 - ext4_mb_pa_adjust_overlap functions uses a modified logic to
  trim the normalized range, which also takes care of presence deleted
  PAs in the preallocation tree.
- Ran xfstests -c all quick and everything seems good. Performance
  numbers seem similar to previous improvements as well.

Both the above changes are based on discussion here [3]

** Changes since PATCH v2 [1] **
- In patch 7, include a design change related to 
  encountering deleted PAs in inode rbtree that overlap with to be
  inserted PA, when adjusting overlap. More details in the patch.
  (Removed Jan's RVB for this patch)

** Changes since PATCH v1 **
- fixed styling issue
- merged ext4_mb_rb_insert() and ext4_mb_pa_cmp()

** Changes since RFC v3 **
- Changed while loops to for loops in patch 7
- Fixed some data types
- Made rbtree comparison logic more intuitive. The
  rbtree insertion function still kept separate from
  comparison function for reusability.

** Changes since RFC v2 **
- Added a function definition that was deleted during v2 rebase

** Changes since RFC v1 **
- Rebased over ext4 dev branch which includes Jan's patchset
  that changed some code in mballoc.c

[1] https://lore.kernel.org/linux-ext4/cover.1665776268.git.ojaswin@linux.ibm.com/
[2] https://lore.kernel.org/all/20230116080216.249195-1-ojaswin@linux.ibm.com/
[3]
https://lore.kernel.org/all/20230116080216.249195-8-ojaswin@linux.ibm.com/
[4]
https://lore.kernel.org/all/cover.1676634592.git.ojaswin@linux.ibm.com/
[5]
https://lore.kernel.org/r/20230303172120.3800725-1-shikemeng@huaweicloud.com

Ojaswin Mujoo (9):
  ext4: Stop searching if PA doesn't satisfy non-extent file
  ext4: Refactor code related to freeing PAs
  ext4: Refactor code in ext4_mb_normalize_request() and
    ext4_mb_use_preallocated()
  ext4: Move overlap assert logic into a separate function
  ext4: Abstract out overlap fix/check logic in
    ext4_mb_normalize_request()
  ext4: Fix best extent lstart adjustment logic in
    ext4_mb_new_inode_pa()
  ext4: Convert pa->pa_inode_list and pa->pa_obj_lock into a union
  ext4: Use rbtrees to manage PAs instead of inode i_prealloc_list
  ext4: Remove the logic to trim inode PAs

 Documentation/admin-guide/ext4.rst |   3 -
 fs/ext4/ext4.h                     |   5 +-
 fs/ext4/mballoc.c                  | 536 ++++++++++++++++++++---------
 fs/ext4/mballoc.h                  |  17 +-
 fs/ext4/super.c                    |   4 +-
 fs/ext4/sysfs.c                    |   2 -
 6 files changed, 377 insertions(+), 190 deletions(-)

-- 
2.31.1

