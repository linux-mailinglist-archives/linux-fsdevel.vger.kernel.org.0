Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485766A784B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 01:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCBAOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 19:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCBAO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 19:14:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1EB2196D;
        Wed,  1 Mar 2023 16:14:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03AA9614EE;
        Thu,  2 Mar 2023 00:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FEAC433EF;
        Thu,  2 Mar 2023 00:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677716065;
        bh=dTyTeyM9tGLIRz+kMXGuLUW7/hvQ8f1GWZNUXRYKvCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQ2UHzTfg1WeboCxTaIapgMiOOxTBlXGJTdQ1LItkm9pFaeQ2bZPM7FsVDFZsqe1m
         kd0vqMil/UKtZWWsiIFClz7Rm14R2Dk1uGt7GysOu2Bo0GG7eFf1GWChp3kfLT9Cqf
         tLjthAugNlCIFgZlLN3S5OXGj6vw1wDXA1rex2K8O5UNwQhXvYe0EZvIDIc3Drfvm1
         1VflVi5gopa2YX8p6A2izQnvohRzl2srQIMR6yXcFopEL88xFqCpulVYtfrL/P2tOa
         31SUpUR8PJU3SV+mFXlNZiZBv+Fp2WzmhqLZEAUfHW4SYqUSpPHvoGBxhXftf6qPAd
         YfUM4ZwrAqwIw==
Date:   Wed, 1 Mar 2023 16:14:24 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     "david@fromorbit.com" <david@fromorbit.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        Catherine Hoang <catherine.hoang@oracle.com>,
        Chandan Babu <chandan.babu@oracle.com>
Subject: Re: [PATCH v24.3 12/14] xfs: document directory tree repairs
Message-ID: <Y//qYIyYcaApDUI2@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825331.682859.12874143420813343961.stgit@magnolia>
 <Y9xtgrkdwlpM2/JN@magnolia>
 <181f96f378c88281e9fa48e1803a03254051cb35.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <181f96f378c88281e9fa48e1803a03254051cb35.camel@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 25, 2023 at 07:33:23AM +0000, Allison Henderson wrote:
