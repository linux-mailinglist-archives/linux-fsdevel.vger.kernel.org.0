Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B8C3CB55E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 11:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhGPJk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 05:40:56 -0400
Received: from icp-osb-irony-out9.external.iinet.net.au ([203.59.1.226]:22642
        "EHLO icp-osb-irony-out9.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234645AbhGPJkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:40:52 -0400
X-SMTP-MATCH: 0
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3At7TAma1IrZHKw7M8QUCgYgqjBJkkLtp133?=
 =?us-ascii?q?Aq2lEZdPU1SKylfqWV98jzuiWftN98YhwdcLO7WZVoI0myyXcd2+B4AV7IZm?=
 =?us-ascii?q?fbUQWTQL2LbePZsl7d866XzJ8l6U9KGJIOauEZBzNB/L7HCI7RKadG/DEEmJ?=
 =?us-ascii?q?rY49s3Th9WPGRXgyQJ1XYcNjqm?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AZBwA6UPFg/y2ELHlaHgEBCxIMQAm?=
 =?us-ascii?q?BRQsCg3ZshAJGkBMBAQEBAQEGjCmFb1+KKYF8CwEBAQEBAQEBAUoEAQGEVAK?=
 =?us-ascii?q?CfAElNAkOAgQVAQEBBQEBAQEBBgMBgQ6FdUMBDAGFdQYjBFIQGA0CGA4CAkc?=
 =?us-ascii?q?QBgEShVMlp2d/MxoCZYpDgRAqAYcIgmiDeiccfYEQgRUzA4EFgiiHW4JkBIM?=
 =?us-ascii?q?YgQ4mWoFAlQwBRooZW50Mgy6eZBeVTwOQdS2VW6cOghRNLgqDJFAZjjgXjjo?=
 =?us-ascii?q?3LzgCBgoBAQMJgnKHIi2CGAEB?=
X-IPAS-Result: =?us-ascii?q?A2AZBwA6UPFg/y2ELHlaHgEBCxIMQAmBRQsCg3ZshAJGk?=
 =?us-ascii?q?BMBAQEBAQEGjCmFb1+KKYF8CwEBAQEBAQEBAUoEAQGEVAKCfAElNAkOAgQVA?=
 =?us-ascii?q?QEBBQEBAQEBBgMBgQ6FdUMBDAGFdQYjBFIQGA0CGA4CAkcQBgEShVMlp2d/M?=
 =?us-ascii?q?xoCZYpDgRAqAYcIgmiDeiccfYEQgRUzA4EFgiiHW4JkBIMYgQ4mWoFAlQwBR?=
 =?us-ascii?q?ooZW50Mgy6eZBeVTwOQdS2VW6cOghRNLgqDJFAZjjgXjjo3LzgCBgoBAQMJg?=
 =?us-ascii?q?nKHIi2CGAEB?=
X-IronPort-AV: E=Sophos;i="5.84,244,1620662400"; 
   d="scan'208";a="329873615"
Received: from unknown (HELO web.messagingengine.com) ([121.44.132.45])
  by icp-osb-irony-out9.iinet.net.au with ESMTP; 16 Jul 2021 17:28:40 +0800
Subject: [PATCH v8 5/5] kernfs: dont call d_splice_alias() under kernfs node
 lock
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
Date:   Fri, 16 Jul 2021 17:28:40 +0800
Message-ID: <162642772000.63632.10672683419693513226.stgit@web.messagingengine.com>
In-Reply-To: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
References: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The call to d_splice_alias() in kernfs_iop_lookup() doesn't depend on
any kernfs node so there's no reason to hold the kernfs node lock when
calling it.

Signed-off-by: Ian Kent <raven@themaw.net>
Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/kernfs/dir.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 4994723d6cf7..ba581429bf7b 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1100,7 +1100,6 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 					struct dentry *dentry,
 					unsigned int flags)
 {
-	struct dentry *ret;
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
 	struct inode *inode = NULL;
@@ -1120,11 +1119,10 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	/* Needed only for negative dentry validation */
 	if (!inode)
 		kernfs_set_rev(parent, dentry);
-	/* instantiate and hash (possibly negative) dentry */
-	ret = d_splice_alias(inode, dentry);
 	up_read(&kernfs_rwsem);
 
-	return ret;
+	/* instantiate and hash (possibly negative) dentry */
+	return d_splice_alias(inode, dentry);
 }
 
 static int kernfs_iop_mkdir(struct user_namespace *mnt_userns,


