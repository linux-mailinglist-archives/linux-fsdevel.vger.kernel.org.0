Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48EB01852EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgCMX5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:57:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50046 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgCMXyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7s-00B6ah-K6; Fri, 13 Mar 2020 23:54:00 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 26/69] sanitize handling of nd->last_type, kill LAST_BIND
Date:   Fri, 13 Mar 2020 23:53:14 +0000
Message-Id: <20200313235357.2646756-26-viro@ZenIV.linux.org.uk>
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

->last_type values are set in 3 places: path_init() (sets to LAST_ROOT),
link_path_walk (LAST_NORM/DOT/DOTDOT) and pick_link (LAST_BIND).

The are checked in walk_component(), lookup_last() and do_last().
They also get copied to the caller by filename_parentat().  In the last
3 cases the value is what we had at the return from link_path_walk().
In case of walk_component() it's either directly downstream from
assignment in link_path_walk() or, when called by lookup_last(), the
value we have at the return from link_path_walk().

The value at the entry into link_path_walk() can survive to return only
if the pathname contains nothing but slashes.  Note that pick_link()
never returns such - pure jumps are handled directly.  So for the calls
of link_path_walk() for trailing symlinks it does not matter what value
had been there at the entry; the value at the return won't depend upon it.

There are 3 call chains that might have pick_link() storing LAST_BIND:

1) pick_link() from step_into() from walk_component() from
link_path_walk().  In that case we will either be parsing the next
component immediately after return into link_path_walk(), which will
overwrite the ->last_type before anyone has a chance to look at it,
or we'll fail, in which case nobody will be looking at ->last_type at all.

2) pick_link() from step_into() from walk_component() from lookup_last().
The value is never looked at due to the above; it won't affect the value
seen at return from any link_path_walk().

3) pick_link() from step_into() from do_last().  Ditto.

In other words, assignemnt in pick_link() is pointless, and so is
LAST_BIND itself; nothing ever looks at that value.  Kill it off.
And make link_path_walk() _always_ assign ->last_type - in the only
case when the value at the entry might survive to the return that value
is always LAST_ROOT, inherited from path_init().  Move that assignment
from path_init() into the beginning of link_path_walk(), to consolidate
the things.

Historical note: LAST_BIND used to be used for the kludge with trailing
pure jump symlinks (extra iteration through the top-level loop).
No point keeping it anymore...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/path-lookup.rst | 7 ++-----
 fs/namei.c                                | 3 +--
 include/linux/namei.h                     | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index a3216979298b..f46b05e9b96c 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -404,11 +404,8 @@ that is the "next" component in the pathname.
 ``int last_type``
 ~~~~~~~~~~~~~~~~~
 
-This is one of ``LAST_NORM``, ``LAST_ROOT``, ``LAST_DOT``, ``LAST_DOTDOT``, or
-``LAST_BIND``.  The ``last`` field is only valid if the type is
-``LAST_NORM``.  ``LAST_BIND`` is used when following a symlink and no
-components of the symlink have been processed yet.  Others should be
-fairly self-explanatory.
+This is one of ``LAST_NORM``, ``LAST_ROOT``, ``LAST_DOT`` or ``LAST_DOTDOT``.
+The ``last`` field is only valid if the type is ``LAST_NORM``.
 
 ``struct path root``
 ~~~~~~~~~~~~~~~~~~~~
diff --git a/fs/namei.c b/fs/namei.c
index 9b08c64397c8..438717b462fb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1785,7 +1785,6 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 	if (unlikely(error))
 		return ERR_PTR(error);
 
-	nd->last_type = LAST_BIND;
 	res = READ_ONCE(inode->i_link);
 	if (!res) {
 		const char * (*get)(struct dentry *, struct inode *,
@@ -2123,6 +2122,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 {
 	int err;
 
+	nd->last_type = LAST_ROOT;
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 	while (*name=='/')
@@ -2224,7 +2224,6 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	if (flags & LOOKUP_RCU)
 		rcu_read_lock();
 
-	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags | LOOKUP_JUMPED | LOOKUP_PARENT;
 	nd->depth = 0;
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index d9576a051808..a4bb992623c4 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -15,7 +15,7 @@ enum { MAX_NESTED_LINKS = 8 };
 /*
  * Type of the last component on LOOKUP_PARENT
  */
-enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
+enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 
 /* pathwalk mode */
 #define LOOKUP_FOLLOW		0x0001	/* follow links at the end */
-- 
2.11.0

