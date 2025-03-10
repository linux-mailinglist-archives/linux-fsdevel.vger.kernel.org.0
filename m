Return-Path: <linux-fsdevel+bounces-43575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33205A58FEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BD916BD34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521AB225407;
	Mon, 10 Mar 2025 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fy3cAe1t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFE223322
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599744; cv=none; b=B8hckmlN6eugc/ghD3dR40n48jomQPAT477250b+KnVHkt3yXnsfsF/c3WfD1xEHnjFJ+MpDsC3CU9VkCLGerJRyKZNhekYwxZlURAsSuVbnWEuppB73imE/WOoN4BXrBMqkcCh07vp4b/JOstoRLyIKViKuafAvd1V4nNT17Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599744; c=relaxed/simple;
	bh=9NUbkeHFJVXSvpJC6cffvGAry+3XZDrlAYjzGGwtup4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SS3RHI0khzhQAq6XuF5HSVGIe5tEIUkPH9U5ytJXfEPuW5QSxvSq5V0ncT39DSMIGpFL1LwXXG8t7kuO7iMqCqtpD5VF6hrpD2FxFQ52F8f7owbEjmX10AU3bE0CL5SuQAztl2oWrJpqKC/kNqRzkkxfk2/FPLfPwVVvvV+VesM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fy3cAe1t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sp9hYSzH6vGjH5HKqctZ4em7wna5YpsrQRLignkLGyE=;
	b=Fy3cAe1tCTOf02n7iXTAoE+aoSI/XuX0XHbjbwvPP09TeSDhXy39Xa0qLO7kCBLJTmqenv
	3oYUdVtdv94pOmXE6smCI8AmRD7004NJgL8ZUOcv6EvQyyuBbZWIbyJEEBp/yWWOJbl4am
	FzLnIxlZpAQig/RazsVFIbm6bkq5qpo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-OF0Y5ao4N9SMK71jUXUVLw-1; Mon,
 10 Mar 2025 05:42:18 -0400
X-MC-Unique: OF0Y5ao4N9SMK71jUXUVLw-1
X-Mimecast-MFC-AGG-ID: OF0Y5ao4N9SMK71jUXUVLw_1741599737
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F6121955BC1;
	Mon, 10 Mar 2025 09:42:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5BA81800366;
	Mon, 10 Mar 2025 09:42:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/11] afs, rxrpc: Clean up refcounting on afs_cell and afs_server records
Date: Mon, 10 Mar 2025 09:41:53 +0000
Message-ID: <20250310094206.801057-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series fixes an occasional hang that's only really encountered when
rmmod'ing the kafs module, one of the reasons why I'm proposing it for the
next merge window rather than immediate upstreaming.  The changes include:

 (1) Fix missing handling of RCU pathwalk in afs_atcell_get_link().

 (2) Remove the "-o autocell" mount option.  This is obsolete with the
     dynamic root and removing it makes the next patch slightly easier.

 (3) Change how the dynamic root mount is constructed.  Currently, the root
     directory is (de)populated when it is (un)mounted if there are cells
     already configured and, further, pairs of automount points have to be
     created/removed each time a cell is added/deleted.

     This is changed so that readdir on the root dir lists all the known
     cell automount pairs plus the @cell symlinks and the inodes and
     dentries are constructed by lookup on demand.  This simplifies the
     cell management code.

 (4) A few improvements to the afs_volume tracepoint.

 (5) A few improvements to the afs_server tracepoint.

 (6) Pass trace info into the afs_lookup_cell() function to allow the trace
     log to indicate the purpose of the lookup.

 (7) Remove the 'net' parameter from afs_unuse_cell() as it's superfluous.

 (8) In rxrpc, allow a kernel app (such as kafs) to store a word of
     information on rxrpc_peer records.

 (9) Use the information stored on the rxrpc_peer record to point to the
     afs_server record.  This allows the server address lookup to be done
     away with.

(10) Simplify the afs_server ref/activity accounting to make each one
     self-contained and not garbage collected from the cell management work
     item.

(11) Simplify the afs_cell ref/activity accounting to make each one of
     these also self-contained and not driven by a central management work
     item.

     The current code was intended to make it such that a single timer for
     the namespace and one work item per cell could do all the work
     required to maintain these records.  This, however, made for some
     sequencing problems when cleaning up these records.  Further, the
     attempt to pass refs along with timers and work items made getting it
     right rather tricky when the timer or work item already had a ref
     attached and now a ref had to be got rid of.

The patches are here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-next

Thanks,
David

Changes
=======
ver #4)
 - Add a fix patch to handle RCU pathwalk in afs_atcell_get_link().

ver #3)
 - Fix the fix for an error check of the form "unsigned value < 0".

ver #2)
 - Fix an error check of the form "unsigned value < 0".

Link: https://lore.kernel.org/r//3190716.1740733119@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r//3399677.1740754398@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r//3761344.1740995350@warthog.procyon.org.uk/ # v3

David Howells (11):
  afs: Fix afs_atcell_get_link() to handle RCU pathwalk
  afs: Remove the "autocell" mount option
  afs: Change dynroot to create contents on demand
  afs: Improve afs_volume tracing to display a debug ID
  afs: Improve server refcount/active count tracing
  afs: Make afs_lookup_cell() take a trace note
  afs: Drop the net parameter from afs_unuse_cell()
  rxrpc: Allow the app to store private data on peer structs
  afs: Use the per-peer app data provided by rxrpc
  afs: Fix afs_server ref accounting
  afs: Simplify cell record handling

 fs/afs/addr_list.c         |  50 +++
 fs/afs/cell.c              | 446 ++++++++++++---------------
 fs/afs/cmservice.c         |  82 +----
 fs/afs/dir.c               |   5 +-
 fs/afs/dynroot.c           | 501 +++++++++++++------------------
 fs/afs/fs_probe.c          |  32 +-
 fs/afs/fsclient.c          |   4 +-
 fs/afs/internal.h          | 100 +++---
 fs/afs/main.c              |  16 +-
 fs/afs/mntpt.c             |   5 +-
 fs/afs/proc.c              |  19 +-
 fs/afs/rxrpc.c             |   8 +-
 fs/afs/server.c            | 601 ++++++++++++++++---------------------
 fs/afs/server_list.c       |   6 +-
 fs/afs/super.c             |  25 +-
 fs/afs/vl_alias.c          |   7 +-
 fs/afs/vl_rotate.c         |   2 +-
 fs/afs/volume.c            |  15 +-
 include/net/af_rxrpc.h     |   2 +
 include/trace/events/afs.h |  83 ++---
 net/rxrpc/ar-internal.h    |   1 +
 net/rxrpc/peer_object.c    |  30 +-
 22 files changed, 927 insertions(+), 1113 deletions(-)


