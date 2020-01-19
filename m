Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFEA141BAF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgASDZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:25:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57000 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgASDZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:25:42 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it1D4-00BFkw-3L; Sun, 19 Jan 2020 03:25:16 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6/9] merging pick_link() with get_link(), part 6
Date:   Sun, 19 Jan 2020 03:17:35 +0000
Message-Id: <20200119031738.2681033-23-viro@ZenIV.linux.org.uk>
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

move the only remaining call of get_link() into pick_link()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ad6de8b4167e..adb573e0f424 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1792,14 +1792,14 @@ static inline int handle_dots(struct nameidata *nd, int type)
 	return 0;
 }
 
-static int pick_link(struct nameidata *nd, struct path *link,
+static const char *pick_link(struct nameidata *nd, struct path *link,
 		     struct inode *inode, unsigned seq)
 {
 	int error;
 	struct saved *last;
 	if (unlikely(nd->total_link_count++ >= MAXSYMLINKS)) {
 		path_to_nameidata(link, nd);
-		return -ELOOP;
+		return ERR_PTR(-ELOOP);
 	}
 	if (!(nd->flags & LOOKUP_RCU)) {
 		if (link->mnt == nd->path.mnt)
@@ -1820,7 +1820,7 @@ static int pick_link(struct nameidata *nd, struct path *link,
 		}
 		if (error) {
 			path_put(link);
-			return error;
+			return ERR_PTR(error);
 		}
 	}
 
@@ -1829,7 +1829,7 @@ static int pick_link(struct nameidata *nd, struct path *link,
 	clear_delayed_call(&last->done);
 	nd->link_inode = inode;
 	last->seq = seq;
-	return 1;
+	return get_link(nd);
 }
 
 enum {WALK_FOLLOW = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
@@ -1864,11 +1864,7 @@ static const char *step_into(struct nameidata *nd, int flags,
 		if (read_seqcount_retry(&path.dentry->d_seq, seq))
 			return ERR_PTR(-ECHILD);
 	}
-	err = pick_link(nd, &path, inode, seq);
-	if (err > 0)
-		return get_link(nd);
-	else
-		return ERR_PTR(err);
+	return pick_link(nd, &path, inode, seq);
 }
 
 static const char *walk_component(struct nameidata *nd, int flags)
-- 
2.20.1

