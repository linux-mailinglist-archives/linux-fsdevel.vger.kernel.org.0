Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AE81B17C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgDTU6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgDTU6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F83C061A0C;
        Mon, 20 Apr 2020 13:58:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r26so1192970wmh.0;
        Mon, 20 Apr 2020 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CEMq9p3y53YSLRVr6wlGedagkBpUr96QW3htu5fn8M=;
        b=ulZuFGYbZXWjjqMRKVh4G+DDgM8jrPd5lgC6lLQ7x3eNkKNQt3ZJ/Iu6BPH8ckFMVr
         emmEcdw/62JMEmpP4hAZmTISbZKbVASjZTp8Y8p8FWs+0ZqCDfHt0T8s2AGCwVXSbRsL
         LTdNk9Pio9cToWJI9SvZRMq+Lsb1L5ARq9qrc94ImCbq/QVvBRLfys8+o7vi0khsSzhY
         +ONPwmhnhHq3HxKJrcphuZc6rVei0zTeL4Pyi9k3jR7iSNtaUhp46uxEcp5IUyj5Z2I0
         7WNb8GL+U9gLPq8VYo/Evi11Pi/mif6iDOf9uPT0aZOu8JTr+ryHJsYqxwn9mPpTetkA
         t/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CEMq9p3y53YSLRVr6wlGedagkBpUr96QW3htu5fn8M=;
        b=Ed9IQZSkmckbnrltp5PMSZYlFd5g0bIjbWMvRA+S0Q0KaxL67w5ARDKB1u03oy0n0U
         En3RqKE+nG/EqQdqd+rbLAc1+/P090sq8KPVRtOixGXqGPQf/pq5eQV8ht+Dqd+lUmY9
         2wbOlhJGHsKO+sn9EJYh2uvkgcmZFdfT1riq/dVCVLwjBHGIXZD3mkiPLCI4qKP7FANe
         jX0d+L5y1v09CMaZkHEJ8W17WzxIZyaYWcstN1x/bn3gQnGHym1gdRwqPZr4Yh/Ceiyl
         CGN6F1kAhikjVwcifsHWD+FAgCxWpEw3DIfb/5yRqs3PljF0FdpTTHigRzLCZMnnTrxI
         /tIg==
X-Gm-Message-State: AGi0PuZxSjrOOv27z6ln69D/00CfrWx/FfzOOzrkB7I8WjIwXu22pa87
        uFNYd7WhOvSiQjseP3h/WA==
X-Google-Smtp-Source: APiQypKXrGH1q/hccGZ4dOO6jGl50did0fsnoStDobiZ8ykrGUvRJGDFPKznv34CYl+tcim6mTBu5w==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr1243151wmc.123.1587416300040;
        Mon, 20 Apr 2020 13:58:20 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:19 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 13/15] print_integer, printf: rewrite num_to_str() via print_integer()
Date:   Mon, 20 Apr 2020 23:57:41 +0300
Message-Id: <20200420205743.19964-13-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In my opinion, num_to_str() is more understandable this way.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 lib/vsprintf.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7c488a1ce318..df2b5ce08fe9 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -51,6 +51,7 @@
 
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
+#include "print-integer.h"
 
 /**
  * simple_strtoull - convert a string to an unsigned long long
@@ -343,33 +344,24 @@ char *put_dec(char *buf, unsigned long long n)
  */
 int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
 {
-	/* put_dec requires 2-byte alignment of the buffer. */
-	char tmp[sizeof(num) * 3] __aligned(2);
-	int idx, len;
+	char tmp[20];
+	char *p = tmp + sizeof(tmp);
+	ptrdiff_t len;
 
-	/* put_dec() may work incorrectly for num = 0 (generate "", not "0") */
-	if (num <= 9) {
-		tmp[0] = '0' + num;
-		len = 1;
-	} else {
-		len = put_dec(tmp, num) - tmp;
-	}
+	p = _print_integer_u64(p, num);
+	len = tmp + sizeof(tmp) - p;
 
 	if (len > size || width > size)
 		return 0;
 
 	if (width > len) {
-		width = width - len;
-		for (idx = 0; idx < width; idx++)
-			buf[idx] = ' ';
+		memset(buf, ' ', width - len);
+		memcpy(buf + width - len, p, len);
+		return width;
 	} else {
-		width = 0;
+		memcpy(buf, p, len);
+		return len;
 	}
-
-	for (idx = 0; idx < len; ++idx)
-		buf[idx + width] = tmp[len - idx - 1];
-
-	return len + width;
 }
 
 #define SIGN	1		/* unsigned/signed, must be 1 */
-- 
2.24.1

