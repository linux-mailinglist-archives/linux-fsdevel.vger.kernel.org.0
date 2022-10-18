Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AB8602137
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 04:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiJRCdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 22:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJRCc5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:32:57 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EE695AD2;
        Mon, 17 Oct 2022 19:32:54 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 582C8100627;
        Tue, 18 Oct 2022 13:32:52 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id udJbdEVks39P; Tue, 18 Oct 2022 13:32:52 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 50934100625; Tue, 18 Oct 2022 13:32:52 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 50C85100319;
        Tue, 18 Oct 2022 13:32:50 +1100 (AEDT)
Subject: [PATCH 2/2] kernfs: dont take i_lock on revalidate
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
Date:   Tue, 18 Oct 2022 10:32:49 +0800
Message-ID: <166606036967.13363.9336408133975631967.stgit@donald.themaw.net>
In-Reply-To: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In kernfs_dop_revalidate() when the passed in dentry is negative the
dentry directory is checked to see if it has changed and if so the
negative dentry is discarded so it can refreshed. During this check
the dentry inode i_lock is taken to mitigate against a possible
concurrent rename.

But if it's racing with a rename, becuase the dentry is negative, it
can't be the source it must be the target and it must be going to do
a d_move() otherwise the rename will return an error.

In this case the parent dentry of the target will not change, it will
be the same over the d_move(), only the source dentry parent may change
so the inode i_lock isn't needed.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 3990f3e270cb..6acd9c3d4cff 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1073,20 +1073,30 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 
 		/* If the kernfs parent node has changed discard and
 		 * proceed to ->lookup.
+		 *
+		 * There's nothing special needed here when getting the
+		 * dentry parent, even if a concurrent rename is in
+		 * progress. That's because the dentry is negative so
+		 * it can only be the target of the rename and it will
+		 * be doing a d_move() not a replace. Consequently the
+		 * dentry d_parent won't change over the d_move().
+		 *
+		 * Also kernfs negative dentries transitioning from
+		 * negative to positive during revalidate won't happen
+		 * because they are invalidated on containing directory
+		 * changes and the lookup re-done so that a new positive
+		 * dentry can be properly created.
 		 */
-		spin_lock(&dentry->d_lock);
+		root = kernfs_root_from_sb(dentry->d_sb);
+		down_read(&root->kernfs_rwsem);
 		parent = kernfs_dentry_node(dentry->d_parent);
 		if (parent) {
-			spin_unlock(&dentry->d_lock);
-			root = kernfs_root(parent);
-			down_read(&root->kernfs_rwsem);
 			if (kernfs_dir_changed(parent, dentry)) {
 				up_read(&root->kernfs_rwsem);
 				return 0;
 			}
-			up_read(&root->kernfs_rwsem);
-		} else
-			spin_unlock(&dentry->d_lock);
+		}
+		up_read(&root->kernfs_rwsem);
 
 		/* The kernfs parent node hasn't changed, leave the
 		 * dentry negative and return success.


