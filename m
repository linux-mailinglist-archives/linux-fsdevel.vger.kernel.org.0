Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3588F442E1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 13:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhKBMeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 08:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231879AbhKBMdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635856277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=okOPeC9PT1fhAG9u4NMdsD5hXJDLof2MB4Ib0EqHhoA=;
        b=MR6XyEPxFmjBY8BS4N1Quiz70q2FIBzvHP8nnoTxh6GxcngScTTxvshNlssw+3MHfl2CBd
        ZcVOT6SBcN6VQCKWIjsd2JikkF4hshva5x8j1rJ+GMaWCrWtE8LUE0MtXRh3vunO8ofbTG
        kG3YTZM1AedSfPNXnQyVKwD7FY0pnKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-w8K_jOW5O-acrzRVR5NB5Q-1; Tue, 02 Nov 2021 08:31:15 -0400
X-MC-Unique: w8K_jOW5O-acrzRVR5NB5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE09380A5C3;
        Tue,  2 Nov 2021 12:31:13 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.195.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88A9319811;
        Tue,  2 Nov 2021 12:31:10 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v9 13/17] iomap: Support partial direct I/O on user copy failures
Date:   Tue,  2 Nov 2021 13:29:41 +0100
Message-Id: <20211102122945.117744-14-agruenba@redhat.com>
In-Reply-To: <20211102122945.117744-1-agruenba@redhat.com>
References: <20211102122945.117744-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In iomap_dio_rw, when iomap_apply returns an -EFAULT error and the
IOMAP_DIO_PARTIAL flag is set, complete the request synchronously and
return a partial result.  This allows the caller to deal with the page
fault and retry the remainder of the request.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/direct-io.c  | 6 ++++++
 include/linux/iomap.h | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index a2a368e824c0..a434fb7887b2 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -581,6 +581,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iov_iter_rw(iter) == READ && iomi.pos >= dio->i_size)
 		iov_iter_revert(iter, iomi.pos - dio->i_size);
 
+	if (ret == -EFAULT && dio->size && (dio_flags & IOMAP_DIO_PARTIAL)) {
+		if (!(iocb->ki_flags & IOCB_NOWAIT))
+			wait_for_completion = true;
+		ret = 0;
+	}
+
 	/* magic error code to fall back to buffered I/O */
 	if (ret == -ENOTBLK) {
 		wait_for_completion = true;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 24f8489583ca..2a213b0d1e1f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -330,6 +330,13 @@ struct iomap_dio_ops {
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
2.31.1

