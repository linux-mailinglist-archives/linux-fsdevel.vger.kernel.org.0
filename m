Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679263F20DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 21:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhHSTm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 15:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235468AbhHSTmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629402126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEdh4JFLYRsuZzefqrc2GRJpUnyWETbVekgWWtQoVm4=;
        b=fmenHRnKsbchgiUZyapzEEb8Zv810JCnUXH1l3QwoBW28Q+yL1dOOjTSlJyOjDcZB2LlYW
        Rfesndde2IEL+4QEVcXhGQdll7/IbGJJq8yGRhUrGH2kDVxgqlq2w1a7o3WunsYJJPJp5u
        eUUJoG2r802mVTBBI/kaocSmd97IQws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-CdsMeSumPnebNm7RHSEZEA-1; Thu, 19 Aug 2021 15:42:02 -0400
X-MC-Unique: CdsMeSumPnebNm7RHSEZEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54064190A7A1;
        Thu, 19 Aug 2021 19:42:01 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9B4E1B46B;
        Thu, 19 Aug 2021 19:41:58 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v6 14/19] iomap: Support partial direct I/O on user copy failures
Date:   Thu, 19 Aug 2021 21:40:57 +0200
Message-Id: <20210819194102.1491495-15-agruenba@redhat.com>
In-Reply-To: <20210819194102.1491495-1-agruenba@redhat.com>
References: <20210819194102.1491495-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In iomap_dio_rw, when iomap_apply returns an -EFAULT error and the
IOMAP_DIO_PARTIAL flag is set, complete the request synchronously and
return a partial result.  This allows the caller to deal with the page
fault and retry the remainder of the request.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/direct-io.c  | 6 ++++++
 include/linux/iomap.h | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8054f5d6c273..ba88fe51b77a 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -561,6 +561,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		ret = iomap_apply(inode, pos, count, iomap_flags, ops, dio,
 				iomap_dio_actor);
 		if (ret <= 0) {
+			if (ret == -EFAULT && dio->size &&
+			    (dio_flags & IOMAP_DIO_PARTIAL)) {
+				wait_for_completion = true;
+				ret = 0;
+			}
+
 			/* magic error code to fall back to buffered I/O */
 			if (ret == -ENOTBLK) {
 				wait_for_completion = true;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 479c1da3e221..bcae4814b8e3 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -267,6 +267,13 @@ struct iomap_dio_ops {
   */
 #define IOMAP_DIO_OVERWRITE_ONLY	(1 << 1)
 
+/*
+ * When a page fault occurs, return a partial synchronous result and allow
+ * the caller to retry the rest of the operation after dealing with the page
+ * fault.
+ */
+#define IOMAP_DIO_PARTIAL		(1 << 2)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags);
-- 
2.26.3

