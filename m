Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94B666346
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 20:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjAKTKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 14:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjAKTKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:10:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C18BB867;
        Wed, 11 Jan 2023 11:10:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B4DA61DCE;
        Wed, 11 Jan 2023 19:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F6DC433EF;
        Wed, 11 Jan 2023 19:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673464244;
        bh=+7JEO8wk5M0g65GEfBpii8a+3rplcwVK86dPWFAgzjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XcHDfFlTiYPHl8gB2UA6Z/iK+RQ4DFOG7Gg3KOumog2ZmsXxDbgM/xTzxBlIH9J/N
         anvUQgVhyHCUA8GosUVwj1C9Uj27ecJbIkHaeE/DUwg52ODZgro2a6F39I9g4wxawM
         ORlRiNzdWWmh8z6VJywMGl92etML5GluAo2Z4rU3a2I1NEo5FDDy+dwYZ3QYkiBGBJ
         0WfNqDNBMeW5ICgRDRfaBMZTMB2eHtesUtcH8gskYurhV4qTDyIETjMwtF5M/giz0u
         r+xcPQxidlMesXCeq3x/dLwTR6OsWPAGOzArK7CDWT2aTHu6zhZVs2BpiVJ9QfqaFN
         c6iXJfrFyxpZQ==
Date:   Wed, 11 Jan 2023 11:10:43 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Chandan Babu <chandan.babu@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 01/14] xfs: document the motivation for online fsck design
Message-ID: <Y78Js8BP+s6xFfzm@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825174.682859.4770282034026097725.stgit@magnolia>
 <0607e986e96def5ba17bd53ff3f7e775a99d3d94.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0607e986e96def5ba17bd53ff3f7e775a99d3d94.camel@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 07, 2023 at 05:01:54AM +0000, Allison Henderson wrote:
> On Fri, 2022-12-30 at 14:10 -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Start the first chapter of the online fsck design documentation.
> > This covers the motivations for creating this in the first place.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  Documentation/filesystems/index.rst                |    1 
> >  .../filesystems/xfs-online-fsck-design.rst         |  199
> > ++++++++++++++++++++
> >  2 files changed, 200 insertions(+)
> >  create mode 100644 Documentation/filesystems/xfs-online-fsck-
> > design.rst
> > 
> > 
> > diff --git a/Documentation/filesystems/index.rst
> > b/Documentation/filesystems/index.rst
> > index bee63d42e5ec..fbb2b5ada95b 100644
> > --- a/Documentation/filesystems/index.rst
> > +++ b/Documentation/filesystems/index.rst
> > @@ -123,4 +123,5 @@ Documentation for filesystem implementations.
> >     vfat
> >     xfs-delayed-logging-design
> >     xfs-self-describing-metadata
> > +   xfs-online-fsck-design
> >     zonefs
> > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst
> > b/Documentation/filesystems/xfs-online-fsck-design.rst
> > new file mode 100644
> > index 000000000000..25717ebb5f80
> > --- /dev/null
> > +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> > @@ -0,0 +1,199 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. _xfs_online_fsck_design:
> > +
> > +..
> > +        Mapping of heading styles within this document:
> > +        Heading 1 uses "====" above and below
> > +        Heading 2 uses "===="
> > +        Heading 3 uses "----"
> > +        Heading 4 uses "````"
> > +        Heading 5 uses "^^^^"
> > +        Heading 6 uses "~~~~"
> > +        Heading 7 uses "...."
> > +
> > +        Sections are manually numbered because apparently that's
> > what everyone
> > +        does in the kernel.
> > +
> > +======================
> > +XFS Online Fsck Design
> > +======================
> > +
> > +This document captures the design of the online filesystem check
> > feature for
> > +XFS.
> > +The purpose of this document is threefold:
> > +
> > +- To help kernel distributors understand exactly what the XFS online
> > fsck
> > +  feature is, and issues about which they should be aware.
> > +
> > +- To help people reading the code to familiarize themselves with the
> > relevant
> > +  concepts and design points before they start digging into the
> > code.
> > +
> > +- To help developers maintaining the system by capturing the reasons
> > +  supporting higher level decisionmaking.
> nit: decision making

Fixed.

