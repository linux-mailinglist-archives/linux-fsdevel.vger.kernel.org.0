Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5F558BC5B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Aug 2022 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbiHGSaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Aug 2022 14:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiHGSaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F065118A;
        Sun,  7 Aug 2022 11:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E55E6101A;
        Sun,  7 Aug 2022 18:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B4BC433C1;
        Sun,  7 Aug 2022 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897011;
        bh=TNiO9oPPCwjUuuZ+Ez/N1z67SQ1tGrCbmqUoqDs0540=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oh1w1mygybJmrSvHMl+FlQ59mIef7dP1rw6Yft5MvMdArGU9Dt2HQl3V7k9RX3zRT
         FL0bwbphW2i8KVXykwkQlLjPQRbHIyWyTXb+pnff5VDe+Yh4uyKCvrH9n6QbyoFQf3
         K2GJk0hDR8vzZEY08RS0z+yjo2+1TiV8K+O8WQgu9gfBCqtINBkn0eTwq3EiT/neG1
         YKjrJ+2dQ4it+WxHUxUovNfiwNhTBYMOnyEJieBn0xXtcF1/ah142oVj5RHdHmiypz
         dzkjpVL9Mk9HvCl3rW1P94ipF6Da07ZBcrbqiywaW7yt5AGzFSxS9vyFoe5yL9ZBM7
         XbFOC2Cqj84YQ==
Subject: [PATCH 01/14] xfs: document the motivation for online fsck design
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Date:   Sun, 07 Aug 2022 11:30:11 -0700
Message-ID: <165989701112.2495930.5791410693087641932.stgit@magnolia>
In-Reply-To: <165989700514.2495930.13997256907290563223.stgit@magnolia>
References: <165989700514.2495930.13997256907290563223.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Start the first chapter of the online fsck design documentation.
This covers the motivations for creating this in the first place.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 Documentation/filesystems/index.rst                |    1 
 .../filesystems/xfs-online-fsck-design.rst         |  199 ++++++++++++++++++++
 2 files changed, 200 insertions(+)
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
index 000000000000..25717ebb5f80
--- /dev/null
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -0,0 +1,199 @@
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
+  supporting higher level decisionmaking.
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
+A Unix filesystem has three main jobs: to provide a hierarchy of names through
+which application programs can associate arbitrary blobs of data for any
+length of time, to virtualize physical storage media across those names, and
+to retrieve the named data blobs at any time.
+The filesystem check (fsck) tool examines all the metadata in a filesystem
+to look for errors.
+Simple tools only check for obvious corruptions, but the more sophisticated
+ones cross-reference metadata records to look for inconsistencies.
+People do not like losing data, so most fsck tools also contains some ability
+to deal with any problems found.
+As a word of caution -- the primary goal of most Linux fsck tools is to restore
+the filesystem metadata to a consistent state, not to maximize the data
+recovered.
+That precedent will not be challenged here.
+
+Filesystems of the 20th century generally lacked any redundancy in the ondisk
+format, which means that fsck can only respond to errors by erasing files until
+errors are no longer detected.
+System administrators avoid data loss by increasing the number of separate
+storage systems through the creation of backups; and they avoid downtime by
+increasing the redundancy of each storage system through the creation of RAID.
+More recent filesystem designs contain enough redundancy in their metadata that
+it is now possible to regenerate data structures when non-catastrophic errors
+occur; this capability aids both strategies.
+Over the past few years, XFS has added a storage space reverse mapping index to
+make it easy to find which files or metadata objects think they own a
+particular range of storage.
+Efforts are under way to develop a similar reverse mapping index for the naming
+hierarchy, which will involve storing directory parent pointers in each file.
+With these two pieces in place, XFS uses secondary information to perform more
+sophisticated repairs.
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
+1. **User programs** suddenly **lose access** to information in the computer
+   when unexpected shutdowns occur as a result of silent corruptions in the
+   filesystem metadata.
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
+   might suffice.
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
+Secondary metadata indices enable the reconstruction of parts of a damaged
+primary metadata object from secondary information.
+XFS filesystems shard themselves into multiple primary objects to enable better
+performance on highly threaded systems and to contain the blast radius when
+problems happen.
+The naming hierarchy is broken up into objects known as directories and files;
+and the physical space is split into pieces known as allocation groups.
+The division of the filesystem into principal objects (allocation groups and
+inodes) means that there are ample opportunities to perform targeted checks and
+repairs on a subset of the filesystem.
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

