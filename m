Return-Path: <linux-fsdevel+bounces-49410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C57ACABBFB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6E64A2364
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1624A27B519;
	Mon, 19 May 2025 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRUr7YKl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13B27FD72
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662513; cv=none; b=P//EIhMObSUZ66xHMmVuA6K/QDJUTFwyMaCLc9ReJlSKT7POQVpAhOF0rqkH5qZwF45VbMwbgq2PZJSS+XQ2ktmugLSaeafbfpun8PmjlViX389hxpR22sPMrP8Dj6cqWveXud+t62m6ckJfRQtQyciaBfXFpcyN3OnTwWvsAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662513; c=relaxed/simple;
	bh=0kFUN0Bb4ZQZ98YAUM8AzAOqvp9BJdqBdqhGWpmyTRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gq87RAlaF5whzCSqBPOGJVbQGdM9DBZOooT7yGXpwJbZcFwJsk3WevDuBPk1F5eAU4eB2DhBCJUruRO24NL4A1dXtTvt03VnkDqtPVr720VHGtTR9ANIjWTDxKpbvnA6fWQ+fNOjDA8xCLToGPH/Q5TjymyYoJ0SyIQzoRqPF5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRUr7YKl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747662510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OoTF+qmsx6IE6mLtdNrrcrScQMVpnF3mNudHwgneH7s=;
	b=PRUr7YKlMquhPw/vCfXUqwJ6oXf79awXuQP44g+YhJLPbg6douW3rXzc9ApCOS0+Yvp+7c
	tZvLh9rP0vc56Ir+UnUDPJLFuh+Y+G4yZurKmxSaAwH1RNswcKe35gT9O9pJ0cdtESoF2M
	ckb8wTxLrpMfoIpK3Kmc6akmwT3ybPQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-s83dwMDsNoWSP8UzoDUabg-1; Mon,
 19 May 2025 09:48:28 -0400
X-MC-Unique: s83dwMDsNoWSP8UzoDUabg-1
X-Mimecast-MFC-AGG-ID: s83dwMDsNoWSP8UzoDUabg_1747662506
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 410F518004A7;
	Mon, 19 May 2025 13:48:26 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CA1A18003FC;
	Mon, 19 May 2025 13:48:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] netfs: Miscellaneous cleanups
Date: Mon, 19 May 2025 14:47:56 +0100
Message-ID: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Christian,

Here are some miscellaneous very minor cleanups for netfslib for the next
merge window, primarily from Max Kellermann, if you could pull them.

 (0) Update the netfs docs.  This is already in the VFS tree, but it's a
     dependency for other patches here.

 (1) Remove NETFS_SREQ_SEEK_DATA_READ.

 (2) Remove NETFS_INVALID_WRITE.

 (3) Remove NETFS_ICTX_WRITETHROUGH.

 (4) Remove NETFS_READ_HOLE_CLEAR.

 (5) Reorder structs to eliminate holes.

 (6) Remove netfs_io_request::ractl.

 (7) Only provide proc_link field if CONFIG_PROC_FS=y.

 (8) Remove folio_queue::marks3.

 (9) Remove NETFS_RREQ_DONT_UNLOCK_FOLIOS.

(10) Remove NETFS_RREQ_BLOCKED.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-next

Thanks,
David

David Howells (1):
  netfs: Update main API document

Max Kellermann (10):
  fs/netfs: remove unused flag NETFS_SREQ_SEEK_DATA_READ
  fs/netfs: remove unused source NETFS_INVALID_WRITE
  fs/netfs: remove unused flag NETFS_ICTX_WRITETHROUGH
  fs/netfs: remove unused enum choice NETFS_READ_HOLE_CLEAR
  fs/netfs: reorder struct fields to eliminate holes
  fs/netfs: remove `netfs_io_request.ractl`
  fs/netfs: declare field `proc_link` only if CONFIG_PROC_FS=y
  folio_queue: remove unused field `marks3`
  fs/netfs: remove unused flag NETFS_RREQ_DONT_UNLOCK_FOLIOS
  fs/netfs: remove unused flag NETFS_RREQ_BLOCKED

 Documentation/core-api/folio_queue.rst      |    3 -
 Documentation/filesystems/netfs_library.rst | 1013 ++++++++++++++-----
 fs/netfs/buffered_read.c                    |   24 +-
 fs/netfs/buffered_write.c                   |    3 +-
 fs/netfs/direct_read.c                      |    3 -
 fs/netfs/objects.c                          |    2 -
 fs/netfs/read_collect.c                     |   14 +-
 fs/netfs/write_collect.c                    |    2 -
 include/linux/folio_queue.h                 |   42 -
 include/linux/fscache.h                     |    3 -
 include/linux/netfs.h                       |   30 +-
 include/trace/events/netfs.h                |    3 +-
 12 files changed, 767 insertions(+), 375 deletions(-)


