Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68249600BFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 12:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJQKGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiJQKGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF53C47BB9;
        Mon, 17 Oct 2022 03:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F99160FE7;
        Mon, 17 Oct 2022 10:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777CDC43470;
        Mon, 17 Oct 2022 10:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666001184;
        bh=SvrUWy81lmvVIIoH2Om5GqcrED9/BQIPyRLOp31jDB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qq9WG+MR0tFTqK0Ieuh6I2zKxfbdT8leFplX+zoE/xubYlVsuc67M/MT3UsPRfHaa
         3j+3ZIZ765FdKAWeufzHDuDid6BzelaWbIV9wt/im57VkR+G4BvUzXSrjct34WXruJ
         awj+OowMIugrnWCSC/MJz1Ion6/hosUhI2rZs/NkIyH9XN2qtX6NBFndhgGXr1S33B
         J+1XfhcYVgaf5YScbFtFCdXKyvm6phG3NQdXEnMGQDbU7CpHUm/yfD8bq2CcksrJRC
         6KIF8Uj2F32zWXy3Nn5OXU6KBweweN4WoOss2QZkwTBqCOMXHiJPLkC1rMIeXRhWn8
         8JmHKHQfVg+Yw==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/5] attr: use consistent sgid stripping checks
Date:   Mon, 17 Oct 2022 12:05:58 +0200
Message-Id: <20221017100600.70269-4-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017100600.70269-1-brauner@kernel.org>
References: <20221017100600.70269-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14916; i=brauner@kernel.org; h=from:subject; bh=SvrUWy81lmvVIIoH2Om5GqcrED9/BQIPyRLOp31jDB0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7avzen/GHZ/LMFXxFi7i54tLXdG7r21ZlN/HDZW/dEkND SxHFjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlEVDP8D9basXem7kk5e5vZrXMDpc 025D82vjn51daPR69I5RhyPWdkWDQ7vq88/I/GnCzfGV+3lS6e8dxVXmHTl49L9LbVKXkoMgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently setgid stripping in file_remove_privs()'s should_remove_suid()
helper is inconsistent with other parts of the vfs. Specifically, it only
raises ATTR_KILL_SGID if the inode is S_ISGID and S_IXGRP but not if the
inode isn't in the caller's groups and the caller isn't privileged over the
inode although we require this already in setattr_prepare() and
setattr_copy() and so all filesystem implement this requirement implicitly
because they have to use setattr_{prepare,copy}() anyway.

But the inconsistency shows up in setgid stripping bugs for overlayfs in
xfstests (e.g., generic/673, generic/683, generic/685, generic/686,
generic/687). For example, we test whether suid and setgid stripping works
correctly when performing various write-like operations as an unprivileged
user (fallocate, reflink, write, etc.):

echo "Test 1 - qa_user, non-exec file $verb"
setup_testfile
chmod a+rws $junk_file
commit_and_check "$qa_user" "$verb" 64k 64k

The test basically creates a file with 6666 permissions. While the file has
the S_ISUID and S_ISGID bits set it does not have the S_IXGRP set. On a
regular filesystem like xfs what will happen is:

sys_fallocate()
-> vfs_fallocate()
   -> xfs_file_fallocate()
      -> file_modified()
         -> __file_remove_privs()
            -> dentry_needs_remove_privs()
               -> should_remove_suid()
            -> __remove_privs()
               newattrs.ia_valid = ATTR_FORCE | kill;
               -> notify_change()
                  -> setattr_copy()

In should_remove_suid() we can see that ATTR_KILL_SUID is raised
unconditionally because the file in the test has S_ISUID set.

But we also see that ATTR_KILL_SGID won't be set because while the file
is S_ISGID it is not S_IXGRP (see above) which is a condition for
ATTR_KILL_SGID being raised.

So by the time we call notify_change() we have attr->ia_valid set to
ATTR_KILL_SUID | ATTR_FORCE. Now notify_change() sees that
ATTR_KILL_SUID is set and does:

ia_valid = attr->ia_valid |= ATTR_MODE
attr->ia_mode = (inode->i_mode & ~S_ISUID);

