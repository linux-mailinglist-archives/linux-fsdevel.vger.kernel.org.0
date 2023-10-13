Return-Path: <linux-fsdevel+bounces-287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F6E7C89C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E9C0B20F88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46974219E9;
	Fri, 13 Oct 2023 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqgUu0q7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483681C6BC
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:05:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FB718A
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697213110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntUQ/reWYDAgg2miRGVf+hR8qevYgo6i7or36auU25I=;
	b=AqgUu0q7sVJIeLNab+QUANdqCin6+FGjqlsv27XPAp3mZODA2aF0QB3nvE3EXxvUuxLDxn
	npPanjfNndNtRFUzlFmN8EEMKoNqWL61hvQKqOLZ4817yOYC256v7I+1SMu7DlBahs5SJM
	HsFWYbDazem5QoeG2pylfich+JLZiKw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-681--Tly13tIP_OoFZmS3aBALw-1; Fri, 13 Oct 2023 12:05:05 -0400
X-MC-Unique: -Tly13tIP_OoFZmS3aBALw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FBB83C40C20;
	Fri, 13 Oct 2023 16:05:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E4F5C1C06535;
	Fri, 13 Oct 2023 16:05:01 +0000 (UTC)
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
Subject: [RFC PATCH 11/53] netfs: Add support for DIO buffering
Date: Fri, 13 Oct 2023 17:03:40 +0100
Message-ID: <20231013160423.2218093-12-dhowells@redhat.com>
In-Reply-To: <20231013160423.2218093-1-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a bvec array pointer and an iterator to netfs_io_request for either
holding a copy of a DIO iterator or a list of all the bits of buffer
pointed to by a DIO iterator.

There are two problems:  Firstly, if an iovec-class iov_iter is passed to
->read_iter() or ->write_iter(), this cannot be passed directly to
kernel_sendmsg() or kernel_recvmsg() as that may cause locking recursion if
a fault is generated, so we need to keep track of the pages involved
separately.

Secondly, if the I/O is asynchronous, we must copy the iov_iter describing
the buffer before returning to the caller as it may be immediately
deallocated.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/objects.c    | 10 ++++++++++
 include/linux/netfs.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 8e92b8401aaa..4396318081bf 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -78,6 +78,7 @@ static void netfs_free_request(struct work_struct *work)
 {
 	struct netfs_io_request *rreq =
 		container_of(work, struct netfs_io_request, work);
+	unsigned int i;
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
 	netfs_proc_del_rreq(rreq);
@@ -86,6 +87,15 @@ static void netfs_free_request(struct work_struct *work)
 		rreq->netfs_ops->free_request(rreq);
 	if (rreq->cache_resources.ops)
 		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
+	if (rreq->direct_bv) {
+		for (i = 0; i < rreq->direct_bv_count; i++) {
+			if (rreq->direct_bv[i].bv_page) {
+				if (rreq->direct_bv_unpin)
+					unpin_user_page(rreq->direct_bv[i].bv_page);
+			}
+		}
+		kvfree(rreq->direct_bv);
+	}
 	kfree_rcu(rreq, rcu);
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index bd0437088f0e..66479a61ad00 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -191,7 +191,9 @@ struct netfs_io_request {
 	struct list_head	subrequests;	/* Contributory I/O operations */
 	struct iov_iter		iter;		/* Unencrypted-side iterator */
 	struct iov_iter		io_iter;	/* I/O (Encrypted-side) iterator */
+	struct bio_vec		*direct_bv;	/* DIO buffer list (when handling iovec-iter) */
 	void			*netfs_priv;	/* Private data for the netfs */
+	unsigned int		direct_bv_count; /* Number of elements in bv[] */
 	unsigned int		debug_id;
 	unsigned int		rsize;		/* Maximum read size (0 for none) */
 	atomic_t		nr_outstanding;	/* Number of ops in progress */
@@ -200,6 +202,7 @@ struct netfs_io_request {
 	size_t			len;		/* Length of the request */
 	short			error;		/* 0 or error that occurred */
 	enum netfs_io_origin	origin;		/* Origin of the request */
+	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
 	loff_t			i_size;		/* Size of the file */
 	loff_t			start;		/* Start position */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */


