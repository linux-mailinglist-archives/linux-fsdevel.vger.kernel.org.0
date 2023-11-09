Return-Path: <linux-fsdevel+bounces-2541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4F27E6D8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D9BB20D1B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED2620334;
	Thu,  9 Nov 2023 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUSrROiM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3920327
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:40:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B1B358C
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8brjlfcAMIw//yWNXtytcgIkgS9J4vnjqU05PUI8g5c=;
	b=OUSrROiMYngm3G5p5LHACpluzvPGk1iv/wpRXCr4Fc8eSan1E2q6RDXCpCLUnz/vN002vz
	GyojPIc4RxlLSisy3jozcvVR3yrhKxzsmorV9WPAXpyOw1Hb6AjFl09D4jzCimFMHH5L8X
	cg21I+vfc+3R8r7FVVfvfs9Xy0R7i5E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-fj2ZUaj8O7m6J0Vlu21oUw-1; Thu, 09 Nov 2023 10:40:10 -0500
X-MC-Unique: fj2ZUaj8O7m6J0Vlu21oUw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50E48821AE1;
	Thu,  9 Nov 2023 15:40:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 85858492BE7;
	Thu,  9 Nov 2023 15:40:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/41] afs: Fix probe handling, server rotation and RO volume callback handling
Date: Thu,  9 Nov 2023 15:39:23 +0000
Message-ID: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hi Marc,

Here are a set of patches to make some substantial fixes to the afs
filesystem including:

 (1) Fix fileserver probe handling so that the next round of probes doesn't
     break ongoing server/address rotation by clearing all the probe result
     tracking.  Instead, detach the probe results into a separate struct
     and allocate a new one each time we start probing and update the
     pointer to it.  Probes are also sent in order of address preference to
     try and improve the chance that the preferred one will complete first.

 (2) Fix server rotation so that it uses configurable address preferences
     across on the probes that have completed so far than ranking them by
     RTT as the latter doesn't necessarily give the best route.  The
     preference list can be altered by echoing commands into
     /proc/net/afs/addr_prefs.

 (3) Fix the handling of Read-Only (and Backup) volume callbacks as there
     is one per volume, not one per file, so if someone performs a command
     that, say, offlines the volume but doesn't change it, when it comes
     back online we don't spam the server with a status fetch for every
     vnode we're using.  Instead, check the Creation timestamp in the
     VolSync record when prompted by a callback break.

 (4) Handle volume regression (ie. a RW volume being restored from a
     backup) by scrubbing all cache data for that volume.  This is detected
     from the VolSync creation timestamp.

 (5) Adjust abort handling and abort -> error mapping to match better with
     what other AFS clients do.

 (6) Handle file locking locally on RO volumes rather than trying to get
     them on the server.  Exclusive locks aren't really handled in a RO
     volume.

 (7) Set RO volumes to be RO superblocks.

 (8) Fix offline and busy volume state handling as they only apply to
     individual server instances and not entire volumes and the rotation
     algorithm should go and look at other servers if available.  Also make
     it sleep briefly before each retry if all the volume instances are
     unavailable.

In addition there are a number of small fixes in rxrpc and afs included
here so that those problems don't affect testing.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

---
%(shortlog)s
%(diffstat)s

