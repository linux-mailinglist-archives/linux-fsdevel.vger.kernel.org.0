Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A7B66A8B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 03:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjANCcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 21:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjANCcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 21:32:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BC78CBC8;
        Fri, 13 Jan 2023 18:32:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7065E62384;
        Sat, 14 Jan 2023 02:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DCBC433D2;
        Sat, 14 Jan 2023 02:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673663539;
        bh=BqkNhXn9PxuERE2HAQ6W8qM892tY77yAbcZgnWz/4fY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=G+KHWhNoOWuaJqGa7BK7UVz2F9FyvTt7k/gmk2SRymtpJ4ctvGfROg24E0mpH7b8y
         jBQN+8MHwLBXro5Ppazp8vjVbBv3rBgWH513XsSn7BLg8Geh1w0jcapqv4Rwa9yvuh
         sN3ph/DTbDEloJC9niPaQpw8vu4fhTzmmQy+8O+swYdeJVBnfB1s6mZkJR3RncMnjj
         qzuxO5pbZd60QuWd6PYVqGY+Qi+I2BwKC2iXe6HTz5SFNhJBv0G3yMpMwH/fwrQuiC
         xfyLjpgey3UFwYTQc1j3hEYr/dpU/rqBwgy7bMgeywrIZaIZBEFU9lEuaFAjnqMwNu
         ERtpuGMBzP4Dg==
Date:   Fri, 13 Jan 2023 18:32:19 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com, david@fromorbit.com
Subject: [PATCH v24.2 12/14] xfs: document directory tree repairs
Message-ID: <Y8IUM6HcxiYAxp1c@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825331.682859.12874143420813343961.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167243825331.682859.12874143420813343961.stgit@magnolia>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Directory tree repairs are the least complete part of online fsck, due
to the lack of directory parent pointers.  However, even without that
feature, we can still make some corrections to the directory tree -- we
can salvage as many directory entries as we can from a damaged
directory, and we can reattach orphaned inodes to the lost+found, just
as xfs_repair does now.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
v24.2: updated with my latest thoughts about how to use parent pointers
---
 .../filesystems/xfs-online-fsck-design.rst         |  322 ++++++++++++++++++++
 1 file changed, 322 insertions(+)

diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index 163be2847c24..15e3a4acd40a 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -4319,3 +4319,325 @@ The proposed patchset is the
 `extended attribute repair
 <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-xattrs>`_
 series.
