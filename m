Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0E579E2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfG3Bt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:49:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37621 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbfG3Bt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:49:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id i70so18423536pgd.4;
        Mon, 29 Jul 2019 18:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V4wnsfYPepTL7VBOARGQ5lE67wVPMfBHpDaxjDrhUgM=;
        b=mVdhesQ5tNEtX68BtA01z6uL9oklDDFPLHcdyLXmewL2G4JMAlvC3Eoxkfa9wfAtLn
         hiIaDaFDX2XbDozc5yxoEv50CHGrstA6AfHc87jWXVa2DjUe3vodAws1Cu1zELgQzmhH
         1wfGKeH3BAF6Mw0lGuy5kiW85z+yDR7tuIq/OMfAOh9nVh8us5pbq2r6EFiZQtSC1Etj
         4e0ECOXlx/Z2ZAhsqxi1MW77jCXGkDFzXBcpUQ1Oy9ig5X2acoaKEeyHZQAo82BiVuqT
         YAD1Jdx9uHgNqcZFzJ4Zo7Ed/Druaq8pjr+vqRwhCExYwhhVttP3ynRpDHoe1HFVY2xk
         FYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V4wnsfYPepTL7VBOARGQ5lE67wVPMfBHpDaxjDrhUgM=;
        b=IsMKdLArXVkRJCYbMjlol8r3dbVBy5VI+oyKg/5LUZRueu8SEl7jWdn5Xc/tXM+q0J
         e3JMyoICWJa7l6vRzM7Hdiuns+3KSSvD7hYxf7xpzUyBpxAZDYXdFeK/zhmqfeDkrhxt
         f0D0y1U/5g62O1d/hA9QC+1+0irw1mfjSh9fA+EUWsqaOK8T2ZuI2ZCr1vYqnGHKn8sC
         AR662yEtaG93+8cT853GUv0LZG81V6+iIxOTCI1n8Ud7qTnpUFmUI4dWcaRdJSbvm+uJ
         ZMgGMlNFd1QWpWnY/d37oUDa0ou9aml65DTRAYC3KgSNJ9Iu0ztm8BPvwXso01O5myuv
         Q5eA==
X-Gm-Message-State: APjAAAUKwaGIEpPWNVoofV3okLm8Hy5cfcSL1YXNWp5kc4pPnxpW4IGV
        lYj8cj6UIGD3WyauRyyKLAA=
X-Google-Smtp-Source: APXvYqwOOY3NE1Y6XzD7xAqTtYd6ktSggeGAcDfSNL+1v5GlW484jITFkK4C+CN26zJOQTOzp9qUow==
X-Received: by 2002:a62:b408:: with SMTP id h8mr38574910pfn.46.1564451395352;
        Mon, 29 Jul 2019 18:49:55 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.49.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:49:54 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: [PATCH 01/20] vfs: Add file timestamp range support
Date:   Mon, 29 Jul 2019 18:49:05 -0700
Message-Id: <20190730014924.2193-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add fields to the superblock to track the min and max
timestamps supported by filesystems.

Initially, when a superblock is allocated, initialize
it to the max and min values the fields can hold.
Individual filesystems override these to match their
actual limits.

Pseudo filesystems are assumed to always support the
min and max allowable values for the fields.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/super.c             | 2 ++
 include/linux/fs.h     | 3 +++
 include/linux/time64.h | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 2739f57515f8..e5835c38d336 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -257,6 +257,8 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_maxbytes = MAX_NON_LFS;
 	s->s_op = &default_op;
 	s->s_time_gran = 1000000000;
+	s->s_time_min = TIME64_MIN;
+	s->s_time_max = TIME64_MAX;
 	s->cleancache_poolid = CLEANCACHE_NO_POOL;
 
 	s->s_shrink.seeks = DEFAULT_SEEKS;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f1a6ca872943..e9d04e4e5628 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1448,6 +1448,9 @@ struct super_block {
 
 	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
 	u32			s_time_gran;
+	/* Time limits for c/m/atime in seconds */
+	time64_t		   s_time_min;
+	time64_t		   s_time_max;
 #ifdef CONFIG_FSNOTIFY
 	__u32			s_fsnotify_mask;
 	struct fsnotify_mark_connector __rcu	*s_fsnotify_marks;
diff --git a/include/linux/time64.h b/include/linux/time64.h
index a620ee610b9f..19125489ae94 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -30,6 +30,8 @@ struct itimerspec64 {
 
 /* Located here for timespec[64]_valid_strict */
 #define TIME64_MAX			((s64)~((u64)1 << 63))
+#define TIME64_MIN			(-TIME64_MAX - 1)
+
 #define KTIME_MAX			((s64)~((u64)1 << 63))
 #define KTIME_SEC_MAX			(KTIME_MAX / NSEC_PER_SEC)
 
-- 
2.17.1

