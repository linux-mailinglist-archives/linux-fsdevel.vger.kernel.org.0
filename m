Return-Path: <linux-fsdevel+bounces-60380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F96B46421
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F107566D0B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AE42BF3F3;
	Fri,  5 Sep 2025 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="B31aU/zO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9A299937
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102519; cv=none; b=ZhEMu4AjO9v/Yabu5fwAtJw1jv1QDcADgdioPYLKLPdXBkifUhoGpJHce0NqpQPJwIdoh5tPtnqIgEGbLgVSvTO0j9fRHPJuzJlJfzxuWHFAmCTg19/Ois8CpmAKKiTc6+/523pvkGeVKIwImxrnynQC65l57+bizMfadKQ9/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102519; c=relaxed/simple;
	bh=DUONlMClBej/4Q7aDnXzksFwSsfbiETJ6aIYtfo+228=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hfe6pU3yMY+bAGw1j9Geg6q1t0QrjD082/vil8h2qe55SJxoCRUD3pG6/K5jHrAfUehVbEC6eFwxJzWn3dS7cqC+SZCy/KxCdAl/j7VXgZMBwl/xZjPhEHdJlHyfLaObVfwia5KWk2pEbAsFwGqfcpu68KwpulntT16gwZPsHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=B31aU/zO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-724b9ba6e65so22573877b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102515; x=1757707315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7crN+tXF8Nc63eUDV2ZzNDa06oYo5xRmcMwyTLC4Ev4=;
        b=B31aU/zOqTZJHh6HBjVpfzoiAFLMe1vRNyBLiNcZLMx0v58Nc3U1YDL6IHvhJdbNbC
         DsX5Q79D8Aw01+Bk6JOhg7LEQEbbFIOKP7HNdNaObcmKnrrE6K8mP0+JIgLgEmDl2KiQ
         o2tYZz7wWqaubdWKiufgSYLuSfv7e4WtfhOaRietib0pfUZeoT6Ub+Wi3AaCfkm5yzf3
         k4fKAtWxIRmYiAHE5CUh1wFAfbzIZCQMaaCz5EPnF/kN2daKCtq3GW6GHjesEw5tHY8r
         59IdAceavw3MSljeXMji0gh81fuBfClB/sA2cQzqIbbjeW/XP+rYjGMvStMqb39DJRHV
         76mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102515; x=1757707315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7crN+tXF8Nc63eUDV2ZzNDa06oYo5xRmcMwyTLC4Ev4=;
        b=cOp9B+UiVxqeGtvmcCrg4TehN1IihLLoiu5q8fpo40j0DEV/OFHwgD8WRXgnyNIIiu
         KcjmrDrp9INTpo3cxIB/4w/jLmGexriDJWfBGAFDnwq4yBHHDPkpTDOewYe/nQmA92pM
         zzk72rCHfVa4EoHfMMQS+woMUvBbCncYvC7CfB8pvOtsLeHYQcS0mRAqDAnx0Cni6Noi
         6lVvj/xd5AWuSWxOJD+DkF6GNtOrhYahseSfM74KhrVBazG8QZADLxaATDfkxuhahU0D
         NDiOFrdz1+nrqt/q6Ao8dMf6WBslRJAkWPbP46bCQSDFLoIA5M3QvYSvjsQ60O3CV6c2
         50og==
X-Forwarded-Encrypted: i=1; AJvYcCUAscNoAquRvhR2A0xKKq7SJdKEZTDhefXXGEt9QIjlB/D+gtudKJ1PoKG9AY3uusrQFot32lbOenJKS8Ko@vger.kernel.org
X-Gm-Message-State: AOJu0YzQIA1fO/ogIivQe3xM27NdNQozCJAxRH2RolPGobNxsmoxhxRb
	ibcukvsclCEGYT34lL01/CkMey5MsAFtfpEz1n3waO1qHNHUBAdD9LzFVAqxexIoJ+Y=
X-Gm-Gg: ASbGncvFNKvzdL2R5/skB4m50ao7dGL2mPiL+q6CjAmH79+/lUyOmQvc9SmogdUiHGA
	c6AAlbg5HlOWh8bftUC1iazyRlIkVrpUqVnY3kOVy+Y4Cxjn8g8IZwgKFyKREx11gimEzwtz14f
	H/pig1z49KvWzIfHx6547yq0jKCldOIQPyDAgT6Y6a+LcCb65wM62lgSXW6c1FD1LnHWIaML8JD
	ioWCJjRLY+gkaF77w3vSHmomLkbsQjnguWmlglMRI9u7Rlw+pDzdRKsCG3hjfy9CoZ3M1okml2Q
	ejmfsSuH7OW5IZKmB43ovghe7RfHJbfyXLHJALgFvPQjMhYafwL+n1VNQ/fCpYfvp3Z7Jdy6Bme
	ut1QG7tBK38eLH2K4RYboIUlW6KT/IsOGqLpNBP8V
X-Google-Smtp-Source: AGHT+IHGlR2pWisau/IYbj+mXJB/uXtvP5GPMkC1nSzMCJ2JCmP6d41VFr+z5a08tlbEuLu4F6QDSQ==
X-Received: by 2002:a05:690c:dce:b0:727:121e:fa40 with SMTP id 00721157ae682-727f3397e88mr1451017b3.21.1757102515006;
        Fri, 05 Sep 2025 13:01:55 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:01:54 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 06/20] ceph: add comments to metadata structures in ceph_fs.h
Date: Fri,  5 Sep 2025 13:00:54 -0700
Message-ID: <20250905200108.151563-7-slava@dubeyko.com>
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

