Return-Path: <linux-fsdevel+bounces-4400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053D77FF23D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26F21F20C23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BFC47A72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NeJBBMoZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8BD1715;
	Thu, 30 Nov 2023 05:53:49 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDnXKC001388;
	Thu, 30 Nov 2023 13:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=I4EWMLFOy1eJZwXfsCVABkVMsuSEuv+Jei1udxbxQWg=;
 b=NeJBBMoZ2jTcxxtiQqRVxMOnkn9+H9cYcY0rFEwQXLb9TgqLzXZn9yw7hjaj+06nHgh4
 Yl4ZIhMeWDhjkrcgpXgf8Bp37Guk7+zx3Rgy6oA9siMVNGMsaqkuNzKTGB8ZYzRBBkka
 3hUQ63MV8G0HgOvEFhEegkmvGN11EqJ26LRSLPt3XL/6nxd1CAqcCDA010qaX0u7fLsL
 /mwwRMJkmoSNhwFnMWhWzMvs/kx9KNleQN3n9BWOwuTwWTdRAmJvaPESFN+R+HT26ZeR
 W4i5XnFrIEcoGmtr292CzejtyJ47BdxVgUbkaWkG+/oB3mY/ac4MADQpCxVhTPBWxEo+ Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upu2vh3mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:44 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AUDowTT006599;
	Thu, 30 Nov 2023 13:53:43 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upu2vh3mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:43 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDnC7r029505;
	Thu, 30 Nov 2023 13:53:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfke1sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AUDrepf30212398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 13:53:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 867932004D;
	Thu, 30 Nov 2023 13:53:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02BCF20040;
	Thu, 30 Nov 2023 13:53:38 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.76.38])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Nov 2023 13:53:37 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: [RFC 5/7] block: export blkdev_atomic_write_valid() and refactor api
Date: Thu, 30 Nov 2023 19:23:14 +0530
Message-Id: <b53609d0d4b97eb9355987ac5ec03d4e89293b43.1701339358.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1701339358.git.ojaswin@linux.ibm.com>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZugCvRCajbO69dPqhlk8SBBZ4fODI8KN
X-Proofpoint-ORIG-GUID: c1vCyZy5Tdbw7RUuXr_sq8Rtv4ONgRya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=839 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300102

Export the blkdev_atomic_write_valid() function so that other filesystems
can call it as a part of validating the atomic write operation.

Further, refactor the api to accept a len argument instead of iov_iter to
make it easier to call from other places.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 block/fops.c           | 18 ++++++++++--------
 include/linux/blkdev.h |  2 ++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 516669ad69e5..5dae95c49720 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -41,8 +41,7 @@ static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
 		!bdev_iter_is_aligned(bdev, iter);
 }
 
-static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
-			      struct iov_iter *iter)
+bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos, size_t len)
 {
 	unsigned int atomic_write_unit_min_bytes =
 			queue_atomic_write_unit_min_bytes(bdev_get_queue(bdev));
@@ -53,16 +52,17 @@ static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
 		return false;
 	if (pos % atomic_write_unit_min_bytes)
 		return false;
-	if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
+	if (len % atomic_write_unit_min_bytes)
 		return false;
-	if (!is_power_of_2(iov_iter_count(iter)))
+	if (!is_power_of_2(len))
 		return false;
-	if (iov_iter_count(iter) > atomic_write_unit_max_bytes)
+	if (len > atomic_write_unit_max_bytes)
 		return false;
-	if (pos % iov_iter_count(iter))
+	if (pos % len)
 		return false;
 	return true;
 }
+EXPORT_SYMBOL_GPL(blkdev_atomic_write_valid);
 
 #define DIO_INLINE_BIO_VECS 4
 
@@ -81,7 +81,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
 
-	if (atomic_write && !blkdev_atomic_write_valid(bdev, pos, iter))
+	if (atomic_write &&
+	    !blkdev_atomic_write_valid(bdev, pos, iov_iter_count(iter)))
 		return -EINVAL;
 
 	if (nr_pages <= DIO_INLINE_BIO_VECS)
@@ -348,7 +349,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
 
-	if (atomic_write && !blkdev_atomic_write_valid(bdev, pos, iter))
+	if (atomic_write &&
+	    !blkdev_atomic_write_valid(bdev, pos, iov_iter_count(iter)))
 		return -EINVAL;
 
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f70988083734..5a3124fc191f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1566,6 +1566,8 @@ static inline int early_lookup_bdev(const char *pathname, dev_t *dev)
 int freeze_bdev(struct block_device *bdev);
 int thaw_bdev(struct block_device *bdev);
 
+bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos, size_t len);
+
 struct io_comp_batch {
 	struct request *req_list;
 	bool need_ts;
-- 
2.39.3


