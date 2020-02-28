Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11C541733E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 10:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgB1J1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 04:27:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbgB1J1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:27:16 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01S9OSdr128433
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 04:27:15 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yepxayps2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 04:27:15 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 28 Feb 2020 09:27:12 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Feb 2020 09:27:08 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01S9R7J630671348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:27:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DB5242047;
        Fri, 28 Feb 2020 09:27:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67F5542054;
        Fri, 28 Feb 2020 09:27:04 +0000 (GMT)
Received: from dhcp-9-199-158-200.in.ibm.com (unknown [9.199.158.200])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Feb 2020 09:27:04 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv5 0/6] ext4: bmap & fiemap conversion to use iomap
Date:   Fri, 28 Feb 2020 14:56:53 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022809-4275-0000-0000-000003A64901
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022809-4276-0000-0000-000038BACC14
Message-Id: <cover.1582880246.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_02:2020-02-26,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280078
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello All, 

PATCHv4 -> PATCHv5
Fixed static symbol warning. Added Reported-by & Reviewed-by tags.

Background
==========
These are v4 patches to move ext4 bmap & fiemap calls to use iomap APIs.
Previous version can be found in links mentioned below.
After some discussions with the community in [RFCv2] all of the below
observational differences between the old and the new (iomap based
implementation) has been agreed upon. It looks like we should be good to move
ext4_fiemap & ext4_bmap too to iomap interface.

FYI - this patch reduces the users of ext4_get_block API and thus a step
towards getting rid of buffer_heads from ext4.
Also reduces a lot of code by making use of existing iomap_ops.

PATCHv3 -> PATCHv4
==================
1. Patch-1: Fixed indentation and checking of flags EXT4_MAP_UNWRITTEN.
2. Patch-4: Moved the checking of offset beyond what indirect mapped file inode
   can support, to early in ext4_iomap_begin_report().
3. Patch-5: Fixed no in-inode & no external block case in case of xattr.
   Returning -ENOENT in that case.
4. Patch-6: Added more info in documentation about when FIEMAP_EXTENT_LAST could
   be set.


RFCv2 -> PATCHv3
================
1. Fixed IOMAP_INLINE & IOMAP_MAPPED flag setting in *xattr_fiemap() based
   on, whether it is inline v/s external block.
2. Fixed fiemap for non-extent based mapping. [PATCHv3 4/6] fixes it.
3. Updated the documentation for description about FIEMAP_EXTENT_LAST flag.
   [PATCHv3 6/6].


Testing (done on ext4 master branch)
========
'xfstests -g quick' passes with default mkfs/mount configuration
(v/s which also pass with vanilla kernel without this patch). Except
generic/473 which also failes on XFS. This seems to be the test case issue
since it expects the data in slightly different way as compared to what iomap
returns.
Point 2.a below describes more about this.

Observations/Review required
============================
1. bmap related old v/s new method differences:-
	a. In case if addr > INT_MAX, it issues a warning and
	   returns 0 as the block no. While earlier it used to return the
	   truncated value with no warning.
	[Again this should be fine, it was just an observation worth mentioning]

	b. block no. is only returned in case of iomap->type is IOMAP_MAPPED,
	   but not when iomap->type is IOMAP_UNWRITTEN. While with previously
	   we used to get block no. for both of above cases.
	[Darrick:- not much reason to map unwritten blocks. So this may not
	 be relevant here [5]]

2. Fiemap related old v/s new method differences:-
	a. iomap_fiemap returns the disk extent information in exact
	   correspondence with start of user requested logical offset till the
	   length requested by user. While in previous implementation the
	   returned information used to give the complete extent information if
	   the range requested by user lies in between the extent mapping.
	[Both behaviors should be fine here as per documentation - [5]]

	b. iomap_fiemap adds the FIEMAP_EXTENT_LAST flag also at the last
	   fiemap_extent mapping range requested by the user via fm_length (
	   if that has a valid mapped extent on the disk). But if the user
	   requested for more fm_length which could not be mapped in the last
	   fiemap_extent, then the flag is not set.
	[This does not seems to be an issue after some community discussion.
	Since this flag is not consistent across different filesystems.
	In ext4 itself for extent v/s non-extent based mapping, this flag is
	set differently. So we rather decided to update the documentation rather
	than complicating it more, which anyway no one seems to cares about -
	[6,7]]
	   