> > +
> > +As the online fsck code is merged, the links in this document to
> > topic branches
> > +will be replaced with links to code.
> > +
> > +This document is licensed under the terms of the GNU Public License,
> > v2.
> > +The primary author is Darrick J. Wong.
> > +
> > +This design document is split into seven parts.
> > +Part 1 defines what fsck tools are and the motivations for writing a
> > new one.
> > +Parts 2 and 3 present a high level overview of how online fsck
> > process works
> > +and how it is tested to ensure correct functionality.
> > +Part 4 discusses the user interface and the intended usage modes of
> > the new
> > +program.
> > +Parts 5 and 6 show off the high level components and how they fit
> > together, and
> > +then present case studies of how each repair function actually
> > works.
> > +Part 7 sums up what has been discussed so far and speculates about
> > what else
> > +might be built atop online fsck.
> > +
> > +.. contents:: Table of Contents
> > +   :local:
> > +
> 
> Something that I've noticed in my training sessions is that often
> times, less is more.  People really only absorb so much over a
> particular duration of time, so sometimes having too much detail in the
> context is not as helpful as you might think.  A lot of times,
> paraphrasing excerpts to reflect the same info in a more compact format
> will help you keep audience on track (a little longer at least). 
> 
> > +1. What is a Filesystem Check?
> > +==============================
> > +
> > +A Unix filesystem has three main jobs: to provide a hierarchy of
> > names through
> > +which application programs can associate arbitrary blobs of data for
> > any
> > +length of time, to virtualize physical storage media across those
> > names, and
> > +to retrieve the named data blobs at any time.
> Consider the following paraphrase:
> 
> A Unix filesystem has three main jobs:
>  * Provide a hierarchy of names by which applications access data for a
> length of time.
>  * Store or retrieve that data at any time.
>  * Virtualize physical storage media across those names

Ooh, listifying.  I did quite a bit of that to break up the walls of
text in earlier revisions, but apparently I missed this one.

> Also... I dont think it would be inappropriate to just skip the above,
> and jump right into fsck.  That's a very limited view of a filesystem,
> likely a reader seeking an fsck doc probably has some idea of what a fs
> is otherwise supposed to be doing.  

This will become part of the general kernel documentation, so we can't
assume that all readers are going to know what a fs really does.

"A Unix filesystem has four main responsibilities:

- Provide a hierarchy of names through which application programs can
  associate arbitrary blobs of data for any length of time,

- Virtualize physical storage media across those names, and

- Retrieve the named data blobs at any time.

- Examine resource usage.

"Metadata directly supporting these functions (e.g. files, directories,
space mappings) are sometimes called primary metadata.
Secondary metadata (e.g. reverse mapping and directory parent pointers)
support operations internal to the filesystem, such as internal
consistency checking and reorganization."

(I added those last two sentences in response to a point you made
below.)

> > +The filesystem check (fsck) tool examines all the metadata in a
> > filesystem
> > +to look for errors.
> > +Simple tools only check for obvious corruptions, but the more
> > sophisticated
> > +ones cross-reference metadata records to look for inconsistencies.
> > +People do not like losing data, so most fsck tools also contains
> > some ability
> > +to deal with any problems found.
> 
> While simple tools can detect data corruptions, a filesystem check
> (fsck) uses metadata records as a cross-reference to find and correct
> more inconsistencies.
> 
> ?

Let's be careful with the term 'data corruption' here -- a lot of people
(well ok me) will see that as *user* data corruption, whereas we're
talking about *metadata* corruption.

I think I'll rework that second sentence further:

"In addition to looking for obvious metadata corruptions, fsck also
cross-references different types of metadata records with each other to
look for inconsistencies."

Since the really dumb fscks of the 1970s are a long ways past now.

> > +As a word of caution -- the primary goal of most Linux fsck tools is
> > to restore
> > +the filesystem metadata to a consistent state, not to maximize the
> > data
> > +recovered.
> > +That precedent will not be challenged here.
> > +
> > +Filesystems of the 20th century generally lacked any redundancy in
> > the ondisk
> > +format, which means that fsck can only respond to errors by erasing
> > files until
> > +errors are no longer detected.
> > +System administrators avoid data loss by increasing the number of
> > separate
> > +storage systems through the creation of backups; 
> 
> 
> > and they avoid downtime by
> > +increasing the redundancy of each storage system through the
> > creation of RAID.
> Mmm, raids help more for hardware failures right?  They dont really
> have a notion of when the fs is corrupted.

Right.

> While an fsck can help
> navigate around a corruption possibly caused by a hardware failure, I
> think it's really a different kind of redundancy. I think I'd probably
> drop the last line and keep the selling point focused online repair.

Yes, RAIDs provide a totally different type of redundancy.  I decided to
make this point specifically to counter the people who argue that RAID
makes them impervious to corruption problems, etc.

This attitude seemed rather prevalent in the early days of btrfs and a
certain other filesystem that Shall Not Be Named, even though the btrfs
developers themselves acknowledge this distinction, given the existence
of `btrfs scrub' and `btrfs check'.

However you do have a good point that this sentence doesn't add much
where it is.  I think I'll add it as a sidebar at the end of the
paragraph.

