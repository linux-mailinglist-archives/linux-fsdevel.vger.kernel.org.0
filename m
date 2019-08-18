Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02C791827
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfHRRAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 13:00:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42371 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfHRRAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 13:00:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so5713516pfk.9;
        Sun, 18 Aug 2019 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B53kfNAL5bPehU6SpckbeuA1BwDTxczPn/Y5JPnbD6I=;
        b=hkv+ERgF20ssKIwymu3URWuHg3UvErhauZ06k/0G2LrqPxFB090vLrMGy/+WZBO2ho
         XSt+Q68y7GmJkE7msre2w2OU38bqK87Adp9b3L+OFdr/MALR1I6O7SHMof+oACZUAvaN
         6KLPI5KKnDKlR1hJ/DOl7FVx8rk+mSUZ9j/wqitb/xx6Z6iXq3fAkgqdz+sFI+tZV8Jy
         4G+KvomuB1vGD8b7FNR4afRSFrCSusWeLb+v6N9a+kbdEfFSF0ufKluXKnIjAx1C6qkD
         B/m3Cl5aZYTnrovlybeFZE5I4QynuGte/X6KW6yDlrYdlAuD5TDLayR1P7Iv+yoTE9p3
         8XpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B53kfNAL5bPehU6SpckbeuA1BwDTxczPn/Y5JPnbD6I=;
        b=amVAWmxMgrUqbqbo2TmI6nrdd8sYOh+Hopwn09tK9EhG0Bx39PqbLoKV43GbfQOcwQ
         GvfqMM7CDALZJJfK3zGN1eg+q7BULJOBlJmIYU6mvXWhrfau9aETiHOj1ENC8jCYRNjI
         iwaT7sW/pBXeP4g/ua4LY3uqqHlGAzOvHCQCA6Ycjk3s30ShFsbSsjNigQI60tVNO8T2
         lNuRjPQB1HW2RE/oXhx9CBTZfVjtFiVgS0wso19/p+6+PBYEGrOSZsGdRelvQ6sLnTC7
         yS3rxI72CvOZhVGIV7/+reHUdiPYK4piQ0PIo1i26wSaHc2fdugtx3FQHVAijehCGRzi
         tNSA==
X-Gm-Message-State: APjAAAVXpMD3dNfMPc4l0Huiwql8YZ2M6npZUxc+5SUp36KTsgn2igVJ
        cInI87yrawgvKUFZp+m/0fM=
X-Google-Smtp-Source: APXvYqwCKGjBW16GSAq1uDKuynJzJTBXWLl/QOCsZVV2XmdwJpydRmod7Xpj2D3WUvxWBkEwnteQZA==
X-Received: by 2002:aa7:8498:: with SMTP id u24mr20671125pfn.61.1566147607698;
        Sun, 18 Aug 2019 10:00:07 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.10.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 10:00:07 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de
Subject: [PATCH v8 20/20] isofs: Initialize filesystem timestamp ranges
Date:   Sun, 18 Aug 2019 09:58:17 -0700
Message-Id: <20190818165817.32634-21-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

Reference: http://www.ecma-international.org/publications/standards/Ecma-119.htm

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/isofs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 9e30d8703735..62c0462dc89f 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -30,6 +30,9 @@
 #include "isofs.h"
 #include "zisofs.h"
 
+/* max tz offset is 13 hours */
+#define MAX_TZ_OFFSET (52*15*60)
+
 #define BEQUIET
 
 static int isofs_hashi(const struct dentry *parent, struct qstr *qstr);
@@ -801,6 +804,10 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 	 */
 	s->s_maxbytes = 0x80000000000LL;
 
+	/* ECMA-119 timestamp from 1900/1/1 with tz offset */
+	s->s_time_min = mktime64(1900, 1, 1, 0, 0, 0) - MAX_TZ_OFFSET;
+	s->s_time_max = mktime64(U8_MAX+1900, 12, 31, 23, 59, 59) + MAX_TZ_OFFSET;
+
 	/* Set this for reference. Its not currently used except on write
 	   which we don't have .. */
 
-- 
2.17.1

