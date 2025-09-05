Return-Path: <linux-fsdevel+bounces-60389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085A1B46434
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936B13B13E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9CC2D1F4A;
	Fri,  5 Sep 2025 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="hrYX5ZE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B857628BA95
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102532; cv=none; b=PSzdQYs2CTliP3vScFp3hCGX8e0Gzuiyc0bO6FqY3TLjSjprxC4DfpEjztVNs/bqq/ixF+JiyuFfvEFYLuS4T5aVWeTyi4XQ0BaG23FySbJxMPgXQe8Q5+PLn/fS0AJ6+EziKdk4zqOQgpazIevuW7wmocv98LJcClbqWA8zQDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102532; c=relaxed/simple;
	bh=1B9woH7VKruK+pEew6BR2oa587KbB+86PiWJjLXwxJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUC9oWHClU5EFDEgxk6hz6Xv0ea4JKIOxiO4IaNfMWtK1zDRVNLuG06Vm6oCRxo40iN6j+YivoasL66CnZkivZdco+ec017nsJ6rgjTuMscK1gumfkWyLROMVm7z0+JUpvi39LvlfayCJqKz4LsoJAAjzKUDSs0If81tAxUVguo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=hrYX5ZE5; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6032c696bd6so150174d50.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102530; x=1757707330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSt1NuFIwkOVeCkCJBg+dlqGdo7MQm9t18uNIJDmeQA=;
        b=hrYX5ZE5NNBfyITI2sXcy/NCoc8nM4iAgO8FLKozd4n/ay706Em3zZaiNx+2R3nsd2
         0b8NaF3diZAvAQpTsqef/322wXwJtuwltH1pKWgJ06Be2qwAJ5ZZuA22Mg0NreVDHwwa
         +3EYhr7HxZs/nIFF6VCdKDaZ6IP3SglHzol/tKRyE97Cj7gzLKbBFSjxcQ8pBL8QxlfB
         KssU7r4obAfcV34VXJV5wYXVzIuDXd0qpEou1KyLYbIDR8EB8UIc16mXzpCk1PAwFMf2
         MvIp8byi5PFUSxmT03F4J4aPBfaCWKNmg463rEVZ3o/PtbowErl4948Iowsr4rjs9edQ
         7aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102530; x=1757707330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSt1NuFIwkOVeCkCJBg+dlqGdo7MQm9t18uNIJDmeQA=;
        b=AchprNf3LeZY1s1+ue4Ca/QXsZS9aG35hKpcCbSgCzw6seM/PhWX8uB5v0cTtoiIvg
         476aR1rGDVLdHxtKuRnZoJau8gAtcFYju81J5/HJqHDGMMoK/ISbHEHkNJg6el3DKUtT
         q0KSUz23D2YuPthvlpAYrsO0Y7/GWMVHfQ+d4Pna6A3XyMZSGk3Jvhl9mjDQeZbzQpva
         suzlpsx9MUEl6TMQRgnr3kubSR4NUv2gH/vlglVemlG0NLRUz4y5uz0kipSFvVrMHO3v
         C3GhnlnoQKZZZR0sX+dfQLtrIvpyBAAkyowc6HoaMn/WK71lDGQN4dJffGRm7SIZF2QE
         GSzw==
X-Forwarded-Encrypted: i=1; AJvYcCXaQ0SwJ55J1ll2d+BWBcGPuTLGkEosRd30I0NGvNERdkPNRZhgSO3xw8+6AsnZJM8517Cu0ylnbaEQtJqZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOdxg7vCq6EKIt0fVH7xOPbXOmANb/8BJTG7T9+clPsx6f97V
	g1b97sQOGz6VytcGI3M+ezVONvTvfSIRtOKRmHtdh0cS26MfZLWHwNGDIpfAp9SvEoBanla/OYT
	X+4axT3c=
