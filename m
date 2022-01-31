Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70974A4A19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379107AbiAaPOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:14:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349447AbiAaPO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643642067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ChuemeG/jS317xBBF70oFf4WwBZNenz/LAHILjMr9M=;
        b=XQO2YA63f9psBA7S9E3P0iGpT6BV1IzSmmV1NznN6jKUY3w45N8pRyx1pXbMcFgAetYwGX
        3KoISaLyMCzalF8OuI5gaTg/mzuYiFRGdNswcZ6eOHPIFMsKPEZFxhJd2JkreTp9KX8D9V
        gvtvH2oDtP+F1k4vRJwv/tPUclmmLiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-12WqAvEZP8mzhmuwdmMDXw-1; Mon, 31 Jan 2022 10:14:23 -0500
X-MC-Unique: 12WqAvEZP8mzhmuwdmMDXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 164CE1091DC3;
        Mon, 31 Jan 2022 15:14:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B69C84D0D;
        Mon, 31 Jan 2022 15:14:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/5] cachefiles: Remove the now-unused mark-inode-in-use
 tracepoints
From:   David Howells <dhowells@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-cachefs@redhat.com, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        torvalds@linux-foundation.org, linux-unionfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 31 Jan 2022 15:14:08 +0000
Message-ID: <164364204859.1476539.8259104934674309990.stgit@warthog.procyon.org.uk>
In-Reply-To: <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk>
References: <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The cachefiles tracepoints that relate to marking an inode in-use with the
S_KERNEL_FILE inode flag are now unused, superseded by general tracepoints.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 include/trace/events/cachefiles.h |   63 -------------------------------------
 1 file changed, 63 deletions(-)

diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index c6f5aa74db89..1c56f9889f69 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -552,69 +552,6 @@ TRACE_EVENT(cachefiles_trunc,
 		      __entry->to)
 	    );
 
-TRACE_EVENT(cachefiles_mark_active,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct inode *inode),
-
-	    TP_ARGS(obj, inode),
-
-	    /* Note that obj may be NULL */
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(ino_t,			inode		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj ? obj->debug_id : 0;
-		    __entry->inode	= inode->i_ino;
-			   ),
-
-	    TP_printk("o=%08x B=%lx",
-		      __entry->obj, __entry->inode)
-	    );
-
-TRACE_EVENT(cachefiles_mark_failed,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct inode *inode),
-
-	    TP_ARGS(obj, inode),
-
-	    /* Note that obj may be NULL */
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(ino_t,			inode		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj ? obj->debug_id : 0;
-		    __entry->inode	= inode->i_ino;
-			   ),
-
-	    TP_printk("o=%08x B=%lx",
-		      __entry->obj, __entry->inode)
-	    );
-
-TRACE_EVENT(cachefiles_mark_inactive,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct inode *inode),
-
-	    TP_ARGS(obj, inode),
-
-	    /* Note that obj may be NULL */
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(ino_t,			inode		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj ? obj->debug_id : 0;
-		    __entry->inode	= inode->i_ino;
-			   ),
-
-	    TP_printk("o=%08x B=%lx",
-		      __entry->obj, __entry->inode)
-	    );
-
 TRACE_EVENT(cachefiles_vfs_error,
 	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
 		     int error, enum cachefiles_error_trace where),


