Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B09038AE28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 14:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhETM2U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 08:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235113AbhETM1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 08:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621513550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jVHI9tAO4j1d0e06AWNsK9Ts1IDxwkkuCGwpEsW+/6g=;
        b=GzkPW/hyurEEZ6U6SE7Y5RRExZ0lXwk75E9gmWOmc5ROMn1pr7jvBf3Z/tMoO/tqKCRCU7
        qV5PGJOrLTEUCVU7Mktqp5+tV2a868DEobZ+th83D1TA3RpX3alI2HqH0n+GntcwPCDE69
        LlcmkjZ0pwcEXOLYW9V2n/hYGxoFbF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-cfoyeOgQNduXqNWdhpx9LA-1; Thu, 20 May 2021 08:25:48 -0400
X-MC-Unique: cfoyeOgQNduXqNWdhpx9LA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79F75802B4F;
        Thu, 20 May 2021 12:25:47 +0000 (UTC)
Received: from max.com (unknown [10.40.195.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF11760C04;
        Thu, 20 May 2021 12:25:45 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, cluster-devel@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/6] iov_iter: Add iov_iter_fault_in_writeable()
Date:   Thu, 20 May 2021 14:25:32 +0200
Message-Id: <20210520122536.1596602-3-agruenba@redhat.com>
In-Reply-To: <20210520122536.1596602-1-agruenba@redhat.com>
References: <20210520122536.1596602-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the equivalent of iov_iter_fault_in_readable(), but for pages that will be
written to.

While at it, fix an indentation error in iov_iter_fault_in_readable().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/uio.h |  1 +
 lib/iov_iter.c      | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index d3ec87706d75..6811eb6ac6e3 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -124,6 +124,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
 int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes);
+int iov_iter_fault_in_writeable(struct iov_iter *i, size_t bytes);
 size_t iov_iter_single_seg_count(const struct iov_iter *i);
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c701b7a187f2..317c94eac907 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -480,13 +480,31 @@ int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
 		iterate_iovec(i, bytes, v, iov, skip, ({
 			err = fault_in_pages_readable(v.iov_base, v.iov_len);
 			if (unlikely(err))
-			return err;
+				return err;
 		0;}))
 	}
 	return 0;
 }
 EXPORT_SYMBOL(iov_iter_fault_in_readable);
 
+int iov_iter_fault_in_writeable(struct iov_iter *i, size_t bytes)
+{
+	size_t skip = i->iov_offset;
+	const struct iovec *iov;
+	int err;
+	struct iovec v;
+
+	if (!(i->type & (ITER_BVEC|ITER_KVEC))) {
+		iterate_iovec(i, bytes, v, iov, skip, ({
+			err = fault_in_pages_writeable(v.iov_base, v.iov_len);
+			if (unlikely(err))
+				return err;
+		0;}))
+	}
+	return 0;
+}
+EXPORT_SYMBOL(iov_iter_fault_in_writeable);
+
 void iov_iter_init(struct iov_iter *i, unsigned int direction,
 			const struct iovec *iov, unsigned long nr_segs,
 			size_t count)
-- 
2.26.3

