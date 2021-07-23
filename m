Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5FF3D41DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 22:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhGWUSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 16:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231912AbhGWUSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 16:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627073947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z5USnk4oWsRd3FH8wsMXQrumYbkYOqMoj1HmwKEKTOA=;
        b=WDqn5LM7+YsuJdH7GpQSeDPouOSmRtfwDwonR/60+KGA899ZWf3Ejc9FH2PMpGPaincJxi
        J8A5D4dDC647xXQHD4l3fEqYT7aqyL5jjdgZjka0T8ePGgtJ8lTwiqJv0DJFl/m+epvotB
        8wdnb0O5SGM9K0pqi0nlqMXKkFvhdBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-MxGRGdVCMoaYazztEfS8xw-1; Fri, 23 Jul 2021 16:59:03 -0400
X-MC-Unique: MxGRGdVCMoaYazztEfS8xw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90B3F1853029;
        Fri, 23 Jul 2021 20:59:02 +0000 (UTC)
Received: from max.com (unknown [10.40.194.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D4C610074FD;
        Fri, 23 Jul 2021 20:59:00 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 5/7] iomap: Support restarting direct I/O requests after user copy failures
Date:   Fri, 23 Jul 2021 22:58:38 +0200
Message-Id: <20210723205840.299280-6-agruenba@redhat.com>
In-Reply-To: <20210723205840.299280-1-agruenba@redhat.com>
References: <20210723205840.299280-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In __iomap_dio_rw, when iomap_apply returns an -EFAULT error, complete the
request synchronously and reset the iterator to the start position.  This
allows callers to deal with the failure and retry the operation.

In gfs2, we need to disable page faults while we're holding glocks to prevent
deadlocks.  This patch is the minimum solution I could find to make
iomap_dio_rw work with page faults disabled.  It's still expensive because any
I/O that was carried out before hitting -EFAULT needs to be retried.

A possible improvement would be to add an IOMAP_DIO_FAULT_RETRY or similar flag
that would allow iomap_dio_rw to return a short result when hitting -EFAULT.
Callers could then retry only the rest of the request after dealing with the
page fault.

Asynchronous requests turn into synchronous requests up to the point of the
page fault in any case, but they could be retried asynchronously after dealing
with the page fault.  To make that work, the completion notification would have
to include the bytes read or written before the page fault(s) as well, and we'd
need an additional iomap_dio_rw argument for that.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/direct-io.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index cc0b4bc8861b..b0a494211bb4 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -561,6 +561,15 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		ret = iomap_apply(inode, pos, count, iomap_flags, ops, dio,
 				iomap_dio_actor);
 		if (ret <= 0) {
+			if (ret == -EFAULT) {
+				/*
+				 * To allow retrying the request, fail
+				 * synchronously and reset the iterator.
+				 */
+				wait_for_completion = true;
+				iov_iter_revert(dio->submit.iter, dio->size);
+			}
+
 			/* magic error code to fall back to buffered I/O */
 			if (ret == -ENOTBLK) {
 				wait_for_completion = true;
-- 
2.26.3

