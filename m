Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6D425269
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 14:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbhJGMDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 08:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241089AbhJGMDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633608114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q0DHA6PLEStWhML4k30x8iHQyL0+mjBxtrjprx4sMyA=;
        b=KKKzN3PNW5Rnr6J+oVmHS6CGg5YGiSIlfOW7k/RkkVNFOWTztk16jUPVPDas1NCDAhM3Ei
        nYrkXSBd3hEF84IFO4mbfab9jikDz5iI4zoakdsieRnORIa6VxlxVaGFM8YO//yLRzTr3d
        n7WkFiRNXq+p8/sEta6DgGzt8ZSe+TA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-3JbSJiIIPdWbNdk-BlmspA-1; Thu, 07 Oct 2021 08:01:53 -0400
X-MC-Unique: 3JbSJiIIPdWbNdk-BlmspA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 584D5835DE3;
        Thu,  7 Oct 2021 12:01:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC2D960C05;
        Thu,  7 Oct 2021 12:01:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH] mm: Stop filemap_read() from grabbing a superfluous page
From:   David Howells <dhowells@redhat.com>
To:     kent.overstreet@gmail.com, willy@infradead.org
Cc:     dhowells@redhat.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Oct 2021 13:01:48 +0100
Message-ID: <163360810881.1636291.17477809397516812670.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Kent Overstreet <kent.overstreet@gmail.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/160588481358.3465195.16552616179674485179.stgit@warthog.procyon.org.uk/
---

 mm/filemap.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index dae481293b5d..c0cdc44c844e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2625,6 +2625,10 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
 			iocb->ki_flags |= IOCB_NOWAIT;
 
+		isize = i_size_read(inode);
+		if (unlikely(iocb->ki_pos >= isize))
+			goto put_pages;
+
 		error = filemap_get_pages(iocb, iter, &pvec);
 		if (error < 0)
 			break;


