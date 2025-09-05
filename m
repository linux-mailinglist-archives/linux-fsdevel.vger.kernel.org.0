Return-Path: <linux-fsdevel+bounces-60388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A1B46432
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9AE1CC5960
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC328C84F;
	Fri,  5 Sep 2025 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="3N9z5KR7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FEF289376
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102531; cv=none; b=SVK6ldB4H0zyLg53liSvFNrXB6CRem5IciHCCKZGAaw339huECIRYGkilUxayg2dd57LnaGyGoAt53DGnSyPa/0TIxMLvP56tgbzxtehkrFBZ0JPZNydZn/qJls8bPvY0JYtnnk/gA/ho+nT5+eD3Zm/zqzccir8X2Iodr8GbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102531; c=relaxed/simple;
	bh=ZbVYEE1pk1Tvsh2gv54E0odRnlDPvfAepzq7sKFqlmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbNMqn/Rb4h7qxs2gRNUsHuS/41VERpb12vWsqvmtu3txb1eGkYGWZkeXeOib1kGpb1wjUrPCuyB/mViaxh9X3lwfBDeFvCjHPHM6jXICUSQpVm266ipGwHnZKFWriX2O/orVFPTMcNSrikiLGntNTQs5+NCBK6vMQUBpo/vWhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=3N9z5KR7; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6089a13961cso66847d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102528; x=1757707328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CCBQwLX0qXHJmbzEMytj2Vya5AhPXwX7vVxzIVyo+8=;
        b=3N9z5KR7RmApJ+LB7SGpgWaysYGpL5K2vqUQ5BjYZPkJo6m1c4qHP5YfBallBWOpjO
         VgHfEKZSmKU0CqhRlN3KYEEGusl9HyLe4JznT24O4BZaRVOsnTNGTF+Oa4Yu0aS0Dyu0
         xIOoH81w6BT+o+oHy4L4AbFzhcDTneQwZbOhWNu7hoeSmreGoXM7f1pEhfg6+RMT+dBf
         itNDdkNZASoy3jk9DwrmJfzTdVsVRU7d6ehfHcXbZtZq68Soe0sBUsvQ6jCDXBHGF2gA
         vSVjpMQxlTk+02fXvUKyRCrcS5tBwTaDKV+Pu6gg7rY/9kPmAHOF7hg0e3R/+z6lselw
         MFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102528; x=1757707328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CCBQwLX0qXHJmbzEMytj2Vya5AhPXwX7vVxzIVyo+8=;
        b=oGZYJbqCPmOHDcRyQ7RhcvzjmhgXc5EooL4yB1VMjq6+K6CTy9l6x3yxIGH09vB1Xy
         s548SdVSVLZDbIrUpYYvH6CbO7WmDi6MbhyrJOw8Vc5t/fyz9FyL1uCfmUIinJ8UmKGm
         pyDK5YfLMQMNvPYyTc1lrR7K7uaWaqDYzAc0df8cGfYmzHGR42w0XNDA6FzWoOagycXW
         M0/H1LYOcVUSnlJR3fJwuRgHplRmb5ORLD62RlW67WzzsxeJR/HZCP62VvUb0VxBd0iK
         0eyK6xtBYjnSxFPQazza8QMPtTMviqY8KzVF90/ugzKcAeQ1+ZqvFS7vP73sgmymHhHo
         EyIw==
X-Forwarded-Encrypted: i=1; AJvYcCVyJjVoviMpM3K8tkoJshfBcxFqJFMkxh0dzK7kADl68bsJj6uG0wQD8bJWS1S/qmviGQx170aADgG5qHYj@vger.kernel.org
X-Gm-Message-State: AOJu0YwscmmXC77Xpv8wU22G8E2HbRv414YnhTfLa3tGe1qAZ1fjTrdt
	XwnTI+cguXBu1hSy7cC8/mdLl9zVomv7pw5b/oSQqEEPpx2a6QDmDrXcg5WLwUTp9cQ=
