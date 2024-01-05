Return-Path: <linux-fsdevel+bounces-7480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FFB82580A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 17:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9F91F2180D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 16:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE5B31739;
	Fri,  5 Jan 2024 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeOlRihf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713D12E855
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704471821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fe0+JU6CSivbFVNMLw9Ada8Il4xnZLCchtokDQzgYEQ=;
	b=TeOlRihf5jF5WVOOcaCDjeE6YUVWsn1k4LGoCESIpLER1XIaK/WLvVCF3JpgemgWGmoHf5
	dm+vctiEL75SsJYQqaFfHyoIJPIeYy/xScNJF8ljvjqTQoQR5/0xNLHQ0eXGVrMQAkeHIz
	CNhDj1bCQMiWbIV9Z1Xp9mIzESCF1sU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-UetGY8TpOB-Pwhx6L1BDOA-1; Fri, 05 Jan 2024 11:23:38 -0500
X-MC-Unique: UetGY8TpOB-Pwhx6L1BDOA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A15FB83B86E;
	Fri,  5 Jan 2024 16:23:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 73812492BE6;
	Fri,  5 Jan 2024 16:23:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jeffrey Altman <jaltman@auristor.com>,
    Oleg Nesterov <oleg@redhat.com>, linux-afs@lists.infradead.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Improve probe handling, server rotation and RO volume callback handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1303898.1704471815.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jan 2024 16:23:35 +0000
Message-ID: <1303899.1704471815@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Hi Linus,

Could you pull this in the upcoming merge window please?  The majority of
the patches are aimed at fixing and improving the AFS filesystem's rotatio=
n
over server IP addresses, but there are also some fixes from Oleg Nesterov
for the use of read_seqbegin_or_lock().

 (1) Fix fileserver probe handling so that the next round of probes doesn'=
t
     break ongoing server/address rotation by clearing all the probe resul=
t
     tracking.  This could occasionally cause the rotation algorithm to
     drop straight through, give a 'successful' result without actually
     emitting any RPC calls, leaving the reply buffer in an undefined
     state.

     Instead, detach the probe results into a separate struct
     and allocate a new one each time we start probing and update the
     pointer to it.  Probes are also sent in order of address preference t=
o
     try and improve the chance that the preferred one will complete first=
.

 (2) Fix server rotation so that it uses configurable address preferences
     across on the probes that have completed so far than ranking them by
     RTT as the latter doesn't necessarily give the best route.  The
     preference list can be altered by writing into
     /proc/net/afs/addr_prefs.

 (3) Fix the handling of Read-Only (and Backup) volume callbacks as there
     is one per volume, not one per file, so if someone performs a command
     that, say, offlines the volume but doesn't change it, when it comes
     back online we don't spam the server with a status fetch for every
     vnode we're using.  Instead, check the Creation timestamp in the
     VolSync record when prompted by a callback break.

 (4) Handle volume regression (ie. a RW volume being restored from a
     backup) by scrubbing all cache data for that volume.  This is detecte=
d
     from the VolSync creation timestamp.

 (5) Adjust abort handling and abort -> error mapping to match better with
     what other AFS clients do.

 (6) Fix offline and busy volume state handling as they only apply to
     individual server instances and not entire volumes and the rotation
     algorithm should go and look at other servers if available.  Also mak=
e
     it sleep briefly before each retry if all the volume instances are
     unavailable.

Tested-by: Marc Dionne <marc.dionne@auristor.com>

Thanks,
David

Changes
=3D=3D=3D=3D=3D=3D=3D
ver #3)
 - Return an error from afs_d_revalidate() if validation of parent dir
   fails with ERESTARTSYS.
 - afs_update_volume_state() must only update the recorded volume
   expiration time if we obtained a callback record from the server.
 - Actually call afs_update_volume_state() (this was being done in a later
   patch).
ver #2)
 - Drop the first two rxrpc fix patches - one has gone through the net tre=
e
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
 - Use rcu_access_pointer() rather than passing an __rcu pointer directly =
to
   kfree_rcu().

Link: https://lore.kernel.org/r/20231109154004.3317227-1-dhowells@redhat.c=
om/ # v1
Link: https://lore.kernel.org/r/20231213135003.367397-1-dhowells@redhat.co=
m/ # v2

