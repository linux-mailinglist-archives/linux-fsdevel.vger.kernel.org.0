Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3597C48D0DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 04:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiAMD0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 22:26:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42864 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232022AbiAMD0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:26:45 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D2Ra6n034568;
        Thu, 13 Jan 2022 03:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VzIhrDGbujHD1bDEJMfS4SklRgGqkhYNXnMSPUm4yiY=;
 b=jJpkYToja4+V9ng2uECFMacAmXhDhYocZ7YgusJYpPMXjSDeROswwJMnzkNqzqFArm5h
 mw2yCVrFDyVO+2kkaIlbWo3vwMMpE6gPBk6f3Zt2QdKv8riAuXhQtxZHShUd08pHAp8I
 Py7j9Z4BcK36P8ZuSPJI/htJzdoEJBezoIbfNDu4Djmwxnm3nB8e4f7j0ToLv8YCWEUn
 p0Jta6LzNFm75HdI20MtiN1N/6nnUIpYJ5Qr6rLIN6C0JssQmwLLOZ15kfjr3eS5o9NX
 TcvWOpMpKf/+wqTJu34FPTJD/HvIiXi8ikXJQ075i0hMvtaAWmnAGKk+gr9xG8mwIThZ xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djban0s66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:40 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20D3Nj4a007761;
        Thu, 13 Jan 2022 03:26:40 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djban0s5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:40 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20D3CDjx005721;
        Thu, 13 Jan 2022 03:26:38 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3dfwhjhxq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:38 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20D3Qac626083628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 03:26:36 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12CC3AE053;
        Thu, 13 Jan 2022 03:26:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1931AE057;
        Thu, 13 Jan 2022 03:26:35 +0000 (GMT)
Received: from localhost (unknown [9.43.54.234])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 03:26:35 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/6] ext4: Fix error handling in ext4_restore_inline_data()
Date:   Thu, 13 Jan 2022 08:56:24 +0530
Message-Id: <e10d89e0184f47ccf9093f50276c2e188c19fd3f.1642044249.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642044249.git.riteshh@linux.ibm.com>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VCC3bMlbKoyJpjAy3oQBiOU8JctRjlai
X-Proofpoint-ORIG-GUID: z71xHYioVF_5XxDRLa1uT276K8mvidaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_01,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130013
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While running "./check -I 200 generic/475" it sometimes gives below
kernel BUG(). Ideally we should not call ext4_write_inline_data() if
ext4_create_inline_data() has failed.

<log snip>
[73131.453234] kernel BUG at fs/ext4/inline.c:223!

<code snip>
 212 static void ext4_write_inline_data(struct inode *inode, struct ext4_iloc *iloc,
 213                                    void *buffer, loff_t pos, unsigned int len)
 214 {
<...>
 223         BUG_ON(!EXT4_I(inode)->i_inline_off);
 224         BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);

This patch handles the error and prints out a emergency msg saying potential
data loss for the given inode (since we couldn't restore the original
inline_data due to some previous error).

[ 9571.070313] EXT4-fs (dm-0): error restoring inline_data for inode -- potential data loss! (inode 1703982, error -30)

Reported-by: Eric Whitney <enwlinux@gmail.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inline.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 534c0329e110..31741e8a462e 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1135,7 +1135,15 @@ static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
 				     struct ext4_iloc *iloc,
 				     void *buf, int inline_size)
 {
-	ext4_create_inline_data(handle, inode, inline_size);
+	int ret;
+
+	ret = ext4_create_inline_data(handle, inode, inline_size);
+	if (ret) {
+		ext4_msg(inode->i_sb, KERN_EMERG,
+			"error restoring inline_data for inode -- potential data loss! (inode %lu, error %d)",
+			inode->i_ino, ret);
+		return;
+	}
 	ext4_write_inline_data(inode, iloc, buf, 0, inline_size);
 	ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 }
-- 
2.31.1

