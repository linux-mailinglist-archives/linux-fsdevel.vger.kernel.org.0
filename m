Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C0356B4FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 11:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiGHJCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 05:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbiGHJCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:02:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2A231359;
        Fri,  8 Jul 2022 02:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7603B82560;
        Fri,  8 Jul 2022 09:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01998C341C0;
        Fri,  8 Jul 2022 09:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657270920;
        bh=w9TPUlJqaxoHZDsDqKs635FhR9H2bCUZ8asTmk396oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EuT2xl0tBkwE+K7eWjA8ArVECcmiE42G7bxP/BUlotTep3TUTvPsRzQ2IVZL+PgEc
         78rSNLorvC9+ml/0X/mKDHfWg8874oEs+LFrWdWpnTlq6l2erMK8uJJsIfrWdJuzkm
         vtv9qKwW2KQUk6yAkHAKzQDbyRbqaGdxpHMKLHrLAz6tw7DxFb/G3GUKra+VNvygJN
         jdPVY4JCj5WOZp8DaJd6mZx/n0e6VzdmzTsKF/36f/5q8xbHoW2H3x2bslZZtUvSAk
         3hAs4kVH4xiJ+Xk1r+V/YtCVsyV9fDFBFJHK7D2f06LPaE5m4HYr0m0Rz3I55LlCMV
         mrhvAdQC04UFw==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/3] acl: move idmapped mount fixup into vfs_{g,s}etxattr()
Date:   Fri,  8 Jul 2022 11:01:32 +0200
Message-Id: <20220708090134.385160-2-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220708090134.385160-1-brauner@kernel.org>
References: <20220708090134.385160-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=34828; h=from:subject; bh=w9TPUlJqaxoHZDsDqKs635FhR9H2bCUZ8asTmk396oo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQd/8TpUW1vlvXxB0Pi+6aZsw5ZVdxJvjZn1oaE5U+ltivp 9cd1d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenANxkRkaGzylK0w0mbZxWfunH++ULLp 5Yto2DY0uP+sIJP0IV9F9vWcLwT23PnYaLcVd3C12sPRhz96nlwkMlD7YGXvzeLJjfPkHFnB8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This cycle we added support for mounting overlayfs on top of idmapped mounts.
Recently I've started looking into potential corner cases when trying to add
additional tests and I noticed that reporting for POSIX ACLs is currently wrong
when using idmapped layers with overlayfs mounted on top of it.

I'm going to give a rather detailed explanation to both the origin of the
problem and the solution.

Let's assume the user creates the following directory layout and they have a
rootfs /var/lib/lxc/c1/rootfs. The files in this rootfs are owned as you would
expect files on your host system to be owned. For example, ~/.bashrc for your
regular user would be owned by 1000:1000 and /root/.bashrc would be owned by
0:0. IOW, this is just regular boring filesystem tree on an ext4 or xfs
filesystem.

The user chooses to set POSIX ACLs using the setfacl binary granting the user
with uid 4 read, write, and execute permissions for their .bashrc file:

        setfacl -m u:4:rwx /var/lib/lxc/c2/rootfs/home/ubuntu/.bashrc

Now they to expose the whole rootfs to a container using an idmapped mount. So
they first create:

        mkdir -pv /vol/contpool/{ctrover,merge,lowermap,overmap}
        mkdir -pv /vol/contpool/ctrover/{over,work}
        chown 10000000:10000000 /vol/contpool/ctrover/{over,work}

The user now creates an idmapped mount for the rootfs:

        mount-idmapped/mount-idmapped --map-mount=b:0:10000000:65536 \
                                      /var/lib/lxc/c2/rootfs \
                                      /vol/contpool/lowermap

This for example makes it so that /var/lib/lxc/c2/rootfs/home/ubuntu/.bashrc
which is owned by uid and gid 1000 as being owned by uid and gid 10001000 at
/vol/contpool/lowermap/home/ubuntu/.bashrc.

