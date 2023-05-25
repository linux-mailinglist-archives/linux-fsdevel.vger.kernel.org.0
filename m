Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DF67109C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 12:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbjEYKQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 06:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240872AbjEYKQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 06:16:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176181AC;
        Thu, 25 May 2023 03:16:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6855D21C0B;
        Thu, 25 May 2023 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685009785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVCS2NXBW5ZH4HJiDG94f7/my/nZc/t1gaXommKhNSs=;
        b=RoZ+L0XbcMRWcB6J4AZN25Na1DyQtzEeDshH7HBysT41c/ZYbMsqsnAOKFVpwOOWjCKFMx
        +oL/USawxS0F6on4zXvP363B9uVOkITLw0zWmHshiEL9DTfsvS7S0jH7akiHKdsMSzrV0M
        bWE9EQbBsfO1l3C7bDiCzW6gZ6+UM28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685009785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVCS2NXBW5ZH4HJiDG94f7/my/nZc/t1gaXommKhNSs=;
        b=IiakXKyIVBBwJ0hAo+GepJiocb+GxZzoTof/+oaCqmwfreRU3TJY3PwmCfu9PC/lHrrT40
        opgoFPbpKINyQNAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51A90134B2;
        Thu, 25 May 2023 10:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id laIMFHk1b2RTdgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 10:16:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6C17FA0764; Thu, 25 May 2023 12:16:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        <linux-xfs@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org
Subject: [PATCH 5/6] fs: Lock moved directories
Date:   Thu, 25 May 2023 12:16:11 +0200
Message-Id: <20230525101624.15814-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230525100654.15069-1-jack@suse.cz>
References: <20230525100654.15069-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5467; i=jack@suse.cz; h=from:subject; bh=x4FZJj19EKHfl9vXc7blu9EGaRK3J4g/IYXgMMiRgsg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkbzVqOagY8JFtxmxrH4yOG15iOHj85ARzmW1mO6z6 m4CoTtqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZG81agAKCRCcnaoHP2RA2WGzB/ 9LotuYmXW9bIPSQ6gDJtNlPN19HYV48mQIwCxCOygnSkLjcDxDOY8Z4Efzc1+1y+Mr66OvFi64TZUf IX0Wi1dqzNYrj5PKKufq3htk+Ji7NrozF947HTgbX7GP5ZCH+GVSDgw0U7KQC+U1cpsAZo9e83JIuz bX+bb/5VzCYu8jA+puphkthUqFOx7RiA/meGRFMXGp+tmV3Kl9lZ3rWISRX2D+CiNFWOA2BkubK7CI TP4KTevNudV4uG4Aj3we0MHITkY6bTRqKjPBMDWrVZMN14eYTwUNbVaAobsqAOXaNP33tm2zjMgPJg Gxjy4nDVTcwgbxP48y83Hoz4fILFbu
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a directory is moved to a different directory, some filesystems
(udf, ext4, ocfs2, f2fs, and likely gfs2, reiserfs, and others) need to
update their pointer to the parent and this must not race with other
operations on the directory. Lock the directories when they are moved.
Although not all filesystems need this locking, we perform it in
vfs_rename() because getting the lock ordering right is really difficult
and we don't want to expose these locking details to filesystems.

CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 .../filesystems/directory-locking.rst         | 26 ++++++++++---------
 fs/namei.c                                    | 22 ++++++++++------
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/directory-locking.rst b/Documentation/filesystems/directory-locking.rst
index 504ba940c36c..dccd61c7c5c3 100644
--- a/Documentation/filesystems/directory-locking.rst
+++ b/Documentation/filesystems/directory-locking.rst
@@ -22,12 +22,11 @@ exclusive.
 3) object removal.  Locking rules: caller locks parent, finds victim,
 locks victim and calls the method.  Locks are exclusive.
 
