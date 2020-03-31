Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900F119890E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 02:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgCaAyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 20:54:19 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:54738
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729019AbgCaAyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:54:19 -0400
X-SMTP-MATCH: 0
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BiAAA4lIJe/+im0XZmHQEBAQkBEQU?=
 =?us-ascii?q?FAYFoBwELAYIogUAhEiqEGo9OAQEBAwaBEooghRSKPoF7CgEBAQEBAQEBARs?=
 =?us-ascii?q?ZAQIEAQGERAKCMiQ1CA4CEAEBAQUBAQEBAQUDAW2FCliFcQYjBFIQGA0CGA4?=
 =?us-ascii?q?CAkcQBhOFfiSteH8zGgKKKYEOKgGMMBp5gQeBRAOBNoFmgReGSYJeBJB2hw9?=
 =?us-ascii?q?FmBuCRpcVHY9CA4wnLaxrAzSBWE0uCoMnUBicfzcwgQYBAY4FAQE?=
X-IPAS-Result: =?us-ascii?q?A2BiAAA4lIJe/+im0XZmHQEBAQkBEQUFAYFoBwELAYIog?=
 =?us-ascii?q?UAhEiqEGo9OAQEBAwaBEooghRSKPoF7CgEBAQEBAQEBARsZAQIEAQGERAKCM?=
 =?us-ascii?q?iQ1CA4CEAEBAQUBAQEBAQUDAW2FCliFcQYjBFIQGA0CGA4CAkcQBhOFfiSte?=
 =?us-ascii?q?H8zGgKKKYEOKgGMMBp5gQeBRAOBNoFmgReGSYJeBJB2hw9FmBuCRpcVHY9CA?=
 =?us-ascii?q?4wnLaxrAzSBWE0uCoMnUBicfzcwgQYBAY4FAQE?=
X-IronPort-AV: E=Sophos;i="5.72,326,1580745600"; 
   d="scan'208";a="238809181"
Received: from unknown (HELO mickey.themaw.net) ([118.209.166.232])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 31 Mar 2020 08:54:13 +0800
Subject: [PATCH v2 1/4] autofs: dont call do_expire_wait() in
 autofs_d_manage()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Mar 2020 08:54:13 +0800
Message-ID: <158561605361.23197.2200523340622024577.stgit@mickey.themaw.net>
In-Reply-To: <158561511964.23197.716188410829525903.stgit@mickey.themaw.net>
References: <158561511964.23197.716188410829525903.stgit@mickey.themaw.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Calling do_expire_wait() in autofs_d_manage() isn't really necessary.

If in rcu-walk mode -ECHILD will be returned and if in ref-walk mode
and the dentry might be picked for expire (or is expiring) 0 will be
returned otherwise it waits for the expire.

But waiting is meant to be done in autofs_d_automount() so simplify
autofs_d_manage() by testing the expire status and returning only
what's needed.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/root.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 5aaa1732bf1e..a3b7c72a298d 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -410,9 +410,12 @@ static int autofs_d_manage(const struct path *path, bool rcu_walk)
 		return 0;
 	}
 
-	/* Wait for pending expires */
-	if (do_expire_wait(path, rcu_walk) == -ECHILD)
-		return -ECHILD;
+	/* Check for (possible) pending expire */
+	if (ino->flags & AUTOFS_INF_WANT_EXPIRE) {
+		if (rcu_walk)
+			return -ECHILD;
+		return 0;
+	}
 
 	/*
 	 * This dentry may be under construction so wait on mount
@@ -432,8 +435,6 @@ static int autofs_d_manage(const struct path *path, bool rcu_walk)
 		 */
 		struct inode *inode;
 
-		if (ino->flags & AUTOFS_INF_WANT_EXPIRE)
-			return 0;
 		if (path_is_mountpoint(path))
 			return 0;
 		inode = d_inode_rcu(dentry);

