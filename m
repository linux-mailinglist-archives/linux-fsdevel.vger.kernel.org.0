Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E1244046
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 23:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHMVEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 17:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgHMVEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:04:25 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3769C061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:24 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id l13so3320567qvt.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ycCIVy361UoLo0c5/AED/UxCAcejG5GKn68oBgGv2HA=;
        b=QijV9x4iaFVr4ppulFFUZv+PUc7jxU/O9GHaA9x761i20qidkkD1kGUq1KbcByoiYW
         ycJmmOdd1tlK9SukOuH1QBjIjTLnvROd4EwwbVlug8Kvwcpy5SeqwkRhFKzHJczfRgcI
         t/mLY1zYoTFj49exE5rWg+hdcxtMLY5vhqudWg5IbYWwSkZ4PrhzpN5PhrbpC8isfxps
         46Zej12Yz58j6T9YOd3483AnmjrhXYPHqsZckD5zuSRQtAIREWXt4eWmJ38C7GC0kIuj
         Bw1tch82CvP93lh9h5nEI9r1fHNWUrheMHmthfiCXSMHEE7fOUys2lrU1xVElVsYrNw+
         tChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ycCIVy361UoLo0c5/AED/UxCAcejG5GKn68oBgGv2HA=;
        b=qWnmEC+KsYDSW79ibbNgfA7ULbkG011MfTzXlxwNJkxhSOh+8A7TjIa4/iNIpQmqXe
         GS7q2Y8OVA6CpVgljvrUwWl/Nc90yz040vdzW8IMo0ApwhRIEHj4xiVGurrbxnp4A+xf
         /jYeOVipfj6TJn8cs/3kpAj3BMGxiERKpQzdtZBpJkw9kc2chyzbEEHB45EwUhzdYuMq
         jnn6Xel7nMGq7mjvK4VO9molJnL7LGO1QVxCAtXINet5d993/BZWdOa5k1IERBL7PIc7
         fUU/2I64YR8pNtMW9a/7yhjzdUEQ+avJte7qvcW0bpNjxaKEgvLSAKa7wcNvuCUsWJ1I
         RXkg==
X-Gm-Message-State: AOAM530L+PteW0USb1ewnBNDc4BqNh7BCFUzfXrogWkYAAm8xsJyyGch
        7+vbRXtT5kfTOR9w6wZ5ItBpDg==
X-Google-Smtp-Source: ABdhPJy7Ev0oEAzZFQ91/Fm3qWfS688wZCmbhl8ge0Fwp1eNf3XvcIMjaZ7llS65arZ8Ck4HavVc8Q==
X-Received: by 2002:ad4:54d4:: with SMTP id j20mr6510667qvx.6.1597352664041;
        Thu, 13 Aug 2020 14:04:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q7sm6663428qkf.35.2020.08.13.14.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:04:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: [PATCH 4/6] sysctl: make proc_put_long() use scnprintf
Date:   Thu, 13 Aug 2020 17:04:09 -0400
Message-Id: <20200813210411.905010-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813210411.905010-1-josef@toxicpanda.com>
References: <20200813210411.905010-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we're passing down a kernel buffer with enough space to account
for an extra NULL terminator, go ahead and use scnprintf() to print out
a long in proc_put_long().  count here includes NULL terminator slot in
the buffer, so we will get the correct behavior we're looking for.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sysctl.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 287862f91717..d8cc8737f58f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -484,6 +484,7 @@ static int proc_get_long(char **buf, size_t *size,
 
 	return 0;
 }
+#undef TMPBUFLEN
 
 /**
  * proc_put_long - converts an integer to a decimal ASCII formatted string
@@ -498,18 +499,12 @@ static int proc_get_long(char **buf, size_t *size,
  */
 static void proc_put_long(void **buf, size_t *size, unsigned long val, bool neg)
 {
-	int len;
-	char tmp[TMPBUFLEN], *p = tmp;
+	size_t ret;
 
-	sprintf(p, "%s%lu", neg ? "-" : "", val);
-	len = strlen(tmp);
-	if (len > *size)
-		len = *size;
-	memcpy(*buf, tmp, len);
-	*size -= len;
-	*buf += len;
+	ret = scnprintf(*buf, *size, "%s%lu", neg ? "-" : "", val);
+	*size -= ret;
+	*buf += ret;
 }
-#undef TMPBUFLEN
 
 static void proc_put_char(void **buf, size_t *size, char c)
 {
-- 
2.24.1

