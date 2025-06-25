Return-Path: <linux-fsdevel+bounces-52936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34804AE8B46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 19:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D357BAE4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB0A2DA776;
	Wed, 25 Jun 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jD2GpF16"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF22D9ED1
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869751; cv=none; b=MFjjsqTmEFwhNocr2Vv949XuBXwjxrTzvRAqTWpNKJx0sq10Sy8rjME6sSY6Olz6QehefkxNIlFLOYdoczeg+ByLCHtO0Ygw/EsjG+MhIJLQNZSaxQD+CxEaAAK/p/FCroBnNfLx8kdrb6bKhMEvkbTyn+j0YIU9ebh8/8SdEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869751; c=relaxed/simple;
	bh=1h2IM9rfU7dvpEu1fgUOn9lieNNTQNiaLaz/a1Vr1+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eILZOyMZHeONauQocEcxIf3eoV79e+VNJ9W2BOoXAWEFyJTto70vHBS/zLYUEPRW97buKsIAFsC3QI+fftoTBfLHUfyErT7lrNE/dMYVuO1a6chxTPTCmPWZyR+0mhRMPca6M3DdrLvohh8b4KFaawLXORUOo/YCydHFWIoTuP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jD2GpF16; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750869747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TYMGHHl3ppzcVUfwHEmmDbKl7IV4fnbm0RDh4dzbFFI=;
	b=jD2GpF16C45YhpaN+ix87GrXUpWYv7ohpvK30VJgWO2YFXDhSGAk8e3bebia8Bl2YRD+Q0
	QWbk7GKQ+mL49PEBeGcQnW+E40E5k9mwKIskbEA/cpk5nTaAd2Or5x8pHU/osSfDJNg6qK
	yf5fwtgUL25dKYywZDhr0KoQQlxKlP4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-xVNaSQOgOPKGfSHWMS6BXw-1; Wed,
 25 Jun 2025 12:42:24 -0400
X-MC-Unique: xVNaSQOgOPKGfSHWMS6BXw-1
X-Mimecast-MFC-AGG-ID: xVNaSQOgOPKGfSHWMS6BXw_1750869742
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19E181956095;
	Wed, 25 Jun 2025 16:42:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65AC3195608D;
	Wed, 25 Jun 2025 16:42:16 +0000 (UTC)
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
Subject: [PATCH v2 00/16] netfs, cifs: Fixes to retry-related code and RDMA support
Date: Wed, 25 Jun 2025 17:41:55 +0100
Message-ID: <20250625164213.1408754-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Christian, Steve,

Here are some miscellaneous fixes and changes for netfslib and cifs, if you
could consider pulling them.  All the bugs fixed were observed in cifs, so
they should probably go through the cifs tree unless Christian would much
prefer for them to go through the VFS tree.

Many of these were found because a bug in Samba was causing smbd to crash
and restart after about 1-2s and this was vigorously and abruptly
exercising the netfslib retry paths.

Subsequent testing of the cifs RDMA support showed up some more bugs, for
which fixes are also included here.

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

Then a bunch of cifs fixes, some of which are from other people:

 (6-8) cifs: Fix various RPC callbacks to set NETFS_SREQ_NEED_RETRY if a
     subrequest fails retriably.

 (9) Fix a regression with SMB symlinks.

(10) Fix a warning in the workqueue code when reconnecting a channel.

(11) Fix smbd_post_send_iter() to correctly respect the max_send_size and
     to transmit all the data.

(12) Fix reading into an ITER_FOLIOQ from the smbdirect code.

(13) Fix the smbd_response slab to allow copy_to_iter() to be used on it
     without incurring a bug from the usercopy hardening code.

(14) Fix a potential deadlock during channel reconnection.

And finally a couple of patches to improve tracing output, but that should
otherwise not affect functionality:

(15) Renumber the NETFS_RREQ_* flags to make the hex values easier to
     interpret by eye, including moving the main status flags down to the
     lowest bits, with IN_PROGRESS in bit 0.

(16) Update the tracepoints in a number of ways, including adding more
     tracepoints into the cifs read/write RPC callback so that differend
     MID_RESPONSE_* values can be differentiated.

Those last two could wait for the next merge window.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (9):
  netfs: Fix hang due to missing case in final DIO read result
    collection
  netfs: Put double put of request
  netfs: Provide helpers to perform NETFS_RREQ_IN_PROGRESS flag wangling
  netfs: Fix looping in wait functions
  netfs: Fix ref leak on inserted extra subreq in write retry
  cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code
  cifs: Fix the smbd_reponse slab to allow usercopy
  netfs: Renumber the NETFS_RREQ_* flags to make traces easier to read
  netfs: Update tracepoints in a number of ways

Paulo Alcantara (6):
  smb: client: set missing retry flag in smb2_writev_callback()
  smb: client: set missing retry flag in cifs_readv_callback()
  smb: client: set missing retry flag in cifs_writev_callback()
  smb: client: fix regression with native SMB symlinks
  smb: client: fix warning when reconnecting channel
  smb: client: fix potential deadlock when reconnecting channels

Stefan Metzmacher (1):
  smb: client: let smbd_post_send_iter() respect the peers max_send_size
    and transmit all data

 fs/netfs/direct_write.c      |   1 -
 fs/netfs/internal.h          |  20 ++++-
 fs/netfs/main.c              |   6 +-
 fs/netfs/misc.c              |  50 +++++++----
 fs/netfs/read_collect.c      |  16 ++--
 fs/netfs/write_collect.c     |   8 +-
 fs/netfs/write_retry.c       |   3 +-
 fs/smb/client/cifsglob.h     |   2 +
 fs/smb/client/cifssmb.c      |  22 +++++
 fs/smb/client/connect.c      |  53 +++++++-----
 fs/smb/client/reparse.c      |  20 +----
 fs/smb/client/smb2pdu.c      |  37 +++++---
 fs/smb/client/smbdirect.c    | 163 +++++++++++++----------------------
 include/linux/netfs.h        |  20 ++---
 include/trace/events/netfs.h |  29 +++++--
 15 files changed, 245 insertions(+), 205 deletions(-)