X-Gm-Gg: ASbGncuPw/16ednVnjttb7rNtRTTUjl86l9azS7ahO3wVllGEX9cnK8N7QyfVarpx1e
	2+cABQDT1mZNeL6iqy7vU7jpzod5V/difiI7C0jJ8NbTRu40vagRUlFFSKC9aEdaxCfCgvmUQZd
	dvXkq67ZXPu3x+w60fpmfk/ozkM/xI+d2WT6wOo4FRfDjB9etfdwaZVTpgzqgbm7BCOyb/A0w2K
	tX30c6zkCqtKJJbXNY/x/CfUf3oGvQBj/MclCspp7e4MqdkMyMuJYBQBhQ/kW5c7TH3eJQ3iTfS
	nxy5TItVB4yz7sSOpoTuMxEhscIHOLYT6hbP+feEuStDmTCSWmr3JbSbhrqaG3t9/+Uunx7XPpv
	1EKfrTZmEzzTftWAWuUhzZkMQUzXYbdIrSvA9lFRP
X-Google-Smtp-Source: AGHT+IH+Aqlz3Ecan6Uew9LwsT2opf1VA48gVCPOug1UIyeV5d7rY2Aqhs47/hMbEOSnx9J/KbYxCw==
X-Received: by 2002:a05:690e:d5c:b0:5f3:319c:ff04 with SMTP id 956f58d0204a3-610274a464emr232505d50.22.1757102528015;
        Fri, 05 Sep 2025 13:02:08 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:02:07 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 14/20] ceph: add comments to metadata structures in osd_client.h
Date: Fri,  5 Sep 2025 13:01:02 -0700
Message-ID: <20250905200108.151563-15-slava@dubeyko.com>
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

This patch adds comments for struct ceph_sparse_extent,
enum ceph_sparse_read_state, struct ceph_sparse_read,
struct ceph_osd, enum ceph_osd_data_type, struct ceph_osd_data,
struct ceph_osd_req_op, struct ceph_osd_request_target,
struct ceph_osd_request, struct ceph_request_redirect,
struct ceph_osd_reqid, struct ceph_blkin_trace_info,
struct ceph_osd_linger_request, struct ceph_watch_item,
struct ceph_spg_mapping, struct ceph_hobject_id,
struct ceph_osd_backoff, struct ceph_osd_client
in /include/linux/ceph/osd_client.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/osd_client.h | 407 +++++++++++++++++++++++++++-----
 1 file changed, 354 insertions(+), 53 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 50b14a5661c7..1278368b16fc 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -23,33 +23,48 @@ struct ceph_osd_request;
 struct ceph_osd_client;
 
 /*
- * completion callback for async writepages
+ * Completion callback for async operations: Called when OSD request completes
+ * to notify the submitter of success or failure. Used for writepages and other
+ * asynchronous I/O operations that need completion notification.
  */
 typedef void (*ceph_osdc_callback_t)(struct ceph_osd_request *);
 
 #define CEPH_HOMELESS_OSD	-1
 
 /*
- * A single extent in a SPARSE_READ reply.
+ * Sparse read extent metadata: Describes a single data extent in a SPARSE_READ reply.
+ * Sparse reads allow efficient retrieval of files with holes by only transferring
+ * data regions, skipping over sparse (zero) areas.
  *
  * Note that these come from the OSD as little-endian values. On BE arches,
  * we convert them in-place after receipt.
  */
 struct ceph_sparse_extent {
+	/* Offset of this extent within the object */
 	u64	off;
+	/* Length of data in this extent */
 	u64	len;
 } __packed;
 
