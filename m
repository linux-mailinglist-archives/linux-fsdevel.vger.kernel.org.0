Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2FE659CE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 23:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiL3WdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 17:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbiL3Wc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 17:32:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851E01C935;
        Fri, 30 Dec 2022 14:32:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 327B7B81C22;
        Fri, 30 Dec 2022 22:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB254C433D2;
        Fri, 30 Dec 2022 22:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672439576;
        bh=VVak2OIsi5OSnNrnVaDFvY23yD5fubhAOe2TmQ4Lv9g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=f6E3Wdew45Jkc92ZllgIdBzUGtY3zTrfvtGF1a4vkUhG4FmnAX3xO2Z813xMcDYni
         ZZv+wIUrsT839M9QK2SEv1UcW+5Nq9FaxGWiYSINvYlzTb39K2jBnXcsyCl2UyHL9M
         0/vhIBkMM2YnEQAfpbL3+rh8+5MDiKY40PUbc22pRmnqdboNO0bZmUfFHyZfh3RDuZ
         7xGuZbO7LJX+AyYHk3NaKUsFt/K16yJOH0xM0HRhcmisXak/WECuFwVsQak9mMKoG0
         GXEBmochuPjc0khyuwKAjg/qrLEsFPtC2hDU06f90Dsr7mattHLNpmxVLLpScSW1kH
         mXGP7IVlnYjFw==
Subject: [PATCH 14/14] xfs: document future directions of online fsck
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com, david@fromorbit.com
Date:   Fri, 30 Dec 2022 14:10:53 -0800
Message-ID: <167243825360.682859.5189751153452545448.stgit@magnolia>
In-Reply-To: <167243825144.682859.12802259329489258661.stgit@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add the seventh and final chapter of the online fsck documentation,
where we talk about future functionality that can tie in with the
functionality provided by the online fsck patchset.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 .../filesystems/xfs-online-fsck-design.rst         |  155 ++++++++++++++++++++
 1 file changed, 155 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index 05b9411fac7f..41291edb02b9 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -4067,6 +4067,8 @@ The extra flexibility enables several new use cases:
   (``FIEXCHANGE_RANGE``) to exchange the file contents, thereby committing all
   of the updates to the original file, or none of them.
 
+.. _swapext_if_unchanged:
+
 - **Transactional file updates**: The same mechanism as above, but the caller
   only wants the commit to occur if the original file's contents have not
   changed.
@@ -4818,3 +4820,156 @@ and report what has been lost.
 For media errors in blocks owned by files, the lack of parent pointers means
 that the entire filesystem must be walked to report the file paths and offsets
 corresponding to the media error.
