Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8245F175060
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgCAVz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:55:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41610 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgCAVwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:44 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVv-003fNR-2Y; Sun, 01 Mar 2020 21:52:43 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 18/55] merging pick_link() with get_link(), part 1
Date:   Sun,  1 Mar 2020 21:52:03 +0000
Message-Id: <20200301215240.873899-18-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
References: <20200301215125.GA873525@ZenIV.linux.org.uk>
 <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Move restoring LOOKUP_PARENT and zeroing nd->stack.name[0] past
the call of get_link() (nothing _currently_ uses them in there).
That allows to moved the call of may_follow_link() into get_link()
as well, since now the presence of LOOKUP_PARENT distinguishes
the callers from each other (link_path_walk() has it, trailing_symlink()
doesn't).

Preparations for folding trailing_symlink() into callers (lookup_last()
and do_last()) and changing the calling conventions of those.  Next
stage after that will have get_link() call migrate into walk_component(),
then - into step_into().  It's tricky enough to warrant doing that
in stages, unfortunately...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3eed5784942a..3594f6a4998b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1115,6 +1115,12 @@ const char *get_link(struct nameidata *nd)
 	int error;
 	const char *res;
 
+	if (!(nd->flags & LOOKUP_PARENT)) {
+		error = may_follow_link(nd);
+		if (unlikely(error))
+			return ERR_PTR(error);
+	}
+
 	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS))
 		return ERR_PTR(-ELOOP);
 
@@ -2329,13 +2335,9 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 static const char *trailing_symlink(struct nameidata *nd)
 {
-	const char *s;
-	int error = may_follow_link(nd);
-	if (unlikely(error))
-		return ERR_PTR(error);
+	const char *s = get_link(nd);
 	nd->flags |= LOOKUP_PARENT;
 	nd->stack[0].name = NULL;
-	s = get_link(nd);
 	return s ? s : "";
 }
 
-- 
2.11.0