X-Gm-Gg: ASbGncsaozI1ro16esqbhoUfthXjzxrQ05bFXn4cnL8ETENnhA4y5wanCexMgw54rRT
	BYb7+rgBc0LauCcFchbHHLoPO83KDcYD65UpWwWb1AOrypt9aC4IAqu1ey/ygXzRlozN5jWe1/K
	Vn9xnEG05EQy66rIA8iLKsIRQU5T5a6X6M0s0lUGkMNjb+smZimmDqQOSxsoJEpNKBvVKa3PaR1
	XBjxcUTS0vR+rOaB7uGI6PQZcvogDnCFMB6jLRVkSTsJT1pJajiai4fbGWFjAMyJtJg/3HDDyqx
	WEFtqh+eKPF6KxeTF4k8CEI0LuTBqxqHTdBDXrYNdD4QV2qkjhZUHlovLjLNc912hou6qDLDVIP
	64T9hP3h3HdENi1bv0baPMXfMbyuYpLSJvzO3ljdGuNtabC7HJUU=
X-Google-Smtp-Source: AGHT+IFLwHFb8X6TvJLjvZz3RGr8LCPU3cmGX6GiPpda0laULEs80glPCbu6d99bsO3XvaJeJrVLfA==
X-Received: by 2002:a53:d883:0:b0:605:e7e3:ed05 with SMTP id 956f58d0204a3-6102e2e2df1mr183045d50.14.1757102529675;
        Fri, 05 Sep 2025 13:02:09 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:02:08 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 15/20] ceph: add comments to metadata structures in osdmap.h
Date: Fri,  5 Sep 2025 13:01:03 -0700
Message-ID: <20250905200108.151563-16-slava@dubeyko.com>
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

This patch adds comments for struct ceph_pg,
struct ceph_spg, struct ceph_pg_pool_info,
struct ceph_object_locator, struct ceph_object_id,
struct workspace_manager, struct ceph_pg_mapping,
struct ceph_osdmap, struct ceph_osds, struct crush_loc,
struct crush_loc_node in /include/linux/ceph/osdmap.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/osdmap.h | 124 ++++++++++++++++++++++++++++++++++--
 1 file changed, 118 insertions(+), 6 deletions(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 5553019c3f07..51ca13d18364 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -19,15 +19,29 @@
  * The map can be updated either via an incremental map (diff) describing
  * the change between two successive epochs, or as a fully encoded map.
  */
+/*
+ * Placement group identifier metadata: Identifies a placement group within
+ * the RADOS system. PGs group objects together for replication and distribution
+ * across OSDs using a deterministic mapping based on pool and placement seed.
+ */
 struct ceph_pg {
+	/* Pool identifier this PG belongs to */
 	uint64_t pool;
+	/* Placement seed for object distribution within the pool */
 	uint32_t seed;
 };
 
 #define CEPH_SPG_NOSHARD	-1
 
+/*
+ * Sharded placement group metadata: Extends placement group identification
+ * with shard information for erasure-coded pools. Each PG can be split
+ * into multiple shards for parallel processing and distribution.
+ */
 struct ceph_spg {
+	/* Base placement group identifier */
 	struct ceph_pg pgid;
+	/* Shard number within the PG (CEPH_SPG_NOSHARD for replicated pools) */
 	s8 shard;
 };
 
@@ -41,22 +55,42 @@ int ceph_spg_compare(const struct ceph_spg *lhs, const struct ceph_spg *rhs);
 							will set FULL too */
 #define CEPH_POOL_FLAG_NEARFULL		(1ULL << 11) /* pool is nearfull */
 
+/*
+ * Pool information metadata: Complete description of a RADOS storage pool
+ * including replication settings, placement group configuration, and tiering
+ * information. Contains all parameters needed for object placement decisions.
+ */
 struct ceph_pg_pool_info {
+	/* Red-black tree node for efficient lookup */
 	struct rb_node node;
+	/* Unique pool identifier */
 	s64 id;
+	/* Pool type (replicated, erasure-coded) */
 	u8 type; /* CEPH_POOL_TYPE_* */
+	/* Number of replicas or erasure coding width */
 	u8 size;
+	/* Minimum replicas required for I/O */
 	u8 min_size;
+	/* CRUSH rule for object placement */
 	u8 crush_ruleset;
+	/* Hash function for object name hashing */
 	u8 object_hash;
+	/* Last epoch when force resend was required */
 	u32 last_force_request_resend;
+	/* Number of placement groups and placement groups for placement */
 	u32 pg_num, pgp_num;
+	/* Bitmasks derived from pg_num and pgp_num */
 	int pg_num_mask, pgp_num_mask;
+	/* Read tier pool (for cache tiering) */
 	s64 read_tier;
+	/* Write tier pool (takes precedence for read+write) */
 	s64 write_tier; /* wins for read+write ops */
+	/* Pool status and behavior flags */
 	u64 flags; /* CEPH_POOL_FLAG_* */
+	/* Human-readable pool name */
 	char *name;
 
+	/* Previous full state (for map change handling) */
 	bool was_full;  /* for handle_one_map() */
 };
 
@@ -72,8 +106,15 @@ static inline bool ceph_can_shift_osds(struct ceph_pg_pool_info *pool)
 	}
 }
 
