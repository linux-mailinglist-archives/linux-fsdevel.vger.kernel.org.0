Return-Path: <linux-fsdevel+bounces-60391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6AEB46438
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906391CC5AC2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CF22848B4;
	Fri,  5 Sep 2025 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="VLNSJSsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42747303A05
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102539; cv=none; b=DIoDZcNTuuOEl1oU48DVn7V00icPbUsVmO/ABxgHfS/Tdw3G6hKvmVUNVAIRWft5TsvSoTwbuRd5zVXak35pyN7E/4YsVajhdgVABtBmbRnac5H+0Bk7S+Dz9APTt4iGLgKRdtzLgi/VuOwdlVB4XJkbOoo7NG4d7oRybpJL4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102539; c=relaxed/simple;
	bh=QD/XJd1fMfno8Xq/Ua6evXoBaLVg9iLmUIRUFCvvAJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugF8INFOd5f8jnnpzyqF9GqlAD5dK3ug0TWMSpF6kS6fFbBBpSWtTiYZau8g5EA12YGA5PbORMpzilFkgkciPFbB2BzfDTYcBDkkpp3AF2EV7/Jig2PEn/C1nXri1vCqb+XBVu8M05NvWW7tUnXl+eaKzqIiob7dc30OxRy7McI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=VLNSJSsS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-72485e14efbso26041197b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102536; x=1757707336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlFTId6UV7Bo09rJ9zs7osFZ95bNpE1HJh5KJ9UpQNI=;
        b=VLNSJSsSIHP0hAF6KNRtsUx32ngJofUf2SNK+137QvDRZBmiba/98N7CcDZN/BwRbo
         YHj3yAWX5tLp97ZJMV/XDfFpl6++W87YeDIcqMIz9nk56wM5WXmuY5NIwdnUtjQk9cDX
         P1FG53yRgil439mQ52vE3YhT7fQimJzcJCqqMjqa+JbW2SaHY/kWe/RhCvKVnjFtbvnU
         5x83agg5pmXywLmXz4Q0pagCNIm/qPI8p7Xdxl1Glj6HiuTtwKiZgcx5s6rhrXItGVh6
         DxMK4hoIfLv6+SPS/eMpUgls0sdtKA3naeFoe8k5t1E5MdvDpm08womwU961eJhjYX5A
         ZJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102536; x=1757707336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlFTId6UV7Bo09rJ9zs7osFZ95bNpE1HJh5KJ9UpQNI=;
        b=E5rZS59fBaEiHU/YTyIR7y4s8t5fNRTPpE/H9gxHWpf6bHm0RqdaSofnWh03mF3prE
         vLMCe+ii+FViplX8M0VLFZBm9PVxNqInfgXdDhUin1sgSMe9B/uCvUB1TaRKrsG6v5gf
         URPYx598YMcro9rH3TxlCwL0R9e7n+4ybm180Ubtq5OnneA3V5jmVUplt79Yd3Fklgdx
         Soc1BqWk8DzXbzj4rF+IdExP7OUk4A8vnFIJOBttkQFryoTUmD0aPlviY/7sgdNvt9t2
         EqSDIRRwxyYy9q1B2GU5xbOL8AknvPSkGU6cZOTwitr39E4egD8XLloJ7QUErzZXiwkm
         LirA==
X-Forwarded-Encrypted: i=1; AJvYcCWu1AIN1uSrU1fSJQVqJh1PwndipLgWsoLWLry5u16Yng4busc/azQP0D8qcOv/caZP3mfRU4ZQovbqhQE3@vger.kernel.org
X-Gm-Message-State: AOJu0YwpuOklwZvVWHGbj+terwXCvnntxOfOlualT+I8U9SrC3nEj4nt
	sfqYSfn9m+ylJ8RhJx28mKlgfRXlJLEt+Fc8tpRJksdsbcFE5Phy6dSXS9b5+ba5b7c=
X-Gm-Gg: ASbGncs7hL1UsKb5/ttwGiRd1Qj0Y/S7cVhG6TnMcAkQxl/gjh+7J6M349rtHYauCoC
	YsTrJ4OduE/phVjrC9smdHs3FSRjIPmIUAENJa23zLZ84h+LLimJ3i/sgdj3OcLl5c5SPWiWOx9
	0eSTrRemMpXg4ZhGxA6aKEub6TA5cxQQE+Lj68fWXWpyFqLwBA871lE6D22CaXB3ZQ8V++PU31z
	1WEHSGp7xtfzdgOXJkyFVslGGWondxtJgKjRM3oIUlR647NE/obxHNXZWIbDf0hL3MWYBDqKCm3
	lmpSNfHvqzYwqyVsUvquu5woEnTYkmGC/KLi3OfPoMBXocWV4Zz0RscG1I3oTuM5Wctk0mlQ+cg
	At4GJRtCmNGp5Y6jEzc8wrqMS+Tb7dhC+3cuIgh2imRbAqvCAy58=
