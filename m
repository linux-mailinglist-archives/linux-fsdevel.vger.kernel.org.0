Return-Path: <linux-fsdevel+bounces-60383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C4CB46427
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD14A3A67C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FA42C3248;
	Fri,  5 Sep 2025 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="h94gPnyn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138827B50F
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102522; cv=none; b=tjZQ0Sz9K1kaxyMiBZymu9OA3THXDy0mT/8zGH26M3+46LFWSDJ/3kOmcTKlGPesJF1EjHj5Y8nQXud/Ninc/amhoSzJ8npNwiJmmoLR9N1BQT7VoDn+ND/S+yBzyo9pLPTnTa6OYzLwEpNbkeiQ4ig5XUGw18v2a7/RdCN1p68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102522; c=relaxed/simple;
	bh=/dn/Tuk5kcGGkCpaBhVSSD0/pN7u2RjuGUnkHEb46v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOufPAboivGT9KjoRW3C6Z7mOeyFP5Nev9hKC8xvcaQKx4sAKUTeFkZ1HxA6rgiSzgWtd+Mp2WHcpuLfGZUPLmVh9lI1s46uOmOnqjfHWdPK3yQNAbHMdaLs5xRuw2rKbWTxYZ/jDaUDbHF4BninrTJhgAyjgtkKrbZzGyhoKBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=h94gPnyn; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-60f4678ce9eso57883d50.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102520; x=1757707320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp1sT7Zh9S4RLRqp90SEVAPvKSW6mVlWCK6rmkV3qVY=;
        b=h94gPnyn71J1La1powzayv540f/tbdOl9O+AO9fSFkFR1vBgKMIANfe8aT6GuYuvyW
         p8f5eizmi1uNW4xXETw4TYxj/00i38duwBHjsBSeDZM6O/CAqCuqQW1MzHaQB9gwrXTO
         KpAmmsKjvDttc6eOSECsskWjBc4dQOG2MFG8liMxtYwhAls77AzmxTMUWsgRaWJbHFZG
         ziL9mau0CFVQoWbOy3d0wLvy+BIP5/HxBVqWppzKoIZ4skByHeeDZJeNHttaeBuy2hat
         bgpZiWDXvUgllJghiOJ/cndFybycwjsYlh9ZfBY93uZnhPQW+y+F338x+be/Ib4zn/ec
         j6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102520; x=1757707320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp1sT7Zh9S4RLRqp90SEVAPvKSW6mVlWCK6rmkV3qVY=;
        b=ie6Wd/fQ7TWSiGl0gDs+E3yTGcxly3OE1CAnu3DLSRV4JhquqoZbbS4N045s4PDrkJ
         URqhKe6pVvQ1mUWpKZzcmrONlClo51C/SYQKxc28zfV9MjrnIV/4hda0WnmQhjt7x4Ht
         q6bWV6bve2iEYi53i10f4RUA0Xp2dNfyGw9qO55Dq2ATSqGUZ1xQcz0gpAXCzWtJg6Jx
         zu0vABBFQQLf4eFsMu/rCZEUlDFchRFUUDI2tEpNDRD5hp+yojmtDe8dBrz4r9jNkvo1
         fBhWoPxplMvKDFr9dv29M/on3GbjFVUFusxzB1RHsvtn9JgC3a+nJ96Pri4e8vCyVnDL
         tolA==
X-Forwarded-Encrypted: i=1; AJvYcCWiZZi7vUfvy7qjvgSMXyPm2oRlrFP+kIarEllTDrkpAa9qPLv7XKZBdQ0k+yg5GXojigU2DFCC7Du6fmfr@vger.kernel.org
X-Gm-Message-State: AOJu0YzWUFqM1XMgyoZ9n11/dkQvYtV6yToLoZMvvgeoEtotGJEPHUAw
	rsLHRPD3AUtfLdu2mzlvoQEaxSrPWhuHJs5mrdx4Ro/WQs1YGfOkah4tJo/c6xAbwuI=
X-Gm-Gg: ASbGnctSI4ReScvuo/aF4Owr/vNTG0lljY+LT7vGTdLnfpakTnwumtD7c62PNgxYriy
	n4nxqzaL9M9U9QE3rlGw9EyX4mQg8cmqnd/PlgGUZEdKpxe45RC6+jnXr+R3t2z+XjWv/xTvolN
	tkY2UO+67FmG2XWhXuehFTpX9+uG7vrW9PwpjHyRE2Lenkc3MU678Tx2raA2aVcat0zRwdhZwnX
	ltftQ/TSdLIt1V8VsBm71yd8tdJVUvz9E7dvRRgYQTcr+FudWXAL7dUiZyQlN/T4881jZ6xcajd
	n2Vn0zo2T2RvnadpQhAMlSmoF7cN3EqhnYeJkCKalqkavV2whD48KVx1gilxVc0ApogE0QlOfbZ
	+tCq52C1t/9EBvSEc+TNiXtHc1uojWjC7f6e8Xm7l
X-Google-Smtp-Source: AGHT+IEGC51m8Wi+RuAgP+jhr8wuNvs245PwOZD73y5E7J7D31ss06oENrFKZt3HGARwftb+beyx+Q==
X-Received: by 2002:a05:690e:d4f:b0:5f3:315d:8fed with SMTP id 956f58d0204a3-6102268511bmr220675d50.8.1757102519945;
        Fri, 05 Sep 2025 13:01:59 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:01:59 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 09/20] ceph: add comments to metadata structures in libceph.h