Below is CTRL-C -> CTRL-V from from previous versions
=====================================================

e.g. output for above differences 2.a & 2.b
===========================================
create a file with below cmds. 
1. fallocate -o 0 -l 8K testfile.txt
2. xfs_io -c "pwrite 8K 8K" testfile.txt
3. check extent mapping:- xfs_io -c "fiemap -v" testfile.txt
4. run this binary on with and without these patches:- ./a.out (test_fiemap_diff.c) [4]

o/p of xfs_io -c "fiemap -v"
============================================
With this patch on patched kernel:-
testfile.txt:
 EXT: FILE-OFFSET      BLOCK-RANGE          TOTAL FLAGS
   0: [0..15]:         122802736..122802751    16 0x800
   1: [16..31]:        122687536..122687551    16   0x1

without patch on vanilla kernel (no difference):-
testfile.txt:
 EXT: FILE-OFFSET      BLOCK-RANGE          TOTAL FLAGS
   0: [0..15]:         332211376..332211391    16 0x800
   1: [16..31]:        332722392..332722407    16   0x1


o/p of a.out without patch:-
================
riteshh-> ./a.out 
logical: [       0..      15] phys: 332211376..332211391 flags: 0x800 tot: 16
(0) extent flag = 2048

o/p of a.out with patch (both point 2.a & 2.b could be seen)
=======================
riteshh-> ./a.out
logical: [       0..       7] phys: 122802736..122802743 flags: 0x801 tot: 8
(0) extent flag = 2049

FYI - In test_fiemap_diff.c test we had 
a. fm_extent_count = 1
b. fm_start = 0
c. fm_length = 4K
Whereas when we change fm_extent_count = 32, then we don't see any difference.

e.g. output for above difference listed in point 1.b
====================================================

o/p without patch (block no returned for unwritten block as well)
=========Testing IOCTL FIBMAP=========
File size = 16384, blkcnt = 4, blocksize = 4096
  0   41526422
  1   41526423
  2   41590299
  3   41590300

o/p with patch (0 returned for unwritten block)
=========Testing IOCTL FIBMAP=========
File size = 16384, blkcnt = 4, blocksize = 4096
  0          0          0
  1          0          0
  2   15335942      29953
  3   15335943      29953

Summary:-
========
Due to some of the observational differences to user, listed above,
requesting to please help with a careful review in moving this to iomap.
Digging into some older threads, it looks like these differences should be fine,
since the same tools have been working fine with XFS (which uses iomap based
implementation) [1]
Also as Ted suggested in [3]: Fiemap & bmap spec could be made based on the ext4
implementation. But since all the tools also work with xfs which uses iomap
based fiemap, so we should be good there.


References of some previous discussions:
=======================================
[RFCv1]: https://www.spinics.net/lists/linux-ext4/msg67077.html
[RFCv2]: https://marc.info/?l=linux-ext4&m=158020672413871&w=2 
[PATCHv3]: https://www.spinics.net/lists/linux-ext4/msg70403.html
[PATCHv4]: https://patchwork.ozlabs.org/project/linux-ext4/list/?series=161168
[1]: https://www.spinics.net/lists/linux-fsdevel/msg128370.html
[2]: https://www.spinics.net/lists/linux-fsdevel/msg127675.html
[3]: https://www.spinics.net/lists/linux-fsdevel/msg128368.html
[4]: https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/tools/test_fiemap_diff.c
[5]: https://marc.info/?l=linux-fsdevel&m=158040005907862&w=2
[6]: https://marc.info/?l=linux-fsdevel&m=158221859807604&w=2
[7]: https://marc.info/?l=linux-ext4&m=158228563431539&w=2

Ritesh Harjani (6):
  ext4: Add IOMAP_F_MERGED for non-extent based mapping
  ext4: Optimize ext4_ext_precache for 0 depth
  ext4: Move ext4 bmap to use iomap infrastructure.
  ext4: Make ext4_ind_map_blocks work with fiemap
  ext4: Move ext4_fiemap to use iomap framework.
  Documentation: Correct the description of FIEMAP_EXTENT_LAST

 Documentation/filesystems/fiemap.txt |  10 +-
 fs/ext4/extents.c                    | 299 +++++----------------------
 fs/ext4/inline.c                     |  41 ----
 fs/ext4/inode.c                      |  22 +-
 4 files changed, 80 insertions(+), 292 deletions(-)

-- 
2.21.0

