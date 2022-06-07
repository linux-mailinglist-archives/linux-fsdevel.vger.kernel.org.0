Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC71E53F38C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 03:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiFGBtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 21:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiFGBtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:49:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5964B6948A;
        Mon,  6 Jun 2022 18:49:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D770161203;
        Tue,  7 Jun 2022 01:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E670C385A9;
        Tue,  7 Jun 2022 01:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654566569;
        bh=qSvr7Gh3LPbX6JdisRAwN1KiQUP4h+g+NqN2y5XhZEg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GOWzi6oQ4/DuYtv4mxtmwy0U8advVwMdaNkJp4JtAn2O1XTGWylJIYyfgoGiFQXXr
         LKlP4lStEIglBYXQy0pn8KEQ75seZaeyssEzYBmAV9euO/9X2t9dXesVsStncg3d9t
         KLrjzTsAm+K8XbDsTYiLPBC3H4l/YtfLp/thV0GCWrFEs3areKbyX6zq6zbTcMsETG
         G3x4zRg3UxjF7/3K3Hpri11RmfeYoQm1RWYbgJ9UojTOaOOBWDFJFzZsbr4IC385G2
         Eu3n+tg+HgOeqqlpe3vN2suX1XnDk7cQEJP7OjHzDMoUzlDDaz//lH9XUEawopMU3U
         vUEb48uUzLoEg==
Subject: [PATCH 8/8] xfs: document future directions of online fsck
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Date:   Mon, 06 Jun 2022 18:49:28 -0700
Message-ID: <165456656884.167418.6681877656704618850.stgit@magnolia>
In-Reply-To: <165456652256.167418.912764930038710353.stgit@magnolia>
References: <165456652256.167418.912764930038710353.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Add the seventh and final chapter of the online fsck documentation,
where we talk about future functionality that can tie in with the
functionality provided by the online fsck patchset.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 .../filesystems/xfs-online-fsck-design.rst         |  190 ++++++++++++++++++++
 1 file changed, 190 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index 47bedce146b8..254c9bb2f2dc 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -3101,6 +3101,8 @@ The extra flexibility enables several new use cases:
   (``FIEXCHANGE_RANGE``) to exchange the file contents, thereby committing all
   of the updates to the original file, or none of them.
 
+.. _swapext_if_unchanged:
+
 - **Transactional file updates**: The same mechanism as above, but the caller
   only wants the commit to occur if the original file's contents have not
   changed.
@@ -3672,3 +3674,191 @@ the failure to the specific region of the media and recorded.
 When we have finished issuing verification requests, we again use the space map
 ioctl to map the recorded media errors back to the metadata structures or files
 that own the space, and report the data have been lost.
