Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9357688750
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 20:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjBBTEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 14:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjBBTEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:04:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B815A23DA9;
        Thu,  2 Feb 2023 11:04:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EE5461C43;
        Thu,  2 Feb 2023 19:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B4AC433EF;
        Thu,  2 Feb 2023 19:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675364644;
        bh=aqdTeLs1MwfyXVSNvRQmbGubHA7xJKHHRTjns2OWdio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0HJDbHjUEg15Ht78uMAb7oEDP+GZSteI1JoObpD+wuzb6RMkrj2CvOMolTkx7DVs
         bbWGQs4NTRcMPgA5W/PpO26IR/L/Mo9EHziIDiSm4W4mUn+NaTauRJfTugftbTxFed
         ygyI98untZ38F5lrE6LhMrpUjikLcJi5oWcXgzo3DpwnXLFm8B4EzibNIgBffXEpXC
         bcsHOkFYZ16msKie0QZ+w8pE+HLWWymGpO7FjmKmUYvk+jpEENtdGFC49NRQJwqgAS
         CpP9JReoykikGMcwEnsi2dvzA26jU3E6muj58//Xt5+urB1lrmuTsxM7DERNFlBaCF
         VLE7ki5TkhZHQ==
Date:   Thu, 2 Feb 2023 11:04:04 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Chandan Babu <chandan.babu@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 05/14] xfs: document the filesystem metadata checking
 strategy
Message-ID: <Y9wJJHVFxuUtFRWN@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825231.682859.8572572208487315258.stgit@magnolia>
 <6cce6a77fbd1b2bc24a28fb08014bacce883d60f.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cce6a77fbd1b2bc24a28fb08014bacce883d60f.camel@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 21, 2023 at 01:38:33AM +0000, Allison Henderson wrote:
> On Fri, 2022-12-30 at 14:10 -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Begin the fifth chapter of the online fsck design documentation,
> > where
> > we discuss the details of the data structures and algorithms used by
> > the
> > kernel to examine filesystem metadata and cross-reference it around
> > the
> > filesystem.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  .../filesystems/xfs-online-fsck-design.rst         |  579
> > ++++++++++++++++++++
> >  .../filesystems/xfs-self-describing-metadata.rst   |    1 
> >  2 files changed, 580 insertions(+)
> > 
> > 
> > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst
> > b/Documentation/filesystems/xfs-online-fsck-design.rst
> > index 42e82971e036..f45bf97fa9c4 100644
> > --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> > +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> > @@ -864,3 +864,582 @@ Proposed patchsets include
> >  and
> >  `preservation of sickness info during memory reclaim
> >  <
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=indirect-health-reporting>`_.
> > +
> > +5. Kernel Algorithms and Data Structures
> > +========================================
> > +
> > +This section discusses the key algorithms and data structures of the
> > kernel
> > +code that provide the ability to check and repair metadata while the
> > system
> > +is running.
> > +The first chapters in this section reveal the pieces that provide
> > the
> > +foundation for checking metadata.
> > +The remainder of this section presents the mechanisms through which
> > XFS
> > +regenerates itself.
> > +
> > +Self Describing Metadata
> > +------------------------
> > +
> > +Starting with XFS version 5 in 2012, XFS updated the format of
> > nearly every
> > +ondisk block header to record a magic number, a checksum, a
> > universally
> > +"unique" identifier (UUID), an owner code, the ondisk address of the
> > block,
> > +and a log sequence number.
> > +When loading a block buffer from disk, the magic number, UUID,
> > owner, and
> > +ondisk address confirm that the retrieved block matches the specific
> > owner of
> > +the current filesystem, and that the information contained in the
> > block is
> > +supposed to be found at the ondisk address.
> > +The first three components enable checking tools to disregard
> > alleged metadata
> > +that doesn't belong to the filesystem, and the fourth component
> > enables the
> > +filesystem to detect lost writes.
> Add...
> 
> "When ever a file system operation modifies a block, the change is
> submitted to the journal as a transaction.  The journal then processes
> these transactions marking them done once they are safely committed to
> the disk"

Ok, I'll add that transition.  Though I'll s/journal/log/ since this is
xfs. :)

> At this point we havnt talked much at all about transactions or logs,
> and we've just barely begin to cover blocks.  I think you at least want
> a quick blip to describe the relation of these two things, or it may
> not be clear why we suddenly jumped into logs.

Point taken.  Thanks for the suggestion.

