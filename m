Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670DA1C4209
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgEDRPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:15:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23948 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730394AbgEDRPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWQJK7zPeDPdYhDwPYU8xq1x4O/xcEWQo3ZiKiG6jyk=;
        b=h2+sOKsWQQoIKxQKiA9/kNcj1Yc9ebpGuuukYPmnHuyytYh25WBZDbcE+CSH5ENpzrFQ5Q
        2HAoVunjeHOHYgR/nc2tiBr3VtmKS4468uuP3koZDFI41psmb7ToYPA9xwMg6lnRYdeQ4g
        0OkZtZOC6lxfJEvIcpkN52E2HXJ0/Po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-2suybqQwNsyAxzX2F4_yfw-1; Mon, 04 May 2020 13:15:36 -0400
X-MC-Unique: 2suybqQwNsyAxzX2F4_yfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5647680BE32;
        Mon,  4 May 2020 17:15:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F146D5C1BD;
        Mon,  4 May 2020 17:15:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 53/61] afs: Note the amount transferred in fetch-data
 delivery
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:15:31 +0100
Message-ID: <158861253114.340223.7031203580922376614.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
index 0b3f33269fdd..577c975c13b0 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -211,9 +211,8 @@ static void afs_dir_dump(struct afs_vnode *dvnode, struct afs_read *req)
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
@@ -323,7 +322,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 
 	nr_pages = (i_size + PAGE_SIZE - 1) / PAGE_SIZE;
 
-	req->actual_len = i_size; /* May change */
+	req->cache.transferred = i_size; /* May change */
 	req->cache.len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
 	req->data_version = dvnode->status.data_version; /* May change */
 	iov_iter_mapping(&req->def_iter, READ, dvnode->vfs_inode.i_mapping,
@@ -548,7 +547,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 
 	/* walk through the blocks in sequence */
 	ret = 0;
-	while (ctx->pos < req->actual_len) {
+	while (ctx->pos < req->cache.transferred) {
 		blkoff = ctx->pos & ~(sizeof(union afs_xdr_dir_block) - 1);
 
 		/* Fetch the appropriate page from the directory and re-add it
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index c9789294fc68..62cc8072874b 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -417,6 +417,11 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
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
index 6ea97233c0d2..fb3f006be31c 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -531,6 +531,11 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		break;
 	}
 
+	/* Pass the call's ref on the read request descriptor to the completion
+	 * handler.
+	 */
+	req->cache.transferred = min(req->actual_len, req->cache.len);
+	set_bit(FSCACHE_IO_DATA_FROM_SERVER, &req->cache.flags);
 	if (req->cache.io_done)
 		req->cache.io_done(&req->cache);
 