> On Thu, 2023-02-02 at 18:12 -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Directory tree repairs are the least complete part of online fsck,
> > due
> > to the lack of directory parent pointers.  However, even without that
> > feature, we can still make some corrections to the directory tree --
> > we
> > can salvage as many directory entries as we can from a damaged
> > directory, and we can reattach orphaned inodes to the lost+found,
> > just
> > as xfs_repair does now.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> > v24.2: updated with my latest thoughts about how to use parent
> > pointers
> > v24.3: updated to reflect the online fsck code I built for parent
> > pointers
> > ---
> >  .../filesystems/xfs-online-fsck-design.rst         |  410
> > ++++++++++++++++++++
> >  1 file changed, 410 insertions(+)
> > 
> > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst
> > b/Documentation/filesystems/xfs-online-fsck-design.rst
> > index af7755fe0107..51d040e4a2d0 100644
> > --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> > +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> > @@ -4359,3 +4359,413 @@ The proposed patchset is the
> >  `extended attribute repair
> >  <
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=repair-xattrs>`_
> >  series.
> > +
> > +Fixing Directories
> > +------------------
> > +
> > +Fixing directories is difficult with currently available filesystem
> > features,
> > +since directory entries are not redundant.
> > +The offline repair tool scans all inodes to find files with nonzero
> > link count,
> > +and then it scans all directories to establish parentage of those
> > linked files.
> > +Damaged files and directories are zapped, and files with no parent
> > are
> > +moved to the ``/lost+found`` directory.
> > +It does not try to salvage anything.
> > +
> > +The best that online repair can do at this time is to read directory
> > data
> > +blocks and salvage any dirents that look plausible, correct link
> > counts, and
> > +move orphans back into the directory tree.
> > +The salvage process is discussed in the case study at the end of
> > this section.
> > +The :ref:`file link count fsck <nlinks>` code takes care of fixing
> > link counts
> > +and moving orphans to the ``/lost+found`` directory.
> > +
> > +Case Study: Salvaging Directories
> > +`````````````````````````````````
> > +
> > +Unlike extended attributes, directory blocks are all the same size,
> > so
> > +salvaging directories is straightforward:
> > +
> > +1. Find the parent of the directory.
> > +   If the dotdot entry is not unreadable, try to confirm that the
> > alleged
> > +   parent has a child entry pointing back to the directory being
> > repaired.
> > +   Otherwise, walk the filesystem to find it.
> > +
> > +2. Walk the first partition of data fork of the directory to find
> > the directory
> > +   entry data blocks.
> > +   When one is found,
> > +
> > +   a. Walk the directory data block to find candidate entries.
> > +      When an entry is found:
> > +
> > +      i. Check the name for problems, and ignore the name if there
> > are.
> > +
> > +      ii. Retrieve the inumber and grab the inode.
> > +          If that succeeds, add the name, inode number, and file
> > type to the
> > +          staging xfarray and xblob.
> > +
> > +3. If the memory usage of the xfarray and xfblob exceed a certain
> > amount of
> > +   memory or there are no more directory data blocks to examine,
> > unlock the
> > +   directory and add the staged dirents into the temporary
> > directory.
> > +   Truncate the staging files.
> > +
> > +4. Use atomic extent swapping to exchange the new and old directory
> > structures.
> > +   The old directory blocks are now attached to the temporary file.
> > +
> > +5. Reap the temporary file.
> > +
> 
> 
> 
> > +**Future Work Question**: Should repair revalidate the dentry cache
> > when
> > +rebuilding a directory?
> > +
> > +*Answer*: Yes, though the current dentry cache code doesn't provide
> > a means
> > +to walk every dentry of a specific directory.
> > +If the cache contains an entry that the salvaging code does not
> > find, the
> > +repair cannot proceed.
> > +
> > +**Future Work Question**: Can the dentry cache know about a
> > directory entry
> > +that cannot be salvaged?
> > +
> > +*Answer*: In theory, the dentry cache should be a subset of the
> > directory
> > +entries on disk because there's no way to load a dentry without
> > having
> > +something to read in the directory.
> > +However, it is possible for a coherency problem to be introduced if
> > the ondisk
> > +structures becomes corrupt *after* the cache loads.
> > +In theory it is necessary to scan all dentry cache entries for a
> > directory to
> > +ensure that one of the following apply:
> 
> "Currently the dentry cache code doesn't provide a means to walk every
> dentry of a specific directory.  This makes validation of the rebuilt
> directory difficult, and it is possible that an ondisk structure to
> become corrupt *after* the cache loads.  Walking the dentry cache is
> currently being considered as a future improvement.  This will also
> enable the ability to report which entries were not salvageable since
> these will be the subset of entries that are absent after the walk. 
> This improvement will ensure that one of the following apply:"

The thing is -- I'm not considering restructuring the dentry cache.  The
cache key is a one-way hash function of the parent_ino and the dirent
name, and I can't even imagine how one would support using that for
arbitrary lookups or walks.

This is the giant hole in all of the online repair code -- the design of
the dentry cache is such that we can't invalidate the entire cache.  We
also cannot walk it to perform targeted invalidation of just the pieces
we want.  If after a repair the cache contains a dentry that isn't
backed by an actual ondisk directory entry ... kaboom.

The one thing I'll grant you is that I don't think it's likely that the
dentry cache will get populated with some information and later the
ondisk directory bitrots undetectably.

> ?
> 
> I just think it reads cleaner.  I realize this is an area that still
> sort of in flux, but definitely before we call the document done we
> should probably strip out the Q's and just document the A's.  If
> someone re-raises the Q's we can always refer to the archives and then
> have the discussion on the mailing list.  But I think the document
> should maintain the goal of making clear whatever the current plan is
> just to keep it reading cleanly. 

Yeah, I'll shorten this section so that it only mentions these things
once and clearly states that I have no solution.

> > +
> > +1. The cached dentry reflects an ondisk dirent in the new directory.
> > +
> > +2. The cached dentry no longer has a corresponding ondisk dirent in
> > the new
> > +   directory and the dentry can be purged from the cache.
> > +
> > +3. The cached dentry no longer has an ondisk dirent but the dentry
> > cannot be
> > +   purged.
> 
> > +   This is bad.
> These entries are irrecoverable, but can now be reported.
> 
> 
> 
> > +
> > +As mentioned above, the dentry cache does not have a means to walk
> > all the
> > +dentries with a particular directory as a parent.
> > +This makes detecting situations #2 and #3 impossible, and remains an
> > +interesting question for research.
> I think the above paraphrase makes this last bit redundant.

N

> > +
> > +The proposed patchset is the
> > +`directory repair
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=repair-dirs>`_
> > +series.
> > +
> > +Parent Pointers
> > +```````````````
> > +
> "Generally speaking, a parent pointer is any kind of metadata that
> enables an inode to locate its parent with out having to traverse the
> directory tree from the root."
> 
> > +The lack of secondary directory metadata hinders directory tree
> "Without them, the lack of secondary..." 