> > +
> > +The logging code maintains the checksum and the log sequence number
> > of the last
> > +transactional update.
> > +Checksums are useful for detecting torn writes and other mischief
> "Checksums (or crc's) are useful for detecting incomplete or torn
> writes as well as other discrepancies..."

Checksums are a general concept, whereas CRCs denote a particular family
of checksums.  The statement would still apply even if we used a
different family (e.g. erasure codes, cryptographic hash functions) of
function instead of crc32c.

I will, however, avoid the undefined term 'mischief'.  Thanks for the
correction.

"Checksums are useful for detecting torn writes and other discrepancies
that can be introduced between the computer and its storage devices."

> > between the
> > +computer and its storage devices.
> > +Sequence number tracking enables log recovery to avoid applying out
> > of date
> > +log updates to the filesystem.
> > +
> > +These two features improve overall runtime resiliency by providing a
> > means for
> > +the filesystem to detect obvious corruption when reading metadata
> > blocks from
> > +disk, but these buffer verifiers cannot provide any consistency
> > checking
> > +between metadata structures.
> > +
> > +For more information, please see the documentation for
> > +Documentation/filesystems/xfs-self-describing-metadata.rst
> > +
> > +Reverse Mapping
> > +---------------
> > +
> > +The original design of XFS (circa 1993) is an improvement upon 1980s
> > Unix
> > +filesystem design.
> > +In those days, storage density was expensive, CPU time was scarce,
> > and
> > +excessive seek time could kill performance.
> > +For performance reasons, filesystem authors were reluctant to add
> > redundancy to
> > +the filesystem, even at the cost of data integrity.
> > +Filesystems designers in the early 21st century choose different
> > strategies to
> > +increase internal redundancy -- either storing nearly identical
> > copies of
> > +metadata, or more space-efficient techniques such as erasure coding.
> "such as erasure coding which may encode sections of the data with
> redundant symbols and in more than one location"
> 
> That ties it into the next line.  If you go on to talk about a term you
> have not previously defined, i think you want to either define it
> quickly or just drop it all together.  Right now your goal is to just
> give the reader context, so you want it to move quickly.

How about I shorten it to:

"...or more space-efficient encoding techniques." ?

and end the paragraph there?

> > +Obvious corruptions are typically repaired by copying replicas or
> > +reconstructing from codes.
> > +
> I think I would have just jumped straight from xfs history to modern
> xfs...
> > +For XFS, a different redundancy strategy was chosen to modernize the
> > design:
> > +a secondary space usage index that maps allocated disk extents back
> > to their
> > +owners.
> > +By adding a new index, the filesystem retains most of its ability to
> > scale
> > +well to heavily threaded workloads involving large datasets, since
> > the primary
> > +file metadata (the directory tree, the file block map, and the
> > allocation
> > +groups) remain unchanged.
> > 
> 
> > +Although the reverse-mapping feature increases overhead costs for
> > space
> > +mapping activities just like any other system that improves
> > redundancy, it
> "Like any system that improves redundancy, the reverse-mapping feature
> increases overhead costs for space mapping activities. However, it..."

I like this better.  These two sentences have been changed to read:

"Like any system that improves redundancy, the reverse-mapping feature
increases overhead costs for space mapping activities.  However, it has
two critical advantages: first, the reverse index is key to enabling
online fsck and other requested functionality such as free space
defragmentation, better media failure reporting, and filesystem
shrinking."

> > +has two critical advantages: first, the reverse index is key to
> > enabling online
> > +fsck and other requested functionality such as filesystem
> > reorganization,
> > +better media failure reporting, and shrinking.
> > +Second, the different ondisk storage format of the reverse mapping
> > btree
> > +defeats device-level deduplication, because the filesystem requires
> > real
> > +redundancy.
> > +
> > +A criticism of adding the secondary index is that it does nothing to
> > improve
> > +the robustness of user data storage itself.
> > +This is a valid point, but adding a new index for file data block
> > checksums
> > +increases write amplification and turns data overwrites into copy-
> > writes, which
> > +age the filesystem prematurely.
> > +In keeping with thirty years of precedent, users who want file data
> > integrity
> > +can supply as powerful a solution as they require.
> > +As for metadata, the complexity of adding a new secondary index of
> > space usage
> > +is much less than adding volume management and storage device
> > mirroring to XFS
> > +itself.
> > +Perfection of RAID and volume management are best left to existing
> > layers in
> > +the kernel.
> I think I would cull the entire above paragraph.  rmap, crc and raid
> all have very different points of redundancy, so criticism that an
> apple is not an orange or visavis just feels like a shortsighted
> comparison that's probably more of a distraction than anything.
> 
> Sometimes it feels like this document kinda gets off into tangents
> like it's preemptively trying to position it's self for an argument
> that hasn't happened yet.

