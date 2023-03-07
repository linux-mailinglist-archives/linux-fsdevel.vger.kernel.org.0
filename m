Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA9C6AD3ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCGBcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCGBcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:32:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BD6580EC;
        Mon,  6 Mar 2023 17:31:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F34BB81236;
        Tue,  7 Mar 2023 01:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208F7C433EF;
        Tue,  7 Mar 2023 01:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678152672;
        bh=QNA6Fq/I4/Pai4iLQD0D0UTJEBYKYRz/tNLdcHC+Uhc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E4meN0AuxPe5WXn5uYha4867HJloiNJaEjifoxSuCottvnB11JAhOvZokP9ozdzBI
         9iYTzdMzs3KrEQFkWVKPU6JsVU/OBDBjvVNvMmxemy1r/bP9DvhLyYi4nNDvljS4/6
         KfFvNJts+Y2bg0HajA/qz1yGU1sDZeGkg4K+5TkjCqwh3WCimKLot3wAzGfq2SMguC
         6X00JZsZ/IwN9Fev0FeVC4BDqggQPorAnWBxFGFzF9qPj+vC4jNh/7jqt5/aywo83U
         v7zwshDmRso/eHG1nqI7fd/g7Hr8wg6QtwBPz0AE3rtMxjBm42fSUlErljD38+nqWf
         YKaruCsqzgBJA==
Subject: [PATCH 04/14] xfs: document the user interface for online fsck
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com, david@fromorbit.com
Date:   Mon, 06 Mar 2023 17:31:11 -0800
Message-ID: <167815267168.3750278.8345431907657256338.stgit@magnolia>
In-Reply-To: <167815264897.3750278.15092544376893521026.stgit@magnolia>
References: <167815264897.3750278.15092544376893521026.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 .../filesystems/xfs-online-fsck-design.rst         |  113 ++++++++++++++++++++
 1 file changed, 113 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index ed9b83c4dbf7..1411c09b9677 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -800,3 +800,116 @@ Proposed patchsets include `general stress testing
 <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=race-scrub-and-mount-state-changes>`_
 and the `evolution of existing per-function stress testing
 <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=refactor-scrub-stress>`_.
+
+4. User Interface
+=================
+
+The primary user of online fsck is the system administrator, just like offline
+repair.
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
+The output of a foreground invocation is captured in the system log.
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
+run online fsck automatically on weekends by default.
+The background service configures scrub to run with as little privilege as
+possible, the lowest CPU and IO priority, and in a CPU-constrained single
+threaded mode.
+This can be tuned by the systemd administrator at any time to suit the latency
+and throughput requirements of customer workloads.
+
+The output of the background service is also captured in the system log.
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
+* ``xfs_scrub_all.timer`` on systemd systems
+* ``xfs_scrub_all.cron`` on non-systemd systems
+
+This automatic weekly scan is configured out of the box to perform an
+additional media scan of all file data once per month.
+This is less foolproof than, say, storing file data block checksums, but much
+more performant if application software provides its own integrity checking,
+redundancy can be provided elsewhere above the filesystem, or the storage
+device's integrity guarantees are deemed sufficient.
+
+The systemd unit file definitions have been subjected to a security audit
+(as of systemd 249) to ensure that the xfs_scrub processes have as little
+access to the rest of the system as possible.
+This was performed via ``systemd-analyze security``, after which privileges
+were restricted to the minimum required, sandboxing was set up to the maximal
+extent possible with sandboxing and system call filtering; and access to the
+filesystem tree was restricted to the minimum needed to start the program and
+access the filesystem being scanned.
+The service definition files restrict CPU usage to 80% of one CPU core, and
+apply as nice of a priority to IO and CPU scheduling as possible.
+This measure was taken to minimize delays in the rest of the filesystem.
+No such hardening has been performed for the cron job.
+
+Proposed patchset:
+`Enabling the xfs_scrub background service
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-media-scan-service>`_.
+
+Health Reporting
+----------------
+
+XFS caches a summary of each filesystem's health status in memory.
+The information is updated whenever ``xfs_scrub`` is run, or whenever
+inconsistencies are detected in the filesystem metadata during regular
+operations.
+System administrators should use the ``health`` command of ``xfs_spaceman`` to
+download this information into a human-readable format.
+If problems have been observed, the administrator can schedule a reduced
+service window to run the online repair tool to correct the problem.
+Failing that, the administrator can decide to schedule a maintenance window to
+run the traditional offline repair tool to correct the problem.
+
+**Future Work Question**: Should the health reporting integrate with the new
+inotify fs error notification system?
+Would it be helpful for sysadmins to have a daemon to listen for corruption
+notifications and initiate a repair?
+
+*Answer*: These questions remain unanswered, but should be a part of the
+conversation with early adopters and potential downstream users of XFS.
+
+Proposed patchsets include
+`wiring up health reports to correction returns
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=corruption-health-reports>`_
+and
+`preservation of sickness info during memory reclaim
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=indirect-health-reporting>`_.

