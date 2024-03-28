Return-Path: <linux-fsdevel+bounces-15578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C793890620
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30AFE1F26727
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C4B13EFEC;
	Thu, 28 Mar 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4VOipao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CE13E6BB
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643951; cv=none; b=l7HaYSLFp9UHy/K8sL8U8HLoZykipL8/PWinGA7flpea+uKdripJLYnm7EBrEmxNBgrtOp7DWG8zlhcEpOdmUkTqj//oW9VobaeUVSqBdnujgjOG6xbWdxXzVFqhwH+fyGsUuS/Drt/hIKeetKoXEnioc0APRb8mztN4eTWJatg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643951; c=relaxed/simple;
	bh=MAIqSjQERVWt0fnm/r+aJyHmAmzJNkiIx6wQJyJNF7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzYOhZE/HaQZxll/z93/PFXDRT4mn/7hu8E4iQ52CuKRSwbNxkYBShab9DffblV8tdl52g7QRi+zxQ9+4/CTtqGH40zt8zGXN6dXVQauju7ZFUAAt2Z5oB3FzTSml+Rt0s6cF8Ko0KqxLV1hnemlnOCR1u4N0sfnhV7r0ESrOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4VOipao; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=456sspCvb5RC8F6uPLvmqcL+ECbtkHJJvcCgmdRCz9o=;
	b=L4VOipaoKxSwD0zzONBR5LSeoc5MRbKmtboEye0ef61Y2PtSBKb2QmugjUbbJT/91fO9t6
	ykX8Yl25pvWWQUMREjbSokt2TygYjsWTBtIRVMm6R/SQYIuI5ewpW6UKpXlmsktUb2W1ZN
	PmZVBfGjCVwtchvd9q1wLOGjBFDQGvE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-5Oh98SDqMqqEMoYuR2MDaA-1; Thu, 28 Mar 2024 12:39:02 -0400
X-MC-Unique: 5Oh98SDqMqqEMoYuR2MDaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02433933EF8;
	Thu, 28 Mar 2024 16:39:01 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F1AEB1C060D0;
	Thu, 28 Mar 2024 16:38:57 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 25/26] netfs: Miscellaneous tidy ups
Date: Thu, 28 Mar 2024 16:34:17 +0000
Message-ID: <20240328163424.2781320-26-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Do a couple of miscellaneous tidy ups:

 (1) Add a qualifier into a file banner comment.

 (2) Put the writeback folio traces back into alphabetical order.

 (3) Remove some unused folio traces.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c    | 2 +-
 include/trace/events/netfs.h | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 2da9905abec9..1eff9413eb1b 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Network filesystem high-level write support.
+/* Network filesystem high-level buffered write support.
  *
  * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index e7700172ae7e..4ba553a6d71b 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -141,12 +141,9 @@
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
 	EM(netfs_folio_trace_clear,		"clear")	\
 	EM(netfs_folio_trace_clear_cc,		"clear-cc")	\
-	EM(netfs_folio_trace_clear_s,		"clear-s")	\
 	EM(netfs_folio_trace_clear_g,		"clear-g")	\
-	EM(netfs_folio_trace_copy,		"copy")		\
-	EM(netfs_folio_trace_copy_plus,		"copy+")	\
+	EM(netfs_folio_trace_clear_s,		"clear-s")	\
 	EM(netfs_folio_trace_copy_to_cache,	"mark-copy")	\
-	EM(netfs_folio_trace_end_copy,		"end-copy")	\
 	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
 	EM(netfs_folio_trace_kill,		"kill")		\
 	EM(netfs_folio_trace_kill_cc,		"kill-cc")	\
@@ -156,7 +153,6 @@
 	EM(netfs_folio_trace_mkwrite_plus,	"mkwrite+")	\
 	EM(netfs_folio_trace_not_under_wback,	"!wback")	\
 	EM(netfs_folio_trace_read_gaps,		"read-gaps")	\
-	EM(netfs_folio_trace_redirty,		"redirty")	\
 	EM(netfs_folio_trace_redirtied,		"redirtied")	\
 	EM(netfs_folio_trace_store,		"store")	\
 	EM(netfs_folio_trace_store_copy,	"store-copy")	\


