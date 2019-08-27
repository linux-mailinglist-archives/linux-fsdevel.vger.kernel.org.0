Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFF1B1396
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbfILR25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:28:57 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:7948 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387610AbfILR2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309334; x=1599845334;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=/7carR8TUg6wHC1wDHhlHNRUEsQ5JS9MirXg3rUQnNE=;
  b=ZRp1T1k6FSRs8mTGIAY9ryncxI+781nKASTrbslw/8gGCkFB1KAlOvrm
   Jr/K77ImL6TATjlFxmjVsanB3/o0uT9A/i9PatKffMVJ1WIvy2qX9RfgB
   yy1+AjCcvoiE+44h0dZMvvw3A4XLScLewfsJzVtepXcFD2zUem8cLbWTz
   g=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="414961241"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Sep 2019 17:28:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 029AFA271F;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D02UWB003.ant.amazon.com (10.43.161.48) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D02UWB003.ant.amazon.com (10.43.161.48) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E5A1DC056F; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <378aa1d4b918a6f021105564369b809ffe4d9184.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Tue, 27 Aug 2019 15:46:07 +0000
Subject: [RFC PATCH 11/35] nfs: define nfs_access_get_cached function
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only consumer of nfs_access_get_cached_rcu and nfs_access_cached
calls these static funtions in order to first try RCU access, and
then locked access.

Combine them in to a single function, and call that. Make this function
available to the rest of the NFS code.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/dir.c           | 20 ++++++++++++++++----
 include/linux/nfs_fs.h |  2 ++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 0adfd8840110..e7f4c25de362 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2285,7 +2285,7 @@ static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, co
 	return NULL;
 }
 
-static int nfs_access_get_cached(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res, bool may_block)
+static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res, bool may_block)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_access_entry *cache;
@@ -2358,6 +2358,20 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	return err;
 }
 
+int nfs_access_get_cached(struct inode *inode, const struct cred *cred, struct
+nfs_access_entry *res, bool may_block)
+{
+	int status;
+
+	status = nfs_access_get_cached_rcu(inode, cred, res);
+	if (status != 0)
+		status = nfs_access_get_cached_locked(inode, cred, res,
+		    may_block);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(nfs_access_get_cached);
+
 static void nfs_access_add_rbtree(struct inode *inode, struct nfs_access_entry *set)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
@@ -2472,9 +2486,7 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 
 	trace_nfs_access_enter(inode);
 
-	status = nfs_access_get_cached_rcu(inode, cred, &cache);
-	if (status != 0)
-		status = nfs_access_get_cached(inode, cred, &cache, may_block);
+	status = nfs_access_get_cached(inode, cred, &cache, may_block);
 	if (status == 0)
 		goto out_cached;
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index e87c894d1960..dec76ec9808c 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -497,6 +497,8 @@ extern int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fh,
 			struct nfs_fattr *fattr, struct nfs4_label *label);
 extern int nfs_may_open(struct inode *inode, const struct cred *cred, int openflags);
 extern void nfs_access_zap_cache(struct inode *inode);
+extern int nfs_access_get_cached(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res,
+				 bool may_block);
 
 /*
  * linux/fs/nfs/symlink.c
-- 
2.17.2

