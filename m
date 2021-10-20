Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9964348A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 12:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhJTKMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 06:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230005AbhJTKMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634724637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kN+rmXjeIN5RoOoqhjSuUAR3s+V7flhqvRXBT3LvpfY=;
        b=On+EX1H+81rFjeHgNaVdtA0Pyq3JTm9muPgqTSLvB4iET/EkBjhW5PGuirIL8DC5YrdsPO
        Uu/AiJxSPzLbHg9S+CjMXKJAYvXM1brvCdPz3Xygn6/FD0ro/Nct6DF43SCrydmVKxPFdW
        bAjHc0PL3PH9ngg4vKoT2MiHWWar+uE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-Q6BXm1oFMY-Na_Om9Svjow-1; Wed, 20 Oct 2021 06:10:34 -0400
X-MC-Unique: Q6BXm1oFMY-Na_Om9Svjow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71DC710A8E02;
        Wed, 20 Oct 2021 10:10:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5A2BADD9;
        Wed, 20 Oct 2021 10:10:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2] mm: Stop filemap_read() from grabbing a superfluous page
From:   David Howells <dhowells@redhat.com>
To:     kent.overstreet@gmail.com, willy@infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Oct 2021 11:10:31 +0100
Message-ID: <163472463105.3126792.7056099385135786492.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Under some circumstances, filemap_read() will allocate sufficient pages to
read to the end of the file, call readahead/readpages on them and copy the
data over - and then it will allocate another page at the EOF and call
readpage on that and then ignore it.  This is unnecessary and a waste of
time and resources.

filemap_read() *does* check for this, but only after it has already done
the allocation and I/O.  Fix this by checking before calling
filemap_get_pages() also.

Changes:
 v2) Break out of the loop immediately rather than going to put_pages (the
     pvec is unoccupied).  Setting isize is then unnecessary.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Kent Overstreet <kent.overstreet@gmail.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Jeff Layton <jlayton@redhat.com>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/160588481358.3465195.16552616179674485179.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/163456863216.2614702.6384850026368833133.stgit@warthog.procyon.org.uk/
---

 mm/filemap.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index dae481293b5d..e50be519f6a4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2625,6 +2625,9 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
 			iocb->ki_flags |= IOCB_NOWAIT;
 
+		if (unlikely(iocb->ki_pos >= i_size_read(inode)))
+			break;
+
 		error = filemap_get_pages(iocb, iter, &pvec);
 		if (error < 0)
 			break;


