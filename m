Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E12FED3EB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 18:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfKCRFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 12:05:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39660 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfKCRFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 12:05:32 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRJJi-00018k-PD; Sun, 03 Nov 2019 17:05:30 +0000
Date:   Sun, 3 Nov 2019 17:05:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] ecryptfs unlink/rmdir breakage (similar to caught in
 ecryptfs rename last year)
Message-ID: <20191103170530.GP26530@ZenIV.linux.org.uk>
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
 <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk>
 <20191102172229.GT20975@paulmck-ThinkPad-P72>
 <20191102180842.GN26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102180842.GN26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 02, 2019 at 06:08:42PM +0000, Al Viro wrote:

> There's also some secondary stuff dropping out of that (e.g. ceph seeding
> dcache on readdir and blindly unhashing dentries it sees stale instead of
> doing d_invalidate() as it ought to - leads to fun results if you had
> something mounted on a subdirectory that got removed/recreated on server),
> but that's a separate pile of joy - doesn't affect this analysis, so
> it'll have to be dealt with later.  It had been an interesting couple of
> weeks...

More secondaries: a piece of nastiness in ecryptfs unlink/rmdir -
have the underlying layer mounted elsewhere, look something up
via ecryptfs, move the underlying object via that mount elsewhere
and call unlink().  Ends up passing the wrong directory
inode to vfs_unlink() and then - to ->unlink() of the underlying
fs...  Embarrassing, since ecryptfs_rename() used to have exact
same problem, caught and fixed in "ecryptfs_rename(): verify that
lower dentries are still OK after lock_rename()" a year ago.
Bugs are like mushrooms - found one, look around for its relatives...

How about the following (completely untested) patch?  Tyler, do you
see any problems in that?

ecryptfs: fix unlink and rmdir in face of underlying fs modifications

A problem similar to the one caught in commit 74dd7c97ea2a ("ecryptfs_rename():
verify that lower dentries are still OK after lock_rename()") exists for
unlink/rmdir as well.

Instead of playing with dget_parent() of underlying dentry of victim
and hoping it's the same as underlying dentry of our directory,
do the following:
	* find the underlying dentry of victim
	* find the underlying directory of victim's parent (stable
since the victim is ecryptfs dentry and inode of its parent is
held exclusive by the caller).
	* lock the inode of dentry underlying the victim's parent
	* check that underlying dentry of victim is still hashed and
has the right parent - it can be moved, but it can't be moved to/from
the directory we are holding exclusive.  So while ->d_parent itself
might not be stable, the result of comparison is.

If the check passes, everything is fine - underlying directory is locked,
underlying victim is still a child of that directory and we can go ahead
and feed them to vfs_unlink().  As in the current mainline we need to
pin the underlying dentry of victim, so that it wouldn't go negative under
us, but that's the only temporary reference that needs to be grabbed there.
Underlying dentry of parent won't go away (it's pinned by the parent,
which is held by caller), so there's no need to grab it.

The same problem (with the same solution) exists for rmdir.  Moreover,
rename gets simpler and more robust with the same "don't bother with
dget_parent()" approach.