Ok.  I want to reword the first sentence slightly, yielding this:

"A parent pointer is a piece of file metadata that enables a user to
locate the file's parent directory without having to traverse the
directory tree from the root.  Without them, reconstruction of directory
trees is hindered in much the same way that the historic lack of reverse
space mapping information once hindered reconstruction of filesystem
space metadata.  The parent pointer feature, however, makes total
directory reconstruction
possible."

But that's a much better start to the paragraph, thank you.

> > reconstruction
> > +in much the same way that the historic lack of reverse space mapping
> > +information once hindered reconstruction of filesystem space
> > metadata.
> > +The parent pointer feature, however, makes total directory
> > reconstruction
> > +possible.
> > +
> 
> History side bar the below chunk...

Done.

> > +Directory parent pointers were first proposed as an XFS feature more
> > than a
> > +decade ago by SGI.
> > +Each link from a parent directory to a child file is mirrored with
> > an extended
> > +attribute in the child that could be used to identify the parent
> > directory.
> > +Unfortunately, this early implementation had major shortcomings and
> > was never
> > +merged into Linux XFS:
> > +
> > +1. The XFS codebase of the late 2000s did not have the
> > infrastructure to
> > +   enforce strong referential integrity in the directory tree.
> > +   It did not guarantee that a change in a forward link would always
> > be
> > +   followed up with the corresponding change to the reverse links.
> > +
> > +2. Referential integrity was not integrated into offline repair.
> > +   Checking and repairs were performed on mounted filesystems
> > without taking
> > +   any kernel or inode locks to coordinate access.
> > +   It is not clear how this actually worked properly.
> > +
> > +3. The extended attribute did not record the name of the directory
> > entry in the
> > +   parent, so the SGI parent pointer implementation cannot be used
> > to reconnect
> > +   the directory tree.
> > +
> > +4. Extended attribute forks only support 65,536 extents, which means
> > that
> > +   parent pointer attribute creation is likely to fail at some point
> > before the
> > +   maximum file link count is achieved.
> 
> 
> "The original parent pointer design was too unstable for something like
> a file system repair to depend on."

Er... I think this is addressed by #2 above?

> > +
> > +Allison Henderson, Chandan Babu, and Catherine Hoang are working on
> > a second
> > +implementation that solves all shortcomings of the first.
> > +During 2022, Allison introduced log intent items to track physical
> > +manipulations of the extended attribute structures.
> > +This solves the referential integrity problem by making it possible
> > to commit
> > +a dirent update and a parent pointer update in the same transaction.
> > +Chandan increased the maximum extent counts of both data and
> > attribute forks,
> 
> > +thereby addressing the fourth problem.
> which ensures the parent pointer creation will succeed even if the max
> extent count is reached.

