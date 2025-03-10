Return-Path: <linux-fsdevel+bounces-43604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F086A595D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 14:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA71188544B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3482022C321;
	Mon, 10 Mar 2025 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsPLvvOH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644122DFBC
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612300; cv=none; b=UhMU9lkGxjOwkd9Y01tdLWqNO4/H2ot0sAik38xc8g6I34CatCn+iSLKU6y75iSrAQofB9dbYbHm3rSajxjfGcPh6YS4T+VwwGxflzsoH4l719Y4eLrSIoQbWlG9Y/22096jUKYrPAcbHVpF8Gz3lhxPr423nyCmPfwD8Gi6FJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612300; c=relaxed/simple;
	bh=AssBWXIV/ifoG3hrXVd+m7SK7nKuBAWaSW5ZLSzg9hc=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=Xw9Im+d7QsOwRis+RtFD+Nfs7wBSfg7iY5gOpf6FLdPuYJRn21DOqrA4OxxbS7WIc8EnJwoUMUvhnXJEgD8amLM9gkvw25bY29chMaHdX2WZev+qO1TBL2k938nWPigzfdELgwha5JsJw1JdYUxWdA5f803EAikZM0GzwOIQpWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsPLvvOH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741612297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TvRKVxX2V+LpzqeszFyuH8/D6f0FPnNS+mKySUYqqBo=;
	b=BsPLvvOHKDRLHCBUHTg/yAWlAu4HYQdS34D4S/6Tg3mPZMl3YxWqL0zv4KSe2Ejp2qL11Y
	2KDlSM5bKBFOMKAmWQLbXxexAG/wwtsAK8NpWwZ079qnaZdEEjad7vbqCD0k3yE1szvOUu
	1zwe9X7vSEi5WCZk+lYmdx2C2D/1Ktw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-3E19lZTPOVewlYjg6GM7WQ-1; Mon,
 10 Mar 2025 09:11:36 -0400
X-MC-Unique: 3E19lZTPOVewlYjg6GM7WQ-1
X-Mimecast-MFC-AGG-ID: 3E19lZTPOVewlYjg6GM7WQ_1741612294
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5D2E19560B7;
	Mon, 10 Mar 2025 13:11:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A1ED1956096;
	Mon, 10 Mar 2025 13:11:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [GIT PULL net-next v4] afs, rxrpc: Clean up refcounting on afs_cell and afs_server records
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <954021.1741612291.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Mar 2025 13:11:31 +0000
Message-ID: <954022.1741612291@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi,

Could you pull this into the net-next tree please (it has been pulled into
the vfs tree[1])?  Besides fixing an rmmod bug, the changes made to the AF=
S
filesystem make it easier to use the AF_RXRPC RxGK (GSSAPI) security
class[2].

More specifically, these changes make it easier to map from the rxrpc_peer
record back to the afs_server record, thereby making it easier for AF_RXRP=
C
to reach out to the AFS filesystem to obtain a token to include in the
RESPONSE packet sent in reply to the AFS fileserver's security challenge.
The fileserver can then use this token to set up a secure connection back
to the client for the purpose of encrypted notifications.

These changes fix an occasional hang that's only really encountered when
rmmod'ing the kafs module, one of the reasons why I'm proposing it for the
next merge window rather than immediate upstreaming.  The changes include:

 (1) Remove the "-o autocell" mount option.  This is obsolete with the
     dynamic root and removing it makes the next patch slightly easier.

 (2) Change how the dynamic root mount is constructed.  Currently, the roo=
t
     directory is (de)populated when it is (un)mounted if there are cells
     already configured and, further, pairs of automount points have to be
     created/removed each time a cell is added/deleted.

     This is changed so that readdir on the root dir lists all the known
     cell automount pairs plus the @cell symlinks and the inodes and
     dentries are constructed by lookup on demand.  This simplifies the
     cell management code.

 (3) A few improvements to the afs_volume tracepoint.

 (4) A few improvements to the afs_server tracepoint.

 (5) Pass trace info into the afs_lookup_cell() function to allow the trac=
e
     log to indicate the purpose of the lookup.

 (6) Remove the 'net' parameter from afs_unuse_cell() as it's superfluous.

 (7) In rxrpc, allow a kernel app (such as kafs) to store a word of
     information on rxrpc_peer records.

 (8) Use the information stored on the rxrpc_peer record to point to the
     afs_server record.  This allows the server address lookup to be done
     away with.

 (9) Simplify the afs_server ref/activity accounting to make each one
     self-contained and not garbage collected from the cell management wor=
k
     item.

(10) Simplify the afs_cell ref/activity accounting to make each one of
     these also self-contained and not driven by a central management work
     item.

     The current code was intended to make it such that a single timer for
     the namespace and one work item per cell could do all the work
     required to maintain these records.  This, however, made for some
     sequencing problems when cleaning up these records.  Further, the
     attempt to pass refs along with timers and work items made getting it
     right rather tricky when the timer or work item already had a ref
     attached and now a ref had to be got rid of.

Thanks,
David

Link: https://lore.kernel.org/r/20250310094206.801057-1-dhowells@redhat.co=
m/ [1]
Link: https://web.git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-f=
s.git/log/?h=3Drxrpc-next [2]

---
The following changes since commit 1e15510b71c99c6e49134d756df91069f7d1814=
1:

  Merge tag 'net-6.14-rc5' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/netdev/net (2025-02-27 09:32:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-next-20250310

for you to fetch changes up to e2c2cb8ef07affd9f69497ea128fa801240fdf32:

  afs: Simplify cell record handling (2025-03-10 09:47:15 +0000)

----------------------------------------------------------------
afs: Fix ref leak in rmmod

----------------------------------------------------------------
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

 fs/afs/addr_list.c         |  50 ++++
 fs/afs/cell.c              | 446 ++++++++++++++-------------------
 fs/afs/cmservice.c         |  82 +------
 fs/afs/dir.c               |   5 +-
 fs/afs/dynroot.c           | 501 ++++++++++++++++---------------------
 fs/afs/fs_probe.c          |  32 ++-
 fs/afs/fsclient.c          |   4 +-
 fs/afs/internal.h          | 100 ++++----
 fs/afs/main.c              |  16 +-
 fs/afs/mntpt.c             |   5 +-
 fs/afs/proc.c              |  19 +-
 fs/afs/rxrpc.c             |   8 +-
 fs/afs/server.c            | 601 +++++++++++++++++++---------------------=
-----
 fs/afs/server_list.c       |   6 +-
 fs/afs/super.c             |  25 +-
 fs/afs/vl_alias.c          |   7 +-
 fs/afs/vl_rotate.c         |   2 +-
 fs/afs/volume.c            |  15 +-
 include/net/af_rxrpc.h     |   2 +
 include/trace/events/afs.h |  83 ++++---
 net/rxrpc/ar-internal.h    |   1 +
 net/rxrpc/peer_object.c    |  30 ++-
 22 files changed, 927 insertions(+), 1113 deletions(-)