> > +More recent filesystem designs contain enough redundancy in their
> > metadata that
> > +it is now possible to regenerate data structures when non-
> > catastrophic errors
> > +occur; 
> 
> 
> > this capability aids both strategies.
> > +Over the past few years, XFS has added a storage space reverse
> > mapping index to
> > +make it easy to find which files or metadata objects think they own
> > a
> > +particular range of storage.
> > +Efforts are under way to develop a similar reverse mapping index for
> > the naming
> > +hierarchy, which will involve storing directory parent pointers in
> > each file.
> > +With these two pieces in place, XFS uses secondary information to
> > perform more
> > +sophisticated repairs.
> This part here I think I would either let go or relocate.  The topic of
> this section is supposed to discuss roughly what a filesystem check is.
> Ideally so we can start talking about how ofsck is different.  It feels
> like a bit of a jump to suddenly hop into rmap and pptrs, and for
> "sophisticated repairs" that we havn't really gotten into the details
> of yet.  So I think it would read easier if we saved this part until we
> start talking about how they are used later.  

Agreed.

> > +
> > +TLDR; Show Me the Code!
> > +-----------------------
> > +
> > +Code is posted to the kernel.org git trees as follows:
> > +`kernel changes
> > <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
> > /log/?h=repair-symlink>`_,
> > +`userspace changes
> > <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.
> > git/log/?h=scrub-media-scan-service>`_, and
> > +`QA test changes
> > <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.
> > git/log/?h=repair-dirs>`_.
> > +Each kernel patchset adding an online repair function will use the
> > same branch
> > +name across the kernel, xfsprogs, and fstests git repos.
> > +
> > +Existing Tools
> > +--------------
> > +
> > +The online fsck tool described here will be the third tool in the
> > history of
> > +XFS (on Linux) to check and repair filesystems.
> > +Two programs precede it:
> > +
> > +The first program, ``xfs_check``, was created as part of the XFS
> > debugger
> > +(``xfs_db``) and can only be used with unmounted filesystems.
> > +It walks all metadata in the filesystem looking for inconsistencies
> > in the
> > +metadata, though it lacks any ability to repair what it finds.
> > +Due to its high memory requirements and inability to repair things,
> > this
> > +program is now deprecated and will not be discussed further.
> > +
> > +The second program, ``xfs_repair``, was created to be faster and
> > more robust
> > +than the first program.
> > +Like its predecessor, it can only be used with unmounted
> > filesystems.
> > +It uses extent-based in-memory data structures to reduce memory
> > consumption,
> > +and tries to schedule readahead IO appropriately to reduce I/O
> > waiting time
> > +while it scans the metadata of the entire filesystem.
> > +The most important feature of this tool is its ability to respond to
> > +inconsistencies in file metadata and directory tree by erasing
> > things as needed
> > +to eliminate problems.
> > +Space usage metadata are rebuilt from the observed file metadata.
> > +
> > +Problem Statement
> > +-----------------
> > +
> > +The current XFS tools leave several problems unsolved:
> > +
> > +1. **User programs** suddenly **lose access** to information in the
> > computer
> > +   when unexpected shutdowns occur as a result of silent corruptions
> > in the
> > +   filesystem metadata.
> > +   These occur **unpredictably** and often without warning.
> 
> 
> 1. **User programs** suddenly **lose access** to the filesystem
>    when unexpected shutdowns occur as a result of silent corruptions
> that could have otherwise been avoided with an online repair
> 
> While some of these issues are not untrue, I think it makes sense to
> limit them to the issue you plan to solve, and therefore discuss.

Fair enough, it's not like one loses /all/ the data in the computer.

That said, we're still in the problem definition phase, so I don't want
to mention online repair just yet.

> > +2. **Users** experience a **total loss of service** during the
> > recovery period
> > +   after an **unexpected shutdown** occurs.
> > +
> > +3. **Users** experience a **total loss of service** if the
> > filesystem is taken
> > +   offline to **look for problems** proactively.
> > +
> > +4. **Data owners** cannot **check the integrity** of their stored
> > data without
> > +   reading all of it.
> 
> > +   This may expose them to substantial billing costs when a linear
> > media scan
> > +   might suffice.
> Ok, I had to re-read this one a few times, but I think this reads a
> little cleaner:
> 
>     Customers that are billed for data egress may incur unnecessary
> cost when a background media scan on the host may have sufficed
> 
> ?

"...when a linear media scan performed by the storage system
administrator would suffice."

I was tempted to say "storage owner" instead of "storage system
administrator" but that sounded a little too IBM.

> > +5. **System administrators** cannot **schedule** a maintenance
> > window to deal
> > +   with corruptions if they **lack the means** to assess filesystem
> > health
> > +   while the filesystem is online.
> > +
> > +6. **Fleet monitoring tools** cannot **automate periodic checks** of
> > filesystem
> > +   health when doing so requires **manual intervention** and
> > downtime.
> > +
> > +7. **Users** can be tricked into **doing things they do not desire**
> > when
> > +   malicious actors **exploit quirks of Unicode** to place
> > misleading names
> > +   in directories.
> hrmm, I guess I'm not immediately extrapolating what things users are
> being tricked into doing, or how ofsck solves this?  Otherwise I might
> drop the last one here, I think the rest of the bullets are plenty of
> motivation.

