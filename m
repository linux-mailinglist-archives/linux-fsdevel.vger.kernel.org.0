Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477B8595369
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 09:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiHPHHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 03:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiHPHHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:07:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A807F11B;
        Mon, 15 Aug 2022 19:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48392B8112C;
        Tue, 16 Aug 2022 02:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E67C433D6;
        Tue, 16 Aug 2022 02:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660617424;
        bh=QfJZwxnijrafDHiqM3pJJbpTrRBL/3uV+xdjgFkUG3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWmE1HoBomfO52m2vYl5tVAiFhDDyrJjkUH4yzBK0Fbtf56pjSPzZ9/35ebVZllNN
         2+YJMYXyMhlBbS7iCTLDJqVM4etW0ZLl+ELv9TcP8yfbZAsWbqoXGPsEW8kN9GtN25
         Ix80Gc4xflYycPlNeWb8ulVPlQuhon9pabQvyT4RK2E6Qlu97UNV5nqIQky0minwj4
         Pxa3Ou6WbsOuQQgNgqiVMNtbbqQviLxqLeCjpGQHl5qKWu77fgRDfuOF5WGhYXUd1A
         Rg3X8KzwItpLk8XLmfJFboJfcy/HuQWRGPRG2Mv8p9WabqQt6mst3hRysD7fGW4TrL
         JoEbO307qAr2g==
Date:   Mon, 15 Aug 2022 19:37:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Subject: Re: [PATCH 05/14] xfs: document the filesystem metadata checking
 strategy
Message-ID: <YvsCz20x8MGyIVRa@magnolia>
References: <165989700514.2495930.13997256907290563223.stgit@magnolia>
 <165989703355.2495930.3778310072095254204.stgit@magnolia>
 <20220811011742.GP3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811011742.GP3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 11, 2022 at 11:17:42AM +1000, Dave Chinner wrote:
> On Sun, Aug 07, 2022 at 11:30:33AM -0700, Darrick J. Wong wrote:
> > +Reverse Mapping
> > +---------------
> > +
> > +The original design of XFS (circa 1993) is an improvement upon 1980s Unix
> > +filesystem design.
> > +In those days, storage density was expensive, CPU time was scarce, and
> > +excessive seek time could kill performance.
> > +For performance reasons, filesystem authors were reluctant to add redundancy to
> > +the filesystem, even at the cost of data integrity.
> > +Filesystems designers in the early 21st century choose different strategies to
> > +increase internal redundancy -- either storing nearly identical copies of
> > +metadata, or more space-efficient techniques such as erasure coding.
> > +Obvious corruptions are typically repaired by copying replicas or
> > +reconstructing from codes.
> > +
> > +For XFS, a different redundancy strategy was chosen to modernize the design:
> > +a secondary space usage index that maps allocated disk extents back to their
> > +owners.
> > +By adding a new index, the filesystem retains most of its ability to scale
> > +well to heavily threaded workloads involving large datasets, since the primary
> > +file metadata (the directory tree, the file block map, and the allocation
> > +groups) remain unchanged.
> > +Although the reverse-mapping feature increases overhead costs for space
> > +mapping activities just like any other system that improves redundancy, it
> > +has two critical advantages: first, the reverse index is key to enabling online
> > +fsck and other requested functionality such as filesystem reorganization,
> > +better media failure reporting, and shrinking.
> > +Second, the different ondisk storage format of the reverse mapping btree
> > +defeats device-level deduplication, because the filesystem requires real
> > +redundancy.
> 
> "defeats device-level deduplication" took me a bit of thought to
> follow what you were trying to describe here.
> 
> I think what you mean is this:
> 
> "Second, the reverse mapping metadata uses a different on-disk
> format for storage. This prevents storage device level deduplication
> from removing redundant metadata the filesystem stores for recovery
> purposes. Hence we will always have two physical copies of the
> metadata we need for recovery in the storage device, regardless of
> the technologies it implements."

Correct.  I'll work that in.

> > +A criticism of adding the secondary index is that it does nothing to improve
> > +the robustness of user data storage itself.
> > +This is a valid point, but adding a new index for file data block checksums
> > +increases write amplification and turns data overwrites into copy-writes, which
> > +age the filesystem prematurely.
> 
> And can come with a significant IO performance penalty.

