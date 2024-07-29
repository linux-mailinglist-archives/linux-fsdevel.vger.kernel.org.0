Return-Path: <linux-fsdevel+bounces-24486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F49D93FB1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8097D1C2206A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F7C1922DA;
	Mon, 29 Jul 2024 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAt+8V5x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40C191F92
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270179; cv=none; b=G3d2xUHRsnsfX/ShwMuJN7WO6kPSyP12OWgozh8JPCtCpdhRywYqrbjRWpnWvJFPIXANJ/E1Pjw+qR/dHDL9+DfzDXBpfOqx6BnxLMbJ9o6EzedsR+yVjK/B7uFMyVKP14YWbqBasrBJTK3NgtBIfYACbZuaqFS4Pu4Mor0pqgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270179; c=relaxed/simple;
	bh=H+ppgUJN0USWOT+d8eZ/+GDIh9HADUMZVxr1fUWv9ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G92yw3AdadVEBQPKTKLSwvbJt4VxERW0bzz/bh4XQMV89riZ7uFyDRyzi2srCSBExh2U5c6CRl1OeQnhqZ/gRfPh5uqJ7kAlQ6NBD//flsIcy132lZtTxopnP96aYYt/FB/kbHVqsrayjRmzuWOuNNtywBf1zdRgZOzwcfJeIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAt+8V5x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0kZOPMyNmDVYhInpXB87sOLpVD7+5JBPbyefcGWBPI=;
	b=fAt+8V5x0wQ0hD50KVPMKzv352auKCXhhNRMhiGgXY2LBAHbx7b8hqE03ES/VBjShnN43K
	JDemqDJVyqJgbqNWg2CTfBSdqsfmg4h7UGhDdApLaoclTGNsyHJrULhT+gWpk3EWHmWvhu
	t6WEGtxnGTnIS8PFBdlE6gQP0eF2pmo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-sRFi_MKbN4WqT1BJaC2kbQ-1; Mon,
 29 Jul 2024 12:22:53 -0400
X-MC-Unique: sRFi_MKbN4WqT1BJaC2kbQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 269871955D45;
	Mon, 29 Jul 2024 16:22:50 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BA9B19560AA;
	Mon, 29 Jul 2024 16:22:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
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
Subject: [PATCH 21/24] netfs: Cancel dirty folios that have no storage destination
Date: Mon, 29 Jul 2024 17:19:50 +0100
Message-ID: <20240729162002.3436763-22-dhowells@redhat.com>
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Kafs wants to be able to cache the contents of directories (and symlinks),
but whilst these are downloaded from the server with the FS.FetchData RPC
op and similar, the same as for regular files, they can't be updated by
FS.StoreData, but rather have special operations (FS.MakeDir, etc.).

Now, rather than redownloading a directory's content after each change made
to that directory, kafs modifies the local blob.  This blob can be saved
out to the cache, and since it's using netfslib, kafs just marks the folios
dirty and lets ->writepages() on the directory take care of it, as for an
regular file.

This is fine as long as there's a cache as although the upload stream is
disabled, there's a cache stream to drive the procedure.  But if the cache
goes away in the meantime, suddenly there's no way do any writes and the
code gets confused, complains "R=%x: No submit" to dmesg and leaves the
dirty folio hanging.

Fix this by just cancelling the store of the folio if neither stream is
active.  (If there's no cache at the time of dirtying, we should just not
mark the folio dirty).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c       | 6 +++++-
 include/trace/events/netfs.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 87a5aeb77073..0cd12c86ea91 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -397,13 +397,17 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	folio_unlock(folio);
 
 	if (fgroup == NETFS_FOLIO_COPY_TO_CACHE) {
-		if (!fscache_resources_valid(&wreq->cache_resources)) {
+		if (!cache->avail) {
 			trace_netfs_folio(folio, netfs_folio_trace_cancel_copy);
 			netfs_issue_write(wreq, upload);
 			netfs_folio_written_back(folio);
 			return 0;
 		}
 		trace_netfs_folio(folio, netfs_folio_trace_store_copy);
+	} else if (!upload->avail && !cache->avail) {
+		trace_netfs_folio(folio, netfs_folio_trace_cancel_store);
+		netfs_folio_written_back(folio);
+		return 0;
 	} else if (!upload->construct) {
 		trace_netfs_folio(folio, netfs_folio_trace_store);
 	} else {
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 4ac3b5d56ebd..1ece47af0b2f 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -151,6 +151,7 @@
 	EM(netfs_streaming_cont_filled_page,	"mod-streamw-f+") \
 	EM(netfs_folio_trace_abandon,		"abandon")	\
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
+	EM(netfs_folio_trace_cancel_store,	"cancel-store")	\
 	EM(netfs_folio_trace_clear,		"clear")	\
 	EM(netfs_folio_trace_clear_cc,		"clear-cc")	\
 	EM(netfs_folio_trace_clear_g,		"clear-g")	\


