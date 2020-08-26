Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53399253348
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 17:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHZPPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgHZPPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:15:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9E5C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l67so3193782ybb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nVHuYaY9UtfQ5ceDG+IOgNARKDklUVVN28+71pW1fmk=;
        b=kI/DmR2cv1d9OJFdhnImUqHSGWV1ZqxdGqYUbrFMzIZoLjyBZUGrKg8nscJM4NLWSq
         aoE+SNTNoDERTGQQ81Jv2cVwHVUyQF4rCSPCBrfHjuNwC0mrKkXcOif6H4GqJ3ObCD1W
         ehHwAGA7xggv+ecKbvq/e9V08q0y/RhTUILd/sit7XJxc7N/40Scp5dgnxPvQs6qrvIc
         79svxj8OV2XyIQ/z/HVb3yBer3F95VUgY2wiLnnZkGmA8ejGcBjzRg0W57SvZTtUh/lg
         tHZ2FutPYjZ60wnBdq/W3QSQ7XEECKopv3MAPfeOlE+Y2386UV58ZZUOqTacbwL3yjIs
         jL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nVHuYaY9UtfQ5ceDG+IOgNARKDklUVVN28+71pW1fmk=;
        b=leMDKqv9ozUEEKcwVQseXitwXHPyeqkqZ0MbzQA3KLmaA1IEJ6ROiJ3K8PDPjUsHr7
         7kUrG0V8fwCcoWZUqFcRgAV5263Z1lCzfACkTbZKpRzH6EP79TMkVWLSLO5DSpksrxMw
         erH1NFQEFhabt9wkow+vK9UyTdSbylnU5QLbwDoFUt+iTNXaOGWzbAWEgsmp2nubDets
         Eo8VYqSgRxz35ad6+LY4JZaEUwu3uAnpHCFyEjzgFgZh49SLh33cA6Wqv76yhDDEJKru
         FYD/zNuHxukQaKJ0+UaLO2akjXnAPoi3z3hZ1WXuN/LIz6sx6FqZn0XbWbJF9FOqsGFD
         nyEw==
X-Gm-Message-State: AOAM533NNo+zmM8ugkqHJCMiJ2WLo85ZjMMJ2tSUE4iKAkHxEF/TWcdp
        Iuc7o9Zcg32kDxp/cKcBi8Id1b1rGw==
X-Google-Smtp-Source: ABdhPJw/rcqGxzh/fmBX9LEz09Jq8CAXmzs2q38x7tBY1D1+LTR0sUBBqdFxw+NulLkgSDFNyvsboxvOcQ==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a25:3cc3:: with SMTP id j186mr21293924yba.208.1598454941009;
 Wed, 26 Aug 2020 08:15:41 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:14:45 +0200
In-Reply-To: <20200826151448.3404695-1-jannh@google.com>
Message-Id: <20200826151448.3404695-3-jannh@google.com>
Mime-Version: 1.0
References: <20200826151448.3404695-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v4 2/5] coredump: Let dump_emit() bail out on short writes
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

