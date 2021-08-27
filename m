Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD353FA18F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 00:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhH0WkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 18:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26835 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232287AbhH0WkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630103953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=n+im3adj8DNRXnbTmQARvHJ2DdknkO8ddntY8WQyZPE=;
        b=ghQwgYR+1fgdfrpi4qUhT/v696zhutEknjkVKIYWG8VWiHW7BIJAiBbcl7dsSFVgVzPPdw
        0oD0KCnrI3TBloBtwBwuF2A5LbQFeidnf9kkxksKL+c7vGzHoSILpaMzrbNcgTOlVD1ZlM
        IRpSkKVE/cJspg8iirH669J/SdmkrXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-Z2tclGrCOfuonxp_jDeqVg-1; Fri, 27 Aug 2021 18:39:10 -0400
X-MC-Unique: Z2tclGrCOfuonxp_jDeqVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 763F8107ACF5;
        Fri, 27 Aug 2021 22:39:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 404586788B;
        Fri, 27 Aug 2021 22:39:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix missing put on afs_read objects on missing get on
 the key therein
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Aug 2021 23:39:07 +0100
Message-ID: <163010394740.3035676.8516846193899793357.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The afs_read objects created by afs_req_issue_op() get leaked because
afs_alloc_read() returns a ref and then afs_fetch_data() gets its own ref
which is released when the operation completes, but the initial ref is
never released.

Fix this by discarding the initial ref at the end of afs_req_issue_op().

This leak also covered another bug whereby a ref isn't got on the key
attached to the read record by afs_req_issue_op().  This isn't a problem as
long as the afs_read req never goes away...

Fix this by calling key_get() in afs_req_issue_op().

This was found by the generic/047 test.  It leaks ~4GiB of RAM each time it
is run.

Fixes: f7605fa869cf ("afs: Fix leak of afs_read objects")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/file.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index db035ae2a134..6688fff14b0b 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -295,7 +295,7 @@ static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
 	fsreq->subreq	= subreq;
 	fsreq->pos	= subreq->start + subreq->transferred;
 	fsreq->len	= subreq->len   - subreq->transferred;
-	fsreq->key	= subreq->rreq->netfs_priv;
+	fsreq->key	= key_get(subreq->rreq->netfs_priv);
 	fsreq->vnode	= vnode;
 	fsreq->iter	= &fsreq->def_iter;
 
@@ -304,6 +304,7 @@ static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
 			fsreq->pos, fsreq->len);
 
 	afs_fetch_data(fsreq->vnode, fsreq);
+	afs_put_read(fsreq);
 }
 
 static int afs_symlink_readpage(struct page *page)


