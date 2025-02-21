Return-Path: <linux-fsdevel+bounces-42225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCA4A3F56F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1F57AA19B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BD620E710;
	Fri, 21 Feb 2025 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBvMEepX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01B820E6F6
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143614; cv=none; b=WV7Oh6IeM/Ogt/BkWniwvYeW+AYvu7Cek5PGyDt9+H0n6VxGFPy1symHHpX9g02dadpodhMFmrKU0oWDn2xQX82j+ksbqacTpApSpzZLXVf4ZXXoyKUbz34C1ST+B+40G1EWpuaUQEPp8+t2kcRzqfgHoNfBSA3me44cfCh8NdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143614; c=relaxed/simple;
	bh=H9q7Q/1d2KNEPPg2Fx7cVMkdZ1/fvPnxmpJnRYqmAnk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n8MFMPmhSft+UY85qx6+ERaGCEzmwut2Ua3sj8i3gYS0+qVwRGU2rbqcHqmkg+kNXlrqUJAUO0sSkTPJbX7iIPvN5giWO3AF74UWzZBDMYGg80cB1De+g1ncTSCoNbof0WS4G1bOGK1NsOmxwccRNlv2oX7sOOZRKIqU4VDCqDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBvMEepX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A909DC4CED6;
	Fri, 21 Feb 2025 13:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143613;
	bh=H9q7Q/1d2KNEPPg2Fx7cVMkdZ1/fvPnxmpJnRYqmAnk=;
	h=From:Subject:Date:To:Cc:From;
	b=WBvMEepXnY9T/9FVoPSHHGRJSAs1jOhRHWcOrIgqOaPnIkZD1XmF73dXk6AqH18HF
	 QSlqpnswEZLwIioDQq8nYc4F9sXnkHMrWGPfE6Fs9W3mCCBrhE4bo+mL7xrop3rwjZ
	 +5UOrijunV1MkOa3k8ZEkw0YYY0JKvwOMsC85o5Al/W8CPtiXoLgByNEoCDirkEoZW
	 QYySSYAT+2P3epn5ChbqcCUOPxZXzL6JtZFQ9aNptZqmY7fWmUSVH5GXLhNxC9pgoM
	 MDejCStbsfaUvb4gAes/MUhSrBVizn4yPaB3X1XRgVVsBenVQoYFEcVgxfZTp4tV9y
	 B4JB0+CCVwuPQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 00/16] fs: expand abilities of anonymous mount
 namespaces
Date: Fri, 21 Feb 2025 14:12:59 +0100
Message-Id: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANx7uGcC/x2M0QqDIBhGXyX+6xlqK2q3gz3AbscQtU/zxkJXD
 KJ3n+3yHDhnp4wUkOlW7ZSwhRzmWEBcKrKTjh4sjIVJcnkVnPfMJL1GJDYviOqTAGYbqTv0aId
 moNItCS58/88XPR93ehdpdMbZRjudu81l1tWire0cXfBqhFm9KpaO4wcvW7F5lAAAAA==
X-Change-ID: 20241008-brauner-open_tree-c32a6e8e5939
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=16275; i=brauner@kernel.org;
 h=from:subject:message-id; bh=H9q7Q/1d2KNEPPg2Fx7cVMkdZ1/fvPnxmpJnRYqmAnk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP6l+1zee2LA3mDFG5FZpp80V90M7H60hnPyhEjdf
 0cz0h7VdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEx5CR4RnXisMRxg/muFWc
 Pip0I/eax4QFKvfn+q7JS1i2TrP98Q1GhuUcj/+c3thrtjTvt62RgMx1xl2Tzp8LLdDumrHPKU4
 qmhsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

This series expands the abilities of anonymous mount namespaces.

I've been sitting on this for quite a while to get a decent handle
on this. I think I've got the thing working but I need some input on
possible pitfalls and things that I've missed during the design. So
here's an RFC. Apart from the comments I'm adding here I hope the
selftests will clarify the semantics sufficiently. I've commented the
tests quite liberally.

Terminology
===========

detached mount:
  A detached mount is a mount belonging to an anonymous mount namespace.

anonymous mount namespace:
  An anonymous mount namespace is a mount namespace that does not appear
  in nsfs. This means neither can it be setns()ed into nor can it be
  persisted through bind-mounts.

attached mount:
  An attached mount is a mount belonging to a non-anonymous mount
  namespace.

