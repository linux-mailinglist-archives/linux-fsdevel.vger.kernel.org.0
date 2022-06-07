Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885AA53F37B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 03:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiFGBsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 21:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiFGBsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:48:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A000F666AC;
        Mon,  6 Jun 2022 18:48:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DF25B81B33;
        Tue,  7 Jun 2022 01:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6406C385A9;
        Tue,  7 Jun 2022 01:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654566528;
        bh=dgwusRndF/29I9yHosCa7MZP9yXww+91poBCY/JBtBU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ppx4O7SoD3hCEyJdqF//gzR5Ml8BMbFMshnt5BZU0F2KIRWwwCHyzCXLaN95FsPmf
         QUhp0/SV5E15iVXEoLx1etjoM35RqSMxIVHPbzKG3BW8V/n/wuLcP2ynR/XJYy5wnq
         40tPFsVuOgkufqkQvPWROTedJtpl0BhYqnGXFJNgBzcTcl72KjC8BJOqmRlKJXD3vf
         JJeP+9Wg/0/jZ7Fan73CLsBAxNPELSBGuyhyekk2KIAdKnhla5HsWL4W4vX13fqW2t
         dkwXmchNotkcYmKxj3ZEJ9TvfNPh2XidvdrwKDiOhMdGr/s/2D+qDM5S7n6VOB6G0c
         JcKE0S1SpglaA==
Subject: [PATCH 1/8] xfs: document the motivation for online fsck design
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Date:   Mon, 06 Jun 2022 18:48:48 -0700
Message-ID: <165456652836.167418.11753978944626721821.stgit@magnolia>
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

Start the first chapter of the online fsck design documentation.
This covers the motivations for creating this in the first place.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 Documentation/filesystems/index.rst                |    1 
 .../filesystems/xfs-online-fsck-design.rst         |  172 ++++++++++++++++++++
 2 files changed, 173 insertions(+)
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
index 000000000000..8768cbf7ab47
--- /dev/null
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -0,0 +1,172 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. _xfs_online_fsck_design:
+
+..
+        Mapping of heading styles within this document:
+        Heading 1 uses "===="
+        Heading 2 uses "----"
+        Heading 3 uses "````"
+        Heading 4 uses "^^^^"
+        Heading 5 uses "~~~~"
+        Heading 6 uses "...."
+
+XFS Online Fsck Design
+======================
+
+This document captures the design of the online filesystem check feature for
+XFS.
+The purpose of this document is threefold:
+First, to help kernel distributors understand exactly what the XFS online fsck
+feature is, and what they should be aware of.
+Second, to help people reading the code to familiarize themselves with the
+relevant concepts and design points before they start digging into the code.
+Third, to assist developers maintaining the system by capturing the reasons
+supporting higher level decisionmaking.
+
+The first section will define what fsck tools are and the motivations for
+writing a new one.
+The second and third sections present a high level overview of how online fsck
+process works and how it will be tested.
+The fourth section discusses the user interface and the intended usage modes of
+the program.
+Sections five and six constitutes the bulk of the discussion wherein specific
+aspects of the design will be presented.
+Specific attention will be paid to parts that are more technically complex; are
+fairly novel for Linux filesystems; or are rather more tightly coupled to the
+rest of the (file)system.
+The final section of this document will capture anticipated future work and
+users of the functionality.
+
+This document is licensed under the terms of the GNU Public License, v2.
+The primary author is Darrick J. Wong.
+
+.. contents::
+
+What is a Filesystem Check?
+===========================
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
+the filesystem metadata to a consistent state, not maximize the data recovered.
+We will not challenge that precedent here.
+
+Filesystems of the 20th century generally lacked any redundancy in the ondisk
+format, which means that fsck can only respond to errors by erasing files until
+errors are gone.
+More recent filesystem designs contain enough redundancy in their metadata that
+it is now possible to regenerate data structures when non-catastrophic errors
+occur.
+Over the past few years, XFS has added a storage space reverse mapping index to
+make it easy to find which files or metadata objects think they own a
+particular range of storage.
+Efforts are under way to develop a similar reverse mapping index for the naming
+hierarchy, which will involve storing directory parent pointers in each file.
+With these two pieces in place, XFS can use that secondary information to
+perform more sophisticated repairs.
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
+inconsistencies in file metadata and directory tree by erasing files as needed
+to eliminate problems.
+All other space usage metadata are rebuilt from the observed file metadata.
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
+2. **System administrators** cannot **schedule** a maintenance window to deal
+   with corruptions if they **lack the means** to assess filesystem health
+   while the filesystem is online.
+
+3. **Users** experience a **total loss of service** during the recovery period
+   after an **unexpected shutdown** occurs.
+
+4. **Fleet monitoring tools** cannot **automate periodic checks** of filesystem
+   health when doing so requires **manual intervention** and downtime.
+
+5. The filesystem is also **completely inaccessible** to **users** if the
+   filesystem is taken offline to **look for problems** proactively.
+
+6. **Data owners** cannot **check the integrity** of their stored data without
+   reading all of it.
+   This may expose them to substantial billing costs when a linear media scan
+   might suffice.
+
+7. **Users** can be tricked into **doing things they do not desire** when
+   malicious actors **exploit quirks of Unicode** to place misleading names
+   in directories.
+
+Having defined the problems we would like to solve and the actors affected by
+the lack of solutions, let us move on to the proposed solution.
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
+| Throughout this document, the existing offline fsck tool may be          |
+| referred to by its current name "``xfs_repair``".  The two kernel pieces |
+| may be referred to as "online scrub" or "online repair", and the         |
+| driver program will be referred to as "``xfs_scrub``".                   |
++--------------------------------------------------------------------------+
+
+Secondary metadata indices give us the opportunity to reconstruct parts of a
+damaged primary metadata object from secondary information.
+XFS filesystems shard themselves into multiple primary objects to enable better
+performance on highly threaded systems and to contain the blast radius when
+problems happen.
+The naming hierarchy is broken up into objects known as directories; and the
+physical space is split into pieces known as allocation groups.
+The division of the filesystem into principal objects means that there are
+ample opportunities to perform targeted checks and repairs on a subset of the
+filesystem.
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

