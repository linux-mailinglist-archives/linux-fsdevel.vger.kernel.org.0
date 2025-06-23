Return-Path: <linux-fsdevel+bounces-52549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD45AE40F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144CF164BC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ABB24A07C;
	Mon, 23 Jun 2025 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKFqkQxc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4102475E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682931; cv=none; b=Pjq3XYi2ey70lVWOOJvMrQ2EneM9WB3cSyQC2+PAXjQt9iplbs3BN25RFq84m14v8usvxl0h8hETpwj4kHo01cLzIacqxnsCMPB7RmRG1foSpihevwB7XQvsmf/G8Svok+TfX0fJQXZMPCk5RVrAl38Zlex250lNqrOcUqDX7sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682931; c=relaxed/simple;
	bh=qhC8jPNT2nWZNs9eWmfYrP6gdoWYMghlzeI9XdjlnSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+gWZ+orZ6jZnAmErNBKDYKAAe8MGuavoc74gYMhSLbRznd/3xJxXwrv1M83CTH4gFkk6Jv+oiGmXhDwy3i/SK+pVbVLPBtORqy6NCPZ+qGSAqUNmgEhnxlwFOyzMz53AMd1QBAySZGLJT/rdKJ+whWu48puJqtBUgt8f7SgzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKFqkQxc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750682927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eqjVeD04dYJeEvbD+6Wgl5HMPrxzLy2Qh89o6pQx3jY=;
	b=JKFqkQxcwZfaKcEiIIQ4iUupR/JUR0+hIazba2GeCInbbnHfCjovSmuQzFEkdUz2B1tTyG
	VX1qq8roa4Sen7gAFGQsOOsoey88YWmpvyI3YCEG0PzmXwKW+EhoGrAo1xFZx9+popWbla
	11wq+qdKkxJGAcwOrrIz9ij7/gAKR/U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-KUDryShdN8Og-mXpwXXWtw-1; Mon,
 23 Jun 2025 08:48:44 -0400
X-MC-Unique: KUDryShdN8Og-mXpwXXWtw-1
X-Mimecast-MFC-AGG-ID: KUDryShdN8Og-mXpwXXWtw_1750682922
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36BE519560BB;
	Mon, 23 Jun 2025 12:48:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8456B180045B;
	Mon, 23 Jun 2025 12:48:38 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] netfs, cifs: Fixes to retry-related code
Date: Mon, 23 Jun 2025 13:48:20 +0100
Message-ID: <20250623124835.1106414-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Christian, Steve,

Here are some miscellaneous fixes and changes for netfslib and cifs, if you
could consider pulling them.  Some or all of them might be better going
through the cifs tree as the effects were most noticeable there.  These
were primarily found because a bug in Samba was causing smbd to crash and
restart after about 1-2s and this was vigorously and abruptly exercising
the netfslib retry paths.

First, there are some netfs fixes:

 (1) Fix a hang due to missing case in final DIO read result collection
     not breaking out of a loop if the request finished, but there were no
     subrequests being processed and NETFS_RREQ_ALL_QUEUED wasn't yet set.

 (2) Fix a double put of the netfs_io_request struct if completion happened
     in the pause loop.

 (3) Provide some helpers to abstract out NETFS_RREQ_IN_PROGRESS flag
     wrangling.

 (4) Fix infinite looping in netfs_wait_for_pause/request() which wa caused
     by a loop waiting for NETFS_RREQ_ALL_QUEUED to get set - but which
     wouldn't get set until the looping function returned.  This uses patch
     (3) above.

 (5) Fix a ref leak on an extra subrequest inserted into a request's list
     of subreqs because more subreq records were needed for retrying than
     were needed for the original request (say, for instance, that the
     amount of cifs credit available was reduced and, subsequently, the ops
     had to be smaller).

Then a bunch of cifs fixes:

 (6) cifs: Fix missing wsize negotiation.

 (7-9) cifs: Fix various RPC callbacks to set NETFS_SREQ_NEED_RETRY if a
     subrequest fails retriably.

And finally a couple of patches to improve tracing output, but that should
otherwise not affect functionality:

 (10) Renumber the NETFS_RREQ_* flags to make the hex values easier to
     interpret by eye, including moving the main status flags down to the
     lowest bits, with IN_PROGRESS in bit 0.

 (11) Update the tracepoints in a number of ways, including adding more
     tracepoints into the cifs read/write RPC callback so that differend
     MID_RESPONSE_* values can be differentiated.

Those last two could wait for the next merge window.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (8):
  netfs: Fix hang due to missing case in final DIO read result
    collection
  netfs: Put double put of request
  netfs: Provide helpers to perform NETFS_RREQ_IN_PROGRESS flag wangling
  netfs: Fix looping in wait functions
  netfs: Fix ref leak on inserted extra subreq in write retry
  cifs: Fix prepare_write to negotiate wsize if needed
  netfs: Renumber the NETFS_RREQ_* flags to make traces easier to read
  netfs: Update tracepoints in a number of ways

Paulo Alcantara (3):
  smb: client: set missing retry flag in smb2_writev_callback()
  smb: client: set missing retry flag in cifs_readv_callback()
  smb: client: set missing retry flag in cifs_writev_callback()

 fs/netfs/direct_write.c      |  1 -
 fs/netfs/internal.h          | 20 ++++++++++++++-
 fs/netfs/main.c              |  6 ++---
 fs/netfs/misc.c              | 50 ++++++++++++++++++++++--------------
 fs/netfs/read_collect.c      | 16 ++++++++----
 fs/netfs/write_collect.c     |  8 +++---
 fs/netfs/write_retry.c       |  3 +--
 fs/smb/client/cifssmb.c      | 22 ++++++++++++++++
 fs/smb/client/file.c         |  8 ++++--
 fs/smb/client/smb2pdu.c      | 27 ++++++++++++++++---
 include/linux/netfs.h        | 20 +++++++--------
 include/trace/events/netfs.h | 29 ++++++++++++++-------
 12 files changed, 151 insertions(+), 59 deletions(-)