+/*
+ * Object locator metadata: Specifies the storage location for an object
+ * within the RADOS cluster. Combines pool identification with optional
+ * namespace for fine-grained object organization.
+ */
 struct ceph_object_locator {
+	/* Target pool ID (-1 for unspecified) */
 	s64 pool;
+	/* Optional namespace within the pool */
 	struct ceph_string *pool_ns;
 };
 
@@ -106,10 +147,17 @@ void ceph_oloc_destroy(struct ceph_object_locator *oloc);
  * Both inline and external buffers have space for a NUL-terminator,
  * which is carried around.  It's not required though - RADOS object
  * names don't have to be NUL-terminated and may contain NULs.
+ *
+ * Object identifier metadata: Flexible object naming with inline optimization.
+ * Uses inline storage for short names (common case) and dynamic allocation
+ * for longer names. Supports arbitrary byte sequences including NUL bytes.
  */
 struct ceph_object_id {
+	/* Pointer to object name (may point to inline_name) */
 	char *name;
+	/* Inline storage for short object names */
 	char inline_name[CEPH_OID_INLINE_LEN];
+	/* Length of object name in bytes */
 	int name_len;
 };
 
@@ -137,64 +185,105 @@ int ceph_oid_aprintf(struct ceph_object_id *oid, gfp_t gfp,
 		     const char *fmt, ...);
 void ceph_oid_destroy(struct ceph_object_id *oid);
 
+/*
+ * Workspace manager metadata: Manages a pool of compression workspaces
+ * for CRUSH map processing. Provides efficient allocation and reuse of
+ * workspaces to avoid frequent memory allocation during map calculations.
+ */
 struct workspace_manager {
+	/* List of idle workspaces ready for use */
 	struct list_head idle_ws;
+	/* Spinlock protecting workspace list operations */
 	spinlock_t ws_lock;
-	/* Number of free workspaces */
+	/* Number of free workspaces available */
 	int free_ws;
 	/* Total number of allocated workspaces */
 	atomic_t total_ws;
-	/* Waiters for a free workspace */
+	/* Wait queue for threads waiting for free workspace */
 	wait_queue_head_t ws_wait;
 };
 
+/*
+ * Placement group mapping override metadata: Allows administrators to override
+ * the default CRUSH-generated OSD mappings for specific placement groups.
+ * Supports various override types for operational flexibility.
+ */
 struct ceph_pg_mapping {
+	/* Red-black tree node for efficient lookup */
 	struct rb_node node;
+	/* Placement group this mapping applies to */
 	struct ceph_pg pgid;
 
+	/* Different types of mapping overrides */
 	union {
+		/* Temporary OSD set override */
 		struct {
+			/* Number of OSDs in override set */
 			int len;
+			/* Array of OSD IDs */
 			int osds[];
 		} pg_temp, pg_upmap;
+		/* Temporary primary OSD override */
 		struct {
+			/* Primary OSD ID */
 			int osd;
 		} primary_temp;
+		/* Item-by-item OSD remapping */
 		struct {
+			/* Number of from->to mappings */
 			int len;
+			/* Array of [from_osd, to_osd] pairs */
 			int from_to[][2];
 		} pg_upmap_items;
 	};
 };
 