-/* Sparse read state machine state values */
+/*
+ * Sparse read state machine values: Tracks the parsing progress through
+ * a SPARSE_READ reply message, which contains header, extent array, and data.
+ */
 enum ceph_sparse_read_state {
+	/* Reading sparse read reply header */
 	CEPH_SPARSE_READ_HDR	= 0,
+	/* Reading extent array (offset/length pairs) */
 	CEPH_SPARSE_READ_EXTENTS,
+	/* Reading data length field */
 	CEPH_SPARSE_READ_DATA_LEN,
+	/* Pre-processing before reading actual data */
 	CEPH_SPARSE_READ_DATA_PRE,
+	/* Reading the actual file data */
 	CEPH_SPARSE_READ_DATA,
 };
 
 /*
+ * Sparse read parser metadata: Tracks the state of parsing a SPARSE_READ reply.
  * A SPARSE_READ reply is a 32-bit count of extents, followed by an array of
  * 64-bit offset/length pairs, and then all of the actual file data
  * concatenated after it (sans holes).
@@ -60,324 +75,573 @@ enum ceph_sparse_read_state {
  * or if the caller doesn't.
  */
 struct ceph_sparse_read {
-	enum ceph_sparse_read_state	sr_state;    /* state machine state */
-	u64				sr_req_off;  /* orig request offset */
-	u64				sr_req_len;  /* orig request length */
-	u64				sr_pos;      /* current pos in buffer */
-	int				sr_index;    /* current extent index */
-	u32				sr_datalen;  /* length of actual data */
-	u32				sr_count;    /* extent count in reply */
-	int				sr_ext_len;  /* length of extent array */
-	struct ceph_sparse_extent	*sr_extent;  /* extent array */
+	/* Current state in the parsing state machine */
+	enum ceph_sparse_read_state	sr_state;
+	/* Original request offset for validation */
+	u64				sr_req_off;
+	/* Original request length for validation */
+	u64				sr_req_len;
+	/* Current position in the receive buffer */
+	u64				sr_pos;
+	/* Current extent being processed */
+	int				sr_index;
+	/* Total length of actual data (excluding holes) */
+	u32				sr_datalen;
+	/* Number of extents in the reply */
+	u32				sr_count;
+	/* Allocated length of extent array */
+	int				sr_ext_len;
+	/* Dynamic array of extent descriptors */
+	struct ceph_sparse_extent	*sr_extent;
 };
 
 /*
- * A given osd we're communicating with.
+ * OSD connection metadata: Represents a single Object Storage Daemon (OSD)
+ * that we're actively communicating with. Manages the network connection,
+ * pending requests, authentication, and sparse read state for this OSD.
  *
  * Note that the o_requests tree can be searched while holding the "lock" mutex
  * or the "o_requests_lock" spinlock. Insertion or removal requires both!
  */
 struct ceph_osd {
+	/* Reference counting for safe cleanup */
 	refcount_t o_ref;
+	/* Index of current sparse read operation */
 	int o_sparse_op_idx;
+	/* Back-reference to OSD client */
 	struct ceph_osd_client *o_osdc;
+	/* OSD identifier number in the cluster */
 	int o_osd;
+	/* OSD incarnation number for detecting restarts */
 	int o_incarnation;
+	/* Red-black tree node in osdc->osds tree */
 	struct rb_node o_node;
+	/* Network connection to this OSD */
 	struct ceph_connection o_con;
+	/* Protects request trees (fast path) */
 	spinlock_t o_requests_lock;
+	/* Tree of regular requests to this OSD */
 	struct rb_root o_requests;
+	/* Tree of linger requests (watches/notifies) */
 	struct rb_root o_linger_requests;
+	/* Backoff mappings by placement group */
 	struct rb_root o_backoff_mappings;
+	/* Backoff mappings by backoff ID */
 	struct rb_root o_backoffs_by_id;
+	/* LRU list node for idle OSD cleanup */
 	struct list_head o_osd_lru;
+	/* Authentication handshake state */
 	struct ceph_auth_handshake o_auth;
+	/* Time when this OSD should be considered for LRU eviction */
 	unsigned long lru_ttl;
+	/* Keepalive processing list */
 	struct list_head o_keepalive_item;
+	/* Serializes OSD operations (slow path) */
 	struct mutex lock;
+	/* Sparse read parsing state for this OSD */
 	struct ceph_sparse_read	o_sparse_read;
 };
 
 #define CEPH_OSD_SLAB_OPS	2
 #define CEPH_OSD_MAX_OPS	16
 
+/*
+ * OSD data container types: Defines the different ways data can be provided
+ * to OSD operations, allowing flexible memory management for different I/O patterns.
+ */
 enum ceph_osd_data_type {
+	/* No data attached */
 	CEPH_OSD_DATA_TYPE_NONE = 0,
+	/* Array of struct page pointers */
 	CEPH_OSD_DATA_TYPE_PAGES,
+	/* Ceph pagelist structure */
 	CEPH_OSD_DATA_TYPE_PAGELIST,
 #ifdef CONFIG_BLOCK
+	/* Block I/O bio structure */
 	CEPH_OSD_DATA_TYPE_BIO,
 #endif /* CONFIG_BLOCK */
+	/* Array of bio_vec structures */
 	CEPH_OSD_DATA_TYPE_BVECS,
+	/* Iterator over memory regions */
 	CEPH_OSD_DATA_TYPE_ITER,
 };
 
