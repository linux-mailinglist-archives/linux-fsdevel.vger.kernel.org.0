Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DE41B17BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgDTU62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgDTU6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3221FC061A0E;
        Mon, 20 Apr 2020 13:58:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so1187414wmg.1;
        Mon, 20 Apr 2020 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vl4tTLTk9UzEHwczyqndkW8Hy/oXFce/6TR/A0PiuF4=;
        b=uAMNO8wa/vAEF4ZVjZdpXBkhZDFn9QKAMx2LUv2fA8kvxdSCYFl07NOFqL8iMBGfL4
         7SrXwMk419+mP0Jzts4yJXh10cBw+mkJ1O8S3upmOyzPC2yxm0JDQ2ooHZLmW8zZWmfa
         022lsBAFBu1dDA4vruYIyYchbX0wfzu+3j/axPn7/Lxj6LKrMecV+7C6fqEtsqh/94hJ
         AOdT/Q8VftcVGgje6hiusM/qNhPsd3Y/ZLnTkID43ty1Gbqt/a8jKufMuGYOgX7CzaS3
         y5cZD5sQts261Q+KkzNMf5yWSsWKC0iTa07GJ2VkTCcJTj4G/xMbAQXdswOZW1FD7T0T
         v21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vl4tTLTk9UzEHwczyqndkW8Hy/oXFce/6TR/A0PiuF4=;
        b=qjpHyf2/U345WhjClQ2pDJgAoSCDKv3YHHaSS50v6Ca0p/ijg80l3dp7SxFgqrLamh
         6UO/s1ZXizvS9UhPwWvnWHK784fLPhZBbMgLHjpcI4hjscAWyni8MO25rAOPhRc0fjKL
         8gIRWqv0klYQGlAiD7h+IgIXyEGaIbIMixrjhIfKxt5wi4UmK4H5wEq7/SNKQFUGFDqx
         TutruFXxcIbD/5aJCroYc2UoX7wEUVtDO3+4c3EqI62Hf8PRfI8Xz7cxD2HV9wFWMFIe
         vyR7ckE7BrIYnK+4vIs0zt0sne/5NJOr6cby8KyLuIDemf22Ca0bxp75NA/H42MhoYnN
         9iFA==
X-Gm-Message-State: AGi0PuYuGGrVF3TYUaIrX5Fer4Z1QvvvUATwoJ8B0fFkS8/X8UNghNGz
        YwufvUxUUUEhImUomVMXmA==
X-Google-Smtp-Source: APiQypLQr5bU/OZo0OwQ93dqoO28iE0APXX2JVZOK7BFZJSXXhalfClJhIT3pP3ZBrj0v/WKPEN+ZQ==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr1292378wmb.155.1587416302013;
        Mon, 20 Apr 2020 13:58:22 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:21 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 15/15] print_integer, proc: rewrite /proc/meminfo via print_integer()
Date:   Mon, 20 Apr 2020 23:57:43 +0300
Message-Id: <20200420205743.19964-15-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This actually makes /proc/meminfo slower, I need to check what's
going on.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/meminfo.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 8c1f1bb1a5ce..6dff2298cc3f 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -24,12 +24,24 @@ void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
 {
 }
 
-static void show_val_kb(struct seq_file *m, const char *s, unsigned long num)
+static void _show_val_kb(struct seq_file *m, const char *s, size_t len,
+			 unsigned long num)
 {
-	seq_put_decimal_ull_width(m, s, num << (PAGE_SHIFT - 10), 8);
-	seq_write(m, " kB\n", 4);
+	char buf[64];
+	char *p = buf + sizeof(buf);
+	char *tmp;
+
+	p = memcpy(p - 4, " kB\n", 4);
+	tmp = memcpy(p - 8, "        ", 8);
+	p = _print_integer_ul(p, num << (PAGE_SHIFT - 10));
+	p = min(p, tmp);
+	p = memcpy(p - len, s, len);
+
+	seq_write(m, p, buf + sizeof(buf) - p);
 }
 
+#define show_val_kb(m, s, n) _show_val_kb((m), (s), strlen(s), (n))
+
 static int meminfo_proc_show(struct seq_file *m, void *v)
 {
 	struct sysinfo i;
-- 
2.24.1

