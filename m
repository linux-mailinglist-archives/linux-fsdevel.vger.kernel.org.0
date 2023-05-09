Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FD66FCC36
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjEIRA7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 13:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjEIRAE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 13:00:04 -0400
Received: from out-30.mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929906A67
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbLEE4jIbrZpJwXBO7eCGOTCJ14bvYB1GBwSVBBfWTo=;
        b=Ema++DByNMG9DiB+n947beAEq7g/Q71m9KoPfjHSpli1UraJyM8iCLpH2dVD7dGmlPZham
        POXN8Vj6rrwc/2I6l2HTF1fjTiqvONuKx/tIEtEaCgCG3vT3KEZtJaEGlgxgJ8gxdR7Ezw
        AkgHuGvv7tkdEsQ6O1IeMS4LPLXMVs0=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 29/32] lib/string_helpers: string_get_size() now returns characters wrote
Date:   Tue,  9 May 2023 12:56:54 -0400
Message-Id: <20230509165657.1735798-30-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

printbuf now needs to know the number of characters that would have been
written if the buffer was too small, like snprintf(); this changes
string_get_size() to return the the return value of snprintf().

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/string_helpers.h | 4 ++--
 lib/string_helpers.c           | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

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
index 230020a2e0..ca36ceba0e 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -32,8 +32,8 @@
  * at least 9 bytes and will always be zero terminated.
  *
  */
-void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
-		     char *buf, int len)
+int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
+		    char *buf, int len)
 {
 	static const char *const units_10[] = {
 		"B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
@@ -126,8 +126,8 @@ void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
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