This patch adds comments for struct ceph_file_layout_legacy,
struct ceph_file_layout, struct ceph_dir_layout,
struct ceph_mon_request_header, struct ceph_mon_statfs,
struct ceph_statfs, struct ceph_mon_statfs_reply,
struct ceph_mon_command, struct ceph_osd_getmap,
struct ceph_mds_getmap, struct ceph_client_mount,
struct ceph_mon_subscribe_item, struct ceph_mon_subscribe_ack,
struct ceph_mds_session_head, union ceph_mds_request_args,
union ceph_mds_request_args_ext, struct ceph_mds_request_head_legacy,
struct ceph_mds_request_head, struct ceph_mds_request_release,
struct ceph_mds_reply_head, struct ceph_frag_tree_split,
struct ceph_frag_tree_head, struct ceph_mds_reply_cap,
struct ceph_mds_reply_inode, struct ceph_mds_reply_lease,
struct ceph_mds_reply_dirfrag, struct ceph_filelock,
struct ceph_mds_caps, struct ceph_mds_cap_peer,
struct ceph_mds_cap_release, struct ceph_mds_cap_item,
struct ceph_mds_lease, struct ceph_mds_cap_reconnect,
struct ceph_mds_cap_reconnect_v1, struct ceph_mds_snaprealm_reconnect,
struct ceph_mds_snap_head, struct ceph_mds_snap_realm,
struct ceph_mds_quota in /include/linux/ceph/ceph_fs.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/ceph_fs.h | 792 +++++++++++++++++++++++------------
 1 file changed, 532 insertions(+), 260 deletions(-)

diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index c7f2c63b3bc3..8f3452439d97 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -35,36 +35,50 @@
 #define CEPH_MAX_MON   31
 
 /*
- * legacy ceph_file_layoute
+ * Legacy file layout metadata: Wire format for older file layout structures.
+ * Describes how a file's data is striped across RADOS objects and distributed
+ * across placement groups. Maintained for backward compatibility.
  */
 struct ceph_file_layout_legacy {
-	/* file -> object mapping */
-	__le32 fl_stripe_unit;     /* stripe unit, in bytes.  must be multiple
-				      of page size. */
-	__le32 fl_stripe_count;    /* over this many objects */
-	__le32 fl_object_size;     /* until objects are this big, then move to
-				      new objects */
-	__le32 fl_cas_hash;        /* UNUSED.  0 = none; 1 = sha256 */
-
-	/* pg -> disk layout */
-	__le32 fl_object_stripe_unit;  /* UNUSED.  for per-object parity, if any */
-
-	/* object -> pg layout */
-	__le32 fl_unused;       /* unused; used to be preferred primary for pg (-1 for none) */
-	__le32 fl_pg_pool;      /* namespace, crush ruleset, rep level */
+	/* File-to-object mapping parameters */
+	/* Stripe unit size in bytes (must be page-aligned) */
+	__le32 fl_stripe_unit;
+	/* Number of objects to stripe across */
+	__le32 fl_stripe_count;
+	/* Maximum object size before creating new objects */
+	__le32 fl_object_size;
+	/* Content-addressable storage hash (unused) */
+	__le32 fl_cas_hash;
+
+	/* Placement group to disk layout */
+	/* Per-object parity stripe unit (unused) */
+	__le32 fl_object_stripe_unit;
+
+	/* Object to placement group layout */
+	/* Unused field (was preferred primary PG) */
+	__le32 fl_unused;
+	/* Pool ID for namespace, CRUSH rules, replication level */
+	__le32 fl_pg_pool;
 } __attribute__ ((packed));
 
 struct ceph_string;
 /*
- * ceph_file_layout - describe data layout for a file/inode
+ * File layout metadata: Describes how a file's data is distributed across
+ * RADOS objects within a storage pool. Controls striping, object sizing,
+ * and namespace placement for optimal performance and data distribution.
  */
 struct ceph_file_layout {
-	/* file -> object mapping */
-	u32 stripe_unit;   /* stripe unit, in bytes */
-	u32 stripe_count;  /* over this many objects */
-	u32 object_size;   /* until objects are this big */
-	s64 pool_id;        /* rados pool id */
-	struct ceph_string __rcu *pool_ns; /* rados pool namespace */
+	/* File-to-object striping parameters */
+	/* Stripe unit size in bytes */
+	u32 stripe_unit;
+	/* Number of objects to stripe data across */
+	u32 stripe_count;
+	/* Maximum size of individual RADOS objects */
+	u32 object_size;
+	/* Target RADOS pool ID */
+	s64 pool_id;
+	/* Optional pool namespace (RCU-protected string) */
+	struct ceph_string __rcu *pool_ns;
 };
 
 extern int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);
