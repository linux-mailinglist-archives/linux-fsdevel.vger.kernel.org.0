Return-Path: <linux-fsdevel+bounces-65248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7774BFEA45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8DC1A0602D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70DC12E1E9;
	Thu, 23 Oct 2025 00:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq1N7aOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158168528E;
	Thu, 23 Oct 2025 00:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177670; cv=none; b=rJHZerXl4GzsFh8cOUo0T2UCarUkKvEGT7z1hjS+LlTfZB2gXvYIfaQQmCLJVNjR4CJYTzrznXkOPT0orRN2aJHpUjObTNiV+LN3UgB50VFqGhM80jzZBQ9fFsQCTWmQJIZd/G/ZSw6A2v+a8mRzj5SOK2d0/UeAXmF1JIwI/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177670; c=relaxed/simple;
	bh=lZWtOjaOjnEN/kAIaVImEygDiKMFnywthMdagDcMy/k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNFG623p5f/ircW9AY+ZVVzw0FVto1TW6D/Dy/m9cAyeseEEOVZGPq9SjIlEkYX7UYOyCAOv3uWcLKe0NI85+DRirc2c/4lX/4LFSsx+QbAr6ReORcY+cFdky3TPSXEhkUJCwVEVIQyjFA8LsDS4mqavf81DIRHmqM57/PT8Clg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq1N7aOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838F9C4CEE7;
	Thu, 23 Oct 2025 00:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177667;
	bh=lZWtOjaOjnEN/kAIaVImEygDiKMFnywthMdagDcMy/k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Lq1N7aOSsvBR9KZS9GH1J+kLb1qz+KOhP/QZ3YOdqjyuCI00CB6J7eKEd69LvAv2+
	 ho1Bcn/Gd2LPd4Ml7ZFsDTdBlP6YYGHeRKqgk7pvIJfb16CD+j/5iu7gv8ChTvXF2e
	 hhiJ360csWY4QueBDqGxTbEkssnZu69u0nBEJNpqkJfkH237GlN2KvR9Gb4QsWGx63
	 ZA5b7uMg2pWXzfzEaWHa2/25K0J/0lj5ZzNkTC+utfzWjkUHs35wD5Lw68SbzmxdiH
	 Cor36UsyyHBGnpapbb+enq3VqIQ5NOffnyobbzkxMW5bv5FSryzv9HRJKG5v67Lk63
	 WgSyemZcNyCzQ==
Date: Wed, 22 Oct 2025 17:01:07 -0700
Subject: [PATCH 02/19] docs: discuss autonomous self healing in the xfs online
 repair design doc
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744541.1025409.747197958715254738.stgit@frogsfrogsfrogs>
In-Reply-To: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
References: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Update the XFS online repair document to describe the motivation and
design of the autonomous filesystem healing agent known as xfs_healer.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 .../filesystems/xfs/xfs-online-fsck-design.rst     |  102 ++++++++++++++++++++
 1 file changed, 100 insertions(+), 2 deletions(-)


diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
index 189d1f5f40788d..bdbf338a9c9f0c 100644
--- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
@@ -166,9 +166,12 @@ The current XFS tools leave several problems unsolved:
    malicious actors **exploit quirks of Unicode** to place misleading names
    in directories.
 
+8. **Site Reliability and Support Engineers** would like to reduce the
+   frequency of incidents requiring **manual intervention**.
+
 Given this definition of the problems to be solved and the actors who would
 benefit, the proposed solution is a third fsck tool that acts on a running
-filesystem.
+filesystem, and an autononmous agent that fixes problems as they arise.
 
 This new third program has three components: an in-kernel facility to check
 metadata, an in-kernel facility to repair metadata, and a userspace driver
@@ -203,6 +206,13 @@ Even if a piece of filesystem metadata can only be regenerated by scanning the
 entire system, the scan can still be done in the background while other file
 operations continue.
 
+The autonomous self healing agent should listen for metadata health impact
+reports coming from the kernel and automatically schedule repairs for the
+damaged metadata.
+If the required repairs are larger in scope than a single metadata structure,
+``xfs_scrub`` should be invoked to perform a full analysis.
+``xfs_healer`` is the name of this program.
+
 In summary, online fsck takes advantage of resource sharding and redundant
 metadata to enable targeted checking and repair operations while the system
 is running.
@@ -850,11 +860,16 @@ variable in the following service files:
 * ``xfs_scrub_all_fail.service``
 
 The decision to enable the background scan is left to the system administrator.
