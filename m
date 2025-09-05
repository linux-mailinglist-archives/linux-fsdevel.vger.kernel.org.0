Return-Path: <linux-fsdevel+bounces-60386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F89B4642E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C9317A0BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99852C3770;
	Fri,  5 Sep 2025 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="vpFD+WRJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940CA2D0C61
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102527; cv=none; b=hZlZ1rtwWT+zjEWP7UGKz6+0FJbHKbfdgXdQSbF9iWsLMSDMBTwQQqpufMZJbROceQGJMb04GbyKBfhI02/juSpRw7HDJ8iywqh2a2O1iqzkgeDN1U/Tyko6EvF+t+iQaaQ8jHpyDFdF6kn0RWA+Sx0W+FORcI+xKnZF1MWQr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102527; c=relaxed/simple;
	bh=lzvZtd9QaLs9Mp4bnsCTmfgKDPRPxFwFfvTW9YuwzWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGCqrJby+Hc5Uy9Al2O57P2Jgz0N+zvQhq4UXKbMmsHFjXLVkbb4p1y44LbjwrBAmE/bnfIdhtY5nnOmwbtREc0SZpag0ZbyFS6+UDAq0DzDlS43iW2upxbl6MbdZ2qDRQdQ9SdsvX7NrexIwMQkPAf2mHPhVZRiGg1DSafa334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=vpFD+WRJ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d5fb5e34cso27427027b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102525; x=1757707325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT02V3uoxau5C6n6cmuTqXU0grnKwiAJMFAqst9Yb2M=;
        b=vpFD+WRJ2l4nQKm3dIh2OtyiW6Yk+PMcE4C073glUSFHvLzhF9oK9IV49LE1OTk6R0
         1cVt5gOrtuFihnamjOZ6aRebPI7wFRFTDfQM73KkeKJuXaakYVFDgoqkSvjrW5Ld9F8G
         U8vNHrPkh+mOfFFxfo0Z7vhdWHLLSs6rElKgD2L3MB1BFvxxaxVitZOOpPyn+ChrCE6x
         HhlOJ69i1GpqkYKp4Xx5HGft02sP+ywBT3yaf//yedtgJWImQfzBCq8B7e1TZKok7ejY
         I1TX4QZP9l2l7sKZdkAuVHI84j/qKO3Ceii/EJ+WP+mrHwGG4UgKMfsjGwlKcO7Xi9ds
         rGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102525; x=1757707325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AT02V3uoxau5C6n6cmuTqXU0grnKwiAJMFAqst9Yb2M=;
        b=qTyf7iUHLi2xyzr1D3wc8Hp4nF9yTgmaypgQ3jkb/OOCZ+lUGuXyikGxFdzEOleLVS
         guDivhOY6mvo+IBYemdK/Zx3rlB7gHgm852DOAqIEEgTyOmY7IapZKjnYDwW8cQKEY2t
         CIdXsQnTrWXFoEL4erZlCfzv2xO8dvoUVcvr1e7VA9dFDUBxvnvwVGpEG73l72Rkh5fO
         AYZWA9q7UMnzzvQjG/khBjhmSyAVyJCZQubzNVlHXNPiATo5IUdBJN24gnv/cZkGdm+m
         Xtl9IyAunAsKNjAOhShhMNDSwmbm0a7VH+OnH5uQNd/89oUkmVPUixNMORe+q6G+jAm0
         z1SA==
X-Forwarded-Encrypted: i=1; AJvYcCVRetz2NUMjV6IcaRUGqJMiagaMjNziGwZpNxBq7Qy8CJorIBVjo5lfog2yaRUA98zx9PNz5dI7xYQB5xYr@vger.kernel.org
X-Gm-Message-State: AOJu0YwZrfWRDX8008tNuJaYhwAr9QPqW6o36oyq12RlyuzuPn5J4xby
	kAWpWS7n7FaXeUXgQbCrpZNopL+VaWBwDcp5DGOY3M1E+n4VQ2ty29Veujd+2Krw6MWBofWIAPU
	+SOx8t0o=
X-Gm-Gg: ASbGncvcEd+fJYidDnxnesEokiMKSBtmZL5jRwmICwF0D+Ojb5Ezu93cJjnDJy0tmOL
	6YAGgEl/+kA9LF2IbcJNAWeIWQANJ42wbWJXqM7l0kWogIsD7jKDSrGBMtAZKsm/xTrZGZGjgrN
	t8oJfnEGOVm+Pu7sMl66w4kSj9eYZjGHZPyjKCAG6YYdQLIUQaqn3tJVo9fvPoijRGq1x8Es5Co
	6zLlr2EvjMACtzJ4rlXmfOKpjpz2qr1s1L9ugiOriIAfJtoiDq4xRZJSkNnLHTX78kiv2dRkmrh
	B7rYrv0mnjrN8xB8tMtbqXMIw6VVyJhTbwmrThWAYQ2ijmIAHdjT3UcT1Fp44usg3s0bQ7hkALK
	DpeG/URhqdPGCg7U1XAs7O9ezwTksd7xJsAhkf/z6
X-Google-Smtp-Source: AGHT+IFHAx9lD6xpdTqy04zuegUJ0B3AsKgYgmCqBxZsWyOgz+3OzQJ2I0nLByYcffNTK474tlO+kg==
X-Received: by 2002:a05:690c:dcf:b0:721:b47:e22a with SMTP id 00721157ae682-725479a4e6amr49658577b3.25.1757102524657;
        Fri, 05 Sep 2025 13:02:04 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:02:04 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 12/20] ceph: add comments to metadata structures in msgpool.h
Date: Fri,  5 Sep 2025 13:01:00 -0700
Message-ID: <20250905200108.151563-13-slava@dubeyko.com>
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

This patch adds comments for struct ceph_msgpool
in /include/linux/ceph/msgpool.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/msgpool.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/ceph/msgpool.h b/include/linux/ceph/msgpool.h
index 729cdf700eae..27e6a53a014d 100644
--- a/include/linux/ceph/msgpool.h
+++ b/include/linux/ceph/msgpool.h
@@ -5,14 +5,21 @@
 #include <linux/mempool.h>
 
 /*
- * we use memory pools for preallocating messages we may receive, to
- * avoid unexpected OOM conditions.
+ * Ceph message pool metadata: Memory pool for preallocating network messages
+ * to avoid out-of-memory conditions during critical operations. Maintains
+ * a reserve of messages with specific types and sizes for reliable operation
+ * under memory pressure.
  */
 struct ceph_msgpool {
+	/* Descriptive name for debugging and identification */
 	const char *name;
+	/* Underlying kernel memory pool */
 	mempool_t *pool;
-	int type;               /* preallocated message type */
-	int front_len;          /* preallocated payload size */
+	/* Message type for preallocated messages */
+	int type;
+	/* Size of preallocated front payload */
+	int front_len;
+	/* Maximum number of data items in preallocated messages */
 	int max_data_items;
 };
 
-- 
2.51.0


