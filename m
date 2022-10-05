Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B355F5747
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 17:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJEPOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 11:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJEPOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:14:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204F165F4;
        Wed,  5 Oct 2022 08:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75BE86173E;
        Wed,  5 Oct 2022 15:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC9AC433D6;
        Wed,  5 Oct 2022 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664982886;
        bh=LWSgW6YT2qHB3b0b3xksOCyVPoE2XV5kW6OVouOH45c=;
        h=From:To:Cc:Subject:Date:From;
        b=S0pXLB6nqkvXMOiVYuRxt69s1MJZYVEqIoTBgLEEa8if2HnVZOOeDK2MLLxtJyCtj
         K/kOAk/KJSEYLoxD5BApz+D8lhW/LTI3dfwQUz68rpWuSkLFdyqA2JV2yYqOnOXdYL
         WKjuGra4AOnYNEAquh/MBtRcClnRnWBoTnFr1oHWFfXcxtN3xFf61PQz8g+pDGy0OY
         tem1S0+CtO7vvCGFh3OADHQgvwyPCX8mI4YEgeOdNBJtqnJqtmrE1/Rnr7PWvHDoZR
         6gp5y260/Srhb6JzGjGdK8o8RN+Wu6QtwMTtNb0puWB3Flo6+2P0X+SM7c1dsbbpDK
         rdOGbqTT3Ji9w==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] fs: improve setgid stripping consistency even more
Date:   Wed,  5 Oct 2022 17:14:30 +0200
Message-Id: <20221005151433.898175-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5717; i=brauner@kernel.org; h=from:subject; bh=iLKUIOCcih+w61RpT7wbs5P9d8I2DLn/b68L+8HdXqY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTbznfYfu7TszzHmw/3PuPgcAgO2CPAtn+XwP4/Z6Vir+v9 FRb+1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR7eUMv1lX5EziVHR9V/mF8aJizU Oru3t6LjybdWLFvKjZEx22LvjG8FcgtP/Xi6hn7G8blmvevOVwu2fzv7SFMe0iC04eW9V/15oFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Christian Brauner (Microsoft)" <brauner@kernel.org>

Hey everyone,

A long while ago I found a few setgid inheritance bugs in overlayfs in
certain conditions. Amir recently picked this back up in
https://lore.kernel.org/linux-fsdevel/20221003123040.900827-1-amir73il@gmail.com
and I jumped on board to fix this more generally. This series should
make setgid stripping more consistent and fix the related overlayfs bugs.

Currently setgid stripping in file_remove_privs()'s should_remove_suid()
helper is inconsistent with other parts of the vfs. Specifically, it only
raises ATTR_KILL_SGID if the inode is S_ISGID and S_IXGRP but not if the
inode isn't in the caller's groups and the caller isn't privileged over the
inode although we require this already in setattr_prepare() and
setattr_copy() and so all filesystem implement this requirement implicitly
because they have to use setattr_{prepare,copy}() anyway.

But the inconsistency shows up in setgid stripping bugs for overlayfs in
xfstests. For example, we test whether suid and setgid stripping works
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

Thanks!
Christian

Amir Goldstein (2):
  ovl: remove privs in ovl_copyfile()
  ovl: remove privs in ovl_fallocate()

Christian Brauner (1):
  attr: use consistent sgid stripping checks

 fs/attr.c           |  4 +++-
 fs/fuse/file.c      |  2 +-
 fs/inode.c          | 47 +++++++++++++++++++++++++++++++--------------
 fs/internal.h       |  3 ++-
 fs/ocfs2/file.c     |  4 ++--
 fs/open.c           |  2 +-
 fs/overlayfs/file.c | 28 ++++++++++++++++++++++++---
 include/linux/fs.h  |  2 +-
 8 files changed, 68 insertions(+), 24 deletions(-)

-- 
2.34.1

