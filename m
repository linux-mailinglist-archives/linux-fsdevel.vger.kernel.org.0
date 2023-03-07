Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044096AD3E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCGBbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCGBbk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:31:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC6B5CC13;
        Mon,  6 Mar 2023 17:30:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE19660F52;
        Tue,  7 Mar 2023 01:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466EAC433D2;
        Tue,  7 Mar 2023 01:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678152655;
        bh=J8/Z2WspjRBA8LnpEWXQAnRQIY5dE3KDSEIxVA+qI1g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=A/I5ljM2Z6WhnzaPep/K1ranWq/oqMSQ1lHzHSeckbrS9D8zLWNURtlPLNM+4f4rZ
         xG/bzgZqF2w4mdu7ZG6hR76Di1RoJhgxMHN4nHYBzZqm+HbQ2kGDKb3CfFvDeig+nh
         O4rj+Y/WCvYK7BnNanTOqiZFN0kUILh1xUnkKxI1sJ+zvw/2DD8L8+alElZWsIlPsD
         B98ZQMy9l7oqMv/kMZTEuWtYq/D2zlY1BxgbyZG5TAbntUXMmQD13gLmkNa0KE7Dl+
         Vw10Fv9gApteL9D1Rb6HVq2JkgHKPXt2+cCWtA1GqvltXKgH4twIbtmP5mHZEhzL9Q
         3TkIG3E/3q6Xw==
Subject: [PATCH 01/14] xfs: document the motivation for online fsck design
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com, david@fromorbit.com
Date:   Mon, 06 Mar 2023 17:30:54 -0800
Message-ID: <167815265473.3750278.16374124130987774203.stgit@magnolia>
In-Reply-To: <167815264897.3750278.15092544376893521026.stgit@magnolia>
References: <167815264897.3750278.15092544376893521026.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Start the first chapter of the online fsck design documentation.
This covers the motivations for creating this in the first place.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 Documentation/filesystems/index.rst                |    1 
 .../filesystems/xfs-online-fsck-design.rst         |  212 ++++++++++++++++++++
 2 files changed, 213 insertions(+)
 create mode 100644 Documentation/filesystems/xfs-online-fsck-design.rst


diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index bee63d42e5ec..fbb2b5ada95b 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -123,4 +123,5 @@ Documentation for filesystem implementations.
    vfat
    xfs-delayed-logging-design
    xfs-self-describing-metadata
+   xfs-online-fsck-design
    zonefs
diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
new file mode 100644
index 000000000000..07c7b4cde18f
--- /dev/null
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -0,0 +1,212 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. _xfs_online_fsck_design:
+
+..
+        Mapping of heading styles within this document:
+        Heading 1 uses "====" above and below
+        Heading 2 uses "===="
+        Heading 3 uses "----"
+        Heading 4 uses "````"
+        Heading 5 uses "^^^^"
+        Heading 6 uses "~~~~"
+        Heading 7 uses "...."
+
+        Sections are manually numbered because apparently that's what everyone
+        does in the kernel.
+
+======================
+XFS Online Fsck Design
+======================
+
+This document captures the design of the online filesystem check feature for
+XFS.
+The purpose of this document is threefold:
+
+- To help kernel distributors understand exactly what the XFS online fsck
+  feature is, and issues about which they should be aware.
+
+- To help people reading the code to familiarize themselves with the relevant
+  concepts and design points before they start digging into the code.
+
+- To help developers maintaining the system by capturing the reasons
+  supporting higher level decision making.
+
+As the online fsck code is merged, the links in this document to topic branches
+will be replaced with links to code.
+
+This document is licensed under the terms of the GNU Public License, v2.
+The primary author is Darrick J. Wong.
+
+This design document is split into seven parts.
+Part 1 defines what fsck tools are and the motivations for writing a new one.
+Parts 2 and 3 present a high level overview of how online fsck process works
+and how it is tested to ensure correct functionality.
+Part 4 discusses the user interface and the intended usage modes of the new
+program.
+Parts 5 and 6 show off the high level components and how they fit together, and
+then present case studies of how each repair function actually works.
+Part 7 sums up what has been discussed so far and speculates about what else
+might be built atop online fsck.
+
+.. contents:: Table of Contents
+   :local:
+
+1. What is a Filesystem Check?
+==============================
+
+A Unix filesystem has four main responsibilities:
+
+- Provide a hierarchy of names through which application programs can associate
+  arbitrary blobs of data for any length of time,
+
+- Virtualize physical storage media across those names, and
+
+- Retrieve the named data blobs at any time.
+
+- Examine resource usage.
+
+Metadata directly supporting these functions (e.g. files, directories, space
+mappings) are sometimes called primary metadata.
+Secondary metadata (e.g. reverse mapping and directory parent pointers) support
+operations internal to the filesystem, such as internal consistency checking
+and reorganization.
+Summary metadata, as the name implies, condense information contained in
+primary metadata for performance reasons.
+
+The filesystem check (fsck) tool examines all the metadata in a filesystem
+to look for errors.
+In addition to looking for obvious metadata corruptions, fsck also
+cross-references different types of metadata records with each other to look
+for inconsistencies.
+People do not like losing data, so most fsck tools also contains some ability
+to correct any problems found.
+As a word of caution -- the primary goal of most Linux fsck tools is to restore
+the filesystem metadata to a consistent state, not to maximize the data
+recovered.
+That precedent will not be challenged here.
+
+Filesystems of the 20th century generally lacked any redundancy in the ondisk
+format, which means that fsck can only respond to errors by erasing files until
+errors are no longer detected.
+More recent filesystem designs contain enough redundancy in their metadata that
+it is now possible to regenerate data structures when non-catastrophic errors
+occur; this capability aids both strategies.
+
++--------------------------------------------------------------------------+
+| **Note**:                                                                |
++--------------------------------------------------------------------------+
+| System administrators avoid data loss by increasing the number of        |
+| separate storage systems through the creation of backups; and they avoid |
+| downtime by increasing the redundancy of each storage system through the |
+| creation of RAID arrays.                                                 |
+| fsck tools address only the first problem.                               |
++--------------------------------------------------------------------------+
+
+TLDR; Show Me the Code!
+-----------------------
+
+Code is posted to the kernel.org git trees as follows:
+`kernel changes <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-symlink>`_,
+`userspace changes <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-media-scan-service>`_, and
+`QA test changes <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=repair-dirs>`_.
+Each kernel patchset adding an online repair function will use the same branch
+name across the kernel, xfsprogs, and fstests git repos.
+
+Existing Tools
+--------------
+
+The online fsck tool described here will be the third tool in the history of
+XFS (on Linux) to check and repair filesystems.
+Two programs precede it:
+
+The first program, ``xfs_check``, was created as part of the XFS debugger
+(``xfs_db``) and can only be used with unmounted filesystems.
+It walks all metadata in the filesystem looking for inconsistencies in the
+metadata, though it lacks any ability to repair what it finds.
+Due to its high memory requirements and inability to repair things, this
+program is now deprecated and will not be discussed further.
+
+The second program, ``xfs_repair``, was created to be faster and more robust
+than the first program.
+Like its predecessor, it can only be used with unmounted filesystems.
+It uses extent-based in-memory data structures to reduce memory consumption,
+and tries to schedule readahead IO appropriately to reduce I/O waiting time
+while it scans the metadata of the entire filesystem.
+The most important feature of this tool is its ability to respond to
+inconsistencies in file metadata and directory tree by erasing things as needed
+to eliminate problems.
+Space usage metadata are rebuilt from the observed file metadata.
+
+Problem Statement
+-----------------
+
+The current XFS tools leave several problems unsolved:
+
+1. **User programs** suddenly **lose access** to the filesystem when unexpected
+   shutdowns occur as a result of silent corruptions in the metadata.
+   These occur **unpredictably** and often without warning.
+
+2. **Users** experience a **total loss of service** during the recovery period
+   after an **unexpected shutdown** occurs.
+
+3. **Users** experience a **total loss of service** if the filesystem is taken
+   offline to **look for problems** proactively.
+
+4. **Data owners** cannot **check the integrity** of their stored data without
+   reading all of it.
+   This may expose them to substantial billing costs when a linear media scan
+   performed by the storage system administrator might suffice.
+
+5. **System administrators** cannot **schedule** a maintenance window to deal
+   with corruptions if they **lack the means** to assess filesystem health
+   while the filesystem is online.
+
+6. **Fleet monitoring tools** cannot **automate periodic checks** of filesystem
+   health when doing so requires **manual intervention** and downtime.
+
+7. **Users** can be tricked into **doing things they do not desire** when
+   malicious actors **exploit quirks of Unicode** to place misleading names
+   in directories.
+
+Given this definition of the problems to be solved and the actors who would
+benefit, the proposed solution is a third fsck tool that acts on a running
+filesystem.
+
+This new third program has three components: an in-kernel facility to check
+metadata, an in-kernel facility to repair metadata, and a userspace driver
+program to drive fsck activity on a live filesystem.
+``xfs_scrub`` is the name of the driver program.
+The rest of this document presents the goals and use cases of the new fsck
+tool, describes its major design points in connection to those goals, and
+discusses the similarities and differences with existing tools.
+
++--------------------------------------------------------------------------+
+| **Note**:                                                                |
++--------------------------------------------------------------------------+
+| Throughout this document, the existing offline fsck tool can also be     |
+| referred to by its current name "``xfs_repair``".                        |
+| The userspace driver program for the new online fsck tool can be         |
+| referred to as "``xfs_scrub``".                                          |
+| The kernel portion of online fsck that validates metadata is called      |
+| "online scrub", and portion of the kernel that fixes metadata is called  |
+| "online repair".                                                         |
++--------------------------------------------------------------------------+
+
+The naming hierarchy is broken up into objects known as directories and files
+and the physical space is split into pieces known as allocation groups.
+Sharding enables better performance on highly parallel systems and helps to
+contain the damage when corruptions occur.
+The division of the filesystem into principal objects (allocation groups and
+inodes) means that there are ample opportunities to perform targeted checks and
+repairs on a subset of the filesystem.
+
+While this is going on, other parts continue processing IO requests.
+Even if a piece of filesystem metadata can only be regenerated by scanning the
+entire system, the scan can still be done in the background while other file
+operations continue.
+
+In summary, online fsck takes advantage of resource sharding and redundant
+metadata to enable targeted checking and repair operations while the system
+is running.
+This capability will be coupled to automatic system management so that
+autonomous self-healing of XFS maximizes service availability.

