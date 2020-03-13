Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B959C185289
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgCMXyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:54:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50206 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCMXyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7y-00B6er-EJ; Fri, 13 Mar 2020 23:54:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 66/69] open_last_lookups(): lift O_EXCL|O_CREAT handling into do_open()
Date:   Fri, 13 Mar 2020 23:53:54 +0000
Message-Id: <20200313235357.2646756-66-viro@ZenIV.linux.org.uk>
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

Currently path_openat() has "EEXIST on O_EXCL|O_CREAT" checks done on one
of the ways out of open_last_lookups().  There are 4 cases:
	1) the last component is . or ..; check is not done.
	2) we had FMODE_OPENED or FMODE_CREATED set while in lookup_open();
check is not done.
	3) symlink to be traversed is found; check is not done (nor
should it be)
	4) everything else: check done (before complete_walk(), even).

In case (1) O_EXCL|O_CREAT ends up failing with -EISDIR - that's
	open("/tmp/.", O_CREAT|O_EXCL, 0600)
Note that in the same conditions
	open("/tmp", O_CREAT|O_EXCL, 0600)
would have yielded EEXIST.  Either error is allowed, switching to -EEXIST
in these cases would've been more consistent.

Case (2) is more subtle; first of all, if we have FMODE_CREATED set, the
object hadn't existed prior to the call.  The check should not be done in
such a case.  The rest is problematic, though - we have
	FMODE_OPENED set (i.e. it went through ->atomic_open() and got
successfully opened there)
	FMODE_CREATED is *NOT* set
	O_CREAT and O_EXCL are both set.
Any such case is a bug - either we failed to set FMODE_CREATED when we
had, in fact, created an object (no such instances in the tree) or
we have opened a pre-existing file despite having had both O_CREAT and
O_EXCL passed.  One of those was, in fact caught (and fixed) while
sorting out this mess (gfs2 on cold dcache).  And in such situations
we should fail with EEXIST.

Note that for (1) and (4) FMODE_CREATED is not set - for (1) there's nothing
in handle_dots() to set it, for (4) we'd explicitly checked that.

And (1), (2) and (4) are exactly the cases when we leave the loop in
the caller, with do_open() called immediately after that loop.  IOW, we
can move the check over there, and make it

	If we have O_CREAT|O_EXCL and after successful pathname resolution
FMODE_CREATED is *not* set, we must have run into a preexisting file and
should fail with EEXIST.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 7269da642391..3e1573373773 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3200,11 +3200,6 @@ static const char *open_last_lookups(struct nameidata *nd,
 		return res;
 	}
 
-	if (unlikely((open_flag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT))) {
-		audit_inode(nd->name, nd->path.dentry, 0);
-		return ERR_PTR(-EEXIST);
-	}
-
 	/* Why this, you ask?  _Now_ we might have grown LOOKUP_JUMPED... */
 	return ERR_PTR(complete_walk(nd));
 }
@@ -3223,6 +3218,8 @@ static int do_open(struct nameidata *nd,
 	if (!(file->f_mode & FMODE_CREATED))
 		audit_inode(nd->name, nd->path.dentry, 0);
 	if (open_flag & O_CREAT) {
+		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
+			return -EEXIST;
 		if (d_is_dir(nd->path.dentry))
 			return -EISDIR;
 		error = may_create_in_sticky(nd->dir_mode, nd->dir_uid,
-- 
2.11.0

