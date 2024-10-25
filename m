Return-Path: <linux-fsdevel+bounces-32964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D5A9B1096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 22:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C8A1C257BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9138E231C8A;
	Fri, 25 Oct 2024 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5JtQpyD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA82231C8F
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888944; cv=none; b=BDKd091jLLvf2FX6lix0N+NBxc9T++Mi7iXRGB6O/K5BLducBClynYkhiNqwmQagQbqkJnkXVuni2JiuqrdLaVXek5CvGAUWHpECUDS5HiP+aTP7ldJcWSsJTH9lKDFMTxGN8DvD9FriiUAuK4KZYXwgKfieANGe5io7UiyJ76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888944; c=relaxed/simple;
	bh=Iu5W7GQDrF6wAgpzj6wnYkl7V7v8hp++3GNg/ZYfmXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ur24DvRDhD2GD6Dg/qGVTrGeEMASNipCyTMaVgGuhOYASom/p1Lt59U2tNCE4Fa2Ahx/aSYkMbtTI6ONxnu+8+4HWrGbhkJk5OvDBy7YkYw/a91iz0Bd5KlTzAdtgPXb7sN6pJgsu+ihlfUWshQenf/nJPS6pZ2wm+q2Qtyf+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5JtQpyD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729888941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZQE6Gk2pDLRsrGirLF3LOxjqtk3JDWUrBtiyK47AD0=;
	b=H5JtQpyDZuZz4/YVrWfbJJzjTb9q8dKM2iNB6vRuAtXYAYEdl88gGAof7Mso3/g8SFyxa3
	sBvehFKp3dYiTY0gq7T7NH6qdqMQsrR+PqXq3tBkmkd+Z/uayXYz79WWhjtff2fCxzBXoH
	uLE/Xp0xF56yTybLMbjiCgLKippo1+s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-W4Ti1EkQNvGPyF-w318ZhQ-1; Fri,
 25 Oct 2024 16:42:16 -0400
X-MC-Unique: W4Ti1EkQNvGPyF-w318ZhQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB6B319560AF;
	Fri, 25 Oct 2024 20:42:13 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78EA51956088;
	Fri, 25 Oct 2024 20:42:08 +0000 (UTC)
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
Subject: [PATCH v2 17/31] cachefiles: Add auxiliary data trace
Date: Fri, 25 Oct 2024 21:39:44 +0100
Message-ID: <20241025204008.4076565-18-dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-1-dhowells@redhat.com>
References: <20241025204008.4076565-1-dhowells@redhat.com>
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