The max extent count cannot be exceeded, but the nrext64 feature ensures
that the xattr structure can grow enough to handle maximal hardlinking.

"Chandan increased the maximum extent counts of both data and attribute
forks, thereby ensuring that the extended attribute structure can grow
to handle the maximum hardlink count of any file."

> > +
> > +To solve the third problem, parent pointers include the dirent name
> "Lastly, the new design includes the dirent name..."

<nod>

> > and
> > +location of the entry within the parent directory.
> > +In other words, child files use extended attributes to store
> > pointers to
> > +parents in the form ``(parent_inum, parent_gen, dirent_pos) →
> > (dirent_name)``.
> This parts still in flux, so probably this will have to get updated
> later...

Yep, I'll add a note about that.

> > +
> > +On a filesystem with parent pointers, the directory checking process
> > can be
> > +strengthened to ensure that the target of each dirent also contains
> > a parent
> > +pointer pointing back to the dirent.
> > +Likewise, each parent pointer can be checked by ensuring that the
> > target of
> > +each parent pointer is a directory and that it contains a dirent
> > matching
> > +the parent pointer.
> > +Both online and offline repair can use this strategy.

I moved this paragraph up to become the second paragraph, and now it
reads:

"XFS parent pointers include the dirent name and location of the entry
within the parent directory.  In other words, child files use extended
attributes to store pointers to parents in the form ``(parent_inum,
parent_gen, dirent_pos) → (dirent_name)``.  The directory checking
process can be strengthened to ensure that the target of each dirent
also contains a parent pointer pointing back to the dirent.  Likewise,
each parent pointer can be checked by ensuring that the target of each
parent pointer is a directory and that it contains a dirent matching the
parent pointer.  Both online and offline repair can use this strategy.

Note: The ondisk format of parent pointers is not yet finalized."

After which comes the historical sidebar.

