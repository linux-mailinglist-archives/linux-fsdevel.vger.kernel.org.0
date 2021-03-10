Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C5433442E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 17:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhCJQ6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 11:58:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233666AbhCJQ5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615395457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJ1em54X7cNlxYOwt1XkWsi2bN3JlmKyhBUdFCYW68w=;
        b=LfNr/TsOmkzujl4cBrcqey+FBn4BjzdfWd870plzsCCupX2GCKjw1Z9OBxp36Vj9FNuuOz
        MTYjd9wmS3gAtvVaoQa/FWp0MalO+iG0TsUs/7yaF4U/QKG1RAJCaQdo2wavxsEehV0XDd
        z0HLWbcNYNnQqGFLhJpFmJRYY8OIkWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-lhDkcfi-NXOnfsBkFqHPVA-1; Wed, 10 Mar 2021 11:57:36 -0500
X-MC-Unique: lhDkcfi-NXOnfsBkFqHPVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7161108BD07;
        Wed, 10 Mar 2021 16:57:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C3C460C13;
        Wed, 10 Mar 2021 16:57:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 13/28] netfs: Hold a ref on a page when PG_private_2 is set
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Mar 2021 16:57:24 +0000
Message-ID: <161539544426.286939.4484560053278261236.stgit@warthog.procyon.org.uk>
In-Reply-To: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
References: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Take a reference on a page when PG_private_2 is set and drop it once the
bit is unlocked[1].

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-mm@kvack.org
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: v9fs-developer@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com/ [1]
Link: https://lore.kernel.org/r/1331025.1612974993@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/161340400833.1303470.8070750156044982282.stgit@warthog.procyon.org.uk/ # v3
---

 fs/netfs/read_helper.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 0a7b76c11c98..ce11ca4c32e4 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/sched/mm.h>
@@ -238,10 +239,13 @@ static void netfs_rreq_unmark_after_write(struct netfs_read_request *rreq,
 					  bool was_async)
 {
 	struct netfs_read_subrequest *subreq;
+	struct pagevec pvec;
 	struct page *page;
 	pgoff_t unlocked = 0;
 	bool have_unlocked = false;
 
+	pagevec_init(&pvec);
+
 	rcu_read_lock();
 
 	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
@@ -255,6 +259,8 @@ static void netfs_rreq_unmark_after_write(struct netfs_read_request *rreq,
 				continue;
 			unlocked = page->index;
 			unlock_page_fscache(page);
+			if (pagevec_add(&pvec, page) == 0)
+				pagevec_release(&pvec);
 			have_unlocked = true;
 		}
 	}
@@ -413,8 +419,10 @@ static void netfs_rreq_unlock(struct netfs_read_request *rreq)
 				pg_failed = true;
 				break;
 			}
-			if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags))
+			if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags)) {
+				get_page(page);
 				SetPageFsCache(page);
+			}
 			pg_failed |= subreq_failed;
 			if (pgend < iopos + subreq->len)
 				break;


