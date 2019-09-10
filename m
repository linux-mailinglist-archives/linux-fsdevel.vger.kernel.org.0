Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFBCAEEF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 17:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436606AbfIJPuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 11:50:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57512 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732013AbfIJPuM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:50:12 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8AFlgLL008223;
        Tue, 10 Sep 2019 11:50:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxcvdkupq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 11:50:05 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8AFlkhj008433;
        Tue, 10 Sep 2019 11:50:03 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxcvdkunx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 11:50:02 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8AFo1Kt017117;
        Tue, 10 Sep 2019 15:50:01 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 2uv467aw3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 15:50:01 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8AFo02f46465320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 15:50:00 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80678112066;
        Tue, 10 Sep 2019 15:50:00 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C283112064;
        Tue, 10 Sep 2019 15:49:57 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.1.89])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Sep 2019 15:49:56 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ebiggers@kernel.org, hch@infradead.org,
        chandanrlinux@gmail.com
Subject: [PATCH RESEND V5 6/7] ext4: Enable encryption for subpage-sized blocks
Date:   Tue, 10 Sep 2019 21:21:14 +0530
Message-Id: <20190910155115.28550-7-chandan@linux.ibm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190910155115.28550-1-chandan@linux.ibm.com>
References: <20190910155115.28550-1-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100149
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