Assume the user wants to expose these idmapped mounts through an overlayfs
mount to a container.

       mount -t overlay overlay                      \
             -o lowerdir=/vol/contpool/lowermap,     \
                upperdir=/vol/contpool/overmap/over, \
                workdir=/vol/contpool/overmap/work   \
             /vol/contpool/merge

The user can do this in two ways:

(1) Mount overlayfs in the initial user namespace and expose it to the
    container.
(2) Mount overlayfs on top of the idmapped mounts inside of the container's
    user namespace.

Let's assume the user chooses the (1) option and mounts overlayfs on the host
and then changes into a container which uses the idmapping 0:10000000:65536
which is the same used for the two idmapped mounts.

Now the user tries to retrieve the POSIX ACLs using the getfacl command

        getfacl -n /vol/contpool/lowermap/home/ubuntu/.bashrc

and to their surprise they see:

        # file: vol/contpool/merge/home/ubuntu/.bashrc
        # owner: 1000
        # group: 1000
        user::rw-
        user:4294967295:rwx
        group::r--
        mask::rwx
        other::r--

indicating the the uid wasn't correctly translated according to the idmapped
mount. The problem is how we currently translate POSIX ACLs. Let's inspect the
callchain in this example:

        idmapped mount /vol/contpool/merge:      0:10000000:65536
        caller's idmapping:                      0:10000000:65536
        overlayfs idmapping (ofs->creator_cred): 0:0:4k /* initial idmapping */

        sys_getxattr()
        -> path_getxattr()
           -> getxattr()
              -> do_getxattr()
                  |> vfs_getxattr()
                  |  -> __vfs_getxattr()
                  |     -> handler->get == ovl_posix_acl_xattr_get()
                  |        -> ovl_xattr_get()
                  |           -> vfs_getxattr()
                  |              -> __vfs_getxattr()
                  |                 -> handler->get() /* lower filesystem callback */
                  |> posix_acl_fix_xattr_to_user()
                     {
                              4 = make_kuid(&init_user_ns, 4);
                              4 = mapped_kuid_fs(&init_user_ns /* no idmapped mount */, 4);
                              /* FAILURE */
                             -1 = from_kuid(0:10000000:65536 /* caller's idmapping */, 4);
                     }

If the user chooses to use option (2) and mounts overlayfs on top of idmapped
mounts inside the container things don't look that much better:

        idmapped mount /vol/contpool/merge:      0:10000000:65536
        caller's idmapping:                      0:10000000:65536
        overlayfs idmapping (ofs->creator_cred): 0:10000000:65536

        sys_getxattr()
        -> path_getxattr()
           -> getxattr()
              -> do_getxattr()
                  |> vfs_getxattr()
                  |  -> __vfs_getxattr()
                  |     -> handler->get == ovl_posix_acl_xattr_get()
                  |        -> ovl_xattr_get()
                  |           -> vfs_getxattr()
                  |              -> __vfs_getxattr()
                  |                 -> handler->get() /* lower filesystem callback */
                  |> posix_acl_fix_xattr_to_user()
                     {
                              4 = make_kuid(&init_user_ns, 4);
                              4 = mapped_kuid_fs(&init_user_ns, 4);
                              /* FAILURE */
                             -1 = from_kuid(0:10000000:65536 /* caller's idmapping */, 4);
                     }

As is easily seen the problem arises because the idmapping of the lower mount
isn't taken into account as all of this happens in do_gexattr(). But
do_getxattr() is always called on an overlayfs mount and inode and thus cannot
possible take the idmapping of the lower layers into account.

This problem is similar for fscaps but there the translation happens as part of
vfs_getxattr() already. Let's walk through an fscaps overlayfs callchain:

        setcap 'cap_net_raw+ep' /var/lib/lxc/c2/rootfs/home/ubuntu/.bashrc

The expected outcome here is that we'll receive the cap_net_raw capability as
we are able to map the uid associated with the fscap to 0 within our container.
IOW, we want to see 0 as the result of the idmapping translations.