The doc gets into this later[1], but it's possible to create two entries
within the same directory that have different byte sequences in the name
but render identically in file choosers.  These pathnames:

/home/djwong/Downloads/rustup.sh
/home/djwong/Downloads/rus<zero width space>tup.sh

refer to different files, but a naïve file open dialog will render them
identically as "rustup.sh".  If the first is the Rust installer and the
second name is actually a ransomware payload, I can victimize you by
tricking you into opening the wrong one.

Firefox had a whole CVE over this in 2018:
https://bugzilla.mozilla.org/show_bug.cgi?id=1438025

xfs_scrub is (so far) the only linux filesystem fsck tool that will warn
system administrators about this kind of thing.

See generic/453 and generic/454.

[1] https://djwong.org/docs/xfs-online-fsck-design/#id108

> > +
> > +Given this definition of the problems to be solved and the actors
> > who would
> > +benefit, the proposed solution is a third fsck tool that acts on a
> > running
> > +filesystem.
> > +
> > +This new third program has three components: an in-kernel facility
> > to check
> > +metadata, an in-kernel facility to repair metadata, and a userspace
> > driver
> > +program to drive fsck activity on a live filesystem.
> > +``xfs_scrub`` is the name of the driver program.
> > +The rest of this document presents the goals and use cases of the
> > new fsck
> > +tool, describes its major design points in connection to those
> > goals, and
> > +discusses the similarities and differences with existing tools.
> > +
> > ++-------------------------------------------------------------------
> > -------+
> > +|
> > **Note**:                                                            
> >     |
> > ++-------------------------------------------------------------------
> > -------+
> > +| Throughout this document, the existing offline fsck tool can also
> > be     |
> > +| referred to by its current name
> > "``xfs_repair``".                        |
> > +| The userspace driver program for the new online fsck tool can
> > be         |
> > +| referred to as
> > "``xfs_scrub``".                                          |
> > +| The kernel portion of online fsck that validates metadata is
> > called      |
> > +| "online scrub", and portion of the kernel that fixes metadata is
> > called  |
> > +| "online
> > repair".                                                         |
> > ++-------------------------------------------------------------------
> > -------+

Errr ^^^^ is Evolution doing line wrapping here?

> Hmm, maybe here might be a good spot to move rmap and pptrs?  It's not
> otherwise clear to me what "secondary metadata" is.  If that is what it
> is meant to refer to, I think the reader will more intuitively make the
> connection if those two blurbs appear in the same context.

Ooh, you found a significant gap-- nowhere in this chapter do I actually
define what is primary metadata.  Or secondary metadata.

> > +
> > +Secondary metadata indices enable the reconstruction of parts of a
> > damaged
> > +primary metadata object from secondary information.
> 
> I would take out this blurb...
> > +XFS filesystems shard themselves into multiple primary objects to
> > enable better
> > +performance on highly threaded systems and to contain the blast
> > radius when
> > +problems happen.
> 
> 
> > +The naming hierarchy is broken up into objects known as directories
> > and files;
> > +and the physical space is split into pieces known as allocation
> > groups.
> And add here:
> 
> "This enables better performance on highly threaded systems and helps
> to contain corruptions when they occur."
> 
> I think that reads cleaner

Ok.  Mind if I reword this slightly?  The entire paragraph now reads
like this:

"The naming hierarchy is broken up into objects known as directories and
files and the physical space is split into pieces known as allocation
groups.  Sharding enables better performance on highly parallel systems
and helps to contain the damage when corruptions occur.  The division of
the filesystem into principal objects (allocation groups and inodes)
means that there are ample opportunities to perform targeted checks and
repairs on a subset of the filesystem."

> > +The division of the filesystem into principal objects (allocation
> > groups and
> > +inodes) means that there are ample opportunities to perform targeted
> > checks and
> > +repairs on a subset of the filesystem.
> > +While this is going on, other parts continue processing IO requests.
> > +Even if a piece of filesystem metadata can only be regenerated by
> > scanning the
> > +entire system, the scan can still be done in the background while
> > other file
> > +operations continue.
> > +
> > +In summary, online fsck takes advantage of resource sharding and
> > redundant
> > +metadata to enable targeted checking and repair operations while the
> > system
> > +is running.
> > +This capability will be coupled to automatic system management so
> > that
> > +autonomous self-healing of XFS maximizes service availability.
> > 
> 
> Nits and paraphrases aside, I think this looks pretty good?

Woot.  Thanks for digging in! :)

> Allison
> 
