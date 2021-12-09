Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8523B46EFB4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbhLIRE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:04:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241928AbhLIREs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SZliK4x2NkPw7qyheFipGoGQBpJum70aryCus4MzV00=;
        b=dVS+rKCepynBn1df5GA1nIIt0aPF8puhTZQYmWBwcjIg/D2P72ZkGH5m4NMG3l2i5/zUYV
        2s3RyhHBUvBEym4oVAfyOqy9u7lMyXG0/lIbGV46V948ifIY5hugjAHt4jLWTYAzZpENf4
        JHm1tiJXdQgm0cIpsbj5UW5PwNFiw3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-565-pOSiC1CbNMOMXgInM5b2UQ-1; Thu, 09 Dec 2021 12:01:09 -0500
X-MC-Unique: pOSiC1CbNMOMXgInM5b2UQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21909874980;
        Thu,  9 Dec 2021 17:01:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6C811B472;
        Thu,  9 Dec 2021 17:01:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 33/67] cachefiles: Add a couple of tracepoints for logging
 errors
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Dec 2021 17:01:02 +0000
Message-ID: <163906926297.143852.18267924605548658911.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add two trace points to log errors, one for vfs operations like mkdir or
create, and one for I/O operations, like read, write or truncate.

Also add the beginnings of a struct that is going to represent a data file
and place a debugging ID in it for the tracepoints to record.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819625632.215744.17907340966178411033.stgit@warthog.procyon.org.uk/ # v1
---

 fs/cachefiles/internal.h          |    1 
 include/trace/events/cachefiles.h |   94 +++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 1f2fea902d3e..b51146a29aca 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -62,6 +62,7 @@ struct cachefiles_cache {
 	char				*tag;		/* cache binding tag */
 };
 
+#include <trace/events/cachefiles.h>
 
 /*
  * error_inject.c
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 5ee0aabb20be..9bd5a8a60801 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -18,11 +18,49 @@
 #ifndef __CACHEFILES_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __CACHEFILES_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
+enum cachefiles_error_trace {
+	cachefiles_trace_fallocate_error,
+	cachefiles_trace_getxattr_error,
+	cachefiles_trace_link_error,
+	cachefiles_trace_lookup_error,
+	cachefiles_trace_mkdir_error,
+	cachefiles_trace_notify_change_error,
+	cachefiles_trace_open_error,
+	cachefiles_trace_read_error,
+	cachefiles_trace_remxattr_error,
+	cachefiles_trace_rename_error,
+	cachefiles_trace_seek_error,
+	cachefiles_trace_setxattr_error,
+	cachefiles_trace_statfs_error,
+	cachefiles_trace_tmpfile_error,
+	cachefiles_trace_trunc_error,
+	cachefiles_trace_unlink_error,
+	cachefiles_trace_write_error,
+};
+
 #endif
 
 /*
  * Define enum -> string mappings for display.
  */
+#define cachefiles_error_traces						\
+	EM(cachefiles_trace_fallocate_error,	"fallocate")		\
+	EM(cachefiles_trace_getxattr_error,	"getxattr")		\
+	EM(cachefiles_trace_link_error,		"link")			\
+	EM(cachefiles_trace_lookup_error,	"lookup")		\
+	EM(cachefiles_trace_mkdir_error,	"mkdir")		\
+	EM(cachefiles_trace_notify_change_error, "notify_change")	\
+	EM(cachefiles_trace_open_error,		"open")			\
+	EM(cachefiles_trace_read_error,		"read")			\
+	EM(cachefiles_trace_remxattr_error,	"remxattr")		\
+	EM(cachefiles_trace_rename_error,	"rename")		\
+	EM(cachefiles_trace_seek_error,		"seek")			\
+	EM(cachefiles_trace_setxattr_error,	"setxattr")		\
+	EM(cachefiles_trace_statfs_error,	"statfs")		\
+	EM(cachefiles_trace_tmpfile_error,	"tmpfile")		\
+	EM(cachefiles_trace_trunc_error,	"trunc")		\
+	EM(cachefiles_trace_unlink_error,	"unlink")		\
+	E_(cachefiles_trace_write_error,	"write")
 
 
 /*
@@ -33,6 +71,8 @@
 #define EM(a, b) TRACE_DEFINE_ENUM(a);
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 
+cachefiles_error_traces;
+
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
  * will be printed in the output.
@@ -43,6 +83,60 @@
 #define E_(a, b)	{ a, b }
 
 
+TRACE_EVENT(cachefiles_vfs_error,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
+		     int error, enum cachefiles_error_trace where),
+
+	    TP_ARGS(obj, backer, error, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(enum cachefiles_error_trace,	where	)
+		    __field(short,				error	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->backer	= backer->i_ino;
+		    __entry->error	= error;
+		    __entry->where	= where;
+			   ),
+
+	    TP_printk("o=%08x b=%08x %s e=%d",
+		      __entry->obj,
+		      __entry->backer,
+		      __print_symbolic(__entry->where, cachefiles_error_traces),
+		      __entry->error)
+	    );
+
+TRACE_EVENT(cachefiles_io_error,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
+		     int error, enum cachefiles_error_trace where),
+
+	    TP_ARGS(obj, backer, error, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(enum cachefiles_error_trace,	where	)
+		    __field(short,				error	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->backer	= backer->i_ino;
+		    __entry->error	= error;
+		    __entry->where	= where;
+			   ),
+
+	    TP_printk("o=%08x b=%08x %s e=%d",
+		      __entry->obj,
+		      __entry->backer,
+		      __print_symbolic(__entry->where, cachefiles_error_traces),
+		      __entry->error)
+	    );
+
 #endif /* _TRACE_CACHEFILES_H */
 
 /* This part must be outside protection */


