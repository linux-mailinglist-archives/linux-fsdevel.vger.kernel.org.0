Return-Path: <linux-fsdevel+bounces-22018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295D910F16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 19:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0331F22B11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 17:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066541C2328;
	Thu, 20 Jun 2024 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvQWKUzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A51B9AB1
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904800; cv=none; b=SfMsjpGiblBzp87z/60d/YrR/p7ef8cclfjwnNWBbPGbrrXwD+RVDx72dHzxjHjqe95WeAbbpBflJArOkFbyagNrFclJMAl1j0CO4IkZe7TIIGxnsi0GtAayoBTFl87cwSO0bUj8eV1G7Etc9Vlp3OQVI7pfRSa2dC2Di1JL0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904800; c=relaxed/simple;
	bh=uNQJZwf5yvLmUciK79dFXHBncqmHSHmd+MY40pmnnuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMJ9eI+U44bqvu0Z52JV7z4OvbDokA85k/0v+5eS4XchQrRBIIagT7eE+6PZTxE02jAVuZDu1umod7Ck0/ug85WEEGJjOb9JfhhL68ULAPIdrFqeTTq2cZIrs885HLSYCOu9oYUVLWHqpNgPfw1DJdRWyx23rrJpsSQr/+Gj6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvQWKUzf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ts5ZCKmEyEPwC8pHpdqPl9OxtkpjpqDkyGOj4sN+myw=;
	b=UvQWKUzfuQ3IO5MlDBMNI1ap5zxzhO0+jz9b2M3/PdKIJqpi5zTeM84YCjIuiRFtYCwwxe
	Xos7MTdSFsY9oujJz5K5gcClizDdWQkoVGMVaOqxm1l4uFUlxpF34zjgZMVCe+PNBTtP97
	ChthCSLesdaYnN6dFPLJnPhsSKRQjMA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-OqI8PTsvNIisGVH6w9IAGQ-1; Thu,
 20 Jun 2024 13:33:14 -0400
X-MC-Unique: OqI8PTsvNIisGVH6w9IAGQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C42B1956056;
	Thu, 20 Jun 2024 17:33:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 340171955E80;
	Thu, 20 Jun 2024 17:32:56 +0000 (UTC)
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
Subject: [PATCH 09/17] cifs: Defer read completion
Date: Thu, 20 Jun 2024 18:31:27 +0100
Message-ID: <20240620173137.610345-10-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

---
 fs/smb/client/smb2pdu.c      | 15 ++++++++++++---
 include/trace/events/netfs.h |  7 +++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 38a06e8a0f90..e213cecd5094 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4484,6 +4484,16 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	return rc;
 }
 
+static void smb2_readv_worker(struct work_struct *work)
+{
+	struct cifs_io_subrequest *rdata =
+		container_of(work, struct cifs_io_subrequest, subreq.work);
+
+	netfs_subreq_terminated(&rdata->subreq,
+				(rdata->result == 0 || rdata->result == -EAGAIN) ?
+				rdata->got_bytes : rdata->result, true);
+}
+
 static void
 smb2_readv_callback(struct mid_q_entry *mid)
 {
@@ -4578,9 +4588,8 @@ smb2_readv_callback(struct mid_q_entry *mid)
 			rdata->result = 0;
 	}
 	rdata->credits.value = 0;
-	netfs_subreq_terminated(&rdata->subreq,
-				(rdata->result == 0 || rdata->result == -EAGAIN) ?
-				rdata->got_bytes : rdata->result, true);
+	INIT_WORK(&rdata->subreq.work, smb2_readv_worker);
+	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
 }
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index fc5dbd19f120..db603a4e22cd 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -412,6 +412,7 @@ TRACE_EVENT(netfs_folio,
 		    __field(ino_t,			ino)
 		    __field(pgoff_t,			index)
 		    __field(unsigned int,		nr)
+		    __field(bool,			ra_trigger)
 		    __field(enum netfs_folio_trace,	why)
 			     ),
 
@@ -420,11 +421,13 @@ TRACE_EVENT(netfs_folio,
 		    __entry->why = why;
 		    __entry->index = folio_index(folio);
 		    __entry->nr = folio_nr_pages(folio);
+		    __entry->ra_trigger = folio_test_readahead(folio);
 			   ),
 
-	    TP_printk("i=%05lx ix=%05lx-%05lx %s",
+	    TP_printk("i=%05lx ix=%05lx-%05lx %s%s",
 		      __entry->ino, __entry->index, __entry->index + __entry->nr - 1,
-		      __print_symbolic(__entry->why, netfs_folio_traces))
+		      __print_symbolic(__entry->why, netfs_folio_traces),
+		      __entry->ra_trigger ? " *RA*" : "")
 	    );
 
 TRACE_EVENT(netfs_write_iter,