which means that when we call setattr_copy() later we will definitely
update inode->i_mode. Note that attr->ia_mode still contains S_ISGID.

Now we call into the filesystem's ->setattr() inode operation which will
end up calling setattr_copy(). Since ATTR_MODE is set we will hit:

if (ia_valid & ATTR_MODE) {
        umode_t mode = attr->ia_mode;
        vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
        if (!vfsgid_in_group_p(vfsgid) &&
            !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
                mode &= ~S_ISGID;
        inode->i_mode = mode;
}

and since the caller in the test is neither capable nor in the group of the
inode the S_ISGID bit is stripped.

But assume the file isn't suid then ATTR_KILL_SUID won't be raised which
has the consequence that neither the setgid nor the suid bits are stripped
even though it should be stripped because the inode isn't in the caller's
groups and the caller isn't privileged over the inode.

If overlayfs is in the mix things become a bit more complicated and the bug
shows up more clearly. When e.g., ovl_setattr() is hit from
ovl_fallocate()'s call to file_remove_privs() then ATTR_KILL_SUID and
ATTR_KILL_SGID might be raised but because the check in notify_change() is
questioning the ATTR_KILL_SGID flag again by requiring S_IXGRP for it to be
stripped the S_ISGID bit isn't removed even though it should be stripped:

sys_fallocate()
-> vfs_fallocate()
   -> ovl_fallocate()
      -> file_remove_privs()
         -> dentry_needs_remove_privs()
            -> should_remove_suid()
         -> __remove_privs()
            newattrs.ia_valid = ATTR_FORCE | kill;
            -> notify_change()
               -> ovl_setattr()
                  // TAKE ON MOUNTER'S CREDS
                  -> ovl_do_notify_change()
                     -> notify_change()
                  // GIVE UP MOUNTER'S CREDS
     // TAKE ON MOUNTER'S CREDS
     -> vfs_fallocate()
        -> xfs_file_fallocate()
           -> file_modified()
              -> __file_remove_privs()
                 -> dentry_needs_remove_privs()
                    -> should_remove_suid()
                 -> __remove_privs()
                    newattrs.ia_valid = attr_force | kill;
                    -> notify_change()

The fix for all of this is to make file_remove_privs()'s
should_remove_suid() helper to perform the same checks as we already
require in setattr_prepare() and setattr_copy() and have notify_change()
not pointlessly requiring S_IXGRP again. It doesn't make any sense in the
first place because the caller must calculate the flags via
should_remove_suid() anyway which would raise ATTR_KILL_SGID.

While we're at it we move should_remove_suid() from inode.c to attr.c
where it belongs with the rest of the iattr helpers. Especially since it
returns ATTR_KILL_S{G,U}ID flags. We also rename it to
setattr_should_drop_suidgid() to better reflect that it indicates both
setuid and setgid bit removal and also that it returns attr flags.

Running xfstests with this doesn't report any regressions. We should really
try and use consistent checks.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    Amir Goldstein <amir73il@gmail.com>:
    - mention xfstests that failed prior to that
    
    Christian Brauner <brauner@kernel.org>:
    - Use should_remove_sgid() in chown_common() just like we do in do_truncate().
    
    /* v3 */
    Christian Brauner <brauner@kernel.org>:
    - Move should_remove_suid() from inode.c to attr.c where it belongs with the
      rest of the iattr helpers. Especially since it returns ATTR_KILL_S{G,U}ID
      flags. We also rename it to setattr_should_drop_suidgid() to better reflect
      that it indicates both setuid and setgid bit removal and also that it returns
      attr flags.
    - Since setattr_should_drop_suidgid() only needs the inode pass an inode,
      not a dentry.

 Documentation/trace/ftrace.rst |  2 +-
 fs/attr.c                      | 37 +++++++++++++++++++++++++++++++++-
 fs/fuse/file.c                 |  2 +-
 fs/inode.c                     | 36 ++++-----------------------------
 fs/internal.h                  |  3 ++-
 fs/ocfs2/file.c                |  4 ++--
 fs/open.c                      |  8 ++++----
 include/linux/fs.h             |  2 +-
 8 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 60bceb018d6a..21f01d32c959 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2940,7 +2940,7 @@ Produces::
               bash-1994  [000] ....  4342.324898: ima_get_action <-process_measurement
               bash-1994  [000] ....  4342.324898: ima_match_policy <-ima_get_action
               bash-1994  [000] ....  4342.324899: do_truncate <-do_last
-              bash-1994  [000] ....  4342.324899: should_remove_suid <-do_truncate
+              bash-1994  [000] ....  4342.324899: setattr_should_drop_suidgid <-do_truncate
               bash-1994  [000] ....  4342.324899: notify_change <-do_truncate
               bash-1994  [000] ....  4342.324900: current_fs_time <-notify_change
               bash-1994  [000] ....  4342.324900: current_kernel_time <-current_fs_time
diff --git a/fs/attr.c b/fs/attr.c
index 3d03ceb332e5..12938a1442f2 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -65,6 +65,41 @@ int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
 				 i_gid_into_vfsgid(mnt_userns, inode));
 }
 
+/**
+ * setattr_should_drop_suidgid - determine whether the set{g,u}id bit needs to
+ *                               be dropped
+ * @mnt_userns:	user namespace of the mount @inode was found from
+ * @inode:	inode to check
+ *
+ * This function determines whether the set{g,u}id bits need to be removed.
+ * If the setuid bit needs to be removed ATTR_KILL_SUID is returned. If the
+ * setgid bit needs to be removed ATTR_KILL_SGID is returned. If both
+ * set{g,u}id bits need to be removed the corresponding mask of both flags is
+ * returned.
+ *
+ * Return: A mask of ATTR_KILL_S{G,U}ID indicating which - if any - setid bits
+ * to remove, 0 otherwise.
+ */
+int setattr_should_drop_suidgid(struct user_namespace *mnt_userns,
+				struct inode *inode)
+{
+	umode_t mode = inode->i_mode;
+	int kill = 0;
+
+	/* suid always must be killed */
+	if (unlikely(mode & S_ISUID))
+		kill = ATTR_KILL_SUID;
+
+	if (unlikely(setattr_should_drop_sgid(mnt_userns, inode)))
+		kill |= ATTR_KILL_SGID;
+
+	if (unlikely(kill && !capable(CAP_FSETID) && S_ISREG(mode)))
+		return kill;
+
+	return 0;
+}
+EXPORT_SYMBOL(setattr_should_drop_suidgid);
+
 /**
  * chown_ok - verify permissions to chown inode
  * @mnt_userns:	user namespace of the mount @inode was found from
@@ -420,7 +455,7 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 		}
 	}
 	if (ia_valid & ATTR_KILL_SGID) {
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
+		if (mode & S_ISGID) {
 			if (!(ia_valid & ATTR_MODE)) {
 				ia_valid = attr->ia_valid |= ATTR_MODE;
 				attr->ia_mode = inode->i_mode;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1a3afd469e3a..97e2d815075d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1313,7 +1313,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			return err;
 
 		if (fc->handle_killpriv_v2 &&
-		    should_remove_suid(file_dentry(file))) {
+		    setattr_should_drop_suidgid(&init_user_ns, file_inode(file))) {
 			goto writethrough;
 		}
 
diff --git a/fs/inode.c b/fs/inode.c
index b608528efd3a..782255d8cdf9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1948,41 +1948,13 @@ void touch_atime(const struct path *path)
 }
 EXPORT_SYMBOL(touch_atime);
 
-/*
- * The logic we want is
- *
- *	if suid or (sgid and xgrp)
- *		remove privs
- */
-int should_remove_suid(struct dentry *dentry)
-{
-	umode_t mode = d_inode(dentry)->i_mode;
-	int kill = 0;
-
-	/* suid always must be killed */
-	if (unlikely(mode & S_ISUID))
-		kill = ATTR_KILL_SUID;
-
-	/*
-	 * sgid without any exec bits is just a mandatory locking mark; leave
-	 * it alone.  If some exec bits are set, it's a real sgid; kill it.
-	 */
-	if (unlikely((mode & S_ISGID) && (mode & S_IXGRP)))
-		kill |= ATTR_KILL_SGID;
-
-	if (unlikely(kill && !capable(CAP_FSETID) && S_ISREG(mode)))
-		return kill;
-
-	return 0;
-}
-EXPORT_SYMBOL(should_remove_suid);
-
 /*
  * Return mask of changes for notify_change() that need to be done as a
  * response to write or truncate. Return 0 if nothing has to be changed.
  * Negative value on error (change should be denied).
  */
