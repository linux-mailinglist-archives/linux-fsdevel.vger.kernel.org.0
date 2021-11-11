Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE77944D079
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 04:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhKKDm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 22:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhKKDmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 22:42:23 -0500
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0B7C061766;
        Wed, 10 Nov 2021 19:39:35 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id AF1721002A7;
        Thu, 11 Nov 2021 14:39:33 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lhI9-2cYJ_S0; Thu, 11 Nov 2021 14:39:33 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 9E14B1002A9; Thu, 11 Nov 2021 14:39:33 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        smtp01.aussiebb.com.au
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=10.0 tests=RDNS_NONE,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
Received: from mickey.themaw.net (unknown [100.72.131.210])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id F089F100299;
        Thu, 11 Nov 2021 14:39:30 +1100 (AEDT)
Subject: [PATCH 2/2] xfs: make sure link path does not go away at access
From:   Ian Kent <raven@themaw.net>
To:     xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Nov 2021 11:39:30 +0800
Message-ID: <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
In-Reply-To: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When following a trailing symlink in rcu-walk mode it's possible to
succeed in getting the ->get_link() method pointer but the link path
string be deallocated while it's being used.

Utilize the rcu mechanism to mitigate this risk.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/xfs/kmem.h      |    4 ++++
 fs/xfs/xfs_inode.c |    4 ++--
 fs/xfs/xfs_iops.c  |   10 ++++++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/kmem.h b/fs/xfs/kmem.h
index 54da6d717a06..c1bd1103b340 100644
--- a/fs/xfs/kmem.h
+++ b/fs/xfs/kmem.h
@@ -61,6 +61,10 @@ static inline void  kmem_free(const void *ptr)
 {
 	kvfree(ptr);
 }
+static inline void  kmem_free_rcu(const void *ptr)
+{
+	kvfree_rcu(ptr);
+}
 
 
 static inline void *
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index a4f6f034fb81..aaa1911e61ed 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2650,8 +2650,8 @@ xfs_ifree(
 	 * already been freed by xfs_attr_inactive.
 	 */
 	if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
-		kmem_free(ip->i_df.if_u1.if_data);
-		ip->i_df.if_u1.if_data = NULL;
+		kmem_free_rcu(ip->i_df.if_u1.if_data);
+		RCU_INIT_POINTER(ip->i_df.if_u1.if_data, NULL);
 		ip->i_df.if_bytes = 0;
 	}
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a607d6aca5c4..2977e19da7b7 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -524,11 +524,17 @@ xfs_vn_get_link_inline(
 
 	/*
 	 * The VFS crashes on a NULL pointer, so return -EFSCORRUPTED if
-	 * if_data is junk.
+	 * if_data is junk. Also, if the path walk is in rcu-walk mode
+	 * and the inode link path has gone away due inode re-use we have
+	 * no choice but to tell the VFS to redo the lookup.
 	 */
-	link = ip->i_df.if_u1.if_data;
+	link = rcu_dereference(ip->i_df.if_u1.if_data);
+	if (!dentry && !link)
+		return ERR_PTR(-ECHILD);
+
 	if (XFS_IS_CORRUPT(ip->i_mount, !link))
 		return ERR_PTR(-EFSCORRUPTED);
+
 	return link;
 }
 


