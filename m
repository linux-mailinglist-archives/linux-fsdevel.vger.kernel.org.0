Return-Path: <linux-fsdevel+bounces-5858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D79881135F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234A51F2177C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A475E2DF95;
	Wed, 13 Dec 2023 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWHgec6X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5984EDD
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6fbfXkkFVGTCRrg97l9L+HJSV/Mp1xytzAMKvjGB/6w=;
	b=iWHgec6Xgmo78yunVM6UMJ/WpsXA6iVk12j2d6CTWaFzCInLZowbp3Y6YcGRKBmw/O0oPC
	xeQBt7Jq4Kp+4+PdT/3+Umi9gfLlauBeGl5OaA+fJtJfxufiGKxrTIVhU84LEATTl4wiNB
	CZWzVVbwkjq+Wt77exphmsyJEhrM3g4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-FQDaSJ26NzmPtK-4ZLZhlA-1; Wed,
 13 Dec 2023 08:50:07 -0500
X-MC-Unique: FQDaSJ26NzmPtK-4ZLZhlA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D57DA1C05AF8;
	Wed, 13 Dec 2023 13:50:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 16478492BE6;
	Wed, 13 Dec 2023 13:50:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/40] afs: Fix probe handling, server rotation and RO volume callback handling
Date: Wed, 13 Dec 2023 13:49:22 +0000
Message-ID: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Hi Marc,

Here are a set of patches to make some substantial fixes to the afs
filesystem including:

 (1) Fix fileserver probe handling so that the next round of probes doesn't
     break ongoing server/address rotation by clearing all the probe result
     tracking.  This could occasionally cause the rotation algorithm to
     drop straight through, give a 'successful' result without actually
     emitting any RPC calls, leaving the reply buffer in an undefined
     state.

     Instead, detach the probe results into a separate struct
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

 (6) Fix offline and busy volume state handling as they only apply to
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

Changes
=======
ver #2)
 - Drop the first two rxrpc fix patches - one has gone through the net tree
   and the other needs a bit more work, but neither is necessary for this
   series.
 - Add a couple of missing symbol exports.
 - Treat UAEIO as VIO too.
 - Switch to using atomic64_t for creation & update times because 64-bit
   cmpxchg isn't available on some 32-bit arches.
 - Some patches went upstream separately as fixes (commit
   5b7ad877e4d81f8904ce83982b1ba5c6e83deccb).
 - Use atomic64_t for vnode->cb_expires_at() as 64-bit xchg() is not
   univerally available.
 - Use rcu_access_pointer() rather than passing an __rcu pointer directly to
   kfree_rcu().

Link: https://lore.kernel.org/r/20231109154004.3317227-1-dhowells@redhat.com/ # v1
---
%(shortlog)s
%(diffstat)s

David Howells (36):
  afs: Remove whitespace before most ')' from the trace header
  afs: Automatically generate trace tag enums
  afs: Add comments on abort handling
  afs: Turn the afs_addr_list address array into an array of structs
  rxrpc, afs: Allow afs to pin rxrpc_peer objects
  afs: Don't skip server addresses for which we didn't get an RTT
    reading
  afs: Rename addr_list::failed to probe_failed
  afs: Handle the VIO and UAEIO aborts explicitly
  afs: Use op->nr_iterations=-1 to indicate to begin fileserver
    iteration
  afs: Wrap most op->error accesses with inline funcs
  afs: Don't put afs_call in afs_wait_for_call_to_complete()
  afs: Simplify error handling
  afs: Add a tracepoint for struct afs_addr_list
  afs: Rename some fields
  afs: Use peer + service_id as call address
  afs: Fold the afs_addr_cursor struct in
  rxrpc: Create a procfile to display outstanding client conn bundles
  afs: Add some more info to /proc/net/afs/servers
  afs: Remove the unimplemented afs_cmp_addr_list()
  afs: Provide a way to configure address priorities
  afs: Mark address lists with configured priorities
  afs: Dispatch fileserver probes in priority order
  afs: Dispatch vlserver probes in priority order
  afs: Keep a record of the current fileserver endpoint state
  afs: Combine the endpoint state bools into a bitmask
  afs: Make it possible to find the volumes that are using a server
  afs: Defer volume record destruction to a workqueue
  afs: Move the vnode/volume validity checking code into its own file
  afs: Apply server breaks to mmap'd files in the call processor
  afs: Fix comment in afs_do_lookup()
  afs: Don't leave DONTUSE/NEWREPSITE servers out of server list
  afs: Parse the VolSync record in the reply of a number of RPC ops
  afs: Overhaul invalidation handling to better support RO volumes
  afs: Fix fileserver rotation
  afs: Fix offline and busy message emission
  afs: trace: Log afs_make_call(), including server address

