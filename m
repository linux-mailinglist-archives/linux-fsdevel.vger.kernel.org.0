Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC87AB138C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbfILR2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:28:53 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:7941 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbfILR2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309332; x=1599845332;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=5dh7nAR252C2An8FWeEY/Vgz2zZx/52DAsCz64TZGNs=;
  b=YxErWnIfJZJ/27pI7GK6lKdAtGeX7E4FQ8yl+f3KtaFsZW4apsvZKm5X
   37Fy7Kt9AH0Iv5WJ4alrZ59gWt1aw5v87Ir9Py5kQxoXi57Cq29kOKowA
   2NVQW6tQukv9IeK4PMOEZJCSlx7k8OIaglsk3YZUcPawiokzyy7jnNAUH
   E=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="414961231"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id CA4EDA2534;
        Thu, 12 Sep 2019 17:28:51 +0000 (UTC)
Received: from EX13D12UEA001.ant.amazon.com (10.43.61.99) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D12UEA001.ant.amazon.com (10.43.61.99) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:50 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E166DC0523; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <04a85df4daa28e34eec78de0c2954efbf26b52c3.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Fri, 30 Aug 2019 22:48:29 +0000
Subject: [RFC PATCH 14/35] nfs: define and use the NFS_INO_INVALID_XATTR flag
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define the NFS_INO_INVALID_XATTR flag, to be used for the NFSv4.2 xattr
cache, and use it where appropriate.

No functional change as yet.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/inode.c         | 7 ++++++-
 fs/nfs/nfs4proc.c      | 3 ++-
 fs/nfs/nfstrace.h      | 3 ++-
 include/linux/nfs_fs.h | 1 +
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 2a03bfeec10a..1632a97a6dfc 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -205,7 +205,8 @@ static void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 			flags &= ~NFS_INO_INVALID_OTHER;
 		flags &= ~(NFS_INO_INVALID_CHANGE
 				| NFS_INO_INVALID_SIZE
-				| NFS_INO_REVAL_PAGECACHE);
+				| NFS_INO_REVAL_PAGECACHE
+				| NFS_INO_INVALID_XATTR);
 	}
 
 	if (inode->i_mapping->nrpages == 0)
@@ -535,6 +536,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 			inode->i_gid = fattr->gid;
 		else if (nfs_server_capable(inode, NFS_CAP_OWNER_GROUP))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
+		if (nfs_server_capable(inode, NFS_CAP_XATTR))
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_XATTR);
 		if (fattr->valid & NFS_ATTR_FATTR_BLOCKS_USED)
 			inode->i_blocks = fattr->du.nfs2.blocks;
 		if (fattr->valid & NFS_ATTR_FATTR_SPACE_USED) {
@@ -1359,6 +1362,8 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		inode_set_iversion_raw(inode, fattr->change_attr);
 		if (S_ISDIR(inode->i_mode))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
+		else if (nfs_server_capable(inode, NFS_CAP_XATTR))
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_XATTR);
 	}
 	/* If we have atomic WCC data, we may update some attributes */
 	ts = timespec64_to_timespec(inode->i_ctime);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a8a6ddb34ad7..30dd92d6e759 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1155,7 +1155,8 @@ nfs4_update_changeattr_locked(struct inode *inode,
 
 		if (cinfo->before != inode_peek_iversion_raw(inode))
 			nfsi->cache_validity |= NFS_INO_INVALID_ACCESS |
-						NFS_INO_INVALID_ACL;
+						NFS_INO_INVALID_ACL |
+						NFS_INO_INVALID_XATTR;
 	}
 	inode_set_iversion_raw(inode, cinfo->after);
 	nfsi->read_cache_jiffies = timestamp;
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 976d4089e267..094b7d59866d 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -59,7 +59,8 @@ TRACE_DEFINE_ENUM(NFS_INO_INVALID_OTHER);
 			{ NFS_INO_INVALID_CTIME, "INVALID_CTIME" }, \
 			{ NFS_INO_INVALID_MTIME, "INVALID_MTIME" }, \
 			{ NFS_INO_INVALID_SIZE, "INVALID_SIZE" }, \
-			{ NFS_INO_INVALID_OTHER, "INVALID_OTHER" })
+			{ NFS_INO_INVALID_OTHER, "INVALID_OTHER" }, \
+			{ NFS_INO_INVALID_XATTR, "INVALID_XATTR" })
 
 TRACE_DEFINE_ENUM(NFS_INO_ADVISE_RDPLUS);
 TRACE_DEFINE_ENUM(NFS_INO_STALE);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index dec76ec9808c..85719db3eeea 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -228,6 +228,7 @@ struct nfs4_copy_state {
 #define NFS_INO_INVALID_OTHER	BIT(12)		/* other attrs are invalid */
 #define NFS_INO_DATA_INVAL_DEFER	\
 				BIT(13)		/* Deferred cache invalidation */
+#define NFS_INO_INVALID_XATTR	BIT(14)		/* xattrs are invalid */
 
 #define NFS_INO_INVALID_ATTR	(NFS_INO_INVALID_CHANGE \
 		| NFS_INO_INVALID_CTIME \
-- 
2.17.2

