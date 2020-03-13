Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 811B31852E8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgCMX5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:57:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50038 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgCMXyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7s-00B6aV-Bt; Fri, 13 Mar 2020 23:54:00 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 24/69] merging pick_link() with get_link(), part 6
Date:   Fri, 13 Mar 2020 23:53:12 +0000
Message-Id: <20200313235357.2646756-24-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
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
 fs/namei.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 04a76f6dd3fe..969b99a88631 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1793,14 +1793,14 @@ static inline int handle_dots(struct nameidata *nd, int type)
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
@@ -1821,7 +1821,7 @@ static int pick_link(struct nameidata *nd, struct path *link,
 		}
 		if (error) {
 			path_put(link);
-			return error;
+			return ERR_PTR(error);
 		}
 	}
 
@@ -1830,7 +1830,7 @@ static int pick_link(struct nameidata *nd, struct path *link,
 	clear_delayed_call(&last->done);
 	nd->link_inode = inode;
 	last->seq = seq;
-	return 1;
+	return get_link(nd);
 }
 
 enum {WALK_FOLLOW = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
@@ -1863,10 +1863,7 @@ static const char *step_into(struct nameidata *nd, int flags,
 		if (read_seqcount_retry(&path.dentry->d_seq, seq))
 			return ERR_PTR(-ECHILD);
 	}
-	err = pick_link(nd, &path, inode, seq);
-	if (err > 0)
-		return get_link(nd);
-	return ERR_PTR(err);
+	return pick_link(nd, &path, inode, seq);
 }
 
 static const char *walk_component(struct nameidata *nd, int flags)
-- 
2.11.0