Fixes: 74dd7c97ea2 "ecryptfs_rename(): verify that lower dentries are still OK after lock_rename()"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 18426f4855f1..a905d5f4f3b0 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -128,13 +128,20 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 			      struct inode *inode)
 {
 	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	struct inode *lower_dir_inode = ecryptfs_inode_to_lower(dir);
 	struct dentry *lower_dir_dentry;
+	struct inode *lower_dir_inode;
 	int rc;
 
-	dget(lower_dentry);
-	lower_dir_dentry = lock_parent(lower_dentry);
-	rc = vfs_unlink(lower_dir_inode, lower_dentry, NULL);
+	lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
+	lower_dir_inode = d_inode(lower_dir_dentry);
+	inode_lock_nested(lower_dir_inode, I_MUTEX_PARENT);
+	dget(lower_dentry);	// don't even try to make the lower negative
+	if (lower_dentry->d_parent != lower_dir_dentry)
+		rc = -EINVAL;
+	else if (d_unhashed(lower_dentry))
+		rc = -EINVAL;
+	else
+		rc = vfs_unlink(lower_dir_inode, lower_dentry, NULL);
 	if (rc) {
 		printk(KERN_ERR "Error in vfs_unlink; rc = [%d]\n", rc);
 		goto out_unlock;
@@ -142,10 +149,11 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 	fsstack_copy_attr_times(dir, lower_dir_inode);
 	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
 	inode->i_ctime = dir->i_ctime;
-	d_drop(dentry);
 out_unlock:
-	unlock_dir(lower_dir_dentry);
 	dput(lower_dentry);
+	inode_unlock(lower_dir_inode);
+	if (!rc)
+		d_drop(dentry);
 	return rc;
 }
 
@@ -512,22 +520,30 @@ static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct dentry *lower_dentry;
 	struct dentry *lower_dir_dentry;
+	struct inode *lower_dir_inode;
 	int rc;
 
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	dget(dentry);
-	lower_dir_dentry = lock_parent(lower_dentry);
-	dget(lower_dentry);
-	rc = vfs_rmdir(d_inode(lower_dir_dentry), lower_dentry);
-	dput(lower_dentry);
-	if (!rc && d_really_is_positive(dentry))
+	lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
+	lower_dir_inode = d_inode(lower_dir_dentry);
+
+	inode_lock_nested(lower_dir_inode, I_MUTEX_PARENT);
+	dget(lower_dentry);	// don't even try to make the lower negative
+	if (lower_dentry->d_parent != lower_dir_dentry)
+		rc = -EINVAL;
+	else if (d_unhashed(lower_dentry))
+		rc = -EINVAL;
+	else
+		rc = vfs_rmdir(lower_dir_inode, lower_dentry);
+	if (!rc) {
 		clear_nlink(d_inode(dentry));
-	fsstack_copy_attr_times(dir, d_inode(lower_dir_dentry));
-	set_nlink(dir, d_inode(lower_dir_dentry)->i_nlink);
-	unlock_dir(lower_dir_dentry);
+		fsstack_copy_attr_times(dir, lower_dir_inode);
+		set_nlink(dir, lower_dir_inode->i_nlink);
+	}
+	dput(lower_dentry);
+	inode_unlock(lower_dir_inode);
 	if (!rc)
 		d_drop(dentry);
-	dput(dentry);
 	return rc;
 }
 
@@ -565,20 +581,22 @@ ecryptfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct dentry *lower_new_dentry;
 	struct dentry *lower_old_dir_dentry;
 	struct dentry *lower_new_dir_dentry;
-	struct dentry *trap = NULL;
+	struct dentry *trap;
 	struct inode *target_inode;
 
 	if (flags)
 		return -EINVAL;
 
+	lower_old_dir_dentry = ecryptfs_dentry_to_lower(old_dentry->d_parent);
+	lower_new_dir_dentry = ecryptfs_dentry_to_lower(new_dentry->d_parent);
+
 	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
 	lower_new_dentry = ecryptfs_dentry_to_lower(new_dentry);
-	dget(lower_old_dentry);
-	dget(lower_new_dentry);
-	lower_old_dir_dentry = dget_parent(lower_old_dentry);
-	lower_new_dir_dentry = dget_parent(lower_new_dentry);
+
 	target_inode = d_inode(new_dentry);
+
 	trap = lock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
+	dget(lower_new_dentry);
 	rc = -EINVAL;
 	if (lower_old_dentry->d_parent != lower_old_dir_dentry)
 		goto out_lock;
@@ -606,11 +624,8 @@ ecryptfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (new_dir != old_dir)
 		fsstack_copy_attr_all(old_dir, d_inode(lower_old_dir_dentry));
 out_lock:
-	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
-	dput(lower_new_dir_dentry);
-	dput(lower_old_dir_dentry);
 	dput(lower_new_dentry);
-	dput(lower_old_dentry);
+	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
 	return rc;
 }
 
