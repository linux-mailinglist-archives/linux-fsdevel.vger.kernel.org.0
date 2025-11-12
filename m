Return-Path: <linux-fsdevel+bounces-68045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3D8C51D80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 12:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBE81898AE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E042030C63B;
	Wed, 12 Nov 2025 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zsp8IGGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50312FDC5B;
	Wed, 12 Nov 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945647; cv=none; b=TZHbf8IyX+R1iYjLC2ph56osZrXh47Zwk7vd23ZUnjNkFxwxu9z3wDyvWCuzIX+Eu0MI8RowT1XvXhoUPrFIfFn7/taWhXsAzooAQdMZA5d0nkDefAE6hDkcX5h1Bkto+CeMwLXXaCGWO5cOemmX//ANgfWZ6GhNPVXeX6XcyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945647; c=relaxed/simple;
	bh=FLWRr/VJnjjspZmZZKRG6gNx20Ea2h0RZt55siqHEDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKGJg8YwKsn+a/ugtPRz/bS/wJelXSnty1P4hqwKL00HHdUmNTlPQlcmFRFGzwsO6WrpuDBnmYLybiGJnmgQ+HmqUkFoYeAmG4kgezHy1C39QEopW4wNDYowZ3DxOKg5VWXlI8MMSxK4VAuXnGlaGyCuCZsMWzN2mq8J8VImOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zsp8IGGU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC8Fa48031499;
	Wed, 12 Nov 2025 11:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w0hJMBz/zYmRWuH4t
	0r130WbFyOsxHRTCGHuO8OgZVY=; b=Zsp8IGGUX0adacqK7k+ZyC2gQLUArA5kD
	P+0u9+6r5JIOnIyHFQxeyhhUP9Kqww/MqrIuT2Lj8BF4R3Cuykd/4HflkKAU0VVD
	jiebOKq6ZfQ/ZYBZTVGF3yhEOjyxGbvyep1sdNt0Kc3i4FsQ6JUKmcznoniSP0yG
	JUwyoIMUodg3UmfGJnsKoz1ybPnxg2pfzxn+0TDNXZtIokV1z+1kzkmZetphg6G9
	dQNQIA+ulOQQoCq99KdZRB0tOn0ZokgTx6XsNUlN63o5KhvGM6JIzd60cvVhWqHd
	Ruaq8bvWXeSgHNIXchpqllc40cx9tp3AVnghct3kvPNA+utXwWqsQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8a21g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:06:56 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACB3dNv020273;
	Wed, 12 Nov 2025 11:06:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8a21c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:06:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC9llv6011431;
	Wed, 12 Nov 2025 11:06:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1fe98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:06:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACB6rFc23003476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 11:06:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14C5520043;
	Wed, 12 Nov 2025 11:06:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DFC020040;
	Wed, 12 Nov 2025 11:06:48 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 11:06:48 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
        ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
        willy@infradead.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
        martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 2/8] mm: Add PG_atomic
Date: Wed, 12 Nov 2025 16:36:05 +0530
Message-ID: <5f0a7c62a3c787f2011ada10abe3826a94f99e17.1762945505.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762945505.git.ojaswin@linux.ibm.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX3xol3abUgNip
 VKmyz7/RYq4tsPh3Uh4rPsga9jfsU05AW8tRZQGbW3X6tXhsPNG/YF0HRPqdfGBlttXVt+3+SdO
 NUb8c2JaqU8RymN5dbs5OABEMaoGMm238koxi0/ZUcHsfSiSi0B7fuMijWaugmoq3kObX8iBzhL
 qqOP7xaDCra7Me6fqcTUCpOa6E2wPgesSgh0En0u6lydJC6KXXfus3W1btuuK/NCUjRBZtC+0If
 AIDXIPhF3hIaRtOylujdeiW/UmTt2KK4c5XE8hWi30uZwZWDdbSFrKoTdvASyqGIP67+4RWb8h3
 36wR4zZJ1QOQdG0EKXvrbIFyRjIow1Q6aazKbEhVeZmtjEg9trRXuozyO1Y56SYi/JKgM6KYBrW
 4IbyCo+hDnmmqYMAuoBDVLP2SbldOg==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=69146a50 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
 a=tnb4hg_zOA4vhegj2c4A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: jBYtFSONvtiNMU_wrHLkJ11-nJl7Gx4o
X-Proofpoint-GUID: xD3cfsMfEHARDSfeDAr-NdTOxU0oXER0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

From: John Garry <john.g.garry@oracle.com>

Add page flag PG_atomic, meaning that a folio needs to be written back
atomically. This will be used by for handling RWF_ATOMIC buffered IO
in upcoming patches.

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/page-flags.h     | 5 +++++
 include/trace/events/mmflags.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0091ad1986bf..bdce0f58a77a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -111,6 +111,7 @@ enum pageflags {
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
 	PG_dropbehind,		/* drop pages on IO completion */
+	PG_atomic,		/* Page is marked atomic for buffered atomic writes */
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
@@ -644,6 +645,10 @@ FOLIO_FLAG(unevictable, FOLIO_HEAD_PAGE)
 	__FOLIO_CLEAR_FLAG(unevictable, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_CLEAR_FLAG(unevictable, FOLIO_HEAD_PAGE)
 
+FOLIO_FLAG(atomic, FOLIO_HEAD_PAGE)
+	__FOLIO_CLEAR_FLAG(atomic, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_CLEAR_FLAG(atomic, FOLIO_HEAD_PAGE)
+
 #ifdef CONFIG_MMU
 FOLIO_FLAG(mlocked, FOLIO_HEAD_PAGE)
 	__FOLIO_CLEAR_FLAG(mlocked, FOLIO_HEAD_PAGE)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index aa441f593e9a..a8294f6146a5 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -159,7 +159,8 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 	DEF_PAGEFLAG_NAME(reclaim),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
 	DEF_PAGEFLAG_NAME(unevictable),					\
-	DEF_PAGEFLAG_NAME(dropbehind)					\
+	DEF_PAGEFLAG_NAME(dropbehind),					\
+	DEF_PAGEFLAG_NAME(atomic)					\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
 IF_HAVE_PG_IDLE(idle)							\
-- 
2.51.0


