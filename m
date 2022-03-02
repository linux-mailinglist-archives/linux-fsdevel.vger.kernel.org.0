Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016254CA75E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 15:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbiCBOId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 09:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbiCBOIV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:08:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80BE58D69B
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 06:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646230030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OLCBF/gDk2Fvqt+9Om6qzgghP79ea3nSGNkR54dItNo=;
        b=af2/ecXmCD1TxOqNFlHH54Ejf7JSG/cpH+N9R5/sTUqVfnGlWJDrw5Nrmbmhv5RjxD/+Eh
        XZYPCTwaHrM9eigivHnWTOBIZiqZyLrzQCnIynqL6resxMIM2HxJQ0QbmsHlRNTFid+/dA
        Tcf7qRfXRMQi5GDgvb3tYtN6LJfGrpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-1ElEWJQTMsqLASy1-LK93w-1; Wed, 02 Mar 2022 09:07:05 -0500
X-MC-Unique: 1ElEWJQTMsqLASy1-LK93w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6018B1091DA0;
        Wed,  2 Mar 2022 14:07:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F2BC8495A;
        Wed,  2 Mar 2022 14:07:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/19] netfs: Adjust the netfs_failure tracepoint to indicate
 non-subreq lines
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Mar 2022 14:06:59 +0000
Message-ID: <164623001948.3564931.2353852999649380059.stgit@warthog.procyon.org.uk>
In-Reply-To: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
References: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adjust the netfs_failure tracepoint to indicate a subrequest number of -1
when it's a full-request failure unrelated to any particular subrequest,
such as a failure to encrypt its data buffer.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 include/trace/events/netfs.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 507c5e612293..685b07573394 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -231,7 +231,7 @@ TRACE_EVENT(netfs_failure,
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		rreq		)
-		    __field(unsigned short,		index		)
+		    __field(short,			index		)
 		    __field(short,			error		)
 		    __field(unsigned short,		flags		)
 		    __field(enum netfs_io_source,	source		)
@@ -243,17 +243,17 @@ TRACE_EVENT(netfs_failure,
 
 	    TP_fast_assign(
 		    __entry->rreq	= rreq->debug_id;
-		    __entry->index	= sreq ? sreq->debug_index : 0;
+		    __entry->index	= sreq ? sreq->debug_index : -1;
 		    __entry->error	= error;
 		    __entry->flags	= sreq ? sreq->flags : 0;
 		    __entry->source	= sreq ? sreq->source : NETFS_INVALID_READ;
 		    __entry->what	= what;
-		    __entry->len	= sreq ? sreq->len : 0;
+		    __entry->len	= sreq ? sreq->len : rreq->len;
 		    __entry->transferred = sreq ? sreq->transferred : 0;
 		    __entry->start	= sreq ? sreq->start : 0;
 			   ),
 
-	    TP_printk("R=%08x[%u] %s f=%02x s=%llx %zx/%zx %s e=%d",
+	    TP_printk("R=%08x[%d] %s f=%02x s=%llx %zx/%zx %s e=%d",
 		      __entry->rreq, __entry->index,
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
 		      __entry->flags,


