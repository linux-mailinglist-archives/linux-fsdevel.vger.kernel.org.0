Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9BF9D89E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 09:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbfJPHhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 03:37:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387438AbfJPHhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:37:36 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G7bKsh095348
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 03:37:35 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vnvb1n4jw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 03:37:35 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 16 Oct 2019 08:37:33 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 08:37:30 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9G7bTdw11403350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 07:37:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 180B0AE058;
        Wed, 16 Oct 2019 07:37:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 664DAAE045;
        Wed, 16 Oct 2019 07:37:26 +0000 (GMT)
Received: from dhcp-9-199-158-105.in.ibm.com (unknown [9.199.158.105])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 07:37:25 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: [RFC 5/5] ext4: Enable blocksize < pagesize for dioread_nolock
Date:   Wed, 16 Oct 2019 13:07:11 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016073711.4141-1-riteshh@linux.ibm.com>
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101607-0020-0000-0000-000003797C3F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101607-0021-0000-0000-000021CF9E44
Message-Id: <20191016073711.4141-6-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=550 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160071
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All support is now added for blocksize < pagesize for dioread_nolock.
This patch removes those checks which disables dioread_nolock
feature for blocksize != pagesize.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/super.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..7796e2ffc294 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2105,16 +2105,6 @@ static int parse_options(char *options, struct super_block *sb,
 		}
 	}
 #endif
-	if (test_opt(sb, DIOREAD_NOLOCK)) {
-		int blocksize =
-			BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
-
-		if (blocksize < PAGE_SIZE) {
-			ext4_msg(sb, KERN_ERR, "can't mount with "
-				 "dioread_nolock if block size != PAGE_SIZE");
-			return 0;
-		}
-	}
 	return 1;
 }
 
-- 
2.21.0