It does!  Each of the many tangents that you've pointed out are a
reaction to some discussion that we've had on the list, or at an
LSF, or <cough> fs nerds sniping on social media.  The reason I
capture all of these offtopic arguments is to discourage people from
wasting time rehashing discussions that were settled long ago.

Admittedly, that is a very defensive reaction on my part...

> But I think it has the effect of pulling the
> readers attention off topic into an argument they never thought to
> consider in the first place.  The topic of this section is to explain
> what rmap is.  So lets stay on topic and finish laying out that ground
> work first before getting into how it compares to other solutions

...and you're right to point out that mentioning these things is
distracting and provides fuel to reignite a flamewar.  At the same time,
I think there's value in identifying the roads not taken, and why.

What if I turned these tangents into explicitly labelled sidebars?
Would that help readers who want to stick to the topic?

> > +
> > +The information captured in a reverse space mapping record is as
> > follows:
> > +
> > +.. code-block:: c
> > +
> > +       struct xfs_rmap_irec {
> > +           xfs_agblock_t    rm_startblock;   /* extent start block
> > */
> > +           xfs_extlen_t     rm_blockcount;   /* extent length */
> > +           uint64_t         rm_owner;        /* extent owner */
> > +           uint64_t         rm_offset;       /* offset within the
> > owner */
> > +           unsigned int     rm_flags;        /* state flags */
> > +       };
> > +
> > +The first two fields capture the location and size of the physical
> > space,
> > +in units of filesystem blocks.
> > +The owner field tells scrub which metadata structure or file inode
> > have been
> > +assigned this space.
> > +For space allocated to files, the offset field tells scrub where the
> > space was
> > +mapped within the file fork.
> > +Finally, the flags field provides extra information about the space
> > usage --
> > +is this an attribute fork extent?  A file mapping btree extent?  Or
> > an
> > +unwritten data extent?
> > +
> > +Online filesystem checking judges the consistency of each primary
> > metadata
> > +record by comparing its information against all other space indices.
> > +The reverse mapping index plays a key role in the consistency
> > checking process
> > +because it contains a centralized alternate copy of all space
> > allocation
> > +information.
> > +Program runtime and ease of resource acquisition are the only real
> > limits to
> > +what online checking can consult.
> > +For example, a file data extent mapping can be checked against:
> > +
> > +* The absence of an entry in the free space information.
> > +* The absence of an entry in the inode index.
> > +* The absence of an entry in the reference count data if the file is
> > not
> > +  marked as having shared extents.
> > +* The correspondence of an entry in the reverse mapping information.
> > +
> > +A key observation here is that only the reverse mapping can provide
> > a positive
> > +affirmation of correctness if the primary metadata is in doubt.
> if any of the above metadata is in doubt...

Fixed.

> > +The checking code for most primary metadata follows a path similar
> > to the
> > +one outlined above.
> > +
> > +A second observation to make about this secondary index is that
> > proving its
> > +consistency with the primary metadata is difficult.
> 
> > +Demonstrating that a given reverse mapping record exactly
> > corresponds to the
> > +primary space metadata involves a full scan of all primary space
> > metadata,
> > +which is very time intensive.
> "But why?" Wonders the reader. Just jump into an example:
> 
> "In order to verify that an rmap extent does not incorrectly over lap
> with another record, we would need a full scan of all the other
> records, which is time intensive."

I want to shorten it even further:

"Validating that reverse mapping records are correct requires a full
scan of all primary space metadata, which is very time intensive."

> 
> ?
> 
> And then the below is a separate observation right?  

Right.

> > +Scanning activity for online fsck can only use non-blocking lock
> > acquisition
> > +primitives if the locking order is not the regular order as used by
> > the rest of
> > +the filesystem.
> Lastly, it should be noted that most file system operations tend to
> lock primary metadata before locking the secondary metadata.

This isn't accurate -- metadata structures don't have separate locks.
So it's not true to say that we lock primary or secondary metadata.

We /can/ say that file operations lock the inode, then the AGI, then the
AGF; or that directory operations lock the parent and child ILOCKs in
inumber order; and that if scrub wants to take locks in any other order,
it can only do that via trylocks and backoff.

