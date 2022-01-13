Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E089A48D0E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 04:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiAMD0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 22:26:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232040AbiAMD0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:26:48 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D2qo3K026132;
        Thu, 13 Jan 2022 03:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DVMWYk/SJRApyN/h1TV5KER0hps4EgWw7ET13qCmni8=;
 b=Kc2TN7/vXI3PM40dTrX6porHlQ9AVZQ+VOXZfl/md/B6v/wsZRjOtmrKZwx5SDfceJzG
 XWxPBmk3q357iECLuBmLAfCJi5se5n/S4w3C+NzxhsVT7/0TumbK7i5Y6icL9Gxmt9Ag
 AIrTSYoJpsh4OzsEA8Obgf0AhR0bvHQQOTO+3Ryy+J6mNWoVOYhHDJFWog8ijjhS3SuZ
 TynR3qZwGnQDLHZqRmEMAbLCXPRMb9lHRxKrv+4iw/37lpW1Ux3zrLEO8fMlgtvbkmNW
 hQUxetqOXVhH/UvZyuVPJ48sZKdWM0vKui0hgyp4MAx+LU1JcjYgTIeulHv7zTc0lsv6 MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3djbpg0eee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:43 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20D3NcLV029307;
        Thu, 13 Jan 2022 03:26:43 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3djbpg0ee3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:43 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20D3C9Uc029236;
        Thu, 13 Jan 2022 03:26:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3df28aerfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:41 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20D3QdoU47448434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 03:26:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1203CAE056;
        Thu, 13 Jan 2022 03:26:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5092AE051;
        Thu, 13 Jan 2022 03:26:37 +0000 (GMT)
Received: from localhost (unknown [9.43.54.234])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 03:26:37 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 2/6] ext4: Remove redundant max inline_size check in ext4_da_write_inline_data_begin()
Date:   Thu, 13 Jan 2022 08:56:25 +0530
Message-Id: <fc7f7b3ad709da48c49ab14a2ce86e00a7defe0e.1642044249.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642044249.git.riteshh@linux.ibm.com>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m0tQry8WTKc6XNQ2g6eBz5A72J_z3kJz
X-Proofpoint-GUID: lOwRXwz2KvowKjW7BCbxJHvRoRp916oq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_01,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=768 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130013
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4_prepare_inline_data() already checks for ext4_get_max_inline_size()
and returns -ENOSPC. So there is no need to check it twice within
ext4_da_write_inline_data_begin(). This patch removes the extra check.

It also makes it more clean.

No functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inline.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 31741e8a462e..c52b0037983d 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -913,7 +913,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 				    struct page **pagep,
 				    void **fsdata)
 {
-	int ret, inline_size;
+	int ret;
 	handle_t *handle;
 	struct page *page;
 	struct ext4_iloc iloc;
@@ -930,14 +930,9 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		goto out;
 	}
 
-	inline_size = ext4_get_max_inline_size(inode);
-
-	ret = -ENOSPC;
-	if (inline_size >= pos + len) {
-		ret = ext4_prepare_inline_data(handle, inode, pos + len);
-		if (ret && ret != -ENOSPC)
-			goto out_journal;
-	}
+	ret = ext4_prepare_inline_data(handle, inode, pos + len);
+	if (ret && ret != -ENOSPC)
+		goto out_journal;
 
 	/*
 	 * We cannot recurse into the filesystem as the transaction
-- 
2.31.1

