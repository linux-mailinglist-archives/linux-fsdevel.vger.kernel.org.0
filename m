Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E18E141B7D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgASDTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:19:22 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56700 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgASDTW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:19:22 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it16o-00BFVK-AH; Sun, 19 Jan 2020 03:18:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 04/17] follow_automount() doesn't need the entire nameidata
Date:   Sun, 19 Jan 2020 03:17:16 +0000
Message-Id: <20200119031738.2681033-4-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
References: <20200119031423.GV8904@ZenIV.linux.org.uk>
 <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

only the address of ->total_link_count and the flags

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index d30a74a18da9..3b6f60c02f8a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1133,7 +1133,7 @@ EXPORT_SYMBOL(follow_up);
  * - return -EISDIR to tell follow_managed() to stop and return the path we
  *   were called with.
  */
-static int follow_automount(struct path *path, struct nameidata *nd)
+static int follow_automount(struct path *path, int *count, unsigned lookup_flags)
 {
 	struct dentry *dentry = path->dentry;
 
@@ -1148,13 +1148,12 @@ static int follow_automount(struct path *path, struct nameidata *nd)
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
+	if (count && *count++ >= 40)
 		return -ELOOP;
 
 	return finish_automount(dentry->d_op->d_automount(path), path);
@@ -1215,7 +1214,8 @@ static int follow_managed(struct path *path, struct nameidata *nd)
 
 		/* Handle an automount point */
 		if (flags & DCACHE_NEED_AUTOMOUNT) {
-			ret = follow_automount(path, nd);
+			ret = follow_automount(path, &nd->total_link_count,
+						nd->flags);
 			if (ret < 0)
 				break;
 			continue;
-- 
2.20.1

