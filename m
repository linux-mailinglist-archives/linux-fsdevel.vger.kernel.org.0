Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDCBB1692A4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgBWBTf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:19:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50138 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgBWBTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:19:34 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5fvR-00HDds-58; Sun, 23 Feb 2020 01:19:22 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 11/34] lookup_fast(): consolidate the RCU success case
Date:   Sun, 23 Feb 2020 01:16:03 +0000
Message-Id: <20200223011626.4103706-11-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

1) in case of __follow_mount_rcu() failure, lookup_fast() proceeds
to call unlazy_child() and, should it succeed, handle_mounts().
Note that we have status > 0 (or we wouldn't be calling
__follow_mount_rcu() at all), so all stuff conditional upon
non-positive status won't be even touched.

Consolidate just that sequence after the call of __follow_mount_rcu().

2) calling d_is_negative() and keeping its result is pointless -
we either don't get past checking ->d_seq (and don't use the results of
d_is_negative() at all), or we are guaranteed that ->d_inode and
type bits of ->d_flags had been consistent at the time of d_is_negative()
call.  IOW, we could only get to the use of its result if it's
equal to !inode.  The same ->d_seq check guarantees that after that point
this CPU won't observe ->d_flags values older than ->d_inode update.
So 'negative' variable is completely pointless these days.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 033f91a72bb5..53e859b80b4c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1631,7 +1631,6 @@ static int lookup_fast(struct nameidata *nd,
 	 */
 	if (nd->flags & LOOKUP_RCU) {
 		unsigned seq;
-		bool negative;
 		dentry = __d_lookup_rcu(parent, &nd->last, &seq);
 		if (unlikely(!dentry)) {
 			if (unlazy_walk(nd))
@@ -1644,7 +1643,6 @@ static int lookup_fast(struct nameidata *nd,
 		 * the dentry name information from lookup.
 		 */
 		*inode = d_backing_inode(dentry);
-		negative = d_is_negative(dentry);
 		if (unlikely(read_seqcount_retry(&dentry->d_seq, seq)))
 			return -ECHILD;
 
@@ -1665,12 +1663,15 @@ static int lookup_fast(struct nameidata *nd,
 			 * Note: do negative dentry check after revalidation in
 			 * case that drops it.
 			 */
-			if (unlikely(negative))
+			if (unlikely(!inode))
 				return -ENOENT;
 			path->mnt = mnt;
 			path->dentry = dentry;
 			if (likely(__follow_mount_rcu(nd, path, inode, seqp)))
 				return 1;
+			if (unlazy_child(nd, dentry, seq))
+				return -ECHILD;
+			return handle_mounts(nd, dentry, path, inode, seqp);
 		}
 		if (unlazy_child(nd, dentry, seq))
 			return -ECHILD;
-- 
2.11.0

