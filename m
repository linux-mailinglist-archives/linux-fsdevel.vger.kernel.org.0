Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAEE5E9A0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiIZHGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 03:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiIZHGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:06:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF802494A;
        Mon, 26 Sep 2022 00:06:41 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q76NXT004558;
        Mon, 26 Sep 2022 07:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=m96v0iLGmj7XUxHYQV+Hvbnrur8YLtpwbZTHYYGS0kY=;
 b=XAw3QmKF9R7BqHeTe8Kd3FgQYxgGwUcUMEqx4Eos1CdjWrec6q7vH1DKCn/T0HI5KYiF
 GxPbl0rieaBSen7RY+6p7O6PdBqUi3sFdAGHtLqPOoouNPVoOxkXQTYO09JyubFbnKSD
 cQQ630impNTW74XlNVgm/NLpSOn50K+QfQBO8fjhWi5MM/cDgkk0BdOfRJfKrOMnLDRi
 h04Zh+qHeXaMQAMQOvN2xeMlZwSznymn0tvpB9ZGV/zCpAv8GXCroNEpBJ8gJVraAi1a
 RkmCzUMqwgCTJqfPRn/aC2jOQxwm1VkdAZlTrcuJQDBM9saeRNHN8n21B6JisvVeIjmr 0A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jtbjj58jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 07:06:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28Q75ZvI009432;
        Mon, 26 Sep 2022 07:06:35 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3jssh9a1pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 07:06:34 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28Q770xG25362746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 07:07:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC19111C04C;
        Mon, 26 Sep 2022 07:06:32 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F2B311C04A;
        Mon, 26 Sep 2022 07:06:30 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.30.221])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 07:06:29 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Subject: [RFC v2 0/8] ext4: Convert inode preallocation list to an rbtree
Date:   Mon, 26 Sep 2022 12:34:51 +0530
Message-Id: <cover.1664172580.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yM6m6Tu0b6oZ3HpqUl-eDhOjGWCRjO11
X-Proofpoint-ORIG-GUID: yM6m6Tu0b6oZ3HpqUl-eDhOjGWCRjO11
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=806 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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
during heavy sparse workloads, the lenght of this list was capped at 512
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

This is comming from the spin_lock(&pa->pa_lock) that is called for
each PA that we iterate over, in ext4_mb_normalize_request(). Since in rbtrees,
we lookup log(n) PAs rather than n PAs, this spin lock is taken less frequently,
as evident in the perf. 

Furthermore, we see some improvements in other tests however since they don't
exercise the PA traversal path as much as test 1, the improvements are relatively
smaller. 

** Summary of patches **

- Patch 1-5: Abstractions/Minor optimizations
- Patch 6: Split common inode & locality group specific fields to a union
- Patch 7: Core changes to move inode PA logic from list to rbtree
- Patch 8: Remove the trim logic as it is not needed

** Changes since v1 **

- Rebased over ext4 dev branch which includes Jan's patchset [1]
  that changed some code in mballoc.c

[1] https://lore.kernel.org/all/20220908091301.147-1-jack@suse.cz/

Ojaswin Mujoo (8):
  ext4: Stop searching if PA doesn't satisfy non-extent file
  ext4: Refactor code related to freeing PAs
  ext4: Refactor code in ext4_mb_normalize_request() and
    ext4_mb_use_preallocated()
  ext4: Move overlap assert logic into a separate function
  ext4: Abstract out overlap fix/check logic in
    ext4_mb_normalize_request()
  ext4: Convert pa->pa_inode_list and pa->pa_obj_lock into a union
  ext4: Use rbtrees to manage PAs instead of inode i_prealloc_list
  ext4: Remove the logic to trim inode PAs

Ojaswin Mujoo (8):
  ext4: Stop searching if PA doesn't satisfy non-extent file
  ext4: Refactor code related to freeing PAs
  ext4: Refactor code in ext4_mb_normalize_request() and
    ext4_mb_use_preallocated()
  ext4: Move overlap assert logic into a separate function
  ext4: Abstract out overlap fix/check logic in
    ext4_mb_normalize_request()
  ext4: Convert pa->pa_inode_list and pa->pa_obj_lock into a union
  ext4: Use rbtrees to manage PAs instead of inode i_prealloc_list
  ext4: Remove the logic to trim inode PAs

 Documentation/admin-guide/ext4.rst |   3 -
 fs/ext4/ext4.h                     |   5 +-
 fs/ext4/mballoc.c                  | 420 ++++++++++++++++++-----------
 fs/ext4/mballoc.h                  |  17 +-
 fs/ext4/super.c                    |   4 +-
 fs/ext4/sysfs.c                    |   2 -
 6 files changed, 276 insertions(+), 175 deletions(-)

-- 
2.31.1