> > +
> > +Case Study: Repairing Directories with Parent Pointers
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Directory rebuilding uses a :ref:`coordinated inode scan <iscan>`
> > and
> > +a :ref:`directory entry live update hook <liveupdate>` as follows:
> > +
> > +1. Set up a temporary directory for generating the new directory
> > structure,
> > +   an xfblob for storing entry names, and an xfarray for stashing
> > directory
> > +   updates.
> > +
> > +2. Set up an inode scanner and hook into the directory entry code to
> > receive
> > +   updates on directory operations.
> > +
> > +3. For each parent pointer found in each file scanned, decide if the
> > parent
> > +   pointer references the directory of interest.
> > +   If so:
> > +
> > +   a. Stash an addname entry for this dirent in the xfarray for
> > later.
> > +
> > +   b. When finished scanning that file, flush the stashed updates to
> > the
> > +      temporary directory.
> > +
> > +4. For each live directory update received via the hook, decide if
> > the child
> > +   has already been scanned.
> > +   If so:
> > +
> > +   a. Stash an addname or removename entry for this dirent update in
> > the
> > +      xfarray for later.
> > +      We cannot write directly to the temporary directory because
> > hook
> > +      functions are not allowed to modify filesystem metadata.
> > +      Instead, we stash updates in the xfarray and rely on the
> > scanner thread
> > +      to apply the stashed updates to the temporary directory.
> > +
> > +5. When the scan is complete, atomically swap the contents of the
> > temporary
> > +   directory and the directory being repaired.
> > +   The temporary directory now contains the damaged directory
> > structure.
> > +
> > +6. Reap the temporary directory.
> > +
> > +7. Update the dirent position field of parent pointers as necessary.
> > +   This may require the queuing of a substantial number of xattr log
> > intent
> > +   items.
> > +
> > +The proposed patchset is the
> > +`parent pointers directory repair
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=pptrs-online-dir-repair>`_
> > +series.
> > +
> > +**Unresolved Question**: How will repair ensure that the
> > ``dirent_pos`` fields
> > +match in the reconstructed directory?
> > +
> > +*Answer*: There are a few ways to solve this problem:
> > +
> > +1. The field could be designated advisory, since the other three
> > values are
> > +   sufficient to find the entry in the parent.
> > +   However, this makes indexed key lookup impossible while repairs
> > are ongoing.
> > +
> > +2. We could allow creating directory entries at specified offsets,
> > which solves
> > +   the referential integrity problem but runs the risk that dirent
> > creation
> > +   will fail due to conflicts with the free space in the directory.
> > +
> > +   These conflicts could be resolved by appending the directory
> > entry and
> > +   amending the xattr code to support updating an xattr key and
> > reindexing the
> > +   dabtree, though this would have to be performed with the parent
> > directory
> > +   still locked.
> > +
> > +3. Same as above, but remove the old parent pointer entry and add a
> > new one
> > +   atomically.
> > +
> > +4. Change the ondisk xattr format to ``(parent_inum, name) →
> > (parent_gen)``,
> > +   which would provide the attr name uniqueness that we require,
> > without
> > +   forcing repair code to update the dirent position.
> > +   Unfortunately, this requires changes to the xattr code to support
> > attr
> > +   names as long as 263 bytes.
> > +
> > +5. Change the ondisk xattr format to ``(parent_inum, hash(name)) →
> > +   (name, parent_gen)``.
> > +   If the hash is sufficiently resistant to collisions (e.g. sha256)
> > then
> > +   this should provide the attr name uniqueness that we require.
> > +   Names shorter than 247 bytes could be stored directly.
> I think the RFC deluge is the same question but more context, so
> probably this section will follow what we decide there.  I will save
> commentary to keep the discussion in the same thread...
> 
> I'll just link it here for anyone else following this for now...
> https://www.spinics.net/lists/linux-xfs/msg69397.html

Yes, the deluge has much more detailed information.  I'll add this link
(for now) to the doc.

> > +
> > +Case Study: Repairing Parent Pointers
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Online reconstruction of a file's parent pointer information works
> > similarly to
> > +directory reconstruction:
> > +
> > +1. Set up a temporary file for generating a new extended attribute
> > structure,
> > +   an xfblob for storing parent pointer names, and an xfarray for
> > stashing
> > +   parent pointer updates.
> we did talk about blobs in patch 6 though it took me a moment to
> remember... if there's a way to link or tag it, that would be helpful
> for with the quick refresh.  kinda like wikipedia hyperlinks, you
> really only need like the first line or two to get it snap back

There is; I'll put in a backreference.

> > +
> > +2. Set up an inode scanner and hook into the directory entry code to
> > receive
> > +   updates on directory operations.
> > +
> > +3. For each directory entry found in each directory scanned, decide
> > if the
> > +   dirent references the file of interest.
> > +   If so:
> > +
> > +   a. Stash an addpptr entry for this parent pointer in the xfblob
> > and xfarray
> > +      for later.
> > +
> > +   b. When finished scanning the directory, flush the stashed
> > updates to the
> > +      temporary directory.
> > +
> > +4. For each live directory update received via the hook, decide if
> > the parent
> > +   has already been scanned.
> > +   If so:
> > +
> > +   a. Stash an addpptr or removepptr entry for this dirent update in
> > the
> > +      xfarray for later.
> > +      We cannot write parent pointers directly to the temporary file
> > because
> > +      hook functions are not allowed to modify filesystem metadata.
> > +      Instead, we stash updates in the xfarray and rely on the
> > scanner thread
> > +      to apply the stashed parent pointer updates to the temporary
> > file.
> > +
> > +5. Copy all non-parent pointer extended attributes to the temporary
> > file.
> > +
> > +6. When the scan is complete, atomically swap the attribute fork of
> > the
> > +   temporary file and the file being repaired.
> > +   The temporary file now contains the damaged extended attribute
> > structure.
> > +
> > +7. Reap the temporary file.
> Seems like it should work

