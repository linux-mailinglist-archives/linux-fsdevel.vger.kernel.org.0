Return-Path: <linux-fsdevel+bounces-18331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040628B7827
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 16:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B387B284C40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C71180A81;
	Tue, 30 Apr 2024 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8r2NNCC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF49E17BB17
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485700; cv=none; b=NJWD/FsQC3dmisY9OpmJnJHtkliPYBli6Vn1X9KW0W3fWg/djGI/cUVIKAF7JC9VIT6qdcWEjhNZ4xJEFARfxtwjTOkqvWAWpYEZbvjj64cBPM9HlF7Qqbh4DWv9UMcWaiqD/Q70mPty6KyBuyaTk/7Om8EtssTFuKc6yeJvjzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485700; c=relaxed/simple;
	bh=hfTpBenYXqn/yYZgL0VekIwKOYS296pHNOKURBLP4z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRZTO9oWDLKvunEj9hJhmUxdn38bK+yz2bgR+OsLCI2ls5iCT5u39FTY+Bc9+bstreFkyrabTXl0mEa81qi5b8naOPdXjeM0+JWbH9F88P8l+2ga+foFaADzQ564m+Cf5Xp4D/HaPgX6Z6WF9m6YbFhmi41Rbh3dkMGsUNAuTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8r2NNCC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL4EWbx4NBAGR5Ppiq2v7C/YTDepZ3O+7v26rOrM0n0=;
	b=g8r2NNCCyPXmbW1o6LtSM2q6JCLIzb3YltUUIVZHU4cAIxvp5MDwtw3gOPvNIs17wKuLe8
	RfJft4gTFskoBr6GcYKMJbZYN3aJMgGpf7koRj50CT7vWVmMwygVjSizUjwGO9kwHBjR7l
	Zy1yuMDLwFQ4cc4WljNmMKTqTZrzsIY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529--TbzclIPMMi2MXLaTqf-qA-1; Tue,
 30 Apr 2024 10:01:33 -0400
X-MC-Unique: -TbzclIPMMi2MXLaTqf-qA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A04ED1C4C385;
	Tue, 30 Apr 2024 14:01:27 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9BCF51121313;
	Tue, 30 Apr 2024 14:01:24 +0000 (UTC)
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
Subject: [PATCH v2 06/22] netfs: Use subreq_counter to allocate subreq debug_index values
Date: Tue, 30 Apr 2024 15:00:37 +0100
Message-ID: <20240430140056.261997-7-dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-1-dhowells@redhat.com>
References: <20240430140056.261997-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Use the subreq_counter in netfs_io_request to allocate subrequest
debug_index values in read ops as well as write ops.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/io.c      | 7 ++-----
 fs/netfs/objects.c | 1 +
 fs/netfs/output.c  | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 2641238aae82..8de581ac0cfb 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -501,8 +501,7 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
  * Slice off a piece of a read request and submit an I/O request for it.
  */
 static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
-				    struct iov_iter *io_iter,
-				    unsigned int *_debug_index)
+				    struct iov_iter *io_iter)
 {
 	struct netfs_io_subrequest *subreq;
 	enum netfs_io_source source;
@@ -511,7 +510,6 @@ static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
 	if (!subreq)
 		return false;
 
-	subreq->debug_index	= (*_debug_index)++;
 	subreq->start		= rreq->start + rreq->submitted;
 	subreq->len		= io_iter->count;
 
@@ -565,7 +563,6 @@ static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
 int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 {
 	struct iov_iter io_iter;
-	unsigned int debug_index = 0;
 	int ret;
 
 	_enter("R=%x %llx-%llx",
@@ -596,7 +593,7 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 		if (rreq->origin == NETFS_DIO_READ &&
 		    rreq->start + rreq->submitted >= rreq->i_size)
 			break;
-		if (!netfs_rreq_submit_slice(rreq, &io_iter, &debug_index))
+		if (!netfs_rreq_submit_slice(rreq, &io_iter))
 			break;
 		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
 		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 72b52f070270..8acc03a64059 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -152,6 +152,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 		INIT_LIST_HEAD(&subreq->rreq_link);
 		refcount_set(&subreq->ref, 2);
 		subreq->rreq = rreq;
+		subreq->debug_index = atomic_inc_return(&rreq->subreq_counter);
 		netfs_get_request(rreq, netfs_rreq_trace_get_subreq);
 		netfs_stat(&netfs_n_rh_sreq);
 	}
diff --git a/fs/netfs/output.c b/fs/netfs/output.c
index fbdbb4f78234..e586396d6b72 100644
--- a/fs/netfs/output.c
+++ b/fs/netfs/output.c
@@ -37,7 +37,6 @@ struct netfs_io_subrequest *netfs_create_write_request(struct netfs_io_request *
 		subreq->source	= dest;
 		subreq->start	= start;
 		subreq->len	= len;
-		subreq->debug_index = atomic_inc_return(&wreq->subreq_counter);
 
 		switch (subreq->source) {
 		case NETFS_UPLOAD_TO_SERVER:


