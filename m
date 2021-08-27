Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399C23F9CFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 18:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbhH0QwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 12:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236442AbhH0QwB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630083071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJ4+KDyHJ93lMZimECwR3DFBTP98uR2xJFwyQkji/R8=;
        b=iXZv7z5WfuGx0ZOjpLMxRoQn25tjO3TLw0kfIphBv37jNXLz4W1aIvTA0KHzaFYCgQ7siQ
        iHDnL5p1v/BxjsSO01xgD/FWRJSd5MIDcOUTeRY4SE2KtBfvUgOPr0NIaoEkVIzh1z7fSc
        Q0FCwfoLJZyMhKd5nYhH/zNG3DJIiKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-AfKozw1XM1mze7tQoVnZrg-1; Fri, 27 Aug 2021 12:51:09 -0400
X-MC-Unique: AfKozw1XM1mze7tQoVnZrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AB1B190A7A2;
        Fri, 27 Aug 2021 16:51:08 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A9D560C82;
        Fri, 27 Aug 2021 16:51:02 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v7 14/19] iomap: Fix iomap_dio_rw return value for user copies
Date:   Fri, 27 Aug 2021 18:49:21 +0200
Message-Id: <20210827164926.1726765-15-agruenba@redhat.com>
In-Reply-To: <20210827164926.1726765-1-agruenba@redhat.com>
References: <20210827164926.1726765-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a user copy fails in one of the helpers of iomap_dio_rw, fail with
-EFAULT instead of returning 0.  This matches what iomap_dio_bio_actor
returns when it gets an -EFAULT from bio_iov_iter_get_pages.  With these
changes, iomap_dio_actor now consistently fails with -EFAULT when a user
page cannot be faulted in.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..8054f5d6c273 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -370,7 +370,7 @@ iomap_dio_hole_actor(loff_t length, struct iomap_dio *dio)
 {
 	length = iov_iter_zero(length, dio->submit.iter);
 	dio->size += length;
-	return length;
+	return length ? length : -EFAULT;
 }
 
 static loff_t
@@ -397,7 +397,7 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
 	}
 	dio->size += copied;
-	return copied;
+	return copied ? copied : -EFAULT;
 }
 
 static loff_t
-- 
2.26.3

