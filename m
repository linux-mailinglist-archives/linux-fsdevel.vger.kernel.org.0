Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51EE3C608C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhGLQau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 12:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234507AbhGLQau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626107281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g8SD4gBexsuP6FmOHm/uXwPJ5QxYWd/skUk7z3Srqr4=;
        b=BcD+5rNtN+/erd9JFfsmjfU+x2xsdXg+sAD4lmgM927Istz2wMWUN4o2ndr6BbQ6Cy1K9h
        5kWcPFiFxGIHy4eXHe/trobNWdO2WrRo3lq7voeu8VxsZyKQXOtyCO97KfzCS7yTuW2PxH
        awOL3bSNmiRJeiWs+WSBzsTZ5DDNZEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-oQChImy2MLqq4eWbcB36cg-1; Mon, 12 Jul 2021 12:27:59 -0400
X-MC-Unique: oQChImy2MLqq4eWbcB36cg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EEF3804142;
        Mon, 12 Jul 2021 16:27:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-19.rdu2.redhat.com [10.10.118.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 276E760936;
        Mon, 12 Jul 2021 16:27:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 2/4] afs: check function return
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Tom Rix <trix@redhat.com>, dhowells@redhat.com,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Jul 2021 17:27:56 +0100
Message-ID: <162610727640.3408253.8687445613469681311.stgit@warthog.procyon.org.uk>
In-Reply-To: <162610726011.3408253.2771348573083023654.stgit@warthog.procyon.org.uk>
References: <162610726011.3408253.2771348573083023654.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem

write.c:773:29: warning: Assigned value is garbage or undefined
  mapping->writeback_index = next;
                           ^ ~~~~
The call to afs_writepages_region() can return without setting
next.  So check the function return before using next.

Changes:
 ver #2:
   - Need to fix the range_cyclic case also[1].

Fixes: e87b03f5830e ("afs: Prepare for use of THPs")
Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20210430155031.3287870-1-trix@redhat.com
Link: https://lore.kernel.org/r/162609464716.3133237.10354897554363093252.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/CAB9dFdvHsLsw7CMnB+4cgciWDSqVjuij4mH3TaXnHQB8sz5rHw@mail.gmail.com/ [1]
---

 fs/afs/write.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 3104b62c2082..1ed62e0ccfe5 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -771,13 +771,19 @@ int afs_writepages(struct address_space *mapping,
 	if (wbc->range_cyclic) {
 		start = mapping->writeback_index * PAGE_SIZE;
 		ret = afs_writepages_region(mapping, wbc, start, LLONG_MAX, &next);
-		if (start > 0 && wbc->nr_to_write > 0 && ret == 0)
-			ret = afs_writepages_region(mapping, wbc, 0, start,
-						    &next);
-		mapping->writeback_index = next / PAGE_SIZE;
+		if (ret == 0) {
+			mapping->writeback_index = next / PAGE_SIZE;
+			if (start > 0 && wbc->nr_to_write > 0) {
+				ret = afs_writepages_region(mapping, wbc, 0,
+							    start, &next);
+				if (ret == 0)
+					mapping->writeback_index =
+						next / PAGE_SIZE;
+			}
+		}
 	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
 		ret = afs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
-		if (wbc->nr_to_write > 0)
+		if (wbc->nr_to_write > 0 && ret == 0)
 			mapping->writeback_index = next;
 	} else {
 		ret = afs_writepages_region(mapping, wbc,


