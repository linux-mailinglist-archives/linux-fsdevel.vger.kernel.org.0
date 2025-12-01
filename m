Return-Path: <linux-fsdevel+bounces-70395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F7EC9978F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 23:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AC604E23E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F417296BAB;
	Mon,  1 Dec 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbuGBDd/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C00287516
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629865; cv=none; b=k9KyFCc/WPmOXmwmh57m4ya7r0zog6ybF553Aj8RcTSaIHMkGxXfaGnVTN2KLR/NDKb4V8/4HqAIHdvv97HMnT9wRfWwyIC3GuJPsWv2FjEmTe0ljCcJ9nCW8WSzvGEzGojYa9RyKOXiAp8X5OHD20GtBMNpRM4Jt084pi0Hvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629865; c=relaxed/simple;
	bh=MwN/vyhsZF0CB7QXdOzedQVkskWBqK57BYUAMzYznV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JxLGGguj85LCB3fDMGaTuNhQ26V2qZ/R0F2FFvF6gbOZBWm1TeavmS30I2WU/d+DxEeqg3s7ZfVozEaZrexVtVgd262Css+2NULGmlTFefTtPQ4rdwURLSqfDbAW4od+D69brU2aCjKjUU6BX8pvRWIvwOBTDfLYdM8mMmeqdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FbuGBDd/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764629863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ibKoxvnJbZFFIklPF8xT2EX3IWfF5VpyLwppz80KddE=;
	b=FbuGBDd/s+vc7FCmvs8E3163J/00CZ8gjaPRhiH7ATHPOI25jGz5HqfKsmSZnEmz4Chx8Y
	JInwTHjA5FkIayQjHJ1qD9woEqSZ9EFfFB2/5sFs1Q7qnf8cPM0r4oMpE+BYMAHWg/9MhC
	8jaDKY2jSIUGCWFJzltsJq4//juA6O4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-4IxlYR7RNuqX4KUpxZCVIw-1; Mon,
 01 Dec 2025 17:57:40 -0500
X-MC-Unique: 4IxlYR7RNuqX4KUpxZCVIw-1
X-Mimecast-MFC-AGG-ID: 4IxlYR7RNuqX4KUpxZCVIw_1764629858
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 877F1195609E;
	Mon,  1 Dec 2025 22:57:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE40530001A4;
	Mon,  1 Dec 2025 22:57:35 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Stefan Metzmacher <metze@samba.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/9] cifs: Miscellaneous prep patches for rewrite of I/O layer
Date: Mon,  1 Dec 2025 22:57:21 +0000
Message-ID: <20251201225732.1520128-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Steve,

Could you take these patches extracted from my I/O layer rewrite for the
upcoming merge window.  The performance change should be neutral, but it
cleans up the code a bit.

 (1) Remove the RFC1002 header from the smb_hdr struct so that it's
     consistent with SMB2/3.  This allows I/O routines to be simplified and
     shared.

 (2) Make SMB1's SendReceive() wrap cifs_send_recv() and thus share code
     with SMB2/3.

 (3) Clean up a bunch of extra kvec[] that were required for RFC1002
     headers from SMB1's header struct.

 (4) Replace SendReceiveBlockingLock() with SendReceive() plus flags.

 (5) Change the mid_*_t function pointers to have the pointer in the typedef
     as is more normal rather than at the point of use.

 (6) Remove the server pointer from smb_message.  It can be passed down
     from the caller to all places that need it.

 (7) Don't need state locking in smb2_get_mid_entry() as we're just doing a	
     single read inside the lock.  READ_ONCE() should suffice instead.

 (8) Add a tracepoint to log EIO errors and up to a couple of bits of info
     for each to make it easier to find out why an EIO error happened when
     the system is very busy without introducing printk delays.

 (9) Make some minor code cleanups.

The patches will be found here also when the git server is accessible
again:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-next

Thanks,
David

Changes
=======
ver #6)
 - Remove the patch to rename mid_q_entry.
 - Add a patch to normalise the func pointer typedefs.

ver #5)
 - Rebased on the ksmbd-for-next branch.
 - Drop the netfs_alloc patch as that's now taken.
 - Added a warning check requested by Stefan Metzmacher.
 - Switched to a branch without the header prototype cleanups.
 - Add a patch to make some minor code cleanups.
 - Don't do EIO changed in smbdirect.c as that interferes with Stefan's
   changes.

