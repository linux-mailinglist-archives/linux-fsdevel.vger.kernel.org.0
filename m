Return-Path: <linux-fsdevel+bounces-69234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD1C75118
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 16:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45D0B366CB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 15:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12F735F8BB;
	Thu, 20 Nov 2025 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c82t0zIN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A39352956
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652347; cv=none; b=vEXdXNz339gsTF65a3ocZke7Pl7ONWCZPvwAB3mhJn4o7i81LKqDOd7GIyY6H+rwGJv7c+YwOlEAPWXSibmYAEEx1gbk3fhSbEoqlbKjfnI/9qoRbGn4vBTnJFMiDevF7L5n6iq7Skm/pYBhnFzbHHqeWAOWUSv6xiUfED2b83I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652347; c=relaxed/simple;
	bh=wSdVpLJCV33dPU5ELuUNEBkTNMU8h4s4XVJel9nkKwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F768mp1cwYD5qS84bY1zKJ8MJ7ONwfGu9NEU6My4DJJwXTBeMtDcZlQDdMWZ7Fr9NgLx5rb3xiXM/1KQuat2rOs6arYjOu1yZSwC3D2FQksf3u5pWJrDQpQ4jJdB1ccEsqQzhRAktdYGsjZoeqlJ+7MtwvoNQqqUa+QHz7G/9Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c82t0zIN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763652344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PjNrAY4dFYWKw1aaXZDc9ufswCb6NZR4BOSYe0sks6k=;
	b=c82t0zINF7nGQRtDIA7eHlJK9UoARQ9EUF1MxK6luNmdpK25P9PPKqofUQTBjJkyJ1D1sA
	y8cGUvKWBvD1EUw00IxuOQ6Mdi8PQa9VpipU4DkN5ZUZ5xUEGqh8SpJjLqk+T2JXVmXcoz
	SCj5ZbGvb2zOCqCGFMR7pA8VNcnV6uo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-dhD_Sij2PfewjznRvvYsfw-1; Thu,
 20 Nov 2025 10:25:41 -0500
X-MC-Unique: dhD_Sij2PfewjznRvvYsfw-1
X-Mimecast-MFC-AGG-ID: dhD_Sij2PfewjznRvvYsfw_1763652340
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02B9E19198A3;
	Thu, 20 Nov 2025 15:25:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D82930044DB;
	Thu, 20 Nov 2025 15:25:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] netfs: Miscellaneous prep patches for rewrite of I/O layer
Date: Thu, 20 Nov 2025 15:25:13 +0000
Message-ID: <20251120152524.2711660-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Steve,

Could you consider taking these patches extracted from my I/O layer rewrite
for the upcoming merge window.  The performance change should be neutral,
but it cleans up the code a bit.

 (1) Add the smb3_read_* tracepoints to SMB1 as well as SMB2/3.

 (2) Use netfs_alloc/free_folioq_buffer() rather than cifs doing its own
     version.

 (3) Rename struct mid_q_entry to smb_message.  In my rewrite, smb_message
     will get allocated in the marshalling functions in smb2pdu.c and
     cifssmb.c rather than in transport.c and used to hand parameters down
     - and so I think it could be better named for that.

 (4) Remove the RFC1002 header from the smb_hdr struct so that it's
     consistent with SMB2/3.  This allows I/O routines to be simplified and
     shared.

 (5) Make SMB1's SendReceive() wrap cifs_send_recv() and thus share code
     with SMB2/3.

 (6) Clean up a bunch of extra kvec[] that were required for RFC1002
     headers from SMB1's header struct.

 (7) Replace SendReceiveBlockingLock() with SendReceive() plus flags.

 (8) Remove the server pointer from smb_message.  It can be passed down
     from the caller to all places that need it.

 (9) Don't need state locking in smb2_get_mid_entry() as we're just doing a
     single read inside the lock.  READ_ONCE() should suffice instead.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-next

Thanks,
David

Changes
=======
ver #2)
 - Rebased on the ksmbd-for-next-next branch.
 - Moved the patch to use netfs_alloc/free_folioq_buffer() down the stack.

David Howells (9):
  cifs: Add the smb3_read_* tracepoints to SMB1
  cifs: Use netfs_alloc/free_folioq_buffer()
  cifs: Rename mid_q_entry to smb_message
  cifs: Remove the RFC1002 header from smb_hdr
  cifs: Make smb1's SendReceive() wrap cifs_send_recv()
  cifs: Clean up some places where an extra kvec[] was required for
    rfc1002
  cifs: Replace SendReceiveBlockingLock() with SendReceive() plus flags
  cifs: Remove the server pointer from smb_message
  cifs: Don't need state locking in smb2_get_mid_entry()

 fs/smb/client/cifs_debug.c    |  47 +-
 fs/smb/client/cifs_debug.h    |   2 +-
 fs/smb/client/cifsencrypt.c   |  72 +--
 fs/smb/client/cifsfs.c        |  31 +-
 fs/smb/client/cifsglob.h      |  92 ++--
 fs/smb/client/cifspdu.h       |   2 +-
 fs/smb/client/cifsproto.h     |  76 ++--
 fs/smb/client/cifssmb.c       | 806 +++++++++++++++++++---------------
 fs/smb/client/cifstransport.c | 432 +++---------------
 fs/smb/client/connect.c       | 188 ++++----
 fs/smb/client/misc.c          |  32 +-
 fs/smb/client/netmisc.c       |  15 +-
 fs/smb/client/sess.c          |   8 +-
 fs/smb/client/smb1ops.c       | 113 +++--
 fs/smb/client/smb2misc.c      |  11 +-
 fs/smb/client/smb2ops.c       | 206 +++------
 fs/smb/client/smb2pdu.c       |  48 +-
 fs/smb/client/smb2proto.h     |  12 +-
 fs/smb/client/smb2transport.c | 111 +++--
 fs/smb/client/transport.c     | 281 ++++++------
 fs/smb/common/smb2pdu.h       |   3 -
 fs/smb/common/smbglob.h       |   1 -
 22 files changed, 1159 insertions(+), 1430 deletions(-)


