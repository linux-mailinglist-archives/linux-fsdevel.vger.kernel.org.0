Return-Path: <linux-fsdevel+bounces-60390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E327AB46436
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936133B131A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343AD27990C;
	Fri,  5 Sep 2025 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="bjbZx4qW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDEC28BA95
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102536; cv=none; b=NvsLfwA2kvFz9xOKRg6vl3ZO7D9/2RhCmkScTza5ek8KWUJzk3X0BRoq+5r6Q56G8WLkw31DzGEA9fKucUjodelSa2ehYGj6BVKsQMQyArRHThGeRS/cknnjQtJKYgwSPv+ei8fCiDzwMmNsY05K/CEnnAnepgQCCfpKBhJmhv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102536; c=relaxed/simple;
	bh=pDkEzq9qtGrw6QWE5ePJPNhSbWzcM7b+DqpwgsaSpjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGDEQwpgzjIeUeXQ1HNZZF4CT2PbyP74L/LIp7qYtWIJZIMSzbW9YZrmb9qF0MxPFWaDnmZMz7KDRBamjeHFJu37JuQXZShP2V05NnA3rVyb4CNQxHBpbvmEZGPy9+x5ZaSQe53HDLvAR93Nkq0olrKVelq25GCaEa6LUYkNPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=bjbZx4qW; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d60504bf8so25875777b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102534; x=1757707334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKHTEqQXzjS0xQHNWAB4vZhFU6CrS5vtASH1+NVtx6Y=;
        b=bjbZx4qWqa9ybqvNujQxqV3yMFlgMpRUb1jIY9ga93jY4XLnda31FrtqPxA1xIZHhb
         Hj8KJYgigSExZV31hhxMKazg/FDQ7DczLkddA05R8IZXtXwruLGIbaBHbucf6gJJ2Xq0
         CazsZl3gdh63B4LHDnSVZAZ4y4MEkRwFSrSMD6CVOJ5EfBmoZWcR7+w6F6EOsABMtYvY
         JjRDnjsa4BmX814Ln9zfXdmbB4QYougmwf2Epdwwzj2UYOVa3tF+auBDGVXwEH3uoywV
         dMcPwW2cpiI2Z7lQMX7vNSQkHyQhmVtAi6bBtZlpcf3aSlWyMZKqZN0n3zZKhdrMlqkh
         RIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102534; x=1757707334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKHTEqQXzjS0xQHNWAB4vZhFU6CrS5vtASH1+NVtx6Y=;
        b=GBBDbytsMWRb7r/HhJVYMqRCk19DowruUCKu9ob1wT2CqlufPylTHDW49UJAB38zTn
         BK97Z8b2v2AV822f5KmmbjPTn++Dg/tnegmt4+9pTEgW9e24fqnOrWd2LZbY+3+mnXXq
         3xXYEZXxz38tjHvH/Rf6XvHeBfVGRbHBr1JGAcLSPRVepxQ8IW8MwT9a0ZlJ1D5g3AI2
         qjXTvOYuJyDKNLqrIk+EsfgdGdpoU6I6tP41ZV/oDeITZpKi7tlPldC0CXuvJY6BZse0
         yiVuqFKs9csezCzf9MqjT00+pM1lJeIYKJYVsu/NHj/sdTgGcHMVTTvf61JwR3gqTJ9/
         w/oA==
X-Forwarded-Encrypted: i=1; AJvYcCVlWoLYhPdp2ztnhVr1BB6wx7nsd7YgwX3Xz6H4Q2Pbs6YRSPvhL1BXe99rAPkepAlmhlQ5h0lW36uCzMG3@vger.kernel.org
X-Gm-Message-State: AOJu0YxTiS5r8+K+W7MM5SGW+wQCb94xtVGa9tR1O3t/PLxjIrOuDE6Y
	tsVSmNj6fgeuMw8DY8mtwWnotWS4Dz/z4eJFDKJII3/ybg3fpJTBIvYcDVTfSTD8tgk=
X-Gm-Gg: ASbGncsB6+Xxt9JatP5TiExVt6WEXPQLXnZsERS0pEl+NqdLHwkg9uGmOJPJKMvzXdN
	kcwm2izB333NsfkOHDGCKYRmeDmEkxa3I0t+il23laK0C849lmYn2N7p/aNosLJGYh/AyvnYOqd
	ltuT+KJJ/ssyMxxLkcwlvAHoA1SOlgGiAukq1BhEcj2MCm8Uw5KYzX6PTm5VqXMgmdqAqBLphRO
	WVqOJYOTOeIsXYqAY5tsEHNloyE/chafiOPPsnwaptB7+E7LAXkvM72V3tTP3qbkyoKLIGfAcTa
	DWZYSZWUZZZb62C9I2pvLpWMKLwEvsDAzg7NbTbFv26y7SsHjDee/wxrsa+4K4mV+3nHGyZyjNI
	hVj0kBxOAlIDpOvgmCOXGXuO6ZJW5iilpIpViY7nuMglpBREyFQKmHgq4Ocwc/Q==
X-Google-Smtp-Source: AGHT+IGQznX/tXChXLzvUzzM7zKQN8g459gR82SC+/VJSjPKm2CMspNA7avOTPFuFU62lu9ouEFbug==
X-Received: by 2002:a05:690c:c0f:b0:71f:b6d2:f8f2 with SMTP id 00721157ae682-727f03e654cmr1864807b3.0.1757102533978;
        Fri, 05 Sep 2025 13:02:13 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:02:10 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 16/20] ceph: add comments to metadata structures in pagelist.h
Date: Fri,  5 Sep 2025 13:01:04 -0700
Message-ID: <20250905200108.151563-17-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905200108.151563-1-slava@dubeyko.com>
References: <20250905200108.151563-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

We have a lot of declarations and not enough good
comments on it.

Claude AI generated comments for CephFS metadata structure
declarations in include/linux/ceph/*.h. These comments
have been reviewed, checked, and corrected.

This patch adds comments for struct ceph_pagelist
in /include/linux/ceph/pagelist.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/pagelist.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/ceph/pagelist.h b/include/linux/ceph/pagelist.h
index 879bec0863aa..1954366ea71b 100644
--- a/include/linux/ceph/pagelist.h
+++ b/include/linux/ceph/pagelist.h
@@ -7,13 +7,26 @@
 #include <linux/list.h>
 #include <linux/types.h>
 
+/*
+ * Page list container metadata: Manages a list of memory pages for efficient
+ * data serialization and transmission. Provides append-only interface with
+ * automatic page allocation, reference counting, and optimized tail access
+ * for building large data structures without memory copies.
+ */
 struct ceph_pagelist {
+	/* Linked list of allocated pages containing data */
 	struct list_head head;
+	/* Memory mapping of current tail page for efficient appends */
 	void *mapped_tail;
+	/* Total data length across all pages */
 	size_t length;
+	/* Available space remaining in current tail page */
 	size_t room;
+	/* List of pre-allocated pages available for future use */
 	struct list_head free_list;
+	/* Count of pages in the free list */
 	size_t num_pages_free;
+	/* Reference count for safe sharing and cleanup */
 	refcount_t refcnt;
 };
 
-- 
2.51.0


