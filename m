Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710A047D9B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 00:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242765AbhLVXP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Dec 2021 18:15:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242826AbhLVXPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640214910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iH4q7YK5vzxx9nR6x4xGVNaN8OgXgR/ENmsnLYtaXN4=;
        b=RU9bd7ShWVg8Q5FKOVmDtZzlX5zUhOSwbruA1zBLbFHdsEefxjtO7Ro/Gl0upfiDdgDKG5
        BzrBhyAmEZylpcgmfwgjo37uJ8zZoXqsukWQ/o6j0vKjN0XYqW76lzwlaCBT4FLCD2Sm8+
        VDvYf5zk4ac+t2bIoY4pF7/WoGkFqYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-d1L2QT93OMCj6pppCCVY5w-1; Wed, 22 Dec 2021 18:15:07 -0500
X-MC-Unique: d1L2QT93OMCj6pppCCVY5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0E8E1006AA4;
        Wed, 22 Dec 2021 23:15:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BA342BE7D;
        Wed, 22 Dec 2021 23:14:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 05/68] netfs: Pass a flag to ->prepare_write() to say if
 there's no alloc'd space
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
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
Date:   Wed, 22 Dec 2021 23:14:53 +0000
Message-ID: <164021489334.640689.3131206613015409076.stgit@warthog.procyon.org.uk>
In-Reply-To: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass a flag to ->prepare_write() to indicate if there's definitely no
space allocated in the cache yet (for instance if we've already checked as
we were asked to do a read).

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819583123.215744.12783808230464471417.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906886835.143852.6689886781122679769.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163967079100.1823006.12889542712309574359.stgit@warthog.procyon.org.uk/ # v3
---

 fs/netfs/read_helper.c |    2 +-
 include/linux/netfs.h  |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 75c76cbb27cc..9dd76b8914f2 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -323,7 +323,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 		}
 
 		ret = cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
-					       rreq->i_size);
+					       rreq->i_size, true);
 		if (ret < 0) {
 			trace_netfs_failure(rreq, subreq, ret, netfs_fail_prepare_write);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_write_skip);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index ca0683b9e3d1..1ea22fc48818 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -232,7 +232,8 @@ struct netfs_cache_ops {
 	 * actually do.
 	 */
 	int (*prepare_write)(struct netfs_cache_resources *cres,
-			     loff_t *_start, size_t *_len, loff_t i_size);
+			     loff_t *_start, size_t *_len, loff_t i_size,
+			     bool no_space_allocated_yet);
 };
 
 struct readahead_control;


