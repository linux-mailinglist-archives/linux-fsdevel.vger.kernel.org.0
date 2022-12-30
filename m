Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506AC659CD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 23:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiL3Wa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 17:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiL3WaZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 17:30:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DBC1C90C;
        Fri, 30 Dec 2022 14:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93350B81B91;
        Fri, 30 Dec 2022 22:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4548FC433EF;
        Fri, 30 Dec 2022 22:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672439420;
        bh=6WHLLBEA3HTggMAQ5x0flj6uWfGUrValSykcziBS9pw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eckazOM9EguDTd8fy1j22j5njYc4HinFDb8dQM6f4WIxV1+CTVWiO1yVlVmM0FNnY
         aKgOiSFwnd1HCxUyggGhIEh7nKTrxHB2Zs2XM+O0tBDPreWGjoFL6HJUk7Ije0k9QB
         lzHUqU0qQhw3mjNHvDBZSLeyjvjaVJ3dvcHvcKQ5phs9rvDkZia8fAcWgSMNqZy5da
         TjF+Qvmr9vxCDn/KSQ1uV51qc47+t2BBb+nBZ17s9a73C3ALyQcF3ulAFEPP/Eay6q
         PCXhy/ExFM8Qg8O5IfEaYfFukB9phGgCf47yqmjOZQqauSbWyaVeHCu8Wba9ycTi6w
         dg10MYV2FFBhw==
Subject: [PATCH 04/14] xfs: document the user interface for online fsck
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com, david@fromorbit.com
Date:   Fri, 30 Dec 2022 14:10:52 -0800
Message-ID: <167243825217.682859.14201039734624895373.stgit@magnolia>
In-Reply-To: <167243825144.682859.12802259329489258661.stgit@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../filesystems/xfs-online-fsck-design.rst         |  114 ++++++++++++++++++++
 1 file changed, 114 insertions(+)


diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index d630b6bdbe4a..42e82971e036 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -750,3 +750,117 @@ Proposed patchsets include `general stress testing
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
+run online fsck automatically on weekends.
+The background service configures scrub to run with as little privilege as
+possible, the lowest CPU and IO priority, and in a CPU-constrained single
+threaded mode.
+It is hoped that this minimizes the amount of load generated on the system and
+avoids starving regular workloads.
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
+**Question**: Should the health reporting integrate with the new inotify fs
+error notification system?
+
+**Question**: Would it be helpful for sysadmins to have a daemon to listen for
+corruption notifications and initiate a repair?
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

