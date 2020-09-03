Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F346425C27B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgICO0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbgICOYg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:24:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0466C06123F;
        Thu,  3 Sep 2020 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=glRx1e+2K28c137CnQcnREE32Krzi32mzQeiUOb4p8k=; b=aXm8ada5czGlZeEedfKGmsycdu
        XFy77fTL6a7UVpeZ5XjCNDyNL1ym6/11MKlvDcgii10R7629AQHAVCkS1pGwSTGRKAJaWkw9LRvVF
        3JSzd4hQb6IDMc6kLI8zVGFbH+Lmkx9TwN07Xr/fV64EzjAO4ABTibJ83Uw29e0dbrGs2LbZedqvb
        E8L6It2nFiIxyBiDcKt9cU59Qp6Q8YAEQmxWAQW02CvAeC7oFJnRoWJDoze120xNiGkiCqg84AoPh
        qpjFDVcO28oUIXPgpopWgoQ9ldSmsPzP3JAuBajxqnl6TjEfHRBKOYSm8K16fkeoOmXevyEP4yp7W
        IG/giTfg==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDq8c-0004bL-6R; Thu, 03 Sep 2020 14:22:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/14] test_bitmap: remove user bitmap tests
Date:   Thu,  3 Sep 2020 16:22:36 +0200
Message-Id: <20200903142242.925828-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903142242.925828-1-hch@lst.de>
References: <20200903142242.925828-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can't run the tests for userspace bitmap parsing if set_fs() doesn't
exist, and it is about to go away for x86, powerpc with other major
architectures to follow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/test_bitmap.c | 91 +++++++++++------------------------------------
 1 file changed, 21 insertions(+), 70 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index df903c53952bb9..4425a1dd4ef1c7 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -354,50 +354,37 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 
 };
 
-static void __init __test_bitmap_parselist(int is_user)
+static void __init test_bitmap_parselist(void)
 {
 	int i;
 	int err;
 	ktime_t time;
 	DECLARE_BITMAP(bmap, 2048);
-	char *mode = is_user ? "_user"  : "";
 
 	for (i = 0; i < ARRAY_SIZE(parselist_tests); i++) {
 #define ptest parselist_tests[i]
 
-		if (is_user) {
-			mm_segment_t orig_fs = get_fs();
-			size_t len = strlen(ptest.in);
-
-			set_fs(KERNEL_DS);
-			time = ktime_get();
-			err = bitmap_parselist_user((__force const char __user *)ptest.in, len,
-						    bmap, ptest.nbits);
-			time = ktime_get() - time;
-			set_fs(orig_fs);
-		} else {
-			time = ktime_get();
-			err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
-			time = ktime_get() - time;
-		}
+		time = ktime_get();
+		err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
+		time = ktime_get() - time;
 
 		if (err != ptest.errno) {
-			pr_err("parselist%s: %d: input is %s, errno is %d, expected %d\n",
-					mode, i, ptest.in, err, ptest.errno);
+			pr_err("parselist: %d: input is %s, errno is %d, expected %d\n",
+					i, ptest.in, err, ptest.errno);
 			continue;
 		}
 
 		if (!err && ptest.expected
 			 && !__bitmap_equal(bmap, ptest.expected, ptest.nbits)) {
-			pr_err("parselist%s: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
-					mode, i, ptest.in, bmap[0],
+			pr_err("parselist: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
+					i, ptest.in, bmap[0],
 					*ptest.expected);
 			continue;
 		}
 
 		if (ptest.flags & PARSE_TIME)
-			pr_err("parselist%s: %d: input is '%s' OK, Time: %llu\n",
-					mode, i, ptest.in, time);
+			pr_err("parselist: %d: input is '%s' OK, Time: %llu\n",
+					i, ptest.in, time);
 
 #undef ptest
 	}
@@ -443,75 +430,41 @@ static const struct test_bitmap_parselist parse_tests[] __initconst = {
 #undef step
 };
 
-static void __init __test_bitmap_parse(int is_user)
+static void __init test_bitmap_parse(void)
 {
 	int i;
 	int err;
 	ktime_t time;
 	DECLARE_BITMAP(bmap, 2048);
-	char *mode = is_user ? "_user"  : "";
 
 	for (i = 0; i < ARRAY_SIZE(parse_tests); i++) {
 		struct test_bitmap_parselist test = parse_tests[i];
+		size_t len = test.flags & NO_LEN ? UINT_MAX : strlen(test.in);
 
-		if (is_user) {
-			size_t len = strlen(test.in);
-			mm_segment_t orig_fs = get_fs();
-
-			set_fs(KERNEL_DS);
-			time = ktime_get();
-			err = bitmap_parse_user((__force const char __user *)test.in, len,
-						bmap, test.nbits);
-			time = ktime_get() - time;
-			set_fs(orig_fs);
-		} else {
-			size_t len = test.flags & NO_LEN ?
-				UINT_MAX : strlen(test.in);
-			time = ktime_get();
-			err = bitmap_parse(test.in, len, bmap, test.nbits);
-			time = ktime_get() - time;
-		}
+		time = ktime_get();
+		err = bitmap_parse(test.in, len, bmap, test.nbits);
+		time = ktime_get() - time;
 
 		if (err != test.errno) {
-			pr_err("parse%s: %d: input is %s, errno is %d, expected %d\n",
-					mode, i, test.in, err, test.errno);
+			pr_err("parse: %d: input is %s, errno is %d, expected %d\n",
+					i, test.in, err, test.errno);
 			continue;
 		}
 
 		if (!err && test.expected
 			 && !__bitmap_equal(bmap, test.expected, test.nbits)) {
-			pr_err("parse%s: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
-					mode, i, test.in, bmap[0],
+			pr_err("parse: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
+					i, test.in, bmap[0],
 					*test.expected);
 			continue;
 		}
 
 		if (test.flags & PARSE_TIME)
-			pr_err("parse%s: %d: input is '%s' OK, Time: %llu\n",
-					mode, i, test.in, time);
+			pr_err("parse: %d: input is '%s' OK, Time: %llu\n",
+					i, test.in, time);
 	}
 }
 
-static void __init test_bitmap_parselist(void)
-{
-	__test_bitmap_parselist(0);
-}
-
-static void __init test_bitmap_parselist_user(void)
-{
-	__test_bitmap_parselist(1);
-}
-
-static void __init test_bitmap_parse(void)
-{
-	__test_bitmap_parse(0);
-}
-
-static void __init test_bitmap_parse_user(void)
-{
-	__test_bitmap_parse(1);
-}
-
 #define EXP1_IN_BITS	(sizeof(exp1) * 8)
 
 static void __init test_bitmap_arr32(void)
@@ -675,9 +628,7 @@ static void __init selftest(void)
 	test_replace();
 	test_bitmap_arr32();
 	test_bitmap_parse();
-	test_bitmap_parse_user();
 	test_bitmap_parselist();
-	test_bitmap_parselist_user();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
 	test_bitmap_cut();
-- 
2.28.0

