Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2BD25448D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 13:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgH0LvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgH0LuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:50:11 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD593C06123A
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:48 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id l7so2481268ejr.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nVHuYaY9UtfQ5ceDG+IOgNARKDklUVVN28+71pW1fmk=;
        b=EKUYAShSuw6vIw45vevo+Sy7e72QAp73T544NA5kbUcsd1iV/LN/8R2GxzPOpqGvdX
         pdndWsVd6Lr3QZFGe4mTnAYNnlEb32APpoNqKM8a2Y00vZHJs04X7m3Rg2VxyGHiu8WB
         8/ObYeSz7+0b4daA5rCvUagkfihi0oU2h2O/4pWpaAnFNKDROaYdPONQnUqQY9kfrvGP
         uKFQPWrcbMbQHbVYb3WZx3sPPDGERlRi8cAKR52YtrWMhsNQhVHjm12Y5jeYEQeQQlti
         ugA2ZkmaIpOOKUnnVGqvAI0YlxcaE3BBSdIcXjisRZIOt2eBY+4cKnwSl5+8CX5Ld5vK
         EnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nVHuYaY9UtfQ5ceDG+IOgNARKDklUVVN28+71pW1fmk=;
        b=E2a28DvwseWCCKTCmU4D91rZtQtYaPkcTKsK+RrfHVI8Yv5zHmlBdBn7O/Dsa+Is4H
         hOxoxR8LZ8xnFEcF7RJ8F5vgvra+KtMNlxjAMO8N9n5lWpOLddGy0rPK6Xb/sWKlu+Ou
         eaWS36R4y5qSajG4hp01g62V2PXFnwhZfJ6gWt5NwhGmdVfmWB2WbhdL+x049Nn14Hn9
         Ik4d1RsvHFOfow8Xj52i1wuot0z+vFRRqd4QRQ34cSA+GUtCX7IDq4IZNTf+M0Knpl6F
         fQXAaxdSIgyNvCGQ+x84swW649KFE6oUfRGqnSmgxDTtPnMF+Lbj/GKmRXyGBCudCftJ
         5U2A==
X-Gm-Message-State: AOAM530o6H1c+cHk6A4ERGsT8dEiOvMUutpKR5mB52asD/DO8oJIowui
        ggKbrydYgEzbI/MgZEFC/0CuL1LOLg==
X-Google-Smtp-Source: ABdhPJy2EioBHl5DQHnC+VEIiLoSJ394iMXy3ZaLk8kxlGOGKXykgo5D+wC/Tp3lDGd7qD4rKXOJxasNpA==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a17:906:dc03:: with SMTP id
 yy3mr21385084ejb.380.1598528987410; Thu, 27 Aug 2020 04:49:47 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:49:27 +0200
In-Reply-To: <20200827114932.3572699-1-jannh@google.com>
Message-Id: <20200827114932.3572699-3-jannh@google.com>
Mime-Version: 1.0
References: <20200827114932.3572699-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v5 2/7] coredump: Let dump_emit() bail out on short writes
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dump_emit() has a retry loop, but there seems to be no way for that retry
logic to actually be used; and it was also buggy, writing the same data
repeatedly after a short write.

Let's just bail out on a short write.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/coredump.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 76e7c10edfc0..5e24c06092c9 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -840,17 +840,17 @@ int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 	ssize_t n;
 	if (cprm->written + nr > cprm->limit)
 		return 0;
-	while (nr) {
-		if (dump_interrupted())
-			return 0;
-		n = __kernel_write(file, addr, nr, &pos);
-		if (n <= 0)
-			return 0;
-		file->f_pos = pos;
-		cprm->written += n;
-		cprm->pos += n;
-		nr -= n;
-	}
+
+
+	if (dump_interrupted())
+		return 0;
+	n = __kernel_write(file, addr, nr, &pos);
+	if (n != nr)
+		return 0;
+	file->f_pos = pos;
+	cprm->written += n;
+	cprm->pos += n;
+
 	return 1;
 }
 EXPORT_SYMBOL(dump_emit);
-- 
2.28.0.297.g1956fa8f8d-goog