+/*
+ * OSD data container metadata: Flexible container for different types of data
+ * that can be sent to or received from OSDs. Supports various memory layouts
+ * for efficient I/O without unnecessary copying.
+ */
 struct ceph_osd_data {
+	/* Type of data container being used */
 	enum ceph_osd_data_type	type;
 	union {
+		/* Page array data container */
 		struct {
+			/* Array of page pointers */
 			struct page	**pages;
+			/* Total data length */
 			u64		length;
+			/* Alignment requirement for first page */
 			u32		alignment;
+			/* Pages allocated from mempool */
 			bool		pages_from_pool;
+			/* We own the pages and must free them */
 			bool		own_pages;
 		};
+		/* Ceph pagelist container */
 		struct ceph_pagelist	*pagelist;
 #ifdef CONFIG_BLOCK
+		/* Block I/O bio container */
 		struct {
+			/* Bio iterator position */
 			struct ceph_bio_iter	bio_pos;
+			/* Length of bio data */
 			u32			bio_length;
 		};
 #endif /* CONFIG_BLOCK */
+		/* Bio vector array container */
 		struct {
+			/* Bio vector iterator position */
 			struct ceph_bvec_iter	bvec_pos;
+			/* Number of bio vectors */
 			u32			num_bvecs;
 		};
+		/* Generic iterator over memory */
 		struct iov_iter		iter;
 	};
 };
 
+/*
+ * OSD request operation metadata: Describes a single operation within an OSD request.
+ * Each request can contain multiple operations that are executed atomically.
+ * Supports various operation types like read/write, class methods, xattrs, etc.
+ */
 struct ceph_osd_req_op {
-	u16 op;           /* CEPH_OSD_OP_* */
-	u32 flags;        /* CEPH_OSD_OP_FLAG_* */
-	u32 indata_len;   /* request */
-	u32 outdata_len;  /* reply */
+	/* Operation type (CEPH_OSD_OP_*) */
+	u16 op;
+	/* Operation flags (CEPH_OSD_OP_FLAG_*) */
+	u32 flags;
+	/* Length of input data */
+	u32 indata_len;
+	/* Length of expected output data */
+	u32 outdata_len;
+	/* Operation result/error code */
 	s32 rval;
 
+	/* Operation-specific parameters */
 	union {
+		/* Raw data input for simple operations */
 		struct ceph_osd_data raw_data_in;
+		/* Extent-based operations (read/write) */
 		struct {
+			/* Offset within object + length of extent */
 			u64 offset, length;
+			/* Truncation parameters */
 			u64 truncate_size;
 			u32 truncate_seq;
+			/* Sparse extent information */
 			int sparse_ext_cnt;
 			struct ceph_sparse_extent *sparse_ext;
+			/* Data payload */
 			struct ceph_osd_data osd_data;
 		} extent;
+		/* Extended attribute operations */
 		struct {
+			/* Attribute name and value lengths */
 			u32 name_len;
 			u32 value_len;
+			/* Comparison operation type */
 			__u8 cmp_op;       /* CEPH_OSD_CMPXATTR_OP_* */
+			/* Comparison mode */
 			__u8 cmp_mode;     /* CEPH_OSD_CMPXATTR_MODE_* */
+			/* Attribute data */
 			struct ceph_osd_data osd_data;
 		} xattr;
+		/* Object class method invocation */
 		struct {
+			/* Class and method names */
 			const char *class_name;
 			const char *method_name;
+			/* Method call data */
 			struct ceph_osd_data request_info;
 			struct ceph_osd_data request_data;
 			struct ceph_osd_data response_data;
+			/* Name lengths */
 			__u8 class_len;
 			__u8 method_len;
+			/* Input data length */
 			u32 indata_len;
 		} cls;
+		/* Watch operations for object monitoring */
 		struct {
+			/* Watch cookie for identification */
 			u64 cookie;
+			/* Watch operation type */
 			__u8 op;           /* CEPH_OSD_WATCH_OP_ */
+			/* Generation number */
 			u32 gen;
 		} watch;
+		/* Notify acknowledgment */
 		struct {
+			/* Acknowledgment data */
 			struct ceph_osd_data request_data;
 		} notify_ack;
+		/* Object notification */
 		struct {
+			/* Notification cookie */
 			u64 cookie;
+			/* Notification payload */
 			struct ceph_osd_data request_data;
 			struct ceph_osd_data response_data;
 		} notify;
+		/* List current watchers */
 		struct {
+			/* Watcher list response */
 			struct ceph_osd_data response_data;
 		} list_watchers;
+		/* Allocation hint for object sizing */
 		struct {
+			/* Expected object and write sizes */
 			u64 expected_object_size;
 			u64 expected_write_size;
+			/* Allocation flags */
 			u32 flags;  /* CEPH_OSD_OP_ALLOC_HINT_FLAG_* */
 		} alloc_hint;
+		/* Copy from another object */
 		struct {
+			/* Source snapshot ID */
 			u64 snapid;
+			/* Source object version */
 			u64 src_version;
+			/* Copy operation flags */
 			u8 flags;
+			/* Source fadvise flags */
 			u32 src_fadvise_flags;
+			/* Destination data */
 			struct ceph_osd_data osd_data;
 		} copy_from;
+		/* Assert object version */
 		struct {
+			/* Expected version */
 			u64 ver;
 		} assert_ver;
 	};
 };
 
