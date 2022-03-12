Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0B24D6BDB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 03:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiCLCOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 21:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiCLCOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:14:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6E51945ED;
        Fri, 11 Mar 2022 18:13:47 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BN1vxI011895;
        Sat, 12 Mar 2022 02:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=AwpXRCZkY8QYpJhUegFeWznbe39s+u1FE01qP8lP6jA=;
 b=cs3aj2jeiTlYCpnGqo46tCGdz/kCOWx1wuK+wA1S3M6U2CQgjux/Jur3B6QqdGmXUC1P
 tmA4Hi13gJMf8kjH2sLOydfG7KWR3eWHikvGyqfWmyv/DhgOW3/f5lM1GUiEtVztQipR
 zL8wkey1ENTFw9SlUdnIHovKvDkHMPFYPJ6rpNVpFmnU3z1saAlm47trzg1t+so0IWQz
 flen0jgq8ztza8dgfeBfRb4lFZyqwmmJleYMr/NXEiIfkTXq3d1Uir01eyyv7lngxvcT
 AtpQmA3Uig/liKu2F7OX5uLCo9lXR48DsRIr7UOc9xAYOF3/IwqcRbXd58kE5kCOtrj6 8A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyfstka5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 02:13:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22C2C4C0084308;
        Sat, 12 Mar 2022 02:13:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3erhj88qfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 02:13:43 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22C2DgMR086332;
        Sat, 12 Mar 2022 02:13:43 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3erhj88qfe-2;
        Sat, 12 Mar 2022 02:13:43 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v16 01/11] fs/lock: add helper locks_owner_has_blockers to check for blockers
Date:   Fri, 11 Mar 2022 18:13:25 -0800
Message-Id: <1647051215-2873-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: ziE3Pj06inWOKfnXXBPJAPd4JKLCN-BN
X-Proofpoint-ORIG-GUID: ziE3Pj06inWOKfnXXBPJAPd4JKLCN-BN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add helper locks_owner_has_blockers to check if there is any blockers
for a given lockowner.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/locks.c         | 28 ++++++++++++++++++++++++++++
 include/linux/fs.h |  7 +++++++
 2 files changed, 35 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 050acf8b5110..53864eb99dc5 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -300,6 +300,34 @@ void locks_release_private(struct file_lock *fl)
 }
 EXPORT_SYMBOL_GPL(locks_release_private);
 
+/**
+ * locks_owner_has_blockers - Check for blocking lock requests
+ * @flctx: file lock context
+ * @owner: lock owner
+ *
+ * Return values:
+ *   %true: @owner has at least one blocker
+ *   %false: @owner has no blockers
+ */
+bool locks_owner_has_blockers(struct file_lock_context *flctx,
+		fl_owner_t owner)
+{
+	struct file_lock *fl;
+
+	spin_lock(&flctx->flc_lock);
+	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
+		if (fl->fl_owner != owner)
+			continue;
+		if (!list_empty(&fl->fl_blocked_requests)) {
+			spin_unlock(&flctx->flc_lock);
+			return true;
+		}
+	}
+	spin_unlock(&flctx->flc_lock);
+	return false;
+}
+EXPORT_SYMBOL_GPL(locks_owner_has_blockers);
+
 /* Free a lock which is not in use. */
 void locks_free_lock(struct file_lock *fl)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 831b20430d6e..da8ae38f471c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1200,6 +1200,8 @@ extern void lease_unregister_notifier(struct notifier_block *);
 struct files_struct;
 extern void show_fd_locks(struct seq_file *f,
 			 struct file *filp, struct files_struct *files);
+extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
+			fl_owner_t owner);
 #else /* !CONFIG_FILE_LOCKING */
 static inline int fcntl_getlk(struct file *file, unsigned int cmd,
 			      struct flock __user *user)
@@ -1335,6 +1337,11 @@ static inline int lease_modify(struct file_lock *fl, int arg,
 struct files_struct;
 static inline void show_fd_locks(struct seq_file *f,
 			struct file *filp, struct files_struct *files) {}
+extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
+			fl_owner_t owner)
+{
+	return false;
+}
 #endif /* !CONFIG_FILE_LOCKING */
 
 static inline struct inode *file_inode(const struct file *f)
-- 
2.9.5