+
+Fixing Directories
+------------------
+
+Fixing directories is difficult with currently available filesystem features.
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
+The second component to fixing the directory tree online is the :ref:`file link
+count fsck <nlinks>`, since it can scan the entire filesystem to make sure that
+files can neither be deleted while there are still parents nor forgotten after
+all parents sever their links to the child.
+The third part is discussed at the :ref:`end of this section<orphanage>`.
+However, there may be a solution to these deficiencies soon!
+
+Parent Pointers
+```````````````
+
+The lack of secondary directory metadata hinders directory tree reconstruction
+in much the same way that the historic lack of reverse space mapping
+information once hindered reconstruction of filesystem space metadata.
+Specifically, dirents are not redundant, which makes it impossible to construct
+a true replacement for a damaged directory.
+The best that online repair can do currently is to construct a new directory
+from any dirents that are salvageable and use the file link count repair
+function to move orphaned files to the lost and found.
+Offline repair doesn't salvage broken directories.
+The proposed parent pointer feature, however, will make total directory
+reconstruction possible.
+
+Directory parent pointers were first proposed as an XFS feature more than a
+decade ago by SGI.
+In that implementation, each link from a parent directory to a child file was
+augmented by an extended attribute in the child that could be used to identify
+the parent directory.
+Unfortunately, this early implementation had several major shortcomings:
+
+1. The XFS codebase of the late 2000s did not have the infrastructure to
+   enforce strong referential integrity in the directory tree, which is a fancy
+   way to say that it could not guarantee that a change in a forward link would
+   always be followed up with the corresponding change to the reverse links.
+
+2. Referential integrity was not integrated into offline repair.
+   Checking and repairs were performed on mounted filesystems without taking
+   any kernel or inode locks to coordinate access.
+   It is not clear if this actually worked properly.
+
+3. The extended attribute did not record the name of the directory entry in the
+   parent, so the first parent pointer implementation cannot be used to
+   reconnect the directory tree.
+
+4. Extended attribute forks only support 65,536 extents, which means that
+   parent pointer attribute creation is likely to fail at some point before the
+   maximum file link count is achieved.
+
+Allison Henderson, Chandan Babu, and Catherine Hoang are working on a second
+implementation that solves the shortcomings of the first.
+During 2022, Allison introduced log intent items to track physical
+manipulations of the extended attribute structures.
+This solves the referential integrity problem by making it possible to commit
+a dirent update and a parent pointer update in the same transaction.
+Chandan increased the maximum extent counts of both data and attribute forks,
+thereby addressing the fourth problem.
+
+Allison has proposed a second implementation of parent pointers.
+This time around, parent pointer data will also include the dirent name and
+location within the parent.
+In other words, child files use extended attributes to store pointers to
+parents in the form ``(parent_inum, parent_gen, dirent_pos) → (dirent_name)``.
+This solves the third problem.
+
+When the parent pointer feature lands, the directory checking process can be
+strengthened to ensure that the target of each dirent also contains a parent
+pointer pointing back to the dirent.
+Likewise, each parent pointer can be checked by ensuring that the target of
+each parent pointer is a directory and that it contains a dirent matching
+the parent pointer.
+Both online and offline repair can use this strategy.
+
+The quality of directory repairs will improve because online fsck will be able
+to reconstruct a directory in its entirety instead of skipping unsalvageable
+areas.
+This process is imagined to involve a :ref:`coordinated inode scan <iscan>` and
+a :ref:`directory entry live update hook <liveupdate>`, and goes as follows:
+
+1. Visit every file in the entire filesystem.
+
+2. Every time the scan encounters a file with a parent pointer to the directory
+   that is being reconstructed, record this entry in the temporary directory.
+
+3. When the scan is complete, atomically swap the contents of the temporary
+   directory and the directory being repaired.
+
+4. Update the dirent position field of parent pointers as necessary.
+   This may require the queuing of a substantial number of xattr log intent
+   items.
+
+**Question**: How will repair ensure that the ``dirent_pos`` fields match in
+the reconstructed directory?
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
+   which would provide the key uniqueness that we require, without forcing
+   repair code to update the dirent position.
+
+Online reconstruction of a file's parent pointer information is imagined to
+work similarly to directory reconstruction:
+
+1. Visit every directory in the entire filesystem.
+
+2. Every time the scan encounters a directory with a dirent pointing to the
+   file that is being reconstructed, record this entry in the temporary file's
+   extended attributes.
+
+3. When the scan is complete, copy the file's other extended attributes to the
+   temporary file.
+
+4. Atomically swap the contents of the temporary file's extended attributes and
+   the file being repaired.
+   If the other extended attributes are large compared to the parent pointers,
+   it may be faster to use xattr log items to copy the parent pointers from the
+   temporary file to the file being reconstructed.
+   We lose the atomicity guarantee if we do this.
+
+This code has not yet been constructed, so there is not yet a case study laying
+out exactly how this process works.
+
+Examining parent pointers in offline repair works differently because corrupt
+files are erased long before directory tree connectivity checks are performed.
+Parent pointer checks are therefore a second pass to be added to the existing
+connectivity checks:
+
+1. After the set of surviving files has been established (i.e. phase 6),
+   walk the surviving directories of each AG in the filesystem.
+
+2. For each dirent found, add ``(child_ag_inum, parent_inum, dirent_pos)``
+   tuples to an in-memory index.
+   This may require creation of another type of xfile btree.
+
+3. Walk each file a second time to compare compare the ondisk parent pointers
+   against the in-memory index.
+   Parent pointers missing in the ondisk structure should be added, and ondisk
+   pointers not found by the scan should be removed.
+
+4. Move on to examining link counts, as we do today.
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
+This code has also not yet been constructed.
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
+**Question**: Should repair revalidate the dentry cache when rebuilding a
+directory?
+
+*Answer*: Yes, though the current dentry cache code doesn't provide a means
+to walk every dentry of a specific directory.
+If the cache contains an entry that the salvaging code does not find, the
+repair cannot proceed.
+
+**Question**: Can the dentry cache know about a directory entry that cannot be
+salvaged?
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
