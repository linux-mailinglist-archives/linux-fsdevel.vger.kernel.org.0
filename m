Return-Path: <linux-fsdevel+bounces-693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236657CE6D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 20:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DCDCB211BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80278450ED;
	Wed, 18 Oct 2023 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nw6xX6ss"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365C4448B
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 18:37:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95071119
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 11:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697654242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Q/0ep7eS2yn1G5ni+CIWne5Bs5Cck5auB+wlCPDOEU=;
	b=Nw6xX6ssD8s77JAqVeyRxJ5lDLa9KIWcWxk9FIVY6DIX9FRLCeTgq9bXlDtohHND38uozB
	L97VLql7UcmFz8qyPpDtfX80ObxReGIF5cIitSjUKjbsYxexKxSE/lIIwWlYKy/lCnsAAo
	GGtjLdtN9ZQ6bmLOMayRRNrk08u6tog=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-Mu_eMp-RO9OeB8AD4XfzsA-1; Wed, 18 Oct 2023 14:37:18 -0400
X-MC-Unique: Mu_eMp-RO9OeB8AD4XfzsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 617943C0C113;
	Wed, 18 Oct 2023 18:37:17 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.167])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53C8E40C6F7D;
	Wed, 18 Oct 2023 18:37:15 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: djwong@kernel.org,
	willy@infradead.org,
	hch@lst.de,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jstancek@redhat.com
Subject: [PATCH v2] iomap: fix short copy in iomap_write_iter()
Date: Wed, 18 Oct 2023 20:32:32 +0200
Message-Id: <e1cb4f8981f8c6e7e0384e95faf1911d9937e979.1697647960.git.jstancek@redhat.com>
In-Reply-To: <8762e91a210f4cc5713fce05fe5906c18513bd0a.1697617238.git.jstancek@redhat.com>
References: <8762e91a210f4cc5713fce05fe5906c18513bd0a.1697617238.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Starting with commit 5d8edfb900d5 ("iomap: Copy larger chunks from
userspace"), iomap_write_iter() can get into endless loop. This can
be reproduced with LTP writev07 which uses partially valid iovecs:
        struct iovec wr_iovec[] = {
                { buffer, 64 },
                { bad_addr, 64 },
                { buffer + 64, 64 },
                { buffer + 64 * 2, 64 },
        };

commit bc1bb416bbb9 ("generic_perform_write()/iomap_write_actor():
saner logics for short copy") previously introduced the logic, which
made short copy retry in next iteration with amount of "bytes" it
managed to copy:

                if (unlikely(status == 0)) {
                        /*
                         * A short copy made iomap_write_end() reject the
                         * thing entirely.  Might be memory poisoning
                         * halfway through, might be a race with munmap,
                         * might be severe memory pressure.
                         */
                        if (copied)
                                bytes = copied;

However, since 5d8edfb900d5 "bytes" is no longer carried into next
iteration, because it is now always initialized at the beginning of
the loop. And for iov_iter_count < PAGE_SIZE, "bytes" ends up with
same value as previous iteration, making the loop retry same copy
over and over, which leads to writev07 testcase hanging.

Make next iteration retry with amount of bytes we managed to copy.

Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
Changes in v2:
- use goto instead of new variable (suggested by Christoph Hellwig)

 fs/iomap/buffered-io.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5db54ca29a35..2bc0aa23fde3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -881,8 +881,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
 
+		bytes = iov_iter_count(i);
+retry:
 		offset = pos & (chunk - 1);
-		bytes = min(chunk - offset, iov_iter_count(i));
+		bytes = min(chunk - offset, bytes);
 		status = balance_dirty_pages_ratelimited_flags(mapping,
 							       bdp_flags);
 		if (unlikely(status))
@@ -933,10 +935,12 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			 * halfway through, might be a race with munmap,
 			 * might be severe memory pressure.
 			 */
-			if (copied)
-				bytes = copied;
 			if (chunk > PAGE_SIZE)
 				chunk /= 2;
+			if (copied) {
+				bytes = copied;
+				goto retry;
+			}
 		} else {
 			pos += status;
 			written += status;
-- 
2.31.1


