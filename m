Return-Path: <linux-fsdevel+bounces-33763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6C79BEA8D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 13:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCFD1F247E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B2F1FB887;
	Wed,  6 Nov 2024 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWd3uYU4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EEE1E0488
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896715; cv=none; b=hlnrWsJbMo5Xy5J2QhL8JL+y5umxf8qULRydd5aRJ2J+Ivm0OZb86YYbHBOpmV5l0f+gdM1s41w4KsPQHcdYuvsnGoHPkIQpOq9aUQM0AubllH2fjlpn1zqRz3PH/52qDZQIK0sincuMs1TyTYfoQKEBvCFrg+XpkkbfqOZJIL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896715; c=relaxed/simple;
	bh=Iu5W7GQDrF6wAgpzj6wnYkl7V7v8hp++3GNg/ZYfmXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5jCbayz7pfBmBQ/odPK8M28cgq0d14xl+f2CO76R9GNQLfxNBGTees7XN77AsKOjKUC3odTdnVTMsLPpDaas6Agggxs6LYXCC7Zis1Oe1kqXCk+svTnQ/U8B78CKqu2wINglmx5dlRdDpk1PntAkFgZyKxwp8CEp/O/RW/DvDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWd3uYU4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZQE6Gk2pDLRsrGirLF3LOxjqtk3JDWUrBtiyK47AD0=;
	b=NWd3uYU4Z6Yr7gTzPflqp0fBkmCwH8HugWT/wFTAOyJkH7yHKffZpDLdcGk7n98D4rs5h9
	Kka/nJHtBVQSn/g/bYbGnBoi7rqE5Mc/1lHQ7pwF0n8faGV/f5nV2cxvOBTLJ+MDdW64Go
	2kMmBHK4nocOMQrno9iykKbru61eZkE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-g9gAON9hOxG1xk5qcIWRxg-1; Wed,
 06 Nov 2024 07:38:28 -0500
X-MC-Unique: g9gAON9hOxG1xk5qcIWRxg-1
X-Mimecast-MFC-AGG-ID: g9gAON9hOxG1xk5qcIWRxg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D03519560B5;
	Wed,  6 Nov 2024 12:38:26 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87C2C19560AA;
	Wed,  6 Nov 2024 12:38:20 +0000 (UTC)
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
Subject: [PATCH v3 18/33] cachefiles: Add auxiliary data trace
Date: Wed,  6 Nov 2024 12:35:42 +0000
Message-ID: <20241106123559.724888-19-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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