If the user chooses option (1) we get the following callchain for fscaps:

        idmapped mount /vol/contpool/merge:      0:10000000:65536
        caller's idmapping:                      0:10000000:65536
        overlayfs idmapping (ofs->creator_cred): 0:0:4k /* initial idmapping */

        sys_getxattr()
        -> path_getxattr()
           -> getxattr()
              -> do_getxattr()
                   -> vfs_getxattr()
                      -> xattr_getsecurity()
                         -> security_inode_getsecurity()                                       ________________________________
                            -> cap_inode_getsecurity()                                         |                              |
                               {                                                               V                              |
                                        10000000 = make_kuid(0:0:4k /* overlayfs idmapping */, 10000000);                     |
                                        10000000 = mapped_kuid_fs(0:0:4k /* no idmapped mount */, 10000000);                  |
                                               /* Expected result is 0 and thus that we own the fscap. */                     |
                                               0 = from_kuid(0:10000000:65536 /* caller's idmapping */, 10000000);            |
                               }                                                                                              |
                               -> vfs_getxattr_alloc()                                                                        |
                                  -> handler->get == ovl_other_xattr_get()                                                    |
                                     -> vfs_getxattr()                                                                        |
                                        -> xattr_getsecurity()                                                                |
                                           -> security_inode_getsecurity()                                                    |
                                              -> cap_inode_getsecurity()                                                      |
                                                 {                                                                            |
                                                                0 = make_kuid(0:0:4k /* lower s_user_ns */, 0);               |
                                                         10000000 = mapped_kuid_fs(0:10000000:65536 /* idmapped mount */, 0); |
                                                         10000000 = from_kuid(0:0:4k /* overlayfs idmapping */, 10000000);    |
                                                         |____________________________________________________________________|
                                                 }
                                                 -> vfs_getxattr_alloc()
                                                    -> handler->get == /* lower filesystem callback */

And if the user chooses option (2) we get:

        idmapped mount /vol/contpool/merge:      0:10000000:65536
        caller's idmapping:                      0:10000000:65536
        overlayfs idmapping (ofs->creator_cred): 0:10000000:65536

        sys_getxattr()
        -> path_getxattr()
           -> getxattr()
              -> do_getxattr()
                   -> vfs_getxattr()
                      -> xattr_getsecurity()
                         -> security_inode_getsecurity()                                                _______________________________
                            -> cap_inode_getsecurity()                                                  |                             |
                               {                                                                        V                             |
                                       10000000 = make_kuid(0:10000000:65536 /* overlayfs idmapping */, 0);                           |
                                       10000000 = mapped_kuid_fs(0:0:4k /* no idmapped mount */, 10000000);                           |
                                               /* Expected result is 0 and thus that we own the fscap. */                             |
                                              0 = from_kuid(0:10000000:65536 /* caller's idmapping */, 10000000);                     |
                               }                                                                                                      |
                               -> vfs_getxattr_alloc()                                                                                |
                                  -> handler->get == ovl_other_xattr_get()                                                            |
                                    |-> vfs_getxattr()                                                                                |
                                        -> xattr_getsecurity()                                                                        |
                                           -> security_inode_getsecurity()                                                            |
                                              -> cap_inode_getsecurity()                                                              |
                                                 {                                                                                    |
                                                                 0 = make_kuid(0:0:4k /* lower s_user_ns */, 0);                      |
                                                          10000000 = mapped_kuid_fs(0:10000000:65536 /* idmapped mount */, 0);        |
                                                                 0 = from_kuid(0:10000000:65536 /* overlayfs idmapping */, 10000000); |
                                                                 |____________________________________________________________________|
                                                 }
                                                 -> vfs_getxattr_alloc()
                                                    -> handler->get == /* lower filesystem callback */

We can see how the translation happens correctly in those cases as the
conversion happens within the vfs_getxattr() helper.

For POSIX ACLs we need to do something similar. However, in contrast to fscaps
we cannot apply the fix directly to the kernel internal posix acl data
structure as this would alter the cached values and would also require a rework
of how we currently deal with POSIX ACLs in general which almost never take the
filesystem idmapping into account (the noteable exception being FUSE but even
there the implementation is special) and instead retrieve the raw values based
on the initial idmapping.

