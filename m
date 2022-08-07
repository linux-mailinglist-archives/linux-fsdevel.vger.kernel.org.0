Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A8258BC71
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Aug 2022 20:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiHGSbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Aug 2022 14:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiHGSbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:31:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4939272B;
        Sun,  7 Aug 2022 11:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CD94B80B84;
        Sun,  7 Aug 2022 18:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81A7C433C1;
        Sun,  7 Aug 2022 18:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897079;
        bh=mk44QepRk7leX0w7W3CosV73bKF+jfZVXqlsizRAqOA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fmm/d7jFbAOGxAckc8e1jPxoRgitC3HhC0o0kCMV+lxNLydXFIy2tjCKzrgkUbt0r
         trWLQLPcZcgofv7lkC6APD9b+uCPTeZUSa6lRjagCZ+uXhrjiPOqUmzR09fv1iZqmX
         s8UiMu9qNEWZzX9qZ6tGYa4B99RRSZ+Vszdcfv8Cm+xN3ZIkeszE5jkOz98b+WRCiu
         63niqTK6jb5cwwwJyG9h4eYuhH27Bzp7XseJWx5t5wAV3WlVGwAQa6Lv8n347yHO2F
         cUxhAZpWszDeaZNg0gPUXB6gHEzIVZt2rNND/d3PuKWb7uxNUjC4Xegm73/gM4D/Ys
         bwInJdG5cUZyg==
Subject: [PATCH 13/14] xfs: document the userspace fsck driver program
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Date:   Sun, 07 Aug 2022 11:31:18 -0700
Message-ID: <165989707848.2495930.3643292675955502890.stgit@magnolia>
In-Reply-To: <165989700514.2495930.13997256907290563223.stgit@magnolia>
References: <165989700514.2495930.13997256907290563223.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 .../filesystems/xfs-online-fsck-design.rst         |  313 ++++++++++++++++++++
 1 file changed, 313 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index cd26ccd3a0e4..adffc8c31c9c 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -300,6 +300,9 @@ The seven phases are as follows:
 7. Re-check the summary counters and presents the caller with a summary of
    space usage and file counts.
 
+This allocation of responsibilities will be :ref:`revisited <scrubcheck>`
+later in this document.
+
 Steps for Each Scrub Item
 -------------------------
 
@@ -4509,3 +4512,313 @@ The proposed patches are in the
 `orphanage adoption
 <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-orphanage>`_
 series.
