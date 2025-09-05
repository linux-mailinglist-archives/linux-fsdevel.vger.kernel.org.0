Return-Path: <linux-fsdevel+bounces-60393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B1BB4643D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CF8DBA059D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42AE303A32;
	Fri,  5 Sep 2025 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="3Ng9vjS3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA85303A0D
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102542; cv=none; b=qh/twbDJtLU0YHqOG1FQBLzdSGEJi1wj5P6uW3OSKP3LsZC+FNxoV9G5szMv1lo+yuiNPfPug+fsh9ePe4uDQ6bkZ8FKsa5IEoFYs1fsU2yKRZKrs9lyddhKAX7lGSSK1w4FOvKSy/wM2iISQpxHJ2150CP+0w+ag6WhxquCPrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102542; c=relaxed/simple;
	bh=Z70XoPTOlkx9NTkkt2pkQeBwuj916mfiH00C2upYnDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WO/6clCehJ5QwNrh7CLVT2aXIVIHy69q669lX3uB16B8jBHNZoxPH/q3fCFpZE3yxd5IT2WnS+mzMKKLoy7flep0DdB+6EPhXP8x3BXfkoWot8s4B8kd34dyLf8trzg0i/9N/3IMkCsELAnDmFxNRgN2Kw0DO1WCRwBqPBL0YkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=3Ng9vjS3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-72485e14efbso26041647b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102539; x=1757707339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWQO3dA2PY3E2HhVFs5HhmytlwkwxTfpbqYMbwO7Sb0=;
        b=3Ng9vjS3jhHMYdkXV+64ISA+U1W+sh0uWro6avjb/ozzrtS6fR38lnhKf24IA5mA4m
         WNsF0p1sQ0ZKfc+rRHEDumW9oz7Yfgr1KWe1C8VRVOfRFe6br94XPvFsbzZRL+bYuzCa
         YZuZ2BGKs3RYnMxT2aU+KhcFe+9lheVLKM6wE0nM6wl0EWXA5giQuoRloWj5NJpA1a4f
         r47jWSilgual8OD0no97H5VJKttBZgdjHFgphJWC4UJpTEQ/qHIVWyoTkHD/YhmCW2iQ
         uWkv3/EBQ0Ba4aCvn5prED+aje2vba9vibcYiBXDrYP1WYiYSlNNFxpFeMvThlFXQd+u
         2y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102539; x=1757707339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWQO3dA2PY3E2HhVFs5HhmytlwkwxTfpbqYMbwO7Sb0=;
        b=Kgj01V+dvs4+8OCs+y1+93JIg0MHAmHg+B+wh+kXZ1Bwupy0OQrGQ1itzoS9+GEBVL
         rgMhBbAqArmKGsl0V9uXMXfAKnKr+MP4HF0cMXMudtCX94PU8AM2FHlbV2VUJh2ZcVVJ
         zpSn9IcNabYi/9vgeF8z6AUAv0pEgcUHYR0PGOYDrJfyHl3ixI9Fpcqzisvy2n+ZWNVn
         +h6GYidCEK3qbQY/NH8gmQDxFRiR+D9vAIe7s5WjqnlUO+BlN+vNp7ZyFWjeLLQG8xm9
         V0Qm/BgQG+ewSJe5vIZVdK9E0eDRpXsxRI71y5/Dh8VBTcbqD0VmTWXr6L/yIJvpn38S
         UBYw==
X-Forwarded-Encrypted: i=1; AJvYcCWxzT35HWU4pzNFQeOx7zAqfKSEMdu6LPbYSIV7QwnLOSAloKAn31r1s8D7BME/lfw9iRb8VKNQPkPA/ioe@vger.kernel.org
X-Gm-Message-State: AOJu0YyXep1v2wngcAt0mqepVpA2sJyL0JVJl6gQqX4sTVoh0xdFqwgG
	9zLSLUckNs0Ky0w44N/YnEdLWnpNU4AtS6kj823WUPieqbA+Gz9wj4KHj+Z2qiP0JVWvy9cI0xY
	RocGTKII=
X-Gm-Gg: ASbGncvAviDDfKQ6MzasdDTTtenyVJJclbPkaHLJDY1ilEySOM0YlcQZDE+rZtHmo3n
	0J4t6PiL0cR0+6gMNmWzN2E5MfxwSaGZyXQLCy9FaRDdVwMrBTJL7tIerK/VOXMFvpdBlaJyFWQ
	PWaOJiK6PP6KGD7zwPjUcHRNo1XgyAhGYh0BejC9hXYpIBgeqFXPjJiEuAZ+pmf6ZWdDn2cTsCf
	FEb2Ow1fILOxizH5yo5kqGSrI17YKQP9esytJ1M0qy9jp6NfxVZLzqSqSXL8pviJRch95avn4II
	kibW8lAlJCyMgPvfIpxRG1uicTq1IEVXJpnFxhfJDHiYAl3F3BdBeBKc7dhDBsyYussI9svsaaG
	zrDOOBuvsnTIfPFPAf2jBtY6P1fU4RGHtjZ0oGvLcwdJrfWNrOLE=
X-Google-Smtp-Source: AGHT+IG/kcbnQZ4r9wPJa9PEhHM8BCr/6/zPvPVkQZKVMMQuqOVGK6oRdeQv44iVffo3zR4wH5qKDQ==
X-Received: by 2002:a05:690c:968f:b0:70e:142d:9c6e with SMTP id 00721157ae682-727f496b52cmr1217857b3.32.1757102539448;
        Fri, 05 Sep 2025 13:02:19 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:02:18 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 19/20] ceph: add comments to metadata structures in striper.h
Date: Fri,  5 Sep 2025 13:01:07 -0700
Message-ID: <20250905200108.151563-20-slava@dubeyko.com>
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

This patch adds comments for struct ceph_object_extent,
struct ceph_file_extent in /include/linux/ceph/striper.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/striper.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/ceph/striper.h b/include/linux/ceph/striper.h
index 3486636c0e6e..b59c055ce562 100644
--- a/include/linux/ceph/striper.h
+++ b/include/linux/ceph/striper.h
@@ -11,10 +11,19 @@ void ceph_calc_file_object_mapping(struct ceph_file_layout *l,
 				   u64 off, u64 len,
 				   u64 *objno, u64 *objoff, u32 *xlen);
 
+/*
+ * Object extent metadata: Represents a contiguous range within a RADOS object
+ * that maps to part of a file. Used by the striping layer to break file I/O
+ * operations into object-level operations distributed across the cluster.
+ */
 struct ceph_object_extent {
+	/* Linkage for lists of extents */
 	struct list_head oe_item;
+	/* RADOS object number containing this extent */
 	u64 oe_objno;
+	/* Byte offset within the object */
 	u64 oe_off;
+	/* Length of the extent in bytes */
 	u64 oe_len;
 };
 
@@ -44,8 +53,15 @@ int ceph_iterate_extents(struct ceph_file_layout *l, u64 off, u64 len,
 			 ceph_object_extent_fn_t action_fn,
 			 void *action_arg);
 
+/*
+ * File extent metadata: Represents a contiguous range within a file.
+ * Used to describe logical file ranges that correspond to object extents
+ * after stripe mapping calculations.
+ */
 struct ceph_file_extent {
+	/* Byte offset within the file */
 	u64 fe_off;
+	/* Length of the extent in bytes */
 	u64 fe_len;
 };
 
-- 
2.51.0


