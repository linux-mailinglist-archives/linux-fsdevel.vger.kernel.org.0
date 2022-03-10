Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC0C4D4ECB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbiCJQSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242815AbiCJQSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:18:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87661190C0B
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 08:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646929041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+5rw8zSPtNYHlJz50ggoUHurB2GiVXScpwkdQ7wos44=;
        b=JU6H8Tknhryc/C12iJWT0Dzl6Uk+GyNwJMwbtuZV3fCYRjiza2gDvgJcqEg26UL6NAWPRe
        cV1Cu3+1oW8G36zWfKrZt9KqpINQNnyNpCdU3VzNtUpvdIM9VL1dz+s2tcQ/KuFSNvqfwZ
        fSe8fGRkWGE7/ljN2CGXEFqRwAVdnQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-KgVhwZz1OrS_G-xw4bYWdQ-1; Thu, 10 Mar 2022 11:17:18 -0500
X-MC-Unique: KgVhwZz1OrS_G-xw4bYWdQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4ED86180FD71;
        Thu, 10 Mar 2022 16:17:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EBAC8379E;
        Thu, 10 Mar 2022 16:17:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 09/20] netfs: Adjust the netfs_failure tracepoint to
 indicate non-subreq lines
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
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
Date:   Thu, 10 Mar 2022 16:17:12 +0000
Message-ID: <164692903233.2099075.15414355147237641274.stgit@warthog.procyon.org.uk>
In-Reply-To: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
References: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adjust the netfs_failure tracepoint to indicate a subrequest number of -1
when it's a full-request failure unrelated to any particular subrequest,
such as a failure to encrypt its data buffer.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/164623001948.3564931.2353852999649380059.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/164678204587.1200972.14893513018190383961.stgit@warthog.procyon.org.uk/ # v2
---

 include/trace/events/netfs.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index dcea5e888fd0..556859b0f107 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -222,7 +222,7 @@ TRACE_EVENT(netfs_failure,
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		rreq		)
-		    __field(unsigned short,		index		)
+		    __field(short,			index		)
 		    __field(short,			error		)
 		    __field(unsigned short,		flags		)
 		    __field(enum netfs_io_source,	source		)
@@ -234,17 +234,17 @@ TRACE_EVENT(netfs_failure,
 
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


