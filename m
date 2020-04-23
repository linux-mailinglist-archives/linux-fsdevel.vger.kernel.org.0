Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5BB1B598D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgDWKsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 06:48:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727019AbgDWKsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:48:21 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NAWvXE101948
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:48:20 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ghu8x8yw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:48:20 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 23 Apr 2020 11:47:29 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Apr 2020 11:47:26 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03NAmDUC17498296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 10:48:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40BC711C066;
        Thu, 23 Apr 2020 10:48:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1FE211C054;
        Thu, 23 Apr 2020 10:48:09 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.60.18])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Apr 2020 10:48:09 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        darrick.wong@oracle.com, hch@infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
Date:   Thu, 23 Apr 2020 16:17:52 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042310-0016-0000-0000-00000309D122
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042310-0017-0000-0000-0000336DF229
Message-Id: <cover.1587555962.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_07:2020-04-22,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230078
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello All,

Here are some changes, which as I understand, takes the right approach in fixing
the offset/length bounds check problem reported in threads [1]-[2].
These warnings in iomap_apply/ext4 path are reported after ext4_fiemap()
was moved to use iomap framework and when overlayfs is mounted on top of ext4.
Though the issues were identified after ext4 moved to iomap framework, but
these changes tries to fix the problem which are anyways present in current code
irrespective of ext4 using iomap framework for fiemap or not.

Patch 1 & 4 commit msg may give more details of the problem.

Tests done
==========
1. Tested xfstest-suite with "-g quick" & "-overlay -g quick" configuration
on a 4k blocksize on x86 & Power. There were no new failures reported
due to these changes.
2. Tested syzcaller reported problem with this change. [1]
3. Tested below change which was reported by Murphy. [2]
	The minimal reproducer is:
	-------------------------------------
	fallocate -l 256M test.img
	mkfs.ext4 -Fq -b 4096 -I 256 test.img
	mkdir -p test
	mount -o loop test.img test || exit
	pushd test
	rm -rf l u w m
	mkdir -p l u w m
	mount -t overlay -o lowerdir=l,upperdir=u,workdir=w overlay m || exit
	xfs_io -f -c "pwrite 0 4096" -c "fiemap"  m/tf
	umount m
	rm -rf l u w m
	popd
	umount -d test
	rm -rf test test.img
	-------------------------------------

Comments/feedback are much welcome!!

References
==========
[1]: https://lkml.org/lkml/2020/4/11/46
[2]: https://patchwork.ozlabs.org/project/linux-ext4/patch/20200418233231.z767yvfiupy7hwgp@xzhoux.usersys.redhat.com/ 


Ritesh Harjani (5):
  ext4: Fix EXT4_MAX_LOGICAL_BLOCK macro
  ext4: Rename fiemap_check_ranges() to make it ext4 specific
  vfs: EXPORT_SYMBOL for fiemap_check_ranges()
  overlayfs: Check for range bounds before calling i_op->fiemap()
  ext4: Get rid of ext4_fiemap_check_ranges

 fs/ext4/ext4.h       |  2 +-
 fs/ext4/ioctl.c      | 23 -----------------------
 fs/ioctl.c           |  5 +++--
 fs/overlayfs/inode.c |  7 ++++++-
 include/linux/fs.h   |  2 ++
 5 files changed, 12 insertions(+), 27 deletions(-)

-- 
2.21.0

