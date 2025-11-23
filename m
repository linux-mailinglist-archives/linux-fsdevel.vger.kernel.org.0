Return-Path: <linux-fsdevel+bounces-69599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD9BC7E9E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 00:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F4B434455A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 23:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86C62773D3;
	Sun, 23 Nov 2025 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UH+tmo/t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E960238C36
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 23:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763941977; cv=none; b=o+EEPIrbepARaBpqLKvGmBfgeG20iASYVVWjLLXAOT63Fz3AM+hD2w9KiTaN8QQMBYZDhDaiIV7O36o1dTdvegwzL/7E+IqcigzsHuQqDQxPuxzTE+UQNBysCqMyQcDTilwGWV/+BtliTTz8uHJTBPWz3JnxPhEXZtNqLFVi9tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763941977; c=relaxed/simple;
	bh=G+396j5E3oSYlgXES0uT2w8/XhT7FnSRGJQJf3/XKTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F7J+IiO9iryAQqRLMnLvPCf6lNwIndCX5Iyglg7ZeJZ/D2GXcCGrPuPfphCQ3PNvJNkThq/rSv4+ZFeaxaEt+DWDNYG5oMi4GVW56rzBYR+Ze73LDOo3VA0wfhM2Wf4a1yEStzlDe1zujBb3DtA2pRzzj6zKTZIfWqv5A/c1NDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UH+tmo/t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763941973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3iwb5YW7lTHp3b6+iKLPVMv6CIYbcmnN5G/p+yPO23I=;
	b=UH+tmo/tg8PV0A+XhA0d8Qhz2YfKk1r60lfHpxjcxlx4HZsbeUe5oGMz5s7Hu6r8DKDAOF
	BQwOCjfBLNecHwo6BcKeE7PfK79+4gb9TzY+x2ttRfR8lnqXhzMK2fU+i2KGkP4NWIE95A
	BwjgAgEvxGoLNLXecuV+FPJKV7CFySE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-CPoFZG8nMTCII-yelFMgEg-1; Sun,
 23 Nov 2025 18:52:50 -0500
X-MC-Unique: CPoFZG8nMTCII-yelFMgEg-1
X-Mimecast-MFC-AGG-ID: CPoFZG8nMTCII-yelFMgEg_1763941968
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B0951800447;
	Sun, 23 Nov 2025 23:52:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B42791955F1B;
	Sun, 23 Nov 2025 23:52:45 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Stefan Metzmacher <metze@samba.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/12] cifs: Miscellaneous prep patches for rewrite of I/O layer
Date: Sun, 23 Nov 2025 23:52:27 +0000
Message-ID: <20251123235242.3361706-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Steve,

