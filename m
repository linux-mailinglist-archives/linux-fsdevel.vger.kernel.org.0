Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA4950CCFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiDWSrq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 14:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbiDWSrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:47:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33DD1A29D5;
        Sat, 23 Apr 2022 11:44:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23NH4ZcW032393;
        Sat, 23 Apr 2022 18:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=8wxROLCFf21i4G1MDpwgdE5up1VD2tI4Hd2iZWeERLk=;
 b=ljVJFIr4IEl8oeT1XfYI21JHQiSTSGCjleWjtKIIsBRfu1GHt8Y5FgdxVu0O8O9SlPUL
 j5W+2BEPrWx9+eIGHZVp22c+9mGzvj/aTThGv9N5c9E+leRLDyUf7HeEixwAMkjoAFXH
 dW0Fq5IYrFBxh5PN5vqJc+ODIChjXqP7IXkPzXs9Nx9MdIfbvBzJ9rlK+XwIp8omsBCI
 ADTXcdGX8nUe6t/m9iWK9FEGpDsXwyAQx/SNQGPm0KdBiaOViOOT0ZzDrorBAXpvYtj4
 cGcBwRqA7En0/eSgJ6cBvQvx+1oRHGUc4zgIX/Wvlxl8FmoSFcRvN7gjUAxOQdUHhvBL lg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jrngn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Apr 2022 18:44:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23NIawoW010447;
        Sat, 23 Apr 2022 18:44:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w14shu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Apr 2022 18:44:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23NIgigs016659;
        Sat, 23 Apr 2022 18:44:21 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w14sh1-5;
        Sat, 23 Apr 2022 18:44:21 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v21 4/7] fs/lock: add helper locks_owner_has_blockers to check for blockers
Date:   Sat, 23 Apr 2022 11:44:12 -0700
Message-Id: <1650739455-26096-5-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: 37vYA03XASQQMGcr93comRUL8YA8YQB8
X-Proofpoint-ORIG-GUID: 37vYA03XASQQMGcr93comRUL8YA8YQB8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 8c6df10cd9ed..c369841ef7d1 100644
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
index bbde95387a23..b8ed7f974fb4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1174,6 +1174,8 @@ extern void lease_unregister_notifier(struct notifier_block *);
 struct files_struct;
 extern void show_fd_locks(struct seq_file *f,
 			 struct file *filp, struct files_struct *files);
+extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
+			fl_owner_t owner);
 #else /* !CONFIG_FILE_LOCKING */
 static inline int fcntl_getlk(struct file *file, unsigned int cmd,
 			      struct flock __user *user)
@@ -1309,6 +1311,11 @@ static inline int lease_modify(struct file_lock *fl, int arg,
 struct files_struct;
 static inline void show_fd_locks(struct seq_file *f,
 			struct file *filp, struct files_struct *files) {}
+static inline bool locks_owner_has_blockers(struct file_lock_context *flctx,
+			fl_owner_t owner)
+{
+	return false;
+}
 #endif /* !CONFIG_FILE_LOCKING */
 
 static inline struct inode *file_inode(const struct file *f)
-- 
2.9.5

