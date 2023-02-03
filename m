Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D7D688CF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 03:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjBCCMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 21:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjBCCMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 21:12:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D18677B1;
        Thu,  2 Feb 2023 18:12:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60D9661D54;
        Fri,  3 Feb 2023 02:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4BDC433D2;
        Fri,  3 Feb 2023 02:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675390338;
        bh=XmEgpfFIT0At+EHANYRKh4I+EtKAreLjoPANuddrUXs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=rIUeRNIR643DQbFXQUZCZpQud0Y5LO/2sKMckInPbTWV6MKyfzIB4oEQzJZdWaB5e
         /4ixKiRA1BoX7eWbGxD21HdO7LVwAzAGFZw51VLgTvJYwk8Ju0HDcETxKbPQyzgEg1
         wshy4EpZX/J2/Y7WBASXTWzZkNt2x5mnKGHpxc2GDLwT7fB+wYxc5O4CXQP9txeLqw
         UQU0YIMoTNhJKqYF7jdArnwUp2mqmhOpE+eYn8ZY7sLujkK7iqQIdvbXJJlLchJQ/0
         uvh+GOdL3oUsvGvUiUK8+tV7BsPNsPBig4I5fA5G9tmiNLxIjbrz+Drq6bz5/hSbbJ
         aAiasd8yHEkwQ==
Date:   Thu, 2 Feb 2023 18:12:18 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com, david@fromorbit.com
Subject: [PATCH v24.3 12/14] xfs: document directory tree repairs
Message-ID: <Y9xtgrkdwlpM2/JN@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825331.682859.12874143420813343961.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167243825331.682859.12874143420813343961.stgit@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Directory tree repairs are the least complete part of online fsck, due
to the lack of directory parent pointers.  However, even without that
feature, we can still make some corrections to the directory tree -- we
can salvage as many directory entries as we can from a damaged
directory, and we can reattach orphaned inodes to the lost+found, just
as xfs_repair does now.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
v24.2: updated with my latest thoughts about how to use parent pointers
v24.3: updated to reflect the online fsck code I built for parent pointers
---
 .../filesystems/xfs-online-fsck-design.rst         |  410 ++++++++++++++++++++
 1 file changed, 410 insertions(+)

diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index af7755fe0107..51d040e4a2d0 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -4359,3 +4359,413 @@ The proposed patchset is the
 `extended attribute repair
 <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-xattrs>`_
 series.
