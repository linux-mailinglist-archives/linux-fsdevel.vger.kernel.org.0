Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87015245E09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 09:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHQHdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 03:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgHQHc1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:32:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44C4C061388;
        Mon, 17 Aug 2020 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=chkBUohlSENVG7jzFIol9qd0YuUufR27opLGYVm+1Ug=; b=nPKsqCwnley2pS/jGgzaWIWqdq
        +H7a88VNXjG35LPNiZ70Kq+7+6Gu3tLxQga7o8tF/RFW8obhq2FJOJAyEb27ONJcpWauRW+6jPNZZ
        s2p1syRBxG+7Zznv0MvH0KZCg4uUaXzvWNUzIrxQoH1qGhjKwe9+K8EoC8VMyfYHj2C+Rf7YmyUjB
        9cvFklBwOIFdee9QbYzjUx4FgKXyy5tI5cDIjL76f4STmRLqqZmkTKqKHi9k8VQ9XdmqFdtmBpO/1
        gEuSuTWhDc+hCkkOLVFdlq+dEoEZbvtg6iVS1PKVj0Gp7LURgpjFVXy1eb9fYkzUOMLCF0hqjeRd+
        mz7yZVjw==;
Received: from [2001:4bb8:188:3918:4550:cdf7:3d45:afb9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7Zd0-0000vz-Gj; Mon, 17 Aug 2020 07:32:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/11] test_bitmap: skip user bitmap tests for !CONFIG_SET_FS
Date:   Mon, 17 Aug 2020 09:32:06 +0200
Message-Id: <20200817073212.830069-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817073212.830069-1-hch@lst.de>
References: <20200817073212.830069-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can't run the tests for userspace bitmap parsing if set_fs() doesn't
exist.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/test_bitmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index df903c53952bb9..49b1d25fbaf546 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -365,6 +365,7 @@ static void __init __test_bitmap_parselist(int is_user)
 	for (i = 0; i < ARRAY_SIZE(parselist_tests); i++) {
 #define ptest parselist_tests[i]
 
+#ifdef CONFIG_SET_FS
 		if (is_user) {
 			mm_segment_t orig_fs = get_fs();
 			size_t len = strlen(ptest.in);
@@ -375,7 +376,9 @@ static void __init __test_bitmap_parselist(int is_user)
 						    bmap, ptest.nbits);
 			time = ktime_get() - time;
 			set_fs(orig_fs);
-		} else {
+		} else
+#endif /* CONFIG_SET_FS */
+		{
 			time = ktime_get();
 			err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
 			time = ktime_get() - time;
@@ -454,6 +457,7 @@ static void __init __test_bitmap_parse(int is_user)
 	for (i = 0; i < ARRAY_SIZE(parse_tests); i++) {
 		struct test_bitmap_parselist test = parse_tests[i];
 
+#ifdef CONFIG_SET_FS
 		if (is_user) {
 			size_t len = strlen(test.in);
 			mm_segment_t orig_fs = get_fs();
@@ -464,7 +468,9 @@ static void __init __test_bitmap_parse(int is_user)
 						bmap, test.nbits);
 			time = ktime_get() - time;
 			set_fs(orig_fs);
-		} else {
+		} else
+#endif /* CONFIG_SET_FS */
+		{
 			size_t len = test.flags & NO_LEN ?
 				UINT_MAX : strlen(test.in);
 			time = ktime_get();
-- 
2.28.0