+/*
+ * OSD request target metadata: Contains object location and placement group
+ * mapping information for routing requests to the correct OSD. Includes both
+ * the original target and the resolved placement information.
+ */
 struct ceph_osd_request_target {
+	/* Original object identifier */
 	struct ceph_object_id base_oid;
+	/* Original object locator (pool, namespace) */
 	struct ceph_object_locator base_oloc;
+	/* Resolved target object identifier */
 	struct ceph_object_id target_oid;
+	/* Resolved target object locator */
 	struct ceph_object_locator target_oloc;
 
-	struct ceph_pg pgid;               /* last raw pg we mapped to */
-	struct ceph_spg spgid;             /* last actual spg we mapped to */
+	/* Last raw placement group we mapped to */
+	struct ceph_pg pgid;
+	/* Last actual sharded placement group */
+	struct ceph_spg spgid;
+	/* Number of placement groups in pool */
 	u32 pg_num;
+	/* Bitmask for PG number calculation */
 	u32 pg_num_mask;
+	/* Acting OSD set for this PG */
 	struct ceph_osds acting;
+	/* Up OSD set for this PG */
 	struct ceph_osds up;
+	/* Replication size */
 	int size;
+	/* Minimum replicas required */
 	int min_size;
+	/* Use bitwise sorting for object names */
 	bool sort_bitwise;
+	/* Recovery can delete objects */
 	bool recovery_deletes;
 
-	unsigned int flags;                /* CEPH_OSD_FLAG_* */
+	/* Request flags (CEPH_OSD_FLAG_*) */
+	unsigned int flags;
+	/* Whether we used a replica OSD */
 	bool used_replica;
+	/* Request is paused */
 	bool paused;
 
+	/* OSD map epoch used for this mapping */
 	u32 epoch;
+	/* Last epoch we force-resent this request */
 	u32 last_force_resend;
 
+	/* Target OSD number */
 	int osd;
 };
 
