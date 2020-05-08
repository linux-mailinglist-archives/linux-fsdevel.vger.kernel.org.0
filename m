Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B271CBA1C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 23:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgEHVvD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 17:51:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34196 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728097AbgEHVvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 17:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588974661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1nuPRTr7zkCHMa6FVvgv5uLC2rFZUxwckBQ7tiqwpY=;
        b=CQat/MiAxutTbaQwWE1O3HppyaVVeGFtiStkHVnaj3J+xxCcc6qYSpW1t9/qfaRwkLriaw
        8Uc8n6848EjD5XZRSYpFyujML/j0Qa/UP+/BTVtuuPWEAffLRJVTUIdsMsnVtYO5oe4Euh
        tli5KmL4EPYR++9F5g8XCIXA/PnJ/Vg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-QR2vPFfkOZO6nwpqEpzj_Q-1; Fri, 08 May 2020 17:51:00 -0400
X-MC-Unique: QR2vPFfkOZO6nwpqEpzj_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D15A0464;
        Fri,  8 May 2020 21:50:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F06F25C3FD;
        Fri,  8 May 2020 21:50:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/4] cachefiles: Fix corruption of the return value in
 cachefiles_read_or_alloc_pages()
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     David Wysochanski <dwysocha@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>, dhowells@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 May 2020 22:50:56 +0100
Message-ID: <158897465610.1116213.3782314033176330124.stgit@warthog.procyon.org.uk>
In-Reply-To: <158897464246.1116213.8184341356151224705.stgit@warthog.procyon.org.uk>
References: <158897464246.1116213.8184341356151224705.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch which changed cachefiles from calling ->bmap() to using the
bmap() wrapper overwrote the running return value with the result of
calling bmap().  This causes an assertion failure elsewhere in the code.

Fix this by using ret2 rather than ret to hold the return value.

The oops looks like:

	kernel BUG at fs/nfs/fscache.c:468!
	...
	RIP: 0010:__nfs_readpages_from_fscache+0x18b/0x190 [nfs]
	...
	Call Trace:
	 nfs_readpages+0xbf/0x1c0 [nfs]
	 ? __alloc_pages_nodemask+0x16c/0x320
	 read_pages+0x67/0x1a0
	 __do_page_cache_readahead+0x1cf/0x1f0
	 ondemand_readahead+0x172/0x2b0
	 page_cache_async_readahead+0xaa/0xe0
	 generic_file_buffered_read+0x852/0xd50
	 ? mem_cgroup_commit_charge+0x6e/0x140
	 ? nfs4_have_delegation+0x19/0x30 [nfsv4]
	 generic_file_read_iter+0x100/0x140
	 ? nfs_revalidate_mapping+0x176/0x2b0 [nfs]
	 nfs_file_read+0x6d/0xc0 [nfs]
	 new_sync_read+0x11a/0x1c0
	 __vfs_read+0x29/0x40
	 vfs_read+0x8e/0x140
	 ksys_read+0x61/0xd0
	 __x64_sys_read+0x1a/0x20
	 do_syscall_64+0x60/0x1e0
	 entry_SYSCALL_64_after_hwframe+0x44/0xa9
	RIP: 0033:0x7f5d148267e0

Fixes: 10d83e11a582 ("cachefiles: drop direct usage of ->bmap method.")
Reported-by: David Wysochanski <dwysocha@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: David Wysochanski <dwysocha@redhat.com>
cc: Carlos Maiolino <cmaiolino@redhat.com>
---

 fs/cachefiles/rdwr.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 1dc97f2d6201..d3d78176b23c 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -398,7 +398,7 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
 	struct inode *inode;
 	sector_t block;
 	unsigned shift;
-	int ret;
+	int ret, ret2;
 
 	object = container_of(op->op.object,
 			      struct cachefiles_object, fscache);
@@ -430,8 +430,8 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
 	block = page->index;
 	block <<= shift;
 
-	ret = bmap(inode, &block);
-	ASSERT(ret < 0);
+	ret2 = bmap(inode, &block);
+	ASSERT(ret2 == 0);
 
 	_debug("%llx -> %llx",
 	       (unsigned long long) (page->index << shift),
@@ -739,8 +739,8 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
 		block = page->index;
 		block <<= shift;
 
-		ret = bmap(inode, &block);
-		ASSERT(!ret);
+		ret2 = bmap(inode, &block);
+		ASSERT(ret2 == 0);
 
 		_debug("%llx -> %llx",
 		       (unsigned long long) (page->index << shift),