non-anonymous mount namespace:
  A non-anonymous mount namespace is a mount namespace that does appear
  in nsfs. This means it can be setns()ed into and can be persisted
  through bind-mounts.

mount namespace sequence number:
  Each non-anonymous mount namespace has a unique 64bit sequence number
  that is assigned when the mount namespace is created. The sequence
  number uniquely identifies a non-anonymous mount namespace.

  One of the purposes of the sequence number is to prevent mount
  namespace loops. These can occur when an nsfs mount namespace file is
  bind mounted into a mount namespace that was created after it.

  Such loops are prevented by verifying that the sequence number of the
  target mount namespace is smaller than the sequence number of the nsfs
  mount namespace file. In other words, the target mount namespace must
  have been created before the nsfs file mount namespace.

  In contrast, anonymous mount namespaces don't have a sequence number
  assigned. Anonymous mount namespaces do not appear in any nsfs
  instances and can thus not be pinned by bind-mounting them anywhere.
  They can thus not be used to form cycles.

Creating detached mounts from detached mounts
=============================================

Currently, detached mounts can only be created from attached mounts.
This limitaton prevents various use-cases. For example, the ability to
mount a subdirectory without ever having to make the whole filesystem
visible first.

The current permission model for OPEN_TREE_CLONE flag of the open_tree()
system call is:

(1) Check that the caller is privileged over the owning user namespace
    of it's current mount namespace.

(2) Check that the caller is located in the mount namespace of the mount
    it wants to create a detached copy of.

While it is not strictly necessary to do it this way it is consistently
applied in the new mount api. This model will also be used when allowing
the creation of detached mount from another detached mount.

The (1) requirement can simply be met by performing the same check as
for the non-detached case, i.e., verify that the caller is privileged
over its current mount namespace.

To meet the (2) requirement it must be possible to infer the origin
mount namespace that the anonymous mount namespace of the detached mount
was created from.

The origin mount namespace of an anonymous mount is the mount namespace
that the mounts that were copied into the anonymous mount namespace
originate from.

In order to check the origin mount namespace of an anonymous mount
namespace two methods come to mind:

 (i) stash a reference to the original mount namespace in the anonymous
     mount namespace
(ii) record the sequence number of the original mount namespace in the
     anonymous mount namespace

The (i) option has more complicated consequences and implications than
(ii). For example, it would pin the origin mount namespace. Even with a
passive reference it would pointlessly pin memory as access to the
origin mount namespace isn't required.

