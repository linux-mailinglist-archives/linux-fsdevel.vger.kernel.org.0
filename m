Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6184F725A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 06:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbfGXEBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jul 2019 00:01:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33747 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfGXEBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jul 2019 00:01:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so46368150otl.0;
        Tue, 23 Jul 2019 21:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bP783P8vHL5hvGQlKfl7m6itu22DJvCAUy0AE7ISvs8=;
        b=qPCplhanET8r4/AEG8Z1Oez4ly5YfbYj4GLsdIxHRcXyBhdG7qQv5tKVda6VGFN0wM
         LJaApJvBC6njyvQQ26dUfFIGfAa4vXbHJr/SUhX7M5c+FMhApEdRPvqja9R/m6LxFDm+
         yKVg2f1U/YJYDx7MEYh/VGa7M5ltkg+9Di8c0Vajc17XVxihzTho2liR5JBp+FixCxbR
         WAeCZZtU8kBlKjfQrXum+zoAgO0yG5Qad+JbgaQKSWpcn0k6ij1L/NNuPAk6Os1CTRjl
         qeHQDP5fNQyzjlhO/y5TArPmVp7XeBX7a0LuwRLHNclhdyVLcv2nqixDMLS2jqsJNDq8
         ZJDA==
X-Gm-Message-State: APjAAAUXPEUH2/O4zOb6jE9CY/uFmx5lhEztqsAumI/++guoPL29vbhO
        u4T60dvV0g6vIXdk3rUTsbOi2qCteQU=
X-Google-Smtp-Source: APXvYqzjQnT/DOSjKiboa1+pO2X26nHpVVkku+OAM/CDAP5PrqN95J4LDbJVoBS0zVwaEYQxeDcYCQ==
X-Received: by 2002:a9d:5ed:: with SMTP id 100mr6248811otd.105.1563940881828;
        Tue, 23 Jul 2019 21:01:21 -0700 (PDT)
Received: from sultan-box.localdomain ([192.111.140.132])
        by smtp.gmail.com with ESMTPSA id v65sm15464278oig.51.2019.07.23.21.01.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 21:01:21 -0700 (PDT)
Date:   Tue, 23 Jul 2019 22:01:18 -0600
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mbcache: Speed up cache entry creation
Message-ID: <20190724040118.GA31214@sultan-box.localdomain>
References: <20190723053549.14465-1-sultan@kerneltoast.com>
 <5EDDA127-031C-4F16-9B9B-8DBC94C7E471@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EDDA127-031C-4F16-9B9B-8DBC94C7E471@dilger.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 23, 2019 at 10:56:05AM -0600, Andreas Dilger wrote:
> Do you have any kind of performance metrics that show this is an actual
> improvement in performance?  This would be either macro-level benchmarks
> (e.g. fio, but this seems unlikely to show any benefit), or micro-level
> measurements (e.g. flame graph) that show a net reduction in CPU cycles,
> lock contention, etc. in this part of the code.

Hi Andreas,

Here are some basic micro-benchmark results:

Before:
[    3.162896] mb_cache_entry_create: AVG cycles: 75
[    3.054701] mb_cache_entry_create: AVG cycles: 78
[    3.152321] mb_cache_entry_create: AVG cycles: 77

After:
[    3.043380] mb_cache_entry_create: AVG cycles: 68
[    3.194321] mb_cache_entry_create: AVG cycles: 71
[    3.038100] mb_cache_entry_create: AVG cycles: 69

The performance difference is probably more drastic when free memory is low,
since an unnecessary call to kmem_cache_alloc() can result in a long wait for
pages to be freed.

The micro-benchmark code is attached.

Thanks,
Sultan
---
diff --git a/fs/mbcache.c b/fs/mbcache.c
index 289f3664061e..e0f22ff8fab8 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -82,7 +82,7 @@ static inline struct mb_bucket *mb_cache_entry_bucket(struct mb_cache *cache,
  * -EBUSY if entry with the same key and value already exists in cache.
  * Otherwise 0 is returned.
  */
-int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
+static int __mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
 			  u64 value, bool reusable)
 {
 	struct mb_cache_entry *entry, *dup;
@@ -148,6 +148,29 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
 
 	return 0;
 }
+
+int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
+			  u64 value, bool reusable)
+{
+	static unsigned long count, sum;
+	static DEFINE_MUTEX(lock);
+	volatile cycles_t start, delta;
+	int ret;
+
+	mutex_lock(&lock);
+	local_irq_disable();
+	start = get_cycles();
+	ret = __mb_cache_entry_create(cache, mask, key, value, reusable);
+	delta = get_cycles() - start;
+	local_irq_enable();
+
+	sum += delta;
+	if (++count == 1000)
+		printk("%s: AVG cycles: %lu\n", __func__, sum / count);
+	mutex_unlock(&lock);
+
+	return ret;
+}
 EXPORT_SYMBOL(mb_cache_entry_create);
 
 void __mb_cache_entry_free(struct mb_cache_entry *entry)
