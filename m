Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83820432107
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhJRPAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232773AbhJRPAB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqXtD4ctY9AuNokwYb2eI4uzaefOorI1un4GDbWnL4g=;
        b=Ua5uMz1fBiAmOyqTGAUXx9u1SuD4Fykpgyr079ZlmhhYB0iHwXFGL4ukgf3bJy1VvmheCd
        9Vkn45Tz/V3i2fWjDb9J5MPVSxwAPoq8Mmxgn5YY9X3j7mL9zPXSnN20amhCRIEUqpK1Y1
        i/j5DwAJWESihU1oCVsgAZPiVo43qho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-uJKXfj15M2-9BoLIeck12g-1; Mon, 18 Oct 2021 10:57:49 -0400
X-MC-Unique: uJKXfj15M2-9BoLIeck12g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CB1F8066F5;
        Mon, 18 Oct 2021 14:57:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B80A7100EA05;
        Mon, 18 Oct 2021 14:57:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 28/67] cachefiles: Trace truncations
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 15:57:42 +0100
Message-ID: <163456906284.2614702.7451773731985568258.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a tracepoint to trace truncation operations.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c         |    9 +++++++-
 include/trace/events/cachefiles.h |   40 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 4edb3a09932a..8f98e5c27d66 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -341,9 +341,16 @@ static void cachefiles_invalidate_object(struct cachefiles_object *object)
 		ASSERT(d_is_reg(file->f_path.dentry));
 
 		cachefiles_begin_secure(cache, &saved_cred);
+		trace_cachefiles_trunc(object, file_inode(file),
+				       i_size_read(file_inode(file)), 0,
+				       cachefiles_trunc_invalidate);
 		ret = vfs_truncate(&file->f_path, 0);
-		if (ret == 0)
+		if (ret == 0) {
+			trace_cachefiles_trunc(object, file_inode(file),
+					       0, ni_size,
+					       cachefiles_trunc_set_size);
 			ret = vfs_truncate(&file->f_path, ni_size);
+		}
 		cachefiles_end_secure(cache, saved_cred);
 
 		if (ret != 0) {
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 6e9f6462833d..09d76c160451 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -37,6 +37,11 @@ enum cachefiles_coherency_trace {
 	cachefiles_coherency_set_ok,
 };
 
+enum cachefiles_trunc_trace {
+	cachefiles_trunc_invalidate,
+	cachefiles_trunc_set_size,
+};
+
 #endif
 
 /*
@@ -72,6 +77,10 @@ enum cachefiles_coherency_trace {
 	EM(cachefiles_coherency_set_fail,	"SET fail")		\
 	E_(cachefiles_coherency_set_ok,		"SET ok  ")
 
+#define cachefiles_trunc_traces						\
+	EM(cachefiles_trunc_invalidate,		"INVAL ")		\
+	E_(cachefiles_trunc_set_size,		"SETSIZ")
+
 /*
  * Export enum symbols via userspace.
  */
@@ -83,6 +92,7 @@ enum cachefiles_coherency_trace {
 cachefiles_obj_kill_traces;
 cachefiles_obj_ref_traces;
 cachefiles_coherency_traces;
+cachefiles_trunc_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -292,6 +302,36 @@ TRACE_EVENT(cachefiles_coherency,
 		      __entry->content)
 	    );
 
+TRACE_EVENT(cachefiles_trunc,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
+		     loff_t from, loff_t to, enum cachefiles_trunc_trace why),
+
+	    TP_ARGS(obj, backer, from, to, why),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(enum cachefiles_trunc_trace,	why	)
+		    __field(loff_t,				from	)
+		    __field(loff_t,				to	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->backer	= backer->i_ino;
+		    __entry->from	= from;
+		    __entry->to		= to;
+		    __entry->why	= why;
+			   ),
+
+	    TP_printk("o=%08x b=%08x %s l=%llx->%llx",
+		      __entry->obj,
+		      __entry->backer,
+		      __print_symbolic(__entry->why, cachefiles_trunc_traces),
+		      __entry->from,
+		      __entry->to)
+	    );
+
 #endif /* _TRACE_CACHEFILES_H */
 
 /* This part must be outside protection */