+
+Fixing Directories
+------------------
+
+Fixing directories is difficult with currently available filesystem features,
+since directory entries are not redundant.
+The offline repair tool scans all inodes to find files with nonzero link count,
+and then it scans all directories to establish parentage of those linked files.
+Damaged files and directories are zapped, and files with no parent are
+moved to the ``/lost+found`` directory.
+It does not try to salvage anything.
+
+The best that online repair can do at this time is to read directory data
+blocks and salvage any dirents that look plausible, correct link counts, and
+move orphans back into the directory tree.
+The salvage process is discussed in the case study at the end of this section.
+The :ref:`file link count fsck <nlinks>` code takes care of fixing link counts
+and moving orphans to the ``/lost+found`` directory.
+
+Case Study: Salvaging Directories
+`````````````````````````````````
+
+Unlike extended attributes, directory blocks are all the same size, so
+salvaging directories is straightforward:
+
+1. Find the parent of the directory.
+   If the dotdot entry is not unreadable, try to confirm that the alleged
+   parent has a child entry pointing back to the directory being repaired.
+   Otherwise, walk the filesystem to find it.
+
+2. Walk the first partition of data fork of the directory to find the directory
+   entry data blocks.
+   When one is found,
+
+   a. Walk the directory data block to find candidate entries.
+      When an entry is found:
+
+      i. Check the name for problems, and ignore the name if there are.
+
+      ii. Retrieve the inumber and grab the inode.
+          If that succeeds, add the name, inode number, and file type to the
+          staging xfarray and xblob.
+
+3. If the memory usage of the xfarray and xfblob exceed a certain amount of
+   memory or there are no more directory data blocks to examine, unlock the
+   directory and add the staged dirents into the temporary directory.
+   Truncate the staging files.
+
+4. Use atomic extent swapping to exchange the new and old directory structures.
+   The old directory blocks are now attached to the temporary file.
+
+5. Reap the temporary file.
+
+**Future Work Question**: Should repair revalidate the dentry cache when
+rebuilding a directory?
+
+*Answer*: Yes, though the current dentry cache code doesn't provide a means
+to walk every dentry of a specific directory.
+If the cache contains an entry that the salvaging code does not find, the
+repair cannot proceed.
+
+**Future Work Question**: Can the dentry cache know about a directory entry
+that cannot be salvaged?
+
+*Answer*: In theory, the dentry cache should be a subset of the directory
+entries on disk because there's no way to load a dentry without having
+something to read in the directory.
+However, it is possible for a coherency problem to be introduced if the ondisk
+structures becomes corrupt *after* the cache loads.
+In theory it is necessary to scan all dentry cache entries for a directory to
+ensure that one of the following apply:
+
+1. The cached dentry reflects an ondisk dirent in the new directory.
+
+2. The cached dentry no longer has a corresponding ondisk dirent in the new
+   directory and the dentry can be purged from the cache.
+
+3. The cached dentry no longer has an ondisk dirent but the dentry cannot be
+   purged.
+   This is bad.
+
+As mentioned above, the dentry cache does not have a means to walk all the
+dentries with a particular directory as a parent.
+This makes detecting situations #2 and #3 impossible, and remains an
+interesting question for research.
+
+The proposed patchset is the
+`directory repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-dirs>`_
+series.
+
+Parent Pointers
+```````````````
+
+The lack of secondary directory metadata hinders directory tree reconstruction
+in much the same way that the historic lack of reverse space mapping
+information once hindered reconstruction of filesystem space metadata.
+The parent pointer feature, however, makes total directory reconstruction
+possible.
+
+Directory parent pointers were first proposed as an XFS feature more than a
+decade ago by SGI.
+Each link from a parent directory to a child file is mirrored with an extended
+attribute in the child that could be used to identify the parent directory.
+Unfortunately, this early implementation had major shortcomings and was never
+merged into Linux XFS:
+
+1. The XFS codebase of the late 2000s did not have the infrastructure to
+   enforce strong referential integrity in the directory tree.
+   It did not guarantee that a change in a forward link would always be
+   followed up with the corresponding change to the reverse links.
+
+2. Referential integrity was not integrated into offline repair.
+   Checking and repairs were performed on mounted filesystems without taking
+   any kernel or inode locks to coordinate access.
+   It is not clear how this actually worked properly.
+
+3. The extended attribute did not record the name of the directory entry in the
+   parent, so the SGI parent pointer implementation cannot be used to reconnect
+   the directory tree.
+
+4. Extended attribute forks only support 65,536 extents, which means that
+   parent pointer attribute creation is likely to fail at some point before the
+   maximum file link count is achieved.
+
+Allison Henderson, Chandan Babu, and Catherine Hoang are working on a second
+implementation that solves all shortcomings of the first.
+During 2022, Allison introduced log intent items to track physical
+manipulations of the extended attribute structures.
+This solves the referential integrity problem by making it possible to commit
+a dirent update and a parent pointer update in the same transaction.
+Chandan increased the maximum extent counts of both data and attribute forks,
+thereby addressing the fourth problem.
+
+To solve the third problem, parent pointers include the dirent name and
+location of the entry within the parent directory.
+In other words, child files use extended attributes to store pointers to
+parents in the form ``(parent_inum, parent_gen, dirent_pos) → (dirent_name)``.
+
+On a filesystem with parent pointers, the directory checking process can be
+strengthened to ensure that the target of each dirent also contains a parent
+pointer pointing back to the dirent.
+Likewise, each parent pointer can be checked by ensuring that the target of
+each parent pointer is a directory and that it contains a dirent matching
+the parent pointer.
+Both online and offline repair can use this strategy.
+
+Case Study: Repairing Directories with Parent Pointers
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Directory rebuilding uses a :ref:`coordinated inode scan <iscan>` and
+a :ref:`directory entry live update hook <liveupdate>` as follows:
+
+1. Set up a temporary directory for generating the new directory structure,
+   an xfblob for storing entry names, and an xfarray for stashing directory
+   updates.
+
+2. Set up an inode scanner and hook into the directory entry code to receive
+   updates on directory operations.
+
+3. For each parent pointer found in each file scanned, decide if the parent
+   pointer references the directory of interest.
+   If so:
+
+   a. Stash an addname entry for this dirent in the xfarray for later.
+
+   b. When finished scanning that file, flush the stashed updates to the
+      temporary directory.
+
+4. For each live directory update received via the hook, decide if the child
+   has already been scanned.
+   If so:
+
+   a. Stash an addname or removename entry for this dirent update in the
+      xfarray for later.
+      We cannot write directly to the temporary directory because hook
+      functions are not allowed to modify filesystem metadata.
+      Instead, we stash updates in the xfarray and rely on the scanner thread
+      to apply the stashed updates to the temporary directory.
+
+5. When the scan is complete, atomically swap the contents of the temporary
+   directory and the directory being repaired.
+   The temporary directory now contains the damaged directory structure.
+
+6. Reap the temporary directory.
+
+7. Update the dirent position field of parent pointers as necessary.
+   This may require the queuing of a substantial number of xattr log intent
+   items.
+
+The proposed patchset is the
+`parent pointers directory repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=pptrs-online-dir-repair>`_
+series.
+
+**Unresolved Question**: How will repair ensure that the ``dirent_pos`` fields
+match in the reconstructed directory?
+
+*Answer*: There are a few ways to solve this problem:
+
+1. The field could be designated advisory, since the other three values are
+   sufficient to find the entry in the parent.
+   However, this makes indexed key lookup impossible while repairs are ongoing.
+
+2. We could allow creating directory entries at specified offsets, which solves
+   the referential integrity problem but runs the risk that dirent creation
+   will fail due to conflicts with the free space in the directory.
+
+   These conflicts could be resolved by appending the directory entry and
+   amending the xattr code to support updating an xattr key and reindexing the
+   dabtree, though this would have to be performed with the parent directory
+   still locked.
+
+3. Same as above, but remove the old parent pointer entry and add a new one
+   atomically.
+
+4. Change the ondisk xattr format to ``(parent_inum, name) → (parent_gen)``,
+   which would provide the attr name uniqueness that we require, without
+   forcing repair code to update the dirent position.
+   Unfortunately, this requires changes to the xattr code to support attr
+   names as long as 263 bytes.
+
+5. Change the ondisk xattr format to ``(parent_inum, hash(name)) →
+   (name, parent_gen)``.
+   If the hash is sufficiently resistant to collisions (e.g. sha256) then
+   this should provide the attr name uniqueness that we require.
+   Names shorter than 247 bytes could be stored directly.
+
+Case Study: Repairing Parent Pointers
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Online reconstruction of a file's parent pointer information works similarly to
+directory reconstruction:
+
+1. Set up a temporary file for generating a new extended attribute structure,
+   an xfblob for storing parent pointer names, and an xfarray for stashing
+   parent pointer updates.
+
+2. Set up an inode scanner and hook into the directory entry code to receive
+   updates on directory operations.
+
+3. For each directory entry found in each directory scanned, decide if the
+   dirent references the file of interest.
+   If so:
+
+   a. Stash an addpptr entry for this parent pointer in the xfblob and xfarray
+      for later.
+
+   b. When finished scanning the directory, flush the stashed updates to the
+      temporary directory.
+
+4. For each live directory update received via the hook, decide if the parent
+   has already been scanned.
+   If so:
+
+   a. Stash an addpptr or removepptr entry for this dirent update in the
+      xfarray for later.
+      We cannot write parent pointers directly to the temporary file because
+      hook functions are not allowed to modify filesystem metadata.
+      Instead, we stash updates in the xfarray and rely on the scanner thread
+      to apply the stashed parent pointer updates to the temporary file.
+
+5. Copy all non-parent pointer extended attributes to the temporary file.
+
+6. When the scan is complete, atomically swap the attribute fork of the
+   temporary file and the file being repaired.
+   The temporary file now contains the damaged extended attribute structure.
+
+7. Reap the temporary file.
+
+The proposed patchset is the
+`parent pointers repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=pptrs-online-parent-repair>`_
+series.
+
+Digression: Offline Checking of Parent Pointers
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Examining parent pointers in offline repair works differently because corrupt
+files are erased long before directory tree connectivity checks are performed.
+Parent pointer checks are therefore a second pass to be added to the existing
+connectivity checks:
+
+1. After the set of surviving files has been established (i.e. phase 6),
+   walk the surviving directories of each AG in the filesystem.
+   This is already performed as part of the connectivity checks.
+
+2. For each directory entry found, record the name in an xfblob, and store
+   ``(child_ag_inum, parent_inum, parent_gen, dirent_pos)`` tuples in a
+   per-AG in-memory slab.
+
+3. For each AG in the filesystem,
+
+   a. Sort the per-AG tuples in order of child_ag_inum, parent_inum, and
+      dirent_pos.
+
+   b. For each inode in the AG,
+
+      1. Scan the inode for parent pointers.
+         Record the names in a per-file xfblob, and store ``(parent_inum,
+         parent_gen, dirent_pos)`` tuples in a per-file slab.
+
+      2. Sort the per-file tuples in order of parent_inum, and dirent_pos.
+
+      3. Position one slab cursor at the start of the inode's records in the
+         per-AG tuple slab.
+         This should be trivial since the per-AG tuples are in child inumber
+         order.
+
+      4. Position a second slab cursor at the start of the per-file tuple slab.
+
+      5. Iterate the two cursors in lockstep, comparing the parent_ino and
+         dirent_pos fields of the records under each cursor.
+
+         a. Tuples in the per-AG list but not the per-file list are missing and
+            need to be written to the inode.
+
+         b. Tuples in the per-file list but not the per-AG list are dangling
+            and need to be removed from the inode.
+
+         c. For tuples in both lists, update the parent_gen and name components
+            of the parent pointer if necessary.
+
+4. Move on to examining link counts, as we do today.
+
+The proposed patchset is the
+`offline parent pointers repair
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=pptrs-repair>`_
+series.
+
+Rebuilding directories from parent pointers in offline repair is very
+challenging because it currently uses a single-pass scan of the filesystem
+during phase 3 to decide which files are corrupt enough to be zapped.
+This scan would have to be converted into a multi-pass scan:
+
+1. The first pass of the scan zaps corrupt inodes, forks, and attributes
+   much as it does now.
+   Corrupt directories are noted but not zapped.
+
+2. The next pass records parent pointers pointing to the directories noted
+   as being corrupt in the first pass.
+   This second pass may have to happen after the phase 4 scan for duplicate
+   blocks, if phase 4 is also capable of zapping directories.
+
+3. The third pass resets corrupt directories to an empty shortform directory.
+   Free space metadata has not been ensured yet, so repair cannot yet use the
+   directory building code in libxfs.
+
+4. At the start of phase 6, space metadata have been rebuilt.
+   Use the parent pointer information recorded during step 2 to reconstruct
+   the dirents and add them to the now-empty directories.
+
+This code has not yet been constructed.
+
+.. _orphanage:
+
+The Orphanage
+-------------
+
+Filesystems present files as a directed, and hopefully acyclic, graph.
+In other words, a tree.
+The root of the filesystem is a directory, and each entry in a directory points
+downwards either to more subdirectories or to non-directory files.
+Unfortunately, a disruption in the directory graph pointers result in a
+disconnected graph, which makes files impossible to access via regular path
+resolution.
+The directory parent pointer online scrub code can detect a dotdot entry
+pointing to a parent directory that doesn't have a link back to the child
+directory, and the file link count checker can detect a file that isn't pointed
+to by any directory in the filesystem.
+If the file in question has a positive link count, the file in question is an
+orphan.
+
+When orphans are found, they should be reconnected to the directory tree.
+Offline fsck solves the problem by creating a directory ``/lost+found`` to
+serve as an orphanage, and linking orphan files into the orphanage by using the
+inumber as the name.
+Reparenting a file to the orphanage does not reset any of its permissions or
+ACLs.
+
+This process is more involved in the kernel than it is in userspace.
+The directory and file link count repair setup functions must use the regular
+VFS mechanisms to create the orphanage directory with all the necessary
+security attributes and dentry cache entries, just like a regular directory
+tree modification.
+
+Orphaned files are adopted by the orphanage as follows:
+
+1. Call ``xrep_orphanage_try_create`` at the start of the scrub setup function
+   to try to ensure that the lost and found directory actually exists.
+   This also attaches the orphanage directory to the scrub context.
+
+2. If the decision is made to reconnect a file, take the IOLOCK of both the
+   orphanage and the file being reattached.
+   The ``xrep_orphanage_iolock_two`` function follows the inode locking
+   strategy discussed earlier.
+
+3. Call ``xrep_orphanage_compute_blkres`` and ``xrep_orphanage_compute_name``
+   to compute the new name in the orphanage and the block reservation required.
+
+4. Use ``xrep_orphanage_adoption_prep`` to reserve resources to the repair
+   transaction.
+
+5. Call ``xrep_orphanage_adopt`` to reparent the orphaned file into the lost
+   and found, and update the kernel dentry cache.
+
+The proposed patches are in the
+`orphanage adoption
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-orphanage>`_
+series.
