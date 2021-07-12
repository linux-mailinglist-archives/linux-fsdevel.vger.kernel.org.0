Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770253C608F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhGLQa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 12:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47211 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233733AbhGLQa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626107287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orCuv0fOYAe+Okpsh58dcgcFPjvYhZB+nzgzSfjkEXM=;
        b=XUbJInrwq08Elhww+nLjePYqVAt37xrsIBD+UylYqLksQPSY8iQ49kWMkOD0KKC42/Cuef
        LlMts5zqo1VxdPA+h/ExD/34q5DYMzfXOU5M6KccwUoTux2EWcdHNUNhLT84wryyAgl4Uk
        wUG5TmkXsvN7II3GnD1OqtjZ83MM2Bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-J6-s0ueaND2X06Du1j8bqA-1; Mon, 12 Jul 2021 12:28:06 -0400
X-MC-Unique: J6-s0ueaND2X06Du1j8bqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DF81362FB;
        Mon, 12 Jul 2021 16:28:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-19.rdu2.redhat.com [10.10.118.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31DCC60936;
        Mon, 12 Jul 2021 16:28:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 3/4] afs: Fix setting of writeback_index
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Jul 2021 17:28:03 +0100
Message-ID: <162610728339.3408253.4604750166391496546.stgit@warthog.procyon.org.uk>
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

Fix afs_writepages() to always set mapping->writeback_index to a page index
and not a byte position[1].

Fixes: 31143d5d515e ("AFS: implement basic file write support")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/CAB9dFdvHsLsw7CMnB+4cgciWDSqVjuij4mH3TaXnHQB8sz5rHw@mail.gmail.com/ [1]
cc: linux-afs@lists.infradead.org
---

 fs/afs/write.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 1ed62e0ccfe5..c0534697268e 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -784,7 +784,7 @@ int afs_writepages(struct address_space *mapping,
 	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
 		ret = afs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
 		if (wbc->nr_to_write > 0 && ret == 0)
-			mapping->writeback_index = next;
+			mapping->writeback_index = next / PAGE_SIZE;
 	} else {
 		ret = afs_writepages_region(mapping, wbc,
 					    wbc->range_start, wbc->range_end, &next);


