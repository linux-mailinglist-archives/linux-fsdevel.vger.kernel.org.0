Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA579B0C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 15:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405455AbfHWNYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 09:24:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392194AbfHWNYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:24:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NDMx6b042890;
        Fri, 23 Aug 2019 09:24:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ujf5g4jqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 09:24:37 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7NDObqs048269;
        Fri, 23 Aug 2019 09:24:37 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ujf5g4jpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 09:24:37 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7NDLHLa004287;
        Fri, 23 Aug 2019 13:24:34 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 2uj099my3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 13:24:34 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7NDOZ3U12714612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Aug 2019 13:24:35 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39200AC05E;
        Fri, 23 Aug 2019 13:24:35 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8586AC05B;
        Fri, 23 Aug 2019 13:24:31 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.53.214])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 23 Aug 2019 13:24:31 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ebiggers@kernel.org, hch@infradead.org,
        chandanrlinux@gmail.com
Subject: [PATCH V5 6/7] ext4: Enable encryption for subpage-sized blocks
Date:   Fri, 23 Aug 2019 18:55:41 +0530
Message-Id: <20190823132542.13434-7-chandan@linux.ibm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190823132542.13434-1-chandan@linux.ibm.com>
References: <20190823132542.13434-1-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230138
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we have the code to support encryption for subpage-sized
blocks, this commit removes the conditional check in filesystem mount
code.

The commit also changes the support statement in
Documentation/filesystems/fscrypt.rst to reflect the fact that
encryption of filesystems with blocksize less than page size now works.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 Documentation/filesystems/fscrypt.rst | 4 ++--
 fs/ext4/super.c                       | 7 -------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 08c23b60e016..c3efe86bf2b2 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -213,8 +213,8 @@ Contents encryption
 -------------------
 
 For file contents, each filesystem block is encrypted independently.
-Currently, only the case where the filesystem block size is equal to
-the system's page size (usually 4096 bytes) is supported.
+Starting from Linux kernel 5.4, encryption of filesystems with block
+size less than system's page size is supported.
 
 Each block's IV is set to the logical block number within the file as
 a little endian number, except that:
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5b92054bf8ea..d580e71ad9c7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4322,13 +4322,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		}
 	}
 
-	if ((DUMMY_ENCRYPTION_ENABLED(sbi) || ext4_has_feature_encrypt(sb)) &&
-	    (blocksize != PAGE_SIZE)) {
-		ext4_msg(sb, KERN_ERR,
-			 "Unsupported blocksize for fs encryption");
-		goto failed_mount_wq;
-	}
-
 	if (DUMMY_ENCRYPTION_ENABLED(sbi) && !sb_rdonly(sb) &&
 	    !ext4_has_feature_encrypt(sb)) {
 		ext4_set_feature_encrypt(sb);
-- 
2.19.1