> This
> means that scanning operations that acquire the secondary metadata
> first may need to yield the secondary lock to filesystem operations
> that have already acquired the primary lock. 
> 
> ?
> 
> > +This means that forward progress during this part of a scan of the
> > reverse
> > +mapping data cannot be guaranteed if system load is especially
> > heavy.
> > +Therefore, it is not practical for online check to detect reverse
> > mapping
> > +records that lack a counterpart in the primary metadata.
> Such as <quick list / quick example>
> 
> > +Instead, scrub relies on rigorous cross-referencing during the
> > primary space
> > +mapping structure checks.

I've converted this section into a bullet list:

"There are several observations to make about reverse mapping indices:

"1. Reverse mappings can provide a positive affirmation of correctness if
any of the above primary metadata are in doubt.  The checking code for
most primary metadata follows a path similar to the one outlined above.

"2. Proving the consistency of secondary metadata with the primary
metadata is difficult because that requires a full scan of all primary
space metadata, which is very time intensive.  For example, checking a
reverse mapping record for a file extent mapping btree block requires
locking the file and searching the entire btree to confirm the block.
Instead, scrub relies on rigorous cross-referencing during the primary
space mapping structure checks.

"3. Consistency scans must use non-blocking lock acquisition primitives
if the required locking order is not the same order used by regular
filesystem operations.  This means that forward progress during this
part of a scan of the reverse mapping data cannot be guaranteed if
system load is heavy."

> > +
> 
> The below paragraph sounds like a re-cap?
> 
> "So to recap, reverse mappings also...."

Yep.

> > +Reverse mappings also play a key role in reconstruction of primary
> > metadata.
> > +The secondary information is general enough for online repair to
> > synthesize a
> > +complete copy of any primary space management metadata by locking
> > that
> > +resource, querying all reverse mapping indices looking for records
> > matching
> > +the relevant resource, and transforming the mapping into an
> > appropriate format.
> > +The details of how these records are staged, written to disk, and
> > committed
> > +into the filesystem are covered in subsequent sections.
> I also think the section would be ok if you were to trim off this last
> paragraph too.

Hm.  I still want to set up the expectation that there's more to come.
How about a brief two-sentence transition paragraph:

"In summary, reverse mappings play a key role in reconstruction of
primary metadata.  The details of how these records are staged, written
to disk, and committed into the filesystem are covered in subsequent
sections."

