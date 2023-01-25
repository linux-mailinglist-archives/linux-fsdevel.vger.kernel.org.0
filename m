Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A02C67AF1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 11:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjAYKBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 05:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjAYKBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:01:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98DC51C4D;
        Wed, 25 Jan 2023 02:01:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64E7761450;
        Wed, 25 Jan 2023 10:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA74C433D2;
        Wed, 25 Jan 2023 10:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674640860;
        bh=4zhVIZkrOjrUGL2yb47IIdWlbz0FbHxlsw6X6A0igOc=;
        h=From:To:Cc:Subject:Date:From;
        b=N61SbrXALksG4oUeIA1ClFhWSMgJz4maLyu+05L5sCHLU/MpfemtfLuhNAwnXgOAc
         jM+3zhnKnnW/kn3ORlCnXofzUfGlWwpc37r1WOt6JWvvIvyuMfEMwUZwi4pCltGo9Z
         v6J4H4mTA2waytIBgssQ/sWnE3NJ2KjxPFuvwcYKboj1yLc74yDj35Fttss5rZlKur
         fxH6AtTcjod3cCjZXiO2a8EcIQ/p2Icw2puySQJs60fD6/vVEsqadqRqIDZHSZU3Kb
         IDa43Mns+PT7YJBViVXQpS7w8DuDZlSje0hNMstCXO68tA+lZcw0IeGykVtEQGsO57
         kXAbF8b826w+g==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Subject: [GIT PULL] fuse acl fix for v6.2-rc6
Date:   Wed, 25 Jan 2023 11:00:40 +0100
Message-Id: <20230125100040.374709-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4965; i=brauner@kernel.org; h=from:subject; bh=4zhVIZkrOjrUGL2yb47IIdWlbz0FbHxlsw6X6A0igOc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRf+Ht4tV798eY9+f0/E0TWHZ7LHnx47o+SfLHjMkLRk85r cqqe6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIhhaG/5ELk8Q8fJt3q/U4J8xV+P fz253n5peXZXDG+tU9m7vx1iWGf3rik1rrjd0eveGOm9RndeWNZla1YIM/m97rrJfLrOJmcwIA
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
This cycle we ported all filesystems to the new posix acl api. While
looking at further simplifications in this area to remove the last
remnants of the generic dummy posix acl handlers we realized that we
regressed fuse daemons that don't set FUSE_POSIX_ACL but still make use
of posix acls.

Before the posix acl api fuse daemons without FUSE_POSIX_ACL were able
to use posix acls with two caveats. First, that acls weren't cached and
second that they weren't used by the VFS for permission checking. This
allowed daemons to perform all permission checking in userspace. For
this fuse specific xattr handlers were used.

Since the new posix acl ap doesn't depend on the xattr handler
infrastructure anymore and instead only relies on the posix acl inode
operations, daemons without FUSE_POSIX_ACL are unable to use posix acls
like they used to.

We can fix this for v6.2 by copying what we did for overlayfs during the
posix acl api conversion. Fuse just implements a dedicated
->get_inode_acl() method as does overlayfs. Fuse can then also uses this
to express different needs for vfs permission checking during lookup and
acl based retrieval via the regular system call path.

This allows fuse to continue to refuse retrieving posix acls for daemons
that don't set FUSE_POSXI_ACL for permission checking while also
allowing a fuse server to retrieve it via the usual system calls.

This is a good an simple fix for v6.2. For v6.3 we should extend the
->get_inode_acl() inode operation to not just pass a simple boolean to
indicate rcu lookup but instead make it a flag argument.

Then in addition to passing the information that this is an rcu lookup
to the filesystem we can also introduce a flag that tells the filesystem
that this is a request from the VFS to use these acls for permission
checking. Then fuse can refuse the get acl request for
permission checking when the daemon doesn't have FUSE_POSIX_ACL set in
the same get acl method.

This also allows us to simplify overlayfs and remove the dedicated
->get_acl() method for both overlayfs and fuse. But since that will be a
bigger change as we need to update the ->get_inode_acl() inode operation
it is unsuitable for v6.2.

A nice side-effect of this change is that for fuse daemons with and
without FUSE_POSIX_ACL the same code is used for posix acls in a
backwards compatible way and we can remove the legacy xattr handlers
completely. While at it, we've also added comments to explain the
expected behavior for daemons without FUSE_POSIX_ACL.

/* Notes */
Miklos is aware that this is going through my tree which contains one
branch that converts all of the vfs to struct mnt_idmap and another one
that fully removes the remnants of the legacy generic posix acl xattr
handlers. The conversion branch will cause a merge conflict with this
patch because it changes the signature of the inode operation. And the
removal series branch on this being merged.

/* Testing */
clang: Ubuntu clang version 15.0.2-1
gcc: gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.2-rc1. This patch has been merged into my
for-next but hasn't showed up in linux-next yet. I decided to go ahead
and send it so the regression will be fixed quickly.

No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions. Since this is a
fuse patch testing this behavior would involve a bunch of userspace fuse
daemons. The one that I tested this with was virtiofs with and without
FUSE_POSIX_ACL set.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline. However, as mentioned above this will generate
generate another merge conflict for linux-next.

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.fuse.acl.v6.2-rc6

for you to fetch changes up to facd61053cff100973921d4d45d47cf53c747ec6:

  fuse: fixes after adapting to new posix acl api (2023-01-24 16:33:37 +0100)

Please consider pulling these changes from the signed fs.fuse.acl.v6.2-rc6 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.fuse.acl.v6.2-rc6

----------------------------------------------------------------
Christian Brauner (1):
      fuse: fixes after adapting to new posix acl api

 fs/fuse/acl.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 fs/fuse/dir.c    |  6 +++--
 fs/fuse/fuse_i.h |  6 ++---
 fs/fuse/inode.c  | 21 +++++++++--------
 fs/fuse/xattr.c  | 51 ------------------------------------------
 5 files changed, 78 insertions(+), 74 deletions(-)