@@ -75,8 +89,15 @@ extern void ceph_file_layout_to_legacy(struct ceph_file_layout *fl,
 
 #define CEPH_MIN_STRIPE_UNIT 65536
 
+/*
+ * Directory layout metadata: Describes how directory entries are distributed
+ * and hashed for efficient lookup and enumeration. Currently minimal with
+ * most fields reserved for future expansion.
+ */
 struct ceph_dir_layout {
-	__u8   dl_dir_hash;   /* see ceph_hash.h for ids */
+	/* Directory hash function ID (see ceph_hash.h) */
+	__u8   dl_dir_hash;
+	/* Reserved fields for future use */
 	__u8   dl_unused1;
 	__u16  dl_unused2;
 	__u32  dl_unused3;
@@ -172,63 +193,137 @@ enum {
 };
 
 
+/*
+ * Monitor request header metadata: Common header for all client requests
+ * to Ceph monitors. Includes version tracking and session identification
+ * for proper request sequencing and duplicate detection.
+ */
 struct ceph_mon_request_header {
+	/* Highest map version client currently has */
 	__le64 have_version;
+	/* Monitor rank for this session */
 	__le16 session_mon;
+	/* Transaction ID for this monitor session */
 	__le64 session_mon_tid;
 } __attribute__ ((packed));
 
+/*
+ * Ceph monitor statfs request structure
+ *
+ * Sent to the monitor to request filesystem statistics information.
+ * Can request stats for the entire cluster or for a specific data pool.
+ * The monitor responds with usage, capacity, and object count information.
+ */
 struct ceph_mon_statfs {
-	struct ceph_mon_request_header monhdr;
-	struct ceph_fsid fsid;
-	__u8 contains_data_pool;
-	__le64 data_pool;
+	struct ceph_mon_request_header monhdr; /* standard monitor request header */
+	struct ceph_fsid fsid;                 /* filesystem identifier */
+	__u8 contains_data_pool;               /* whether requesting pool-specific stats */
+	__le64 data_pool;                      /* specific pool ID (if contains_data_pool) */
 } __attribute__ ((packed));
 
+/*
+ * Filesystem statistics metadata: Reports storage usage and capacity
+ * information for a Ceph filesystem or pool. Used by statfs() system call.
+ */
 struct ceph_statfs {
-	__le64 kb, kb_used, kb_avail;
+	/* Total capacity in kilobytes */
+	__le64 kb;
+	/* Used space in kilobytes */
+	__le64 kb_used;
+	/* Available space in kilobytes */
+	__le64 kb_avail;
+	/* Total number of objects stored */
 	__le64 num_objects;
 } __attribute__ ((packed));
 
+/*
+ * Ceph monitor statfs reply structure
+ *
+ * Response from the monitor containing filesystem statistics information.
+ * Sent in response to a ceph_mon_statfs request, providing current usage,
+ * capacity, and object count data for the requested filesystem or pool.
+ */
 struct ceph_mon_statfs_reply {
-	struct ceph_fsid fsid;
-	__le64 version;
-	struct ceph_statfs st;
+	struct ceph_fsid fsid;         /* filesystem identifier */
+	__le64 version;                /* statistics version/timestamp */
+	struct ceph_statfs st;         /* actual filesystem statistics */
 } __attribute__ ((packed));
 
+/*
+ * Ceph monitor command structure
+ *
+ * Used to send administrative commands to the Ceph monitor. The command
+ * is specified as a text string that follows this header structure.
+ * Monitor responds with command results or error information.
+ */
 struct ceph_mon_command {
-	struct ceph_mon_request_header monhdr;
-	struct ceph_fsid fsid;
-	__le32 num_strs;         /* always 1 */
-	__le32 str_len;
-	char str[];
+	struct ceph_mon_request_header monhdr; /* standard monitor request header */
+	struct ceph_fsid fsid;                 /* filesystem identifier */
+	__le32 num_strs;                       /* number of command strings (always 1) */
+	__le32 str_len;                        /* length of command string */
+	char str[];                            /* command string (variable length) */
 } __attribute__ ((packed));
 
+/*
+ * Ceph OSD map request structure
+ *
+ * Sent to the monitor to request OSD map updates. The client specifies
+ * a starting epoch to receive incremental map updates from that point.
+ * Essential for maintaining current cluster topology and OSD status.
+ */
 struct ceph_osd_getmap {
-	struct ceph_mon_request_header monhdr;
-	struct ceph_fsid fsid;
-	__le32 start;
+	struct ceph_mon_request_header monhdr; /* standard monitor request header */
+	struct ceph_fsid fsid;                 /* filesystem identifier */
+	__le32 start;                          /* starting epoch for map updates */
 } __attribute__ ((packed));
 
+/*
+ * Ceph MDS map request structure
+ *
+ * Sent to the monitor to request MDS map updates. Contains information
+ * about active metadata servers, their states, and filesystem layout.
+ * Critical for clients to know which MDS to contact for operations.
+ */
 struct ceph_mds_getmap {
-	struct ceph_mon_request_header monhdr;
-	struct ceph_fsid fsid;
+	struct ceph_mon_request_header monhdr; /* standard monitor request header */
+	struct ceph_fsid fsid;                 /* filesystem identifier */
 } __attribute__ ((packed));
 
+/*
+ * Ceph client mount request structure
+ *
+ * Minimal structure sent to the monitor during client mount operations.
+ * Used to signal client presence and initiate the mount handshake with
+ * the monitor. Contains only the basic monitor request header.
+ */
 struct ceph_client_mount {
-	struct ceph_mon_request_header monhdr;
+	struct ceph_mon_request_header monhdr; /* standard monitor request header */
 } __attribute__ ((packed));
 
 #define CEPH_SUBSCRIBE_ONETIME    1  /* i want only 1 update after have */
 
+/*
+ * Ceph monitor subscription item
+ *
+ * Specifies subscription parameters for receiving map updates from the
+ * monitor. Used within subscription requests to indicate starting epoch
+ * and subscription behavior (one-time vs continuous updates).
+ */
 struct ceph_mon_subscribe_item {
-	__le64 start;
-	__u8 flags;
+	__le64 start;                          /* starting epoch/version for updates */
+	__u8 flags;                            /* subscription flags (CEPH_SUBSCRIBE_*) */
 } __attribute__ ((packed));
 
+/*
+ * Ceph monitor subscription acknowledgment
+ *
+ * Response from monitor confirming subscription requests. Indicates how long
+ * the subscription will remain active and confirms the filesystem ID.
+ * Used for managing subscription renewal timing.
+ */
 struct ceph_mon_subscribe_ack {
-	__le32 duration;         /* seconds */
-	struct ceph_fsid fsid;
+	__le32 duration;                       /* subscription duration in seconds */
+	struct ceph_fsid fsid;                 /* filesystem identifier */
 } __attribute__ ((packed));
 
 #define CEPH_FS_CLUSTER_ID_NONE  -1
@@ -306,11 +401,21 @@ enum {
 
 extern const char *ceph_session_op_name(int op);
 
+/*
+ * MDS session header metadata: Header for metadata server session messages.
+ * Manages the client-MDS session lifecycle including capability and lease limits.
+ */
 struct ceph_mds_session_head {
+	/* Session operation type */
 	__le32 op;
+	/* Session sequence number */
 	__le64 seq;
+	/* Message timestamp */
 	struct ceph_timespec stamp;
-	__le32 max_caps, max_leases;
+	/* Maximum capabilities client can hold */
+	__le32 max_caps;
+	/* Maximum directory entry leases */
+	__le32 max_leases;
 } __attribute__ ((packed));
 
 /* client_request */
@@ -410,78 +515,113 @@ extern const char *ceph_mds_op_name(int op);
 #define CEPH_O_DIRECTORY	00200000
 #define CEPH_O_NOFOLLOW		00400000
 
+/*
+ * Ceph MDS request arguments union
+ *
+ * Contains operation-specific arguments for different MDS operations.
+ * Each operation type has its own structure within the union, providing
+ * the specific parameters needed for that operation while sharing the
+ * same memory space efficiently.
+ */
 union ceph_mds_request_args {
+	/* Get inode attributes operation */
 	struct {
-		__le32 mask;                 /* CEPH_CAP_* */
+		__le32 mask;                 /* attribute mask (CEPH_CAP_*) */
 	} __attribute__ ((packed)) getattr;
+
+	/* Set inode attributes operation */
 	struct {
-		__le32 mode;
-		__le32 uid;
-		__le32 gid;
-		struct ceph_timespec mtime;
-		struct ceph_timespec atime;
-		__le64 size, old_size;       /* old_size needed by truncate */
-		__le32 mask;                 /* CEPH_SETATTR_* */
+		__le32 mode;                 /* file permissions */
+		__le32 uid;                  /* user ID */
+		__le32 gid;                  /* group ID */
+		struct ceph_timespec mtime;  /* modification time */
+		struct ceph_timespec atime;  /* access time */
+		__le64 size, old_size;       /* new and old file sizes */
+		__le32 mask;                 /* which attributes to set (CEPH_SETATTR_*) */
 	} __attribute__ ((packed)) setattr;
+
+	/* Read directory entries operation */
 	struct {
-		__le32 frag;                 /* which dir fragment */
-		__le32 max_entries;          /* how many dentries to grab */
-		__le32 max_bytes;
-		__le16 flags;
-		__le32 offset_hash;
+		__le32 frag;                 /* directory fragment to read */
+		__le32 max_entries;          /* maximum number of entries to return */
+		__le32 max_bytes;            /* maximum response size in bytes */
+		__le16 flags;                /* readdir operation flags */
+		__le32 offset_hash;          /* hash offset for pagination */
 	} __attribute__ ((packed)) readdir;
+
+	/* Create device node (mknod) operation */
 	struct {
-		__le32 mode;
-		__le32 rdev;
+		__le32 mode;                 /* file type and permissions */
+		__le32 rdev;                 /* device number (major/minor) */
 	} __attribute__ ((packed)) mknod;
+
+	/* Create directory (mkdir) operation */
 	struct {
-		__le32 mode;
+		__le32 mode;                 /* directory permissions */
 	} __attribute__ ((packed)) mkdir;
+
+	/* Open/create file operation */
 	struct {
-		__le32 flags;
-		__le32 mode;
-		__le32 stripe_unit;          /* layout for newly created file */
-		__le32 stripe_count;         /* ... */
-		__le32 object_size;
-		__le32 pool;
-		__le32 mask;                 /* CEPH_CAP_* */
-		__le64 old_size;
+		__le32 flags;                /* open flags (O_RDWR, O_CREAT, etc.) */
+		__le32 mode;                 /* file permissions (for creation) */
+		__le32 stripe_unit;          /* RADOS striping unit size */
+		__le32 stripe_count;         /* number of objects to stripe across */
+		__le32 object_size;          /* RADOS object size */
+		__le32 pool;                 /* RADOS pool ID */
+		__le32 mask;                 /* capability mask for new file */
+		__le64 old_size;             /* previous file size (for truncation) */
 	} __attribute__ ((packed)) open;
+
+	/* Set extended attributes operation */
 	struct {
-		__le32 flags;
-		__le32 osdmap_epoch; /* used for setting file/dir layouts */
+		__le32 flags;                /* xattr operation flags */
+		__le32 osdmap_epoch;         /* OSD map epoch for consistency */
 	} __attribute__ ((packed)) setxattr;
+
+	/* Set file/directory layout operation */
 	struct {
-		struct ceph_file_layout_legacy layout;
+		struct ceph_file_layout_legacy layout; /* striping layout */
 	} __attribute__ ((packed)) setlayout;
+
+	/* File locking operation */
 	struct {
-		__u8 rule; /* currently fcntl or flock */
-		__u8 type; /* shared, exclusive, remove*/
-		__le64 owner; /* owner of the lock */
-		__le64 pid; /* process id requesting the lock */
-		__le64 start; /* initial location to lock */
-		__le64 length; /* num bytes to lock from start */
-		__u8 wait; /* will caller wait for lock to become available? */
+		__u8 rule;                   /* lock rule (CEPH_LOCK_FCNTL/FLOCK) */
+		__u8 type;                   /* lock type (SHARED/EXCL/UNLOCK) */
+		__le64 owner;                /* lock owner identifier */
+		__le64 pid;                  /* process ID holding the lock */
+		__le64 start;                /* byte offset where lock begins */
+		__le64 length;               /* number of bytes to lock */
+		__u8 wait;                   /* whether to wait for lock */
 	} __attribute__ ((packed)) filelock_change;
+
+	/* Lookup by inode number operation */
 	struct {
-		__le32 mask;                 /* CEPH_CAP_* */
-		__le64 snapid;
-		__le64 parent;
-		__le32 hash;
+		__le32 mask;                 /* attribute mask for returned data */
+		__le64 snapid;               /* snapshot ID */
+		__le64 parent;               /* parent inode number */
+		__le32 hash;                 /* inode hash for verification */
 	} __attribute__ ((packed)) lookupino;
 } __attribute__ ((packed));
 
+/*
+ * Ceph MDS request arguments union (extended version)
+ *
+ * This union extends the original ceph_mds_request_args with support
+ * for newer protocol features. It maintains backward compatibility
+ * while adding extended functionality like birth time support.
+ */
 union ceph_mds_request_args_ext {
-	union ceph_mds_request_args old;
+	union ceph_mds_request_args old; /* legacy argument formats */
+	/* Extended setattr arguments with birth time support */
 	struct {
-		__le32 mode;
-		__le32 uid;
-		__le32 gid;
-		struct ceph_timespec mtime;
-		struct ceph_timespec atime;
-		__le64 size, old_size;       /* old_size needed by truncate */
-		__le32 mask;                 /* CEPH_SETATTR_* */
-		struct ceph_timespec btime;
+		__le32 mode;                 /* file permissions */
+		__le32 uid;                  /* user ID */
+		__le32 gid;                  /* group ID */
+		struct ceph_timespec mtime;  /* modification time */
+		struct ceph_timespec atime;  /* access time */
+		__le64 size, old_size;       /* current and previous file sizes */
+		__le32 mask;                 /* attribute mask (CEPH_SETATTR_*) */
+		struct ceph_timespec btime;  /* birth/creation time (extended) */
 	} __attribute__ ((packed)) setattr_ext;
 };
 
@@ -489,119 +629,183 @@ union ceph_mds_request_args_ext {
 #define CEPH_MDS_FLAG_WANT_DENTRY	2 /* want dentry in reply */
 #define CEPH_MDS_FLAG_ASYNC		4 /* request is asynchronous */
 
+/*
+ * Ceph MDS request message header (legacy version)
+ *
+ * This is the original MDS request header format used before protocol
+ * version 4. It lacks the version field and extended features present
+ * in the modern header. Used for backward compatibility with older
+ * MDS servers that don't support newer protocol features.
+ */
 struct ceph_mds_request_head_legacy {
-	__le64 oldest_client_tid;
-	__le32 mdsmap_epoch;           /* on client */
-	__le32 flags;                  /* CEPH_MDS_FLAG_* */
-	__u8 num_retry, num_fwd;       /* count retry, fwd attempts */
-	__le16 num_releases;           /* # include cap/lease release records */
-	__le32 op;                     /* mds op code */
-	__le32 caller_uid, caller_gid;
-	__le64 ino;                    /* use this ino for openc, mkdir, mknod,
-					  etc. (if replaying) */
-	union ceph_mds_request_args args;
+	__le64 oldest_client_tid;      /* oldest transaction ID from client */
+	__le32 mdsmap_epoch;           /* MDS map epoch client is using */
+	__le32 flags;                  /* request flags (CEPH_MDS_FLAG_*) */
+	__u8 num_retry, num_fwd;       /* retry and forward attempt counters */
+	__le16 num_releases;           /* number of cap/lease release records */
+	__le32 op;                     /* MDS operation code to perform */
+	__le32 caller_uid, caller_gid; /* credentials of the caller */
+	__le64 ino;                    /* inode number for replay operations */
+	union ceph_mds_request_args args; /* operation-specific arguments */
 } __attribute__ ((packed));
 
 #define CEPH_MDS_REQUEST_HEAD_VERSION  3
 
+/*
+ * Ceph MDS request message header
+ *
+ * Contains the header information for all MDS request messages, including
+ * operation type, client context, retry information, and operation-specific
+ * arguments. This structure has evolved over time with different versions.
+ */
 struct ceph_mds_request_head {
-	__le16 version;                /* struct version */
-	__le64 oldest_client_tid;
-	__le32 mdsmap_epoch;           /* on client */
-	__le32 flags;                  /* CEPH_MDS_FLAG_* */
-	__u8 num_retry, num_fwd;       /* legacy count retry and fwd attempts */
-	__le16 num_releases;           /* # include cap/lease release records */
-	__le32 op;                     /* mds op code */
-	__le32 caller_uid, caller_gid;
-	__le64 ino;                    /* use this ino for openc, mkdir, mknod,
-					  etc. (if replaying) */
-	union ceph_mds_request_args_ext args;
-
-	__le32 ext_num_retry;          /* new count retry attempts */
-	__le32 ext_num_fwd;            /* new count fwd attempts */
-
-	__le32 struct_len;             /* to store size of struct ceph_mds_request_head */
-	__le32 owner_uid, owner_gid;   /* used for OPs which create inodes */
-} __attribute__ ((packed));
-
-/* cap/lease release record */
+	__le16 version;                /* header structure version */
+	__le64 oldest_client_tid;      /* oldest transaction ID from client */
+	__le32 mdsmap_epoch;           /* MDS map epoch client is using */
+	__le32 flags;                  /* request flags (CEPH_MDS_FLAG_*) */
+	__u8 num_retry, num_fwd;       /* legacy retry and forward counters */
+	__le16 num_releases;           /* number of cap/lease release records */
+	__le32 op;                     /* MDS operation code to perform */
+	__le32 caller_uid, caller_gid; /* credentials of the caller */
+	__le64 ino;                    /* inode number for replay operations */
+	union ceph_mds_request_args_ext args; /* operation-specific arguments */
+
+	__le32 ext_num_retry;          /* extended retry attempt counter */
+	__le32 ext_num_fwd;            /* extended forward attempt counter */
+
+	__le32 struct_len;             /* size of this header structure */
+	__le32 owner_uid, owner_gid;   /* ownership for inode creation operations */
+} __attribute__ ((packed));
+
+/*
+ * Ceph MDS capability/lease release record
+ *
+ * Included in MDS requests to inform the MDS about capabilities or
+ * directory leases that the client is releasing. This allows the
+ * client to proactively return unused capabilities to reduce overhead.
+ */
 struct ceph_mds_request_release {
-	__le64 ino, cap_id;            /* ino and unique cap id */
-	__le32 caps, wanted;           /* new issued, wanted */
-	__le32 seq, issue_seq, mseq;
-	__le32 dname_seq;              /* if releasing a dentry lease, a */
-	__le32 dname_len;              /* string follows. */
+	__le64 ino, cap_id;            /* inode number and capability identifier */
+	__le32 caps, wanted;           /* capabilities being released/still wanted */
+	__le32 seq, issue_seq, mseq;   /* sequence numbers for capability tracking */
+	__le32 dname_seq;              /* directory name lease sequence number */
+	__le32 dname_len;              /* length of dentry name string (follows) */
 } __attribute__ ((packed));
 
 /* client reply */
+/*
+ * Ceph MDS reply message header
+ *
+ * Contains the header information for all MDS reply messages, including
+ * operation status, result codes, and flags indicating what additional
+ * data structures follow in the message payload.
+ */
 struct ceph_mds_reply_head {
-	__le32 op;
-	__le32 result;
-	__le32 mdsmap_epoch;
-	__u8 safe;                     /* true if committed to disk */
-	__u8 is_dentry, is_target;     /* true if dentry, target inode records
-					  are included with reply */
+	__le32 op;                     /* MDS operation that was performed */
+	__le32 result;                 /* operation result code (errno) */
+	__le32 mdsmap_epoch;           /* MDS map epoch when reply was sent */
+	__u8 safe;                     /* true if operation committed to disk */
+	__u8 is_dentry, is_target;     /* flags: dentry and target inode data included */
 } __attribute__ ((packed));
 
 /* one for each node split */
+/*
+ * Ceph directory fragment tree split record
+ *
+ * Describes how a directory fragment is split into smaller fragments.
+ * Each record specifies a fragment ID and the number of bits by which
+ * it should be split to create multiple sub-fragments.
+ */
 struct ceph_frag_tree_split {
-	__le32 frag;                   /* this frag splits... */
-	__le32 by;                     /* ...by this many bits */
+	__le32 frag;                   /* fragment identifier to split */
+	__le32 by;                     /* number of bits to split by */
 } __attribute__ ((packed));
 
+/*
+ * Ceph directory fragment tree header
+ *
+ * Contains the complete fragment tree structure for a directory, describing
+ * how the directory namespace is divided among multiple fragments. Large
+ * directories are split into fragments for load distribution across MDS nodes.
+ */
 struct ceph_frag_tree_head {
-	__le32 nsplits;                /* num ceph_frag_tree_split records */
-	struct ceph_frag_tree_split splits[];
+	__le32 nsplits;                /* number of fragment split records */
+	struct ceph_frag_tree_split splits[]; /* array of split records */
 } __attribute__ ((packed));
 
 /* capability issue, for bundling with mds reply */
+/*
+ * Ceph MDS reply capability structure
+ *
+ * Contains capability information included in MDS replies, specifying
+ * what capabilities are being granted to the client for an inode.
+ */
 struct ceph_mds_reply_cap {
-	__le32 caps, wanted;           /* caps issued, wanted */
-	__le64 cap_id;
-	__le32 seq, mseq;
-	__le64 realm;                  /* snap realm */
-	__u8 flags;                    /* CEPH_CAP_FLAG_* */
+	__le32 caps, wanted;           /* capabilities issued and wanted */
+	__le64 cap_id;                 /* unique capability identifier */
+	__le32 seq, mseq;              /* sequence and migration sequence numbers */
+	__le64 realm;                  /* snapshot realm this cap belongs to */
+	__u8 flags;                    /* capability flags (CEPH_CAP_FLAG_*) */
 } __attribute__ ((packed));
 
 #define CEPH_CAP_FLAG_AUTH	(1 << 0)  /* cap is issued by auth mds */
 #define CEPH_CAP_FLAG_RELEASE	(1 << 1)  /* release the cap */
 
-/* inode record, for bundling with mds reply */
+/*
+ * Ceph MDS reply inode structure
+ *
+ * Contains complete inode metadata bundled with MDS replies. This allows
+ * the MDS to send updated inode information along with operation results
+ * to keep clients synchronized with the current inode state.
+ */
 struct ceph_mds_reply_inode {
-	__le64 ino;
-	__le64 snapid;
-	__le32 rdev;
-	__le64 version;                /* inode version */
-	__le64 xattr_version;          /* version for xattr blob */
-	struct ceph_mds_reply_cap cap; /* caps issued for this inode */
-	struct ceph_file_layout_legacy layout;
-	struct ceph_timespec ctime, mtime, atime;
-	__le32 time_warp_seq;
-	__le64 size, max_size, truncate_size;
-	__le32 truncate_seq;
-	__le32 mode, uid, gid;
-	__le32 nlink;
-	__le64 files, subdirs, rbytes, rfiles, rsubdirs;  /* dir stats */
-	struct ceph_timespec rctime;
-	struct ceph_frag_tree_head fragtree;  /* (must be at end of struct) */
+	__le64 ino;                    /* inode number */
+	__le64 snapid;                 /* snapshot ID */
+	__le32 rdev;                   /* device number for special files */
+	__le64 version;                /* inode version number */
+	__le64 xattr_version;          /* extended attributes version */
+	struct ceph_mds_reply_cap cap; /* capabilities issued for this inode */
+	struct ceph_file_layout_legacy layout; /* file striping layout */
+	struct ceph_timespec ctime, mtime, atime; /* timestamps */
+	__le32 time_warp_seq;          /* time warp sequence number */
+	__le64 size, max_size, truncate_size; /* file size information */
+	__le32 truncate_seq;           /* truncate operation sequence */
+	__le32 mode, uid, gid;         /* file permissions and ownership */
+	__le32 nlink;                  /* number of hard links */
+	__le64 files, subdirs, rbytes, rfiles, rsubdirs; /* directory statistics */
+	struct ceph_timespec rctime;   /* recursive change time */
+	struct ceph_frag_tree_head fragtree; /* fragment tree (must be at end) */
 } __attribute__ ((packed));
 /* followed by frag array, symlink string, dir layout, xattr blob */
 
-/* reply_lease follows dname, and reply_inode */
+/*
+ * Ceph MDS reply lease structure
+ *
+ * Contains directory name lease information included in MDS replies.
+ * Directory leases allow clients to cache directory entries and negative
+ * lookups to improve performance by reducing round trips to the MDS.
+ */
 struct ceph_mds_reply_lease {
-	__le16 mask;            /* lease type(s) */
-	__le32 duration_ms;     /* lease duration */
-	__le32 seq;
+	__le16 mask;            /* lease type mask (CEPH_LEASE_*) */
+	__le32 duration_ms;     /* lease duration in milliseconds */
+	__le32 seq;             /* lease sequence number */
 } __attribute__ ((packed));
 
 #define CEPH_LEASE_VALID        (1 | 2) /* old and new bit values */
 #define CEPH_LEASE_PRIMARY_LINK 4       /* primary linkage */
 
+/*
+ * Ceph MDS reply directory fragment structure
+ *
+ * Contains information about directory fragment distribution across MDS nodes.
+ * Large directories are split into fragments that can be distributed across
+ * multiple MDS nodes for load balancing and scalability.
+ */
 struct ceph_mds_reply_dirfrag {
-	__le32 frag;            /* fragment */
-	__le32 auth;            /* auth mds, if this is a delegation point */
-	__le32 ndist;           /* number of mds' this is replicated on */
-	__le32 dist[];
+	__le32 frag;            /* directory fragment identifier */
+	__le32 auth;            /* authoritative MDS for this fragment */
+	__le32 ndist;           /* number of MDS nodes this fragment is replicated on */
+	__le32 dist[];          /* array of MDS node IDs holding replicas */
 } __attribute__ ((packed));
 
 #define CEPH_LOCK_FCNTL		1
@@ -614,13 +818,20 @@ struct ceph_mds_reply_dirfrag {
 #define CEPH_LOCK_EXCL     2
 #define CEPH_LOCK_UNLOCK   4
 
+/*
+ * Ceph file lock structure
+ *
+ * Represents advisory file locks (fcntl/flock) used for coordination
+ * between clients accessing the same file. The MDS mediates these locks
+ * across the cluster to ensure consistency.
+ */
 struct ceph_filelock {
-	__le64 start;/* file offset to start lock at */
-	__le64 length; /* num bytes to lock; 0 for all following start */
-	__le64 client; /* which client holds the lock */
-	__le64 owner; /* owner the lock */
-	__le64 pid; /* process id holding the lock on the client */
-	__u8 type; /* shared lock, exclusive lock, or unlock */
+	__le64 start;   /* file byte offset where lock begins */
+	__le64 length;  /* number of bytes to lock (0 = lock to EOF) */
+	__le64 client;  /* client ID that holds the lock */
+	__le64 owner;   /* lock owner identifier (typically file pointer) */
+	__le64 pid;     /* process ID holding the lock on the client */
+	__u8 type;      /* lock type: CEPH_LOCK_SHARED/EXCL/UNLOCK */
 } __attribute__ ((packed));
 
 
@@ -762,53 +973,76 @@ extern const char *ceph_cap_op_name(int op);
 #define CEPH_CLIENT_CAPS_PENDING_CAPSNAP	(1<<2)
 
 /*
- * caps message, used for capability callbacks, acks, requests, etc.
+ * Ceph MDS capability message structure
+ *
+ * This structure represents capability-related messages exchanged between
+ * the MDS and clients. Capabilities grant permissions to perform operations
+ * on inodes and include cached metadata to reduce round trips.
  */
 struct ceph_mds_caps {
-	__le32 op;                  /* CEPH_CAP_OP_* */
-	__le64 ino, realm;
-	__le64 cap_id;
-	__le32 seq, issue_seq;
-	__le32 caps, wanted, dirty; /* latest issued/wanted/dirty */
-	__le32 migrate_seq;
-	__le64 snap_follows;
-	__le32 snap_trace_len;
-
-	/* authlock */
-	__le32 uid, gid, mode;
-
-	/* linklock */
-	__le32 nlink;
-
-	/* xattrlock */
-	__le32 xattr_len;
-	__le64 xattr_version;
-
-	/* a union of non-export and export bodies. */
-	__le64 size, max_size, truncate_size;
-	__le32 truncate_seq;
-	struct ceph_timespec mtime, atime, ctime;
-	struct ceph_file_layout_legacy layout;
-	__le32 time_warp_seq;
+	__le32 op;                  /* capability operation (CEPH_CAP_OP_*) */
+	__le64 ino, realm;          /* inode number and snapshot realm */
+	__le64 cap_id;              /* unique capability identifier */
+	__le32 seq, issue_seq;      /* sequence numbers for ordering */
+	__le32 caps, wanted, dirty; /* capability bits: granted/requested/dirty */
+	__le32 migrate_seq;         /* sequence number for cap migration */
+	__le64 snap_follows;        /* snapshot context this cap follows */
+	__le32 snap_trace_len;      /* length of snapshot trace following */
+
+	/* File ownership and permissions */
+	__le32 uid, gid, mode;      /* owner user/group ID and file mode */
+
+	/* Link count */
+	__le32 nlink;               /* number of hard links to this inode */
+
+	/* Extended attributes */
+	__le32 xattr_len;           /* length of xattr blob */
+	__le64 xattr_version;       /* version of extended attributes */
+
+	/* File data and layout (union for export/non-export operations) */
+	__le64 size, max_size, truncate_size;  /* current/max/truncate file sizes */
+	__le32 truncate_seq;        /* truncate operation sequence number */
+	struct ceph_timespec mtime, atime, ctime;  /* file timestamps */
+	struct ceph_file_layout_legacy layout;     /* file striping layout */
+	__le32 time_warp_seq;       /* sequence for time warp detection */
 } __attribute__ ((packed));
 
+/*
+ * Ceph MDS capability peer information structure
+ *
+ * This structure contains information about a capability at a peer MDS,
+ * used during capability import/export operations when capabilities are
+ * migrated between different MDS nodes.
+ */
 struct ceph_mds_cap_peer {
-	__le64 cap_id;
-	__le32 issue_seq;
-	__le32 mseq;
-	__le32 mds;
-	__u8   flags;
+	__le64 cap_id;		/* capability ID at the peer MDS */
+	__le32 issue_seq;	/* issue sequence number at peer MDS */
+	__le32 mseq;		/* migration sequence number at peer MDS */
+	__le32 mds;		/* MDS number of the peer */
+	__u8   flags;		/* capability flags at peer MDS */
 } __attribute__ ((packed));
 
-/* cap release msg head */
+/*
+ * Ceph MDS capability release message header
+ *
+ * This structure forms the header of a capability release message sent from
+ * client to MDS to inform that the client is releasing (giving up) capabilities
+ * on one or more inodes. The message contains a list of cap_item structures.
+ */
 struct ceph_mds_cap_release {
-	__le32 num;                /* number of cap_items that follow */
+	__le32 num;                /* number of ceph_mds_cap_item entries following */
 } __attribute__ ((packed));
 
+/*
+ * Ceph MDS capability release item
+ *
+ * Represents a single capability being released by the client. Multiple
+ * cap items can be batched together in a single cap release message.
+ */
 struct ceph_mds_cap_item {
-	__le64 ino;
-	__le64 cap_id;
-	__le32 migrate_seq, issue_seq;
+	__le64 ino;                /* inode number of the file */
+	__le64 cap_id;             /* unique capability identifier */
+	__le32 migrate_seq, issue_seq; /* migration and issue sequence numbers */
 } __attribute__ ((packed));
 
 #define CEPH_MDS_LEASE_REVOKE           1  /*    mds  -> client */
@@ -818,42 +1052,68 @@ struct ceph_mds_cap_item {
 
 extern const char *ceph_lease_op_name(int o);
 
-/* lease msg header */
+/*
+ * Ceph MDS lease message structure
+ *
+ * This structure represents directory name lease messages exchanged between
+ * MDS and clients. Directory leases grant clients permission to cache
+ * directory contents and negative dentries to improve performance.
+ */
 struct ceph_mds_lease {
-	__u8 action;            /* CEPH_MDS_LEASE_* */
-	__le16 mask;            /* which lease */
-	__le64 ino;
-	__le64 first, last;     /* snap range */
-	__le32 seq;
-	__le32 duration_ms;     /* duration of renewal */
+	__u8 action;            /* lease action (CEPH_MDS_LEASE_*) */
+	__le16 mask;            /* which lease type is being acted upon */
+	__le64 ino;             /* inode number of parent directory */
+	__le64 first, last;     /* snapshot range for the lease */
+	__le32 seq;             /* lease sequence number for ordering */
+	__le32 duration_ms;     /* lease duration in milliseconds (for renewals) */
 } __attribute__ ((packed));
 /* followed by a __le32+string for dname */
 
-/* client reconnect */
+/*
+ * Ceph MDS capability reconnect structure (version 2)
+ *
+ * Sent during MDS session reconnection to restore capability state
+ * after a session has been lost. This allows the client to inform
+ * the MDS about capabilities it believes it holds.
+ */
 struct ceph_mds_cap_reconnect {
-	__le64 cap_id;
-	__le32 wanted;
-	__le32 issued;
-	__le64 snaprealm;
-	__le64 pathbase;        /* base ino for our path to this ino */
-	__le32 flock_len;       /* size of flock state blob, if any */
+	__le64 cap_id;          /* unique capability identifier */
+	__le32 wanted;          /* capabilities the client wants */
+	__le32 issued;          /* capabilities the client believes are issued */
+	__le64 snaprealm;       /* snapshot realm this inode belongs to */
+	__le64 pathbase;        /* base inode number for path reconstruction */
+	__le32 flock_len;       /* size of file lock state blob following */
 } __attribute__ ((packed));
 /* followed by flock blob */
 
+/*
+ * Ceph MDS capability reconnect structure (version 1)
+ *
+ * Legacy version of the capability reconnect structure used for
+ * backwards compatibility with older MDS versions. Contains
+ * additional file metadata fields not present in version 2.
+ */
 struct ceph_mds_cap_reconnect_v1 {
-	__le64 cap_id;
-	__le32 wanted;
-	__le32 issued;
-	__le64 size;
-	struct ceph_timespec mtime, atime;
-	__le64 snaprealm;
-	__le64 pathbase;        /* base ino for our path to this ino */
+	__le64 cap_id;          /* unique capability identifier */
+	__le32 wanted;          /* capabilities the client wants */
+	__le32 issued;          /* capabilities the client believes are issued */
+	__le64 size;            /* file size */
+	struct ceph_timespec mtime, atime; /* file modification and access times */
+	__le64 snaprealm;       /* snapshot realm this inode belongs to */
+	__le64 pathbase;        /* base inode number for path reconstruction */
 } __attribute__ ((packed));
 
+/*
+ * Ceph MDS snapshot realm reconnect structure
+ *
+ * Sent during MDS session reconnection to restore snapshot realm
+ * hierarchy information. This helps the MDS reconstruct the client's
+ * view of snapshot realms after a session interruption.
+ */
 struct ceph_mds_snaprealm_reconnect {
-	__le64 ino;     /* snap realm base */
-	__le64 seq;     /* snap seq for this snap realm */
-	__le64 parent;  /* parent realm */
+	__le64 ino;     /* inode number of snapshot realm root directory */
+	__le64 seq;     /* sequence number of this snapshot realm */
+	__le64 parent;  /* inode number of parent snapshot realm */
 } __attribute__ ((packed));
 
 /*
@@ -868,44 +1128,56 @@ enum {
 
 extern const char *ceph_snap_op_name(int o);
 
-/* snap msg header */
+/*
+ * Ceph MDS snapshot message header
+ *
+ * This structure forms the header for snapshot-related messages from the MDS,
+ * containing operation type and metadata about snapshot realm operations.
+ */
 struct ceph_mds_snap_head {
-	__le32 op;                /* CEPH_SNAP_OP_* */
-	__le64 split;             /* ino to split off, if any */
-	__le32 num_split_inos;    /* # inos belonging to new child realm */
-	__le32 num_split_realms;  /* # child realms udner new child realm */
-	__le32 trace_len;         /* size of snap trace blob */
+	__le32 op;                /* snapshot operation type (CEPH_SNAP_OP_*) */
+	__le64 split;             /* inode number to split off into new realm */
+	__le32 num_split_inos;    /* number of inodes belonging to new child realm */
+	__le32 num_split_realms;  /* number of child realms under new child realm */
+	__le32 trace_len;         /* size of the snapshot trace blob following */
 } __attribute__ ((packed));
 /* followed by split ino list, then split realms, then the trace blob */
 
 /*
- * encode info about a snaprealm, as viewed by a client
+ * Ceph MDS snapshot realm information structure
+ *
+ * Encodes information about a snapshot realm as viewed by a client.
+ * A snapshot realm represents a subtree of the filesystem that shares
+ * the same snapshot history and can be snapshotted as a unit.
  */
 struct ceph_mds_snap_realm {
-	__le64 ino;           /* ino */
-	__le64 created;       /* snap: when created */
-	__le64 parent;        /* ino: parent realm */
-	__le64 parent_since;  /* snap: same parent since */
-	__le64 seq;           /* snap: version */
-	__le32 num_snaps;
-	__le32 num_prior_parent_snaps;
+	__le64 ino;           /* inode number of the realm root directory */
+	__le64 created;       /* snapshot ID when this realm was created */
+	__le64 parent;        /* inode number of parent realm (0 if root) */
+	__le64 parent_since;  /* snapshot ID since realm had same parent */
+	__le64 seq;           /* sequence number for realm version/updates */
+	__le32 num_snaps;     /* number of snapshots in this realm */
+	__le32 num_prior_parent_snaps; /* number of parent snapshots before split */
 } __attribute__ ((packed));
 /* followed by my snap list, then prior parent snap list */
 
 /*
- * quotas
+ * Ceph MDS quota information structure
+ *
+ * This structure represents quota-related metadata sent from the MDS
+ * to update directory quota limits and current usage statistics.
  */
 struct ceph_mds_quota {
-	__le64 ino;		/* ino */
-	struct ceph_timespec rctime;
-	__le64 rbytes;		/* dir stats */
-	__le64 rfiles;
-	__le64 rsubdirs;
-	__u8 struct_v;		/* compat */
-	__u8 struct_compat;
-	__le32 struct_len;
-	__le64 max_bytes;	/* quota max. bytes */
-	__le64 max_files;	/* quota max. files */
+	__le64 ino;			/* inode number of the directory */
+	struct ceph_timespec rctime;	/* recursive change time */
+	__le64 rbytes;			/* recursive bytes used in directory tree */
+	__le64 rfiles;			/* recursive file count in directory tree */
+	__le64 rsubdirs;		/* recursive subdirectory count */
+	__u8 struct_v;			/* structure version for compatibility */
+	__u8 struct_compat;		/* compatibility version */
+	__le32 struct_len;		/* length of this structure */
+	__le64 max_bytes;		/* quota limit: maximum bytes allowed */
+	__le64 max_files;		/* quota limit: maximum files allowed */
 } __attribute__ ((packed));
 
 #endif
-- 
2.51.0


