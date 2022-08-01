Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B39586D50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 16:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiHAOz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 10:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiHAOzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:55:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B628B32ED4;
        Mon,  1 Aug 2022 07:55:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF691B8122D;
        Mon,  1 Aug 2022 14:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDC4C433D6;
        Mon,  1 Aug 2022 14:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659365749;
        bh=h1Fe0gINZpv34l2yAELLWUO7QdB7midfPw21rlOVcsA=;
        h=From:To:Cc:Subject:Date:From;
        b=VFGMjV9KwFoGos3R4pzJF7SUwwMBcCdQ1GyZiBDFBYY6dUsi/akHBLzNsNIxyLxcG
         jokVFkDOZ8UKyPqifPRRbHwnFZrBzcBsGYDaIM+DVjg6ySYn/DB7iHwPdNsMtiCmFh
         t9oMg8ROWsNysWHrwzyyVAWB+mbTJoI0LWKKPZoma1ZscABoCOBSOgcZ1g85z8ckuk
         OD1KUIwgDA9PmYpiIpwaKKsj+4xDGLKpTcYwIWADOZ3JC4saDJm6kiPQNQYokws2zl
         1qQsLMyICTKztmlVT0H1ZnsFUJvydtM7Skt450ZsgGhNYBEbb7JsR+H1YHeFP8BTRv
         jE3nkl5Aq0psw==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Subject: [GIT PULL] acl updates for v5.20/v6.0
Date:   Mon,  1 Aug 2022 16:55:20 +0200
Message-Id: <20220801145520.1532837-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
Last cycle we introduced support for mounting overlayfs on top of idmapped
mounts. While looking into additional testing we realized that posix acls don't
really work correctly with stacking filesystems on top of idmapped layers. We
already knew what the fix were but it would require work that is more suitable
for the merge window so we turned off posix acls for v5.19 for overlayfs on top
of idmapped layers with Miklos routing my patch upstream in
72a8e05d4f66 ("Merge tag 'ovl-fixes-5.19-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs").

As announced this pull request here contains the work to support posix acls for
overlayfs on top of idmapped layers. Since the posix acl fixes should use the
new vfs{g,u}id_t work the associated branch has been merged in. (We sent a pull
request for this earlier.)

