Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EABA53F382
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 03:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiFGBtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 21:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiFGBtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:49:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1B2674F6;
        Mon,  6 Jun 2022 18:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03EE6B81B32;
        Tue,  7 Jun 2022 01:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51D9C385A9;
        Tue,  7 Jun 2022 01:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654566546;
        bh=gnmKBHuJg3I1F7AYS8hB6izDiy9T1/ewzeo6Sx31TGM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lpDZwAWeABIdCsYAiEb6EyxeTARTcnoaV1RuGhgnvt+vo1tVRgQxe4/EQM2i6n3jZ
         SJ1F6D0IqjC5Q5mvW/+hoChnseLG2kDn36ZvXykUQ+lBc/LEyS8xFq19XJaK8L8rNt
         5dxwysTnP11+eJkZ6vtNSCw5i217AZo06wC6UtlnDExxZkvsD/sugjIFkC7IDX/20R
         AwvgwbsSZMU2+E7uHD1ZhHL4d/7fNlb7jORZl9Ldrt7FnJaTQw4ehtRhrFTepGpWrK
         CO2xnBycG+VSDfQkj6O+PvDRm+zxfGPTWYlW2p35E5V9pZsJOrn+YZcO5WAZS3sA0Z
         tHZg0uYfVqR1w==
Subject: [PATCH 4/8] xfs: document the testing plan for online fsck
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Date:   Mon, 06 Jun 2022 18:49:05 -0700
Message-ID: <165456654534.167418.5247534406783316379.stgit@magnolia>
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

Start the fourth chapter of the online fsck design documentation, which
discusses the user interface and the background scrubbing service.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 .../filesystems/xfs-online-fsck-design.rst         |  105 ++++++++++++++++++++
 1 file changed, 105 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index 536698b138b8..bdb4bdda3180 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -712,3 +712,108 @@ and the `evolution of existing per-function stress testing
 <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=refactor-scrub-stress>`_.
 Each kernel patchset adding an online repair function will use the same branch
 name across the kernel, xfsprogs, and fstests git repos.
+
+User Interface
+==============
+
+Like offline fsck, the primary user of online fsck should be the system
+administrator.
+Online fsck presents two modes of operation to administrators:
+A foreground CLI process for online fsck on demand, and a background service
+that performs autonomous checking and repair.
+
+Checking on Demand
+------------------
+
+For administrators who want the absolute freshest information about the
+metadata in a filesystem, ``xfs_scrub`` can be run as a foreground process on
+a command line.
+The program checks every piece of metadata in the filesystem while the
+administrator waits for the results to be reported, just like the existing
+``xfs_repair`` tool.
+Both tools share a ``-n`` option to perform a read-only scan, and a ``-v``
+option to increase the verbosity of the information reported.
+
+A new feature of ``xfs_scrub`` is the ``-x`` option, which employs the error
+correction capabilities of the hardware to check data file contents.
+The media scan is not enabled by default because it may dramatically increase
+program runtime and consume a lot of bandwidth on older storage hardware.
+
+The output of a foreground invocation will be captured in the system log.
+
+The ``xfs_scrub_all`` program walks the list of mounted filesystems and
+initiates ``xfs_scrub`` for each of them in parallel.
+It serializes scans for any filesystems that resolve to the same top level
+kernel block device to prevent resource overconsumption.
+
+Background Service
+------------------
+
+To reduce the workload of system administrators, the ``xfs_scrub`` package
+provides a suite of `systemd <https://systemd.io/>`_ timers and services that
+run online fsck automatically on weekends.
+The background service configures scrub to run with as little privilege as
+possible (which is quite a lot), the lowest IO priority, and in a single
+threaded mode to minimize the amount of load generated on the system to avoid
+starving regular workloads.
+
+The output of the background service will also be captured in the system log.
+If desired, reports of failures (either due to inconsistencies or mere runtime
+errors) can be emailed automatically by setting the ``EMAIL_ADDR`` environment
+variable in the following service files:
+
+* ``xfs_scrub_fail@.service``
+* ``xfs_scrub_media_fail@.service``
+* ``xfs_scrub_all_fail.service``
+
+The decision to enable the background scan is left to the system administrator.
+This can be done by enabling either of the following services:
+
+* ``xfs_scrub_all.timer`` on systemd systems to enable a weekly scan of the
+  metadata of all mounted filesystems.
+* ``xfs_scrub_all.cron`` can be used on non-systemd systems to schedule a
+  weekly scan of all mounted filesystems.
+
+The automatic weekly scan is configured out of the box to perform an additional
+media scan of all file data once per month.
+This is less foolproof than, say, storing file data block checksums, but much
+more performant if application software provides its own integrity checking,
+redundancy can be provided elsewhere above the filesystem, or the storage
+device's integrity guarantees are deemed sufficient.
+
+**Question**: Are we using systemd unit directives to their maximum advantage
+to isolate the scrub process and control its resource usage?
+**Question**: Should we document how system administrators can modify the
+xfs_scrub@ service file to contain the QoS hit?
+Or do we assume admins are familiar with existing systemd documentation?
+Where do we even document that?
+
+Proposed patchsets include
+`enabling the background service
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-media-scan-service>`_.
+
+Health Reporting
+----------------
+
+XFS caches a summary of each filesystem's health status in memory.
+The information is updated whenever ``xfs_scrub`` is run, as well as whenever
+inconsistencies are detected in the filesystem metadata.
+System administrators can use the ``health`` command of ``xfs_spaceman`` to
+download this information into a human-readable format.
+If problems have been observed, the administrator can decide to schedule a
+reduced service window in which to run the online repair tool to correct the
+problem.
+Failing that, the administrator can decide to schedule a maintenance window to
+run the traditional offline repair tool to correct the problem.
+
+**Question**: Should the health reporting integrate with the new inotify fs
+error notification system?
+**Question**: Should we write a daemon to listen for corruption notifications
+and initiate a repair?
+
+Proposed patchsets include
+`wiring up health reports to correction returns
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=corruption-health-reports>`_
+and
+`preservation of sickness info during memory reclaim
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=indirect-health-reporting>`_.