+/*
+ * OSD cluster map metadata: Complete description of the RADOS cluster topology
+ * and configuration. Contains all information needed to locate objects, determine
+ * OSD health, and route requests. Updated with each cluster state change.
+ */
 struct ceph_osdmap {
+	/* Cluster filesystem identifier */
 	struct ceph_fsid fsid;
+	/* Map version number (monotonically increasing) */
 	u32 epoch;
+	/* Timestamps for map creation and modification */
 	struct ceph_timespec created, modified;
 
+	/* Global cluster flags */
 	u32 flags;         /* CEPH_OSDMAP_* */
 
+	/* OSD array size and state information */
 	u32 max_osd;       /* size of osd_state, _offload, _addr arrays */
+	/* Per-OSD state flags (exists, up, etc.) */
 	u32 *osd_state;    /* CEPH_OSD_* */
-	u32 *osd_weight;   /* 0 = failed, 0x10000 = 100% normal */
+	/* Per-OSD weight (0=failed, 0x10000=100% normal) */
+	u32 *osd_weight;
+	/* Per-OSD network addresses */
 	struct ceph_entity_addr *osd_addr;
 
+	/* Temporary PG to OSD mappings */
 	struct rb_root pg_temp;
 	struct rb_root primary_temp;
 
-	/* remap (post-CRUSH, pre-up) */
+	/* Post-CRUSH, pre-up remappings for load balancing */
 	struct rb_root pg_upmap;	/* PG := raw set */
 	struct rb_root pg_upmap_items;	/* from -> to within raw set */
 
+	/* Per-OSD primary affinity weights */
 	u32 *osd_primary_affinity;
 
+	/* Storage pool definitions */
 	struct rb_root pg_pools;
 	u32 pool_max;
 
-	/* the CRUSH map specifies the mapping of placement groups to
+	/* CRUSH map for object placement calculations.
+	 * The CRUSH map specifies the mapping of placement groups to
 	 * the list of osds that store+replicate them. */
 	struct crush_map *crush;
 
+	/* Workspace manager for CRUSH calculations */
 	struct workspace_manager crush_wsm;
 };
 
@@ -256,9 +345,17 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end, bool msgr2,
 					     struct ceph_osdmap *map);
 extern void ceph_osdmap_destroy(struct ceph_osdmap *map);
 
+/*
+ * OSD set metadata: Represents a set of OSDs that store replicas of a
+ * placement group. Contains the ordered list of OSDs and identifies
+ * the primary OSD responsible for coordinating operations.
+ */
 struct ceph_osds {
+	/* Array of OSD IDs in preference order */
 	int osds[CEPH_PG_MAX_SIZE];
+	/* Number of OSDs in the set */
 	int size;
+	/* Primary OSD ID (not array index) */
 	int primary; /* id, NOT index */
 };
 
@@ -312,14 +409,29 @@ bool ceph_pg_to_primary_shard(struct ceph_osdmap *osdmap,
 int ceph_pg_to_acting_primary(struct ceph_osdmap *osdmap,
 			      const struct ceph_pg *raw_pgid);
 
+/*
+ * CRUSH location constraint metadata: Specifies a location constraint
+ * for CRUSH map placement. Used to restrict object placement to specific
+ * parts of the cluster hierarchy (e.g., specific racks, hosts).
+ */
 struct crush_loc {
+	/* CRUSH hierarchy level type (e.g., "rack", "host") */
 	char *cl_type_name;
+	/* Name of the specific location within that type */
 	char *cl_name;
 };
 
+/*
+ * CRUSH location node metadata: Red-black tree node for efficient storage
+ * and lookup of CRUSH location constraints. Contains the location data
+ * inline for memory efficiency.
+ */
 struct crush_loc_node {
+	/* Red-black tree linkage */
 	struct rb_node cl_node;
-	struct crush_loc cl_loc;  /* pointers into cl_data */
+	/* Location constraint (pointers into cl_data) */
+	struct crush_loc cl_loc;
+	/* Inline storage for location strings */
 	char cl_data[];
 };
 
-- 
2.51.0


