Return-Path: <linux-fsdevel+bounces-37292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C63F9F0DB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E9718811AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E061E0DAF;
	Fri, 13 Dec 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xy+eugGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A91E04A0
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097835; cv=none; b=Xp6XZK8iGWiIPcuc9IUH//4zZtYuCQVNfMWPa55V/t3lDZZAsVIA9mQhCKVXhNhCHMU31cBZ2wlWg9Xx44wCplVILMO0UgXbJ6WXYAriAZ/4pKykxBDEATuwwTxO79HRUftR0BOQYYY3N/xTdapELqdgWspi6YTDcnrbj3G8t+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097835; c=relaxed/simple;
	bh=yrjsEmooXq2ypadXEezCFG+UKHZM0Z6P5rrlvhFilyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLjNE/d+QfTl3YD16jG+udBAWz99n4T1cKyrcqL9z13nuddhCPZxsVt5FX2p30EH3zz8mfQYkqoswXNfiNbTqLL2Sr/GVl7rkfwru1aBOTbkOUiQtWtYX1LseJS65aVDDDogyMSEhOl8pIxJwwcAOTdGA+n2L0Fspxi0d3zdOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xy+eugGA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zlbVdG3EuDS4xv5qOG5kSQTp/vih38GtqzMbAmIdEqA=;
	b=Xy+eugGAdUa4S4WYt3WqLWhpyCJk3Zh7tUZ6MYUz3Le/i4Z+rkaPv4Mr9WSLj6N3QBFBDr
	UGinOaQGEuyLhUVakj/Qo+BcMSj9PBeOSBWXDdbVsIBxRYPO0ZMkL7CxrdWi+aKW6aqfrB
	Xea9luuyaxARGOH09ZU8CSPyDjAG+RU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-woItBugOMb6D8BiRItruoA-1; Fri,
 13 Dec 2024 08:50:26 -0500
X-MC-Unique: woItBugOMb6D8BiRItruoA-1
X-Mimecast-MFC-AGG-ID: woItBugOMb6D8BiRItruoA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23A451955D4B;
	Fri, 13 Dec 2024 13:50:22 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8520330044C1;
	Fri, 13 Dec 2024 13:50:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] netfs, ceph, nfs, cachefiles: Miscellaneous fixes/changes
Date: Fri, 13 Dec 2024 13:50:00 +0000
Message-ID: <20241213135013.2964079-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Christian,

Here are some miscellaneous fixes and changes for netfslib and the ceph and
nfs filesystems:

 (1) Ignore silly-rename files from afs and nfs when building the header
     archive in a kernel build.

 (2) netfs: Fix the way read result collection applies results to folios
     when each folio is being read by multiple subrequests and the results
     come out of order.

 (3) netfs: Fix ENOMEM handling in buffered reads.

 (4) nfs: Fix an oops in nfs_netfs_init_request() when copying to the cache.

 (5) cachefiles: Parse the "secctx" command immediately to get the correct
     error rather than leaving it to the "bind" command.

 (6) netfs: Remove a redundant smp_rmb().  This isn't a bug per se and
     could be deferred.

 (7) netfs: Fix missing barriers by using clear_and_wake_up_bit().

 (8) netfs: Work around recursion in read retry by failing and abandoning
     the retried subrequest if no I/O is performed.

     [!] NOTE: This only works around the recursion problem if the
     	 recursion keeps returning no data.  If the server manages, say, to
     	 repeatedly return a single byte of data faster than the retry
     	 algorithm can complete, it will still recurse and the stack
     	 overrun may still occur.  Actually fixing this requires quite an
     	 intrusive change which will hopefully make the next merge window.

 (9) netfs: Fix the clearance of a folio_queue when unlocking the page if
     we're going to want to subsequently send the queue for copying to the
     cache (if, for example, we're using ceph).

(10) netfs: Fix the lack of cancellation of copy-to-cache when the cache
     for a file is temporarily disabled (for example when a DIO write is
     done to the file).  This patch and (9) fix hangs with ceph.

With these patches, I can run xfstest -g quick to completion on ceph with a
local cache.

The patches can also be found here with a bonus cifs patch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (8):
  kheaders: Ignore silly-rename files
  netfs: Fix non-contiguous donation between completed reads
  netfs: Fix enomem handling in buffered reads
  nfs: Fix oops in nfs_netfs_init_request() when copying to cache
  netfs: Fix missing barriers by using clear_and_wake_up_bit()
  netfs: Work around recursion by abandoning retry if nothing read
  netfs: Fix ceph copy to cache on write-begin
  netfs: Fix the (non-)cancellation of copy when cache is temporarily
    disabled

Max Kellermann (1):
  cachefiles: Parse the "secctx" immediately

Zilin Guan (1):
  netfs: Remove redundant use of smp_rmb()

 fs/9p/vfs_addr.c         |  6 +++++-
 fs/afs/write.c           |  5 ++++-
 fs/cachefiles/daemon.c   | 14 +++++++-------
 fs/cachefiles/internal.h |  3 ++-
 fs/cachefiles/security.c |  6 +++---
 fs/netfs/buffered_read.c | 28 ++++++++++++++++------------
 fs/netfs/direct_write.c  |  1 -
 fs/netfs/read_collect.c  | 33 +++++++++++++++++++--------------
 fs/netfs/read_pgpriv2.c  |  4 ++++
 fs/netfs/read_retry.c    |  6 ++++--
 fs/netfs/write_collect.c | 14 +++++---------
 fs/netfs/write_issue.c   |  2 ++
 fs/nfs/fscache.c         |  9 ++++++++-
 fs/smb/client/cifssmb.c  | 13 +++++++++----
 fs/smb/client/smb2pdu.c  |  9 ++++++---
 include/linux/netfs.h    |  6 +++---
 kernel/gen_kheaders.sh   |  1 +
 17 files changed, 98 insertions(+), 62 deletions(-)


