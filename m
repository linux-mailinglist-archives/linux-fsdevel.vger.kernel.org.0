Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBFC48C79E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 16:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245419AbiALPui (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 10:50:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354801AbiALPuh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:50:37 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CDr3fL011534;
        Wed, 12 Jan 2022 15:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=gvXyv6y0de7RxzTlYNgGytlYQXgkL979msr2pglbkzA=;
 b=Ae+ayH33o66KoDLa5Yi7yWoLFGxWzELQ6E4oyMnX49ZnZYW9ZGIymUp6+N9vYKaypIbF
 qo5vOiwLbhIK+v81l0fdG8zEWA6KOLSUHee/6Kx+VDHNwuK5brAXVnp/gZtKVouH/nvs
 DOrj5AVQuFJ5HjcgoxBf4daWfN2jPrVS6EIVN8PWfs4GEQ4IRnPqJdRDBKosOCte1vEm
 B637jEmAufBMvt7g0W2c699i7S89ID64/13dIVdQzGtiOwSDXzd9HwyMwGmbZ4wpZVp4
 Uo+H07Nf6guZECYSUJm3hCk6VBnXFE45fvEvBM08Tq7ltQ730cL1ZMswLT2diNMTcYM/ FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dhwp77mmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 15:50:36 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20CFZLUB008419;
        Wed, 12 Jan 2022 15:50:36 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dhwp77mk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 15:50:35 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20CFWK6j017187;
        Wed, 12 Jan 2022 15:50:33 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3df289kjuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 15:50:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20CFoVJT46727654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 15:50:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E429C52050;
        Wed, 12 Jan 2022 15:50:30 +0000 (GMT)
Received: from localhost (unknown [9.43.59.72])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 791D35204F;
        Wed, 12 Jan 2022 15:50:30 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH] bad_inode: add missing i_op initializers for fileattr_get/_set
Date:   Wed, 12 Jan 2022 21:20:16 +0530
Message-Id: <4bdc14fd6bf5cbe17bebeea2165840a2af6c4cf8.1642002262.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IxsI07RNVCVofNu5WgP0Cd2KrGvcCl3T
X-Proofpoint-ORIG-GUID: yOwbug3xl1rW0AWhmWnzgpMIDTNWK2Q0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120102
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's bring inode_operations in sync for bad_inode_ops.
Some of the reasons are listed here [1]. But mostly it is
just for completeness sake I think.

This patch also removes some of the whitespaces at the end of line
which is due to my editor config settings for kernel work.

[1]: https://lore.kernel.org/lkml/1473708559-12714-2-git-send-email-mszeredi@redhat.com/

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/bad_inode.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 12b8fdcc445b..08d5e44316cc 100644
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
@@ -183,18 +194,19 @@ static const struct inode_operations bad_inode_ops =
 	.atomic_open	= bad_inode_atomic_open,
 	.tmpfile	= bad_inode_tmpfile,
 	.set_acl	= bad_inode_set_acl,
+	.fileattr_set	= bad_inode_fileattr_set,
+	.fileattr_get	= bad_inode_fileattr_get,
 };

-
 /*
  * When a filesystem is unable to read an inode due to an I/O error in
  * its read_inode() function, it can call make_bad_inode() to return a
- * set of stubs which will return EIO errors as required.
+ * set of stubs which will return EIO errors as required.
  *
  * We only need to do limited initialisation: all other fields are
  * preinitialised to zero automatically.
  */
-
+
 /**
  *	make_bad_inode - mark an inode bad due to an I/O error
  *	@inode: Inode to mark bad
@@ -203,7 +215,7 @@ static const struct inode_operations bad_inode_ops =
  *	failure this function makes the inode "bad" and causes I/O operations
  *	on it to fail from this point on.
  */
-
+
 void make_bad_inode(struct inode *inode)
 {
 	remove_inode_hash(inode);
@@ -211,9 +223,9 @@ void make_bad_inode(struct inode *inode)
 	inode->i_mode = S_IFREG;
 	inode->i_atime = inode->i_mtime = inode->i_ctime =
 		current_time(inode);
-	inode->i_op = &bad_inode_ops;
+	inode->i_op = &bad_inode_ops;
 	inode->i_opflags &= ~IOP_XATTR;
-	inode->i_fop = &bad_file_ops;
+	inode->i_fop = &bad_file_ops;
 }
 EXPORT_SYMBOL(make_bad_inode);

@@ -222,17 +234,17 @@ EXPORT_SYMBOL(make_bad_inode);
  * &bad_inode_ops to cover the case of invalidated inodes as well as
  * those created by make_bad_inode() above.
  */
-
+
 /**
  *	is_bad_inode - is an inode errored
  *	@inode: inode to test
  *
  *	Returns true if the inode in question has been marked as bad.
  */
-
+
 bool is_bad_inode(struct inode *inode)
 {
-	return (inode->i_op == &bad_inode_ops);
+	return (inode->i_op == &bad_inode_ops);
 }

 EXPORT_SYMBOL(is_bad_inode);
--
2.31.1

