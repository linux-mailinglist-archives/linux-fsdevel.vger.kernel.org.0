Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5ED36C8703
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 21:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjCXUo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 16:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjCXUoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:44:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01439BDDC
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 13:44:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o2so2954479plg.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 13:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679690690; x=1682282690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEWa8RqyWnmLoYKTYgOGZe7r28i+i7nM+JxeYDQo2JY=;
        b=Ug7GmmPOOt0bnUK3Ic063D+toKxyLE88oNFnTH2C9F08q5d+G4VC9amlZLFybFAyfx
         yZAjGubPGYl7yUwpIMSFY4+oMzNauylq5QbuzTmxfQV7LgGM0ivlelInJPhws9tDhb7z
         1HEHsmElwXXUMpa/RilGjlizjNGqSq2lERUtmTXpCsJD3mM4UYcBCydXmLBxNbb3En6N
         QHPulxpx0d+sc7YNtT5qw/aL4HDZ3dSJCVVTy1rfZK2iRa9AQdoCfqJSyuVssOka+wpJ
         VhO5ZbkhY1fhuY7pm4ByQ5BzCvVWaihJJVYN0h7NKlaq8Sm9vFGEnT6VccX6bkAIapIG
         Mt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690690; x=1682282690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEWa8RqyWnmLoYKTYgOGZe7r28i+i7nM+JxeYDQo2JY=;
        b=O+SES9U64WqMfLjm6A6UjLHwCxLEL/4/JBPkdVBeS0Dk+pZptlldcf3T0+ru83x+Xn
         UAD45X1fe0A/100dNMULcZrHR+bYV+GZy0L/iTLiKWgReij3kfyjQhAC+wvSHd5dxs+z
         HkmeQGbF+jMlCgHYeKG6zThm0IKPRIWWrWquNkfCDfiTbiGXnjGdjsHRiY7yeFIkWzcB
         E2zkZIsgN2qn2MCTkXeQgMXdLphonr82syE+BaMpq+L+yK1MViSw8ZEI6JOHM82EFrwI
         4GB97BJ0kQewt9LRQ8oG/A48Wt5Q9PvMR41wHaTqUoRc3hmB3U5CJ2yeF4ozlcTftmCJ
         jlyQ==
X-Gm-Message-State: AAQBX9eDfv0sZd/fJ+NCPX+PUB3t4AhhVdbeaCAkl6s76lpFTyYWZCbq
        jU28KklKBgFDBMiY4m6vykfVKOPw5Wc+GQY9KMc5zg==
X-Google-Smtp-Source: AKy350bd/TJ5eLCcGQP1rpB4ojHe1mr1rKOCu77gjZFkzl/rz81qWNphoSYiBnWmVjJTVxanSEurjQ==
X-Received: by 2002:a17:902:f943:b0:19a:839d:b67a with SMTP id kx3-20020a170902f94300b0019a839db67amr3452436plb.5.1679690690006;
        Fri, 24 Mar 2023 13:44:50 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jc9-20020a17090325c900b0019a87ede846sm14605344plb.285.2023.03.24.13.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:44:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] iov_iter: import single vector iovecs as ITER_UBUF
Date:   Fri, 24 Mar 2023 14:44:43 -0600
Message-Id: <20230324204443.45950-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324204443.45950-1-axboe@kernel.dk>
References: <20230324204443.45950-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a special case to __import_iovec(), which imports a single segment
iovec as an ITER_UBUF rather than an ITER_IOVEC. ITER_UBUF is cheaper
to iterate than ITER_IOVEC, and for a single segment iovec, there's no
point in using a segmented iterator.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 lib/iov_iter.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fc82cc42ffe6..7868145fde4f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1780,6 +1780,28 @@ struct iovec *iovec_from_user(const struct iovec __user *uvec,
 	return iov;
 }
 
+/*
+ * Single segment iovec supplied by the user, import it as ITER_UBUF.
+ */
+ssize_t __import_iovec_ubuf(int type, const struct iovec __user *uvec,
+			    struct iovec **iovp, struct iov_iter *i,
+			    bool compat)
+{
+	struct iovec *iov = *iovp;
+	ssize_t ret;
+
+	if (compat)
+		ret = copy_compat_iovec_from_user(iov, uvec, 1);
+	else
+		ret = copy_iovec_from_user(iov, uvec, 1);
+	if (unlikely(ret))
+		return ret;
+
+	import_ubuf(type, iov->iov_base, iov->iov_len, i);
+	*iovp = NULL;
+	return i->count;
+}
+
 ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 		 unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
 		 struct iov_iter *i, bool compat)
@@ -1788,6 +1810,9 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 	unsigned long seg;
 	struct iovec *iov;
 
+	if (nr_segs == 1)
+		return __import_iovec_ubuf(type, uvec, iovp, i, compat);
+
 	iov = iovec_from_user(uvec, nr_segs, fast_segs, *iovp, compat);
 	if (IS_ERR(iov)) {
 		*iovp = NULL;
-- 
2.39.2

