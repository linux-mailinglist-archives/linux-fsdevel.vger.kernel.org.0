Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72072649D75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 12:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiLLLWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 06:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiLLLWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:22:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1A4386;
        Mon, 12 Dec 2022 03:21:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D3F0B80CB6;
        Mon, 12 Dec 2022 11:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F94C433D2;
        Mon, 12 Dec 2022 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670844068;
        bh=sqYGUpdntzmIEmj44sEOPdeOIF08iqbXOKKLcIsKpDU=;
        h=From:To:Cc:Subject:Date:From;
        b=XvIMOQmigXWWGKxBQqfwjNOzo7L3gW732FBIuuqjW1XirwkmX/ZdwzPNS06tQoWAX
         Cp5ZFpdr0wDNKlPMpGaDFHgT5+LjkRkGJJMKNAldu0fOZyrfiG1gQl5f6nAQCjrNKG
         ZNxUuIh0rVLvwhmsmfoTzZikyMWg0pqfNF3AN9l66Tu63K9PnDiwAAcMz6yw1S5eds
         RmEVcgG9FeJPNM6ieQDj2DpyMKnwlYQ0/cSzRE9pH5RnuNQCLNZU8gv8LZb7LQxv83
         Cpr2iIWMYuV+9hKmhpdMkD63sNcTeUctwteAN/bkZOBK28W8WmkLBPSAka1v9NFzPy
         CGp0SSeeLCjZg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] setgid inheritance updates for v6.2
Date:   Mon, 12 Dec 2022 12:20:53 +0100
Message-Id: <20221212112053.99208-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9577; i=brauner@kernel.org; h=from:subject; bh=sqYGUpdntzmIEmj44sEOPdeOIF08iqbXOKKLcIsKpDU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRP5+s87yT6/42OmcN96T/5vLuaOJa/VFPn1L6/69Ghxx2L ep8d7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgI+ydGhh5NvdRkvsWxq6ZUnYzgnq lZ2rLkwKJKu++cwlPdX2jZ2jD8U2GY3i7wMMbgcazp3SUvH80pycn1ejhbSaFwjYbkM/v7jAA=
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

Hey Linus,

/* Summary */
This contains the work to make setgid inheritance consistent between modifying
a file and when changing ownership or mode as this has been a repeated source
of very subtle bugs. The gist is that we perform the same permission checks in
the write path as we do in the ownership and mode changing paths after this
series where we're currently doing different things.

We've already made setgid inheritance a lot more consistent and reliable in the
last releases by moving setgid stripping from the individual filesystems up
into the vfs. This aims to make the logic even more consistent and easier to
understand and also to fix long-standing overlayfs setgid inheritance bugs.
Miklos was nice enough to just let me carry the trivial overlayfs patches from
Amir too.

Below is a more detailed explanation how the current difference in setgid
handling lead to very subtle bugs exemplified via overlayfs which is a victim
of the current rules. I hope this explains why I think taking the regression
risk here is worth it.

A long while ago I found a few setgid inheritance bugs in overlayfs in the
write path in certain conditions. Amir recently picked this back up in
https://lore.kernel.org/linux-fsdevel/20221003123040.900827-1-amir73il@gmail.com
and I jumped on board to fix this more generally. On the surface all that
overlayfs would need to fix setgid inheritance would be to call
file_remove_privs() or file_modified() but actually that isn't enough because
the setgid inheritance api is wildly inconsistent in that area.

Before this pr setgid stripping in file_remove_privs()'s old
should_remove_suid() helper was inconsistent with other parts of the vfs.
Specifically, it only raises ATTR_KILL_SGID if the inode is S_ISGID and S_IXGRP
but not if the inode isn't in the caller's groups and the caller isn't
privileged over the inode although we require this already in setattr_prepare()
and setattr_copy() and so all filesystem implement this requirement implicitly
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

The test basically creates a file with 6666 permissions. While the file has the
S_ISUID and S_ISGID bits set it does not have the S_IXGRP set. On a regular
filesystem like xfs what will happen is:

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

