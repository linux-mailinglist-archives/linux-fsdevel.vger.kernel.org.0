Return-Path: <linux-fsdevel+bounces-4395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A0E7FF2B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728A52826AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2802D51016
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j0M+lOl+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97900170C;
	Thu, 30 Nov 2023 05:53:35 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDnXcU001367;
	Thu, 30 Nov 2023 13:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=HeP1XueRhjsHpWAhcUWUNoyK0cnx/fEeEMwzhs6stek=;
 b=j0M+lOl+IpGdqDyYvXUzR7gbQAgSqThCFgfMYqKNSKd8sbyOQiIWq+1rSYlpbnJ3T/1w
 UyxeBzbZEw+DYcO38YmgbMINrTYt1GhA2kJaUxURDpSWzF0Gmno2dgqpG2oCY7KatdDp
 tvq39mWK1Q7+n/43FwGJuq0m4XMGg31GJvBieIkV6++gBIBORymAPwoqAjXMun7RmB9R
 FR1UiaQ2+kOsywwmAsyfRnl193efWwThZC1jaKbht1dvmZVjRRZ3vQofcrOQtJBfO/T7
 jwpcd0f5E0wtKZMt1/UWMtcmhfkG8Ef//wsoBrHsOOeg96ZT4dBM81ZtuCACOUdjJHp+ Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upu2vh3b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:25 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AUDniCu002718;
	Thu, 30 Nov 2023 13:53:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upu2vh3ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:24 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDnBHU029486;
	Thu, 30 Nov 2023 13:53:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfke1qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AUDrLWM23528130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 13:53:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6CD82004D;
	Thu, 30 Nov 2023 13:53:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7149B20043;
	Thu, 30 Nov 2023 13:53:19 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.76.38])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Nov 2023 13:53:19 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: [RFC 0/7] ext4: Allocator changes for atomic write support with DIO
Date: Thu, 30 Nov 2023 19:23:08 +0530
Message-Id: <cover.1701339358.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hBD7kWuO7Nb_vj1mPT_00MLQichdLJ_H
X-Proofpoint-ORIG-GUID: zeJyHyfHU1L2PEvisQEtnw9KtFa1_K0H
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300102

This patch series builds on top of John Gary's atomic direct write 
patch series [1] and enables this support in ext4. This is a 2 step
process:

1. Enable aligned allocation in ext4 mballoc. This allows us to allocate
power-of-2 aligned physical blocks, which is needed for atomic writes.

2. Hook the direct IO path in ext4 to use aligned allocation to obtain 
physical blocks at a given alignment, which is needed for atomic IO. If 
for any reason we are not able to obtain blocks at given alignment we
fail the atomic write.

Currently this RFC does not impose any restrictions for atomic and non-atomic
allocations to any inode,  which also leaves policy decisions to user-space
as much as possible. So, for example, the user space can:

 * Do an atomic direct IO at any alignment and size provided it
   satisfies underlying device constraints. The only restriction for now
   is that it should be power of 2 len and atleast of FS block size.

 * Do any combination of non atomic and atomic writes on the same file
   in any order. As long as the user space is passing the RWF_ATOMIC flag 
   to pwritev2() it is guaranteed to do an atomic IO (or fail if not
   possible).

There are some TODOs on the allocator side which are remaining like...

1.  Fallback to original request size when normalized request size (due to
    preallocation) allocation is not possible.
2.  Testing some edge cases.

But since all the basic test scenarios were covered, hence we wanted to get
this RFC out for discussion on atomic write support for DIO in ext4.

Further points for discussion -

1. We might need an inode flag to identify that the inode has blocks/extents
atomically allocated. So that other userspace tools do not move the blocks of
the inode for e.g. during resize/fsck etc.
  a. Should inode be marked as atomic similar to how we have IS_DAX(inode)
  implementation? Any thoughts?

2. Should there be support for open flags like O_ATOMIC. So that in case if
user wants to do only atomic writes to an open fd, then all writes can be
considered atomic.

3. Do we need to have any feature compat flags for FS? (IMO) It doesn't look
like since say if there are block allocations done which were done atomically,
it should not matter to FS w.r.t compatibility.

4. Mostly aligned allocations are required when we don't have data=journal
mode. So should we return -EIO with data journalling mode for DIO request?

Script to test using pwritev2() can be found here: 
https://gist.github.com/OjaswinM/e67accee3cbb7832bd3f1a9543c01da9

Regards,
ojaswin

[1] https://lore.kernel.org/linux-fsdevel/20230929102726.2985188-1-john.g.garry@oracle.com


Ojaswin Mujoo (7):
  iomap: Don't fall back to buffered write if the write is atomic
  ext4: Factor out size and start prediction from
    ext4_mb_normalize_request()
  ext4: add aligned allocation support in mballoc
  ext4: allow inode preallocation for aligned alloc
  block: export blkdev_atomic_write_valid() and refactor api
  ext4: Add aligned allocation support for atomic direct io
  ext4: Support atomic write for statx

 block/fops.c                |  18 ++-
 fs/ext4/ext4.h              |  10 +-
 fs/ext4/extents.c           |  14 ++
 fs/ext4/file.c              |  49 ++++++
 fs/ext4/inode.c             | 142 ++++++++++++++++-
 fs/ext4/mballoc.c           | 302 +++++++++++++++++++++++++-----------
 fs/iomap/direct-io.c        |   8 +-
 include/linux/blkdev.h      |   2 +
 include/trace/events/ext4.h |   2 +
 9 files changed, 442 insertions(+), 105 deletions(-)

-- 
2.39.3


