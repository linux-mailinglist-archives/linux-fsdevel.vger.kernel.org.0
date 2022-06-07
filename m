Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C3053F38A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 03:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiFGBtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 21:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiFGBt0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:49:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE08466F94;
        Mon,  6 Jun 2022 18:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ADE9611E8;
        Tue,  7 Jun 2022 01:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB4FC3411C;
        Tue,  7 Jun 2022 01:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654566563;
        bh=UDONAaKGGd3UwTf4kkDP8Lt1KEBys8H8hC9AJd75qPw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fZvkIueHrFY2BdCaUVwzumV7/gqYIYErNR5LIbNP/nsGZh8iG0U3HX0rRSy+Tt1Yq
         1fcVkAlgDzO9EKkudT8aNZAVTm8wQx0f2IDV3PBeFXhbUdwpLVutJCF9RviXgg6Krr
         fDTTT3TKVZ8fwrDYO1jpXBc5WaJY9/H1nEuGAl/vVDhTCgR5rLz9+0474RNl6SI9pa
         Sw2xQg8sjEjNsOEYCfd6tER5ChKHbGMUYXhNxveAJ6wQ8pCaxXF25F0Pv15jQbUadr
         Mqw68It/dMTWX+ZShCtom5XiLblj6/TbF7NyzbypxQWbcKYQYzTxmmINJouIyUSsdg
         100HcxSHd3jFQ==
Subject: [PATCH 7/8] xfs: document specific technical aspects of userspace
 driver program
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Date:   Mon, 06 Jun 2022 18:49:23 -0700
Message-ID: <165456656324.167418.13728838498028089183.stgit@magnolia>
In-Reply-To: <165456652256.167418.912764930038710353.stgit@magnolia>
References: <165456652256.167418.912764930038710353.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add the sixth chapter of the online fsck design documentation, where
we discuss the details of the data structures and algorithms used by the
driver program xfs_scrub.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 .../filesystems/xfs-online-fsck-design.rst         |  289 ++++++++++++++++++++
 1 file changed, 289 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index d9662c9653c9..47bedce146b8 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -268,6 +268,9 @@ The seven phases are as follows:
 7. The final phase re-checks the summary counters and presents the caller with
    a summary of space usage and file counts.
 
+This allocation of responsibilities will be :ref:`revisited <scrubcheck>`
+later in this document.
+
 Steps for Each Scrub Item
 -------------------------
 
@@ -3383,3 +3386,289 @@ The proposed patches are in the
 `directory repair
 <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-dirs>`_
 series.