ver #4)
 - Rebased on the ksmbd-for-next branch.
 - The read tracepoint patch got merged, so drop it.
 - Move the netfs_alloc, etc. patch first.
 - Fix a couple of prototypes that need to be conditional (may need some
   post cleanup).
 - Fixed another couple of headers that needed their own prototype lists.
 - Fixed #include order in a couple of places.

ver #3)
 - Rebased on the ksmbd-for-next branch.
 - Add the patches to clean up the function prototypes in the headers.
   - Don't touch smbdirect.
   - Put prototypes into netlink.h and cached_dir.h rather than
     centralising them.
   - Indent the arguments in the prototypes to the opening bracket + 1.
 - Cleaned up most other checkpatch complaints.
 - Added the EIO tracepoint patch to the end.

ver #2)
 - Rebased on the ksmbd-for-next-next branch.
 - Moved the patch to use netfs_alloc/free_folioq_buffer() down the stack.

David Howells (9):
  cifs: Remove the RFC1002 header from smb_hdr
  cifs: Make smb1's SendReceive() wrap cifs_send_recv()
  cifs: Clean up some places where an extra kvec[] was required for
    rfc1002
  cifs: Replace SendReceiveBlockingLock() with SendReceive() plus flags
  cifs: Fix specification of function pointers
  cifs: Remove the server pointer from smb_message
  cifs: Don't need state locking in smb2_get_mid_entry()
  cifs: Add a tracepoint to log EIO errors
  cifs: Do some preparation prior to organising the function
    declarations

 fs/smb/client/cached_dir.c    |   2 +-
 fs/smb/client/cifs_debug.c    |  14 +-
 fs/smb/client/cifs_debug.h    |   6 +-
 fs/smb/client/cifs_spnego.h   |   2 -
 fs/smb/client/cifs_unicode.h  |   3 -
 fs/smb/client/cifsacl.c       |  10 +-
 fs/smb/client/cifsencrypt.c   |  83 +---
 fs/smb/client/cifsfs.c        |  12 +-
 fs/smb/client/cifsglob.h      | 151 ++----
 fs/smb/client/cifspdu.h       |   2 +-
 fs/smb/client/cifsproto.h     | 194 ++++++--
 fs/smb/client/cifssmb.c       | 913 +++++++++++++++++++---------------
 fs/smb/client/cifstransport.c | 382 ++------------
 fs/smb/client/compress.c      |  23 +-
 fs/smb/client/compress.h      |  19 +-
 fs/smb/client/connect.c       |  81 ++-
 fs/smb/client/dir.c           |   8 +-
 fs/smb/client/dns_resolve.h   |   4 -
 fs/smb/client/file.c          |   6 +-
 fs/smb/client/fs_context.c    |   2 +-
 fs/smb/client/inode.c         |  14 +-
 fs/smb/client/link.c          |  10 +-
 fs/smb/client/misc.c          |  53 +-
 fs/smb/client/netmisc.c       |  11 +-
 fs/smb/client/readdir.c       |   2 +-
 fs/smb/client/reparse.c       |  53 +-
 fs/smb/client/sess.c          |  16 +-
 fs/smb/client/smb1ops.c       |  78 ++-
 fs/smb/client/smb2file.c      |   9 +-
 fs/smb/client/smb2inode.c     |  13 +-
 fs/smb/client/smb2maperror.c  |   6 +-
 fs/smb/client/smb2misc.c      |   3 +-
 fs/smb/client/smb2ops.c       |  78 +--
 fs/smb/client/smb2pdu.c       | 208 ++++----
 fs/smb/client/smb2proto.h     |   4 +-
 fs/smb/client/smb2transport.c |  59 +--
 fs/smb/client/trace.h         | 149 ++++++
 fs/smb/client/transport.c     | 179 +++----
 fs/smb/client/xattr.c         |   2 +-
 fs/smb/common/smb2pdu.h       |   3 -
 fs/smb/common/smbglob.h       |   1 -
 41 files changed, 1463 insertions(+), 1405 deletions(-)


