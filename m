Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7941B21382C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 11:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgGCJxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 05:53:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41077 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgGCJxf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593770013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H3F7Np/uM/15jpMjri5ryOy3uvdVrn3PYgDhCmIq6hw=;
        b=VHu7N1KgO+LkAB0yNVNU7MftNrb8HBg3gc9k49D0itahg9FcOsIi4yMyv2idXMm+WV+dJf
        EpckcxV3tjuNE1IYZlIIOrt9LxrsqkVD2G/QpJuh65vcF7au/nTqyt2h5TeXYBp7D2hmMT
        sW1wsrpsaRRqV7/jHHlUe+1SZQEtoN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-g2LTuadCPpCwQwFgSo78mw-1; Fri, 03 Jul 2020 05:53:32 -0400
X-MC-Unique: g2LTuadCPpCwQwFgSo78mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1109F107ACF4;
        Fri,  3 Jul 2020 09:53:31 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 494ED6111F;
        Fri,  3 Jul 2020 09:53:29 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC v2 1/2] fs: Add IOCB_NOIO flag for generic_file_read_iter
Date:   Fri,  3 Jul 2020 11:53:24 +0200
Message-Id: <20200703095325.1491832-2-agruenba@redhat.com>
In-Reply-To: <20200703095325.1491832-1-agruenba@redhat.com>
References: <20200703095325.1491832-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an IOCB_NOIO flag that indicates to generic_file_read_iter that it
shouldn't trigger any filesystem I/O for the actual request or for
readahead.  This allows to do tentative reads out of the page cache as
some filesystems allow, and to take the appropriate locks and retry the
reads only if the requested pages are not cached.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/fs.h |  1 +
 mm/filemap.c       | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea7..1ab2ea19e883 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -315,6 +315,7 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+#define IOCB_NOIO		(1 << 8)
 
 struct kiocb {
 	struct file		*ki_filp;
diff --git a/mm/filemap.c b/mm/filemap.c
index f0ae9a6308cb..22f7ff2d369e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2028,7 +2028,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		page = find_get_page(mapping, index);
 		if (!page) {
-			if (iocb->ki_flags & IOCB_NOWAIT)
+			if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
 				goto would_block;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
@@ -2038,6 +2038,10 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 				goto no_cached_page;
 		}
 		if (PageReadahead(page)) {
+			if (iocb->ki_flags & IOCB_NOIO) {
+				put_page(page);
+				goto out;
+			}
 			page_cache_async_readahead(mapping,
 					ra, filp, page,
 					index, last_index - index);
@@ -2249,9 +2253,18 @@ EXPORT_SYMBOL_GPL(generic_file_buffered_read);
  *
  * This is the "read_iter()" routine for all filesystems
  * that can use the page cache directly.
+ *
+ * The IOCB_NOWAIT flag in iocb->ki_flags indicates that -EAGAIN shall
+ * be returned when no data can be read without waiting for I/O requests
+ * to complete; it doesn't prevent readahead.
+ *
+ * The IOCB_NOIO flag in iocb->ki_flags indicates that -EAGAIN shall be
+ * returned when no data can be read without issuing new I/O requests,
+ * and 0 shall be returned when readhead would have been triggered.
+ *
  * Return:
  * * number of bytes copied, even for partial reads
- * * negative error code if nothing was read
+ * * negative error code (or 0 if IOCB_NOIO) if nothing was read
  */
 ssize_t
 generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
-- 
2.26.2

