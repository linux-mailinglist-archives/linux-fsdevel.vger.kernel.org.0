Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F2F3CB558
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 11:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhGPJkf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 05:40:35 -0400
Received: from icp-osb-irony-out9.external.iinet.net.au ([203.59.1.226]:22594
        "EHLO icp-osb-irony-out9.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233986AbhGPJkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:40:33 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jul 2021 05:40:26 EDT
X-SMTP-MATCH: 0
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AHCUZiq2XJJWX1INLK/FgJQqjBIgkLtp133?=
 =?us-ascii?q?Aq2lEZdPU1SKClfqWV98jzuiWatN98Yh8dcLK7WJVoMEm8yXcd2+B4V9qftW?=
 =?us-ascii?q?/dyQmVxepZnOjfKlPbakrD398Y+aB8c7VvTP3cZGIK6/oSOTPIdurIFuP3lJ?=
 =?us-ascii?q?yVuQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AbBwA6UPFg/y2ELHlQCh4BAQsSDEA?=
 =?us-ascii?q?JgUULAoN2bIQCRpATAQEBAQEBBoFAimmFb1+KKYF8CwEBAQEBAQEBAUoEAQG?=
 =?us-ascii?q?EVAKCfAElNAkOAgQVAQEBBQEBAQEBBgMBgQ6FdUMBDAGFdQYjBFIQGA0CGA4?=
 =?us-ascii?q?CAkcQBgEShVMlp2d/MxoCZYpDgRAqAYcIgmiDeiccfYEQgRUzA4EFgiiEF4N?=
 =?us-ascii?q?EgmQEglJFAYEOFIFkSJIRgnsBRohtgSxbnQyDLp5kF5VPA5B1hwePAacOghR?=
 =?us-ascii?q?NLgqDJFAZjjgBFo46Ny84AgYKAQEDCYJyhyItghgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2AbBwA6UPFg/y2ELHlQCh4BAQsSDEAJgUULAoN2bIQCR?=
 =?us-ascii?q?pATAQEBAQEBBoFAimmFb1+KKYF8CwEBAQEBAQEBAUoEAQGEVAKCfAElNAkOA?=
 =?us-ascii?q?gQVAQEBBQEBAQEBBgMBgQ6FdUMBDAGFdQYjBFIQGA0CGA4CAkcQBgEShVMlp?=
 =?us-ascii?q?2d/MxoCZYpDgRAqAYcIgmiDeiccfYEQgRUzA4EFgiiEF4NEgmQEglJFAYEOF?=
 =?us-ascii?q?IFkSJIRgnsBRohtgSxbnQyDLp5kF5VPA5B1hwePAacOghRNLgqDJFAZjjgBF?=
 =?us-ascii?q?o46Ny84AgYKAQEDCYJyhyItghgBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,244,1620662400"; 
   d="scan'208";a="329873575"
Received: from unknown (HELO web.messagingengine.com) ([121.44.132.45])
  by icp-osb-irony-out9.iinet.net.au with ESMTP; 16 Jul 2021 17:28:24 +0800
Subject: [PATCH v8 2/5] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>, Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 16 Jul 2021 17:28:24 +0800
Message-ID: <162642770420.63632.15791924970508867106.stgit@web.messagingengine.com>
In-Reply-To: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
References: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If there are many lookups for non-existent paths these negative lookups
can lead to a lot of overhead during path walks.

The VFS allows dentries to be created as negative and hashed, and caches
them so they can be used to reduce the fairly high overhead alloc/free
cycle that occurs during these lookups.

Use the kernfs node parent revision to identify if a change has been
made to the containing directory so that the negative dentry can be
discarded and the lookup redone.

Signed-off-by: Ian Kent <raven@themaw.net>
Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/kernfs/dir.c |   55 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index b3d1bc0f317d..0b21a8f961ac 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1039,9 +1039,31 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	/* Always perform fresh lookup for negatives */
-	if (d_really_is_negative(dentry))
-		goto out_bad_unlocked;
+	/* Negative hashed dentry? */
+	if (d_really_is_negative(dentry)) {
+		struct kernfs_node *parent;
+
+		/* If the kernfs parent node has changed discard and
+		 * proceed to ->lookup.
+		 */
+		mutex_lock(&kernfs_mutex);
+		spin_lock(&dentry->d_lock);
+		parent = kernfs_dentry_node(dentry->d_parent);
+		if (parent) {
+			if (kernfs_dir_changed(parent, dentry)) {
+				spin_unlock(&dentry->d_lock);
+				mutex_unlock(&kernfs_mutex);
+				return 0;
+			}
+		}
+		spin_unlock(&dentry->d_lock);
+		mutex_unlock(&kernfs_mutex);
+
+		/* The kernfs parent node hasn't changed, leave the
+		 * dentry negative and return success.
+		 */
+		return 1;
+	}
 
 	kn = kernfs_dentry_node(dentry);
 	mutex_lock(&kernfs_mutex);
@@ -1067,7 +1089,6 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	return 1;
 out_bad:
 	mutex_unlock(&kernfs_mutex);
-out_bad_unlocked:
 	return 0;
 }
 
@@ -1082,33 +1103,27 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	struct dentry *ret;
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
-	struct inode *inode;
+	struct inode *inode = NULL;
 	const void *ns = NULL;
 
 	mutex_lock(&kernfs_mutex);
-
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
 	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
-
-	/* no such entry */
-	if (!kn || !kernfs_active(kn)) {
-		ret = NULL;
-		goto out_unlock;
-	}
-
 	/* attach dentry and inode */
-	inode = kernfs_get_inode(dir->i_sb, kn);
-	if (!inode) {
-		ret = ERR_PTR(-ENOMEM);
-		goto out_unlock;
+	if (kn && kernfs_active(kn)) {
+		inode = kernfs_get_inode(dir->i_sb, kn);
+		if (!inode)
+			inode = ERR_PTR(-ENOMEM);
 	}
-
-	/* instantiate and hash dentry */
+	/* Needed only for negative dentry validation */
+	if (!inode)
+		kernfs_set_rev(parent, dentry);
+	/* instantiate and hash (possibly negative) dentry */
 	ret = d_splice_alias(inode, dentry);
- out_unlock:
 	mutex_unlock(&kernfs_mutex);
+
 	return ret;
 }
 


