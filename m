Return-Path: <linux-fsdevel+bounces-32772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3469AE7FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 16:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706F2286EFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CEE20604B;
	Thu, 24 Oct 2024 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHGvw5zK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5DD1EF0A0
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778893; cv=none; b=UAVm+kXfcsxDtIYkgVxkZPFRr/vSeSALzeHNTKLdA5/l6i2lqMb9veefy9HDHBkH18lqe/ofN3Laeloycfn5J8uKycKFCA0WnLrpTlQM4pavmkY5mpZlOdVIXCrRjEHQvRize2pcicCaLtWKEhs2IdFOXJYnbQphiPeTgYC2zoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778893; c=relaxed/simple;
	bh=Iu5W7GQDrF6wAgpzj6wnYkl7V7v8hp++3GNg/ZYfmXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1bbiJCVL4zW4/ZV0XF7W3Ii8TO0uXQOoGKKMMPnvfsTR/RFNbYfVYq0W5M6ytUo3KXlIdKkHOur50GiehBZecSCSYGx/KxHlQECTpsT808NVGeb9WWOppIVGHUufEnzNNUYgVG7CeImlvuu+G7xt/t6smyRptscbp/WN6/gjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHGvw5zK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZQE6Gk2pDLRsrGirLF3LOxjqtk3JDWUrBtiyK47AD0=;
	b=HHGvw5zK6+M8xtW5+IjbITndJ9WpGrBHcK61zEHWu0Kg0A5EBNF7olrs+4TvZcn7SmaEmk
	iLhLGeg/+Cdh3Sso5IO8Voz1n9tlGjmC659CMTfRRiJdHSBubXLdu+er/2AUV6gc/mI+12
	odHTKj19sUw0lIwNGK/EX9t9+IRj5D0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-LJzRLwyPP5e6Mlw0i1E05Q-1; Thu,
 24 Oct 2024 10:08:06 -0400
X-MC-Unique: LJzRLwyPP5e6Mlw0i1E05Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7271A1955D52;
	Thu, 24 Oct 2024 14:08:03 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E72E61956088;
	Thu, 24 Oct 2024 14:07:57 +0000 (UTC)
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
Subject: [PATCH 17/27] cachefiles: Add auxiliary data trace
Date: Thu, 24 Oct 2024 15:05:15 +0100
Message-ID: <20241024140539.3828093-18-dhowells@redhat.com>
In-Reply-To: <20241024140539.3828093-1-dhowells@redhat.com>
References: <20241024140539.3828093-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add a display of the first 8 bytes of the downloaded auxiliary data and of
the on-disk stored auxiliary data as these are used in coherency
management.  In the case of afs, this holds the data version number.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/xattr.c             |  9 ++++++++-
 include/trace/events/cachefiles.h | 13 ++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 7c6f260a3be5..52383b1d0ba6 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -77,6 +77,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 		trace_cachefiles_vfs_error(object, file_inode(file), ret,
 					   cachefiles_trace_setxattr_error);
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+					   be64_to_cpup((__be64 *)buf->data),
 					   buf->content,
 					   cachefiles_coherency_set_fail);
 		if (ret != -ENOMEM)
@@ -85,6 +86,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 				"Failed to set xattr with error %d", ret);
 	} else {
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+					   be64_to_cpup((__be64 *)buf->data),
 					   buf->content,
 					   cachefiles_coherency_set_ok);
 	}
@@ -126,7 +128,10 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 				object,
 				"Failed to read aux with error %zd", xlen);
 		why = cachefiles_coherency_check_xattr;
-	} else if (buf->type != CACHEFILES_COOKIE_TYPE_DATA) {
+		goto out;
+	}
+
+	if (buf->type != CACHEFILES_COOKIE_TYPE_DATA) {
 		why = cachefiles_coherency_check_type;
 	} else if (memcmp(buf->data, p, len) != 0) {
 		why = cachefiles_coherency_check_aux;
@@ -141,7 +146,9 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 		ret = 0;
 	}
 
+out:
 	trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+				   be64_to_cpup((__be64 *)buf->data),
 				   buf->content, why);
 	kfree(buf);
 	return ret;
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 7d931db02b93..775a72e6adc6 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -380,10 +380,11 @@ TRACE_EVENT(cachefiles_rename,
 TRACE_EVENT(cachefiles_coherency,
 	    TP_PROTO(struct cachefiles_object *obj,
 		     ino_t ino,
+		     u64 disk_aux,
 		     enum cachefiles_content content,
 		     enum cachefiles_coherency_trace why),
 
-	    TP_ARGS(obj, ino, content, why),
+	    TP_ARGS(obj, ino, disk_aux, content, why),
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
@@ -391,6 +392,8 @@ TRACE_EVENT(cachefiles_coherency,
 		    __field(enum cachefiles_coherency_trace,	why	)
 		    __field(enum cachefiles_content,		content	)
 		    __field(u64,				ino	)
+		    __field(u64,				aux	)
+		    __field(u64,				disk_aux)
 			     ),
 
 	    TP_fast_assign(
@@ -398,13 +401,17 @@ TRACE_EVENT(cachefiles_coherency,
 		    __entry->why	= why;
 		    __entry->content	= content;
 		    __entry->ino	= ino;
+		    __entry->aux	= be64_to_cpup((__be64 *)obj->cookie->inline_aux);
+		    __entry->disk_aux	= disk_aux;
 			   ),
 
-	    TP_printk("o=%08x %s B=%llx c=%u",
+	    TP_printk("o=%08x %s B=%llx c=%u aux=%llx dsk=%llx",
 		      __entry->obj,
 		      __print_symbolic(__entry->why, cachefiles_coherency_traces),
 		      __entry->ino,
-		      __entry->content)
+		      __entry->content,
+		      __entry->aux,
+		      __entry->disk_aux)
 	    );
 
 TRACE_EVENT(cachefiles_vol_coherency,


