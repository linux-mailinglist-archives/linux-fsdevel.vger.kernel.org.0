Return-Path: <linux-fsdevel+bounces-60377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B7B4641C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB6E7B27D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5E2299944;
	Fri,  5 Sep 2025 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="2iKVHs5E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532C28725B
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102512; cv=none; b=ZRcOsRkLbT+NcDtl0+FT4fWZNrTrSoFRbipHnzVCRypdMdmJ+fTp0hruAIpO7WPXmogL0WEDZgLlNDkeqcRmF0AKpWg3sqan+jrA7YoDoJbDcD/Pg4jGtOXNmZ7PVLmP2y6twLFqf97qgL7kc7RuPn5AUzwx6/j/mo5+ITG02ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102512; c=relaxed/simple;
	bh=m4Shq0w1QeGWE+lESirfaTaJl7mavJNlhxShOIYSN9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMxJfMsrX84CrPTuoxbZ45HDuplxMsJr4bw1a9XF35L8s/cF1E3wtFAHPtmk1fau1mpIF4WgwUGb/A4HB5P9zn4nqjDHGgc3tBWJJd98XJRc2RHJ3uN+fytUQD1HsET8+pZZku9RW3GqF3Y3cbwrfMvspiOxE+9aULva+ya6B/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=2iKVHs5E; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-72485e14efbso26038317b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102510; x=1757707310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6o6xlEervPq3TBu5cEylN0YsfH2EgWkd2uA0/3pnh0=;
        b=2iKVHs5EIhD8HfzQ8cZ/uOk3sD0W593VduS/a1JMssFmjCzbcz9OZ1DKsTHQphVQcF
         HUgdEHxE84FZHMlMVJadXaz/Gqfn1/F10CpBhgGRYl1NKEeB/iiWfT8kFPvn+Gw7PgyW
         uunWI186YR/L2TDUPT1DyAhByU6yMm+YNMfhO+E3xX/T9bslSQdQdMn0fiEWTkHS3raV
         pFImyPLxTSSaZCVeI7gOUegQ4DrPzLAkFSNAIAkZsov058HcVhhLZtGhpkK6SvND5Fal
         Xa9XjxLwBNybYmcpekGJqYGDUY4yRoYS+YpK88I7dzbeAWyK1bUrM7siXhbfGLMeJC5x
         nWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102510; x=1757707310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6o6xlEervPq3TBu5cEylN0YsfH2EgWkd2uA0/3pnh0=;
        b=nKxBiI4yYTqpOzTUNVMFPDygpcxjh0sYwGrsRcPTfQvylvQdFHKV29Z3YLMeFRQIr0
         Nb8kWPUQCLeKkabl9zmByOP/1lj1KG0YuD9KRJy5Od1BA8dSB3VMFkmySqTNH6Wymrnq
         Qi7V9RglKyb1+iZ0rTtJmglt4Dq5wmK2zF4LgZMeM3awjY0MN8De5tbp+lZFnPuVclIW
         qqyEYXybm/B17stZ1Tz6zsxJOnIhX+DX5GbMwXhkRJYKJLMAdIbIuGCIuex+tZkxy7xr
         GlCdW9m6OUX+TPOPDASxUJUL9ZTmYWj6CzKVjsYwHFOwW/kf9TjRsk8ZgRr/rOdSsPKd
         xEfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrsF9V2TfWEz1aJt816y55OiMjmrDgvbuOm9IbbtTIZpRLAFML7DxcbaGOD6MB61wD6l5cScI3Tsklwa+x@vger.kernel.org
X-Gm-Message-State: AOJu0YxRHCTKWYV6Zdn3mVdHpSNWyUbMAiPCe7iU5IuYzOGBAZeYeCMd
	H1+j0BroOu8e3QeWfjec+Wpfj07xNB5wwLztRb7MEVrLX2VGT48JG66Fn0GwXD1MiTg=
X-Gm-Gg: ASbGncv/kTDmFLFhE5EIiG3Si4MB2WjAsXtsz0tGbpd47DB9NmVRjdMV59ppRfUm0MY
	NBVXFMkSVhvveV+TM0E9PkzapSdidIiUva3H5w23PrhoYnPnlU2wTvgTj6M8uV8xnzOVOhOhb/n
	K2xv4e9j6iIeJQ2r+eCCte3bAK8xnuBfP98ezakmWGzNA+p9Ryocr74bSpoF69AX/JQ7Ezv3QXo
	LQ1cC3ed6SUtbKGCwG3x/g8cJg+fZdqmju4Twd7cNNSkpRJ8cZ+RlIZfUYSksfP/dpJqHZVqAgH
	18B1FcH004TfjJ2WX5UiA8VZN0oWvVQw2NbWwukPA+WONnkNRMWXJPo1fkJCXFLHE9+eyibuTia
	lv7VvW5I20zyktONEU3KIxBRmZJUJ4wl/3A/Qs+wfvXNCB2Uq9Co=
X-Google-Smtp-Source: AGHT+IGq2TElXN07d6LtA/B+GqmB04VnpnY/X4EZ8ZQmTbnUQB9PdZstgAs6SBiiv+TeeqZg/XDQsg==
X-Received: by 2002:a05:690c:4889:b0:70f:83af:7db1 with SMTP id 00721157ae682-727f2eb8fdbmr1687677b3.19.1757102509923;
        Fri, 05 Sep 2025 13:01:49 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:01:49 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 03/20] ceph: add comments in ceph_debug.h
Date: Fri,  5 Sep 2025 13:00:51 -0700
Message-ID: <20250905200108.151563-4-slava@dubeyko.com>
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

This patch adds clarifiying comments in
include/linux/ceph/ceph_debug.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/ceph_debug.h | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
index 5f904591fa5f..d94865e762d1 100644
--- a/include/linux/ceph/ceph_debug.h
+++ b/include/linux/ceph/ceph_debug.h
@@ -9,11 +9,16 @@
 #ifdef CONFIG_CEPH_LIB_PRETTYDEBUG
 
 /*
- * wrap pr_debug to include a filename:lineno prefix on each line.
- * this incurs some overhead (kernel size and execution time) due to
- * the extra function call at each call site.
+ * Pretty debug output metadata: Enhanced debugging infrastructure that provides
+ * detailed context information including filenames, line numbers, and client
+ * identification. Incurs additional overhead but significantly improves debugging
+ * capabilities for complex distributed system interactions.
  */
 
+/*
+ * Active debug macros: Full-featured debugging with file/line context.
+ * Format: "MODULE FILE:LINE : message" with optional client identification.
+ */
 # if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
 #  define dout(fmt, ...)						\
 	pr_debug("%.*s %12.12s:%-4d : " fmt,				\
@@ -26,7 +31,10 @@
 		 &client->fsid, client->monc.auth->global_id,		\
 		 ##__VA_ARGS__)
 # else
-/* faux printk call just to see any compiler warnings. */
+/*
+ * Compile-time debug validation: No-op macros that preserve format string
+ * checking without generating debug output. Catches format errors at compile time.
+ */
 #  define dout(fmt, ...)					\
 		no_printk(KERN_DEBUG fmt, ##__VA_ARGS__)
 #  define doutc(client, fmt, ...)				\
@@ -39,7 +47,8 @@
 #else
 
 /*
- * or, just wrap pr_debug
+ * Simple debug output metadata: Basic debugging without filename/line context.
+ * Lighter weight alternative that includes client identification and function names.
  */
 # define dout(fmt, ...)	pr_debug(" " fmt, ##__VA_ARGS__)
 # define doutc(client, fmt, ...)					\
@@ -48,6 +57,12 @@
 
 #endif
 
+/*
+ * Client-aware logging macros: Production logging infrastructure that includes
+ * client identification (FSID + global ID) in all messages. Essential for
+ * debugging multi-client scenarios and cluster-wide issues.
+ * Format: "[FSID GLOBAL_ID]: message"
+ */
 #define pr_notice_client(client, fmt, ...)				\
 	pr_notice("[%pU %llu]: " fmt, &client->fsid,			\
 		  client->monc.auth->global_id, ##__VA_ARGS__)
-- 
2.51.0


