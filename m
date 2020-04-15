Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43E71AAA2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 16:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636596AbgDOOgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 10:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394079AbgDOOdD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:33:03 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B96121D80;
        Wed, 15 Apr 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961171;
        bh=ubu4hjiULVHHM3prMmCRERzF03BF6cYz4GncxGsMI94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aur4uZ6ec9X42PYCVoMXlN9okUXumVXGG37j/RLTB+XnaeImKO5CRMCW4HScGjwE1
         3yqj/XX3ICTq+5Jz45zdgyaSzxvBd0i9NKCVmk5NE1dlIrSAm5GgAEpVuIAz/vglby
         Xq52Ke6Hhj+LaCUccRR0qhKakXxuUj31GocI8xY0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5t-006kPW-Rn; Wed, 15 Apr 2020 16:32:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 23/34] docs: filesystems: convert path-walking.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:36 +0200
Message-Id: <8da9284bb667d842193760c1e9cd40abbf587a5c.1586960617.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586960617.git.mchehab+huawei@kernel.org>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Add a SPDX header;

- Add a document title;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 .../{path-walking.txt => path-walking.rst}    | 88 ++++++++++---------
 Documentation/filesystems/porting.rst         |  2 +-
 fs/dcache.c                                   |  6 +-
 fs/namei.c                                    |  2 +-
 5 files changed, 54 insertions(+), 45 deletions(-)
 rename Documentation/filesystems/{path-walking.txt => path-walking.rst} (91%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 4d63eafc9fbf..a35b7d6ee5bc 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -20,6 +20,7 @@ algorithms work.
 
    vfs
    path-lookup
+   path-walking
    api-summary
    splice
    locking
diff --git a/Documentation/filesystems/path-walking.txt b/Documentation/filesystems/path-walking.rst
similarity index 91%
rename from Documentation/filesystems/path-walking.txt
rename to Documentation/filesystems/path-walking.rst
index 9b8930f589d9..941e5e0e0eed 100644
--- a/Documentation/filesystems/path-walking.txt
+++ b/Documentation/filesystems/path-walking.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
 Path walking and name lookup locking
 ====================================
 
@@ -64,6 +67,7 @@ mounted vfsmount. These behaviours are variously modified depending on the
 exact path walking flags.
 
 Path walking then must, broadly, do several particular things:
+
 - find the start point of the walk;
 - perform permissions and validity checks on inodes;
 - perform dcache hash name lookups on (parent, name element) tuples;
@@ -118,45 +122,45 @@ the remaining dentries on the list.
 There is no fundamental problem with walking down the wrong list, because the
 dentry comparisons will never match. However it is fatal to miss a matching
 dentry. So a seqlock is used to detect when a rename has occurred, and so the
-lookup can be retried.
+lookup can be retried::
 
-         1      2      3
-        +---+  +---+  +---+
-hlist-->| N-+->| N-+->| N-+->
-head <--+-P |<-+-P |<-+-P |
-        +---+  +---+  +---+
+	    1      2      3
+	    +---+  +---+  +---+
+    hlist-->| N-+->| N-+->| N-+->
+    head <--+-P |<-+-P |<-+-P |
+	    +---+  +---+  +---+
 
 Rename of dentry 2 may require it deleted from the above list, and inserted
-into a new list. Deleting 2 gives the following list.
+into a new list. Deleting 2 gives the following list::
 
-         1             3
-        +---+         +---+     (don't worry, the longer pointers do not
-hlist-->| N-+-------->| N-+->    impose a measurable performance overhead
-head <--+-P |<--------+-P |      on modern CPUs)
-        +---+         +---+
-          ^      2      ^
-          |    +---+    |
-          |    | N-+----+
-          +----+-P |
-               +---+
+	    1             3
+	    +---+         +---+     (don't worry, the longer pointers do not
+    hlist-->| N-+-------->| N-+->    impose a measurable performance overhead
+    head <--+-P |<--------+-P |      on modern CPUs)
+	    +---+         +---+
+	    ^      2      ^
+	    |    +---+    |
+	    |    | N-+----+
+	    +----+-P |
+		+---+
 
 This is a standard RCU-list deletion, which leaves the deleted object's
 pointers intact, so a concurrent list walker that is currently looking at
 object 2 will correctly continue to object 3 when it is time to traverse the
 next object.
 
-However, when inserting object 2 onto a new list, we end up with this:
+However, when inserting object 2 onto a new list, we end up with this::
 
-         1             3
-        +---+         +---+
-hlist-->| N-+-------->| N-+->
-head <--+-P |<--------+-P |
-        +---+         +---+
-                 2
-               +---+
-               | N-+---->
-          <----+-P |
-               +---+
+	    1             3
+	    +---+         +---+
+    hlist-->| N-+-------->| N-+->
+    head <--+-P |<--------+-P |
+	    +---+         +---+
+		    2
+		+---+
+		| N-+---->
+	    <----+-P |
+		+---+
 
 Because we didn't wait for a grace period, there may be a concurrent lookup
 still at 2. Now when it follows 2's 'next' pointer, it will walk off into
@@ -210,7 +214,7 @@ RCU-walk path walking design
 ============================
 
 Path walking code now has two distinct modes, ref-walk and rcu-walk. ref-walk
-is the traditional[*] way of performing dcache lookups using d_lock to
+is the traditional\ [#]_ way of performing dcache lookups using d_lock to
 serialise concurrent modifications to the dentry and take a reference count on
 it. ref-walk is simple and obvious, and may sleep, take locks, etc while path
 walking is operating on each dentry. rcu-walk uses seqcount based dentry
@@ -219,14 +223,14 @@ shared data in the dentry or inode. rcu-walk can not be applied to all cases,
 eg. if the filesystem must sleep or perform non trivial operations, rcu-walk
 must be switched to ref-walk mode.
 
-[*] RCU is still used for the dentry hash lookup in ref-walk, but not the full
-    path walk.
+.. [#] RCU is still used for the dentry hash lookup in ref-walk, but not the
+       full path walk.
 
-Where ref-walk uses a stable, refcounted ``parent'' to walk the remaining
+Where ref-walk uses a stable, refcounted ``parent`` to walk the remaining
 path string, rcu-walk uses a d_seq protected snapshot. When looking up a
 child of this parent snapshot, we open d_seq critical section on the child
 before closing d_seq critical section on the parent. This gives an interlocking
-ladder of snapshots to walk down.
+ladder of snapshots to walk down::
 
 
      proc 101
@@ -240,7 +244,7 @@ ladder of snapshots to walk down.
 So when vi wants to open("/home/npiggin/test.c", O_RDWR), then it will
 start from current->fs->root, which is a pinned dentry. Alternatively,
 "./test.c" would start from cwd; both names refer to the same path in
-the context of proc101.
+the context of proc101::
 
      dentry 0
     +---------------------+   rcu-walk begins here, we note d_seq, check the
@@ -288,6 +292,7 @@ these cases is fundamental for performance and scalability because blocking
 operations such as creates and unlinks are not uncommon.
 
 The detailed design for rcu-walk is like this:
+
 * LOOKUP_RCU is set in nd->flags, which distinguishes rcu-walk from ref-walk.
 * Take the RCU lock for the entire path walk, starting with the acquiring
   of the starting path (eg. root/cwd/fd-path). So now dentry refcounts are
@@ -315,6 +320,7 @@ The detailed design for rcu-walk is like this:
   a better errno) to signal an rcu-walk failure.
 
 The cases where rcu-walk cannot continue are:
+
 * NULL dentry (ie. any uncached path element)
 * Following links
 
@@ -345,12 +351,14 @@ element, nodentry for missing dentry, revalidate for filesystem revalidate
 routine requiring rcu drop, permission for permission check requiring drop,
 and link for symlink traversal requiring drop.
 
-     rcu-lookups     restart  nodentry          link  revalidate  permission
-bootup     47121           0      4624          1010       10283        7852
-dbench  25386793           0   6778659(26.7%)     55         549        1156
-kbuild   2696672          10     64442(2.3%)  108764(4.0%)     1        1590
-git diff   39605           0        28             2           0         106
-vfstest 24185492        4945    708725(2.9%) 1076136(4.4%)     0        2651
+::
+
+	rcu-lookups     restart  nodentry          link  revalidate  permission
+    bootup     47121           0      4624          1010       10283        7852
+    dbench  25386793           0   6778659(26.7%)     55         549        1156
+    kbuild   2696672          10     64442(2.3%)  108764(4.0%)     1        1590
+    git diff   39605           0        28             2           0         106
+    vfstest 24185492        4945    708725(2.9%) 1076136(4.4%)     0        2651
 
 What this shows is that failed rcu-walk lookups, ie. ones that are restarted
 entirely with ref-walk, are quite rare. Even the "vfstest" case which
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 8f7d25acf326..55a4bc87f664 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -404,7 +404,7 @@ the callback.  It used to be necessary to clean it there, but not anymore
 
 vfs now tries to do path walking in "rcu-walk mode", which avoids
 atomic operations and scalability hazards on dentries and inodes (see
-Documentation/filesystems/path-walking.txt). d_hash and d_compare changes
+Documentation/filesystems/path-walking.rst). d_hash and d_compare changes
 (above) are examples of the changes required to support this. For more complex
 filesystem callbacks, the vfs drops out of rcu-walk mode before the fs call, so
 no changes are required to the filesystem. However, this is costly and loses
diff --git a/fs/dcache.c b/fs/dcache.c
index cf8d5893bd0e..ab050262d0e6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2191,7 +2191,7 @@ static inline bool d_same_name(const struct dentry *dentry,
  *
  * __d_lookup_rcu is the dcache lookup function for rcu-walk name
  * resolution (store-free path walking) design described in
- * Documentation/filesystems/path-walking.txt.
+ * Documentation/filesystems/path-walking.rst.
  *
  * This is not to be used outside core vfs.
  *
@@ -2239,7 +2239,7 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 	 * false-negative result. d_lookup() protects against concurrent
 	 * renames using rename_lock seqlock.
 	 *
-	 * See Documentation/filesystems/path-walking.txt for more details.
+	 * See Documentation/filesystems/path-walking.rst for more details.
 	 */
 	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
 		unsigned seq;
@@ -2362,7 +2362,7 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 	 * false-negative result. d_lookup() protects against concurrent
 	 * renames using rename_lock seqlock.
 	 *
-	 * See Documentation/filesystems/path-walking.txt for more details.
+	 * See Documentation/filesystems/path-walking.rst for more details.
 	 */
 	rcu_read_lock();
 	
diff --git a/fs/namei.c b/fs/namei.c
index d1b53fea83d8..ae68041be7b6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -645,7 +645,7 @@ static bool legitimize_root(struct nameidata *nd)
 
 /*
  * Path walking has 2 modes, rcu-walk and ref-walk (see
- * Documentation/filesystems/path-walking.txt).  In situations when we can't
+ * Documentation/filesystems/path-walking.rst).  In situations when we can't
  * continue in RCU mode, we attempt to drop out of rcu-walk mode and grab
  * normal reference counts on dentries and vfsmounts to transition to ref-walk
  * mode.  Refcounts are grabbed at the last known good point before rcu-walk
-- 
2.25.2

