Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047A2659CE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 23:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiL3Wca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 17:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiL3Wc1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 17:32:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D626B1D0DF;
        Fri, 30 Dec 2022 14:32:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73F8860CF0;
        Fri, 30 Dec 2022 22:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64ADC433EF;
        Fri, 30 Dec 2022 22:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672439544;
        bh=kULxrq3DfHNpV9dPzZBhHAETwjWYJl5X2ON0iBBZ6ss=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=i8Ss0fvTRndljS72PoxrDiuINZkmgdpxt8i7q9le3N1YxU6XGyu5A4BgCgW+YCg2h
         QD+zvsckgfUr5PWaVKL2oBAZ83+DMeX9MOeWP2zCeSX/MYx4Wmo1kaVOe4aWZnsjip
         7bKlJt6kglmAOjkUeISl6Hp9u3dKMzGWwwGCaVKjUuU7N1+I/dEN7u4X8ZLIc6aU1k
         P+jKO3Y4BYN+DJI/fRSUuwClMIzW9JZEzYsGS8O22uVc/6QUKXu/WqHGZw6+1c594g
         jBa82xPp0j32P0yAzLRoeGwkJgbfAiCycduOtgTLMfdamHce85eRiiryF9wfHSJtna
         VHZ9GfxZghfAA==
Subject: [PATCH 12/14] xfs: document directory tree repairs
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com, david@fromorbit.com
Date:   Fri, 30 Dec 2022 14:10:53 -0800
Message-ID: <167243825331.682859.12874143420813343961.stgit@magnolia>
In-Reply-To: <167243825144.682859.12802259329489258661.stgit@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 .../filesystems/xfs-online-fsck-design.rst         |  236 ++++++++++++++++++++
 1 file changed, 236 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index e32506acb66f..2e20314f1831 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -4269,3 +4269,239 @@ The proposed patchset is the
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
+Specifically, the lack of redundant metadata makes it nearly impossible to
+construct a true replacement for a damaged directory; the best repair can do is
+to salvage the dirents and use the file link count repair function to move
+orphaned files to the lost and found.
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
+   always be followed up by a corresponding change to the reverse links.
+
+2. Referential integrity was not integrated into either offline repair tool.
+   Checking had to be done online without taking any kernel or inode locks to
+   coordinate access.
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
+In the second implementation (currently being developed by Allison Henderson
+and Chandan Babu), the extended attribute code will be enhanced to use log
+intent items to guarantee that an extended attribute update can always be
+completed by log recovery.
+The maximum extent counts of both the data and attribute forks have raised to
+allow for creation of as many parent pointers as possible.
+The parent pointer data will also include the entry name and location within
+the parent.
+In other words, child files will store parent pointer mappings of the form
+``(parent_ino, parent_gen, dirent_pos) → (dirent_name)`` in their extended
+attribute data.
+With that in place, XFS can guarantee strong referential integrity of directory
+tree operations -- forward links will always be complemented with reverse
+links.
+
+When the parent pointer feature lands, the directory checking process can be
+strengthened to ensure that the target of each dirent also contains a parent
+pointer pointing back to the dirent.
+The quality of directory repairs will improve because online fsck will be able
+to reconstruct a directory in its entirety instead of skipping unsalvageable
+areas.
+This process is imagined to involve a :ref:`coordinated inode scan <iscan>` and
+a :ref:`directory entry live update hook <liveupdate>`:
+Scan every file in the entire filesystem, and every time the scan encounters a
+file with a parent pointer to the directory that is being reconstructed, record
+this entry in the temporary directory.
+When the scan is complete, atomically swap the contents of the temporary
+directory and the directory being repaired.
+This code has not yet been constructed, so there is not yet a case study laying
+out exactly how this process works.
+
+Parent pointers themselves can be checked by scanning each pointer and
+verifying that the target of the pointer is a directory and that it contains a
+dirent that corresponds to the information recorded in the parent pointer.
+Reconstruction of the parent pointer information will work similarly to
+directory reconstruction -- scan the filesystem, record the dirents pointing to
+the file being repaired, and rebuild that part of the xattr namespace.
+
+**Question**: How will repair ensure that the ``dirent_pos`` fields match in
+the reconstructed directory?
+
+*Answer*: The field could be designated advisory, since the other three values
+are sufficient to find the entry in the parent.
+However, this makes indexed key lookup impossible while repairs are ongoing.
+A second option would be to allow creating directory entries at specified
+offsets, which solves the referential integrity problem but runs the risk that
+dirent creation will fail due to conflicts with the free space in the
+directory.
+These conflicts could be resolved by appending the directory entry and amending
+the xattr code to support updating an xattr key and reindexing the dabtree,
+though this would have to be performed with the parent directory still locked.
+A fourth option would be to remove the parent pointer entry and re-add it
+atomically.
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
+**Question**: Should repair invalidate dentries when rebuilding a directory?
+
+**Question**: Can the dentry cache know about a directory entry that cannot be
+salvaged?
+
+In theory, the dentry cache should be a subset of the directory entries on disk
+because there's no way to load a dentry without having something to read in the
+directory.
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
+Unfortunately, the dentry cache does not have a means to walk all the dentries
+with a particular directory as a parent.
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