-/* an in-flight request */
+/*
+ * In-flight OSD request metadata: Represents a complete request to an OSD,
+ * including target information, operations, timing, and completion handling.
+ * Tracks the full lifecycle from submission to completion.
+ */
 struct ceph_osd_request {
-	u64             r_tid;              /* unique for this client */
+	/* Unique transaction ID for this client */
+	u64             r_tid;
+	/* Red-black tree node for OSD's request tree */
 	struct rb_node  r_node;
-	struct rb_node  r_mc_node;          /* map check */
+	/* Red-black tree node for map check tree */
+	struct rb_node  r_mc_node;
+	/* Work item for completion processing */
 	struct work_struct r_complete_work;
+	/* Target OSD for this request */
 	struct ceph_osd *r_osd;
 
+	/* Request targeting and placement information */
 	struct ceph_osd_request_target r_t;
 #define r_base_oid	r_t.base_oid
 #define r_base_oloc	r_t.base_oloc
 #define r_flags		r_t.flags
 
+	/* Network messages for request and reply */
 	struct ceph_msg  *r_request, *r_reply;
-	u32               r_sent;      /* >0 if r_request is sending/sent */
+	/* >0 if r_request is sending/sent */
+	u32               r_sent;
 
-	/* request osd ops array  */
+	/* Number of operations in this request */
 	unsigned int		r_num_ops;
 
+	/* Overall result code for the request */
 	int               r_result;
 
+	/* Back-reference to OSD client */
 	struct ceph_osd_client *r_osdc;
+	/* Reference counting for safe cleanup */
 	struct kref       r_kref;
+	/* Request allocated from mempool */
 	bool              r_mempool;
-	bool		  r_linger;           /* don't resend on failure */
-	struct completion r_completion;       /* private to osd_client.c */
+	/* Linger request - don't resend on failure */
+	bool		  r_linger;
+	/* Completion notification (private to osd_client.c) */
+	struct completion r_completion;
+	/* Callback function for async completion */
 	ceph_osdc_callback_t r_callback;
 
-	struct inode *r_inode;         	      /* for use by callbacks */
-	struct list_head r_private_item;      /* ditto */
-	void *r_priv;			      /* ditto */
-
-	/* set by submitter */
-	u64 r_snapid;                         /* for reads, CEPH_NOSNAP o/w */
-	struct ceph_snap_context *r_snapc;    /* for writes */
-	struct timespec64 r_mtime;            /* ditto */
-	u64 r_data_offset;                    /* ditto */
-
-	/* internal */
-	u64 r_version;			      /* data version sent in reply */
+	/* Context information for callbacks */
+	struct inode *r_inode;
+	struct list_head r_private_item;
+	void *r_priv;
+
+	/* Request parameters set by submitter */
+	/* Snapshot ID for reads, CEPH_NOSNAP otherwise */
+	u64 r_snapid;
+	/* Snapshot context for writes */
+	struct ceph_snap_context *r_snapc;
+	/* Modification time for writes */
+	struct timespec64 r_mtime;
+	/* Data offset within object */
+	u64 r_data_offset;
+
+	/* Internal tracking fields */
+	/* Data version returned in reply */
+	u64 r_version;
+	/* Timestamp when sent or last checked */
 	unsigned long r_stamp;                /* jiffies, send or check time */
+	/* Timestamp when request started */
 	unsigned long r_start_stamp;          /* jiffies */
+	/* Latency measurement start time */
 	ktime_t r_start_latency;              /* ktime_t */
+	/* Latency measurement end time */
 	ktime_t r_end_latency;                /* ktime_t */
+	/* Number of send attempts */
 	int r_attempts;
+	/* Map epoch bound for "does not exist" errors */
 	u32 r_map_dne_bound;
 
+	/* Array of operations in this request */
 	struct ceph_osd_req_op r_ops[] __counted_by(r_num_ops);
 };
 
+/*
+ * Request redirect metadata: Contains the new object location when an OSD
+ * request is redirected to a different pool or namespace.
+ */
 struct ceph_request_redirect {
+	/* New object locator (pool, namespace) */
 	struct ceph_object_locator oloc;
 };
 
 /*
- * osd request identifier
+ * OSD request identifier metadata: Uniquely identifies a request across
+ * the cluster by combining client identity, incarnation, and transaction ID.
+ * Used for request deduplication and tracking.
  *
- * caller name + incarnation# + tid to unique identify this request
+ * Format: caller name + incarnation# + tid to uniquely identify this request
  */
 struct ceph_osd_reqid {
+	/* Client entity name (type + number) */
 	struct ceph_entity_name name;
+	/* Transaction ID */
 	__le64 tid;
+	/* Client incarnation number */
 	__le32 inc;
 } __packed;
 
+/*
+ * Blkin tracing metadata: Distributed tracing information for performance
+ * analysis and debugging. Compatible with Zipkin/Jaeger tracing systems.
+ */
 struct ceph_blkin_trace_info {
+	/* Unique trace identifier */
 	__le64 trace_id;
+	/* Span identifier within the trace */
 	__le64 span_id;
+	/* Parent span identifier */
 	__le64 parent_span_id;
 } __packed;
 
