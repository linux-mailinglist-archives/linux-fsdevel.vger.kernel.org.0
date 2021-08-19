Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B29A3F20DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 21:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhHSTml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 15:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235433AbhHSTmi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629402121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJ4+KDyHJ93lMZimECwR3DFBTP98uR2xJFwyQkji/R8=;
        b=Fn04D7EiANkGOANeJKYTDsJ0ybfsp6EDzHykjjsZtNvux1B3KLKhMXK4yxovoIUWZz135w
        SoUOm5SF770Gbzoj1uFR+JaNCXYliXh20Hp6ToDs8VHhshoPeTco6OL+h3nunCNDX+07Dv
        OCm3hYcTs7UhaHoRJfImT9voBS2C8ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-vE6w8APeP_GyeW3VnbTLRg-1; Thu, 19 Aug 2021 15:42:00 -0400
X-MC-Unique: vE6w8APeP_GyeW3VnbTLRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83717801A92;
        Thu, 19 Aug 2021 19:41:58 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 150331B46B;
        Thu, 19 Aug 2021 19:41:55 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v6 13/19] iomap: Fix iomap_dio_rw return value for user copies
Date:   Thu, 19 Aug 2021 21:40:56 +0200
Message-Id: <20210819194102.1491495-14-agruenba@redhat.com>
In-Reply-To: <20210819194102.1491495-1-agruenba@redhat.com>
References: <20210819194102.1491495-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