We've also pulled in Miklos pull request containing my patch to turn of posix
acls on top of idmapped layers. This allowed us to avoid rebasing the branch
which we didn't like because we were already at rc7 by then. Merging it in
allows this branch to first fix posix acls and then to cleanly revert the
temporary fix it brought in by commit 4a47c6385bb4 ("ovl: turn of SB_POSIXACL
with idmapped layers temporarily"). So with this pull request merged no more
follow up patches are needed.

Note, the pull request contains the VFS work and the single overlayfs patch
that is required. This was easier and clearer and doesn't require splitting
this work over two different trees. We've announced this multiple times on the
overlayfs mailing list and didn't here any objections.

The last patch in this series adds Seth Forshee as a co-maintainer for idmapped
mounts. Seth has been integral to all of this work and is also the main
architect behind the filesystem idmapping work which ultimately made
filesystems such as FUSE and overlayfs available in containers. He continues to
be active in both development and review. I'm very happy he decided to help and
he has my full trust. This increases the bus factor which is always great for
work like this. I'm honestly very excited about this because I think in general
we don't do great in the bringing on new maintainers department.

----------
What follows is an optional excursion into posix acls which provides a wider
background. But the pull request message can be cut off here if not useful.

Last we want to lose a few detailed words on ACL_{GROUP,USER} posix acls and how
they violate type safety precautions we usually take and how this is aggravated
by stacking filesystems. While the commit messages in this series contain
detailed information we've spent some time going over posix acls (and fscaps)
and it's worth pointing out a few details. Maybe we should add some of this as
kernel documentation in the future.

When we enter the kernel to get or set ACL_{GROUP,USER} posix acls the first
thing the VFS does is to map the {g,u}ids stored as ACL_{GROUP,USER} posix acls
into the caller's idmapping ("caller_idmapping").

This mapping or "translation" is performed by posix_acl_fix_xattr_from_user()
for setxattr() and by posix_acl_fix_xattr_to_user() for getxattr().

The underlying helper called by posix_acl_fix_xattr_{from,to}_user() has a
pecular implemation that is important to understand in order to understand
ACL_{GROUP,USER} posix acls.

The posix_acl_fix_xattr_{from,to}_user() helpers always use the
initial_idmapping independent of whether or not the underlying filesystem that
the posix acls were retrieved from has been mounted with a filesystem idmapping
("fs_idmapping") or not.

Usually, when writing {g,u}ids passed in from userspace to the filesystem the
kernel translates the {g,u}id_t into a k{g,u}id_t right at the userspace <->
VFS boundary. Then they are kept as k{g,u}id_t right until the moment where
they need to be written to the backing store.

For example, consider a regular chown() call. Right when entering the VFS the
kernel will map the {g,u}id_t values passed in from userspace into a k{g,u}id_t
and store it in an appropriate kernel internal struct iattr. Once the inode is
changed and the change ultimately written back to disk the kernel will map the
k{g,u}id_t back into a {g,u}id_t and write these values to disk taking the
fs_idmapping into account.

The kernel will take care to never conflate {g,u}id_t and k{g,u}id_t. It will
especially not translate k{g,u}id_t back into {g,u}id_t unless at a relevant
boundary. But for posix acls this isn't true.

Going back to posix_acl_fix_xattr_from_user() the kernel does indeed first map
the {g,u}id_t provided in ACL_{GROUP,USER} into k{g,u}id_t in the
caller_idmapping. But then it immediately maps the just generated k{g,u}id_t
back to a {g,u}id_t using the initial_idmapping.

And strangly all that this will achieve is an identity translation that turns
the k{g,u}id_t that were just generated back into {g,u}id_t with the samve
value as the k{g,u}id_t that was just created. This is odd because the kernel
should be adamant about translating between userspace {g,u}id_t and k{g,u}id_t
only at either the userspace <-> VFS or the VFS <-> backing store boundary.

The reason for this is simple and nasty. The VFS currently abuses the uapi
struct posix_acl_xattr_entry to transport k{g,u}id_t from the VFS down to the
filesystem and from the filesystem up to the VFS in the form of userspace
{g,u}id_t. This has the consequence that the kernel intentionally breaks it's
own type-safety requirements.

The only reason that the kernel uses the initial_idmapping in
posix_acl_fix_xattr_from_user() is to translate the just generated k{g,u}id_t
back into {g,u}id_t of the same value so that the target value can be
communicated to and from the filesystem without having to introduce an
additional kernel internal struct that would contain k{g,u}id_t values and
would perserve type safety. In other words, this is a classic hack.

This has other consequences. For example, the callchains that posix acls are
involved in look extremely weird because the VFS always uses the
initial_idmapping when translating between the uapi struct
posix_acl_xattr_entry and the kernel internal struct posix_acl even if the
filesystem is mounted with an fs_idmapping.

The cost of this is that it becomes very hard to understand what is going on
especially when lacking proper documentation. It is unclear why the
fs_idmapping is completely irrelevant even though the kernel translates between
k{g,u}id_t and {g,u}id_t multiple times in a standard posix acl callchain. Just
consider xfs for a second and roughly follow the conversion in getxattr():

    xfs_get_acl(uid_t/gid_t -> kuid_t/kgid_t)
    posix_acl_from_xattr(kuid_t/kgid_t -> uid_t/gid_t)
    posix_acl_fix_xattr_to_user(uid_t/gid_t -> kuid_t/kgid_t -> uid_t/gid_t)

when really it should be:

    xfs_get_acl(uid_t/gid_t -> kuid_t/kgid_t)
    posix_acl_fix_xattr_to_user(kuid_t/kgid_t -> uid_t/gid_t)

This is a whole lot of subtlety and ripe for confusion and bugs and bound to
confuse developers and it is certain to wreak havoc when bringing stacking
filesystems like overlayfs into the mix.

Overlayfs callchains are more complicated because certain functions will be hit
twice in an overlayfs callchain: once for the overlayfs layer and once for the
lower layer:

sys_setxattr()
-> vfs_setxattr() /* overlayfs */
   -> vfs_setxattr() /* lower fs such as xfs, btrfs, FUSE */

The subtle type confusions are even more problematic now because they have to
be reasoned about in scenarios where two filesystems are involved. That's not
taking into account that the type confusion has to be kept around for an even
longer time and passed into even more complicated and deep callchains.

Now when an idmapped mount is in the mix the mnt_idmapping needs to be taken
into account when ownership information is needed. This comes down to undoing
the fs_idmapping and applying the mnt_idmapping.

The idmapped mount helpers (e.g., make_vfs{g,u}id() and from_vfs{g,u}id())
express the dependency between the fs_idmapping and the mnt_idmapping and thus
suggest even more strongly that the fs_idmapping must be used whenever they are
called.

The problem is that the type safety subversion in ACL_{GROUP,USER} now becomes
even more problematic. First, because the developer needs to be aware that the
fs_idmapping is completely irrelevant in posix_acl_fix_xattr_{from,to}_user()
and thus is also irrelevant for idmapped mount helpers.

That itself is already a feat because the developer needs to be aware of the
callchain pecularities of posix acls. That problem would not exist if the type
passed down into or up from the filesystem would stay a k{g,u}id_t or
vfs{g,u}id_t in the newer callchains right until the moment where we transition
between the VFS <-> userspace or backingstore <-> VFS boundary.

Second, the mnt_idmapping is a property of the VFS that is tied to a mount
created for a specific filesystem. So the mnt_idmapping cannot be taken into
account for ACL_{GROUP,USER} posix acls in some early place of a stacking
callchain that overlayfs generates. Since they are a property of each layer in
a filesystem stack generated by overlayfs they need to be taken into account at
specific places in the callchain. But before this branch we did:

sys_setxattr()
-> do_setxattr()
   -> setxattr_convert()
      -> posix_acl_fix_xattr_from_user() /* translation step */
   -> vfs_setxattr() /* overlayfs */
      -> vfs_setxattr() /* lower fs such as xfs, btrfs, FUSE */

We can see that the translation happens outside vfs_setxattr() in
do_setxattr() including taking the mnt_idmapping into account. But that means
the mnt_idmapping of the lower layer cannot be taken into account as the
translation happens only in the top layer of the filesystem stack. In other
words, the translation happens for the overlayfs filesystem but obviously the
overlayfs filesystem cannot be on an idmapped mount as we don't support that
and probably never will.

So the translation step involving the mnt_idmapping needs to happen in
vfs_{g,s}etxattr() so that the VFS can take the mnt_idmapping into account for
each filesystem it is called upon.

All of this should be addressed cleaning up the posix acl codepaths and we plan
to do so.

A final note on fs_idmappings. A little while ago we received a few questions
about the role of the fs_idmapping for posix acls as we were fixing the
overlayfs posix acl handling on top of idmapped layers where we explained that
the mnt_idmapping needs to be handled in vfs_{g,s}etxattr().

The question was why posix_acl_fix_xattr_{from,to}_user() couldn't just be
moved into vfs_{g,s}etxattr() and simply taking the fs_idmapping into account
in these helpers.

This questions shows how dangerous the type subversion is. The fact is that the
fs_idmapping is entirely irrelevant for posix_acl_fix_xattr_{from,to}_user() as
we've seen. The reason why it seems relevant is that we convert between a
k{g,u}id_t and {g,u}id_t but that conversion is entirely based on a hack to
pass k{g,u}id_t in a uapi struct posix_acl_xattr_entry as {g,u}id_t as
explained above.

For a stacking filesystem the fs_idmapping of the top layer needs to be
transparent with respect to the ownership of things such as inode->i_{g,u}id,
ACL_{GROUP,USER} and posix acls and filesystem capabilities.

The general idea is that right at the userspace <-> VFS boundary any {g,u}id_t
passed in from userspace is immediately turned into a k{g,u}id_t. The
k{g,u}id_t is kept and only translated into a {g,u}id_t at the VFS <-> backing
store boundary, i.e., when a write to a backing store occurs. The same applies
for the backing store <-> VFS boundary where the {g,u}id_t stored in the
backing store needs to be turned into a k{g,u}id_t and only ever converted back
into {g,u}id_t at the VFS <-> userspace boundary.

A great example to illustrate the point is a simple chown() operation. In
chown_common() the passed in {g,u}id_t is turned into k{g,u}id_t (vfs{g,u}id_t
on newer kernels) in the caller_idmapping. The notify_change() helper is then
called to determine whether the caller is allowed to perform the ownership
change. Part of that is validating that the requested k{g,u}id_t has a mapping
in the fs_idmapping. If it does we know we can translate the k{g,u}id_t back
into {g,u}id_t when writing to the backing store later on. But nowhere do we
subvert the type system by converting that k{g,u}id_t back into {g,u}id_t let
alone storing it anwywhere to be operated on later.

For overlayfs the chown() operation is similar just that permission checking is
performed twice as notify_change() is called once on the overlayfs layer and
once on the lower layer. But note that the requested k{g,u}id_t never takes the
fs_idmapping or caller_idmapping of the mounter of the overlayfs filesystem
into account.

Similarly, when we report ownership information of a file the lower layer will
fill in struct kstat with the ownership information based on the fs_idmapping
and mnt_idmapping of the relevant lower layer. But the fs_idmapping and
caller_idmapping of the overlayfs mounter are entirely irrelevant for this.

This is crucial to notice as taking the fs_idmapping or caller_idmapping for
overlayfs into account would mean that overlayfs changes the ownership of the
underlying filesystem objects when mounted inside of a user namespace. That
would be a pretty nasty security issue.

But this is what moving posix_acl_fix_xattr_{from,to}_user() into
vfs_{g,s}etxattr() would amount to. If these helpers were relocated and would
be changed to take the fs_idmapping into account then posix acl ownership would
be changed by the overlayfs layer causing wrong values for ACL_{GROUP,USER} to
be stored in the backing store of the underlying filesystem.

Fwiw, fscaps currently work that way by performing the full translation twice
for each layer taking the caller_idmapping and the fs_idmapping into account
twice.

This only works correctly because overlayfs currently guarantees that the
caller_idmapping used to map up the fscaps from the lower fs_idmapping and the
fs_idmapping of overlayfs itself are identical. So the two translations invert
each other. But that's only guaranteed because of the override_creds() call. If
that were turned off though (patchsets like this have been floated around) this
would all break. Independent of this it is opaque and hard to understand. Seth
is currently working on a patchset to fix this.

/* Testing */
All patches are based on v5.19-rc5 and have been sitting in linux-next. No
build failures or warnings were observed and fstests and selftests have seen no
regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 88084a3df1672e131ddc1b4e39eeacfd39864acf:

  Linux 5.19-rc5 (2022-07-03 15:39:28 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.overlay.acl.v5.20

for you to fetch changes up to ba40a57ff08bf606135866bfe5fddc572089ac16:

  Add Seth Forshee as co-maintainer for idmapped mounts (2022-07-27 10:13:44 +0200)

Please consider pulling these changes from the signed fs.idmapped.overlay.acl.v5.20 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.idmapped.overlay.acl.v5.20

----------------------------------------------------------------
Christian Brauner (21):
      mnt_idmapping: add vfs{g,u}id_t
      fs: add two type safe mapping helpers
      fs: use mount types in iattr
      fs: introduce tiny iattr ownership update helpers
      fs: port to iattr ownership update helpers
      quota: port quota helpers mount ids
      security: pass down mount idmapping to setattr hook
      attr: port attribute changes to new types
      attr: fix kernel doc
      fs: port HAS_UNMAPPED_ID() to vfs{g,u}id_t
      mnt_idmapping: use new helpers in mapped_fs{g,u}id()
      mnt_idmapping: align kernel doc and parameter order
      ovl: turn of SB_POSIXACL with idmapped layers temporarily
      Merge tag 'ovl-fixes-5.19-rc7' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs into fs.idmapped.overlay.acl
      mnt_idmapping: add vfs[g,u]id_into_k[g,u]id()
      acl: move idmapped mount fixup into vfs_{g,s}etxattr()
      acl: port to vfs{g,u}id_t
      acl: make posix_acl_clone() available to overlayfs
      ovl: handle idmappings in ovl_get_acl()
      Revert "ovl: turn of SB_POSIXACL with idmapped layers temporarily"
      Add Seth Forshee as co-maintainer for idmapped mounts

Seth Forshee (1):
      mnt_idmapping: return false when comparing two invalid ids

 MAINTAINERS                       |   1 +
 fs/attr.c                         |  74 +++++----
 fs/ext2/inode.c                   |   8 +-
 fs/ext4/inode.c                   |  14 +-
 fs/f2fs/file.c                    |  22 +--
 fs/f2fs/recovery.c                |  10 +-
 fs/fat/file.c                     |   9 +-
 fs/jfs/file.c                     |   4 +-
 fs/ksmbd/vfs.c                    |   2 +-
 fs/ksmbd/vfs.h                    |   2 +-
 fs/ocfs2/file.c                   |   2 +-
 fs/open.c                         |  60 ++++++--
 fs/overlayfs/copy_up.c            |   4 +-
 fs/overlayfs/inode.c              |  87 ++++++++++-
 fs/overlayfs/overlayfs.h          |  15 +-
 fs/posix_acl.c                    | 168 ++++++++++++++-------
 fs/quota/dquot.c                  |  17 ++-
 fs/reiserfs/inode.c               |   4 +-
 fs/xattr.c                        |  25 +++-
 fs/xfs/xfs_iops.c                 |  14 +-
 fs/zonefs/super.c                 |   2 +-
 include/linux/evm.h               |   6 +-
 include/linux/fs.h                | 140 ++++++++++++++++-
 include/linux/mnt_idmapping.h     | 305 ++++++++++++++++++++++++++++++++++----
 include/linux/posix_acl.h         |   1 +
 include/linux/posix_acl_xattr.h   |  34 +++--
 include/linux/quotaops.h          |  15 +-
 include/linux/security.h          |   8 +-
 include/linux/xattr.h             |   2 +-
 security/integrity/evm/evm_main.c |  12 +-
 security/security.c               |   5 +-
 31 files changed, 815 insertions(+), 257 deletions(-)
