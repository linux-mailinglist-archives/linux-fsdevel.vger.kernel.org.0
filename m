Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BED921DD78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgGMQiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:38:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27898 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730298AbgGMQiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594658324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sL3hQiLEAPYlRGXT83j6gzNW7fCSVrdyHgkgU/ju4ks=;
        b=daMF7txm1fIJQpVfZvPhkL3+4Pibe04S4yJ3pAQbv5mpczRhDm18EM7A4xKGLNOSAYJoag
        FAbZDsSadQdfinYsdBGS0swxe1HRBE1X7MMoxxziLQu+QvkY7zHK6R6FLSh1lHN73D2jf0
        sqoU1sMnkYpNED0IhPlUTIL4zAmImPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166--kgTRIfMOL-pA7rXZyEOTQ-1; Mon, 13 Jul 2020 12:38:40 -0400
X-MC-Unique: -kgTRIfMOL-pA7rXZyEOTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDB6380183C;
        Mon, 13 Jul 2020 16:38:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0D5110013C0;
        Mon, 13 Jul 2020 16:38:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/13] afs: Note the amount transferred in fetch-data delivery
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:38:32 +0100
Message-ID: <159465831290.1377938.10075677476527399814.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
References: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Note the amount of data transferred in the fscache request op structure in
the delivery/decode routines for the various FetchData operations.

Also, we need to exclude the excess from this value and then we need to use
this in directory read rather than actual_len.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c       |    9 ++++-----
 fs/afs/fsclient.c  |    5 +++++
 fs/afs/yfsclient.c |    5 +++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9d47df15c790..03ef09330d10 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -209,9 +209,8 @@ static void afs_dir_dump(struct afs_vnode *dvnode, struct afs_read *req)
 	pr_warn("DIR %llx:%llx f=%llx l=%llx al=%llx\n",
 		dvnode->fid.vid, dvnode->fid.vnode,
 		req->file_size, req->cache.len, req->actual_len);
-	pr_warn("DIR %llx %x %zx %zx\n",
-		req->cache.pos, req->cache.nr_pages,
-		req->iter->iov_offset,  iov_iter_count(req->iter));
+	pr_warn("DIR %llx %x %llx\n",
+		req->cache.pos, req->cache.nr_pages, req->cache.transferred);
 
 	xas_for_each(&xas, page, last) {
 		if (xas_retry(&xas, page))
@@ -321,7 +320,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 
 	nr_pages = (i_size + PAGE_SIZE - 1) / PAGE_SIZE;
 
-	req->actual_len = i_size; /* May change */
+	req->cache.transferred = i_size; /* May change */
 	req->cache.len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
 	req->data_version = dvnode->status.data_version; /* May change */
 	iov_iter_mapping(&req->def_iter, READ, dvnode->vfs_inode.i_mapping,
@@ -546,7 +545,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 
 	/* walk through the blocks in sequence */
 	ret = 0;
-	while (ctx->pos < req->actual_len) {
+	while (ctx->pos < req->cache.transferred) {
 		blkoff = ctx->pos & ~(sizeof(union afs_xdr_dir_block) - 1);
 
 		/* Fetch the appropriate page from the directory and re-add it
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index d6a8066e666d..e729a19f28c5 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -393,6 +393,11 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		break;
 	}
 
+	/* Pass the call's ref on the read request descriptor to the completion
+	 * handler.
+	 */
+	req->cache.transferred = min(req->actual_len, req->cache.len);
+	set_bit(FSCACHE_IO_DATA_FROM_SERVER, &req->cache.flags);
 	if (req->cache.io_done)
 		req->cache.io_done(&req->cache);
 
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 30621f4fffc0..4ead0c1f9014 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -450,6 +450,11 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		break;
 	}
 
+	/* Pass the call's ref on the read request descriptor to the completion
+	 * handler.
+	 */
+	req->cache.transferred = min(req->actual_len, req->cache.len);
+	set_bit(FSCACHE_IO_DATA_FROM_SERVER, &req->cache.flags);
 	if (req->cache.io_done)
 		req->cache.io_done(&req->cache);
 


