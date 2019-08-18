Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1706391800
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 18:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfHRQ7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 12:59:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32998 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRQ7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:59:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so5747950pfq.0;
        Sun, 18 Aug 2019 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shWsRWzM35+5Yos+RU2UQmsto+H1BQo5byPAe0Akm68=;
        b=B3e7PTxrj2DaLWUCNuBoKtm+rwj4kJpzRtXfqb3S6l/65rA1d5fYVCs1Yb1CWqd+kD
         ZMmybglSMVjQQxS3iAUr6P+Zyx1uhPt4LSAIfhT76d3Sc7FuuTmfZqa3i0y3OqPKrUqX
         JaqwA6CAcS1tJTfKarwN1LwzB3hHNBUc5jhC8EhBi8WzHX1xRl3WW7Q2c30jCdXLmWiv
         FTdhcusPbhAcZP9xevzUawo7zWtNXs0rC0vkYntwCrEY+q1PfwI3DMWvkoXF4UEmPsaM
         Ak6/fh7YLisbbue03omVbf7CxA1bVejQseOGWut9dH9UoK8g7u5QHppD2fu8FLmjvEho
         E+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shWsRWzM35+5Yos+RU2UQmsto+H1BQo5byPAe0Akm68=;
        b=nwpnHs295A+uTXlMGmWVOPvcvInNtfkBM71hCwP0CTrm1BVAkTDd9Yw/+CVU/vebJ+
         OQJ4j44QjeecgEdlTaOGyYGS1rZLnKBSkoFgZYFGe2G7f1XxEYViaBtM57uGOUYSuVe9
         cU6Fb3eAbWCLI6yhzQo2r/4060/7N+LVdqy4Nup0lvFyeh02HP0r9noyZGIPkRHUcOmn
         D89ejGvdtfxOHovJtm8iNqZA7nC65KQ3LFBM4SANQALvOxyNTiytdOPRes0nSvu0y9yG
         6WwUNaYS9qAcVYndPFKylUgQuscHL6bQRf76iRUrfIuHknVtOrrcZdeCqWF6oWtvbPBc
         ZTsA==
X-Gm-Message-State: APjAAAXvQ9ImytvHrN3P+lzsdlZfmXP0I2RFAaibBpZgjZygHNOpPiqh
        CnrgZjWUhHCcH61HmbHjk0A38A39
X-Google-Smtp-Source: APXvYqy+kjZ2DvdO7w2xvC04IWsdu978wsibBtbY4J767+g61DztlihAtNZRrV5Qn3136FKPvXwXyQ==
X-Received: by 2002:a62:2aca:: with SMTP id q193mr20674597pfq.209.1566147571763;
        Sun, 18 Aug 2019 09:59:31 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.09.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 09:59:31 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de
Subject: [PATCH v8 01/20] vfs: Add file timestamp range support
Date:   Sun, 18 Aug 2019 09:57:58 -0700
Message-Id: <20190818165817.32634-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
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
index 36cb5aaf6f08..620c1911bb36 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -258,6 +258,8 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_maxbytes = MAX_NON_LFS;
 	s->s_op = &default_op;
 	s->s_time_gran = 1000000000;
+	s->s_time_min = TIME64_MIN;
+	s->s_time_max = TIME64_MAX;
 	s->cleancache_poolid = CLEANCACHE_NO_POOL;
 
 	s->s_shrink.seeks = DEFAULT_SEEKS;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d97d74f35eb3..93c440d22547 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1463,6 +1463,9 @@ struct super_block {
 
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

