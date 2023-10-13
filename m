Return-Path: <linux-fsdevel+bounces-280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D327C8998
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B26B20CD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50B51D6B0;
	Fri, 13 Oct 2023 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHjoogeV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D71D54C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:04:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9607EC9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697213083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcj4568/Cja75cJgRJVpO1Pa05t3rY5GzidcrAxRiJc=;
	b=ZHjoogeVXWGbXwl6J6xoFy+27jocsKMn6iD0jOTJOa919OSJaZV/mPtEeBpgsps/qnfASf
	fsr5waeOI8IAbz5IUOcsn+pguoXkxcaCL29B2tDqxtH+0rjuLzXJ401/0iHCkS8MEs5UE2
	afzxQjit/Gp2RY97CrQCgJm65vbwiz8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-7pwZptOZM4Gupdab9T4_0w-1; Fri, 13 Oct 2023 12:04:42 -0400
X-MC-Unique: 7pwZptOZM4Gupdab9T4_0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16FBB2810D7B;
	Fri, 13 Oct 2023 16:04:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 90FC92157F5A;
	Fri, 13 Oct 2023 16:04:38 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cachefs@redhat.com
Subject: [RFC PATCH 04/53] netfs: Allow the netfs to make the io (sub)request alloc larger
Date: Fri, 13 Oct 2023 17:03:33 +0100
Message-ID: <20231013160423.2218093-5-dhowells@redhat.com>
In-Reply-To: <20231013160423.2218093-1-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Allow the network filesystem to specify extra space to be allocated on the
end of the io (sub)request.  This allows cifs, for example, to use this
space rather than allocating its own cifs_readdata struct.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/objects.c    | 7 +++++--
 include/linux/netfs.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index e41f9fc9bdd2..2f1865ff7cce 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -22,7 +22,8 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	struct netfs_io_request *rreq;
 	int ret;
 
-	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
+	rreq = kzalloc(ctx->ops->io_request_size ?: sizeof(struct netfs_io_request),
+		       GFP_KERNEL);
 	if (!rreq)
 		return ERR_PTR(-ENOMEM);
 
@@ -116,7 +117,9 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 {
 	struct netfs_io_subrequest *subreq;
 
-	subreq = kzalloc(sizeof(struct netfs_io_subrequest), GFP_KERNEL);
+	subreq = kzalloc(rreq->netfs_ops->io_subrequest_size ?:
+			 sizeof(struct netfs_io_subrequest),
+			 GFP_KERNEL);
 	if (subreq) {
 		INIT_LIST_HEAD(&subreq->rreq_link);
 		refcount_set(&subreq->ref, 2);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index b92e982ac4a0..6942b8cf03dc 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -214,6 +214,8 @@ struct netfs_io_request {
  * Operations the network filesystem can/must provide to the helpers.
  */
 struct netfs_request_ops {
+	unsigned int	io_request_size;	/* Alloc size for netfs_io_request struct */
+	unsigned int	io_subrequest_size;	/* Alloc size for netfs_io_subrequest struct */
 	int (*init_request)(struct netfs_io_request *rreq, struct file *file);
 	void (*free_request)(struct netfs_io_request *rreq);
 	int (*begin_cache_operation)(struct netfs_io_request *rreq);


