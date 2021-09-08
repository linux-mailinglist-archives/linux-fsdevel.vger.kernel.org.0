Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5496403B8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351938AbhIHOaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 10:30:24 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:41496 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351936AbhIHOaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:30:24 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1mNyAO-0004qq-Jo; Wed, 08 Sep 2021 10:03:08 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/9] coda: Avoid NULL pointer dereference from a bad inode
Date:   Wed,  8 Sep 2021 10:03:00 -0400
Message-Id: <20210908140308.18491-2-jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
References: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Avoid accessing coda_inode_info from a dentry with a bad inode.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/dir.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index d69989c1bac3..3fd085009f26 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -499,15 +499,20 @@ static int coda_dentry_revalidate(struct dentry *de, unsigned int flags)
  */
 static int coda_dentry_delete(const struct dentry * dentry)
 {
-	int flags;
+	struct inode *inode;
+	struct coda_inode_info *cii;
 
 	if (d_really_is_negative(dentry)) 
 		return 0;
 
-	flags = (ITOC(d_inode(dentry))->c_flags) & C_PURGE;
-	if (is_bad_inode(d_inode(dentry)) || flags) {
+	inode = d_inode(dentry);
+	if (!inode || is_bad_inode(inode))
 		return 1;
-	}
+
+	cii = ITOC(inode);
+	if (cii->c_flags & C_PURGE)
+		return 1;
+
 	return 0;
 }
 
-- 
2.25.1

