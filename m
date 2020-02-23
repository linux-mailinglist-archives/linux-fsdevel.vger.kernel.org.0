Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60DEB169296
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgBWBRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:17:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50092 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgBWBRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:17:14 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5ft9-00HDaI-Ul; Sun, 23 Feb 2020 01:17:02 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 04/34] follow_automount() doesn't need the entire nameidata
Date:   Sun, 23 Feb 2020 01:15:56 +0000
Message-Id: <20200223011626.4103706-4-viro@ZenIV.linux.org.uk>
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

Only the address of ->total_link_count and the flags.
And fix an off-by-one is ELOOP detection - make it
consistent with symlink following, where we check if
the pre-increment value has reached 40, rather than
check the post-increment one.

[kudos to Christian Brauner for spotted braino]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 39dd56f5171f..6721c5f7e9d5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1208,7 +1208,7 @@ EXPORT_SYMBOL(follow_up);
  * - return -EISDIR to tell follow_managed() to stop and return the path we
  *   were called with.
  */
-static int follow_automount(struct path *path, struct nameidata *nd)
+static int follow_automount(struct path *path, int *count, unsigned lookup_flags)
 {
 	struct dentry *dentry = path->dentry;
 
@@ -1223,13 +1223,12 @@ static int follow_automount(struct path *path, struct nameidata *nd)
 	 * as being automount points.  These will need the attentions
 	 * of the daemon to instantiate them before they can be used.
 	 */
-	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
+	if (!(lookup_flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
 			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
 	    dentry->d_inode)
 		return -EISDIR;
 
-	nd->total_link_count++;
-	if (nd->total_link_count >= 40)
+	if (count && (*count)++ >= MAXSYMLINKS)
 		return -ELOOP;
 
 	return finish_automount(dentry->d_op->d_automount(path), path);
@@ -1290,7 +1289,8 @@ static int follow_managed(struct path *path, struct nameidata *nd)
 
 		/* Handle an automount point */
 		if (flags & DCACHE_NEED_AUTOMOUNT) {
-			ret = follow_automount(path, nd);
+			ret = follow_automount(path, &nd->total_link_count,
+						nd->flags);
 			if (ret < 0)
 				break;
 			continue;
-- 
2.11.0