Let's hope so!

> > +
> > +The proposed patchset is the
> > +`parent pointers repair
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=pptrs-online-parent-repair>`_
> > +series.
> > +
> > +Digression: Offline Checking of Parent Pointers
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Examining parent pointers in offline repair works differently
> > because corrupt
> > +files are erased long before directory tree connectivity checks are
> > performed.
> > +Parent pointer checks are therefore a second pass to be added to the
> > existing
> > +connectivity checks:
> > +
> > +1. After the set of surviving files has been established (i.e. phase
> > 6),
> > +   walk the surviving directories of each AG in the filesystem.
> > +   This is already performed as part of the connectivity checks.
> > +
> > +2. For each directory entry found, record the name in an xfblob, and
> > store
> > +   ``(child_ag_inum, parent_inum, parent_gen, dirent_pos)`` tuples
> > in a
> > +   per-AG in-memory slab.
> > +
> > +3. For each AG in the filesystem,
> > +
> > +   a. Sort the per-AG tuples in order of child_ag_inum, parent_inum,
> > and
> > +      dirent_pos.
> > +
> > +   b. For each inode in the AG,
> > +
> > +      1. Scan the inode for parent pointers.
> > +         Record the names in a per-file xfblob, and store
> > ``(parent_inum,
> > +         parent_gen, dirent_pos)`` tuples in a per-file slab.
> > +
> > +      2. Sort the per-file tuples in order of parent_inum, and
> > dirent_pos.
> > +
> > +      3. Position one slab cursor at the start of the inode's
> > records in the
> > +         per-AG tuple slab.
> > +         This should be trivial since the per-AG tuples are in child
> > inumber
> > +         order.
> > +
> > +      4. Position a second slab cursor at the start of the per-file
> > tuple slab.
> > +
> > +      5. Iterate the two cursors in lockstep, comparing the
> > parent_ino and
> > +         dirent_pos fields of the records under each cursor.
> > +
> > +         a. Tuples in the per-AG list but not the per-file list are
> > missing and
> > +            need to be written to the inode.
> > +
> > +         b. Tuples in the per-file list but not the per-AG list are
> > dangling
> > +            and need to be removed from the inode.
> > +
> > +         c. For tuples in both lists, update the parent_gen and name
> > components
> > +            of the parent pointer if necessary.
> > +
> > +4. Move on to examining link counts, as we do today.
> > +
> > +The proposed patchset is the
> > +`offline parent pointers repair
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.g
> > it/log/?h=pptrs-repair>`_
> > +series.
> > +
> > +Rebuilding directories from parent pointers in offline repair is
> > very
> > +challenging because it currently uses a single-pass scan of the
> > filesystem
> > +during phase 3 to decide which files are corrupt enough to be
> > zapped.
> > +This scan would have to be converted into a multi-pass scan:
> > +
> > +1. The first pass of the scan zaps corrupt inodes, forks, and
> > attributes
> > +   much as it does now.
> > +   Corrupt directories are noted but not zapped.
> > +
> > +2. The next pass records parent pointers pointing to the directories
> > noted
> > +   as being corrupt in the first pass.
> > +   This second pass may have to happen after the phase 4 scan for
> > duplicate
> > +   blocks, if phase 4 is also capable of zapping directories.
> > +
> > +3. The third pass resets corrupt directories to an empty shortform
> > directory.
> > +   Free space metadata has not been ensured yet, so repair cannot
> > yet use the
> > +   directory building code in libxfs.
> > +
> > +4. At the start of phase 6, space metadata have been rebuilt.
> > +   Use the parent pointer information recorded during step 2 to
> > reconstruct
> > +   the dirents and add them to the now-empty directories.
> > +
> > +This code has not yet been constructed.
> > +
> > +.. _orphanage:
> > +
> > +The Orphanage
> > +-------------
> > +
> > +Filesystems present files as a directed, and hopefully acyclic,
> > graph.
> > +In other words, a tree.
> > +The root of the filesystem is a directory, and each entry in a
> > directory points
> > +downwards either to more subdirectories or to non-directory files.
> > +Unfortunately, a disruption in the directory graph pointers result
> > in a
> > +disconnected graph, which makes files impossible to access via
> > regular path
> > +resolution.
> > +The directory parent pointer online scrub code can detect a dotdot
> > entry
> > +pointing to a parent directory that doesn't have a link back to the
> > child
> > +directory, and the file link count checker can detect a file that
> > isn't pointed
> > +to by any directory in the filesystem.
> > +If the file in question has a positive link count, the file in
> > question is an
> > +orphan.
> 
> Hmm, I kinda felt like this should have flowed into something like:
> "now that we have parent pointers, we can reparent them instead of
> putting them in the orphanage..."