With (ii) in place it is possible to perform an equivalent check (2') to
(2). The origin mount namespace of the anonymous mount namespace must be
the same as the caller's mount namespace. To establish this the sequence
number of the caller's mount namespace and the origin sequence number of
the anonymous mount namespace are compared.

The caller is always located in a non-anonymous mount namespace since
anonymous mount namespaces cannot be setns()ed into. The caller's mount
namespace will thus always have a valid sequence number.

The owning namespace of any mount namespace, anonymous or non-anonymous,
can never change. A mount attached to a non-anonymous mount namespace
can never change mount namespace.

If the sequence number of the non-anonymous mount namespace and the
origin sequence number of the anonymous mount namespace match, the
owning namespaces must match as well.

Hence, the capability check on the owning namespace of the caller's
mount namespace ensures that the caller has the ability to copy the
mount tree.

Mounting detached mounts onto detached mounts
=============================================

Currently, detached mounts can only be mounted onto attached mounts.
This limitation makes it impossible to assemble a new private rootfs and
move it into place. Instead, a detached tree must be created, attached,
then mounted open and then either moved or detached again. Lift this
restriction.

In order to allow mounting detached mounts onto other detached mounts
the same permission model used for creating detached mounts from
detached mounts can be used (cf. above).

Allowing to mount detached mounts onto detached mounts leaves three
cases to consider:

(1) The source mount is an attached mount and the target mount is a
    detached mount. This would be equivalent to moving a mount between
    different mount namespaces. A caller could move an attached mount to
    a detached mount. The detached mount can now be freely attached to
    any mount namespace. This changes the current delegatioh model
    significantly for no good reason. So this will fail.

(2) Anonymous mount namespaces are always attached fully, i.e., it is
    not possible to only attach a subtree of an anoymous mount
    namespace. This simplifies the implementation and reasoning.

    Consequently, if the anonymous mount namespace of the source
    detached mount and the target detached mount are the identical the
    mount request will fail.

(3) The source mount's anonymous mount namespace is different from the
    target mount's anonymous mount namespace.

    In this case the source anonymous mount namespace of the source
    mount tree must be freed after its mounts have been moved to the
    target anonymous mount namespace. The source anonymous mount
    namespace must be empty afterwards.

By allowing to mount detached mounts onto detached mounts a caller may
do the following:

fd_tree1 = open_tree(-EBADF, "/mnt", OPEN_TREE_CLONE)
fd_tree2 = open_tree(-EBADF, "/tmp", OPEN_TREE_CLONE)

fd_tree1 and fd_tree2 refer to two different detached mount trees that
belong to two different anonymous mount namespace.

It is important to note that fd_tree1 and fd_tree2 both refer to the
root of their respective anonymous mount namespaces.

By allowing to mount detached mounts onto detached mounts the caller
may now do:

move_mount(fd_tree1, "", fd_tree2, "",
           MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH)

This will cause the detached mount referred to by fd_tree1 to be
mounted on top of the detached mount referred to by fd_tree2.

Thus, the detached mount fd_tree1 is moved from its separate anonymous
mount namespace into fd_tree2's anonymous mount namespace.

It also means that while fd_tree2 continues to refer to the root of
its respective anonymous mount namespace fd_tree1 doesn't anymore.

This has the consequence that only fd_tree2 can be moved to another
anonymous or non-anonymous mount namespace. Moving fd_tree1 will now
fail as fd_tree1 doesn't refer to the root of an anoymous mount
namespace anymore.

Now fd_tree1 and fd_tree2 refer to separate detached mount trees
referring to the same anonymous mount namespace.

This is conceptually fine. The new mount api does allow for this to
happen already via:

mount -t tmpfs tmpfs /mnt
mkdir -p /mnt/A
mount -t tmpfs tmpfs /mnt/A

fd_tree3 = open_tree(-EBADF, "/mnt", OPEN_TREE_CLONE | AT_RECURSIVE)
fd_tree4 = open_tree(-EBADF, "/mnt/A", 0)

Both fd_tree3 and fd_tree4 refer to two different detached mount trees
but both detached mount trees refer to the same anonymous mount
namespace. An as with fd_tree1 and fd_tree2, only fd_tree3 may be
moved another mount namespace as fd_tree3 refers to the root of the
anonymous mount namespace just while fd_tree4 doesn't.

However, there's an important difference between the fd_tree3/fd_tree4
and the fd_tree1/fd_tree2 example.

Closing fd_tree4 and releasing the respective struct file will have no
further effect on fd_tree3's detached mount tree.

However, closing fd_tree3 will cause the mount tree and the respective
anonymous mount namespace to be destroyed causing the detached mount
tree of fd_tree4 to be invalid for further mounting.

By allowing to mount detached mounts on detached mounts as in the
fd_tree1/fd_tree2 example both struct files will affect each other.

Both fd_tree1 and fd_tree2 refer to struct files that have
FMODE_NEED_UNMOUNT set.

When either one of them is closed it ends up unmounting the mount
tree. The problem is that both will unconditionally free the mount
namespace and may end up causing UAFs for each other.

Another problem stems from the fact that fd_tree1 doesn't refer to the
root of the anonymous mount namespace. So ignoring the UAF issue, if
fd_tree2 were to be closed after fd_tree1, then fd_tree1 would free
only a part of the mount tree while leaking the rest of the mount
tree.

Multiple solutions for this problem come to mind:

(1) Reference Counting Anonymous Mount Namespaces

    A solution to this problem would be reference counting anonymous
    mount namespaces. The source detached mount tree acquires a
    reference when it is moved into the anonymous mount namespace of
    the target mount tree. When fd_tree1 is closed the mount tree
    isn't unmounted and the anonymous mount namespace shared between
    the detached mount tree at fd_tree1 and fd_tree2 isn't freed.

    However, this has another problem. When fd_tree2 is closed before
    fd_tree1 then closing fd_tree1 will cause the mount tree to be
    unmounted and the anonymous mount namespace to be destroyed.
    However, fd_tree1 only refers to a part of the mounts that the
    shared anonymous mount namespace has collected. So this would leak
    mounts.

(2) Removing FMODE_NEED_UNMOUNT from the struct file of the source
    detached mount tree

    In the current state of the mount api the creation of two file
    descriptors that refer to different detached mount trees but to
    the same anonymous mount namespace is already possible. See the
    fd_tree3/fd_tree4 examples above.

    In those cases only one of the two file descriptors will actually
    end up unmounting and destroying the detached mount tree.

    Whether or not a struct file needs to unmount and destroy an
    anonymous mount namespace is governed by the FMODE_NEED_UNMOUNT
    flag. In the fd_tree3/fd_tree4 example above only fd_tree3 will
    refer to a struct file that has FMODE_NEED_UNMOUNT set.

    A similar solution would work for mounting detached mounts onto
    detached mounts. When the source detached mount tree is moved to
    the target detached mount tree and thus from the source anonymous
    mount namespace to the target anonymous mount namespace the
    FMODE_NEED_UNMOUNT flag will be removed from the struct file of
    the source detached mount tree.

    In the above example the FMODE_NEED_UNMOUNT would be removed from
    the struct file that fd_tree1 refers to.

    This requires that the source file descriptor fd_tree1 needs to be
    kept open until move_mount() is finished so that FMODE_NEED_UNMOUNT
    can be removed:

        move_mount(fd_tree1, "", fd_tree2, "",
                   MOVE_MOUNT_F_EMPTY_PATH |
                   MOVE_MOUNT_T_EMPTY_PATH)

        /*
         * Remove FMODE_NEED_UNMOUNT so closing fd_tree1 will leave the
         * mount tree alone.
         */
        close(fd_tree1);

        /*
         * Remove the whole mount tree including all the mounts that
         * were moved from fd_tree1 into fd_tree2.
         */
        close(fd_tree2);

    Since the source detached mount tree fd_tree1 has now become an
    attached mount tree, i.e., fd_tree1_mnt->mnt_parent == fd_tree2_mnt
    is is ineligible for attaching again as move_mount() requires that a
    detached mount tree can only be attached if it is the root of an
    anonymous mount namespace.

    Removing FMODE_NEED_UNMOUNT doesn't require to hold @namespace_sem.
    Attaching @fd_tree1 to @fd_tree2 requires holding @namespace_sem and
    so does dissolve_on_fput() should @fd_tree2 have been closed
    concurrently.

    While removing FMODE_NEED_UNMOUNT can be done it would require some
    ugly hacking similar to what's done for splice to remove
    FMODE_NOWAIT. That's ugly.

(3) Use the fact that @fd_tree1 will have a parent mount once it has
    been attached to @fd_tree2.

    When dissolve_on_fput() is called the mount that has been passed in
    will refer to the root of the anonymous mount namespace. If it
    doesn't it would mean that mounts are leaked. So before allowing to
    mount detached mounts onto detached mounts this would be a bug.

    Now that detached mounts can be mounted onto detached mounts it just
    means that the mount has been attached to another anonymous mount
    namespace and thus dissolve_on_fput() must not unmount the mount
    tree or free the anonymous mount namespace as the file referring to
    the root of the namespace hasn't been closed yet.

    If it had been closed yet it would be obvious because the mount
    namespace would be NULL, i.e., the @fd_tree1 would have already been
    unmounted. If @fd_tree1 hasn't been unmounted yet and has a parent
    mount it is safe to skip any cleanup as closing @fd_tree2 will take
    care of all cleanup operations.

Imho, (3) is the cleanest solution and thus has been chosen.

Note that no mount propagation happens when mounting detached mount
trees onto other detached mount trees.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (16):
      fs: record sequence number of origin mount namespace
      fs: add mnt_ns_empty() helper
      fs: add assert for move_mount()
      fs: add fastpath for dissolve_on_fput()
      fs: add may_copy_tree()
      fs: create detached mounts from detached mounts
      selftests: create detached mounts from detached mounts
      fs: support getname_maybe_null() in move_mount()
      fs: mount detached mounts onto detached mounts
      selftests: first test for mounting detached mounts onto detached mounts
      selftests: second test for mounting detached mounts onto detached mounts
      selftests: third test for mounting detached mounts onto detached mounts
      selftests: fourth test for mounting detached mounts onto detached mounts
      selftests: fifth test for mounting detached mounts onto detached mounts
      selftests: sixth test for mounting detached mounts onto detached mounts
      selftests: seventh test for mounting detached mounts onto detached mounts

 fs/mount.h                                         |   6 +
 fs/namespace.c                                     | 346 +++++++++---
 include/linux/fs.h                                 |   1 +
 .../selftests/mount_setattr/mount_setattr_test.c   | 591 +++++++++++++++++++++
 4 files changed, 884 insertions(+), 60 deletions(-)
---
base-commit: 822c11592522dc00e1f447dbe95350071001d9f1
change-id: 20241008-brauner-open_tree-c32a6e8e5939