The correct values are then generated right before returning to userspace. The
fix for this is to move taking the mount's idmapping into account directly in
vfs_getxattr() instead of having it be part of posix_acl_fix_xattr_to_user().

To this end we split out two small and unexported helpers
posix_acl_getxattr_idmapped_mnt() and posix_acl_setxattr_idmapped_mnt(). The
former to be called in vfs_getxattr() and the latter to be called in
vfs_setxattr().

Let's go back to the original example. Assume the user chose option (1) and
mounted overlayfs on top of idmapped mounts on the host:

        idmapped mount /vol/contpool/merge:      0:10000000:65536
        caller's idmapping:                      0:10000000:65536
        overlayfs idmapping (ofs->creator_cred): 0:0:4k /* initial idmapping */

        sys_getxattr()
        -> path_getxattr()
           -> getxattr()
              -> do_getxattr()
                  |> vfs_getxattr()
                  |  |> __vfs_getxattr()
                  |  |  -> handler->get == ovl_posix_acl_xattr_get()
                  |  |     -> ovl_xattr_get()
                  |  |        -> vfs_getxattr()
                  |  |           |> __vfs_getxattr()
                  |  |           |  -> handler->get() /* lower filesystem callback */
                  |  |           |> posix_acl_getxattr_idmapped_mnt()
                  |  |              {
                  |  |                              4 = make_kuid(&init_user_ns, 4);
                  |  |                       10000004 = mapped_kuid_fs(0:10000000:65536 /* lower idmapped mount */, 4);
                  |  |                       10000004 = from_kuid(&init_user_ns, 10000004);
                  |  |                       |_______________________
                  |  |              }                               |
                  |  |                                              |
                  |  |> posix_acl_getxattr_idmapped_mnt()           |
                  |     {                                           |
                  |                                                 V
                  |             10000004 = make_kuid(&init_user_ns, 10000004);
                  |             10000004 = mapped_kuid_fs(&init_user_ns /* no idmapped mount */, 10000004);
                  |             10000004 = from_kuid(&init_user_ns, 10000004);
                  |     }       |_________________________________________________
                  |                                                              |
                  |                                                              |
                  |> posix_acl_fix_xattr_to_user()                               |
                     {                                                           V
                                 10000004 = make_kuid(0:0:4k /* init_user_ns */, 10000004);
                                        /* SUCCESS */
                                        4 = from_kuid(0:10000000:65536 /* caller's idmapping */, 10000004);
                     }