That's only true if we actually *find* the relevant forward or back
pointers.  If a file has positive link count but there aren't any links
to it from anywhere, we still have to dump it in the /lost+found.

Parent pointers make it a lot less likely that we'll have to put a file
in the /lost+found, but it's still possible.

I think I'll change this paragraph to start:

"Without parent pointers, the directory parent pointer online scrub code
can detect a dotdot entry pointing to a parent directory..."

and then add a new paragraph:

"With parent pointers, directories can be rebuilt by scanning parent
pointers and parent pointers can be rebuilt by scanning directories.
This should reduce the incidence of files ending up in ``/lost+found``."

> ?
> > +
> > +When orphans are found, they should be reconnected to the directory
> > tree.
> > +Offline fsck solves the problem by creating a directory
> > ``/lost+found`` to
> > +serve as an orphanage, and linking orphan files into the orphanage
> > by using the
> > +inumber as the name.
> > +Reparenting a file to the orphanage does not reset any of its
> > permissions or
> > +ACLs.
> > +
> > +This process is more involved in the kernel than it is in userspace.
> > +The directory and file link count repair setup functions must use
> > the regular
> > +VFS mechanisms to create the orphanage directory with all the
> > necessary
> > +security attributes and dentry cache entries, just like a regular
> > directory
> > +tree modification.
> > +
> > +Orphaned files are adopted by the orphanage as follows:
> > +
> > +1. Call ``xrep_orphanage_try_create`` at the start of the scrub
> > setup function
> > +   to try to ensure that the lost and found directory actually
> > exists.
> > +   This also attaches the orphanage directory to the scrub context.
> > +
> > +2. If the decision is made to reconnect a file, take the IOLOCK of
> > both the
> > +   orphanage and the file being reattached.
> > +   The ``xrep_orphanage_iolock_two`` function follows the inode
> > locking
> > +   strategy discussed earlier.
> > +
> > +3. Call ``xrep_orphanage_compute_blkres`` and
> > ``xrep_orphanage_compute_name``
> > +   to compute the new name in the orphanage and the block
> > reservation required.
> > +
> > +4. Use ``xrep_orphanage_adoption_prep`` to reserve resources to the
> > repair
> > +   transaction.
> > +
> > +5. Call ``xrep_orphanage_adopt`` to reparent the orphaned file into
> > the lost
> > +   and found, and update the kernel dentry cache.
> > +
> > +The proposed patches are in the
> > +`orphanage adoption
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=repair-orphanage>`_
> > +series.
> 
> Certainly we'll need to come back and update all the parts that would
> be affected by the RFC, but otherwise looks ok.  It seems trying to
> document code before it's written tends to cause things to go around
> for a while, since we really just cant know how stable a design is
> until it's been through at least a few prototypes.

Agreed!

--D

> Allison