X-Google-Smtp-Source: AGHT+IHa9Svm+dbm4fl3DsCOzIyUZBItu4CNR2HYQsap9/tb5+gRYuyWzuYLGaoH2mz6m166nqp7WQ==
X-Received: by 2002:a05:690c:3392:b0:726:bba4:dd50 with SMTP id 00721157ae682-727f27dbf83mr1265017b3.8.1757102536021;
        Fri, 05 Sep 2025 13:02:16 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:02:14 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 17/20] ceph: add comments to metadata structures in rados.h
Date: Fri,  5 Sep 2025 13:01:05 -0700
Message-ID: <20250905200108.151563-18-slava@dubeyko.com>
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

This patch adds comments for struct ceph_fsid,
struct ceph_timespec, struct ceph_pg_v1,
struct ceph_object_layout, struct ceph_eversion,
struct ceph_osd_op in /include/linux/ceph/rados.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/rados.h | 91 ++++++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 14 deletions(-)

diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 73c3efbec36c..1850ef439bf6 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -10,9 +10,12 @@
 #include <linux/ceph/msgr.h>
 
 /*
- * fs id
+ * Filesystem identifier metadata: Unique 128-bit identifier for a Ceph cluster.
+ * All clients and daemons in the same cluster share this FSID, used to prevent
+ * accidental cross-cluster communication and data corruption.
  */
 struct ceph_fsid {
+	/* 16-byte unique cluster identifier */
 	unsigned char fsid[16];
 };
 
@@ -30,8 +33,15 @@ typedef __le64 ceph_snapid_t;
 #define CEPH_NOSNAP  ((__u64)(-2))  /* "head", "live" revision */
 #define CEPH_MAXSNAP ((__u64)(-3))  /* largest valid snapid */
 
+/*
+ * RADOS timespec metadata: Network-endian time representation used in
+ * RADOS protocol messages. Provides nanosecond precision timestamps
+ * for object modification times and other temporal data.
+ */
 struct ceph_timespec {
+	/* Seconds since Unix epoch (little-endian) */
 	__le32 tv_sec;
+	/* Nanoseconds within the second (little-endian) */
 	__le32 tv_nsec;
 } __attribute__ ((packed));
 
