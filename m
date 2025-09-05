Return-Path: <linux-fsdevel+bounces-60381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AADEBB46424
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B61189D59C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC722C0280;
	Fri,  5 Sep 2025 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="OiHI4qZU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74872BE620
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102519; cv=none; b=Tq9mIGV6D2obg8MkVYnBcdtZYrSSP+S6WQl6AurnoBz+84xGzcw+Yh/9fKbv4q41IagBfyIFK3fAgFSVBtp5zeCjkWSi6hqfRvLc/PATWlLe/cggOGH0adCglFJnn4tbOACFwYxYo9GOzF6u/jecG2KdD3yJuZYsI4yl/58EqB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102519; c=relaxed/simple;
	bh=0CFy/0Cs+Y7quQKD6SDFhQDSufoV4lFWsciwm37yuaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8zTg5dTO0OMOXtCS4TgTVMrYrUOHUZiyhKhGsNYDzinPJ/OtUjdcoUzFpnHA7lyUV4lyAevGabhfhSGylxGiwoHnoKk60Kx8jpuE8UXthPg8MVGdbMoKi/BWoePD1SG78wZ0FxWeaMZuThif/wKQJ0SQrNq2IKLaWjZyVhq8qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=OiHI4qZU; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e96dc26dfa2so2176228276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102517; x=1757707317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v+RXdEOPuTMu7zTp8TzJPMfk4pVB2xdVlKUf9qqy3U=;
        b=OiHI4qZU1MThjYKlVoEKCIO1pWTz8LdP7wA/e/xqlzhONzga8OA6ewjUfROXKevHKw
         nhi7GFrBYh1Piwgb7/r1cimbKD4+WsiomwgCC1iu9ZzddrgYlfKCQ6fSTDiaBydB7tvb
         utQSn2jAuqVV1NPb+oDPGlnb94uQinXIHTkF6NySYcIHeoBQknJoubvYKVegGPXNUxhT
         9JY0aza+HpHi8s7irlIWQ7pJbZRPSY7kBZU8tSRydgcVA+ib3m0Z7we65vXnQLooZFny
         1YkEd+jWTKtcbB0zCzBVvxZJd1PR88YtzIPC8UtF46m3Rww8g46AtG683hBMxv4grn43
         202w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102517; x=1757707317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/v+RXdEOPuTMu7zTp8TzJPMfk4pVB2xdVlKUf9qqy3U=;
        b=pDNNAMXla9H58DOfvuL09H+ifC8ctR1OJ5Vr0TRp3AWcnEZ0fpx5r2gbpkfNkOALhd
         AR/fGoF/NWWX5sZ6aUJkFHm9F+ib8aV7w2ndgoAy465C97q3+J7JYDsQKppOGWNjqnsk
         Xp1WQDxh+Fhqv11Ca6fFtBNwx3l+ul2P+gnvejOqrHokynzC6PukR4F2LINCIvyFvXBr
         3mHjiYWDcwXH78rmDxrdgU/Zv5Rct41cWO1Aya5dXgwCk8mPMsbewrPsInj2MhzSNHkm
         e0u+rhb24qWhbULQuNI1PwobzzQe964uyDBsZWP5nYBI7wVXSrnaBn2WaNrNkZwTh4e7
         WjkA==
X-Forwarded-Encrypted: i=1; AJvYcCWkO6YGFjUoooa/5bN7ZWB2vQdJ4bNs/nRU3YMX6l4SCdE3FwsplURM5SRMYycsFtej3TsUJH1JOo1y+OgY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+uaYnWePfyDtxhOHKDAKeIYtTJl1SuGcKbxNGsSOyu/S1sgu
	Qiu0FfqVl0E5/Bn/+SEZH47qy5BvGxhk5dHcu861nrTur9cHDv8WiFxpOT1X5MVp2aU=
X-Gm-Gg: ASbGnct0ntNYqQ88x+zp06oJbRx8BQBsBr3tBifliw/jHw8VWHrmj8SjcB7/M2a7fw3
	3Mn1TwKEPs30Jl7mVLDJVDpgwEKsTOZSmHcXma0xm+dEqPZT1ThMKp2jIsGljSiXcqVW5kzCGAw
	JdSYTr4UEUiFSynCSQe8uWC7RfoAp8Gqi0lCSI9d9iZKL1hsDiENxRfoE8k2au6vFBc8yEl4kMp
	Jp46M1ti1IYiRXRQjRuVXX1T/z2h8Ap9RRQX4FkjBW/kCsDhp4TSC3abYmvw2vkcIVXfx+Q/3kq
	+JFqIwPl1BlpzZzum/RtgOFE8iHTA1TqzDQ9ZXqX8aWEMZcAJcVd8l3zg/sL73CO3YyXm9PjfRF
	RDcIl/vSX7hWikkVlBldRAnTkTNTfjToMiXJbckdH
X-Google-Smtp-Source: AGHT+IGr8DwZF1PvcbqpOiyYBvyhBdtZeQn8WgiALoHnJmBlYollBjIPtOtZEOVzyz1uGxYtwpohfg==
X-Received: by 2002:a53:dc82:0:b0:5f3:316d:1cf4 with SMTP id 956f58d0204a3-61027e48ca5mr211143d50.19.1757102516728;
        Fri, 05 Sep 2025 13:01:56 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:01:55 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 07/20] ceph: add comments in ceph_hash.h
Date: Fri,  5 Sep 2025 13:00:55 -0700
Message-ID: <20250905200108.151563-8-slava@dubeyko.com>
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

This patch adds comments for constant and method declarations
in /include/linux/ceph/ceph_hash.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/ceph_hash.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/ceph_hash.h b/include/linux/ceph/ceph_hash.h
index fda474c7a5d6..8ea203f6fbfa 100644
--- a/include/linux/ceph/ceph_hash.h
+++ b/include/linux/ceph/ceph_hash.h
@@ -2,13 +2,30 @@
 #ifndef FS_CEPH_HASH_H
 #define FS_CEPH_HASH_H
 
-#define CEPH_STR_HASH_LINUX      0x1  /* linux dcache hash */
-#define CEPH_STR_HASH_RJENKINS   0x2  /* robert jenkins' */
+/*
+ * String hashing algorithm type constants used for Ceph directory layout hashing.
+ * These determine how directory entries are distributed across metadata servers.
+ */
+/* Linux dcache hash algorithm - matches kernel dcache string hashing */
+#define CEPH_STR_HASH_LINUX      0x1
+/* Robert Jenkins' hash algorithm - provides good distribution properties */
+#define CEPH_STR_HASH_RJENKINS   0x2
 
+/*
+ * String hashing function interfaces for Ceph filesystem operations.
+ * Used primarily for consistent directory entry placement across MDS nodes.
+ */
+
+/* Compute Linux dcache-style hash of a string */
 extern unsigned ceph_str_hash_linux(const char *s, unsigned len);
+
+/* Compute Robert Jenkins hash of a string */
 extern unsigned ceph_str_hash_rjenkins(const char *s, unsigned len);
 
+/* Generic hash function dispatcher - calls appropriate algorithm based on type */
 extern unsigned ceph_str_hash(int type, const char *s, unsigned len);
+
+/* Get human-readable name for a hash algorithm type */
 extern const char *ceph_str_hash_name(int type);
 
 #endif
-- 
2.51.0


