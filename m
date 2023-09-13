Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D4C79EF8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjIMQ6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjIMQ6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1794A1BF7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJaTbGB+togQTw9SIdIdixTkcz5/QJ2b3c5fZ9o3sSg=;
        b=dosB59GerJt17VVwQ4JHDDwNjPeqNopMnuOZFEMjAWZAg4VmfjKzUpmIM3ChlJbsw93Yg3
        UH2YvEKWgWZ7tSb84zxcUKxT9WLc9s2j2E/SFXxy+W6C8txp8Paf0GCEquVtp1WhkH3b9C
        RNxk2cmDEKCPOLat3mMLpfYeFWjYGkk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-694-6buX1QvqNt-weeixz82rJw-1; Wed, 13 Sep 2023 12:57:12 -0400
X-MC-Unique: 6buX1QvqNt-weeixz82rJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 222FF18312C9;
        Wed, 13 Sep 2023 16:57:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B42840C6EBF;
        Wed, 13 Sep 2023 16:57:08 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/13] iov_iter: Make copy_from_iter() always handle MCE
Date:   Wed, 13 Sep 2023 17:56:42 +0100
Message-ID: <20230913165648.2570623-8-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-1-dhowells@redhat.com>
References: <20230913165648.2570623-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make copy_from_iter() always catch an MCE and return a short copy and make
the coredump code rely on that.  This requires arch support in the form of
a memcpy_mc() function that returns the length copied.

[?] Is it better to kill the thread in the event of an MCE occurring?

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <christian@brauner.io>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: David Laight <David.Laight@ACULAB.COM>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 arch/x86/include/asm/mce.h | 23 +++++++++++++++++++++++
 fs/coredump.c              |  1 -
 lib/iov_iter.c             | 12 +++++-------
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 180b1cbfcc4e..77ce2044536c 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -353,4 +353,27 @@ static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_am
 
 unsigned long copy_mc_fragile_handle_tail(char *to, char *from, unsigned len);
 
+static __always_inline __must_check
+size_t memcpy_mc(void *to, const void *from, size_t len)
+{
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+	/*
+	 * If CPU has FSRM feature, use 'rep movs'.
+	 * Otherwise, use rep_movs_alternative.
+	 */
+	asm volatile(
+		"1:\n\t"
+		ALTERNATIVE("rep movsb",
+			    "call rep_movs_alternative", ALT_NOT(X86_FEATURE_FSRM))
+		"2:\n"
+		_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_DEFAULT_MCE_SAFE)
+		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
+		: : "memory", "rax", "r8", "r9", "r10", "r11");
+#else
+	memcpy(to, from, len);
+	return 0;
+#endif
+	return len;
+}
+
 #endif /* _ASM_X86_MCE_H */
diff --git a/fs/coredump.c b/fs/coredump.c
index 9d235fa14ab9..ad54102a5e14 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -884,7 +884,6 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	pos = file->f_pos;
 	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
 	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
-	iov_iter_set_copy_mc(&iter);
 	n = __kernel_write_iter(cprm->file, &iter, &pos);
 	if (n != PAGE_SIZE)
 		return 0;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 65374ee91ecd..b574601783bc 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -14,6 +14,7 @@
 #include <linux/scatterlist.h>
 #include <linux/instrumented.h>
 #include <linux/iov_iter.h>
+#include <asm/mce.h>
 
 static __always_inline
 size_t copy_to_user_iter(void __user *iter_to, size_t progress,
@@ -253,14 +254,11 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
 #endif /* CONFIG_ARCH_HAS_COPY_MC */
 
-static size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
-				  size_t len, void *to, void *priv2)
+static __always_inline
+size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
+			   size_t len, void *to, void *priv2)
 {
-	struct iov_iter *iter = priv2;
-
-	if (iov_iter_is_copy_mc(iter))
-		return copy_mc_to_kernel(to + progress, iter_from, len);
-	return memcpy_from_iter(iter_from, progress, len, to, priv2);
+	return memcpy_mc(to + progress, iter_from, len);
 }
 
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)