@@ -54,13 +64,17 @@ struct ceph_timespec {
 #define CEPH_PG_MAX_SIZE      32  /* max # osds in a single pg */
 
 /*
- * placement group.
- * we encode this into one __le64.
+ * Placement group identifier (version 1): Identifies a placement group within
+ * the RADOS system. PGs group objects together for replication and distribution.
+ * This version is encoded into a single __le64 for efficient storage and comparison.
  */
 struct ceph_pg_v1 {
-	__le16 preferred; /* preferred primary osd */
-	__le16 ps;        /* placement seed */
-	__le32 pool;      /* object pool */
+	/* Preferred primary OSD for this PG */
+	__le16 preferred;
+	/* Placement seed for object distribution */
+	__le16 ps;
+	/* Pool identifier this PG belongs to */
+	__le32 pool;
 } __attribute__ ((packed));
 
 /*
@@ -104,18 +118,26 @@ static inline int ceph_stable_mod(int x, int b, int bmask)
 }
 
 /*
- * object layout - how a given object should be stored.
+ * Object layout metadata: Describes how a specific object should be stored
+ * and distributed within the RADOS cluster. Contains placement group mapping
+ * and striping information for optimal data distribution.
  */
 struct ceph_object_layout {
-	struct ceph_pg_v1 ol_pgid;   /* raw pg, with _full_ ps precision. */
-	__le32 ol_stripe_unit;    /* for per-object parity, if any */
+	/* Raw placement group ID with full placement seed precision */
+	struct ceph_pg_v1 ol_pgid;
+	/* Stripe unit size for per-object parity (erasure coding) */
+	__le32 ol_stripe_unit;
 } __attribute__ ((packed));
 
 /*
- * compound epoch+version, used by storage layer to serialize mutations
+ * Extended version metadata: Compound epoch and version number used by the
+ * storage layer to serialize mutations and ensure consistency. Combines
+ * cluster-wide epoch with object-specific version for total ordering.
  */
 struct ceph_eversion {
+	/* Object version number within the epoch */
 	__le64 version;
+	/* Cluster epoch number (map generation) */
 	__le32 epoch;
 } __attribute__ ((packed));
 
@@ -484,61 +506,101 @@ enum {
 };
 
 /*
- * an individual object operation.  each may be accompanied by some data
- * payload
+ * Individual OSD operation metadata: Wire format for a single operation within
+ * an OSD request. Each operation may be accompanied by data payload and contains
+ * operation-specific parameters in a discriminated union.
  */
 struct ceph_osd_op {
-	__le16 op;           /* CEPH_OSD_OP_* */
-	__le32 flags;        /* CEPH_OSD_OP_FLAG_* */
+	/* Operation type code (CEPH_OSD_OP_*) */
+	__le16 op;
+	/* Operation-specific flags (CEPH_OSD_OP_FLAG_*) */
+	__le32 flags;
+	/* Operation-specific parameters */
 	union {
+		/* Extent-based operations (read, write, truncate) */
 		struct {
+			/* Byte offset and length within object */
 			__le64 offset, length;
+			/* Truncation parameters */
 			__le64 truncate_size;
 			__le32 truncate_seq;
 		} __attribute__ ((packed)) extent;
+		/* Extended attribute operations */
 		struct {
+			/* Attribute name and value lengths */
 			__le32 name_len;
 			__le32 value_len;
+			/* Comparison operation type */
 			__u8 cmp_op;       /* CEPH_OSD_CMPXATTR_OP_* */
+			/* Comparison mode (string/numeric) */
 			__u8 cmp_mode;     /* CEPH_OSD_CMPXATTR_MODE_* */
 		} __attribute__ ((packed)) xattr;
+		/* Object class method invocation */
 		struct {
+			/* Class and method name lengths */
 			__u8 class_len;
 			__u8 method_len;
+			/* Number of method arguments */
 			__u8 argc;
+			/* Input data length */
 			__le32 indata_len;
 		} __attribute__ ((packed)) cls;
+		/* Placement group listing */
 		struct {
+			/* Listing cookie and count */
 			__le64 cookie, count;
 		} __attribute__ ((packed)) pgls;
+		/* Snapshot operations */
 	        struct {
+			/* Snapshot identifier */
 		        __le64 snapid;
 	        } __attribute__ ((packed)) snap;
+		/* Watch/notify operations */
 		struct {
+			/* Unique watch cookie */
 			__le64 cookie;
+			/* Version (deprecated) */
 			__le64 ver;     /* no longer used */
+			/* Watch operation type */
 			__u8 op;	/* CEPH_OSD_WATCH_OP_* */
+			/* Watch generation number */
 			__le32 gen;     /* registration generation */
 		} __attribute__ ((packed)) watch;
+		/* Notification operations */
 		struct {
+			/* Notification cookie */
 			__le64 cookie;
 		} __attribute__ ((packed)) notify;
+		/* Version assertion */
 		struct {
+			/* Unused field */
 			__le64 unused;
+			/* Expected version */
 			__le64 ver;
 		} __attribute__ ((packed)) assert_ver;
+		/* Object cloning operations */
 		struct {
+			/* Destination offset and length */
 			__le64 offset, length;
+			/* Source offset */
 			__le64 src_offset;
 		} __attribute__ ((packed)) clonerange;
+		/* Allocation hints for object sizing */
 		struct {
+			/* Expected final object size */
 			__le64 expected_object_size;
+			/* Expected write size */
 			__le64 expected_write_size;
+			/* Allocation hint flags */
 			__le32 flags;  /* CEPH_OSD_OP_ALLOC_HINT_FLAG_* */
 		} __attribute__ ((packed)) alloc_hint;
+		/* Copy from another object */
 		struct {
+			/* Source snapshot ID */
 			__le64 snapid;
+			/* Source object version */
 			__le64 src_version;
+			/* Copy operation flags */
 			__u8 flags; /* CEPH_OSD_COPY_FROM_FLAG_* */
 			/*
 			 * CEPH_OSD_OP_FLAG_FADVISE_*: fadvise flags
@@ -548,6 +610,7 @@ struct ceph_osd_op {
 			__le32 src_fadvise_flags;
 		} __attribute__ ((packed)) copy_from;
 	};
+	/* Length of accompanying data payload */
 	__le32 payload_len;
 } __attribute__ ((packed));
 
-- 
2.51.0