> 
> > +
> > +Checking and Cross-Referencing
> > +------------------------------
> > +
> > +The first step of checking a metadata structure is to examine every
> > record
> > +contained within the structure and its relationship with the rest of
> > the
> > +system.
> > +XFS contains multiple layers of checking to try to prevent
> > inconsistent
> > +metadata from wreaking havoc on the system.
> > +Each of these layers contributes information that helps the kernel
> > to make
> > +three decisions about the health of a metadata structure:
> > +
> > +- Is a part of this structure obviously corrupt
> > (``XFS_SCRUB_OFLAG_CORRUPT``) ?
> > +- Is this structure inconsistent with the rest of the system
> > +  (``XFS_SCRUB_OFLAG_XCORRUPT``) ?
> > +- Is there so much damage around the filesystem that cross-
> > referencing is not
> > +  possible (``XFS_SCRUB_OFLAG_XFAIL``) ?
> > +- Can the structure be optimized to improve performance or reduce
> > the size of
> > +  metadata (``XFS_SCRUB_OFLAG_PREEN``) ?
> > +- Does the structure contain data that is not inconsistent but
> > deserves review
> > +  by the system administrator (``XFS_SCRUB_OFLAG_WARNING``) ?
> > +
> > +The following sections describe how the metadata scrubbing process
> > works.
> > +
> > +Metadata Buffer Verification
> > +````````````````````````````
> > +
> > +The lowest layer of metadata protection in XFS are the metadata
> > verifiers built
> > +into the buffer cache.
> > +These functions perform inexpensive internal consistency checking of
> > the block
> > +itself, and answer these questions:
> > +
> > +- Does the block belong to this filesystem?
> > +
> > +- Does the block belong to the structure that asked for the read?
> > +  This assumes that metadata blocks only have one owner, which is
> > always true
> > +  in XFS.
> > +
> > +- Is the type of data stored in the block within a reasonable range
> > of what
> > +  scrub is expecting?
> > +
> > +- Does the physical location of the block match the location it was
> > read from?
> > +
> > +- Does the block checksum match the data?
> > +
> > +The scope of the protections here are very limited -- verifiers can
> > only
> > +establish that the filesystem code is reasonably free of gross
> > corruption bugs
> > +and that the storage system is reasonably competent at retrieval.
> > +Corruption problems observed at runtime cause the generation of
> > health reports,
> > +failed system calls, and in the extreme case, filesystem shutdowns
> > if the
> > +corrupt metadata force the cancellation of a dirty transaction.
> > +
> > +Every online fsck scrubbing function is expected to read every
> > ondisk metadata
> > +block of a structure in the course of checking the structure.
> > +Corruption problems observed during a check are immediately reported
> > to
> > +userspace as corruption; during a cross-reference, they are reported
> > as a
> > +failure to cross-reference once the full examination is complete.
> > +Reads satisfied by a buffer already in cache (and hence already
> > verified)
> > +bypass these checks.
> > +
> > +Internal Consistency Checks
> > +```````````````````````````
> > +
> > +The next higher level of metadata protection is the internal record
> "After the buffer cache, the next level of metadata protection is..."

Changed.  I'll do the same to the next section as well.

> > +verification code built into the filesystem.
> 
> > +These checks are split between the buffer verifiers, the in-
> > filesystem users of
> > +the buffer cache, and the scrub code itself, depending on the amount
> > of higher
> > +level context required.
> > +The scope of checking is still internal to the block.
> > +For performance reasons, regular code may skip some of these checks
> > unless
> > +debugging is enabled or a write is about to occur.
> > +Scrub functions, of course, must check all possible problems.
> I'd put this chunk after the list below.
> 
> > +Either way, these higher level checking functions answer these
> > questions:
> Then this becomes:
> "These higher level checking functions..."

Done.

> > +
> > +- Does the type of data stored in the block match what scrub is
> > expecting?
> > +
> > +- Does the block belong to the owning structure that asked for the
> > read?
> > +
> > +- If the block contains records, do the records fit within the
> > block?
> > +
> > +- If the block tracks internal free space information, is it
> > consistent with
> > +  the record areas?
> > +
> > +- Are the records contained inside the block free of obvious
> > corruptions?
> > +
> > +Record checks in this category are more rigorous and more time-
> > intensive.
> > +For example, block pointers and inumbers are checked to ensure that
> > they point
> > +within the dynamically allocated parts of an allocation group and
> > within
> > +the filesystem.
> > +Names are checked for invalid characters, and flags are checked for
> > invalid
> > +combinations.
> > +Other record attributes are checked for sensible values.
> > +Btree records spanning an interval of the btree keyspace are checked
> > for
> > +correct order and lack of mergeability (except for file fork
> > mappings).
> > +
> > +Validation of Userspace-Controlled Record Attributes
> > +````````````````````````````````````````````````````
> > +
> > +Various pieces of filesystem metadata are directly controlled by
> > userspace.
> > +Because of this nature, validation work cannot be more precise than
> > checking
> > +that a value is within the possible range.
> > +These fields include:
> > +
> > +- Superblock fields controlled by mount options
> > +- Filesystem labels
> > +- File timestamps
> > +- File permissions
> > +- File size
> > +- File flags
> > +- Names present in directory entries, extended attribute keys, and
> > filesystem
> > +  labels
> > +- Extended attribute key namespaces
> > +- Extended attribute values
> > +- File data block contents
> > +- Quota limits
> > +- Quota timer expiration (if resource usage exceeds the soft limit)
> > +
> > +Cross-Referencing Space Metadata
> > +````````````````````````````````
> > +
> > +The next higher level of checking is cross-referencing records
> > between metadata
> 
> I kinda like the list first so that the reader has an idea of what
> these checks are before getting into discussion about them.  It just
> makes it a little more obvious as to why it's "prohibitively expensive"
> or "dependent on the context of the structure" after having just looked
> at it

<nod>

> The rest looks good from here.

Woot.  Onto the next reply! :)

--D

> Allison
> 
> > +structures.
> > +For regular runtime code, the cost of these checks is considered to
> > be
> > +prohibitively expensive, but as scrub is dedicated to rooting out
> > +inconsistencies, it must pursue all avenues of inquiry.
> > +The exact set of cross-referencing is highly dependent on the
> > context of the
> > +data structure being checked.
> > +
> > +The XFS btree code has keyspace scanning functions that online fsck
> > uses to
> > +cross reference one structure with another.
> > +Specifically, scrub can scan the key space of an index to determine
> > if that
> > +keyspace is fully, sparsely, or not at all mapped to records.
> > +For the reverse mapping btree, it is possible to mask parts of the
> > key for the
> > +purposes of performing a keyspace scan so that scrub can decide if
> > the rmap
> > +btree contains records mapping a certain extent of physical space
> > without the
> > +sparsenses of the rest of the rmap keyspace getting in the way.
> > +
> > +Btree blocks undergo the following checks before cross-referencing:
> > +
> > +- Does the type of data stored in the block match what scrub is
> > expecting?
> > +
> > +- Does the block belong to the owning structure that asked for the
> > read?
> > +
> > +- Do the records fit within the block?
> > +
> > +- Are the records contained inside the block free of obvious
> > corruptions?
> > +
> > +- Are the name hashes in the correct order?
> > +
> > +- Do node pointers within the btree point to valid block addresses
> > for the type
> > +  of btree?
> > +
> > +- Do child pointers point towards the leaves?
> > +
> > +- Do sibling pointers point across the same level?
> > +
> > +- For each node block record, does the record key accurate reflect
> > the contents
> > +  of the child block?
> > +
> > +Space allocation records are cross-referenced as follows:
> > +
> > +1. Any space mentioned by any metadata structure are cross-
> > referenced as
> > +   follows:
> > +
> > +   - Does the reverse mapping index list only the appropriate owner
> > as the
> > +     owner of each block?
> > +
> > +   - Are none of the blocks claimed as free space?
> > +
> > +   - If these aren't file data blocks, are none of the blocks
> > claimed as space
> > +     shared by different owners?
> > +
> > +2. Btree blocks are cross-referenced as follows:
> > +
> > +   - Everything in class 1 above.
> > +
> > +   - If there's a parent node block, do the keys listed for this
> > block match the
> > +     keyspace of this block?
> > +
> > +   - Do the sibling pointers point to valid blocks?  Of the same
> > level?
> > +
> > +   - Do the child pointers point to valid blocks?  Of the next level
> > down?
> > +
> > +3. Free space btree records are cross-referenced as follows:
> > +
> > +   - Everything in class 1 and 2 above.
> > +
> > +   - Does the reverse mapping index list no owners of this space?
> > +
> > +   - Is this space not claimed by the inode index for inodes?
> > +
> > +   - Is it not mentioned by the reference count index?
> > +
> > +   - Is there a matching record in the other free space btree?
> > +
> > +4. Inode btree records are cross-referenced as follows:
> > +
> > +   - Everything in class 1 and 2 above.
> > +
> > +   - Is there a matching record in free inode btree?
> > +
> > +   - Do cleared bits in the holemask correspond with inode clusters?
> > +
> > +   - Do set bits in the freemask correspond with inode records with
> > zero link
> > +     count?
> > +
> > +5. Inode records are cross-referenced as follows:
> > +
> > +   - Everything in class 1.
> > +
> > +   - Do all the fields that summarize information about the file
> > forks actually
> > +     match those forks?
> > +
> > +   - Does each inode with zero link count correspond to a record in
> > the free
> > +     inode btree?
> > +
> > +6. File fork space mapping records are cross-referenced as follows:
> > +
> > +   - Everything in class 1 and 2 above.
> > +
> > +   - Is this space not mentioned by the inode btrees?
> > +
> > +   - If this is a CoW fork mapping, does it correspond to a CoW
> > entry in the
> > +     reference count btree?
> > +
> > +7. Reference count records are cross-referenced as follows:
> > +
> > +   - Everything in class 1 and 2 above.
> > +
> > +   - Within the space subkeyspace of the rmap btree (that is to say,
> > all
> > +     records mapped to a particular space extent and ignoring the
> > owner info),
> > +     are there the same number of reverse mapping records for each
> > block as the
> > +     reference count record claims?
> > +
> > +Proposed patchsets are the series to find gaps in
> > +`refcount btree
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=scrub-detect-refcount-gaps>`_,
> > +`inode btree
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=scrub-detect-inobt-gaps>`_, and
> > +`rmap btree
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=scrub-detect-rmapbt-gaps>`_ records;
> > +to find
> > +`mergeable records
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=scrub-detect-mergeable-records>`_;
> > +and to
> > +`improve cross referencing with rmap
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=scrub-strengthen-rmap-checking>`_
> > +before starting a repair.
> > +
> > +Checking Extended Attributes
> > +````````````````````````````
> > +
> > +Extended attributes implement a key-value store that enable
> > fragments of data
> > +to be attached to any file.
> > +Both the kernel and userspace can access the keys and values,
> > subject to
> > +namespace and privilege restrictions.
> > +Most typically these fragments are metadata about the file --
> > origins, security
> > +contexts, user-supplied labels, indexing information, etc.
> > +
> > +Names can be as long as 255 bytes and can exist in several different
> > +namespaces.
> > +Values can be as large as 64KB.
> > +A file's extended attributes are stored in blocks mapped by the attr
> > fork.
> > +The mappings point to leaf blocks, remote value blocks, or dabtree
> > blocks.
> > +Block 0 in the attribute fork is always the top of the structure,
> > but otherwise
> > +each of the three types of blocks can be found at any offset in the
> > attr fork.
> > +Leaf blocks contain attribute key records that point to the name and
> > the value.
> > +Names are always stored elsewhere in the same leaf block.
> > +Values that are less than 3/4 the size of a filesystem block are
> > also stored
> > +elsewhere in the same leaf block.
> > +Remote value blocks contain values that are too large to fit inside
> > a leaf.
> > +If the leaf information exceeds a single filesystem block, a dabtree
> > (also
> > +rooted at block 0) is created to map hashes of the attribute names
> > to leaf
> > +blocks in the attr fork.
> > +
> > +Checking an extended attribute structure is not so straightfoward
> > due to the
> > +lack of separation between attr blocks and index blocks.
> > +Scrub must read each block mapped by the attr fork and ignore the
> > non-leaf
> > +blocks:
> > +
> > +1. Walk the dabtree in the attr fork (if present) to ensure that
> > there are no
> > +   irregularities in the blocks or dabtree mappings that do not
> > point to
> > +   attr leaf blocks.
> > +
> > +2. Walk the blocks of the attr fork looking for leaf blocks.
> > +   For each entry inside a leaf:
> > +
> > +   a. Validate that the name does not contain invalid characters.
> > +
> > +   b. Read the attr value.
> > +      This performs a named lookup of the attr name to ensure the
> > correctness
> > +      of the dabtree.
> > +      If the value is stored in a remote block, this also validates
> > the
> > +      integrity of the remote value block.
> > +
> > +Checking and Cross-Referencing Directories
> > +``````````````````````````````````````````
> > +
> > +The filesystem directory tree is a directed acylic graph structure,
> > with files
> > +constituting the nodes, and directory entries (dirents) constituting
> > the edges.
> > +Directories are a special type of file containing a set of mappings
> > from a
> > +255-byte sequence (name) to an inumber.
> > +These are called directory entries, or dirents for short.
> > +Each directory file must have exactly one directory pointing to the
> > file.
> > +A root directory points to itself.
> > +Directory entries point to files of any type.
> > +Each non-directory file may have multiple directories point to it.
> > +
> > +In XFS, directories are implemented as a file containing up to three
> > 32GB
> > +partitions.
> > +The first partition contains directory entry data blocks.
> > +Each data block contains variable-sized records associating a user-
> > provided
> > +name with an inumber and, optionally, a file type.
> > +If the directory entry data grows beyond one block, the second
> > partition (which
> > +exists as post-EOF extents) is populated with a block containing
> > free space
> > +information and an index that maps hashes of the dirent names to
> > directory data
> > +blocks in the first partition.
> > +This makes directory name lookups very fast.
> > +If this second partition grows beyond one block, the third partition
> > is
> > +populated with a linear array of free space information for faster
> > +expansions.
> > +If the free space has been separated and the second partition grows
> > again
> > +beyond one block, then a dabtree is used to map hashes of dirent
> > names to
> > +directory data blocks.
> > +
> > +Checking a directory is pretty straightfoward:
> > +
> > +1. Walk the dabtree in the second partition (if present) to ensure
> > that there
> > +   are no irregularities in the blocks or dabtree mappings that do
> > not point to
> > +   dirent blocks.
> > +
> > +2. Walk the blocks of the first partition looking for directory
> > entries.
> > +   Each dirent is checked as follows:
> > +
> > +   a. Does the name contain no invalid characters?
> > +
> > +   b. Does the inumber correspond to an actual, allocated inode?
> > +
> > +   c. Does the child inode have a nonzero link count?
> > +
> > +   d. If a file type is included in the dirent, does it match the
> > type of the
> > +      inode?
> > +
> > +   e. If the child is a subdirectory, does the child's dotdot
> > pointer point
> > +      back to the parent?
> > +
> > +   f. If the directory has a second partition, perform a named
> > lookup of the
> > +      dirent name to ensure the correctness of the dabtree.
> > +
> > +3. Walk the free space list in the third partition (if present) to
> > ensure that
> > +   the free spaces it describes are really unused.
> > +
> > +Checking operations involving :ref:`parents <dirparent>` and
> > +:ref:`file link counts <nlinks>` are discussed in more detail in
> > later
> > +sections.
> > +
> > +Checking Directory/Attribute Btrees
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +As stated in previous sections, the directory/attribute btree
> > (dabtree) index
> > +maps user-provided names to improve lookup times by avoiding linear
> > scans.
> > +Internally, it maps a 32-bit hash of the name to a block offset
> > within the
> > +appropriate file fork.
> > +
> > +The internal structure of a dabtree closely resembles the btrees
> > that record
> > +fixed-size metadata records -- each dabtree block contains a magic
> > number, a
> > +checksum, sibling pointers, a UUID, a tree level, and a log sequence
> > number.
> > +The format of leaf and node records are the same -- each entry
> > points to the
> > +next level down in the hierarchy, with dabtree node records pointing
> > to dabtree
> > +leaf blocks, and dabtree leaf records pointing to non-dabtree blocks
> > elsewhere
> > +in the fork.
> > +
> > +Checking and cross-referencing the dabtree is very similar to what
> > is done for
> > +space btrees:
> > +
> > +- Does the type of data stored in the block match what scrub is
> > expecting?
> > +
> > +- Does the block belong to the owning structure that asked for the
> > read?
> > +
> > +- Do the records fit within the block?
> > +
> > +- Are the records contained inside the block free of obvious
> > corruptions?
> > +
> > +- Are the name hashes in the correct order?
> > +
> > +- Do node pointers within the dabtree point to valid fork offsets
> > for dabtree
> > +  blocks?
> > +
> > +- Do leaf pointers within the dabtree point to valid fork offsets
> > for directory
> > +  or attr leaf blocks?
> > +
> > +- Do child pointers point towards the leaves?
> > +
> > +- Do sibling pointers point across the same level?
> > +
> > +- For each dabtree node record, does the record key accurate reflect
> > the
> > +  contents of the child dabtree block?
> > +
> > +- For each dabtree leaf record, does the record key accurate reflect
> > the
> > +  contents of the directory or attr block?
> > +
> > +Cross-Referencing Summary Counters
> > +``````````````````````````````````
> > +
> > +XFS maintains three classes of summary counters: available
> > resources, quota
> > +resource usage, and file link counts.
> > +
> > +In theory, the amount of available resources (data blocks, inodes,
> > realtime
> > +extents) can be found by walking the entire filesystem.
> > +This would make for very slow reporting, so a transactional
> > filesystem can
> > +maintain summaries of this information in the superblock.
> > +Cross-referencing these values against the filesystem metadata
> > should be a
> > +simple matter of walking the free space and inode metadata in each
> > AG and the
> > +realtime bitmap, but there are complications that will be discussed
> > in
> > +:ref:`more detail <fscounters>` later.
> > +
> > +:ref:`Quota usage <quotacheck>` and :ref:`file link count <nlinks>`
> > +checking are sufficiently complicated to warrant separate sections.
> > +
> > +Post-Repair Reverification
> > +``````````````````````````
> > +
> > +After performing a repair, the checking code is run a second time to
> > validate
> > +the new structure, and the results of the health assessment are
> > recorded
> > +internally and returned to the calling process.
> > +This step is critical for enabling system administrator to monitor
> > the status
> > +of the filesystem and the progress of any repairs.
> > +For developers, it is a useful means to judge the efficacy of error
> > detection
> > +and correction in the online and offline checking tools.
> > diff --git a/Documentation/filesystems/xfs-self-describing-
> > metadata.rst b/Documentation/filesystems/xfs-self-describing-
> > metadata.rst
> > index b79dbf36dc94..a10c4ae6955e 100644
> > --- a/Documentation/filesystems/xfs-self-describing-metadata.rst
> > +++ b/Documentation/filesystems/xfs-self-describing-metadata.rst
> > @@ -1,4 +1,5 @@
> >  .. SPDX-License-Identifier: GPL-2.0
> > +.. _xfs_self_describing_metadata:
> >  
> >  ============================
> >  XFS Self Describing Metadata
> > 
> 
