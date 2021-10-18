Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB024320E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhJRO7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232831AbhJRO7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0IGgvCu7e2XQhbY70i8TSPJVNJmFP5Vsi2waD4HEQVM=;
        b=PA+71rY0RU4XXDOwTBIFlKfjk55XGIBO9OG8EwscwLgYYbs/boZwr+3LGR2LLvWNwqVD5h
        z57oLanl8ObWzhXDkk6GIJcTVJT7tSlpZWh3PnP6mthLvJNkx8WVkDl0zfL1YWXCTJd2iU
        B5on4Qw3MX2sNSS1UZPupK2KpBOF+yQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-YOy2swJJMP6NZIQxWFL5mw-1; Mon, 18 Oct 2021 10:56:52 -0400
X-MC-Unique: YOy2swJJMP6NZIQxWFL5mw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2BB418D6A36;
        Mon, 18 Oct 2021 14:56:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99AE7100E809;
        Mon, 18 Oct 2021 14:56:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 23/67] cachefiles: trace: Improve the lookup tracepoint
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
Date:   Mon, 18 Oct 2021 15:56:45 +0100
Message-ID: <163456900574.2614702.12478396115896341195.stgit@warthog.procyon.org.uk>
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

Improve the cachefiles_lookup tracepoint:

 - Don't display the dentry address, since it's going to get hashed.

 - Do display any error code.

 - Work out the inode in the tracepoint rather than in the caller so that
   the logic is conditional on the tracepoint being enabled.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/namei.c             |    4 +---
 include/trace/events/cachefiles.h |   18 +++++++++---------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 10b6d571eda8..b5a0aec529af 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -340,14 +340,12 @@ static int cachefiles_walk_to_file(struct cachefiles_cache *cache,
 	inode_lock_nested(dinode, I_MUTEX_PARENT);
 
 	dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+	trace_cachefiles_lookup(object, dentry);
 	if (IS_ERR(dentry)) {
-		trace_cachefiles_lookup(object, dentry, NULL);
 		ret = PTR_ERR(dentry);
 		goto error;
 	}
 
-	trace_cachefiles_lookup(object, dentry, d_backing_inode(dentry));
-
 	if (d_is_negative(dentry)) {
 		/* This element of the path doesn't exist, so we can release
 		 * any readers in the certain knowledge that there's nothing
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index bd0b5bbd3889..87681dd957ec 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -98,25 +98,25 @@ TRACE_EVENT(cachefiles_ref,
 
 TRACE_EVENT(cachefiles_lookup,
 	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de,
-		     struct inode *inode),
+		     struct dentry *de),
 
-	    TP_ARGS(obj, de, inode),
+	    TP_ARGS(obj, de),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		obj	)
-		    __field(struct dentry *,		de	)
-		    __field(struct inode *,		inode	)
+		    __field(short,			error	)
+		    __field(unsigned long,		ino	)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->obj	= obj->fscache.debug_id;
-		    __entry->de		= de;
-		    __entry->inode	= inode;
+		    __entry->ino	= (!IS_ERR(de) && d_backing_inode(de) ?
+					   d_backing_inode(de)->i_ino : 0);
+		    __entry->error	= IS_ERR(de) ? PTR_ERR(de) : 0;
 			   ),
 
-	    TP_printk("o=%08x d=%p i=%p",
-		      __entry->obj, __entry->de, __entry->inode)
+	    TP_printk("o=%08x i=%lx e=%d",
+		      __entry->obj, __entry->ino, __entry->error)
 	    );
 
 TRACE_EVENT(cachefiles_create,