-This can be done by enabling either of the following services:
+This can be done system-wide by enabling either of the following services:
 
 * ``xfs_scrub_all.timer`` on systemd systems
 * ``xfs_scrub_all.cron`` on non-systemd systems
 
+To enable online repair for specific filesystems, the ``autofsck``
+filesystem property should be set to ``repair``.
+To enable only scanning, the property should be set to ``check``.
+To disable online fsck entirely, the property should be set to ``none``.
+
 This automatic weekly scan is configured out of the box to perform an
 additional media scan of all file data once per month.
 This is less foolproof than, say, storing file data block checksums, but much
@@ -897,6 +912,36 @@ notifications and initiate a repair?
 *Answer*: These questions remain unanswered, but should be a part of the
 conversation with early adopters and potential downstream users of XFS.
 
+Autonomous Self Healing
+-----------------------
+
+The autonomous self healing agent is a background system service that starts
+when the filesystem is mounted and runs until unmount.
+When starting up, the agent opens a special pseudofile under the specific
+mount.
+When the filesystem generates new adverse health events, the events will be
+made available for reading via the special pseudofile.
+The events need not be limited to metadata concerns; they can also reflect
+events outside of the filesystem's direct control such as file I/O errors.
+
+The agent reads these events in a loop and responds to the events
+appropriately.
+For a single trouble report about metadata, the agent initiates a targeted
+repair of the specific structure.
+If that repair fails or the agent observes too many metadata trouble reports
+over a short interval, it should then initiate a full scan of the filesystem
+via the ``xfs_scrub`` service.
+
+The decision to enable the background scan is left to the system administrator.
+This can be done system-wide by enabling the following services:
+
+* ``xfs_healer@.service`` on systemd systems
+
+To enable autonomous healing for specific filesystems, the ``autofsck``
+filesystem property should be set to ``repair``.
+To disable self healing, the property should be set to ``check``,
+``optimize``, or ``none``.
+
 5. Kernel Algorithms and Data Structures
 ========================================
 
@@ -5071,6 +5116,59 @@ and report what has been lost.
 For media errors in blocks owned by files, parent pointers can be used to
 construct file paths from inode numbers for user-friendly reporting.
 
+Autonomous Self Healing
+-----------------------
+
+When a filesystem mounts, the Linux kernel initiates a uevent describing the
+mount and the path to the data device.
+A udev rule determines the initial mountpoint from the data device path
+and starts a mount-specific ``xfs_healer`` service instance.
+The ``xfs_healer`` service opens the mountpoint and issues the
+XFS_IOC_HEALTH_MONITOR ioctl to open a special health monitoring file.
+After that is set up, the mountpoint is closed to avoid pinning the mount.
+
+The health monitoring file hooks certain points of the filesystem so that it
+may receive events about metadata health, filesystem shutdowns, media errors,
+file I/O errors, and unmounting of the filesystem.
+Events are queued up for each health monitor file and encoded into a
+``struct xfs_health_monitor_event`` object when the agent calls ``read()`` on
+the file.
+All health events are dispatched to a background threadpool to reduce stalls
+in the main event loop.
+Events can be logged into the system log for further analysis.
+
+For metadata health events, the specific details are used to construct a call
+to the scrub ioctl.
+The filesystem mountpoint is reopened, and the kernel is called.
+If events are lost or the repairs fail, a full scan will be initiated by
+starting up an ``xfs_scrub@.service`` for the given mountpoint.
+
+A filesystem shutdown causes all future repair work to cease, and an unmount
+causes the agent to exit.
+
+**Question**: Why use a pseudofile and not use existing notification methods?
+
+*Answer*: The pseudofile is a private filesystem interface only available to
+processes with the CAP_SYS_ADMIN priviledge.
+Being private gives the kernel and ``xfs_healer`` the flexibility to change
+or update the event format in the future without worrying about backwards
+compatibility.
+Using existing notifications means that the event format would be frozen in
+public UAPI forever.
+
+The pseudofile can also accept ioctls, which gives ``xfs_healer`` a solid
+means to validate that prior to a repair, its reopened mountpoint is actually
+the same filesystem that is being monitored.
+
+**Future Work Question**: Should the healer daemon also register a dbus
+listener and publish events there?
+
+*Answer*: This is unclear -- if there's a demand for system monitoring daemons
+to consume this information and make decisions, then yes, this could be wired
+up in ``xfs_healer``.
+On the other hand, systemd is in the middle of a transition to varlink, so
+it makes more sense to wait and see what happens.
+
 7. Conclusion and Future Work
 =============================
 