---
The following changes since commit 861deac3b092f37b2c5e6871732f3e11486f708=
2:

  Linux 6.7-rc7 (2023-12-23 16:25:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fix-rotation-20240105

for you to fetch changes up to abcbd3bfbbfe97a8912d0c929d4aa18f50d9bc52:

  afs: trace: Log afs_make_call(), including server address (2024-01-01 16=
:37:27 +0000)

----------------------------------------------------------------
AFS fileserver rotation fix

----------------------------------------------------------------
David Howells (36):
      afs: Remove whitespace before most ')' from the trace header
      afs: Automatically generate trace tag enums
      afs: Add comments on abort handling
      afs: Turn the afs_addr_list address array into an array of structs
      rxrpc, afs: Allow afs to pin rxrpc_peer objects
      afs: Don't skip server addresses for which we didn't get an RTT read=
ing
      afs: Rename addr_list::failed to probe_failed
      afs: Handle the VIO and UAEIO aborts explicitly
      afs: Use op->nr_iterations=3D-1 to indicate to begin fileserver iter=
ation
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
      afs: fix the usage of read_seqbegin_or_lock() in afs_lookup_volume_r=
cu()
      afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()
      afs: use read_seqbegin() in afs_check_validity() and afs_getattr()
      rxrpc_find_service_conn_rcu: fix the usage of read_seqbegin_or_lock(=
)

 fs/afs/Makefile              |   2 +
 fs/afs/addr_list.c           | 224 +++++--------
 fs/afs/addr_prefs.c          | 531 +++++++++++++++++++++++++++++
 fs/afs/afs.h                 |   3 +-
 fs/afs/callback.c            | 141 +++++---
 fs/afs/cell.c                |   5 +-
 fs/afs/cmservice.c           |   5 +-
 fs/afs/dir.c                 |  66 ++--
 fs/afs/dir_silly.c           |   2 +-
 fs/afs/file.c                |  20 +-
 fs/afs/fs_operation.c        |  85 +++--
 fs/afs/fs_probe.c            | 323 ++++++++++--------
 fs/afs/fsclient.c            |  74 +++-
 fs/afs/inode.c               | 204 +----------
 fs/afs/internal.h            | 370 +++++++++++++-------
 fs/afs/main.c                |   1 +
 fs/afs/misc.c                |  10 +-
 fs/afs/proc.c                | 102 +++++-
 fs/afs/rotate.c              | 520 +++++++++++++++++++++--------
 fs/afs/rxrpc.c               | 107 +++---
 fs/afs/server.c              | 135 ++++----
 fs/afs/server_list.c         | 174 ++++++++--
 fs/afs/super.c               |   7 +-
 fs/afs/validation.c          | 473 ++++++++++++++++++++++++++
 fs/afs/vl_alias.c            |  69 +---
 fs/afs/vl_list.c             |  29 +-
 fs/afs/vl_probe.c            |  60 ++--
 fs/afs/vl_rotate.c           | 215 +++++++-----
 fs/afs/vlclient.c            | 143 +++++---
 fs/afs/volume.c              |  61 ++--
 fs/afs/write.c               |   6 +-
 fs/afs/yfsclient.c           |  25 +-
 include/net/af_rxrpc.h       |  15 +-
 include/trace/events/afs.h   | 779 ++++++++++++++++++++++++--------------=
-----
 include/trace/events/rxrpc.h |   3 +
 net/rxrpc/af_rxrpc.c         |  62 +++-
 net/rxrpc/ar-internal.h      |   6 +-
 net/rxrpc/call_object.c      |  17 +-
 net/rxrpc/conn_client.c      |  10 +
 net/rxrpc/conn_service.c     |   3 +-
 net/rxrpc/net_ns.c           |   4 +
 net/rxrpc/peer_object.c      |  58 ++--
 net/rxrpc/proc.c             |  76 +++++
 net/rxrpc/sendmsg.c          |  11 +-
 44 files changed, 3544 insertions(+), 1692 deletions(-)
 create mode 100644 fs/afs/addr_prefs.c
 create mode 100644 fs/afs/validation.c


