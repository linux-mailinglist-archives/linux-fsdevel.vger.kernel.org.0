Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4354BC6E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Feb 2022 09:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbiBSIKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Feb 2022 03:10:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiBSIJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Feb 2022 03:09:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7663C5C346;
        Sat, 19 Feb 2022 00:09:40 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21J66vXE026801;
        Sat, 19 Feb 2022 08:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=cYs92ukqP6Kc1Qt0PRBoSN4oMZR6wMODxe+0lCpjYxo=;
 b=okO4ujBgKp4szNB2CGpEBkn338UnBnH4JRIHShxR/p8H+0La1Jxn+TTroTmCeN1XtNkH
 uVHrNkgMG/4Wht3CQpl8Zt4EeGt3UDqib1GuMNBH4M1hjtJ/QpxmrwlGRlcZC8NE5lx8
 4hgvBr6qcs30TKvKlhGw7LYU+0clVMuno8mdFM7ZBxSyhZO85BBTFjuL+APd9Z+Bna4m
 nPxKEVagKq3q6NW65B3VjkrdnDi6jR8ZdL6virlXdc+2LST2uzdSuugZ08w23Mb32gbt
 r2BqTAEfRSgD4A6PfkroMxUPk7Qy+1BC8hCb92q9twfLwlZzJGAkiMDzOjeQCwND4Bym ng== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3earxmauc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Feb 2022 08:09:39 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21J88072004910;
        Sat, 19 Feb 2022 08:09:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3eaqthh077-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Feb 2022 08:09:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21J89ZrW56099092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Feb 2022 08:09:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4638AA4054;
        Sat, 19 Feb 2022 08:09:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8667A405C;
        Sat, 19 Feb 2022 08:09:33 +0000 (GMT)
Received: from localhost (unknown [9.43.86.157])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 19 Feb 2022 08:09:33 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 REBASED] bad_inode: add missing i_op initializers for fileattr_get/_set
Date:   Sat, 19 Feb 2022 13:39:17 +0530
Message-Id: <456975d5d84b1098d5edc49619cfd9a736fc8594.1645257680.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3Wa0HFIGiUoQbEYHsSa99hd7EmJB-XGX
X-Proofpoint-ORIG-GUID: 3Wa0HFIGiUoQbEYHsSa99hd7EmJB-XGX
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-19_02,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 clxscore=1011 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202190051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's bring inode_operations in sync for bad_inode_ops.
Some of the reasons for doing this are listed here [1].
But mostly it is just for completeness sake.

[1]: https://lore.kernel.org/lkml/1473708559-12714-2-git-send-email-mszeredi@redhat.com/

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
v1 -> v2
1. Rebased.
2. Removed end of line whitespace fixes as it could quickly give conflicts
   while applying.

 fs/bad_inode.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 12b8fdcc445b..cefd4ed8d5b2 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -160,6 +160,17 @@ static int bad_inode_set_acl(struct user_namespace *mnt_userns,
 	return -EIO;
 }

+static int bad_inode_fileattr_set(struct user_namespace *mnt_userns,
+			struct dentry *dentry, struct fileattr *fa)
+{
+	return -EIO;
+}
+
+static int bad_inode_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	return -EIO;
+}
+
 static const struct inode_operations bad_inode_ops =
 {
 	.create		= bad_inode_create,
@@ -183,6 +194,8 @@ static const struct inode_operations bad_inode_ops =
 	.atomic_open	= bad_inode_atomic_open,
 	.tmpfile	= bad_inode_tmpfile,
 	.set_acl	= bad_inode_set_acl,
+	.fileattr_set	= bad_inode_fileattr_set,
+	.fileattr_get	= bad_inode_fileattr_get,
 };


--
2.25.1

