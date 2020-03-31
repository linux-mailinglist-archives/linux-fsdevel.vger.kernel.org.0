Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB30198915
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 02:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgCaAya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 20:54:30 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:54738
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729672AbgCaAy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:54:29 -0400
X-SMTP-MATCH: 0
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BiAAA4lIJe/+im0XZmHQEBAQkBEQU?=
 =?us-ascii?q?FAYFoBwELAYF3MYFAIRIqhBqPTgEBAQmBEooghRSFFYUpgXsKAQEBAQEBAQE?=
 =?us-ascii?q?BGxkBAgQBAYREAoIyJDUIDgIQAQEBBQEBAQEBBQMBbYUKWIVxBiMEUhAYDQI?=
 =?us-ascii?q?YDgICRxAGE4V+JK14fzMaAoopgQ4qAYwwGnmBB4FEA4E2c3OBBAGGW4JeBI1?=
 =?us-ascii?q?zgwOHD0WBAJcbgkaNO4laHY9CA4wnLaZxhXoCNYFYTS4KgydQGI5Cjj03MIE?=
 =?us-ascii?q?GAQGNJl8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2BiAAA4lIJe/+im0XZmHQEBAQkBEQUFAYFoBwELAYF3M?=
 =?us-ascii?q?YFAIRIqhBqPTgEBAQmBEooghRSFFYUpgXsKAQEBAQEBAQEBGxkBAgQBAYREA?=
 =?us-ascii?q?oIyJDUIDgIQAQEBBQEBAQEBBQMBbYUKWIVxBiMEUhAYDQIYDgICRxAGE4V+J?=
 =?us-ascii?q?K14fzMaAoopgQ4qAYwwGnmBB4FEA4E2c3OBBAGGW4JeBI1zgwOHD0WBAJcbg?=
 =?us-ascii?q?kaNO4laHY9CA4wnLaZxhXoCNYFYTS4KgydQGI5Cjj03MIEGAQGNJl8BAQ?=
X-IronPort-AV: E=Sophos;i="5.72,326,1580745600"; 
   d="scan'208";a="238809223"
Received: from unknown (HELO mickey.themaw.net) ([118.209.166.232])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 31 Mar 2020 08:54:26 +0800
Subject: [PATCH v2 3/4] vfs: check for autofs expiring dentry in
 follow_automount()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Mar 2020 08:54:26 +0800
Message-ID: <158561606601.23197.9330916868830786372.stgit@mickey.themaw.net>
In-Reply-To: <158561511964.23197.716188410829525903.stgit@mickey.themaw.net>
References: <158561511964.23197.716188410829525903.stgit@mickey.themaw.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

follow_automount() checks if a stat family system call path walk is
being done on a positive dentry and and returns -EISDIR to indicate
the dentry should be used as is without attempting an automount.

But if autofs is expiring the dentry at the time it should be
remounted following the expire.

There are two cases, in the case of a "nobrowse" indirect autofs
mount it would have been mounted on lookup anyway. In the case of
a "browse" indirect or direct autofs mount re-mounting it will
maintain the mount which is what user space would be expected.

This will defer expiration of the mount which might lead to mounts
unexpectedly remaining mounted under heavy stat activity but there's
no other choice in order to maintain consistency for user space.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/root.c |   10 +++++++++-
 fs/namei.c       |   13 +++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index a1c9c32e104f..b3f748e4df08 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -406,9 +406,17 @@ static int autofs_d_manage(const struct path *path, bool rcu_walk)
 
 	/* Check for (possible) pending expire */
 	if (ino->flags & AUTOFS_INF_WANT_EXPIRE) {
+		/* dentry possibly going to be picked for expire,
+		 * proceed to ref-walk mode.
+		 */
 		if (rcu_walk)
 			return -ECHILD;
-		return 0;
+
+		/* ref-walk mode, return 1 so follow_automount()
+		 * can wait on the expire outcome and possibly
+		 * attempt a re-mount.
+		 */
+		return 1;
 	}
 
 	/*
diff --git a/fs/namei.c b/fs/namei.c
index db6565c99825..a9c909251b2c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1227,11 +1227,20 @@ static int follow_automount(struct path *path, struct nameidata *nd,
 	 * mounted directory.  Also, autofs may mark negative dentries
 	 * as being automount points.  These will need the attentions
 	 * of the daemon to instantiate them before they can be used.
+	 *
+	 * Also if ->d_manage() returns 1 the dentry transit needs
+	 * to be managed. For autofs, a return of 1 it tells us the
+	 * dentry might be expired, so proceed to ->d_automount().
 	 */
 	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
 			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
-	    path->dentry->d_inode)
-		return -EISDIR;
+	    path->dentry->d_inode) {
+		if (path->dentry->d_flags & DCACHE_MANAGE_TRANSIT) {
+			if (!path->dentry->d_op->d_manage(path, false))
+				return -EISDIR;
+		} else
+			return -EISDIR;
+	}
 
 	nd->total_link_count++;
 	if (nd->total_link_count >= 40)

