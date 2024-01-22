Return-Path: <linux-fsdevel+bounces-8421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12A3836367
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 13:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C9D2931DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7003C68A;
	Mon, 22 Jan 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKgKdcHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9713C693
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927139; cv=none; b=MgH0w8jsRALTa7DQecE5sHVfrGZTWO6p9uc9ZYQrd3RSECqtShdQFiLN6pK4AmSMWfl7YTbfAkNjCd6/CESm/6fiRgArMKdSVVuYINRPGYjdABI7uPgPgFz541e4zfii2Pn/1AQlJLukTZU7SaGiROBrgUHiOHqkLawyObYkmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927139; c=relaxed/simple;
	bh=zeo2jxGPanKotKy5hjByOmMTkO1G/PEVRSjvkrtHUsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmPTebI56KK5MEMCYo8Fz+UmESUqGJ614elLZbiXNkNtntiBmqEh4AQa9OEWB3XMBJg4xc2w/smP0hxnm7p0J+kIkOCkdGWaFzQrkaQesIbgxoJ82U0XXHYOBJP3pbrazkgDwq0G6dXEQ5tZcOhYzQmcLyPQKzk8wZgTCeICC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKgKdcHr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705927135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ca8cxTevNKQzpblzOoDFxpwIIAtXLPpPEjrN9AhhcL4=;
	b=RKgKdcHrFyu019r76hlVwfa3nS8Efh+Iu9Hno3MYGhbCAAA5llbSV9qIJ/Z+pjH9vDAVkf
	vgjFAz8xYHwMs8fqoGPwqzVbtxjrPBUUYjsSqGQqGHMyV1gq5jPw7LPr3MqcB7aH670rqA
	jjfwobX9tc4HmBsolSaf28kjsAt5gXs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-RK-uI1WhPqCXplc0tNwNjw-1; Mon, 22 Jan 2024 07:38:52 -0500
X-MC-Unique: RK-uI1WhPqCXplc0tNwNjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 555BC85A58A;
	Mon, 22 Jan 2024 12:38:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8060F111E408;
	Mon, 22 Jan 2024 12:38:49 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
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
Subject: [PATCH 00/10] netfs, afs, cifs, cachefiles, erofs: Miscellaneous fixes
Date: Mon, 22 Jan 2024 12:38:33 +0000
Message-ID: <20240122123845.3822570-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi Christian,

Here are some miscellaneous fixes for netfslib and a number of filesystems:

 (1) Replace folio_index() with folio->index in netfs, afs and cifs.

 (2) Fix an oops in fscache_put_cache().

 (3) Fix error handling in netfs_perform_write().

 (4) Fix an oops in cachefiles when not using erofs ondemand mode.

 (5) In afs, hide silly-rename files from getdents() to avoid problems with
     tar and suchlike.

 (6) In afs, fix error handling in lookup with a bulk status fetch.

 (7) In afs, afs_dynroot_d_revalidate() is redundant, so remove it.

 (8) In afs, fix the RCU unlocking in afs_proc_addr_prefs_show().

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

Dan Carpenter (2):
  netfs, fscache: Prevent Oops in fscache_put_cache()
  netfs: Fix a NULL vs IS_ERR() check in netfs_perform_write()

David Howells (8):
  netfs: Don't use certain internal folio_*() functions
  afs: Don't use certain internal folio_*() functions
  cifs: Don't use certain internal folio_*() functions
  cachefiles, erofs: Fix NULL deref in when cachefiles is not doing
    ondemand-mode
  afs: Hide silly-rename files from userspace
  afs: Fix error handling with lookup via FS.InlineBulkStatus
  afs: Remove afs_dynroot_d_revalidate() as it is redundant
  afs: Fix missing/incorrect unlocking of RCU read lock

 fs/afs/dir.c               | 30 ++++++++++++++++++++++--------
 fs/afs/dynroot.c           |  9 ---------
 fs/afs/proc.c              |  5 +++--
 fs/cachefiles/namei.c      | 16 ++++++++++------
 fs/netfs/buffered_read.c   | 12 ++++++------
 fs/netfs/buffered_write.c  | 15 ++++++++-------
 fs/netfs/fscache_cache.c   |  3 ++-
 fs/netfs/io.c              |  2 +-
 fs/netfs/misc.c            |  2 +-
 fs/smb/client/file.c       | 10 +++++-----
 include/trace/events/afs.h | 25 +++++++++++++++++++++++++
 11 files changed, 83 insertions(+), 46 deletions(-)


