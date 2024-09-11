Return-Path: <linux-fsdevel+bounces-29122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C88E975AEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 21:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0471F285D13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 19:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2471BA888;
	Wed, 11 Sep 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+Dw7Eba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAF91BA277
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083796; cv=none; b=ZdRSVfnDX8sHLPPZaMx5fUc2gUIbC5fLuibGEeXVQlbrEJ9wKb4TYK/1CfndbwSjIjhFV/hpBwNeoFKXmauUJYyjG0nx/r3m2KJrT5CHS4eLFOI9B1+6CAEWpyt0J2cu4usw6HaPUu7xhUFRCympfE6zrDqCJIlYcgGm7D3kN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083796; c=relaxed/simple;
	bh=fc23IZuIEY2URFYPzyp37ykpohdad+TCX5KOlULCAQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VShSUfAw7/BjmXlhy3x3f5tz+nifR0lviDiAPnWOSfTmWymy8bw27ecp0vp0Ei1DKM4CzUTroEHnaamQYEE8IecA40h/d1knFGC/9QRiMqHR4nCiXNAuMJMzPudCXGGnbmSHKfnTY/g3E3Rihg5biICr4m3KEy+YEk3ISBHz03o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+Dw7Eba; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726083793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jfjK+0U85uvSGEsnGWsahhya+Xw2ihZr5BH0W7SsSlQ=;
	b=G+Dw7Ebaa95T0ImD7Xt8Bmjusc9oXi7MnwpLLh6JjAJWAlbN4ZzX+RO4szVqW5yT6oqjb4
	29W3kKcfRaD6g9hthQ6zkxET7EeMQU53fldDMF+z+y87Saq87HxSsyjLquYyH3pHy/MTjc
	4/RcHWtHaSZM/NVOuiXEj0fctPGy4vA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-6tuEGQ03PWuP78CkMOpNrg-1; Wed,
 11 Sep 2024 15:43:10 -0400
X-MC-Unique: 6tuEGQ03PWuP78CkMOpNrg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 659D71955D45;
	Wed, 11 Sep 2024 19:43:07 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.7])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 16F221956086;
	Wed, 11 Sep 2024 19:43:01 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Ahring Oder Aring <aahringo@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev,
	ocfs2-devel@lists.linux.dev
Subject: [PATCH v1 0/4] Fixup NLM and kNFSD file lock callbacks
Date: Wed, 11 Sep 2024 15:42:56 -0400
Message-ID: <cover.1726083391.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Last year both GFS2 and OCFS2 had some work done to make their locking more
robust when exported over NFS.  Unfortunately, part of that work caused both
NLM (for NFS v3 exports) and kNFSD (for NFSv4.1+ exports) to no longer send
lock notifications to clients.

This in itself is not a huge problem because most NFS clients will still
poll the server in order to acquire a conflicted lock, but now that I've
noticed it I can't help but try to fix it because there are big advantages
for setups that might depend on timely lock notifications, and we've
supported that as a feature for a long time.

Its important for NLM and kNFSD that they do not block their kernel threads
inside filesystem's file_lock implementations because that can produce
deadlocks.  We used to make sure of this by only trusting that
posix_lock_file() can correctly handle blocking lock calls asynchronously,
so the lock managers would only setup their file_lock requests for async
callbacks if the filesystem did not define its own lock() file operation.

However, when GFS2 and OCFS2 grew the capability to correctly
handle blocking lock requests asynchronously, they started signalling this
behavior with EXPORT_OP_ASYNC_LOCK, and the check for also trusting
posix_lock_file() was inadvertently dropped, so now most filesystems no
longer produce lock notifications when exported over NFS.

I tried to fix this by simply including the old check for lock(), but the
resulting include mess and layering violations was more than I could accept.
There's a much cleaner way presented here using an fop_flag, which while
potentially flag-greedy, greatly simplifies the problem and grooms the
way for future uses by both filesystems and lock managers alike.

Criticism welcomed,
Ben

Benjamin Coddington (4):
  fs: Introduce FOP_ASYNC_LOCK
  gfs2/ocfs2: set FOP_ASYNC_LOCK
  NLM/NFSD: Fix lock notifications for async-capable filesystems
  exportfs: Remove EXPORT_OP_ASYNC_LOCK

 Documentation/filesystems/nfs/exporting.rst |  7 -------
 fs/gfs2/export.c                            |  1 -
 fs/gfs2/file.c                              |  2 ++
 fs/lockd/svclock.c                          |  5 ++---
 fs/nfsd/nfs4state.c                         | 19 ++++---------------
 fs/ocfs2/export.c                           |  1 -
 fs/ocfs2/file.c                             |  2 ++
 include/linux/exportfs.h                    | 13 -------------
 include/linux/filelock.h                    |  5 +++++
 include/linux/fs.h                          |  2 ++
 10 files changed, 17 insertions(+), 40 deletions(-)

-- 
2.44.0