David Howells (41):
  rxrpc: Fix RTT determination to use PING ACKs as a source
  rxrpc: Fix two connection reaping bugs
  rxrpc: Fix some minor issues with bundle tracing
  afs: Fix afs_server_list to be cleaned up with RCU
  afs: Make error on cell lookup failure consistent with OpenAFS
  afs: Remove whitespace before most ')' from the trace header
  afs: Automatically generate trace tag enums
  afs: Add comments on abort handling
  afs: Turn the afs_addr_list address array into an array of structs
  rxrpc, afs: Allow afs to pin rxrpc_peer objects
  afs: Don't skip server addresses for which we didn't get an RTT
    reading
  afs: Rename addr_list::failed to probe_failed
  afs: Handle the VIO abort explicitly
  afs: Use op->nr_iterations=-1 to indicate to begin fileserver
    iteration
  afs: Return ENOENT if no cell DNS record can be found
  afs: Wrap most op->error accesses with inline funcs
  afs: Don't put afs_call in afs_wait_for_call_to_complete()
  afs: Simplify error handling
  afs: Add a tracepoint for struct afs_addr_list
  afs: Rename some fields
  afs: Use peer + service_id as call address
  afs: Fold the afs_addr_cursor struct in
  rxrpc: Create a procfile to display outstanding clien conn bundles
  afs: Add some more info to /proc/net/afs/servers
  afs: Remove the unimplemented afs_cmp_addr_list()
  afs: Provide a way to configure address priorities
  afs: Mark address lists with configured priorities
  afs: Dispatch fileserver probes in priority order
  afs: Dispatch vlserver probes in priority order
  afs: Keep a record of the current fileserver endpoint state
  afs: Combine the endpoint state bools into a bitmask
  afs: Fix file locking on R/O volumes to operate in local mode
  afs: Mark a superblock for an R/O or Backup volume as SB_RDONLY
  afs: Make it possible to find the volumes that are using a server
  afs: Defer volume record destruction to a workqueue
  afs: Move the vnode/volume validity checking code into its own file
  afs: Apply server breaks to mmap'd files in the call processor
  afs: Parse the VolSync record in the reply of a number of RPC ops
  afs: Overhaul invalidation handling to better support RO volumes
  afs: Fix fileserver rotation
  afs: Fix offline and busy handling

 fs/afs/Makefile              |   2 +
 fs/afs/addr_list.c           | 224 +++++------
 fs/afs/addr_prefs.c          | 531 +++++++++++++++++++++++++
 fs/afs/afs.h                 |   4 +
 fs/afs/callback.c            | 138 ++++---
 fs/afs/cell.c                |   5 +-
 fs/afs/cmservice.c           |   5 +-
 fs/afs/dir.c                 |  55 +--
 fs/afs/dir_silly.c           |   2 +-
 fs/afs/dynroot.c             |   4 +-
 fs/afs/file.c                |  20 +-
 fs/afs/fs_operation.c        |  86 ++--
 fs/afs/fs_probe.c            | 323 ++++++++-------
 fs/afs/fsclient.c            |  56 ++-
 fs/afs/inode.c               | 198 +---------
 fs/afs/internal.h            | 355 +++++++++++------
 fs/afs/main.c                |   1 +
 fs/afs/misc.c                |  10 +-
 fs/afs/proc.c                | 102 ++++-
 fs/afs/rotate.c              | 495 ++++++++++++++++-------
 fs/afs/rxrpc.c               | 107 ++---
 fs/afs/server.c              | 130 +++---
 fs/afs/server_list.c         | 126 +++++-
 fs/afs/super.c               |  11 +-
 fs/afs/validation.c          | 376 ++++++++++++++++++
 fs/afs/vl_alias.c            |  69 +---
 fs/afs/vl_list.c             |  29 +-
 fs/afs/vl_probe.c            |  60 ++-
 fs/afs/vl_rotate.c           | 223 +++++++----
 fs/afs/vlclient.c            | 124 ++++--
 fs/afs/volume.c              |  66 +++-
 fs/afs/write.c               |   6 +-
 fs/afs/yfsclient.c           |   6 +-
 include/net/af_rxrpc.h       |  15 +-
 include/trace/events/afs.h   | 742 +++++++++++++++++++----------------
 include/trace/events/rxrpc.h |   3 +
 net/rxrpc/af_rxrpc.c         |  62 ++-
 net/rxrpc/ar-internal.h      |   6 +-
 net/rxrpc/call_object.c      |  17 +-
 net/rxrpc/conn_client.c      |  17 +-
 net/rxrpc/conn_object.c      |   2 +-
 net/rxrpc/input.c            |   4 +
 net/rxrpc/local_object.c     |   2 +-
 net/rxrpc/net_ns.c           |   4 +
 net/rxrpc/peer_object.c      |  56 ++-
 net/rxrpc/proc.c             |  76 ++++
 net/rxrpc/sendmsg.c          |  11 +-
 47 files changed, 3304 insertions(+), 1662 deletions(-)
 create mode 100644 fs/afs/addr_prefs.c
 create mode 100644 fs/afs/validation.c


