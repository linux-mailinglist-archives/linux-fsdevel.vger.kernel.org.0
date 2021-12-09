Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4152246EDFA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 17:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbhLIQ6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 11:58:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241393AbhLIQ6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639068868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cpzPqhOkb6bNWztmaWC2bqWrQcw/ICLeyzWLupw/QnQ=;
        b=HKJ6Z9lrAKLctucTlQfwqDctevntuWGZ39QFAFBiZEhVlWAWOSPTTV9bmhvhTeilDHT1NW
        LdgAXpK3JIXvQ2rS9XZjChcQ3afpf1z3MbHto9WkfUOd4uxYtFE7i2jtTk/lV/S1bcEQzq
        X6FWhhHsyxL602uThNwJnkt6UK6cRnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-I4_FQcCIOdmbsL0XbhIYdQ-1; Thu, 09 Dec 2021 11:54:25 -0500
X-MC-Unique: I4_FQcCIOdmbsL0XbhIYdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 210F210247A7;
        Thu,  9 Dec 2021 16:54:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D92075BE07;
        Thu,  9 Dec 2021 16:54:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 04/67] netfs: Display the netfs inode number in the
 netfs_read tracepoint
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
Date:   Thu, 09 Dec 2021 16:54:19 +0000
Message-ID: <163906885903.143852.12229407815154182247.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Display the netfs inode number in the netfs_read tracepoint so that this
can be used to correlate with the cachefiles_prep_read tracepoint.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819581097.215744.17476611915583897051.stgit@warthog.procyon.org.uk/ # v1
---

 include/trace/events/netfs.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 4d470bffd9f1..e6f4ebbb4c69 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -135,6 +135,7 @@ TRACE_EVENT(netfs_read,
 		    __field(loff_t,			start		)
 		    __field(size_t,			len		)
 		    __field(enum netfs_read_trace,	what		)
+		    __field(unsigned int,		netfs_inode	)
 			     ),
 
 	    TP_fast_assign(
@@ -143,12 +144,14 @@ TRACE_EVENT(netfs_read,
 		    __entry->start	= start;
 		    __entry->len	= len;
 		    __entry->what	= what;
+		    __entry->netfs_inode = rreq->inode->i_ino;
 			   ),
 
-	    TP_printk("R=%08x %s c=%08x s=%llx %zx",
+	    TP_printk("R=%08x %s c=%08x ni=%x s=%llx %zx",
 		      __entry->rreq,
 		      __print_symbolic(__entry->what, netfs_read_traces),
 		      __entry->cookie,
+		      __entry->netfs_inode,
 		      __entry->start, __entry->len)
 	    );
 