+
+Conclusion
+==========
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
+Future Work
+===========
+
+Quite a lot of future XFS work ties into the online fsck feature.
+Here is a quick discussion of a few pieces that are immediately adjacent.
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
+This incentivizes us to make as few system calls as possible to reduce the
+number of times we have to cross a security boundary.
+
+With vectorized scrub, we now push to the kernel the identity of a filesystem
+object, a list of scrub types to run against that object, and a simple
+representation of the data dependencies between the selected scrub types.
+The kernel executes as much of the userspace plan as it can until it hits a
+dependency that cannot be satisfied due to a corruption, and tells userspace
+how much was accomplished.
+It is hoped that ``io_uring`` will pick up enough of this functionality that we
+can use that instead of adding a separate vectored scrub system call to XFS.
+
+The relevant patchsets are the
+`kernel
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
+we can spend in the kernel holding resource locks is basically unbounded.
+Userspace is allowed to send a fatal signal to the process which will cause
+``xfs_scrub`` to exit when it reaches a good stopping point, but there's no way
+for userspace to provide a time budget to the kernel.
+Given that we have helpers to detect fatal signals, it shouldn't be too much
+work to allow userspace to specify a timeout for a scrub/repair operation
+and abort the operation if it exceeds budget.
+
+Parent Pointers
+---------------
+
+Directory parent pointers were first proposed as an XFS feature more than a
+decade ago by SGI.
+In that implementation, each link from a parent directory to a child file would
+be augmented by an extended attribute in the child that could be used to
+identify the directory.
+Unfortunately, this early implementation had two major shortcomings:
+First, the XFS codebase of the late 2000s did not have the infrastructure to
+enforce strong referential integrity in the directory tree, which is a fancy
+way to say that it could not guarantee that a change in a forward link would
+always be followed up by a corresponding change to the reverse links.
+Second, the extended attribute did not record the name of the directory entry
+in the parent, so the first parent pointer implementation cannot be used to
+reconnect the directory tree.
+
+In the second implementation (currently being developed by Allison Henderson),
+the extended attribute code will be enhanced to use log intent items to
+guarantee that an extended attribute update can always be completed by log
+recovery.
+The parent pointer data will also include the entry name and location in the
+parent.
+In other words, we will be storing parent pointer mappings of the form
+``(parent_ino, parent_gen, dirent_pos) => (dirent_name)`` in the extended
+attribute data.
+With that in place, XFS can guarantee strong referential integrity of directory
+tree operations -- forward links will always be complemented with reverse
+links.
+
+When parent pointers have landed, it will no longer be necessary to salvage
+damaged directories and hope for the best!
+Instead, we will set up a :ref:`coordinated inode scan <iscan>` and a
+:ref:`directory entry live update hook <liveupdate>`.
+We can then scan the filesystem to find the parent of a directory being
+repaired, and we can reconstruct the rest of the directory entries from the
+parent pointer information.
+The new entries will be written to the temporary directory like they are now,
+and the atomic extent swap will be used to replace the old directory with the
+new one.
+
+**Question**: How do we ensure that the ``dirent_pos`` fields match in the
+reconstructed directory?
+Is that field merely advisory, since the other three values are sufficient to
+find the entry in the parent?
+Or will we have to remove the parent pointer entry and re-add it?
+
+Defragmenting Free Space
+------------------------
+
+We define this operation as clearing a portion of the physical storage so that
+it becomes a contiguous chunk of free space.
+
+The first piece we need is the ability to read the reverse mapping index from
+userspace.
+This already exists in the form of the ``FS_IOC_GETFSMAP`` ioctl.
+The second piece we need is a new fallocate mode (``FALLOC_FL_MAP_FREE_SPACE``)
+that allocates the free space in a region and maps it to a file.
+Call this file the "space collector" file.
+The third piece is the ability to force an online repair.
+
+To clear all the metadata out of a portion of physical storage, we use the new
+fallocate call to map any free space in that region to the space collector.
+Next, we find all metadata blocks in that region by way of ``GETFSMAP``,
+and issue forced repair requests on the data structure.
+This will most probably result in the metadata being rebuilt somewhere else.
+That takes care of everything except inode chunks and file data.
+After each rebuild operation, we re-call the "map free space" function to
+collect the newly freed space.
+
+To clear all the file data out of a portion of the physical storage, we again
+use the FSMAP information to find relevant file data blocks.
+Once we've identified a good target, we use the ``FICLONERANGE`` call on that
+file to try to map the space to a dummy file.
+Cloning the extent means that the original owners cannot overwrite the
+contents; any changes will be staged somewhere else via copy-on-write.
+We can then make our own copy of the frozen extent in an area that we are not
+clearing, and use ``FIEDEUPRANGE`` (or the
+:ref:`atomic extent swap <swapext_if_unchanged>` feature) to change the target
+file's data extent mapping away from the area we're clearing.
+After we've frozen the file data extent and removed all other mappings, we
+reflink the space into the space collector file.
+
+There are further optimizations to be had in the above algorithm.
+If we need to clear a piece of physical storage that has a high sharing factor,
+we would strongly prefer to retain this sharing factor.
+In fact, we prefer to relocate highly shared chunks first.
+To make this work smoothly, we add a fourth piece: a new ioctl
+(``FS_IOC_GETREFCOUNTS``) to report the reference count records to userspace.
+With the refcount information exposed, we can quickly find the longest, most
+shared data extents in the filesystem, and target them first.
+
+**Question**: How do we move inode chunks?
+Dave Chinner has a prototype that creates a new file with the old contents and
+then locklessly runs around the filesystem updating directory entries.
+The operation cannot complete if the filesystem goes down.
+That problem isn't totally insurmountable: create an inode remapping table
+hidden behind a jump label, and a log item that tracks the kernel walking the
+filesystem to update directory entries.
+The trouble is, we can't do anything about open files, since we can't revoke
+them.
+Can we abuse jump labels even further to add a revoke-me-hard bailout to
+*every* code path coming in from userspace?
+
+The relevant patchsets are the
+`kernel
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
+Unfortunately, that requires an evacuation of the space at end of the
+filesystem, which sounds an awful lot like free space defragmentation!