+/*
+ * Watch notification callback: Called when a watched object receives a notification.
+ * Provides the notification data and identifies the notifier.
+ */
 typedef void (*rados_watchcb2_t)(void *arg, u64 notify_id, u64 cookie,
 				 u64 notifier_id, void *data, size_t data_len);
+/*
+ * Watch error callback: Called when a watch encounters an error condition
+ * such as connection loss or object deletion.
+ */
 typedef void (*rados_watcherrcb_t)(void *arg, u64 cookie, int err);
 
+/*
+ * Long-running OSD request metadata: Represents watch and notify operations
+ * that persist beyond normal request completion. Handles connection recovery
+ * and maintains state for ongoing object monitoring.
+ */
 struct ceph_osd_linger_request {
+	/* Parent OSD client */
 	struct ceph_osd_client *osdc;
+	/* Unique linger request identifier */
 	u64 linger_id;
+	/* Registration has been committed */
 	bool committed;
-	bool is_watch;                  /* watch or notify */
+	/* True for watch, false for notify */
+	bool is_watch;
 
+	/* Target OSD for this linger request */
 	struct ceph_osd *osd;
+	/* Registration request */
 	struct ceph_osd_request *reg_req;
+	/* Keepalive ping request */
 	struct ceph_osd_request *ping_req;
+	/* When last ping was sent */
 	unsigned long ping_sent;
+	/* Watch validity expiration time */
 	unsigned long watch_valid_thru;
+	/* List of pending linger work items */
 	struct list_head pending_lworks;
 
+	/* Target object and placement information */
 	struct ceph_osd_request_target t;
+	/* Map epoch bound for "does not exist" errors */
 	u32 map_dne_bound;
 
+	/* Modification time */
 	struct timespec64 mtime;
 
+	/* Reference counting for safe cleanup */
 	struct kref kref;
+	/* Serializes linger request operations */
 	struct mutex lock;
-	struct rb_node node;            /* osd */
-	struct rb_node osdc_node;       /* osdc */
-	struct rb_node mc_node;         /* map check */
+	/* Red-black tree node in OSD's linger tree */
+	struct rb_node node;
+	/* Red-black tree node in OSDC's linger tree */
+	struct rb_node osdc_node;
+	/* Red-black tree node in map check tree */
+	struct rb_node mc_node;
+	/* List item for scanning operations */
 	struct list_head scan_item;
 
+	/* Completion synchronization */
 	struct completion reg_commit_wait;
 	struct completion notify_finish_wait;
+	/* Error codes */
 	int reg_commit_error;
 	int notify_finish_error;
 	int last_error;
 
+	/* Registration generation number */
 	u32 register_gen;
+	/* Notification identifier */
 	u64 notify_id;
 
+	/* Callback functions */
 	rados_watchcb2_t wcb;
 	rados_watcherrcb_t errcb;
+	/* Callback context data */
 	void *data;
 
+	/* Request data structures */
 	struct ceph_pagelist *request_pl;
 	struct page **notify_id_pages;
 
+	/* Reply handling */
 	struct page ***preply_pages;
 	size_t *preply_len;
 };
 
+/*
+ * Watch item metadata: Describes a single watcher on an object,
+ * including the client identity and network address.
+ */
 struct ceph_watch_item {
+	/* Watcher client entity name */
 	struct ceph_entity_name name;
+	/* Unique watch cookie */
 	u64 cookie;
+	/* Watcher's network address */
 	struct ceph_entity_addr addr;
 };
 
+/*
+ * Sharded placement group mapping metadata: Maps a sharded placement group
+ * to its associated backoff requests. Used for managing flow control when
+ * OSDs request clients to back off from certain operations.
+ */
 struct ceph_spg_mapping {
+	/* Red-black tree node for efficient lookup */
 	struct rb_node node;
+	/* Sharded placement group identifier */
 	struct ceph_spg spgid;
 
+	/* Tree of backoff requests for this PG */
 	struct rb_root backoffs;
 };
 