-int dentry_needs_remove_privs(struct dentry *dentry)
+int dentry_needs_remove_privs(struct user_namespace *mnt_userns,
+			      struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 	int mask = 0;
@@ -1991,7 +1963,7 @@ int dentry_needs_remove_privs(struct dentry *dentry)
 	if (IS_NOSEC(inode))
 		return 0;
 
-	mask = should_remove_suid(dentry);
+	mask = setattr_should_drop_suidgid(mnt_userns, inode);
 	ret = security_inode_need_killpriv(dentry);
 	if (ret < 0)
 		return ret;
@@ -2023,7 +1995,7 @@ static int __file_remove_privs(struct file *file, unsigned int flags)
 	if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
 		return 0;
 
-	kill = dentry_needs_remove_privs(dentry);
+	kill = dentry_needs_remove_privs(file_mnt_user_ns(file), dentry);
 	if (kill < 0)
 		return kill;
 
diff --git a/fs/internal.h b/fs/internal.h
index 988e123d3885..29a9e85f0b05 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -150,7 +150,8 @@ extern int vfs_open(const struct path *, struct file *);
  * inode.c
  */
 extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
-extern int dentry_needs_remove_privs(struct dentry *dentry);
+extern int dentry_needs_remove_privs(struct user_namespace *,
+				     struct dentry *dentry);
 
 /*
  * fs-writeback.c
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 9c67edd215d5..4d78e0979517 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1991,7 +1991,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 		}
 	}
 
-	if (file && should_remove_suid(file->f_path.dentry)) {
+	if (file && setattr_should_drop_suidgid(&init_user_ns, file_inode(file))) {
 		ret = __ocfs2_write_remove_suid(inode, di_bh);
 		if (ret) {
 			mlog_errno(ret);
@@ -2279,7 +2279,7 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
 		 * inode. There's also the dinode i_size state which
 		 * can be lost via setattr during extending writes (we
 		 * set inode->i_size at the end of a write. */
-		if (should_remove_suid(dentry)) {
+		if (setattr_should_drop_suidgid(&init_user_ns, inode)) {
 			if (meta_level == 0) {
 				ocfs2_inode_unlock_for_extent_tree(inode,
 								   &di_bh,
diff --git a/fs/open.c b/fs/open.c
index a81319b6177f..9d0197db15e7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -54,7 +54,7 @@ int do_truncate(struct user_namespace *mnt_userns, struct dentry *dentry,
 	}
 
 	/* Remove suid, sgid, and file capabilities on truncate too */
-	ret = dentry_needs_remove_privs(dentry);
+	ret = dentry_needs_remove_privs(mnt_userns, dentry);
 	if (ret < 0)
 		return ret;
 	if (ret)
@@ -723,10 +723,10 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 		return -EINVAL;
 	if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
 		return -EINVAL;
-	if (!S_ISDIR(inode->i_mode))
-		newattrs.ia_valid |=
-			ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_KILL_PRIV;
 	inode_lock(inode);
+	if (!S_ISDIR(inode->i_mode))
+		newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
+				     setattr_should_drop_sgid(mnt_userns, inode);
 	/* Continue to send actual fs values, not the mount values. */
 	error = security_path_chown(
 		path,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e654435f1651..b39c5efca180 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3104,7 +3104,7 @@ extern void __destroy_inode(struct inode *);
 extern struct inode *new_inode_pseudo(struct super_block *sb);
 extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
-extern int should_remove_suid(struct dentry *);
+extern int setattr_should_drop_suidgid(struct user_namespace *, struct inode *);
 extern int file_remove_privs(struct file *);
 
 /*
-- 
2.34.1

