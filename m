Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F37403D17
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352227AbhIHP64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 11:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352236AbhIHP6x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631116665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIYOIZTjSumo0cZjZ+r3pqvQFMtN5uYJIKOnJtD04/o=;
        b=bKFjg9oghKQ1LxZFynpAel7TsU8GxuQ+PCV5CLyCLUHAmhZv8LKE6HgtAfTUIsiBrhELkz
        8niL1naHEjh0E7SWLGfCsO0GiYR7m0HCKvjYt2XAQPsOGkuJscB+II8Vui78KI3DC0CJuJ
        iOvRsgP+Q6aWIeTRCpsyiK3FryIzoDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-ALKHmArIND-X1cA0CTMYxA-1; Wed, 08 Sep 2021 11:57:42 -0400
X-MC-Unique: ALKHmArIND-X1cA0CTMYxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20025801A92;
        Wed,  8 Sep 2021 15:57:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F017C5D9C6;
        Wed,  8 Sep 2021 15:57:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/6] afs: Fix missing put on afs_read objects and missing get
 on the key therein
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        markus.suvanto@gmail.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Sep 2021 16:57:39 +0100
Message-ID: <163111665914.283156.3038561975681836591.stgit@warthog.procyon.org.uk>
In-Reply-To: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
References: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

This was found by the generic/074 test.  It leaks a bunch of kmalloc-192
objects each time it is run, which can be observed by watching
/proc/slabinfo.

Fixes: f7605fa869cf ("afs: Fix leak of afs_read objects")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/163010394740.3035676.8516846193899793357.stgit@warthog.procyon.org.uk/
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