But we also see that ATTR_KILL_SGID won't be set because while the file is
S_ISGID it is not S_IXGRP (see above) which is a condition for ATTR_KILL_SGID
being raised.

So by the time we call notify_change() we have attr->ia_valid set to
ATTR_KILL_SUID | ATTR_FORCE. Now notify_change() sees that ATTR_KILL_SUID is
set and does:

ia_valid      = attr->ia_valid |= ATTR_MODE
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
shows up more clearly. When e.g., ovl_setattr() is hit from ovl_fallocate()'s
call to file_remove_privs() then ATTR_KILL_SUID and ATTR_KILL_SGID might be
raised but because the check in notify_change() is questioning the
ATTR_KILL_SGID flag again by requiring S_IXGRP for it to be stripped the
S_ISGID bit isn't removed even though it should be stripped:

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
                  /* TAKE ON MOUNTER'S CREDS */
                  -> ovl_do_notify_change()
                     -> notify_change()
                  /* GIVE UP MOUNTER'S CREDS */
     /* TAKE ON MOUNTER'S CREDS */
     -> vfs_fallocate()
        -> xfs_file_fallocate()
           -> file_modified()
              -> __file_remove_privs()
                 -> dentry_needs_remove_privs()
                    -> should_remove_suid()
                 -> __remove_privs()
                    newattrs.ia_valid = attr_force | kill;
                    -> notify_change()

The fix for all of this is to make file_remove_privs()'s should_remove_suid()
helper to perform the same checks as we already require in setattr_prepare()
and setattr_copy() and have notify_change() not pointlessly requiring S_IXGRP
again. It doesn't make any sense in the first place because the caller must
calculate the flags via should_remove_suid() anyway which would raise
ATTR_KILL_SGID.

/* Testing */
clang: Ubuntu clang version 15.0.2-1
gcc: gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.2-rc1 and have been sitting in linux-next. No build
failures or warnings were observed.

Note, that some xfstests will now fail as these patches will cause the setgid
bit to be lost in certain conditions for unprivileged users modifying a setgid
file when they would've been kept otherwise. I think this risk is worth taking
and I explained and mentioned this multiple times on the list:
https://lore.kernel.org/linux-fsdevel/20221122142010.zchf2jz2oymx55qi@wittgenstein

Enforcing the rules consistently across write operations and chmod/chown will
lead to losing the setgid bit in cases were it might've been retained before.

While I've mentioned this a few times but it's worth repeating just to make
sure that this is understood. For the sake of maintainability, consistency, and
security this is a risk worth taking.

If we really see regressions for workloads the fix is to have special setgid
handling in the write path again with different semantics from chmod/chown and
possibly additional duct tape for overlayfs. I'll update the relevant xfstests
with if you should decide to merge this second setgid cleanup. Before that
people should be aware that there might be failures for fstests where
unprivileged users modify a setgid file.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.ovl.setgid.v6.2

for you to fetch changes up to 8d84e39d76bd83474b26cb44f4b338635676e7e8:

  fs: use consistent setgid checks in is_sxid() (2022-11-24 18:07:01 +0100)

Please consider pulling these changes from the signed fs.ovl.setgid.v6.2 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.ovl.setgid.v6.2

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: remove privs in ovl_copyfile()
      ovl: remove privs in ovl_fallocate()

Christian Brauner (5):
      attr: add in_group_or_capable()
      fs: move should_remove_suid()
      attr: add setattr_should_drop_sgid()
      attr: use consistent sgid stripping checks
      fs: use consistent setgid checks in is_sxid()

 Documentation/trace/ftrace.rst |  2 +-
 fs/attr.c                      | 74 ++++++++++++++++++++++++++++++++++++++----
 fs/fuse/file.c                 |  2 +-
 fs/inode.c                     | 64 ++++++++++++++++--------------------
 fs/internal.h                  | 10 +++++-
 fs/ocfs2/file.c                |  4 +--
 fs/open.c                      |  8 ++---
 fs/overlayfs/file.c            | 28 ++++++++++++++--
 include/linux/fs.h             |  4 +--
 9 files changed, 140 insertions(+), 56 deletions(-)
