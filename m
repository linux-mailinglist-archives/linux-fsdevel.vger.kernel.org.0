Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463EA420492
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 03:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhJDBFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Oct 2021 21:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhJDBFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Oct 2021 21:05:53 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77101C0613EC;
        Sun,  3 Oct 2021 18:04:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 91A991002B3;
        Mon,  4 Oct 2021 12:04:00 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LF2jWtRANEnq; Mon,  4 Oct 2021 12:04:00 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 70562100291; Mon,  4 Oct 2021 12:04:00 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        smtp01.aussiebb.com.au
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=10.0 tests=RDNS_NONE,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
Received: from mickey.themaw.net (unknown [100.72.131.210])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 70B74100278;
        Mon,  4 Oct 2021 12:03:58 +1100 (AEDT)
Subject: [REPOST,UPDATED PATCH] kernfs: don't create a negative dentry if
 inactive node exists
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Hou Tao <houtao1@huawei.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 04 Oct 2021 09:03:53 +0800
Message-ID: <163330943316.19450.15056895533949392922.stgit@mickey.themaw.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's been reported that doing stress test for module insertion and
removal can result in an ENOENT from libkmod for a valid module.

In kernfs_iop_lookup() a negative dentry is created if there's no kernfs
node associated with the dentry or the node is inactive.

But inactive kernfs nodes are meant to be invisible to the VFS and
creating a negative dentry for these can have unexpected side effects
when the node transitions to an active state.

The point of creating negative dentries is to avoid the expensive
alloc/free cycle that occurs if there are frequent lookups for kernfs
attributes that don't exist. So kernfs nodes that are not yet active
should not result in a negative dentry being created so when they
transition to an active state VFS lookups can create an associated
dentry is a natural way.

It's also been reported that https://github.com/osandov/blktests.git
test block/001 hangs during the test. It was suggested that recent
changes to blktests might have caused it but applying this patch
resolved the problem without change to blktests.

Fixes: c7e7c04274b1 ("kernfs: use VFS negative dentry caching")
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index ba581429bf7b..a957c944cf3a 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1111,7 +1111,14 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 
 	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
 	/* attach dentry and inode */
-	if (kn && kernfs_active(kn)) {
+	if (kn) {
+		/* Inactive nodes are invisible to the VFS so don't
+		 * create a negative.
+		 */
+		if (!kernfs_active(kn)) {
+			up_read(&kernfs_rwsem);
+			return NULL;
+		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);


