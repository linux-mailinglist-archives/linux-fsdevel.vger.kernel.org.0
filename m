Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0043D43204E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhJROyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232464AbhJROyJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634568718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2pO0HYOIIwD/Lw/VU0P6w15qtVfjBqMaV1iunSc4EI=;
        b=Bf7mvUcLvbfo0fI58x35zipm8ZLEXcIjntpxCI3TE+4oEI7t9NYlvl5zIonBWWKXcPBLWy
        R0R8TfHREK1jwnLnAxq+8TB2guoEDYNsZaS/6gfe8qYzUaIOL+l0z2rAbEN9DzXSnxOWda
        3kxzIjRLyE6n/vxggNH58q4DljN/BZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-SRK6oy3jNimOUw2cLzn71A-1; Mon, 18 Oct 2021 10:51:55 -0400
X-MC-Unique: SRK6oy3jNimOUw2cLzn71A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B055A362F9;
        Mon, 18 Oct 2021 14:51:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0EBB5F4EE;
        Mon, 18 Oct 2021 14:51:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/67] afs: Fix afs_write_end() to handle len > page size
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
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
Date:   Mon, 18 Oct 2021 15:51:43 +0100
Message-ID: <163456870391.2614702.14754663282861965969.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is possible for the len argument to afs_write_end() to overrun the end
of the page (len is used to key the size of the page in afs_write_start()
when compound pages become a regular thing).

Fix afs_write_end() to correctly trim the write length so that it doesn't
exceed the end of the page.

Fixes: 3003bbd0697b ("afs: Use the netfs_write_begin() helper")
Reported-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk/ # v1
---

 fs/afs/write.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index c09830c9dc43..e1cb19cb6314 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -119,6 +119,7 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 	_enter("{%llx:%llu},{%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, page->index);
 
+	len = min_t(size_t, len, thp_size(page) - from);
 	if (!PageUptodate(page)) {
 		if (copied < len) {
 			copied = 0;