+/*
+ * RADOS object identifier metadata: Complete identification of an object
+ * in the RADOS system, including pool, namespace, name, and snapshot.
+ * Used for precise object addressing and comparison operations.
+ */
 struct ceph_hobject_id {
+	/* Object key for special objects */
 	void *key;
 	size_t key_len;
+	/* Object identifier string */
 	void *oid;
 	size_t oid_len;
+	/* Snapshot identifier */
 	u64 snapid;
+	/* Object hash value for placement */
 	u32 hash;
+	/* Maximum object marker */
 	u8 is_max;
+	/* Object namespace */
 	void *nspace;
 	size_t nspace_len;
+	/* Pool identifier */
 	s64 pool;
 
-	/* cache */
+	/* Cached bit-reversed hash for efficient comparisons */
 	u32 hash_reverse_bits;
 };
 
@@ -387,51 +651,88 @@ static inline void ceph_hoid_build_hash_cache(struct ceph_hobject_id *hoid)
 }
 
 /*
- * PG-wide backoff: [begin, end)
- * per-object backoff: begin == end
+ * OSD backoff metadata: Represents a request from an OSD for the client
+ * to temporarily cease operations on a range of objects. Used for flow
+ * control during recovery, rebalancing, or overload conditions.
+ *
+ * PG-wide backoff: [begin, end) covers a range
+ * per-object backoff: begin == end covers single object
  */
 struct ceph_osd_backoff {
+	/* Red-black tree node indexed by PG */
 	struct rb_node spg_node;
+	/* Red-black tree node indexed by backoff ID */
 	struct rb_node id_node;
 
+	/* Sharded placement group this backoff applies to */
 	struct ceph_spg spgid;
+	/* Unique backoff identifier */
 	u64 id;
+	/* Beginning of object range (inclusive) */
 	struct ceph_hobject_id *begin;
+	/* End of object range (exclusive) */
 	struct ceph_hobject_id *end;
 };
 
 #define CEPH_LINGER_ID_START	0xffff000000000000ULL
 
+/*
+ * OSD client metadata: Main interface for communicating with Ceph OSDs.
+ * Manages OSD connections, request routing, map updates, and provides
+ * high-level APIs for object operations, watches, and notifications.
+ */
 struct ceph_osd_client {
+	/* Parent Ceph client instance */
 	struct ceph_client     *client;
 
-	struct ceph_osdmap     *osdmap;       /* current map */
+	/* Current OSD cluster map */
+	struct ceph_osdmap     *osdmap;
+	/* Protects OSD client state */
 	struct rw_semaphore    lock;
 
-	struct rb_root         osds;          /* osds */
-	struct list_head       osd_lru;       /* idle osds */
+	/* Tree of active OSD connections */
+	struct rb_root         osds;
+	/* LRU list of idle OSD connections */
+	struct list_head       osd_lru;
+	/* Protects OSD LRU operations */
 	spinlock_t             osd_lru_lock;
+	/* Minimum map epoch for request processing */
 	u32		       epoch_barrier;
+	/* Placeholder OSD for unmapped requests */
 	struct ceph_osd        homeless_osd;
-	atomic64_t             last_tid;      /* tid of last request */
+	/* Last transaction ID assigned */
+	atomic64_t             last_tid;
+	/* Last linger request ID assigned */
 	u64                    last_linger_id;
-	struct rb_root         linger_requests; /* lingering requests */
+	/* Tree of active linger requests */
+	struct rb_root         linger_requests;
+	/* Requests pending map check */
 	struct rb_root         map_checks;
+	/* Linger requests pending map check */
 	struct rb_root         linger_map_checks;
+	/* Total number of active requests */
 	atomic_t               num_requests;
+	/* Number of homeless (unmapped) requests */
 	atomic_t               num_homeless;
+	/* Error code for aborting all requests */
 	int                    abort_err;
+	/* Work item for request timeout processing */
 	struct delayed_work    timeout_work;
+	/* Work item for OSD connection timeouts */
 	struct delayed_work    osds_timeout_work;
 #ifdef CONFIG_DEBUG_FS
+	/* Debug filesystem entry for monitoring */
 	struct dentry 	       *debugfs_file;
 #endif
 
+	/* Memory pool for request allocation */
 	mempool_t              *req_mempool;
 
+	/* Message pools for efficient memory management */
 	struct ceph_msgpool	msgpool_op;
 	struct ceph_msgpool	msgpool_op_reply;
 
+	/* Work queues for async processing */
 	struct workqueue_struct	*notify_wq;
 	struct workqueue_struct	*completion_wq;
 };
-- 
2.51.0