+
+6. Userspace Algorithms and Data Structures
+===========================================
+
+This section discusses the key algorithms and data structures of the userspace
+program, ``xfs_scrub``, that provide the ability to drive metadata checks and
+repairs in the kernel, verify file data, and look for other potential problems.
+
+.. _scrubcheck:
+
+Checking Metadata
+-----------------
+
+Recall the :ref:`phases of fsck work<scrubphases>` outlined earlier.
+That structure follows naturally from the data dependencies designed into the
+filesystem from its beginnings in 1993.
+In XFS, there are several groups of metadata dependencies:
+
+a. Filesystem summary counts depend on consistency within the inode indices,
+   the allocation group space btrees, and the realtime volume space
+   information.
+
+b. Quota resource counts depend on consistency within the quota file data
+   forks, inode indices, inode records, and the forks of every file on the
+   system.
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
+f. Inode records depends on consistency within the inode metadata indices.
+
+g. Realtime space metadata depend on the inode records and data forks of the
+   realtime metadata inodes.
+
+h. The allocation group metadata indices (free space, inodes, reference count,
+   and reverse mapping btrees) depend on consistency within the AG headers and
+   between all the AG metadata btrees.
+
+i. ``xfs_scrub`` depends on the filesystem being mounted and kernel support
+   for online fsck functionality.
+
+Therefore, a metadata dependency graph is a convenient way to schedule checking
+operations in the ``xfs_scrub`` program:
+
+- Phase 1 checks that the provided path maps to an XFS filesystem and detect
+  the kernel's scrubbing abilities, which validates group (i).
+
+- Phase 2 scrubs groups (g) and (h) in parallel using a threaded workqueue.
+
+- Phase 3 checks groups (f), (e), and (d), in that order.
+  These groups are all file metadata, which means that inodes are scanned in
+  parallel.
+
+- Phase 4 repairs everything in groups (i) through (d) so that phases 5 and 6
+  may run reliably.
+
+- Phase 5 starts by checking groups (b) and (c) in parallel before moving on
+  to checking names.
+
+- Phase 6 depends on groups (i) through (b) to find file data blocks to verify,
+  to read them, and to report which blocks of which files are affected.
+
+- Phase 7 checks group (a), having validated everything else.
+
+Notice that the data dependencies between groups are enforced by the structure
+of the program flow.
+
+Parallel Inode Scans
+--------------------
+
+An XFS filesystem can easily contain hundreds of millions of inodes.
+Given that XFS targets installations with large high-performance storage,
+it is desirable to scrub inodes in parallel to minimize runtime, particularly
+if the program has been invoked manually from a command line.
+This requires careful scheduling to keep the threads as evenly loaded as
+possible.
+
+Early iterations of the ``xfs_scrub`` inode scanner naïvely created a single
+workqueue and scheduled a single workqueue item per AG.
+Each workqueue item walked the inode btree (with ``XFS_IOC_INUMBERS``) to find
+inode chunks and then called bulkstat (``XFS_IOC_BULKSTAT``) to gather enough
+information to construct file handles.
+The file handle was then passed to a function to generate scrub items for each
+metadata object of each inode.
+This simple algorithm leads to thread balancing problems in phase 3 if the
+filesystem contains one AG with a few large sparse files and the rest of the
+AGs contain many smaller files.
+The inode scan dispatch function was not sufficiently granular; it should have
+been dispatching at the level of individual inodes, or, to constrain memory
+consumption, inode btree records.
+
+Thanks to Dave Chinner, bounded workqueues in userspace enable ``xfs_scrub`` to
+avoid this problem with ease by adding a second workqueue.
+Just like before, the first workqueue is seeded with one workqueue item per AG,
+and it uses INUMBERS to find inode btree chunks.
+The second workqueue, however, is configured with an upper bound on the number
+of items that can be waiting to be run.
+Each inode btree chunk found by the first workqueue's workers are queued to the
+second workqueue, and it is this second workqueue that queries BULKSTAT,
+creates a file handle, and passes it to a function to generate scrub items for
+each metadata object of each inode.
+If the second workqueue is too full, the workqueue add function blocks the
+first workqueue's workers until the backlog eases.
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
+Problems reported in any other space metadata are deferred to phase 4.
+Optimization opportunities are always deferred to phase 4, no matter their
+origin.
+
+During phase 3, corruptions and inconsistencies reported in any part of a
+file's metadata are repaired immediately if all space metadata were validated
+during phase 2.
+Repairs that fail or cannot be repaired immediately are scheduled for phase 4.
+
+In the original design of ``xfs_scrub``, it was thought that repairs would be
+so infrequent that the ``struct xfs_scrub_metadata`` objects used to
+communicate with the kernel could also be used as the primary object to
+schedule repairs.
+With recent increases in the number of optimizations possible for a given
+filesystem object, it became much more memory-efficient to track all eligible
+repairs for a given filesystem object with a single repair item.
+Each repair item represents a single lockable object -- AGs, metadata files,
+individual inodes, or a class of summary information.
+
+Phase 4 is responsible for scheduling a lot of repair work in as quick a
+manner as is practical.
+The :ref:`data dependencies <scrubcheck>` outlined earlier still apply, which
+means that ``xfs_scrub`` must try to complete the repair work scheduled by
+phase 2 before trying repair work scheduled by phase 3.
+The repair process is as follows:
+
+1. Start a round of repair with a workqueue and enough workers to keep the CPUs
+   as busy as the user desires.
+
+   a. For each repair item queued by phase 2,
+
+      i.   Ask the kernel to repair everything listed in the repair item for a
+           given filesystem object.
+
+      ii.  Make a note if the kernel made any progress in reducing the number
+           of repairs needed for this object.
+
+      iii. If the object no longer requires repairs, revalidate all metadata
+           associated with this object.
+           If the revalidation succeeds, drop the repair item.
+           If not, requeue the item for more repairs.
+
+   b. If any repairs were made, jump back to 1a to retry all the phase 2 items.
+
+   c. For each repair item queued by phase 3,
+
+      i.   Ask the kernel to repair everything listed in the repair item for a
+           given filesystem object.
+
+      ii.  Make a note if the kernel made any progress in reducing the number
+           of repairs needed for this object.
+
+      iii. If the object no longer requires repairs, revalidate all metadata
+           associated with this object.
+           If the revalidation succeeds, drop the repair item.
+           If not, requeue the item for more repairs.
+
+   d. If any repairs were made, jump back to 1c to retry all the phase 3 items.
+
+2. If step 1 made any repair progress of any kind, jump back to step 1 to start
+   another round of repair.
+
+3. If there are items left to repair, run them all serially one more time.
+   Complain if the repairs were not successful, since this is the last chance
+   to repair anything.
+
+Corruptions and inconsistencies encountered during phases 5 and 7 are repaired
+immediately.
+Corrupt file data blocks reported by phase 6 cannot be recovered by the
+filesystem.
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
+phase 4, it moves on to phase 5, which checks for suspicious looking names in
+the filesystem.
+These names consist of the filesystem label, names in directory entries, and
+the names of extended attributes.
+Like most Unix filesystems, XFS imposes the sparest of constraints on the
+contents of a name -- slashes and null bytes are not allowed in directory
+entries; and null bytes are not allowed in extended attributes and the
+filesystem label.
+Directory entries and attribute keys store the length of the name explicitly
+ondisk, which means that nulls are not name terminators.
+For this section, the term "naming domain" refers to any place where names are
+presented together -- all the names in a directory, or all the attributes of a
+file.
+
+Although the Unix naming constraints are very permissive, the reality of most
+modern-day Linux systems is that programs work with Unicode character code
+points to support international languages.
+These programs typically encode those code points in UTF-8 when interfacing
+with the C library because the kernel expects null-terminated names.
+In the common case, therefore, names found in an XFS filesystem are actually
+UTF-8 encoded Unicode data.
+
+To maximize its expressiveness, the Unicode standard defines separate control
+points for various characters that render similarly or identically in writing
+systems around the world.
+For example, the character "Cyrillic Small Letter A" U+0430 "а" often renders
+identically to "Latin Small Letter A" U+0061 "a".
+
+The standard also permits characters to be constructed in multiple ways --
+either by using a defined code point, or by combining one code point with
+various combining marks.
+For example, the character "Angstrom Sign U+212B "Å" can also be expressed
+as "Latin Capital Letter A" U+0041 "A" followed by "Combining Ring Above"
+U+030A "◌̊".
+Both sequences render identically.
+
+Like the standards that preceded it, Unicode also defines various control
+characters to alter the presentation of text.
+For example, the character "Right-to-Left Override" U+202E can trick some
+programs into rendering "moo\\xe2\\x80\\xaegnp.txt" as "mootxt.png".
+A second category of rendering problems involves whitespace characters.
+If the character "Zero Width Space" U+200B is encountered in a file name, the
+name will render identically to a name that does not have the zero width
+space.
+
+If two names within a naming domain have different byte sequences but render
+identically, a user may be confused by it.
+The kernel, in its indifference to upper level encoding schemes, permits this.
+Most filesystem drivers persist the byte sequence names that are given to them
+by the VFS.
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
+verification request is sent to the disk as a directio read of the raw block
+device.
+
+If the verification read fails, ``xfs_scrub`` retries with single-block reads
+to narrow down the failure to the specific region of the media and recorded.
+When it has finished issuing verification requests, it again uses the space
+mapping ioctl to map the recorded media errors back to metadata structures
+and report what has been lost.
+For media errors in blocks owned by files, the lack of parent pointers means
+that the entire filesystem must be walked to report the file paths and offsets
+corresponding to the media error.

