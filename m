Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2431A278D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 18:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgDHQy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 12:54:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729017AbgDHQyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:54:25 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 038GYSRu167356
        for <linux-fsdevel@vger.kernel.org>; Wed, 8 Apr 2020 12:54:24 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 309gw0u8b9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2020 12:54:24 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 8 Apr 2020 17:54:02 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Apr 2020 17:53:59 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 038GsHM934340882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Apr 2020 16:54:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67378A4060;
        Wed,  8 Apr 2020 16:54:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BDD5A4054;
        Wed,  8 Apr 2020 16:54:15 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.42])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Apr 2020 16:54:15 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        sandeen@sandeen.net, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 0/1] ext4: Fix mballoc race in freeing up group preallocations
Date:   Wed,  8 Apr 2020 22:24:09 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040816-0008-0000-0000-0000036CF98F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040816-0009-0000-0000-00004A8E97A5
Message-Id: <cover.1586358980.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_10:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080125
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello All, 

There seems to be a below race with current
ext4_mb_group_discard_preallocations() function. This could be fairly
easily reproduced on a system with only 1 group. But internally this was even
reported with more than 1 group. We could reproduce this on both 64K and 4K
blocksize filesystem.

This is a RFC patch sent out for reviews, feedback and/or any comments.
Below mail provide all the necessary details.

Test setup
==========
1. It's a multithreaded test case where each thread is trying to create a
file using open() -> ftruncate().
2. Then we are doing mmap of this file for filesize bytes. 
3. Then start writing sequentially byte by byte for full filesize. 

Details for creating it on loop device:-
======================================
1. truncate -s 240M filefs   (easier on a smaller filesystem)
2. losetup /dev/loop0 filefs 
3. mkfs.ext4 -F -b 65536 /dev/loop0
4. mkdir mnt
5. mount -t ext4 /dev/loop0 mnt/
6. cd mnt/
7. Start running the test case mentioned above in above "Test setup".
(for our test we were keeping no. of threads to ~70 and filling the available
filesystem space (df -h) to around ~80%/70%. Based on that each filesize is
calculated).
8. cd .. (once the test finishes)
9. umount mnt
10. Go to step 3.

Test (test-ext4-mballoc.c) file and script which does the
unmount/mount and run the ./a.out is mentioned at [1], [2].


Analysis:-
==========

It seems below race could be occurring
	P1 							P2
ext4_mb_new_blocks() 						|
	|						ext4_mb_new_blocks()
	|
ext4_mb_group_discard_preallocations() 				|
		| 				ext4_mb_group_discard_preallocations()
	if (list_empty(&grp->bb_prealloc_list)
		return 0; 					|
		| 						|
	ext4_lock_group() 					|
	list_for_each_entry_safe() {  				|
		<..>  						|
		list_del(&pa->pa_group_list);  			|
		list_add(&pa->u.pa_tmp_list, &list) 		|
	} 							|
								|
	processing-local-list() 		if(list_empty(&grp->bb_prealloc_list)
	 	|					return 0
	<...>
	ext4_unlock_group()

What we see here is that, there are multiple threads which are trying to allocate. 
But since there is not enough space, they try to discard the group preallocations.
(will be easy to understand if we only consider group 0, though it could
be reproduced with multiple groups as well). 
Now while more than 1 thread tries to free up the group preallocations, there
could be 1 thread (P2) which sees that the bb_prealloc_list is already
empty and will assume that there is nothing to free from here. Hence return 0.
Now consider this happens with thread P2 for all other groups as well (where some other
thread came in early and freed up the group preallocations). At that point,
P2 sees that the total freed blocks returned by ext4_mb_discard_preallocations()
back to ext4_mb_new_blocks() is 0 and hence it does not retry the allocation,
instead it returns -ENOSPC error. 

This causes SIGBUS to the application who was doing an mmap write. Once
the application crashes we could still see that the filesystem available space
is more than ~70-80% (worst case scenario). So ideally P2 should have waited
for P1 to get over and should have checked how much P1 could free up.


Solution (based on the understanding of the mballoc code)
=========================================================

We think that it is best to check if there is anything to be freed
within ext4_group_lock(). i.e. to check if the bb_prealloc_list is empty.
This patch attempts to fix this race by checking if nothing could be collected
in the local list. This could mean that someone else might have freed
all of this group PAs for us. So simply return group->bb_free which
should also give us an upper bound on the total available space for
allocation in this group.

We need not worry about the fast path of whether the list is empty without
taking ext4_group_lock(), since we are anyway in the slow path where the
ext4_mb_regular_allocator() failed and hence we are now desperately trying
to discard all the group PAs to free up some space for allocation.


Please correct if any of below understanding is incorrect:-
==========================================================
1. grp->bb_free is the available number of free blocks in that group for
   allocation by anyone.
2. If grp->bb_free is non-zero and we call ext4_mb_regular_allocator(ac),
then it will always return ac->ac_status == AC_STATUS_FOUND
(and it could even allocate and return less than the requested no. of blocks).
3. There shouldn't be any infinte loop in ext4_mb_new_blocks() after we
return grp->bb_free in this patch.
(i.e. between ext4_mb_regular_allocator() and ext4_mb_discard_preallocations())
It could only happen if ext4_mb_regular_allocator cannot make any forward
progress even if grp->bb_free is non-zero. 
But IIUC, that won't happen. Please correct here.

Tests run:-
==========
For now I have only done unit testing with the shared test code [1] [2].
Wanted to post this RFC for review comments/discussion.

Resources:
==========
[1] - https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/tools/test-ext4-mballoc.c
[2] - https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/tools/test_mballoc.sh

Ritesh Harjani (1):
  ext4: Fix race in ext4_mb_discard_group_preallocations()

 fs/ext4/mballoc.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

-- 
2.21.0