And similarly if the user chooses option (1) and mounted overayfs on top of
idmapped mounts inside the container:

        idmapped mount /vol/contpool/merge:      0:10000000:65536
        caller's idmapping:                      0:10000000:65536
        overlayfs idmapping (ofs->creator_cred): 0:10000000:65536

        sys_getxattr()
        -> path_getxattr()
           -> getxattr()
              -> do_getxattr()
                  |> vfs_getxattr()
                  |  |> __vfs_getxattr()
                  |  |  -> handler->get == ovl_posix_acl_xattr_get()
                  |  |     -> ovl_xattr_get()
                  |  |        -> vfs_getxattr()
                  |  |           |> __vfs_getxattr()
                  |  |           |  -> handler->get() /* lower filesystem callback */
                  |  |           |> posix_acl_getxattr_idmapped_mnt()
                  |  |              {
                  |  |                              4 = make_kuid(&init_user_ns, 4);
                  |  |                       10000004 = mapped_kuid_fs(0:10000000:65536 /* lower idmapped mount */, 4);
                  |  |                       10000004 = from_kuid(&init_user_ns, 10000004);
                  |  |                       |_______________________
                  |  |              }                               |
                  |  |                                              |
                  |  |> posix_acl_getxattr_idmapped_mnt()           |
                  |     {                                           V
                  |             10000004 = make_kuid(&init_user_ns, 10000004);
                  |             10000004 = mapped_kuid_fs(&init_user_ns /* no idmapped mount */, 10000004);
                  |             10000004 = from_kuid(0(&init_user_ns, 10000004);
                  |             |_________________________________________________
                  |     }                                                        |
                  |                                                              |
                  |> posix_acl_fix_xattr_to_user()                               |
                     {                                                           V
                                 10000004 = make_kuid(0:0:4k /* init_user_ns */, 10000004);
                                        /* SUCCESS */
                                        4 = from_kuid(0:10000000:65536 /* caller's idmappings */, 10000004);
                     }

The last remaining problem we need to fix here is ovl_get_acl(). During
ovl_permission() overlayfs will call:

        ovl_permission()
        -> generic_permission()
           -> acl_permission_check()
              -> check_acl()
                 -> get_acl()
                    -> inode->i_op->get_acl() == ovl_get_acl()
                        > get_acl() /* on the underlying filesystem)
                          ->inode->i_op->get_acl() == /*lower filesystem callback */
                 -> posix_acl_permission()

passing through the get_acl request to the underlying filesystem. This will
retrieve the acls stored in the lower filesystem without taking the idmapping
of the underlying mount into account as this would mean altering the cached
values for the lower filesystem. So we block using ACLs for now until we
decided on a nice way to fix this. Note this limitation both in the
documentation and in the code.

The most straightforward solution would be to have ovl_get_acl() simply
duplicate the ACLs, update the values according to the idmapped mount and
return it to acl_permission_check() so it can be used in posix_acl_permission()
forgetting them afterwards. This is a bit heavy handed but fairly
straightforward otherwise.

Link: https://github.com/brauner/mount-idmapped/issues/9
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/ksmbd/vfs.c                  |   2 +-
 fs/ksmbd/vfs.h                  |   2 +-
 fs/overlayfs/overlayfs.h        |   3 +-
 fs/posix_acl.c                  | 139 ++++++++++++++++++++++----------
 fs/xattr.c                      |  25 ++++--
 include/linux/posix_acl_xattr.h |  34 +++++---
 include/linux/xattr.h           |   2 +-
 7 files changed, 143 insertions(+), 64 deletions(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 05efcdf7a4a7..7c849024999f 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -963,7 +963,7 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
  */
 int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
 		       struct dentry *dentry, const char *attr_name,
-		       const void *attr_value, size_t attr_size, int flags)
+		       void *attr_value, size_t attr_size, int flags)
 {
 	int err;
 
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 8c37aaf936ab..70da4c0ba7ad 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -109,7 +109,7 @@ ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
 				int attr_name_len);
 int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
 		       struct dentry *dentry, const char *attr_name,
