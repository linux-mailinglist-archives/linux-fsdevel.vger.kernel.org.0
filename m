Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D72C247E4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 08:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHRGM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 02:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgHRGMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:12:55 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4CDC061389
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 23:12:55 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id l24so7367885edv.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 23:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GSVoeZY4VtJncRCsBDOJV6iGFCXNH029JG2AgbxMzIw=;
        b=mJkEz75fkVHT8du8gdQBjaw6pE2ldFlA4jAPMSL2QbrZWXnfCVbN0C+c08ERHBXu6g
         C2fnjAZnH5RpJUIy5bISJjpd5WjqtYLOVKzqSpZEUfB9oMJdSN28QzPbF9Nlo8946/Fj
         oMh5GZo83yuAfd3Li5R2BToVuUri/UWMuEmqmPuoHlnAFltI6gltdTVRb4pk9SMR8r3s
         VxGDiC/Qdhttg9SXgox69qIlULfK8Md8HEGzpeXVfTvQr/JMHA9T5dT2KQ+7AwF2YMXd
         KtyAFJ/QUHW796NNlto8dQliaZ6uR4Jj68ysPjJBEx1Nd/tzEky2FMVHrzXQJZ+L4CxF
         tGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GSVoeZY4VtJncRCsBDOJV6iGFCXNH029JG2AgbxMzIw=;
        b=TrNrvU3p9/v2FXe10clPyqhw9zCG/l2Rj3txix8UN1haoWri8rlDZfASuWazik25Wy
         engCEeKakwGHHdRqy/NNIntKfSShv9KwjHWnwAqrriI2DITYAJu3q7hCFovZHq6J25Ts
         SDCwiS7sHt0H/WkkTftTEvIGWJCK0Mc/Sl/JvImQP7oPaGmbHI09WpyYso6OhdlFqMgD
         L7+BJRO+n4xkA5CXVGFJHOMHd+bptiSia48Yl/djBcBQEQkUdr6Gc/7dEfm2t4hRfXt3
         UF0DACftR1D/7w4JUUjR7D8ePYdDRcv8bDCb6tWoFM4A02sqLY9/Xlvs//qKjQ4S3YFJ
         fNCA==
X-Gm-Message-State: AOAM530LqIgKtMxrxNCAb3XDIPu6puNTsR3qL+F1H+gQtmYgZfMjAcSq
        h+P8DY27G4sIuHNpT7xIzY+DEPP6lQ==
X-Google-Smtp-Source: ABdhPJw8kbNtK89Z+bGnNpE12khmVpUyK5YNskcMYl1yh5qw2UP1aNNDhMVoCYncY9CyFubOVCb/FD841g==
X-Received: by 2002:a50:d2c7:: with SMTP id q7mr17620488edg.61.1597731173685;
 Mon, 17 Aug 2020 23:12:53 -0700 (PDT)
Date:   Tue, 18 Aug 2020 08:12:36 +0200
In-Reply-To: <20200818061239.29091-1-jannh@google.com>
Message-Id: <20200818061239.29091-3-jannh@google.com>
Mime-Version: 1.0
References: <20200818061239.29091-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 2/5] coredump: Let dump_emit() bail out on short writes
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
2.28.0.220.ged08abb693-goog

