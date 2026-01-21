Return-Path: <linux-fsdevel+bounces-74784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLEHJMxzcGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:35:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F16BE521C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B8296A1341
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835C1426D3C;
	Wed, 21 Jan 2026 06:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCDQUGEH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC73A0B20;
	Wed, 21 Jan 2026 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977306; cv=none; b=Tb5i05FHWllNZ1oGzGoboxQSIfIHzkHbIHykWR4foJqjYUOGw2XmuvV7FRL713+Fy1pErQC822lotzKBgzEzjOoavGB3gEjW7ZMiXHsL6p7VLxWa7pmTmqKk/mJWihRvdY9thRUwOh6OJyo5/htoQ6q4fBCX5oBXPuR9QPxCpns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977306; c=relaxed/simple;
	bh=2vTeexCtry65UaJBjUwmRHAhcvCe5/+OjQz3yOvnU1E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYDnNKIH6SqKsUUA2oz6/2XY5DFOlQxTNOr1iBQK+HSspk5V3o4rULme6ijfj0qhrNJKzFnH0EAOAj6mAAveI+taVZ7725SZETF09XDIQC4gBPSJrBLV/8LAguQS2t9kpC1u9khYN7pF8SEAV65pmDKUDWAEP+Pp/FNp05H4uJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCDQUGEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889CEC116D0;
	Wed, 21 Jan 2026 06:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768977305;
	bh=2vTeexCtry65UaJBjUwmRHAhcvCe5/+OjQz3yOvnU1E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZCDQUGEHBxccWHnn2XbFr7IFjhtm+PRcA5/IQzvna/lePh1Pp5WHbpcKRLrpbI/F2
	 h5FezjN9umoijYyRUm0NcjyKFe5VWyNmAZvQ8+/cUPwG+Kr0Q5sYYBYTpvM6zUAJ3e
	 GXh+E/87L638lkFcJCTLqv1ZcmmcogTBbOLybvccM8D+EGt3lM8rL146NJDZoVhnFI
	 Ye3L/sPo8VF/1PC3ZRU3hM7VmTVdi/BffMSx5eLLqKR6eFGWKQQkikXpp80apTxyxS
	 sxo5d6OQP3fzwVO8FlT7qRKUgL5GAiNajxQ5GlDYNEsnQkEBUBPrKSgzWHGr01+9XW
	 T8piEoD1G1+gw==
Date: Tue, 20 Jan 2026 22:35:05 -0800
Subject: [PATCH 01/11] docs: discuss autonomous self healing in the xfs online
 repair design doc
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 hch@lst.de
Message-ID: <176897695043.202109.11463709812609495560.stgit@frogsfrogsfrogs>
In-Reply-To: <176897694953.202109.15171131238404759078.stgit@frogsfrogsfrogs>
References: <176897694953.202109.15171131238404759078.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74784-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: F16BE521C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Darrick J. Wong <djwong@kernel.org>

Update the XFS online repair document to describe the motivation and
design of the autonomous filesystem healing agent known as xfs_healer.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 .../filesystems/xfs/xfs-online-fsck-design.rst     |  153 ++++++++++++++++++++
 1 file changed, 151 insertions(+), 2 deletions(-)


diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
index 3d9233f403dbb1..fd936d1b7a32a2 100644
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
 
@@ -4780,6 +4825,70 @@ Orphaned files are adopted by the orphanage as follows:
 7. If a runtime error happens, call ``xrep_adoption_cancel`` to release all
    resources.
 
+Health Monitoring
+-----------------
+
+A self-correcting filesystem responds to observations of problems by scheduling
+repairs of the affected areas.
+The filesystem must therefore create event objects in response to stimuli
+(metadata corruption, file I/O errors, etc.) and dispatch these events to
+downstream consumers.
+
+However, the decision to translate an adverse metadata health report into a
+repair should be made by userspace, and the actual scheduling done by userspace.
+Some users (e.g. containers) would prefer to fast-fail the container and restart
+it on another node at a previous checkpoint.
+For workloads running in isolation, repairs may be preferable; either way this
+is something the system administrator knows, and not the kernel.
+A userspace agent (``xfs_healer``, described later) will collect events from the
+kernel and dispatch them appropriately.
+
+Exporting health events to userspace requires the creation of a new component,
+known as the health monitor.
+Because the monitor exposes itself to userspace to deliver information, a file
+descriptor is the natural abstraction to use here.
+The health monitor hooks all the relevant sources of metadata health events.
+Upon activation of the hook, a new event object is created and added to a queue.
+When the agent reads from the fd, event objects are pulled from the start of the
+queue and formatted into the user's buffer.
+The events are freed, and the read call returns to userspace to allow the agent
+to perform some work.
+Memory usage is constrained on a per-fd basis to prevent memory exhaustion; if
+an event must be discarded, a special "lost event" event is delivered to the
+agent.
+
+In short, health events are captured, queued, and eventually copied out to
+userspace for dispatching.
+
++----------------------------------------------------------------------+
+| **Sidebar**:                                                         |
++----------------------------------------------------------------------+
+| **Question**: Why use a pseudofile and not use existing notification |
+| methods such as fanotify?                                            |
+|                                                                      |
+| *Answer*: The pseudofile is a private filesystem interface only      |
+| available to processes with the CAP_SYS_ADMIN priviledge and the     |
+| ability to open the root directory of an XFS filesystem.             |
+| Using a pseudofile gives the kernel and ``xfs_healer`` the           |
+| flexibility to expose XFS-specific filesystem details to a special   |
+| userspace daemon without cluttering up fanotify's userspace ABI.     |
+| Normal userpace programs are not expected to subscribe to the XFS    |
+| events in this manner.                                               |
+| Instead, they should subscribe to the generic events provided by     |
+| fanotify.                                                            |
+|                                                                      |
+| The pseudofile can also accept ioctls, which gives the userspace     |
+| ``xfs_healer`` program a programmatic means to validate that prior   |
+| to a repair, its reopened mountpoint is actually the same filesystem |
+| that is being monitored.                                             |
+|                                                                      |
+| Finally, on an implementation level, fsnotify provides rather little |
+| in the way of an actual event queue implementation; it's really more |
+| of an event dispatcher.                                              |
+| This means there's little advantage in terms of the quantity of new  |
+| code added since we still have to write our own queuing discipline!  |
++----------------------------------------------------------------------+
+
 6. Userspace Algorithms and Data Structures
 ===========================================
 
@@ -5071,6 +5180,46 @@ and report what has been lost.
 For media errors in blocks owned by files, parent pointers can be used to
 construct file paths from inode numbers for user-friendly reporting.
 
+Autonomous Self Healing
+-----------------------
+
+When a filesystem mounts, the Linux kernel initiates a fsnotify event
+describing the mount point and the path to the data device.
+A separate ``xfs_healer_start`` systemd service listens for these mount
+events via fanotify, and starts a mountpoint-specific ``xfs_healer``
+service instance.
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
 


