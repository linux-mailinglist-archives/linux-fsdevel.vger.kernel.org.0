Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51291B59A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 12:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgDWKs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 06:48:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727121AbgDWKs6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:48:58 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NAW5Eh092853
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:48:58 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmua8j23-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:48:57 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 23 Apr 2020 11:48:31 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Apr 2020 11:48:26 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03NAmnrL66650428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 10:48:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEB3111C04A;
        Thu, 23 Apr 2020 10:48:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85F7711C054;
        Thu, 23 Apr 2020 10:48:46 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.60.18])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Apr 2020 10:48:46 +0000 (GMT)
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
Subject: [PATCH 4/5] overlayfs: Check for range bounds before calling i_op->fiemap()
Date:   Thu, 23 Apr 2020 16:17:56 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1587555962.git.riteshh@linux.ibm.com>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042310-0012-0000-0000-000003A9CB93
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042310-0013-0000-0000-000021E71F83
Message-Id: <39b4bf94f6723831a9798237bb1b4ae14da04d98.1587555962.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_07:2020-04-22,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230078
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Underlying fs may not be able to handle the length in fiemap
beyond sb->s_maxbytes. So similar to how VFS ioctl does it,
add fiemap_check_ranges() check in ovl_fiemap() as well
before calling underlying fs i_op->fiemap() call.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/overlayfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 79e8994e3bc1..9bcd2e96faad 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -455,16 +455,21 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	int err;
 	struct inode *realinode = ovl_inode_real(inode);
 	const struct cred *old_cred;
+	u64 length;
 
 	if (!realinode->i_op->fiemap)
 		return -EOPNOTSUPP;
 
+	err = fiemap_check_ranges(realinode->i_sb, start, len, &length);
+	if (err)
+		return err;
+
 	old_cred = ovl_override_creds(inode->i_sb);
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC)
 		filemap_write_and_wait(realinode->i_mapping);
 
-	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
+	err = realinode->i_op->fiemap(realinode, fieinfo, start, length);
 	revert_creds(old_cred);
 
 	return err;
-- 
2.21.0

