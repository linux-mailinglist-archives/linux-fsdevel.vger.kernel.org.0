Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B9E3F9780
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 11:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244820AbhH0JpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 05:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245002AbhH0Joz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630057446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=umSnYP/WvzHC2yY7lWMQKN/6202Vdgqk8ZmUQWItKQo=;
        b=ApjAnc0oKLwgBGjwHK7sn1OuV4Nzlw2mu2JHFWcpFY71iALoCUXMakn2DPeRtX9uQJX/ef
        UO+aklFJOvjdDAFEflwZlgmFjCVINcMN+WTnuPME3+XbgHdCKR9iDgDzmsilGo3mqMZvwj
        xzx4A7gW2M3t3R7Nv6HU42l7dRA+hdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-TTm60KDbOYuMybYev-wCYw-1; Fri, 27 Aug 2021 05:44:02 -0400
X-MC-Unique: TTm60KDbOYuMybYev-wCYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70E4F802E73;
        Fri, 27 Aug 2021 09:43:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A19E65D6B1;
        Fri, 27 Aug 2021 09:43:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 1/6] afs: Fix afs_launder_page() to set correct start file
 position
From:   David Howells <dhowells@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Aug 2021 10:43:36 +0100
Message-ID: <163005741670.2472992.2073548908229887941.stgit@warthog.procyon.org.uk>
In-Reply-To: <163005740700.2472992.12365214290752300378.stgit@warthog.procyon.org.uk>
References: <163005740700.2472992.12365214290752300378.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs_launder_page() to set the starting position of the StoreData RPC at
the offset into the page at which the modified data starts instead of at
the beginning of the page (the iov_iter is correctly offset).

The offset got lost during the conversion to passing an iov_iter into
afs_store_data().

Changes:
ver #2:
 - Use page_offset() rather than manually calculating it[1].

Fixes: bd80d8a80e12 ("afs: Use ITER_XARRAY for writing")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/YST/0e92OdSH0zjg@casper.infradead.org/ [1]
Link: https://lore.kernel.org/r/162880783179.3421678.7795105718190440134.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/162937512409.1449272.18441473411207824084.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/162981148752.1901565.3663780601682206026.stgit@warthog.procyon.org.uk/
---

 fs/afs/write.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index fb7d5c1cabde..5c977deeeee0 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -950,8 +950,7 @@ int afs_launder_page(struct page *page)
 		iov_iter_bvec(&iter, WRITE, bv, 1, bv[0].bv_len);
 
 		trace_afs_page_dirty(vnode, tracepoint_string("launder"), page);
-		ret = afs_store_data(vnode, &iter, (loff_t)page->index * PAGE_SIZE,
-				     true);
+		ret = afs_store_data(vnode, &iter, page_offset(page) + f, true);
 	}
 
 	trace_afs_page_dirty(vnode, tracepoint_string("laundered"), page);