Right, I shouldn't be assuming that people can draw the connection
between write amplification/aging fs metadata and slow performance.

> > +Checking Extended Attributes
> > +````````````````````````````
> > +
> > +Extended attributes implement a key-value store that enable fragments of data
> > +to be attached to any file.
> > +Both the kernel and userspace can access the keys and values, subject to
> > +namespace and privilege restrictions.
> > +Most typically these fragments are metadata about the file -- origins, security
> > +contexts, user-supplied labels, indexing information, etc.
> > +
> > +Names can be as long as 255 bytes and can exist in several different
> > +namespaces.
> > +Values can be as large as 64KB.
> > +A file's extended attributes are stored in blocks mapped by the attr fork.
> > +The mappings point to leaf blocks, remote value blocks, or dabtree blocks.
> > +Block 0 in the attribute fork is always the top of the structure, but otherwise
> > +each of the three types of blocks can be found at any offset in the attr fork.
> > +Leaf blocks contain attribute key records that point to the name and the value.
> > +Names are always stored elsewhere in the same leaf block.
> > +Values that are less than 3/4 the size of a filesystem block are also stored
> > +elsewhere in the same leaf block.
> > +Remote value blocks contain values that are too large to fit inside a leaf.
> > +If the leaf information exceeds a single filesystem block, a dabtree (also
> > +rooted at block 0) is created to map hashes of the attribute names to leaf
> > +blocks in the attr fork.
> > +
> > +Checking an extended attribute structure is not so straightfoward due to the
> > +lack of separation between attr blocks and index blocks.
> > +Scrub must read each block mapped by the attr fork and ignore the non-leaf
> > +blocks:
> > +
> > +1. Walk the dabtree in the attr fork (if present) to ensure that there are no
> > +   irregularities in the blocks or dabtree mappings that do not point to
> > +   attr leaf blocks.
> > +
> > +2. Walk the blocks of the attr fork looking for leaf blocks.
> > +   For each entry inside a leaf:
> > +
> > +   a. Validate that the name does not contain invalid characters.
> > +
> > +   b. Read the attr value.
> > +      This performs a named lookup of the attr name to ensure the correctness
> > +      of the dabtree.
> > +      If the value is stored in a remote block, this also validates the
> > +      integrity of the remote value block.
> 
> I'm assuming that checking remote xattr blocks involves checking the headers
> are all valid, the overall length is correct, they have valid rmap
> entries, etc?

Yep.  The headers are checked by reading the attr value; and the space
mappings are checked by the attr fork scanner.

> > +Checking and Cross-Referencing Directories
> > +``````````````````````````````````````````
> > +
> > +The filesystem directory tree is a directed acylic graph structure, with files
> > +constituting the nodes, and directory entries (dirents) constituting the edges.
> 
> "with hashed file names consituting the nodes" ?



> > +Directories are a special type of file containing a set of mappings from a
> > +255-byte sequence (name) to an inumber.
> > +These are called directory entries, or dirents for short.
> > +Each directory file must have exactly one directory pointing to the file.
> > +A root directory points to itself.
> > +Directory entries point to files of any type.
> 
> "point to inodes"
> 
> > +Each non-directory file may have multiple directories point to it.
> 
> "Each non directory inode may have multiple dirents point to it"

Both fixed.

> > +
> > +In XFS, directories are implemented as a file containing up to three 32GB
> > +partitions.
> 
> "implemented as offset-based file data"

Fixed.

> > +The first partition contains directory entry data blocks.
> > +Each data block contains variable-sized records associating a user-provided
> > +name with an inumber and, optionally, a file type.
> > +If the directory entry data grows beyond one block, the second partition (which
> > +exists as post-EOF extents) is populated with a block containing free space
> > +information and an index that maps hashes of the dirent names to directory data
> > +blocks in the first partition.
> > +This makes directory name lookups very fast.
> 
> "This is known as a "LEAF 1" format directory."

Good addition!

> > +If this second partition grows beyond one block, the third partition is
> > +populated with a linear array of free space information for faster
> > +expansions.
> 
> s/for faster expansions/to speed up first fit searches when inserting
> new dirents/.
> 
> "This is known as a "NODE" format directory."

Ok.

