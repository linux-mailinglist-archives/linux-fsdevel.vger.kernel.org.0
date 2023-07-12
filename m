Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B78675126C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjGLVNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjGLVMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:12:35 -0400
Received: from out-30.mta1.migadu.com (out-30.mta1.migadu.com [IPv6:2001:41d0:203:375::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E362D54
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQIFhUqpaGDOWzE1yHnvTxX4EVy7v8panA3oqA36kSA=;
        b=DuRaDz8oKa7WhaBdL3TSBM/C20dZYJhltRM8sbfKp0t5CEqxOQnbhbTXHDch0TXpNWiWOT
        HlUoONNwjSA+t9fvp5k6w8fyp6pxL22ZBoYPwa/dEQbLxoOU4KkMCjUs8O3BOmo1pQ0O20
        sqWLZy4zHvQG/vEpVSvzhmTPJei8u+w=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 09/20] lib/string_helpers: string_get_size() now returns characters wrote
Date:   Wed, 12 Jul 2023 17:11:04 -0400
Message-Id: <20230712211115.2174650-10-kent.overstreet@linux.dev>
In-Reply-To: <20230712211115.2174650-1-kent.overstreet@linux.dev>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

printbuf now needs to know the number of characters that would have been
written if the buffer was too small, like snprintf(); this changes
string_get_size() to return the the return value of snprintf().

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/string_helpers.h |  4 ++--
 lib/string_helpers.c           | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index fae6beaaa2..44148f8feb 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -23,8 +23,8 @@ enum string_size_units {
 	STRING_UNITS_2,		/* use binary powers of 2^10 */
 };
 
-void string_get_size(u64 size, u64 blk_size, enum string_size_units units,
-		     char *buf, int len);
+int string_get_size(u64 size, u64 blk_size, enum string_size_units units,
+		    char *buf, int len);
 
 int parse_int_array_user(const char __user *from, size_t count, int **array);
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 230020a2e0..b9a34eb386 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -31,9 +31,11 @@
  * giving the size in the required units.  @buf should have room for
  * at least 9 bytes and will always be zero terminated.
  *
+ * Return value: number of characters of output that would have been written
+ * (which may be greater than len, if output was truncated).
  */
-void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
-		     char *buf, int len)
+int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
+		    char *buf, int len)
 {
 	static const char *const units_10[] = {
 		"B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
@@ -126,8 +128,8 @@ void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	else
 		unit = units_str[units][i];
 
-	snprintf(buf, len, "%u%s %s", (u32)size,
-		 tmp, unit);
+	return snprintf(buf, len, "%u%s %s", (u32)size,
+			tmp, unit);
 }
 EXPORT_SYMBOL(string_get_size);
 
-- 
2.40.1

