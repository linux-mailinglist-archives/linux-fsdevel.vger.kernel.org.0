Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8F3602135
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 04:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiJRCcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 22:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJRCcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:32:48 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7630C92F48;
        Mon, 17 Oct 2022 19:32:47 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id B9A01100626;
        Tue, 18 Oct 2022 13:32:44 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6T_nZIWt-tY1; Tue, 18 Oct 2022 13:32:44 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id A5E6810061D; Tue, 18 Oct 2022 13:32:44 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id E5B0B1005F4;
        Tue, 18 Oct 2022 13:32:42 +1100 (AEDT)
Subject: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 18 Oct 2022 10:32:42 +0800
Message-ID: <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
In-Reply-To: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernfs write lock is held when the kernfs node inode attributes
are updated. Therefore, when either kernfs_iop_getattr() or
kernfs_iop_permission() are called the kernfs node inode attributes
won't change.

Consequently concurrent kernfs_refresh_inode() calls always copy the
same values from the kernfs node.

So there's no need to take the inode i_lock to get consistent values
for generic_fillattr() and generic_permission(), the kernfs read lock
is sufficient.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/inode.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5da..74f3453f4639 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -190,10 +190,8 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 	struct kernfs_root *root = kernfs_root(kn);
 
 	down_read(&root->kernfs_rwsem);
-	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&init_user_ns, inode, stat);
-	spin_unlock(&inode->i_lock);
 	up_read(&root->kernfs_rwsem);
 
 	return 0;
@@ -288,10 +286,8 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 	root = kernfs_root(kn);
 
 	down_read(&root->kernfs_rwsem);
-	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&init_user_ns, inode, mask);
-	spin_unlock(&inode->i_lock);
 	up_read(&root->kernfs_rwsem);
 
 	return ret;