Could you take these patches extracted from my I/O layer rewrite for the
upcoming merge window.  The performance change should be neutral, but it
cleans up the code a bit.

 (1) Do some minor cleanups so that patch 2 can be generated wholly by a
     script.

 (2) Organise the declarations in the cifs client header files, naming the
     arguments the same as for the implementations, inserting divider
     comments, ordering them the same as they're found in the files and
     dividing them better between general, smb1 and smb2/3 categories.

     The organisation is entirely scripted with the script in the second
     patch's commit message.  The first patch does a bit of preparation to
     make sure that the second patch's output will build.

     By filling in the argument names, this stops checkpatch moaning about
     unnamed arguments from search-and-replace changes in later patches.
     (Note that it doesn't fix func pointer declarations).

     smbdirect is left untouched as requested by Stefan Metzmacher.

 (3) Add the smb3_read_* tracepoints to SMB1 as well as SMB2/3.

 (4) Use netfs_alloc/free_folioq_buffer() rather than cifs doing its own
     version.

 (5) Rename struct mid_q_entry to smb_message.  In my rewrite, smb_message
     will get allocated in the marshalling functions in smb2pdu.c and
     cifssmb.c rather than in transport.c and used to hand parameters down
     - and so I think it could be better named for that.

 (6) Remove the RFC1002 header from the smb_hdr struct so that it's
     consistent with SMB2/3.  This allows I/O routines to be simplified and
     shared.

 (7) Make SMB1's SendReceive() wrap cifs_send_recv() and thus share code
     with SMB2/3.

 (8) Clean up a bunch of extra kvec[] that were required for RFC1002
     headers from SMB1's header struct.

 (9) Replace SendReceiveBlockingLock() with SendReceive() plus flags.

(10) Remove the server pointer from smb_message.  It can be passed down
     from the caller to all places that need it.

(11) Don't need state locking in smb2_get_mid_entry() as we're just doing a
     single read inside the lock.  READ_ONCE() should suffice instead.

(12) Add a tracepoint to log EIO errors and up to a couple of bits of info
     for each to make it easier to find out why an EIO error happened when
     the system is very busy without introducing printk delays.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-cleanup

Thanks,
David

Changes
=======
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

David Howells (12):
  cifs: Do some preparation prior to organising the function
    declarations
  cifs: Clean up declarations
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
  cifs: Add a tracepoint to log EIO errors

 fs/smb/client/cached_dir.c    |    2 +-
 fs/smb/client/cached_dir.h    |   37 +-
 fs/smb/client/cifs_debug.c    |   51 +-
 fs/smb/client/cifs_debug.h    |   15 +-
 fs/smb/client/cifs_spnego.h   |    2 -
 fs/smb/client/cifs_swn.h      |   15 +-
 fs/smb/client/cifs_unicode.c  |    1 +
 fs/smb/client/cifs_unicode.h  |   16 -
 fs/smb/client/cifsacl.c       |   11 +-
 fs/smb/client/cifsencrypt.c   |   83 +-
 fs/smb/client/cifsfs.c        |   36 +-
 fs/smb/client/cifsfs.h        |   64 --
 fs/smb/client/cifsglob.h      |  219 ++----
 fs/smb/client/cifspdu.h       |   13 +-
 fs/smb/client/cifsproto.h     | 1340 +++++++++++++++++----------------
 fs/smb/client/cifssmb.c       |  954 +++++++++++++----------
 fs/smb/client/cifstransport.c |  439 ++---------
 fs/smb/client/compress.c      |   23 +-
 fs/smb/client/compress.h      |   20 +-
 fs/smb/client/connect.c       |  200 ++---
 fs/smb/client/dfs.h           |    4 -
 fs/smb/client/dfs_cache.h     |   16 -
 fs/smb/client/dir.c           |    9 +-
 fs/smb/client/dns_resolve.h   |    3 -
 fs/smb/client/file.c          |    7 +-
 fs/smb/client/fs_context.c    |    2 +-
 fs/smb/client/fs_context.h    |    9 -
 fs/smb/client/fscache.h       |   13 +-
 fs/smb/client/inode.c         |   15 +-
 fs/smb/client/ioctl.c         |    1 +
 fs/smb/client/link.c          |   11 +-
 fs/smb/client/misc.c          |   53 +-
 fs/smb/client/netlink.h       |    8 +-
 fs/smb/client/netmisc.c       |   21 +-
 fs/smb/client/nterr.h         |    2 -
 fs/smb/client/ntlmssp.h       |   13 -
 fs/smb/client/readdir.c       |    2 +-
 fs/smb/client/reparse.c       |   53 +-
 fs/smb/client/reparse.h       |   11 -
 fs/smb/client/sess.c          |   17 +-
 fs/smb/client/smb1ops.c       |  116 ++-
 fs/smb/client/smb1proto.h     |  227 ++++++
 fs/smb/client/smb2file.c      |    9 +-
 fs/smb/client/smb2inode.c     |   12 +-
 fs/smb/client/smb2maperror.c  |    3 +
 fs/smb/client/smb2misc.c      |   11 +-
 fs/smb/client/smb2ops.c       |  249 +++---
 fs/smb/client/smb2pdu.c       |  228 +++---
 fs/smb/client/smb2proto.h     |  516 ++++++-------
 fs/smb/client/smb2transport.c |  113 ++-
 fs/smb/client/smbdirect.c     |   18 +-
 fs/smb/client/smbdirect.h     |    1 +
 fs/smb/client/trace.h         |  153 ++++
 fs/smb/client/transport.c     |  302 ++++----
 fs/smb/client/xattr.c         |    2 +-
 fs/smb/common/smb2pdu.h       |    3 -
 fs/smb/common/smbglob.h       |    1 -
 57 files changed, 2913 insertions(+), 2862 deletions(-)
 create mode 100644 fs/smb/client/smb1proto.h