-		       const void *attr_value, size_t attr_size, int flags);
+		       void *attr_value, size_t attr_size, int flags);
 int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 				size_t *xattr_stream_name_size, int s_type);
 int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 4f34b7e02eee..eb6b427d8fa6 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -259,7 +259,8 @@ static inline int ovl_do_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
 				  const char *name, const void *value,
 				  size_t size, int flags)
 {
-	int err = vfs_setxattr(ovl_upper_mnt_userns(ofs), dentry, name, value, size, flags);
+	int err = vfs_setxattr(ovl_upper_mnt_userns(ofs), dentry, name,
+			       (void *)value, size, flags);
 
 	pr_debug("setxattr(%pd2, \"%s\", \"%*pE\", %zu, %d) = %i\n",
 		 dentry, name, min((int)size, 48), value, size, flags, err);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 962d32468eb4..331edcf54cfd 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -375,8 +375,7 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
                                         goto check_perm;
                                 break;
                         case ACL_USER:
-				uid = mapped_kuid_fs(mnt_userns,
-						     i_user_ns(inode),
+				uid = mapped_kuid_fs(mnt_userns, &init_user_ns,
 						     pa->e_uid);
 				if (uid_eq(uid, current_fsuid()))
                                         goto mask;
@@ -390,8 +389,7 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
                                 }
 				break;
                         case ACL_GROUP:
-				gid = mapped_kgid_fs(mnt_userns,
-						     i_user_ns(inode),
+				gid = mapped_kgid_fs(mnt_userns, &init_user_ns,
 						     pa->e_gid);
 				if (in_group_p(gid)) {
 					found = 1;
@@ -710,10 +708,30 @@ EXPORT_SYMBOL(posix_acl_update_mode);
 /*
  * Fix up the uids and gids in posix acl extended attributes in place.
  */
-static void posix_acl_fix_xattr_userns(
-	struct user_namespace *to, struct user_namespace *from,
-	struct user_namespace *mnt_userns,
-	void *value, size_t size, bool from_user)
+static int posix_acl_fix_xattr_common(void *value, size_t size)
+{
+	struct posix_acl_xattr_header *header = value;
+	int count;
+
+	if (!header)
+		return -EINVAL;
+	if (size < sizeof(struct posix_acl_xattr_header))
+		return -EINVAL;
+	if (header->a_version != cpu_to_le32(POSIX_ACL_XATTR_VERSION))
+		return -EINVAL;
+
+	count = posix_acl_xattr_count(size);
+	if (count < 0)
+		return -EINVAL;
+	if (count == 0)
+		return -EINVAL;
+
+	return count;
+}
+
+void posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
+				     const struct inode *inode,
+				     void *value, size_t size)
 {
 	struct posix_acl_xattr_header *header = value;
 	struct posix_acl_xattr_entry *entry = (void *)(header + 1), *end;
@@ -721,35 +739,88 @@ static void posix_acl_fix_xattr_userns(
 	kuid_t uid;
 	kgid_t gid;
 
-	if (!value)
+	if (no_idmapping(mnt_userns, i_user_ns(inode)))
 		return;
-	if (size < sizeof(struct posix_acl_xattr_header))
+
+	count = posix_acl_fix_xattr_common(value, size);
+	if (count < 0)
 		return;
-	if (header->a_version != cpu_to_le32(POSIX_ACL_XATTR_VERSION))
+
+	for (end = entry + count; entry != end; entry++) {
+		switch (le16_to_cpu(entry->e_tag)) {
+		case ACL_USER:
+			uid = make_kuid(&init_user_ns, le32_to_cpu(entry->e_id));
+			uid = mapped_kuid_fs(mnt_userns, &init_user_ns, uid);
+			entry->e_id = cpu_to_le32(from_kuid(&init_user_ns, uid));
+			break;
+		case ACL_GROUP:
+			gid = make_kgid(&init_user_ns, le32_to_cpu(entry->e_id));
+			gid = mapped_kgid_fs(mnt_userns, &init_user_ns, gid);
+			entry->e_id = cpu_to_le32(from_kgid(&init_user_ns, gid));
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+void posix_acl_setxattr_idmapped_mnt(struct user_namespace *mnt_userns,
+				     const struct inode *inode,
+				     void *value, size_t size)
+{
+	struct posix_acl_xattr_header *header = value;
+	struct posix_acl_xattr_entry *entry = (void *)(header + 1), *end;
+	int count;
+	kuid_t uid;
+	kgid_t gid;
+
+	if (no_idmapping(mnt_userns, i_user_ns(inode)))
 		return;
 
-	count = posix_acl_xattr_count(size);
+	count = posix_acl_fix_xattr_common(value, size);
 	if (count < 0)
 		return;
-	if (count == 0)
+
+	for (end = entry + count; entry != end; entry++) {
+		switch (le16_to_cpu(entry->e_tag)) {
+		case ACL_USER:
+			uid = make_kuid(&init_user_ns, le32_to_cpu(entry->e_id));
+			uid = mapped_kuid_user(mnt_userns, &init_user_ns, uid);
+			entry->e_id = cpu_to_le32(from_kuid(&init_user_ns, uid));
+			break;
+		case ACL_GROUP:
+			gid = make_kgid(&init_user_ns, le32_to_cpu(entry->e_id));
+			gid = mapped_kgid_user(mnt_userns, &init_user_ns, gid);
+			entry->e_id = cpu_to_le32(from_kgid(&init_user_ns, gid));
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void posix_acl_fix_xattr_userns(
+	struct user_namespace *to, struct user_namespace *from,
+	void *value, size_t size)
+{
+	struct posix_acl_xattr_header *header = value;
+	struct posix_acl_xattr_entry *entry = (void *)(header + 1), *end;
+	int count;
+	kuid_t uid;
+	kgid_t gid;
+
+	count = posix_acl_fix_xattr_common(value, size);
+	if (count < 0)
 		return;
 
 	for (end = entry + count; entry != end; entry++) {
 		switch(le16_to_cpu(entry->e_tag)) {
 		case ACL_USER:
 			uid = make_kuid(from, le32_to_cpu(entry->e_id));
-			if (from_user)
-				uid = mapped_kuid_user(mnt_userns, &init_user_ns, uid);
-			else
-				uid = mapped_kuid_fs(mnt_userns, &init_user_ns, uid);
 			entry->e_id = cpu_to_le32(from_kuid(to, uid));
 			break;
 		case ACL_GROUP:
 			gid = make_kgid(from, le32_to_cpu(entry->e_id));
-			if (from_user)
-				gid = mapped_kgid_user(mnt_userns, &init_user_ns, gid);
-			else
-				gid = mapped_kgid_fs(mnt_userns, &init_user_ns, gid);
 			entry->e_id = cpu_to_le32(from_kgid(to, gid));
 			break;
 		default:
@@ -758,34 +829,20 @@ static void posix_acl_fix_xattr_userns(
 	}
 }
 
-void posix_acl_fix_xattr_from_user(struct user_namespace *mnt_userns,
-				   struct inode *inode,
-				   void *value, size_t size)
+void posix_acl_fix_xattr_from_user(void *value, size_t size)
 {
 	struct user_namespace *user_ns = current_user_ns();
-
-	/* Leave ids untouched on non-idmapped mounts. */
-	if (no_idmapping(mnt_userns, i_user_ns(inode)))
-		mnt_userns = &init_user_ns;
-	if ((user_ns == &init_user_ns) && (mnt_userns == &init_user_ns))
+	if (user_ns == &init_user_ns)
 		return;
-	posix_acl_fix_xattr_userns(&init_user_ns, user_ns, mnt_userns, value,
-				   size, true);
+	posix_acl_fix_xattr_userns(&init_user_ns, user_ns, value, size);
 }
 
-void posix_acl_fix_xattr_to_user(struct user_namespace *mnt_userns,
-				 struct inode *inode,
-				 void *value, size_t size)
+void posix_acl_fix_xattr_to_user(void *value, size_t size)
 {
 	struct user_namespace *user_ns = current_user_ns();
-
-	/* Leave ids untouched on non-idmapped mounts. */
-	if (no_idmapping(mnt_userns, i_user_ns(inode)))
-		mnt_userns = &init_user_ns;
-	if ((user_ns == &init_user_ns) && (mnt_userns == &init_user_ns))
+	if (user_ns == &init_user_ns)
 		return;
-	posix_acl_fix_xattr_userns(user_ns, &init_user_ns, mnt_userns, value,
-				   size, false);
+	posix_acl_fix_xattr_userns(user_ns, &init_user_ns, value, size);
 }
 
 /*
diff --git a/fs/xattr.c b/fs/xattr.c
index e8dd03e4561e..a1f4998bc6be 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -282,9 +282,15 @@ __vfs_setxattr_locked(struct user_namespace *mnt_userns, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(__vfs_setxattr_locked);
 
+static inline bool is_posix_acl_xattr(const char *name)
+{
+	return (strcmp(name, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
+	       (strcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT) == 0);
+}
+
 int
 vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
-	     const char *name, const void *value, size_t size, int flags)
+	     const char *name, void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
 	struct inode *delegated_inode = NULL;
@@ -292,12 +298,16 @@ vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	int error;
 
 	if (size && strcmp(name, XATTR_NAME_CAPS) == 0) {
-		error = cap_convert_nscap(mnt_userns, dentry, &value, size);
+		error = cap_convert_nscap(mnt_userns, dentry,
+					  (const void **)&value, size);
 		if (error < 0)
 			return error;
 		size = error;
 	}
 
+	if (size && is_posix_acl_xattr(name))
+		posix_acl_setxattr_idmapped_mnt(mnt_userns, inode, value, size);
+
 retry_deleg:
 	inode_lock(inode);
 	error = __vfs_setxattr_locked(mnt_userns, dentry, name, value, size,
@@ -431,7 +441,10 @@ vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return ret;
 	}
 nolsm:
-	return __vfs_getxattr(dentry, inode, name, value, size);
+	error = __vfs_getxattr(dentry, inode, name, value, size);
+	if (error > 0 && is_posix_acl_xattr(name))
+		posix_acl_getxattr_idmapped_mnt(mnt_userns, inode, value, size);
+	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_getxattr);
 
@@ -577,8 +590,7 @@ static void setxattr_convert(struct user_namespace *mnt_userns,
 	if (ctx->size &&
 		((strcmp(ctx->kname->name, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		(strcmp(ctx->kname->name, XATTR_NAME_POSIX_ACL_DEFAULT) == 0)))
-		posix_acl_fix_xattr_from_user(mnt_userns, d_inode(d),
-						ctx->kvalue, ctx->size);
+		posix_acl_fix_xattr_from_user(ctx->kvalue, ctx->size);
 }
 
 int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
@@ -695,8 +707,7 @@ do_getxattr(struct user_namespace *mnt_userns, struct dentry *d,
 	if (error > 0) {
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_to_user(mnt_userns, d_inode(d),
-							ctx->kvalue, error);
+			posix_acl_fix_xattr_to_user(ctx->kvalue, error);
 		if (ctx->size && copy_to_user(ctx->value, ctx->kvalue, error))
 			error = -EFAULT;
 	} else if (error == -ERANGE && ctx->size >= XATTR_SIZE_MAX) {
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index 1766e1de6956..b6bd3eac2bcc 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -33,21 +33,31 @@ posix_acl_xattr_count(size_t size)
 }
 
 #ifdef CONFIG_FS_POSIX_ACL
-void posix_acl_fix_xattr_from_user(struct user_namespace *mnt_userns,
-				   struct inode *inode,
-				   void *value, size_t size);
-void posix_acl_fix_xattr_to_user(struct user_namespace *mnt_userns,
-				   struct inode *inode,
-				 void *value, size_t size);
+void posix_acl_fix_xattr_from_user(void *value, size_t size);
+void posix_acl_fix_xattr_to_user(void *value, size_t size);
+void posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
+				     const struct inode *inode,
+				     void *value, size_t size);
+void posix_acl_setxattr_idmapped_mnt(struct user_namespace *mnt_userns,
+				     const struct inode *inode,
+				     void *value, size_t size);
 #else
-static inline void posix_acl_fix_xattr_from_user(struct user_namespace *mnt_userns,
-						 struct inode *inode,
-						 void *value, size_t size)
+static inline void posix_acl_fix_xattr_from_user(void *value, size_t size)
 {
 }
-static inline void posix_acl_fix_xattr_to_user(struct user_namespace *mnt_userns,
-					       struct inode *inode,
-					       void *value, size_t size)
+static inline void posix_acl_fix_xattr_to_user(void *value, size_t size)
+{
+}
+static inline void
+posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
+				const struct inode *inode, void *value,
+				size_t size)
+{
+}
+static inline void
+posix_acl_setxattr_idmapped_mnt(struct user_namespace *mnt_userns,
+				const struct inode *inode, void *value,
+				size_t size)
 {
 }
 #endif
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 4c379d23ec6e..979a9d3e5bfb 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -61,7 +61,7 @@ int __vfs_setxattr_locked(struct user_namespace *, struct dentry *,
 			  const char *, const void *, size_t, int,
 			  struct inode **);
 int vfs_setxattr(struct user_namespace *, struct dentry *, const char *,
-		 const void *, size_t, int);
+		 void *, size_t, int);
 int __vfs_removexattr(struct user_namespace *, struct dentry *, const char *);
 int __vfs_removexattr_locked(struct user_namespace *, struct dentry *,
 			     const char *, struct inode **);
-- 
2.34.1

