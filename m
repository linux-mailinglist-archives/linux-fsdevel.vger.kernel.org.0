Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17A1B17C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgDTU67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgDTU6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50642C061A0E;
        Mon, 20 Apr 2020 13:58:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so1192563wmh.0;
        Mon, 20 Apr 2020 13:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HzqPqoWK1aNcRwETf7TNa4PDAUr2rRyDa5sLUlM5fg=;
        b=Q6XalzeytgTUsS7Iy2MW/hsb3wdDHB0fSQPRCb7J/7t9YS+HiELNVUKWJPI+2DX4Id
         mMAyLO6f//ZHyFPUt4l/0gdX7JM7vC/MBCifJlhNQX2hnwEncA6nueaMNPENAeun6CRg
         /tGhWC4DoUk3jQSdMErkTqyU5LaQUPsJJG7shkJrGKvxzewrAqS6MByxKbdQwyrsGaSl
         r5wEo+fWXNImiP4bTXPkkkgIbk3zcHPFXH9VLdx8rnIMmKGbBa59VNcEm3tpYd4nx0EG
         q8kUjUu4YVH2LBMDPJgGTJ2rjC3aeqV2l43NIbz6XnIwZnqp+q88DNzqwQtd8c0lOToi
         L6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HzqPqoWK1aNcRwETf7TNa4PDAUr2rRyDa5sLUlM5fg=;
        b=WJVTParsk4SkenyA+o74Ran08BBgRQt7dUZSlGRud3EYKvdUZp3xZWgpHkyJvgHEXG
         ir12hVNmq5ttm4d34RWhmSXV0Fs1Nyi9P/jbMGSCHdEPUX2z23GPErikHh9Bt8S7Sd1i
         GIjl8imkHf6IPRqU2rxItx4vlmxqS+vrkksQlxsLOEKGwIimbHFpQ0o+ijK9I7A62na2
         /28QaOgSJvnyiKjD7WdJbfsdMHiFxq8mxAMKsZr/SGQ8rD4wnd13d4PySLiLUwrgJMd8
         d2yhxeMCoy8mNWB0zwfTyAlSNC4M9+BLK2+HvdKMbRCGYS1NGFDKVqxQcqF71O8qmHVb
         m5jg==
X-Gm-Message-State: AGi0PuZaidfYEoHMUNA3UABF3NB7iSsrhoPw2z+qzOjeZt3yFP2Tnasa
        igCM51+JO/lf1BK3NUcdng==
X-Google-Smtp-Source: APiQypL3GQfn0JoRoUkTzaECVwzycRyQkR3FNF7GR225Xg434Vgezy9OqoXRsas2ymT/Wnc/TaBuOg==
X-Received: by 2002:a1c:a7c2:: with SMTP id q185mr1323029wme.42.1587416293086;
        Mon, 20 Apr 2020 13:58:13 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:12 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 06/15] print_integer, proc: rewrite /proc/loadavg via print_integer()
Date:   Mon, 20 Apr 2020 23:57:34 +0300
Message-Id: <20200420205743.19964-6-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/loadavg.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/proc/loadavg.c b/fs/proc/loadavg.c
index f32878d9a39f..4540a894db22 100644
--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -9,19 +9,33 @@
 #include <linux/seq_file.h>
 #include <linux/seqlock.h>
 #include <linux/time.h>
+#include "../../lib/print-integer.h"
 
 static int loadavg_proc_show(struct seq_file *m, void *v)
 {
 	unsigned long avnrun[3];
+	char buf[3 * (LEN_UL + 1 + 2 + 1) + 10 + 1 + 10 + 1 + 10 + 1];
+	char *p = buf + sizeof(buf);
+	int i;
+
+	*--p = '\n';
+	p = _print_integer_u32(p, idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
+	*--p = ' ';
+	p = _print_integer_u32(p, nr_threads);
+	*--p = '/';
+	p = _print_integer_u32(p, nr_running());
 
 	get_avenrun(avnrun, FIXED_1/200, 0);
+	for (i = 2; i >= 0; i--) {
+		*--p = ' ';
+		--p;		/* overwritten */
+		*--p = '0';	/* conditionally overwritten */
+		(void)_print_integer_u32(p + 2, LOAD_FRAC(avnrun[i]));
+		*--p = '.';
+		p = _print_integer_ul(p, LOAD_INT(avnrun[i]));
+	}
 
-	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %u/%d %d\n",
-		LOAD_INT(avnrun[0]), LOAD_FRAC(avnrun[0]),
-		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
-		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
-		nr_running(), nr_threads,
-		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
+	seq_write(m, p, buf + sizeof(buf) - p);
 	return 0;
 }
 
-- 
2.24.1

