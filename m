Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870003D4994
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 21:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhGXSy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 14:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230075AbhGXSyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 14:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627155323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlV78agUrABREXpDwHnFobASjjrmkrmXAkGCJNUidbE=;
        b=MzZ1H+4fyIDULt+MTSd3INstdVoMspqrXbA31QewwJ3A6j9zYR3YVECdWJWS1/eUMT1b0V
        eL3kRgNTQF35pYGA/BG/tAV6ZJWLWb8p+8cZpSOd0a9yXeiFvKf54jt/gJClTcGhW+3M47
        4uYQI0ggqdBnhkZx33SKx56XStASKSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143--w01YonrMLiV3vWGsDxy9g-1; Sat, 24 Jul 2021 15:35:21 -0400
X-MC-Unique: -w01YonrMLiV3vWGsDxy9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE26C1084F55;
        Sat, 24 Jul 2021 19:35:19 +0000 (UTC)
Received: from max.com (unknown [10.40.194.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78D92544F1;
        Sat, 24 Jul 2021 19:35:17 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v4 6/8] iomap: Support restarting direct I/O requests after user copy failures
Date:   Sat, 24 Jul 2021 21:34:47 +0200
Message-Id: <20210724193449.361667-7-agruenba@redhat.com>
In-Reply-To: <20210724193449.361667-1-agruenba@redhat.com>
References: <20210724193449.361667-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In iomap_dio_rw, when iomap_apply returns an -EFAULT error, complete the
request synchronously.  Either return a partial result (when the
IOMAP_DIO_FAULT_RETRY flag is set and the caller is thus prepared to handle
partial results), or reset the iterator to the start to allow a restart.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/direct-io.c  | 13 +++++++++++++
 include/linux/iomap.h |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 51831ce93f6e..1ba825bab08b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -565,6 +565,19 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		ret = iomap_apply(inode, pos, count, iomap_flags, ops, dio,
 				iomap_dio_actor);
 		if (ret <= 0) {
+			if (ret == -EFAULT) {
+				/*
+				 * Finish synchronously and revert the iterator
+				 * when failing the request to allow a retry.
+				 */
+				wait_for_completion = true;
+				if (dio->size &&
+				    (dio_flags & IOMAP_DIO_FAULT_RETRY))
+					ret = 0;
+				else
+					iov_iter_revert(iter, dio->size);
+			}
+
 			/* magic error code to fall back to buffered I/O */
 			if (ret == -ENOTBLK) {
 				wait_for_completion = true;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8aea35f1a003..9dbba9f7c945 100644
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
+#define IOMAP_DIO_FAULT_RETRY		(1 << 2)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, size_t done_before);
-- 
2.26.3

