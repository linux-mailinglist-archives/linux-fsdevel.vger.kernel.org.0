Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84D36BAFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 23:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhDZVHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 17:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234864AbhDZVHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619471194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoprxGl2uK6k56hNY9CDxe9Gob3U7ejqWda/scDa68M=;
        b=BSG+FQcPL1rKANBx8xAwzC0Y+rhK1aKnOeeFdP5UHB0XP3mF49K7aXHk4inxIp+rraZNMK
        G8IeExS5Fd4TqW6QRih2NCOMElrEhXGYSq3ulPYVPRFnUlfOnTOQADBdHJMKgfSYl8ItIG
        Tf9afdFxni5lhHeVfJABp4YwKI37rFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-XW_eethqPa-CB163_frKsg-1; Mon, 26 Apr 2021 17:06:32 -0400
X-MC-Unique: XW_eethqPa-CB163_frKsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3DDA1B18BC1;
        Mon, 26 Apr 2021 21:06:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-20.rdu2.redhat.com [10.10.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BD605D9DE;
        Mon, 26 Apr 2021 21:06:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
References: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        v9fs-developer@lists.sourceforge.net, linux-mm@kvack.org,
        linux-afs@lists.infradead.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Miscellaneous fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3726523.1619471123.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From:   David Howells <dhowells@redhat.com>
Date:   Mon, 26 Apr 2021 22:06:24 +0100
Message-ID: <3726642.1619471184@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    =

Fix some miscellaneous things in the new netfs lib[1]:

 (1) The kerneldoc for netfs_readpage() shouldn't say netfs_page().

 (2) netfs_readpage() can get an integer overflow on 32-bit when it
     multiplies page_index(page) by PAGE_SIZE.  It should use
     page_offset() instead.

 (3) netfs_write_begin() should also use page_offset() to avoid the same
     overflow.

 (4) Use page_mapping() in netfs_write_begin() rather than page->mapping.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/161789062190.6155.12711584466338493050.stg=
it@warthog.procyon.org.uk/ [1]
---
 fs/netfs/read_helper.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 1d3b50c5db6d..568e26352309 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -933,7 +933,7 @@ void netfs_readahead(struct readahead_control *ractl,
 EXPORT_SYMBOL(netfs_readahead);
 =

 /**
- * netfs_page - Helper to manage a readpage request
+ * netfs_readpage - Helper to manage a readpage request
  * @file: The file to read from
  * @page: The page to read
  * @ops: The network filesystem's operations for the helper to use
@@ -968,7 +968,7 @@ int netfs_readpage(struct file *file,
 		return -ENOMEM;
 	}
 	rreq->mapping	=3D page_file_mapping(page);
-	rreq->start	=3D page_index(page) * PAGE_SIZE;
+	rreq->start	=3D page_offset(page);
 	rreq->len	=3D thp_size(page);
 =

 	if (ops->begin_cache_operation) {
@@ -1105,8 +1105,8 @@ int netfs_write_begin(struct file *file, struct addr=
ess_space *mapping,
 	rreq =3D netfs_alloc_read_request(ops, netfs_priv, file);
 	if (!rreq)
 		goto error;
-	rreq->mapping		=3D page->mapping;
-	rreq->start		=3D page->index * PAGE_SIZE;
+	rreq->mapping		=3D page_file_mapping(page);
+	rreq->start		=3D page_offset(page);
 	rreq->len		=3D thp_size(page);
 	rreq->no_unlock_page	=3D page->index;
 	__set_bit(NETFS_RREQ_NO_UNLOCK_PAGE, &rreq->flags);