> > +If the free space has been separated and the second partition grows again
> > +beyond one block, then a dabtree is used to map hashes of dirent names to
> > +directory data blocks.
> 
> The second partition is changed to a dabtree format during NODE
> format conversion - it's just the single root block form. It grows
> as a btree from there by normal split/grow btree operations at that
> point.  Hence I'm not sure this needs to be mentioned as a separate
> step - the node form conversion should mention the second partition
> transitions to the dabtree index format, and it's all obvious from
> there...

I put that nugget in because *I* keep forgetting that there are
directories with a single block in the second partition that doesn't
have the DA3_NODE magicnum. ;)

How about:

"This is known as a 'NODE' format directory.
The second partition contains a dabtree that ranges in size from a
single block to many levels."

> > +Checking a directory is pretty straightfoward:
> > +
> > +1. Walk the dabtree in the second partition (if present) to ensure that there
> > +   are no irregularities in the blocks or dabtree mappings that do not point to
> > +   dirent blocks.
> > +
> > +2. Walk the blocks of the first partition looking for directory entries.
> > +   Each dirent is checked as follows:
> > +
> > +   a. Does the name contain no invalid characters?
> > +
> > +   b. Does the inumber correspond to an actual, allocated inode?
> > +
> > +   c. Does the child inode have a nonzero link count?
> > +
> > +   d. If a file type is included in the dirent, does it match the type of the
> > +      inode?
> > +
> > +   e. If the child is a subdirectory, does the child's dotdot pointer point
> > +      back to the parent?
> > +
> > +   f. If the directory has a second partition, perform a named lookup of the
> > +      dirent name to ensure the correctness of the dabtree.
> > +
> > +3. Walk the free space list in the third partition (if present) to ensure that
> > +   the free spaces it describes are really unused.
> 
> Actaully, they should reflect the largest free space in the given
> block, so this has to be checked against the bests array in the
> given block.
> 
> Also, if we are walking the directory blocks, we should be checking
> the empty ranges for valid tags and sizes, and that the largest 3
> holes in the block are correctly ordered in the bests array, too.

<nod> I think the code actually does that, but I got lazy with writing
here. :/

> > +
> > +Checking operations involving :ref:`parents <dirparent>` and
> > +:ref:`file link counts <nlinks>` are discussed in more detail in later
> > +sections.
> > +
> > +Checking Directory/Attribute Btrees
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +As stated in previous sections, the directory/attribute btree (dabtree) index
> > +maps user-provided names to improve lookup times by avoiding linear scans.
> > +Internally, it maps a 32-bit hash of the name to a block offset within the
> > +appropriate file fork.
> > +
> > +The internal structure of a dabtree closely resembles the btrees that record
> > +fixed-size metadata records -- each dabtree block contains a magic number, a
> > +checksum, sibling pointers, a UUID, a tree level, and a log sequence number.
> > +The format of leaf and node records are the same -- each entry points to the
> > +next level down in the hierarchy, with dabtree node records pointing to dabtree
> > +leaf blocks, and dabtree leaf records pointing to non-dabtree blocks elsewhere
> > +in the fork.
> > +
> > +Checking and cross-referencing the dabtree is very similar to what is done for
> > +space btrees:
> > +
> > +- Does the type of data stored in the block match what scrub is expecting?
> > +
> > +- Does the block belong to the owning structure that asked for the read?
> > +
> > +- Do the records fit within the block?
> > +
> > +- Are the records contained inside the block free of obvious corruptions?
> > +
> > +- Are the name hashes in the correct order?
> > +
> > +- Do node pointers within the dabtree point to valid fork offsets for dabtree
> > +  blocks?
> > +
> > +- Do leaf pointers within the dabtree point to valid fork offsets for directory
> > +  or attr leaf blocks?
> > +
> > +- Do child pointers point towards the leaves?
> > +
> > +- Do sibling pointers point across the same level?
> > +
> > +- For each dabtree node record, does the record key accurate reflect the
> > +  contents of the child dabtree block?
> > +
> > +- For each dabtree leaf record, does the record key accurate reflect the
> > +  contents of the directory or attr block?
> 
> This last one is checking that they point to a valid dirent and
> check that the hash of the dirent name actually matches the hash
> that points to it?

Yes.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
