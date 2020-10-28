Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD9429DCDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733154AbgJ1WXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732846AbgJ1WW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9U/jwdb6mwOhoCQYyqS94x38hiiYC1ycmew3Gz8Xmk=;
        b=eGt+vo0eO5wO0cb152Sbj5Td6WBBfB/Hb0wt6yayjva2rENWRF5MCQ8EFVVU0OnE2RSCdt
        Xrdm6UhVT8bzPYnG2vA8/B/2rgk5tYctdXpqhfEzFvdZ1fb2ROgs7vtA3FmTHqnoL75EjP
        yxEDQzcNhX0AV4y3DHU051P3Glmj8ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-ZwunBqjdM0C-O37Nx0H9Ug-1; Wed, 28 Oct 2020 18:22:53 -0400
X-MC-Unique: ZwunBqjdM0C-O37Nx0H9Ug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 391B456FDE;
        Wed, 28 Oct 2020 22:22:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55C7D5B4B2;
        Wed, 28 Oct 2020 22:22:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/11] afs: Fix tracing deref-before-check
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 22:22:50 +0000
Message-ID: <160392377060.592578.13639668128726372248.stgit@warthog.procyon.org.uk>
In-Reply-To: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
References: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch dca54a7bbb8c: "afs: Add tracing for cell refcount and active user
count" from Oct 13, 2020, leads to the following Smatch complaint:

    fs/afs/cell.c:596 afs_unuse_cell()
    warn: variable dereferenced before check 'cell' (see line 592)

Fix this by moving the retrieval of the cell debug ID to after the check of
the validity of the cell pointer.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: dca54a7bbb8c ("afs: Add tracing for cell refcount and active user count")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dan Carpenter <dan.carpenter@oracle.com>
---

 fs/afs/cell.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 52233fa6195f..887b673f6223 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -589,7 +589,7 @@ struct afs_cell *afs_use_cell(struct afs_cell *cell, enum afs_cell_trace reason)
  */
 void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_trace reason)
 {
-	unsigned int debug_id = cell->debug_id;
+	unsigned int debug_id;
 	time64_t now, expire_delay;
 	int u, a;
 
@@ -604,6 +604,7 @@ void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_tr
 	if (cell->vl_servers->nr_servers)
 		expire_delay = afs_cell_gc_delay;
 
+	debug_id = cell->debug_id;
 	u = atomic_read(&cell->ref);
 	a = atomic_dec_return(&cell->active);
 	trace_afs_cell(debug_id, u, a, reason);


