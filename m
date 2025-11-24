Return-Path: <linux-fsdevel+bounces-69655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F6FC80850
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 13:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A28C3A6B24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 12:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CCF301016;
	Mon, 24 Nov 2025 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yaf5o048"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4A27466A
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988186; cv=none; b=VZRGx7pMtyby84rGJVoqVk3GMMzqFCUgrKGep5WY6wpqFI26/tO7glsGjxSixg9wHzjyH+VnpzLnMT72jBcXIwZiT/vZWcp3w2yTOH9PvYUuBzPYQ8tJSvsl+pxj4NtgcNCVE/G24xU2hWL5cZLTbSs186jJjvhROnm1M6X2bH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988186; c=relaxed/simple;
	bh=GA5bDKGcQ9ouYULzNRYeF0iuQoUfe3Y/1YEdFzZ3mvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wt6WUNe7my0zrWybNMEGV83cq1tSbTSFeDCh0GjVj6cG9SiuoPor4aeUUtzRaOUlIa5xegfg6wT0yxHt432n824hXxSgBW/WMEwv6v+LEOYct5+I21jRAjZBcaQ0P5PlniZKqOlVlWOFXZ2m3f97TtApqpDIio2o394WS5BPnvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yaf5o048; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763988182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1iD30+8y8aeycbkW0yQ0TCow658sGNcOCv4O0ud5y6s=;
	b=Yaf5o048BDJt40zcaZWYovWaXEWSpuIp2UnfPCBARTsXNeTz/gpLWo2G9QPWxV1ad4b7ZZ
	9i/3nql5HGrKPHKiyNz/vJPoeMLtHtviDvRLNLGzLjpKS2wqK0SgmTxwu9ZqdTsZFKIZFe
	HpO4nGgYDxyKOhA2dAFXU0HUz7sMLPU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-TMLAfd1VNoKVXAyGgG-4GQ-1; Mon,
 24 Nov 2025 07:42:59 -0500
X-MC-Unique: TMLAfd1VNoKVXAyGgG-4GQ-1
X-Mimecast-MFC-AGG-ID: TMLAfd1VNoKVXAyGgG-4GQ_1763988178
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1E96195608F;
	Mon, 24 Nov 2025 12:42:57 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 335FB180047F;
	Mon, 24 Nov 2025 12:42:54 +0000 (UTC)
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
Subject: [PATCH v4 00/11] cifs: Miscellaneous prep patches for rewrite of I/O layer
Date: Mon, 24 Nov 2025 12:42:39 +0000
Message-ID: <20251124124251.3565566-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Steve,

Could you take these patches extracted from my I/O layer rewrite for the
upcoming merge window.  The performance change should be neutral, but it
cleans up the code a bit.

 (1) Use netfs_alloc/free_folioq_buffer() rather than cifs doing its own
     version.

 (2) Do some minor cleanups so that patch 2 can be generated wholly by a
     script.

 (3) Organise the declarations in the cifs client header files, naming the
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

 (4) Rename struct mid_q_entry to smb_message.  In my rewrite, smb_message
     will get allocated in the marshalling functions in smb2pdu.c and
     cifssmb.c rather than in transport.c and used to hand parameters down
     - and so I think it could be better named for that.

 (5) Remove the RFC1002 header from the smb_hdr struct so that it's
     consistent with SMB2/3.  This allows I/O routines to be simplified and
     shared.

 (6) Make SMB1's SendReceive() wrap cifs_send_recv() and thus share code
     with SMB2/3.

 (7) Clean up a bunch of extra kvec[] that were required for RFC1002
     headers from SMB1's header struct.

 (8) Replace SendReceiveBlockingLock() with SendReceive() plus flags.

 (9) Remove the server pointer from smb_message.  It can be passed down
     from the caller to all places that need it.

(10) Don't need state locking in smb2_get_mid_entry() as we're just doing a
     single read inside the lock.  READ_ONCE() should suffice instead.

(11) Add a tracepoint to log EIO errors and up to a couple of bits of info
     for each to make it easier to find out why an EIO error happened when
     the system is very busy without introducing printk delays.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-cleanup

Thanks,
David

Changes
=======
ver #4)
 - Rebased on the ksmbd-for-next branch.
 - The read tracepoint patch got merged, so drop it.
 - Move the netfs_alloc, etc. patch first.
 - Fix a couple of prototypes that need to be conditional (may need some post
   cleanup).
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

David Howells (11):
  cifs: Use netfs_alloc/free_folioq_buffer()
  cifs: Do some preparation prior to organising the function
    declarations
  cifs: Clean up declarations
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
 fs/smb/client/cifsencrypt.c   |   83 +--
 fs/smb/client/cifsfs.c        |   36 +-
 fs/smb/client/cifsfs.h        |   64 --
 fs/smb/client/cifsglob.h      |  219 ++----
 fs/smb/client/cifspdu.h       |   13 +-
 fs/smb/client/cifsproto.h     | 1318 +++++++++++++++++----------------
 fs/smb/client/cifssmb.c       |  932 +++++++++++++----------
 fs/smb/client/cifstransport.c |  439 ++---------
 fs/smb/client/compress.c      |   23 +-
 fs/smb/client/compress.h      |   20 +-
 fs/smb/client/connect.c       |  200 ++---
 fs/smb/client/dfs.h           |   12 +-
 fs/smb/client/dfs_cache.h     |    9 +-
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
 fs/smb/client/smb2inode.c     |   13 +-
 fs/smb/client/smb2maperror.c  |    6 +-
 fs/smb/client/smb2misc.c      |   11 +-
 fs/smb/client/smb2ops.c       |  253 +++----
 fs/smb/client/smb2pdu.c       |  230 +++---
 fs/smb/client/smb2proto.h     |  516 +++++++------
 fs/smb/client/smb2transport.c |  113 ++-
 fs/smb/client/smbdirect.c     |   18 +-
 fs/smb/client/smbdirect.h     |    1 +
 fs/smb/client/trace.h         |  153 ++++
 fs/smb/client/transport.c     |  302 ++++----
 fs/smb/client/xattr.c         |    2 +-
 fs/smb/common/smb2pdu.h       |    3 -
 fs/smb/common/smbglob.h       |    1 -
 57 files changed, 2887 insertions(+), 2855 deletions(-)
 create mode 100644 fs/smb/client/smb1proto.h


