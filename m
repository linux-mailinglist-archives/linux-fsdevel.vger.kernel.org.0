Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEBF41EFAC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 16:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354575AbhJAOj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 10:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354574AbhJAOj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633099062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/KKRYJFhv/QJA9FN2XncZtvBI8w9ECIMj6A6MWC7kv8=;
        b=UsuyIvJm5j4wzh46PY7Qa6seoGHEUoH9umhVXBLQUG7QNGcmzD+wo2vp19JEI6ZIkrN4Uq
        uM+GMRCEcrvMyx6LWyfM7v43cNJejdg19BZaQvAf+O5SoUM354OcwP/yEJKu8QFHYh3ls9
        A1sUH2AJD28bPUINoQOWIHQbSNgf1A8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-_YyqmfaxPX2LTkbQkc9YAQ-1; Fri, 01 Oct 2021 10:37:39 -0400
X-MC-Unique: _YyqmfaxPX2LTkbQkc9YAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67F6F835DE0;
        Fri,  1 Oct 2021 14:37:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C23A652A4;
        Fri,  1 Oct 2021 14:37:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] cachefiles: Fix oops in trace_cachefiles_mark_buried due to
 NULL object
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Wysochanski <dwysocha@redhat.com>, linux-cachefs@redhat.com,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 Oct 2021 15:37:31 +0100
Message-ID: <163309905120.80461.1932497502647013780.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Wysochanski <dwysocha@redhat.com>

In cachefiles_mark_object_buried, the dentry in question may
not have an owner, and thus our cachefiles_object pointer
may be NULL when calling the tracepoint, in which case we
will also not have a valid debug_id to print in the tracepoint.
Check for NULL object in the tracepoint and if so, just set
debug_id to MAX_UINT as was done in 2908f5e101e3.

This fixes the following oops:

    FS-Cache: Cache "mycache" added (type cachefiles)
    CacheFiles: File cache on vdc registered
    ...
    Workqueue: fscache_object fscache_object_work_func [fscache]
    RIP: 0010:trace_event_raw_event_cachefiles_mark_buried+0x4e/0xa0 [cachefiles]
    ....
    Call Trace:
     cachefiles_mark_object_buried+0xa5/0xb0 [cachefiles]
     cachefiles_bury_object+0x270/0x430 [cachefiles]
     ? kfree+0xaa/0x3a0
     ? vfs_getxattr+0x15a/0x180
     cachefiles_walk_to_object+0x195/0x9c0 [cachefiles]
     ? trace_event_buffer_commit+0x61/0x220
     cachefiles_lookup_object+0x5a/0xc0 [cachefiles]
     fscache_look_up_object+0xd7/0x160 [fscache]
     fscache_object_work_func+0xb2/0x340 [fscache]
     process_one_work+0x1f1/0x390
     worker_thread+0x53/0x3e0
     ? process_one_work+0x390/0x390
     kthread+0x127/0x150
     ? set_kthread_struct+0x40/0x40
     ret_from_fork+0x22/0x30

Fixes: 2908f5e101e3 ("fscache: Add a cookie debug ID and use that in traces")
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 include/trace/events/cachefiles.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 9a448fe9355d..695bfdbfdcad 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -305,7 +305,7 @@ TRACE_EVENT(cachefiles_mark_buried,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->obj	= obj ? obj->fscache.debug_id : UINT_MAX;
 		    __entry->de		= de;
 		    __entry->why	= why;
 			   ),