Oleg Nesterov (4):
  afs: fix the usage of read_seqbegin_or_lock() in
    afs_lookup_volume_rcu()
  afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()
  afs: use read_seqbegin() in afs_check_validity() and afs_getattr()
  rxrpc_find_service_conn_rcu: fix the usage of read_seqbegin_or_lock()

 fs/afs/Makefile              |   2 +
 fs/afs/addr_list.c           | 224 +++++-----
 fs/afs/addr_prefs.c          | 531 ++++++++++++++++++++++++
 fs/afs/afs.h                 |   3 +-
 fs/afs/callback.c            | 141 ++++---
 fs/afs/cell.c                |   5 +-
 fs/afs/cmservice.c           |   5 +-
 fs/afs/dir.c                 |  59 +--
 fs/afs/dir_silly.c           |   2 +-
 fs/afs/file.c                |  20 +-
 fs/afs/fs_operation.c        |  85 ++--
 fs/afs/fs_probe.c            | 323 +++++++++------
 fs/afs/fsclient.c            |  74 +++-
 fs/afs/inode.c               | 204 +--------
 fs/afs/internal.h            | 370 +++++++++++------
 fs/afs/main.c                |   1 +
 fs/afs/misc.c                |  10 +-
 fs/afs/proc.c                | 102 ++++-
 fs/afs/rotate.c              | 520 ++++++++++++++++-------
 fs/afs/rxrpc.c               | 107 ++---
 fs/afs/server.c              | 135 +++---
 fs/afs/server_list.c         | 174 ++++++--
 fs/afs/super.c               |   7 +-
 fs/afs/validation.c          | 467 +++++++++++++++++++++
 fs/afs/vl_alias.c            |  69 +---
 fs/afs/vl_list.c             |  29 +-
 fs/afs/vl_probe.c            |  60 ++-
 fs/afs/vl_rotate.c           | 215 ++++++----
 fs/afs/vlclient.c            | 143 ++++---
 fs/afs/volume.c              |  61 ++-
 fs/afs/write.c               |   6 +-
 fs/afs/yfsclient.c           |  25 +-
 include/net/af_rxrpc.h       |  15 +-
 include/trace/events/afs.h   | 779 ++++++++++++++++++++---------------
 include/trace/events/rxrpc.h |   3 +
 net/rxrpc/af_rxrpc.c         |  62 ++-
 net/rxrpc/ar-internal.h      |   6 +-
 net/rxrpc/call_object.c      |  17 +-
 net/rxrpc/conn_client.c      |  10 +
 net/rxrpc/conn_service.c     |   3 +-
 net/rxrpc/net_ns.c           |   4 +
 net/rxrpc/peer_object.c      |  58 ++-
 net/rxrpc/proc.c             |  76 ++++
 net/rxrpc/sendmsg.c          |  11 +-
 44 files changed, 3532 insertions(+), 1691 deletions(-)
 create mode 100644 fs/afs/addr_prefs.c
 create mode 100644 fs/afs/validation.c