+
+Userspace Algorithms and Data Structures
+========================================
+
+In this chapter, we discuss the key algorithms and data structures employed by
+the driver program, ``xfs_scrub``, to check and repair metadata, verify file
+data, and look for other potential problems.
+
+.. _scrubcheck:
+
+Checking Metadata
+-----------------
+
+Recall the overview of the :ref:`work phases <scrubphases>` outlined earlier.
+This structure follows naturally from the data dependencies designed into the
+filesystem from its beginnings in 1993.
+In XFS, there are several groups of metadata dependencies:
+
+a. Filesystem summary counts depend on consistency within the inode indices,
+   the allocation group space btrees, and the realtime volume space information.
+
+b. Quota resource counts depend on consistency within the quota file data forks
+   and the file forks of every file on the system.
+
+c. The naming hierarchy depends on consistency within the directory and
+   extended attribute structures.
+   This includes file link counts.
+
+d. Directories, extended attributes, and file data depend on consistency within
+   the file forks that map directory and extended attribute data to physical
+   storage media.
+
+e. The file forks depends on consistency within inode records and the space
+   metadata indices of the allocation groups and the realtime volume.
+   This includes quota and realtime metadata files.
+
+f. The inode records depends on consistency within the inode metadata indices.
+
+g. The realtime space metadata depend on the data forks of the realtime
+   metadata inodes.
+
+h. The allocation group metadata indices (free space, inodes, reference count,
+   and reverse mapping btrees) depend on consistency within the AG headers and
+   between all the AG metadata btrees.
+
+i. ``xfs_scrub`` depends on the filesystem being mounted and kernel support
+   for online fsck functionality.
+
+Therefore, a metadata dependency graph is a convenient way to schedule checking
+operations in the ``xfs_scrub`` program, and that is exactly what we do:
+
+- Phase 1 checks that the provided path maps to an XFS filesystem and detect
+  the kernel's scrubbing abilities, which validates group (i).
+
+- Phase 2 scrubs groups (g) and (h) in parallel using a threaded workqueue.
+
+- Phase 3 checks groups (f), (e), and (d), in that order.
+  These groups are all file metadata, which means that we can scan the inodes
+  in parallel.
+
+- Phase 5 starts by checking groups (b) and (c) in parallel before moving on
+  to checking names.
+
+- Phase 6 depends on phase 2 to have validated all the metadata that it uses
+  to find file data blocks to verify.
+
+- Phase 7 checks group (a), having validated everything else.
+
+Notice that the data dependencies between groups are enforced by the structure
+of the program flow.
+
+Parallel Inode Scans
+--------------------
+
+An XFS filesystem can easily contain many millions of inodes.
+Given that XFS targets installations with large high-performance storage,
+we'd like to be able to scrub inodes in parallel to minimize runtime.
+This requires careful scheduling to keep the threads as evenly loaded as
+possible.
+
+Early iterations of the ``xfs_scrub`` inode scanner naïvely created a single
+workqueue and scheduled a single work item per AG.
+Each work item walked the inode btree (with ``XFS_IOC_INUMBERS``) to find inode
+chunks, called bulkstat (``XFS_IOC_BULKSTAT``) to gather enough information to
+construct file handles, and invoked a callback function with the bulkstat
+information and the handle.
+This leads to thread balancing problems in phase 3 if the filesystem contains
+one AG with a few large sparse files, and the rest of the AGs contain many
+smaller files, because we serialized the per-AG part of the inode scan.
+
+Thanks to Dave Chinner, bounded workqueues in userspace enable us to fix this
+problem with ease by adding a second workqueue.
+Just like before, the first workqueue is seeded with one work item per AG, and
+it uses INUMBERS to find inode btree chunks.
+The second workqueue, however, is created with an upper bound on the number of
+items that can be pending.
+Each inode btree chunk found by the first workqueue's workers are queued as a
+work item for the second workqueue, and it is this second workqueue that
+queries BULKSTAT and actually invokes the callback.
+This doesn't completely solve the balancing problem, but reduces it enough to
+move on to more pressing issues.
+
+The proposed patchsets are the scrub
+`performance tweaks
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-performance-tweaks>`_
+and the
+`inode scan rebalance
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-iscan-rebalance>`_
+series.
+
+.. _scrubrepair:
+
+Scheduling Repairs
+------------------
+
+During phase 2, corruptions and inconsistencies reported in any AGI header or
+inode btree are repaired immediately, because phase 3 relies on proper
+functioning of the inode indices to find inodes to scan.
+Failed repairs are rescheduled to phase 4.
+Problems and optimization opportunities reported in any other space metadata
+are deferred to phase 4.
+
+During phase 3, corruptions and inconsistencies reported in any part of a
+file's metadata can be repaired immediately if all space metadata were
+validated.
+Otherwise, unfixed repairs and optimization opportunities are scheduled for
+phase 4.
+
+In the original design of ``xfs_scrub``, we thought that repairs would be so
+infrequent that we could get away with using the ``struct xfs_scrub_metadata``
+that we use to communicate with the kernel as the primary object to control
+repairs.
+Unfortunately, with recent increases in the number of optimizations possible
+for a given primary filesystem object (allocation group, realtime volume, file,
+the entire filesystem), it became much more memory-efficient to track all
+eligible repairs for a given filesystem object with a single repair item.
+
+Phase 4 is responsible for scheduling a lot of repair work in as quick a
+manner as is practical.
+The :ref:`data dependencies <scrubcheck>` outlined earlier still apply, which
+means that we must try to complete the repair work scheduled by phase 2 before
+trying the work scheduled by phase 3.
+
+1. Start a round of repair with a workqueue and enough workers to keep the CPUs
+   as busy as the user desires.
+
+   a. For each repair item queued by phase 2,
+
+      i.   Ask the kernel to repair everything listed in the repair item for a
+           given filesystem object.
+
+      ii.  Make a note if the kernel made any progress in reducing the number of
+           repairs needed for this object.
+
+      iii. If the object no longer requires repairs, revalidate all metadata
+           associated with this object.
+           If the revalidation succeeds, drop the repair item.
+           If not, requeue the item for more repairs.
+
+   b. While we're making progress on repairs, jump back to 1a to retry all the
+      phase 2 items.
+
+   c. For each repair item queued by phase 3,
+
+      i.   Ask the kernel to repair everything listed in the repair item for a
+           given filesystem object.
+
+      ii.  Make a note if the kernel made any progress in reducing the number of
+           repairs needed for this object.
+
+      iii. If the object no longer requires repairs, revalidate all metadata
+           associated with this object.
+           If the revalidation succeeds, drop the repair item.
+           If not, requeue the item for more repairs.
+
+   d. While we're making progress on repairs, jump back to 1c to retry all the
+      phase 3 items.
+
+2. If step 1 made any repair progress of any kind, jump back to step 1 to start
+   another round of repair.
+
+3. If there are items left to repair, run them all serially one more time.
+   This time we complain if the repairs were not successful, since this is
+   the last chance to any work in phase 4.
+
+Corruptions and inconsistencies encountered during phases 5 and 7 are repaired
+immediately.
+
+The proposed patchsets are the
+`repair warning improvements
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-better-repair-warnings>`_,
+refactoring of the
+`repair data dependency
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-repair-data-deps>`_
+and
+`object tracking
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-object-tracking>`_,
+and the
+`repair scheduling
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-repair-scheduling>`_
+improvement series.
+
+Checking Names for Confusable Unicode Sequences
+-----------------------------------------------
+
+If ``xfs_scrub`` succeeds in validating the filesystem metadata by the end of
+phase 4, it moves on to checking for suspicious looking names in the
+filesystem.
+These names consist of the filesystem label, names in directory entries, and
+the names of extended attributes.
+Like most Unix filesystems, XFS imposes the sparest of constraints on the
+contents of a name -- slashes and null bytes are not allowed in directory
+entries; and null bytes are not allowed in extended attributes and the
+filesystem label.
+However, the reality of most modern-day Linux systems is that programs work
+with Unicode character code points to support international languages.
+These programs encode those code points in UTF-8 when talking to the kernel,
+which means that in the common case, names found in an XFS filesystem are
+actually UTF-8 encoded Unicode data.
+
+To maximize its expressiveness, the Unicode standard defines separate control
+points for various characters that are rendered similarly or identically in
+writing systems around the world.
+For example, the character "Cyrillic Small Letter A" U+0430 "а" often renders
+identically to "Latin Small Letter A" U+0061 "a".
+
+The standard also permits characters to be constructed in multiple ways --
+either by using a defined code point, or by combining one code point with
+various combining marks.
+For example, the character "Angstrom Sign U+212B "Å" can also be expressed
+as "Latin Capital Letter A" U+0041 "A" followed by "Combining Ring Above"
+U+030A "◌̊".
+
+Like the standards that preceded it, Unicode also defines various control
+characters to alter the presentation of text.
+For example, the character "Right-to-Left Override" U+202E can trick some
+programs into rendering "moo\\xe2\\x80\\xaegnp.txt" as "mootxt.png".
+A second category of rendering problems involves whitespace characters.
+If the character "Zero Width Space" U+200B is encountered in a file name,
+the name will be rendered with no whitespace between the previous and the next
+character.
+If there is a name in the same name domain with the previous and next
+characters in sequence but omitting the zero width space, the rendering will be
+identical and user may be confused by it.
+The kernel, in its indifference to byte encoding schemes, permits this.
+
+As you can see, the flexibility of Unicode comes at a cost -- malicious actors
+can create names that can be used to mislead users.
+UTF-8 codecs faithfully translate whatever Unicode sequences are provided,
+which means that these sequences are persisted to disk.
+
+Techniques for detecting confusable names are explained in great detail in
+sections 4 and 5 of the
+`Unicode Security Mechanisms <https://unicode.org/reports/tr39/>`_
+document.
+``xfs_scrub``, when it detects UTF-8 encoding in use on a system, uses the
+Unicode normalization form NFD in conjunction with the confusable name
+detection component of
+`libicu <https://github.com/unicode-org/icu>`_
+to identify names with a directory or within a file's extended attributes that
+could be confused for each other.
+Names are also checked for control characters, non-rendering characters, and
+mixing of bidirectional characters.
+All of these potential issues are reported to the system administrator during
+phase 5.
+
+Media Verification of File Data Extents
+---------------------------------------
+
+The system administrator can elect to initiate a media scan of all file data
+blocks.
+This scan after validation of all filesystem metadata (except for the summary
+counters) as phase 6.
+The scan starts by calling ``FS_IOC_GETFSMAP`` to scan the filesystem space map
+to find areas that are allocated to file data fork extents.
+Gaps betweeen data fork extents that are smaller than 64k are treated as if
+they were data fork extents to reduce the command setup overhead.
+When the space map scan accumulates a region larger than 32MB, a media
+verification request is sent to the disk, either as a SCSI_VERIFY command, or a
+directio read of the raw block device.
+
+If the verification read fails, we retry with single-block reads to narrow down
+the failure to the specific region of the media and recorded.
+When we have finished issuing verification requests, we again use the space map
+ioctl to map the recorded media errors back to the metadata structures or files
+that own the space, and report the data have been lost.

