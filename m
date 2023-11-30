Return-Path: <linux-fsdevel+bounces-4396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A2D7FF2B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A199B20B5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B405100B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ungc5id+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3761709;
	Thu, 30 Nov 2023 05:53:36 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDFpFE006446;
	Thu, 30 Nov 2023 13:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PNIwPfumSNnVlUUlBo/GDih8RAKZHb0Z2KAJ+LhauC0=;
 b=Ungc5id+xDFLfOdwyqgvYbHfIvdJ1LgR1wfvB8HEWxM6aTunXdel15SkCiDS1+DH2NxQ
 4dV6369cWKoDjbwBdL/ZsSevfNX97wwl6feyvymUaI3e7R6anF/EkNbYmlNM87v+IYC9
 zWxKQsSA41B2sAD4mzLkTjz4oMr2AZJ4XStc0N4rZH9M+gozec21C8Qq3obLK3BKYK7g
 tmqKxjiwNRBnWE0bf2/HaOSyKeVDnwLzb/1UJbk5WS1WHHNSVm/tEh2u9xSFEqqZK3tn
 dGO9e+wbLEW6uEJkWGGepCx4rrNFvPPCJK9zeWAWVKzaq8knbq56Iz/aIRGZEova45eJ /A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upu4b983u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:31 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AUDGX1i008254;
	Thu, 30 Nov 2023 13:53:30 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upu4b983b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDmw70006089;
	Thu, 30 Nov 2023 13:53:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy25vsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AUDrSUq6554294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 13:53:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFABF2004B;
	Thu, 30 Nov 2023 13:53:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CF7720043;
	Thu, 30 Nov 2023 13:53:25 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.76.38])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Nov 2023 13:53:25 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: [RFC 1/7] iomap: Don't fall back to bufferred write if the write is atomic
Date: Thu, 30 Nov 2023 19:23:10 +0530
Message-Id: <4c29ab39998ef21898e930ad78588d105f4d81a5.1701247289.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1701247289.git.ojaswin@linux.ibm.com>
References: <cover.1701247289.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F5E9TSUM1DCcqBAO5JInTGaNPQrrdbge
X-Proofpoint-GUID: Ezm7edadeu2lyI1-UAjDTOwNZDGRhuxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=824 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300102

Currently, iomap only supports atomic writes for direct IOs and there is
no guarantees that a bufferred IO will be atomic. Hence, if the user has
explicitly requested the direct write to be atomic and there's a
failure, return -EIO instead of falling back to bufferred IO.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/iomap/direct-io.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 6ef25e26f1a1..d7e6c6eacbf7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -662,7 +662,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			if (ret != -EAGAIN) {
 				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
 								iomi.len);
-				ret = -ENOTBLK;
+				/*
+				 * if this write was supposed to be atomic,
+				 * return the err rather than trying to fall
+				 * back to bufferred IO.
+				 */
+				if (!atomic_write)
+					ret = -ENOTBLK;
 			}
 			goto out_free_dio;
 		}
-- 
2.39.3


