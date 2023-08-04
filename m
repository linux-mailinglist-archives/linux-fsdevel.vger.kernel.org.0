Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217E67700E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjHDNOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjHDNOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DB549C1
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHYA2IrNpONr95AjtpQxWSgfxf0e6O6AgQhvb/6sHd0=;
        b=Mb3fsKF7nWAP5tEweftJBcZOpkklNbANNwwz6NrrDuNab0KcqA6WLBxjXZnSSJQzDOzmFV
        6qsn6yCqbW9tjdjJrLbkenMAoXFVaW5m+j6N1EbMlxOpory7P1Cf+55ZeQmey91i0nnE1y
        3YaYgwYXP8vY4mSxdoFNHGKkmsetEeE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-SckMlT4pN9uRr4YSQHtsZw-1; Fri, 04 Aug 2023 09:13:34 -0400
X-MC-Unique: SckMlT4pN9uRr4YSQHtsZw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC7F28022EF;
        Fri,  4 Aug 2023 13:13:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC457492CA6;
        Fri,  4 Aug 2023 13:13:32 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/18] iov_iter: Add function to see if buffer is all zeros
Date:   Fri,  4 Aug 2023 14:13:10 +0100
Message-ID: <20230804131327.2574082-2-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function to scan a buffer and indicate if all of the bytes contained
therein are zero.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/uio.h |  1 +
 lib/iov_iter.c      | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index ff81e5ccaef2..49de7b8a8890 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -264,6 +264,7 @@ static inline bool iov_iter_is_copy_mc(const struct iov_iter *i)
 #endif
 
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
+bool iov_iter_is_zero(const struct iov_iter *i, size_t count);
 bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
 			unsigned len_mask);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index b667b1e2f688..ec9e3e1a11a9 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -566,6 +566,28 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_zero);
 
+/**
+ * iov_iter_is_zero - Return true if the buffer is entirely zeroed
+ * @i: The iterator describing the buffer
+ * @count: Amount of buffer to scan
+ *
+ * Scans the specified amount of the supplied buffer and returns true if only
+ * zero bytes are found therein and false otherwise.
+ */
+bool iov_iter_is_zero(const struct iov_iter *i, size_t count)
+{
+	struct iov_iter j = *i, *pj = &j;
+	void *p;
+
+	iterate_and_advance(pj, count, base, len, count,
+			    ({ p = memchr_inv(base, 0, len); p ? p - base : len; }),
+			    ({ p = memchr_inv(base, 0, len); p ? p - base : len; })
+	)
+
+	return !count;
+}
+EXPORT_SYMBOL(iov_iter_is_zero);
+
 size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t bytes,
 				  struct iov_iter *i)
 {