Date: Fri,  5 Sep 2025 13:00:57 -0700
Message-ID: <20250905200108.151563-10-slava@dubeyko.com>
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

This patch adds comments for struct ceph_options,
struct ceph_client, struct ceph_snap_context
in /include/linux/ceph/libceph.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/libceph.h | 50 ++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 733e7f93db66..f7edef4fcc54 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -44,15 +44,29 @@
 #define ceph_test_opt(client, opt) \
 	(!!((client)->options->flags & CEPH_OPT_##opt))
 
+/*
+ * Ceph client options metadata: Configuration parameters for connecting to
+ * and operating with a Ceph cluster. Contains network settings, timeouts,
+ * authentication details, and cluster topology information.
+ */
 struct ceph_options {
+	/* Feature and behavior flags (CEPH_OPT_*) */
 	int flags;
+	/* Cluster filesystem identifier */
 	struct ceph_fsid fsid;
+	/* Client's network address */
 	struct ceph_entity_addr my_addr;
+	/* Timeout for initial cluster connection */
 	unsigned long mount_timeout;		/* jiffies */
+	/* How long to keep idle OSD connections */
 	unsigned long osd_idle_ttl;		/* jiffies */
+	/* OSD keepalive message interval */
 	unsigned long osd_keepalive_timeout;	/* jiffies */
+	/* Timeout for OSD requests (0 = no timeout) */
 	unsigned long osd_request_timeout;	/* jiffies */
+	/* Read from replica policy flags */
 	u32 read_from_replica;  /* CEPH_OSD_FLAG_BALANCE/LOCALIZE_READS */
+	/* Connection modes for msgr1/msgr2 protocols */
 	int con_modes[2];  /* CEPH_CON_MODE_* */
 
 	/*
@@ -61,11 +75,16 @@ struct ceph_options {
 	 * ceph_compare_options() should be updated accordingly
 	 */
 
+	/* Array of monitor addresses */
 	struct ceph_entity_addr *mon_addr; /* should be the first
 					      pointer type of args */
+	/* Number of monitors configured */
 	int num_mon;
+	/* Client authentication name */
 	char *name;
+	/* Authentication key */
 	struct ceph_crypto_key *key;
+	/* CRUSH map location constraints */
 	struct rb_root crush_locs;
 };
 
@@ -109,31 +128,46 @@ struct ceph_mds_client;
 /*
  * per client state
  *
- * possibly shared by multiple mount points, if they are
- * mounting the same ceph filesystem/cluster.
+ * Ceph client state metadata: Central state for a connection to a Ceph cluster.
+ * Manages authentication, messaging, and communication with monitors and OSDs.
+ * Can be shared by multiple mount points accessing the same cluster.
  */
 struct ceph_client {
+	/* Cluster filesystem identifier */
 	struct ceph_fsid fsid;
+	/* Whether we have received the cluster FSID */
 	bool have_fsid;
 
+	/* Private data for specific client types (RBD, CephFS, etc.) */
 	void *private;
 
+	/* Client configuration options */
 	struct ceph_options *options;
 
-	struct mutex mount_mutex;      /* serialize mount attempts */
+	/* Serializes mount and authentication attempts */
+	struct mutex mount_mutex;
+	/* Wait queue for authentication completion */
 	wait_queue_head_t auth_wq;
+	/* Latest authentication error code */
 	int auth_err;
 
+	/* Optional callback for extra monitor message handling */
 	int (*extra_mon_dispatch)(struct ceph_client *, struct ceph_msg *);
 
+	/* Feature flags supported by this client */
 	u64 supported_features;
+	/* Feature flags required by this client */
 	u64 required_features;
 
+	/* Network messaging subsystem */
 	struct ceph_messenger msgr;   /* messenger instance */
+	/* Monitor client for cluster map updates */
 	struct ceph_mon_client monc;
+	/* OSD client for data operations */
 	struct ceph_osd_client osdc;
 
 #ifdef CONFIG_DEBUG_FS
+	/* Debug filesystem entries */
 	struct dentry *debugfs_dir;
 	struct dentry *debugfs_monmap;
 	struct dentry *debugfs_osdmap;
@@ -153,17 +187,23 @@ static inline bool ceph_msgr2(struct ceph_client *client)
  */
 
 /*
- * A "snap context" is the set of existing snapshots when we
- * write data.  It is used by the OSD to guide its COW behavior.
+ * Snapshot context metadata: Represents the set of existing snapshots at the
+ * time data was written. Used by OSDs to guide copy-on-write (COW) behavior
+ * and ensure snapshot consistency. Reference-counted and attached to dirty
+ * pages to track the snapshot state when data was dirtied.
  *
  * The ceph_snap_context is refcounted, and attached to each dirty
  * page, indicating which context the dirty data belonged when it was
  * dirtied.
  */
 struct ceph_snap_context {
+	/* Reference count for safe sharing */
 	refcount_t nref;
+	/* Snapshot sequence number */
 	u64 seq;
+	/* Number of snapshots in the array */
 	u32 num_snaps;
+	/* Array of snapshot IDs (variable length) */
 	u64 snaps[];
 };
 
-- 
2.51.0