-4) rename() that is _not_ cross-directory.  Locking rules: caller locks
-the parent and finds source and target.  In case of exchange (with
-RENAME_EXCHANGE in flags argument) lock both.  In any case,
-if the target already exists, lock it.  If the source is a non-directory,
-lock it.  If we need to lock both, lock them in inode pointer order.
-Then call the method.  All locks are exclusive.
+4) rename() that is _not_ cross-directory.  Locking rules: caller locks the
+parent and finds source and target.  We lock both (provided they exist).  If we
+need to lock two inodes of different type (dir vs non-dir), we lock directory
+first.  If we need to lock two inodes of the same type, lock them in inode
+pointer order.  Then call the method.  All locks are exclusive.
 NB: we might get away with locking the source (and target in exchange
 case) shared.
 
@@ -44,15 +43,17 @@ All locks are exclusive.
 rules:
 
 	* lock the filesystem
-	* lock parents in "ancestors first" order.
+	* lock parents in "ancestors first" order. If one is not ancestor of
+	  the other, lock them in inode pointer order.
 	* find source and target.
 	* if old parent is equal to or is a descendent of target
 	  fail with -ENOTEMPTY
 	* if new parent is equal to or is a descendent of source
 	  fail with -ELOOP
-	* If it's an exchange, lock both the source and the target.
-	* If the target exists, lock it.  If the source is a non-directory,
-	  lock it.  If we need to lock both, do so in inode pointer order.
+	* Lock both the source and the target provided they exist. If we
+	  need to lock two inodes of different type (dir vs non-dir), we lock
+	  the directory first. If we need to lock two inodes of the same type,
+	  lock them in inode pointer order.
 	* call the method.
 
 All ->i_rwsem are taken exclusive.  Again, we might get away with locking
@@ -66,8 +67,9 @@ If no directory is its own ancestor, the scheme above is deadlock-free.
 
 Proof:
 
-	First of all, at any moment we have a partial ordering of the
-	objects - A < B iff A is an ancestor of B.
+	First of all, at any moment we have a linear ordering of the
+	objects - A < B iff (A is an ancestor of B) or (B is not an ancestor
+        of A and ptr(A) < ptr(B)).
 
 	That ordering can change.  However, the following is true:
 
diff --git a/fs/namei.c b/fs/namei.c
index 148570aabe74..6a5e26a529e1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4731,7 +4731,7 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *	   sb->s_vfs_rename_mutex. We might be more accurate, but that's another
  *	   story.
  *	c) we have to lock _four_ objects - parents and victim (if it exists),
- *	   and source (if it is not a directory).
+ *	   and source.
  *	   And that - after we got ->i_mutex on parents (until then we don't know
  *	   whether the target exists).  Solution: try to be smart with locking
  *	   order for inodes.  We rely on the fact that tree topology may change
@@ -4815,10 +4815,16 @@ int vfs_rename(struct renamedata *rd)
 
 	take_dentry_name_snapshot(&old_name, old_dentry);
 	dget(new_dentry);
-	if (!is_dir || (flags & RENAME_EXCHANGE))
-		lock_two_nondirectories(source, target);
-	else if (target)
-		inode_lock(target);
+	/*
+	 * Lock all moved children. Moved directories may need to change parent
+	 * pointer so they need the lock to prevent against concurrent
+	 * directory changes moving parent pointer. For regular files we've
+	 * historically always done this. The lockdep locking subclasses are
+	 * somewhat arbitrary but RENAME_EXCHANGE in particular can swap
+	 * regular files and directories so it's difficult to tell which
+	 * subclasses to use.
+	 */
+	lock_two_inodes(source, target, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
 
 	error = -EPERM;
 	if (IS_SWAPFILE(source) || (target && IS_SWAPFILE(target)))
@@ -4866,9 +4872,9 @@ int vfs_rename(struct renamedata *rd)
 			d_exchange(old_dentry, new_dentry);
 	}
 out:
-	if (!is_dir || (flags & RENAME_EXCHANGE))
-		unlock_two_nondirectories(source, target);
-	else if (target)
+	if (source)
+		inode_unlock(source);
+	if (target)
 		inode_unlock(target);
 	dput(new_dentry);
 	if (!error) {
-- 
2.35.3

