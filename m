Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391BE4927AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbiARNye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:54:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244008AbiARNyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642514054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fr5/mO03Eh5zUsIqinEzhvjD7us57tEwXFItTFwYtZU=;
        b=V2+/gWzD2yh9Ufp0rDB6XMhnc9igEnqyAit1ndGeOkHGmPGVRNmva85fsvJh0hs1f97TEs
        POMR6NUQvse3+M1VEJDRv+5bRWdc+feBrZ87cz+TV86VHQdMY4g9PvcriAWf6wzF2A6Z7o
        RTRdntOOsXtm2aL23HnTEsyKQ8pZLx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-pH-mfP1eOZqcIhYXlI8mdA-1; Tue, 18 Jan 2022 08:54:13 -0500
X-MC-Unique: pH-mfP1eOZqcIhYXlI8mdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F288483DD2B;
        Tue, 18 Jan 2022 13:54:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81BC978AB5;
        Tue, 18 Jan 2022 13:54:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/11] cachefiles: Trace active-mark failure
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
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
Date:   Tue, 18 Jan 2022 13:54:06 +0000
Message-ID: <164251404666.3435901.17331742792401482190.stgit@warthog.procyon.org.uk>
In-Reply-To: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
References: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a tracepoint to log failure to apply an active mark to a file in
addition to tracing successfully setting and unsetting the mark.

Also include the backing file inode number in the message logged to dmesg.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/namei.c             |    4 +++-
 include/trace/events/cachefiles.h |   21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 52c9f0864a87..f256c8aff7bb 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -25,7 +25,9 @@ static bool __cachefiles_mark_inode_in_use(struct cachefiles_object *object,
 		trace_cachefiles_mark_active(object, inode);
 		can_use = true;
 	} else {
-		pr_notice("cachefiles: Inode already in use: %pd\n", dentry);
+		trace_cachefiles_mark_failed(object, inode);
+		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
+			  dentry, inode->i_ino);
 	}
 
 	return can_use;
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 093c4acb7a3a..c6f5aa74db89 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -573,6 +573,27 @@ TRACE_EVENT(cachefiles_mark_active,
 		      __entry->obj, __entry->inode)
 	    );
 
+TRACE_EVENT(cachefiles_mark_failed,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct inode *inode),
+
+	    TP_ARGS(obj, inode),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj		)
+		    __field(ino_t,			inode		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->inode	= inode->i_ino;
+			   ),
+
+	    TP_printk("o=%08x B=%lx",
+		      __entry->obj, __entry->inode)
+	    );
+
 TRACE_EVENT(cachefiles_mark_inactive,
 	    TP_PROTO(struct cachefiles_object *obj,
 		     struct inode *inode),