+
+7. Conclusion and Future Work
+=============================
+
+It is hoped that the reader of this document has followed the designs laid out
+in this document and now has some familiarity with how XFS performs online
+rebuilding of its metadata indices, and how filesystem users can interact with
+that functionality.
+Although the scope of this work is daunting, it is hoped that this guide will
+make it easier for code readers to understand what has been built, for whom it
+has been built, and why.
+Please feel free to contact the XFS mailing list with questions.
+
+FIEXCHANGE_RANGE
+----------------
+
+As discussed earlier, a second frontend to the atomic extent swap mechanism is
+a new ioctl call that userspace programs can use to commit updates to files
+atomically.
+This frontend has been out for review for several years now, though the
+necessary refinements to online repair and lack of customer demand mean that
+the proposal has not been pushed very hard.
+
+Vectorized Scrub
+----------------
+
+As it turns out, the :ref:`refactoring <scrubrepair>` of repair items mentioned
+earlier was a catalyst for enabling a vectorized scrub system call.
+Since 2018, the cost of making a kernel call has increased considerably on some
+systems to mitigate the effects of speculative execution attacks.
+This incentivizes program authors to make as few system calls as possible to
+reduce the number of times an execution path crosses a security boundary.
+
+With vectorized scrub, userspace pushes to the kernel the identity of a
+filesystem object, a list of scrub types to run against that object, and a
+simple representation of the data dependencies between the selected scrub
+types.
+The kernel executes as much of the caller's plan as it can until it hits a
+dependency that cannot be satisfied due to a corruption, and tells userspace
+how much was accomplished.
+It is hoped that ``io_uring`` will pick up enough of this functionality that
+online fsck can use that instead of adding a separate vectored scrub system
+call to XFS.
+
+The relevant patchsets are the
+`kernel vectorized scrub
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=vectorized-scrub>`_
+and
+`userspace vectorized scrub
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=vectorized-scrub>`_
+series.
+
+Quality of Service Targets for Scrub
+------------------------------------
+
+One serious shortcoming of the online fsck code is that the amount of time that
+it can spend in the kernel holding resource locks is basically unbounded.
+Userspace is allowed to send a fatal signal to the process which will cause
+``xfs_scrub`` to exit when it reaches a good stopping point, but there's no way
+for userspace to provide a time budget to the kernel.
+Given that the scrub codebase has helpers to detect fatal signals, it shouldn't
+be too much work to allow userspace to specify a timeout for a scrub/repair
+operation and abort the operation if it exceeds budget.
+However, most repair functions have the property that once they begin to touch
+ondisk metadata, the operation cannot be cancelled cleanly, after which a QoS
+timeout is no longer useful.
+
+Defragmenting Free Space
+------------------------
+
+Over the years, many XFS users have requested the creation of a program to
+clear a portion of the physical storage underlying a filesystem so that it
+becomes a contiguous chunk of free space.
+Call this free space defragmenter ``clearspace`` for short.
+
+The first piece the ``clearspace`` program needs is the ability to read the
+reverse mapping index from userspace.
+This already exists in the form of the ``FS_IOC_GETFSMAP`` ioctl.
+The second piece it needs is a new fallocate mode
+(``FALLOC_FL_MAP_FREE_SPACE``) that allocates the free space in a region and
+maps it to a file.
+Call this file the "space collector" file.
+The third piece is the ability to force an online repair.
+
+To clear all the metadata out of a portion of physical storage, clearspace
+uses the new fallocate map-freespace call to map any free space in that region
+to the space collector file.
+Next, clearspace finds all metadata blocks in that region by way of
+``GETFSMAP`` and issues forced repair requests on the data structure.
+This often results in the metadata being rebuilt somewhere that is not being
+cleared.
+After each relocation, clearspace calls the "map free space" function again to
+collect any newly freed space in the region being cleared.
+
+To clear all the file data out of a portion of the physical storage, clearspace
+uses the FSMAP information to find relevant file data blocks.
+Having identified a good target, it uses the ``FICLONERANGE`` call on that part
+of the file to try to share the physical space with a dummy file.
+Cloning the extent means that the original owners cannot overwrite the
+contents; any changes will be written somewhere else via copy-on-write.
+Clearspace makes its own copy of the frozen extent in an area that is not being
+cleared, and uses ``FIEDEUPRANGE`` (or the :ref:`atomic extent swap
+<swapext_if_unchanged>` feature) to change the target file's data extent
+mapping away from the area being cleared.
+When all other mappings have been moved, clearspace reflinks the space into the
+space collector file so that it becomes unavailable.
+
+There are further optimizations that could apply to the above algorithm.
+To clear a piece of physical storage that has a high sharing factor, it is
+strongly desirable to retain this sharing factor.
+In fact, these extents should be moved first to maximize sharing factor after
+the operation completes.
+To make this work smoothly, clearspace needs a new ioctl
+(``FS_IOC_GETREFCOUNTS``) to report reference count information to userspace.
+With the refcount information exposed, clearspace can quickly find the longest,
+most shared data extents in the filesystem, and target them first.
+
+**Question**: How might the filesystem move inode chunks?
+
+*Answer*: Dave Chinner has a prototype that creates a new file with the old
+contents and then locklessly runs around the filesystem updating directory
+entries.
+The operation cannot complete if the filesystem goes down.
+That problem isn't totally insurmountable: create an inode remapping table
+hidden behind a jump label, and a log item that tracks the kernel walking the
+filesystem to update directory entries.
+The trouble is, the kernel can't do anything about open files, since it cannot
+revoke them.
+
+**Question**: Can static keys be used to add a revoke bailout return to
+*every* code path coming in from userspace?
+
+*Answer*: In principle, yes.
+This would eliminate the overhead of the check until a revocation happens.
+It's not clear what we do to a revoked file after all the callers are finished
+with it, however.
+
+The relevant patchsets are the
+`kernel freespace defrag
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=defrag-freespace>`_
+and
+`userspace freespace defrag
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=defrag-freespace>`_
+series.
+
+Shrinking Filesystems
+---------------------
+
+Removing the end of the filesystem ought to be a simple matter of evacuating
+the data and metadata at the end of the filesystem, and handing the freed space
+to the shrink code.
+That requires an evacuation of the space at end of the filesystem, which is a
+use of free space defragmentation!

