Return-Path: <linux-fsdevel+bounces-70573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0798AC9FBB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 16:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74D3530AB2EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1811231A7F1;
	Wed,  3 Dec 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAKEWwQ9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoDTyMeM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58443191CA
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776803; cv=none; b=ZHARbM/G3/LCE3tdLskmJkcUgvD20iu1YDgD2kkZ86huyjRw1JiQ0A1vfBWl9KhGPEBH6DLo6Op6oAL/NRir8XjQCkwyPmF0WSrGzPd0O3WnG+TI3mUdcwknOoki07ZdVd4xHTXBO73dJqcBEqFt9M9AvfTkKDp2tBkjWZ7Ugsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776803; c=relaxed/simple;
	bh=5ZbuvRSC4ENKeUiOAx1tIlgYqM6wKHRg8GEXrAb5dFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rTSg/Lky69OZdeMFZfeNCrmjsh8zIyqsMbRTmBcwmMh09bcTLhfSI7B/u4skUkvrBFGFB8FI8X0YdhCrFTYF5lcNlRrnq7bqgfN3fuukBvgWEtn6X87XYU2kwrjyx08GbPONfG1OnBbNb+AT9E7z1hlNoxUMOI5Ddee0BJmyqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAKEWwQ9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PoDTyMeM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764776798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8NiOAfclJvaeWrP2JEHSOBjpZbhbDPGhJgKzIVE+XU=;
	b=hAKEWwQ9NKC/PJVFDMsIK8PtMWRGA5dc6e9cEtNjflQkqE6n0aiQVcy4hVc8mTRaqbzSpa
	Z2E+CmS43o8pcCSLG0E+/XYk7GJw5K1Q1Dlz07ZIM/Wh7oPHcgXxZ2woHRpP2CSsCu5mad
	woTH9TEq9Fx7go4BrFpltmMrXUgaezY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-OqoQJsYKPvqAsbBnpvPC5A-1; Wed, 03 Dec 2025 10:46:36 -0500
X-MC-Unique: OqoQJsYKPvqAsbBnpvPC5A-1
X-Mimecast-MFC-AGG-ID: OqoQJsYKPvqAsbBnpvPC5A_1764776796
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-647a3af31fbso300709a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 07:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764776795; x=1765381595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8NiOAfclJvaeWrP2JEHSOBjpZbhbDPGhJgKzIVE+XU=;
        b=PoDTyMeMh0FYXVNeLasrwyyOEx45+g77RZAQbNa3G217/zyez+bkgqB7u5X4D+MZ2C
         XAF+rTElsABV0eOAjhCtgcMu4O3EZNMA8v9R3JFcbC6XeLmaGwEsITtdfP97uWlN8pig
         ELno6R4WaQu6Y5pXJ6FkkxiUi5iLj+GPbVaS+ciWkDqh9SqAivWXj0Og4DzFVgAX0TJ6
         BSCDvBNFUAj12CaqFIh79QA4n0/9y+emR7TGq9w/3K2/N+2YmKxgSAGkht6Hss32UZkD
         e+0nBHnoaWNUpW3qIO0IMY019zu3kRg2k+wwxH7K9EKPVe+T/dVngk0EzLiglZ/sFw0S
         bpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764776795; x=1765381595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D8NiOAfclJvaeWrP2JEHSOBjpZbhbDPGhJgKzIVE+XU=;
        b=uGjiDrZQaTAHDZrb69WkTu90s3MzCK/TOvMVgSseXzw4Rmqsk+j9jqLC/mrcf7AzdK
         XrAXuBm4bpkD5e4odSe8Qm27NegRjgdP0tvuPIB3WPdQyJWYLp0poCK6BCUDIdHZJH1T
         X6UV05AAfg+Fba8iUxCWq1slylkvDy4jRW72q5U7PTRMSAyXYT+tehBVLu7lDSWpO2HD
         UjCuqsOyBzLvHdRRkiuSLn5/3E/Bu9ZfN3i4ontXKWy4U16dVzXMKTmVdGUUsIpRs8Gf
         3OxI7Igrh8s01+JZj2jEEzvnePjSiGY+nx1zGxy3pDRYogyD2+H45LM7M2i5eMKaGrxM
         5aaA==
X-Forwarded-Encrypted: i=1; AJvYcCWJlCSAMiZf5v9L3r67lT2H3YjlNLcE4aXG8rSyde4LNztBtES1+qmii8G4IBkGs8SRl7Psw9g1TPu0xD/S@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPZ/uvPxzydXEN6WG9P6KmRZ4VMNohx1lTXD4ozKwKW2wdqIl
	AnZ/braWKTyeSBIIJDRmpxVWmsjouopldc7+iWtl9djj0CFTPKSs55tx3kZKyYK8tjyeMrdXMhz
	ZJCn7H0RF2CV/GgZCXPRSfi9fk9i2dgqdrgOdwLsvuWm3Vmk7sFwRl0vsd7f3VDQrgghWWbn+rl
	q6erIN
X-Gm-Gg: ASbGnctvO5BTTlkX3cnnuGsW5vsefn/UwQ4Ps06vTz1lp2EY6QfWec3XqvmdES2toTj
	flpr7b0X3CmEQgpAtN9kJi7vACtIZcS5lraB7WUA0wN2gDwyHyAYBxCcR91R5nvrxVdUx+Zwrgg
	W03VCMEQzJ6T8QntBEd8qXiDQgc53Sd9bSlH/sXrK6OHK/AbygUchQP4BZQA03AiBmXKBWYqR/R
	Pv0fyoKDr4Tgcr3lEUOsKkheZHY5R2qLWeUc7sMGwCSxj1DKfS7i79mh6zkiD8lPXUy5utpEA8k
	6ACAtvTIxncFmbq+vFtWodYQPu0jKm8mP6T45qa92VgNoH/5qTS+5K744/7az+qTgvo+5Ohbcd1
	C9oppC1SypdE3HQx8UCdC8QsahwnvvGkl207p9sviRVY=
X-Received: by 2002:a05:6402:4310:b0:640:f8a7:aa25 with SMTP id 4fb4d7f45d1cf-6479c4b220cmr2501080a12.30.1764776794541;
        Wed, 03 Dec 2025 07:46:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIAysdM/v+ZscNMBvO76YwIehJ6tK5DxIwBHwUStBWAm005npAJxNRB1crww5byklELySusA==
X-Received: by 2002:a05:6402:4310:b0:640:f8a7:aa25 with SMTP id 4fb4d7f45d1cf-6479c4b220cmr2500903a12.30.1764776793224;
        Wed, 03 Dec 2025 07:46:33 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm18529786a12.29.2025.12.03.07.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 07:46:32 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v3 3/4] ceph: add subvolume metrics collection and reporting
Date: Wed,  3 Dec 2025 15:46:24 +0000
Message-Id: <20251203154625.2779153-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203154625.2779153-1-amarkuze@redhat.com>
References: <20251203154625.2779153-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add complete subvolume metrics infrastructure for tracking and reporting
per-subvolume I/O metrics to the MDS. This enables administrators to
monitor I/O patterns at the subvolume granularity.

The implementation includes:

- New CEPHFS_FEATURE_SUBVOLUME_METRICS feature flag for MDS negotiation
- Red-black tree based metrics tracker (subvolume_metrics.c/h)
- Wire format encoding matching the MDS C++ AggregatedIOMetrics struct
- Integration with the existing metrics reporting infrastructure
- Recording of I/O operations from file read/write paths
- Debugfs interface for monitoring collected metrics

Metrics tracked per subvolume:
- Read/write operation counts
- Read/write byte counts
- Read/write latency sums (for average calculation)

The metrics are periodically sent to the MDS as part of the existing
CLIENT_METRICS message when the MDS advertises support for the
SUBVOLUME_METRICS feature.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/Makefile            |   2 +-
 fs/ceph/addr.c              |  10 +
 fs/ceph/debugfs.c           | 159 +++++++++++++
 fs/ceph/file.c              |  68 +++++-
 fs/ceph/mds_client.c        |  70 ++++--
 fs/ceph/mds_client.h        |  13 +-
 fs/ceph/metric.c            | 173 ++++++++++++++-
 fs/ceph/metric.h            |  27 ++-
 fs/ceph/subvolume_metrics.c | 431 ++++++++++++++++++++++++++++++++++++
 fs/ceph/subvolume_metrics.h |  97 ++++++++
 fs/ceph/super.c             |   8 +
 fs/ceph/super.h             |   1 +
 12 files changed, 1031 insertions(+), 28 deletions(-)
 create mode 100644 fs/ceph/subvolume_metrics.c
 create mode 100644 fs/ceph/subvolume_metrics.h

diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
index 1f77ca04c426..ebb29d11ac22 100644
--- a/fs/ceph/Makefile
+++ b/fs/ceph/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_CEPH_FS) += ceph.o
 ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
 	export.o caps.o snap.o xattr.o quota.o io.o \
 	mds_client.o mdsmap.o strings.o ceph_frag.o \
-	debugfs.o util.o metric.o
+	debugfs.o util.o metric.o subvolume_metrics.o
 
 ceph-$(CONFIG_CEPH_FSCACHE) += cache.o
 ceph-$(CONFIG_CEPH_FS_POSIX_ACL) += acl.o
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 322ed268f14a..feae80dc2816 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -19,6 +19,7 @@
 #include "mds_client.h"
 #include "cache.h"
 #include "metric.h"
+#include "subvolume_metrics.h"
 #include "crypto.h"
 #include <linux/ceph/osd_client.h>
 #include <linux/ceph/striper.h>
@@ -823,6 +824,10 @@ static int write_folio_nounlock(struct folio *folio,
 
 	ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
 				  req->r_end_latency, len, err);
+	if (err >= 0 && len > 0)
+		ceph_subvolume_metrics_record_io(fsc->mdsc, ci, true, len,
+						 req->r_start_latency,
+						 req->r_end_latency);
 	fscrypt_free_bounce_page(bounce_page);
 	ceph_osdc_put_request(req);
 	if (err == 0)
@@ -963,6 +968,11 @@ static void writepages_finish(struct ceph_osd_request *req)
 	ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
 				  req->r_end_latency, len, rc);
 
+	if (rc >= 0 && len > 0)
+		ceph_subvolume_metrics_record_io(mdsc, ci, true, len,
+						 req->r_start_latency,
+						 req->r_end_latency);
+
 	ceph_put_wrbuffer_cap_refs(ci, total_pages, snapc);
 
 	osd_data = osd_req_op_extent_osd_data(req, 0);
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index f3fe786b4143..d49069a90f91 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -9,11 +9,13 @@
 #include <linux/seq_file.h>
 #include <linux/math64.h>
 #include <linux/ktime.h>
+#include <linux/atomic.h>
 
 #include <linux/ceph/libceph.h>
 #include <linux/ceph/mon_client.h>
 #include <linux/ceph/auth.h>
 #include <linux/ceph/debugfs.h>
+#include <linux/ceph/decode.h>
 
 #include "super.h"
 
@@ -21,6 +23,38 @@
 
 #include "mds_client.h"
 #include "metric.h"
+#include "subvolume_metrics.h"
+
+extern bool disable_send_metrics;
+
+/**
+ * struct ceph_session_feature_desc - Maps feature bits to names for debugfs
+ * @bit: Feature bit number from enum ceph_feature_type (see mds_client.h)
+ * @name: Human-readable feature name for debugfs output
+ *
+ * Used by metric_features_show() to display negotiated session features.
+ */
+struct ceph_session_feature_desc {
+	unsigned int bit;
+	const char *name;
+};
+
+static const struct ceph_session_feature_desc ceph_session_feature_table[] = {
+	{ CEPHFS_FEATURE_METRIC_COLLECT, "METRIC_COLLECT" },
+	{ CEPHFS_FEATURE_REPLY_ENCODING, "REPLY_ENCODING" },
+	{ CEPHFS_FEATURE_RECLAIM_CLIENT, "RECLAIM_CLIENT" },
+	{ CEPHFS_FEATURE_LAZY_CAP_WANTED, "LAZY_CAP_WANTED" },
+	{ CEPHFS_FEATURE_MULTI_RECONNECT, "MULTI_RECONNECT" },
+	{ CEPHFS_FEATURE_DELEG_INO, "DELEG_INO" },
+	{ CEPHFS_FEATURE_ALTERNATE_NAME, "ALTERNATE_NAME" },
+	{ CEPHFS_FEATURE_NOTIFY_SESSION_STATE, "NOTIFY_SESSION_STATE" },
+	{ CEPHFS_FEATURE_OP_GETVXATTR, "OP_GETVXATTR" },
+	{ CEPHFS_FEATURE_32BITS_RETRY_FWD, "32BITS_RETRY_FWD" },
+	{ CEPHFS_FEATURE_NEW_SNAPREALM_INFO, "NEW_SNAPREALM_INFO" },
+	{ CEPHFS_FEATURE_HAS_OWNER_UIDGID, "HAS_OWNER_UIDGID" },
+	{ CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK, "MDS_AUTH_CAPS_CHECK" },
+	{ CEPHFS_FEATURE_SUBVOLUME_METRICS, "SUBVOLUME_METRICS" },
+};
 
 static int mdsmap_show(struct seq_file *s, void *p)
 {
@@ -360,6 +394,59 @@ static int status_show(struct seq_file *s, void *p)
 	return 0;
 }
 
+static int subvolume_metrics_show(struct seq_file *s, void *p)
+{
+	struct ceph_fs_client *fsc = s->private;
+	struct ceph_mds_client *mdsc = fsc->mdsc;
+	struct ceph_subvol_metric_snapshot *snapshot = NULL;
+	u32 nr = 0;
+	u64 total_sent = 0;
+	u64 nonzero_sends = 0;
+	u32 i;
+
+	if (!mdsc) {
+		seq_puts(s, "mds client unavailable\n");
+		return 0;
+	}
+
+	mutex_lock(&mdsc->subvol_metrics_last_mutex);
+	if (mdsc->subvol_metrics_last && mdsc->subvol_metrics_last_nr) {
+		nr = mdsc->subvol_metrics_last_nr;
+		snapshot = kmemdup_array(mdsc->subvol_metrics_last, nr,
+					 sizeof(*snapshot), GFP_KERNEL);
+		if (!snapshot)
+			nr = 0;
+	}
+	total_sent = mdsc->subvol_metrics_sent;
+	nonzero_sends = mdsc->subvol_metrics_nonzero_sends;
+	mutex_unlock(&mdsc->subvol_metrics_last_mutex);
+
+	seq_puts(s, "Last sent subvolume metrics:\n");
+	if (!nr) {
+		seq_puts(s, "  (none)\n");
+	} else {
+		seq_puts(s, "  subvol_id          rd_ops    wr_ops    rd_bytes       wr_bytes       rd_lat_us      wr_lat_us\n");
+		for (i = 0; i < nr; i++) {
+			const struct ceph_subvol_metric_snapshot *e = &snapshot[i];
+
+			seq_printf(s, "  %-18llu %-9llu %-9llu %-14llu %-14llu %-14llu %-14llu\n",
+				   e->subvolume_id,
+				   e->read_ops, e->write_ops,
+				   e->read_bytes, e->write_bytes,
+				   e->read_latency_us, e->write_latency_us);
+		}
+	}
+	kfree(snapshot);
+
+	seq_puts(s, "\nStatistics:\n");
+	seq_printf(s, "  entries_sent:      %llu\n", total_sent);
+	seq_printf(s, "  non_zero_sends:    %llu\n", nonzero_sends);
+
+	seq_puts(s, "\nPending (unsent) subvolume metrics:\n");
+	ceph_subvolume_metrics_dump(&mdsc->subvol_metrics, s);
+	return 0;
+}
+
 DEFINE_SHOW_ATTRIBUTE(mdsmap);
 DEFINE_SHOW_ATTRIBUTE(mdsc);
 DEFINE_SHOW_ATTRIBUTE(caps);
@@ -369,7 +456,72 @@ DEFINE_SHOW_ATTRIBUTE(metrics_file);
 DEFINE_SHOW_ATTRIBUTE(metrics_latency);
 DEFINE_SHOW_ATTRIBUTE(metrics_size);
 DEFINE_SHOW_ATTRIBUTE(metrics_caps);
+DEFINE_SHOW_ATTRIBUTE(subvolume_metrics);
+
+static int metric_features_show(struct seq_file *s, void *p)
+{
+	struct ceph_fs_client *fsc = s->private;
+	struct ceph_mds_client *mdsc = fsc->mdsc;
+	unsigned long session_features = 0;
+	bool have_session = false;
+	bool metric_collect = false;
+	bool subvol_support = false;
+	bool metrics_enabled = false;
+	bool subvol_enabled = false;
+	int i;
+
+	if (!mdsc) {
+		seq_puts(s, "mds client unavailable\n");
+		return 0;
+	}
+
+	mutex_lock(&mdsc->mutex);
+	if (mdsc->metric.session) {
+		have_session = true;
+		session_features = mdsc->metric.session->s_features;
+	}
+	mutex_unlock(&mdsc->mutex);
+
+	if (have_session) {
+		metric_collect =
+			test_bit(CEPHFS_FEATURE_METRIC_COLLECT,
+				 &session_features);
+		subvol_support =
+			test_bit(CEPHFS_FEATURE_SUBVOLUME_METRICS,
+				 &session_features);
+	}
+
+	metrics_enabled = !disable_send_metrics && have_session && metric_collect;
+	subvol_enabled = metrics_enabled && subvol_support;
+
+	seq_printf(s,
+		   "metrics_enabled: %s (disable_send_metrics=%d, session=%s, metric_collect=%s)\n",
+		   metrics_enabled ? "yes" : "no",
+		   disable_send_metrics ? 1 : 0,
+		   have_session ? "yes" : "no",
+		   metric_collect ? "yes" : "no");
+	seq_printf(s, "subvolume_metrics_enabled: %s\n",
+		   subvol_enabled ? "yes" : "no");
+	seq_printf(s, "session_feature_bits: 0x%lx\n", session_features);
+
+	if (!have_session) {
+		seq_puts(s, "(no active MDS session for metrics)\n");
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ceph_session_feature_table); i++) {
+		const struct ceph_session_feature_desc *desc =
+			&ceph_session_feature_table[i];
+		bool set = test_bit(desc->bit, &session_features);
+
+		seq_printf(s, "  %-24s : %s\n", desc->name,
+			   set ? "yes" : "no");
+	}
+
+	return 0;
+}
 
+DEFINE_SHOW_ATTRIBUTE(metric_features);
 
 /*
  * debugfs
@@ -404,6 +556,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
 	debugfs_remove(fsc->debugfs_caps);
 	debugfs_remove(fsc->debugfs_status);
 	debugfs_remove(fsc->debugfs_mdsc);
+	debugfs_remove(fsc->debugfs_subvolume_metrics);
 	debugfs_remove_recursive(fsc->debugfs_metrics_dir);
 	doutc(fsc->client, "done\n");
 }
@@ -468,6 +621,12 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 			    &metrics_size_fops);
 	debugfs_create_file("caps", 0400, fsc->debugfs_metrics_dir, fsc,
 			    &metrics_caps_fops);
+	debugfs_create_file("metric_features", 0400, fsc->debugfs_metrics_dir,
+			    fsc, &metric_features_fops);
+	fsc->debugfs_subvolume_metrics =
+		debugfs_create_file("subvolumes", 0400,
+				    fsc->debugfs_metrics_dir, fsc,
+				    &subvolume_metrics_fops);
 	doutc(fsc->client, "done\n");
 }
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 99b30f784ee2..8f4425fde171 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -19,6 +19,25 @@
 #include "cache.h"
 #include "io.h"
 #include "metric.h"
+#include "subvolume_metrics.h"
+
+/*
+ * Record I/O for subvolume metrics tracking.
+ *
+ * Callers must ensure bytes > 0 for reads (ret > 0 check) to avoid counting
+ * EOF as an I/O operation. For writes, the condition is (ret >= 0 && len > 0).
+ */
+static inline void ceph_record_subvolume_io(struct inode *inode, bool is_write,
+					    ktime_t start, ktime_t end,
+					    size_t bytes)
+{
+	if (!bytes)
+		return;
+
+	ceph_subvolume_metrics_record_io(ceph_sb_to_mdsc(inode->i_sb),
+					 ceph_inode(inode),
+					 is_write, bytes, start, end);
+}
 
 static __le32 ceph_flags_sys2wire(struct ceph_mds_client *mdsc, u32 flags)
 {
@@ -1140,6 +1159,15 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 					 req->r_start_latency,
 					 req->r_end_latency,
 					 read_len, ret);
+		/*
+		 * Only record subvolume metrics for actual bytes read.
+		 * ret == 0 means EOF (no data), not an I/O operation.
+		 */
+		if (ret > 0)
+			ceph_record_subvolume_io(inode, false,
+						 req->r_start_latency,
+						 req->r_end_latency,
+						 ret);
 
 		if (ret > 0)
 			objver = req->r_version;
@@ -1385,12 +1413,23 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 
 	/* r_start_latency == 0 means the request was not submitted */
 	if (req->r_start_latency) {
-		if (aio_req->write)
+		if (aio_req->write) {
 			ceph_update_write_metrics(metric, req->r_start_latency,
 						  req->r_end_latency, len, rc);
-		else
+			if (rc >= 0 && len)
+				ceph_record_subvolume_io(inode, true,
+							 req->r_start_latency,
+							 req->r_end_latency,
+							 len);
+		} else {
 			ceph_update_read_metrics(metric, req->r_start_latency,
 						 req->r_end_latency, len, rc);
+			if (rc > 0)
+				ceph_record_subvolume_io(inode, false,
+							 req->r_start_latency,
+							 req->r_end_latency,
+							 rc);
+		}
 	}
 
 	put_bvecs(osd_data->bvec_pos.bvecs, osd_data->num_bvecs,
@@ -1614,12 +1653,23 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 		ceph_osdc_start_request(req->r_osdc, req);
 		ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
 
-		if (write)
+		if (write) {
 			ceph_update_write_metrics(metric, req->r_start_latency,
 						  req->r_end_latency, len, ret);
-		else
+			if (ret >= 0 && len)
+				ceph_record_subvolume_io(inode, true,
+							 req->r_start_latency,
+							 req->r_end_latency,
+							 len);
+		} else {
 			ceph_update_read_metrics(metric, req->r_start_latency,
 						 req->r_end_latency, len, ret);
+			if (ret > 0)
+				ceph_record_subvolume_io(inode, false,
+							 req->r_start_latency,
+							 req->r_end_latency,
+							 ret);
+		}
 
 		size = i_size_read(inode);
 		if (!write) {
@@ -1872,6 +1922,11 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 						 req->r_start_latency,
 						 req->r_end_latency,
 						 read_len, ret);
+			if (ret > 0)
+				ceph_record_subvolume_io(inode, false,
+							 req->r_start_latency,
+							 req->r_end_latency,
+							 ret);
 
 			/* Ok if object is not already present */
 			if (ret == -ENOENT) {
@@ -2036,6 +2091,11 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 
 		ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
 					  req->r_end_latency, len, ret);
+		if (ret >= 0 && write_len)
+			ceph_record_subvolume_io(inode, true,
+						 req->r_start_latency,
+						 req->r_end_latency,
+						 write_len);
 		ceph_osdc_put_request(req);
 		if (ret != 0) {
 			doutc(cl, "osd write returned %d\n", ret);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 099b8f22683b..2b831f48c844 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -67,6 +67,22 @@ static void ceph_cap_reclaim_work(struct work_struct *work);
 
 static const struct ceph_connection_operations mds_con_ops;
 
+static void ceph_metric_bind_session(struct ceph_mds_client *mdsc,
+				     struct ceph_mds_session *session)
+{
+	struct ceph_mds_session *old;
+
+	if (!mdsc || !session || disable_send_metrics)
+		return;
+
+	old = mdsc->metric.session;
+	mdsc->metric.session = ceph_get_mds_session(session);
+	if (old)
+		ceph_put_mds_session(old);
+
+	metric_schedule_delayed(&mdsc->metric);
+}
+
 
 /*
  * mds reply parsing
@@ -95,21 +111,23 @@ static int parse_reply_info_quota(void **p, void *end,
 	return -EIO;
 }
 
-/*
- * parse individual inode info
- */
 static int parse_reply_info_in(void **p, void *end,
 			       struct ceph_mds_reply_info_in *info,
-			       u64 features)
+			       u64 features,
+			       struct ceph_mds_client *mdsc)
 {
 	int err = 0;
 	u8 struct_v = 0;
+	u8 struct_compat = 0;
+	u32 struct_len = 0;
+	struct ceph_client *cl = mdsc ? mdsc->fsc->client : NULL;
+
+	info->subvolume_id = 0;
+	doutc(cl, "subv_metric parse start features=0x%llx\n", features);
 
 	info->subvolume_id = 0;
 
 	if (features == (u64)-1) {
-		u32 struct_len;
-		u8 struct_compat;
 		ceph_decode_8_safe(p, end, struct_v, bad);
 		ceph_decode_8_safe(p, end, struct_compat, bad);
 		/* struct_v is expected to be >= 1. we only understand
@@ -389,12 +407,13 @@ static int parse_reply_info_lease(void **p, void *end,
  */
 static int parse_reply_info_trace(void **p, void *end,
 				  struct ceph_mds_reply_info_parsed *info,
-				  u64 features)
+				  u64 features,
+				  struct ceph_mds_client *mdsc)
 {
 	int err;
 
 	if (info->head->is_dentry) {
-		err = parse_reply_info_in(p, end, &info->diri, features);
+		err = parse_reply_info_in(p, end, &info->diri, features, mdsc);
 		if (err < 0)
 			goto out_bad;
 
@@ -414,7 +433,8 @@ static int parse_reply_info_trace(void **p, void *end,
 	}
 
 	if (info->head->is_target) {
-		err = parse_reply_info_in(p, end, &info->targeti, features);
+		err = parse_reply_info_in(p, end, &info->targeti, features,
+					  mdsc);
 		if (err < 0)
 			goto out_bad;
 	}
@@ -435,7 +455,8 @@ static int parse_reply_info_trace(void **p, void *end,
  */
 static int parse_reply_info_readdir(void **p, void *end,
 				    struct ceph_mds_request *req,
-				    u64 features)
+				    u64 features,
+				    struct ceph_mds_client *mdsc)
 {
 	struct ceph_mds_reply_info_parsed *info = &req->r_reply_info;
 	struct ceph_client *cl = req->r_mdsc->fsc->client;
@@ -550,7 +571,7 @@ static int parse_reply_info_readdir(void **p, void *end,
 		rde->name_len = oname.len;
 
 		/* inode */
-		err = parse_reply_info_in(p, end, &rde->inode, features);
+		err = parse_reply_info_in(p, end, &rde->inode, features, mdsc);
 		if (err < 0)
 			goto out_bad;
 		/* ceph_readdir_prepopulate() will update it */
@@ -758,7 +779,8 @@ static int parse_reply_info_extra(void **p, void *end,
 	if (op == CEPH_MDS_OP_GETFILELOCK)
 		return parse_reply_info_filelock(p, end, info, features);
 	else if (op == CEPH_MDS_OP_READDIR || op == CEPH_MDS_OP_LSSNAP)
-		return parse_reply_info_readdir(p, end, req, features);
+		return parse_reply_info_readdir(p, end, req, features,
+						req->r_mdsc);
 	else if (op == CEPH_MDS_OP_CREATE)
 		return parse_reply_info_create(p, end, info, features, s);
 	else if (op == CEPH_MDS_OP_GETVXATTR)
@@ -787,7 +809,8 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
 	ceph_decode_32_safe(&p, end, len, bad);
 	if (len > 0) {
 		ceph_decode_need(&p, end, len, bad);
-		err = parse_reply_info_trace(&p, p+len, info, features);
+		err = parse_reply_info_trace(&p, p + len, info, features,
+					     s->s_mdsc);
 		if (err < 0)
 			goto out_bad;
 	}
@@ -796,7 +819,7 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
 	ceph_decode_32_safe(&p, end, len, bad);
 	if (len > 0) {
 		ceph_decode_need(&p, end, len, bad);
-		err = parse_reply_info_extra(&p, p+len, req, features, s);
+		err = parse_reply_info_extra(&p, p + len, req, features, s);
 		if (err < 0)
 			goto out_bad;
 	}
@@ -4326,6 +4349,11 @@ static void handle_session(struct ceph_mds_session *session,
 		}
 		mdsc->s_cap_auths_num = cap_auths_num;
 		mdsc->s_cap_auths = cap_auths;
+
+		session->s_features = features;
+		if (test_bit(CEPHFS_FEATURE_METRIC_COLLECT,
+			     &session->s_features))
+			ceph_metric_bind_session(mdsc, session);
 	}
 	if (op == CEPH_SESSION_CLOSE) {
 		ceph_get_mds_session(session);
@@ -4352,7 +4380,11 @@ static void handle_session(struct ceph_mds_session *session,
 			pr_info_client(cl, "mds%d reconnect success\n",
 				       session->s_mds);
 
-		session->s_features = features;
+		if (test_bit(CEPHFS_FEATURE_SUBVOLUME_METRICS,
+			     &session->s_features))
+			ceph_subvolume_metrics_enable(&mdsc->subvol_metrics, true);
+		else
+			ceph_subvolume_metrics_enable(&mdsc->subvol_metrics, false);
 		if (session->s_state == CEPH_MDS_SESSION_OPEN) {
 			pr_notice_client(cl, "mds%d is already opened\n",
 					 session->s_mds);
@@ -5591,6 +5623,12 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	err = ceph_metric_init(&mdsc->metric);
 	if (err)
 		goto err_mdsmap;
+	ceph_subvolume_metrics_init(&mdsc->subvol_metrics);
+	mutex_init(&mdsc->subvol_metrics_last_mutex);
+	mdsc->subvol_metrics_last = NULL;
+	mdsc->subvol_metrics_last_nr = 0;
+	mdsc->subvol_metrics_sent = 0;
+	mdsc->subvol_metrics_nonzero_sends = 0;
 
 	spin_lock_init(&mdsc->dentry_list_lock);
 	INIT_LIST_HEAD(&mdsc->dentry_leases);
@@ -6123,6 +6161,8 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 	ceph_mdsc_stop(mdsc);
 
 	ceph_metric_destroy(&mdsc->metric);
+	ceph_subvolume_metrics_destroy(&mdsc->subvol_metrics);
+	kfree(mdsc->subvol_metrics_last);
 
 	fsc->mdsc = NULL;
 	kfree(mdsc);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index bd3690baa65c..4e6c87f8414c 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -18,6 +18,7 @@
 
 #include "mdsmap.h"
 #include "metric.h"
+#include "subvolume_metrics.h"
 #include "super.h"
 
 /* The first 8 bits are reserved for old ceph releases */
@@ -36,8 +37,9 @@ enum ceph_feature_type {
 	CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
 	CEPHFS_FEATURE_HAS_OWNER_UIDGID,
 	CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,
+	CEPHFS_FEATURE_SUBVOLUME_METRICS,
 
-	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,
+	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_SUBVOLUME_METRICS,
 };
 
 #define CEPHFS_FEATURES_CLIENT_SUPPORTED {	\
@@ -54,6 +56,7 @@ enum ceph_feature_type {
 	CEPHFS_FEATURE_32BITS_RETRY_FWD,	\
 	CEPHFS_FEATURE_HAS_OWNER_UIDGID,	\
 	CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,	\
+	CEPHFS_FEATURE_SUBVOLUME_METRICS,	\
 }
 
 /*
@@ -537,6 +540,14 @@ struct ceph_mds_client {
 	struct list_head  dentry_dir_leases; /* lru list */
 
 	struct ceph_client_metric metric;
+	struct ceph_subvolume_metrics_tracker subvol_metrics;
+
+	/* Subvolume metrics send tracking */
+	struct mutex		subvol_metrics_last_mutex;
+	struct ceph_subvol_metric_snapshot *subvol_metrics_last;
+	u32			subvol_metrics_last_nr;
+	u64			subvol_metrics_sent;
+	u64			subvol_metrics_nonzero_sends;
 
 	spinlock_t		snapid_map_lock;
 	struct rb_root		snapid_map_tree;
diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index 871c1090e520..9bb357abc897 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -4,10 +4,84 @@
 #include <linux/types.h>
 #include <linux/percpu_counter.h>
 #include <linux/math64.h>
+#include <linux/ratelimit.h>
+
+#include <linux/ceph/decode.h>
 
 #include "metric.h"
 #include "mds_client.h"
 
+static bool metrics_disable_warned;
+
+static inline u32 ceph_subvolume_entry_payload_len(void)
+{
+	return sizeof(struct ceph_subvolume_metric_entry_wire);
+}
+
+static inline u32 ceph_subvolume_entry_encoded_len(void)
+{
+	return CEPH_ENCODING_START_BLK_LEN +
+		ceph_subvolume_entry_payload_len();
+}
+
+static inline u32 ceph_subvolume_outer_payload_len(u32 nr_subvols)
+{
+	/* count is encoded as le64 (size_t on wire) to match FUSE client */
+	return sizeof(__le64) +
+		nr_subvols * ceph_subvolume_entry_encoded_len();
+}
+
+static inline u32 ceph_subvolume_metric_data_len(u32 nr_subvols)
+{
+	return CEPH_ENCODING_START_BLK_LEN +
+		ceph_subvolume_outer_payload_len(nr_subvols);
+}
+
+static inline u32 ceph_subvolume_clamp_u32(u64 val)
+{
+	return val > U32_MAX ? U32_MAX : (u32)val;
+}
+
+static void ceph_init_subvolume_wire_entry(
+	struct ceph_subvolume_metric_entry_wire *dst,
+	const struct ceph_subvol_metric_snapshot *src)
+{
+	dst->subvolume_id = cpu_to_le64(src->subvolume_id);
+	dst->read_ops = cpu_to_le32(ceph_subvolume_clamp_u32(src->read_ops));
+	dst->write_ops = cpu_to_le32(ceph_subvolume_clamp_u32(src->write_ops));
+	dst->read_bytes = cpu_to_le64(src->read_bytes);
+	dst->write_bytes = cpu_to_le64(src->write_bytes);
+	dst->read_latency_us = cpu_to_le64(src->read_latency_us);
+	dst->write_latency_us = cpu_to_le64(src->write_latency_us);
+	dst->time_stamp = 0;
+}
+
+static int ceph_encode_subvolume_metrics(void **p, void *end,
+					 struct ceph_subvol_metric_snapshot *subvols,
+					 u32 nr_subvols)
+{
+	u32 i;
+
+	ceph_start_encoding(p, 1, 1,
+			    ceph_subvolume_outer_payload_len(nr_subvols));
+	/* count is encoded as le64 (size_t on wire) to match FUSE client */
+	ceph_encode_64_safe(p, end, (u64)nr_subvols, enc_err);
+
+	for (i = 0; i < nr_subvols; i++) {
+		struct ceph_subvolume_metric_entry_wire wire_entry;
+
+		ceph_init_subvolume_wire_entry(&wire_entry, &subvols[i]);
+		ceph_start_encoding(p, 1, 1,
+				    ceph_subvolume_entry_payload_len());
+		ceph_encode_copy_safe(p, end, &wire_entry,
+				      sizeof(wire_entry), enc_err);
+	}
+
+	return 0;
+enc_err:
+	return -ERANGE;
+}
+
 static void ktime_to_ceph_timespec(struct ceph_timespec *ts, ktime_t val)
 {
 	struct timespec64 t = ktime_to_timespec64(val);
@@ -29,10 +103,14 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 	struct ceph_read_io_size *rsize;
 	struct ceph_write_io_size *wsize;
 	struct ceph_client_metric *m = &mdsc->metric;
+	struct ceph_subvol_metric_snapshot *subvols = NULL;
 	u64 nr_caps = atomic64_read(&m->total_caps);
 	u32 header_len = sizeof(struct ceph_metric_header);
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *msg;
+	u32 nr_subvols = 0;
+	size_t subvol_len = 0;
+	void *cursor;
 	s64 sum;
 	s32 items = 0;
 	s32 len;
@@ -45,15 +123,37 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 	}
 	mutex_unlock(&mdsc->mutex);
 
+	if (ceph_subvolume_metrics_enabled(&mdsc->subvol_metrics) &&
+	    test_bit(CEPHFS_FEATURE_SUBVOLUME_METRICS, &s->s_features)) {
+		int ret;
+
+		ret = ceph_subvolume_metrics_snapshot(&mdsc->subvol_metrics,
+						      &subvols, &nr_subvols,
+						      true);
+		if (ret) {
+			pr_warn_client(cl, "failed to snapshot subvolume metrics: %d\n",
+				       ret);
+			nr_subvols = 0;
+			subvols = NULL;
+		}
+	}
+
+	if (nr_subvols) {
+		/* type (le32) + ENCODE_START payload - no metric header */
+		subvol_len = sizeof(__le32) +
+			     ceph_subvolume_metric_data_len(nr_subvols);
+	}
+
 	len = sizeof(*head) + sizeof(*cap) + sizeof(*read) + sizeof(*write)
 	      + sizeof(*meta) + sizeof(*dlease) + sizeof(*files)
 	      + sizeof(*icaps) + sizeof(*inodes) + sizeof(*rsize)
-	      + sizeof(*wsize);
+	      + sizeof(*wsize) + subvol_len;
 
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_METRICS, len, GFP_NOFS, true);
 	if (!msg) {
 		pr_err_client(cl, "to mds%d, failed to allocate message\n",
 			      s->s_mds);
+		kfree(subvols);
 		return false;
 	}
 
@@ -172,13 +272,56 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 	wsize->total_size = cpu_to_le64(m->metric[METRIC_WRITE].size_sum);
 	items++;
 
+	cursor = wsize + 1;
+
+	if (nr_subvols) {
+		void *payload;
+		void *payload_end;
+		int ret;
+
+		/* Emit only the type (le32), no ver/compat/data_len */
+		ceph_encode_32(&cursor, CLIENT_METRIC_TYPE_SUBVOLUME_METRICS);
+		items++;
+
+		payload = cursor;
+		payload_end = (char *)payload +
+			      ceph_subvolume_metric_data_len(nr_subvols);
+
+		ret = ceph_encode_subvolume_metrics(&payload, payload_end,
+						    subvols, nr_subvols);
+		if (ret) {
+			pr_warn_client(cl,
+				       "failed to encode subvolume metrics\n");
+			kfree(subvols);
+			ceph_msg_put(msg);
+			return false;
+		}
+
+		WARN_ON(payload != payload_end);
+		cursor = payload;
+	}
+
 	put_unaligned_le32(items, &head->num);
-	msg->front.iov_len = len;
+	msg->front.iov_len = (char *)cursor - (char *)head;
 	msg->hdr.version = cpu_to_le16(1);
 	msg->hdr.compat_version = cpu_to_le16(1);
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
+
 	ceph_con_send(&s->s_con, msg);
 
+	if (nr_subvols) {
+		mutex_lock(&mdsc->subvol_metrics_last_mutex);
+		kfree(mdsc->subvol_metrics_last);
+		mdsc->subvol_metrics_last = subvols;
+		mdsc->subvol_metrics_last_nr = nr_subvols;
+		mdsc->subvol_metrics_sent += nr_subvols;
+		mdsc->subvol_metrics_nonzero_sends++;
+		mutex_unlock(&mdsc->subvol_metrics_last_mutex);
+
+		subvols = NULL;
+	}
+	kfree(subvols);
+
 	return true;
 }
 
@@ -201,6 +344,12 @@ static void metric_get_session(struct ceph_mds_client *mdsc)
 		 */
 		if (check_session_state(s) &&
 		    test_bit(CEPHFS_FEATURE_METRIC_COLLECT, &s->s_features)) {
+			if (ceph_subvolume_metrics_enabled(&mdsc->subvol_metrics) &&
+			    !test_bit(CEPHFS_FEATURE_SUBVOLUME_METRICS,
+				      &s->s_features)) {
+				ceph_put_mds_session(s);
+				continue;
+			}
 			mdsc->metric.session = s;
 			break;
 		}
@@ -217,8 +366,17 @@ static void metric_delayed_work(struct work_struct *work)
 	struct ceph_mds_client *mdsc =
 		container_of(m, struct ceph_mds_client, metric);
 
-	if (mdsc->stopping || disable_send_metrics)
+	if (mdsc->stopping)
+		return;
+
+	if (disable_send_metrics) {
+		if (!metrics_disable_warned) {
+			pr_info("ceph: metrics sending disabled via module parameter\n");
+			metrics_disable_warned = true;
+		}
 		return;
+	}
+	metrics_disable_warned = false;
 
 	if (!m->session || !check_session_state(m->session)) {
 		if (m->session) {
@@ -227,10 +385,13 @@ static void metric_delayed_work(struct work_struct *work)
 		}
 		metric_get_session(mdsc);
 	}
-	if (m->session) {
+
+	if (m->session)
 		ceph_mdsc_send_metrics(mdsc, m->session);
-		metric_schedule_delayed(m);
-	}
+	else
+		pr_warn_ratelimited("ceph: metrics worker has no MDS session\n");
+
+	metric_schedule_delayed(m);
 }
 
 int ceph_metric_init(struct ceph_client_metric *m)
diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
index 0d0c44bd3332..7e4aac63f6a6 100644
--- a/fs/ceph/metric.h
+++ b/fs/ceph/metric.h
@@ -25,8 +25,9 @@ enum ceph_metric_type {
 	CLIENT_METRIC_TYPE_STDEV_WRITE_LATENCY,
 	CLIENT_METRIC_TYPE_AVG_METADATA_LATENCY,
 	CLIENT_METRIC_TYPE_STDEV_METADATA_LATENCY,
+	CLIENT_METRIC_TYPE_SUBVOLUME_METRICS,
 
-	CLIENT_METRIC_TYPE_MAX = CLIENT_METRIC_TYPE_STDEV_METADATA_LATENCY,
+	CLIENT_METRIC_TYPE_MAX = CLIENT_METRIC_TYPE_SUBVOLUME_METRICS,
 };
 
 /*
@@ -50,6 +51,7 @@ enum ceph_metric_type {
 	CLIENT_METRIC_TYPE_STDEV_WRITE_LATENCY,	   \
 	CLIENT_METRIC_TYPE_AVG_METADATA_LATENCY,   \
 	CLIENT_METRIC_TYPE_STDEV_METADATA_LATENCY, \
+	CLIENT_METRIC_TYPE_SUBVOLUME_METRICS,	   \
 						   \
 	CLIENT_METRIC_TYPE_MAX,			   \
 }
@@ -139,6 +141,29 @@ struct ceph_write_io_size {
 	__le64 total_size;
 } __packed;
 
+/* Wire format for subvolume metrics - matches C++ AggregatedIOMetrics */
+struct ceph_subvolume_metric_entry_wire {
+	__le64 subvolume_id;
+	__le32 read_ops;
+	__le32 write_ops;
+	__le64 read_bytes;
+	__le64 write_bytes;
+	__le64 read_latency_us;
+	__le64 write_latency_us;
+	__le64 time_stamp;
+} __packed;
+
+/* Old struct kept for internal tracking, not used on wire */
+struct ceph_subvolume_metric_entry {
+	__le64 subvolume_id;
+	__le64 read_ops;
+	__le64 write_ops;
+	__le64 read_bytes;
+	__le64 write_bytes;
+	__le64 read_latency_us;
+	__le64 write_latency_us;
+} __packed;
+
 struct ceph_metric_head {
 	__le32 num;	/* the number of metrics that will be sent */
 } __packed;
diff --git a/fs/ceph/subvolume_metrics.c b/fs/ceph/subvolume_metrics.c
new file mode 100644
index 000000000000..111f6754e609
--- /dev/null
+++ b/fs/ceph/subvolume_metrics.c
@@ -0,0 +1,431 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ceph/ceph_debug.h>
+
+#include <linux/math64.h>
+#include <linux/slab.h>
+#include <linux/seq_file.h>
+
+#include "subvolume_metrics.h"
+#include "mds_client.h"
+#include "super.h"
+
+struct ceph_subvol_metric_rb_entry {
+	struct rb_node node;
+	u64 subvolume_id;
+	u64 read_ops;
+	u64 write_ops;
+	u64 read_bytes;
+	u64 write_bytes;
+	u64 read_latency_us;
+	u64 write_latency_us;
+};
+
+static struct kmem_cache *ceph_subvol_metric_entry_cachep;
+
+void ceph_subvolume_metrics_init(struct ceph_subvolume_metrics_tracker *tracker)
+{
+	spin_lock_init(&tracker->lock);
+	tracker->tree = RB_ROOT_CACHED;
+	tracker->nr_entries = 0;
+	tracker->enabled = false;
+	atomic64_set(&tracker->snapshot_attempts, 0);
+	atomic64_set(&tracker->snapshot_empty, 0);
+	atomic64_set(&tracker->snapshot_failures, 0);
+	atomic64_set(&tracker->record_calls, 0);
+	atomic64_set(&tracker->record_disabled, 0);
+	atomic64_set(&tracker->record_no_subvol, 0);
+	atomic64_set(&tracker->total_read_ops, 0);
+	atomic64_set(&tracker->total_read_bytes, 0);
+	atomic64_set(&tracker->total_write_ops, 0);
+	atomic64_set(&tracker->total_write_bytes, 0);
+}
+
+static struct ceph_subvol_metric_rb_entry *
+__lookup_entry(struct ceph_subvolume_metrics_tracker *tracker, u64 subvol_id)
+{
+	struct rb_node *node;
+
+	node = tracker->tree.rb_root.rb_node;
+	while (node) {
+		struct ceph_subvol_metric_rb_entry *entry =
+			rb_entry(node, struct ceph_subvol_metric_rb_entry, node);
+
+		if (subvol_id < entry->subvolume_id)
+			node = node->rb_left;
+		else if (subvol_id > entry->subvolume_id)
+			node = node->rb_right;
+		else
+			return entry;
+	}
+
+	return NULL;
+}
+
+static struct ceph_subvol_metric_rb_entry *
+__insert_entry(struct ceph_subvolume_metrics_tracker *tracker,
+	       struct ceph_subvol_metric_rb_entry *entry)
+{
+	struct rb_node **link = &tracker->tree.rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	bool leftmost = true;
+
+	while (*link) {
+		struct ceph_subvol_metric_rb_entry *cur =
+			rb_entry(*link, struct ceph_subvol_metric_rb_entry, node);
+
+		parent = *link;
+		if (entry->subvolume_id < cur->subvolume_id)
+			link = &(*link)->rb_left;
+		else if (entry->subvolume_id > cur->subvolume_id) {
+			link = &(*link)->rb_right;
+			leftmost = false;
+		} else
+			return cur;
+	}
+
+	rb_link_node(&entry->node, parent, link);
+	rb_insert_color_cached(&entry->node, &tracker->tree, leftmost);
+	tracker->nr_entries++;
+	return entry;
+}
+
+static void ceph_subvolume_metrics_clear_locked(
+		struct ceph_subvolume_metrics_tracker *tracker)
+{
+	struct rb_node *node = rb_first_cached(&tracker->tree);
+
+	while (node) {
+		struct ceph_subvol_metric_rb_entry *entry =
+			rb_entry(node, struct ceph_subvol_metric_rb_entry, node);
+		struct rb_node *next = rb_next(node);
+
+		rb_erase_cached(&entry->node, &tracker->tree);
+		tracker->nr_entries--;
+		kmem_cache_free(ceph_subvol_metric_entry_cachep, entry);
+		node = next;
+	}
+
+	tracker->tree = RB_ROOT_CACHED;
+}
+
+void ceph_subvolume_metrics_destroy(struct ceph_subvolume_metrics_tracker *tracker)
+{
+	spin_lock(&tracker->lock);
+	ceph_subvolume_metrics_clear_locked(tracker);
+	tracker->enabled = false;
+	spin_unlock(&tracker->lock);
+}
+
+void ceph_subvolume_metrics_enable(struct ceph_subvolume_metrics_tracker *tracker,
+				   bool enable)
+{
+	spin_lock(&tracker->lock);
+	if (enable) {
+		tracker->enabled = true;
+	} else {
+		tracker->enabled = false;
+		ceph_subvolume_metrics_clear_locked(tracker);
+	}
+	spin_unlock(&tracker->lock);
+}
+
+void ceph_subvolume_metrics_record(struct ceph_subvolume_metrics_tracker *tracker,
+				   u64 subvol_id, bool is_write,
+				   size_t size, u64 latency_us)
+{
+	struct ceph_subvol_metric_rb_entry *entry, *new_entry = NULL;
+	bool retry = false;
+
+	/* 0 means unknown/unset subvolume (matches FUSE client convention) */
+	if (!READ_ONCE(tracker->enabled) || !subvol_id || !size || !latency_us)
+		return;
+
+	do {
+		spin_lock(&tracker->lock);
+		if (!tracker->enabled) {
+			spin_unlock(&tracker->lock);
+			kmem_cache_free(ceph_subvol_metric_entry_cachep, new_entry);
+			return;
+		}
+
+		entry = __lookup_entry(tracker, subvol_id);
+		if (!entry) {
+			if (!new_entry) {
+				spin_unlock(&tracker->lock);
+				new_entry = kmem_cache_zalloc(ceph_subvol_metric_entry_cachep,
+						      GFP_NOFS);
+				if (!new_entry)
+					return;
+				new_entry->subvolume_id = subvol_id;
+				retry = true;
+				continue;
+			}
+			entry = __insert_entry(tracker, new_entry);
+			if (entry != new_entry) {
+				/* raced with another insert */
+				spin_unlock(&tracker->lock);
+				kmem_cache_free(ceph_subvol_metric_entry_cachep, new_entry);
+				new_entry = NULL;
+				retry = true;
+				continue;
+			}
+			new_entry = NULL;
+		}
+
+		if (is_write) {
+			entry->write_ops++;
+			entry->write_bytes += size;
+			entry->write_latency_us += latency_us;
+			atomic64_inc(&tracker->total_write_ops);
+			atomic64_add(size, &tracker->total_write_bytes);
+		} else {
+			entry->read_ops++;
+			entry->read_bytes += size;
+			entry->read_latency_us += latency_us;
+			atomic64_inc(&tracker->total_read_ops);
+			atomic64_add(size, &tracker->total_read_bytes);
+		}
+		spin_unlock(&tracker->lock);
+		kmem_cache_free(ceph_subvol_metric_entry_cachep, new_entry);
+		return;
+	} while (retry);
+}
+
+int ceph_subvolume_metrics_snapshot(struct ceph_subvolume_metrics_tracker *tracker,
+				    struct ceph_subvol_metric_snapshot **out,
+				    u32 *nr, bool consume)
+{
+	struct ceph_subvol_metric_snapshot *snap = NULL;
+	struct rb_node *node;
+	u32 count = 0, idx = 0;
+	int ret = 0;
+
+	*out = NULL;
+	*nr = 0;
+
+	if (!READ_ONCE(tracker->enabled))
+		return 0;
+
+	atomic64_inc(&tracker->snapshot_attempts);
+
+	spin_lock(&tracker->lock);
+	for (node = rb_first_cached(&tracker->tree); node; node = rb_next(node)) {
+		struct ceph_subvol_metric_rb_entry *entry =
+			rb_entry(node, struct ceph_subvol_metric_rb_entry, node);
+
+		/* Include entries with ANY I/O activity (read OR write) */
+		if (entry->read_ops || entry->write_ops)
+			count++;
+	}
+	spin_unlock(&tracker->lock);
+
+	if (!count) {
+		atomic64_inc(&tracker->snapshot_empty);
+		return 0;
+	}
+
+	snap = kcalloc(count, sizeof(*snap), GFP_NOFS);
+	if (!snap) {
+		atomic64_inc(&tracker->snapshot_failures);
+		return -ENOMEM;
+	}
+
+	spin_lock(&tracker->lock);
+	node = rb_first_cached(&tracker->tree);
+	while (node) {
+		struct ceph_subvol_metric_rb_entry *entry =
+			rb_entry(node, struct ceph_subvol_metric_rb_entry, node);
+		struct rb_node *next = rb_next(node);
+
+		/* Skip entries with NO I/O activity at all */
+		if (!entry->read_ops && !entry->write_ops) {
+			rb_erase_cached(&entry->node, &tracker->tree);
+			tracker->nr_entries--;
+			kmem_cache_free(ceph_subvol_metric_entry_cachep, entry);
+			node = next;
+			continue;
+		}
+
+		if (idx >= count) {
+			pr_warn("ceph: subvol metrics snapshot race (idx=%u count=%u)\n",
+				idx, count);
+			break;
+		}
+
+		snap[idx].subvolume_id = entry->subvolume_id;
+		snap[idx].read_ops = entry->read_ops;
+		snap[idx].write_ops = entry->write_ops;
+		snap[idx].read_bytes = entry->read_bytes;
+		snap[idx].write_bytes = entry->write_bytes;
+		snap[idx].read_latency_us = entry->read_latency_us;
+		snap[idx].write_latency_us = entry->write_latency_us;
+		idx++;
+
+		if (consume) {
+			entry->read_ops = 0;
+			entry->write_ops = 0;
+			entry->read_bytes = 0;
+			entry->write_bytes = 0;
+			entry->read_latency_us = 0;
+			entry->write_latency_us = 0;
+			rb_erase_cached(&entry->node, &tracker->tree);
+			tracker->nr_entries--;
+			kmem_cache_free(ceph_subvol_metric_entry_cachep, entry);
+		}
+		node = next;
+	}
+	spin_unlock(&tracker->lock);
+
+	if (!idx) {
+		kfree(snap);
+		snap = NULL;
+		ret = 0;
+	} else {
+		*nr = idx;
+		*out = snap;
+	}
+
+	return ret;
+}
+
+void ceph_subvolume_metrics_free_snapshot(struct ceph_subvol_metric_snapshot *snapshot)
+{
+	kfree(snapshot);
+}
+
+static u64 div_rem(u64 dividend, u64 divisor)
+{
+	return divisor ? div64_u64(dividend, divisor) : 0;
+}
+
+/*
+ * Dump subvolume metrics to a seq_file for debugfs.
+ * This function does not return an error code because the seq_file API
+ * handles errors internally - any failures are tracked in the seq_file
+ * structure and reported to userspace when the file is read.
+ */
+void ceph_subvolume_metrics_dump(struct ceph_subvolume_metrics_tracker *tracker,
+				 struct seq_file *s)
+{
+	struct rb_node *node;
+	struct ceph_subvol_metric_snapshot *snapshot = NULL;
+	u32 count = 0, idx = 0;
+
+	spin_lock(&tracker->lock);
+	if (!tracker->enabled) {
+		spin_unlock(&tracker->lock);
+		seq_puts(s, "subvolume metrics disabled\n");
+		return;
+	}
+
+	for (node = rb_first_cached(&tracker->tree); node; node = rb_next(node)) {
+		struct ceph_subvol_metric_rb_entry *entry =
+			rb_entry(node, struct ceph_subvol_metric_rb_entry, node);
+
+		if (entry->read_ops || entry->write_ops)
+			count++;
+	}
+	spin_unlock(&tracker->lock);
+
+	if (!count) {
+		seq_puts(s, "(no subvolume metrics collected)\n");
+		return;
+	}
+
+	snapshot = kcalloc(count, sizeof(*snapshot), GFP_KERNEL);
+	if (!snapshot) {
+		seq_puts(s, "(unable to allocate memory for snapshot)\n");
+		return;
+	}
+
+	spin_lock(&tracker->lock);
+	for (node = rb_first_cached(&tracker->tree); node; node = rb_next(node)) {
+		struct ceph_subvol_metric_rb_entry *entry =
+			rb_entry(node, struct ceph_subvol_metric_rb_entry, node);
+
+		if (!entry->read_ops && !entry->write_ops)
+			continue;
+
+		if (idx >= count)
+			break;
+
+		snapshot[idx].subvolume_id = entry->subvolume_id;
+		snapshot[idx].read_ops = entry->read_ops;
+		snapshot[idx].write_ops = entry->write_ops;
+		snapshot[idx].read_bytes = entry->read_bytes;
+		snapshot[idx].write_bytes = entry->write_bytes;
+		snapshot[idx].read_latency_us = entry->read_latency_us;
+		snapshot[idx].write_latency_us = entry->write_latency_us;
+		idx++;
+	}
+	spin_unlock(&tracker->lock);
+
+	seq_puts(s, "subvol_id       rd_ops    rd_bytes    rd_avg_lat_us  wr_ops    wr_bytes    wr_avg_lat_us\n");
+	seq_puts(s, "------------------------------------------------------------------------------------------------\n");
+
+	for (idx = 0; idx < count; idx++) {
+		u64 avg_rd_lat = div_rem(snapshot[idx].read_latency_us,
+					 snapshot[idx].read_ops);
+		u64 avg_wr_lat = div_rem(snapshot[idx].write_latency_us,
+					 snapshot[idx].write_ops);
+
+		seq_printf(s, "%-15llu%-10llu%-12llu%-16llu%-10llu%-12llu%-16llu\n",
+			   snapshot[idx].subvolume_id,
+			   snapshot[idx].read_ops,
+			   snapshot[idx].read_bytes,
+			   avg_rd_lat,
+			   snapshot[idx].write_ops,
+			   snapshot[idx].write_bytes,
+			   avg_wr_lat);
+	}
+
+	kfree(snapshot);
+}
+
+void ceph_subvolume_metrics_record_io(struct ceph_mds_client *mdsc,
+				      struct ceph_inode_info *ci,
+				      bool is_write, size_t bytes,
+				      ktime_t start, ktime_t end)
+{
+	struct ceph_subvolume_metrics_tracker *tracker;
+	u64 subvol_id;
+	s64 delta_us;
+
+	if (!mdsc || !ci || !bytes)
+		return;
+
+	tracker = &mdsc->subvol_metrics;
+	atomic64_inc(&tracker->record_calls);
+
+	if (!ceph_subvolume_metrics_enabled(tracker)) {
+		atomic64_inc(&tracker->record_disabled);
+		return;
+	}
+
+	subvol_id = READ_ONCE(ci->i_subvolume_id);
+	if (!subvol_id) {
+		atomic64_inc(&tracker->record_no_subvol);
+		return;
+	}
+
+	delta_us = ktime_to_us(ktime_sub(end, start));
+	if (delta_us <= 0)
+		delta_us = 1;
+
+	ceph_subvolume_metrics_record(tracker, subvol_id, is_write,
+				      bytes, (u64)delta_us);
+}
+
+int __init ceph_subvolume_metrics_cache_init(void)
+{
+	ceph_subvol_metric_entry_cachep = KMEM_CACHE(ceph_subvol_metric_rb_entry,
+						    SLAB_RECLAIM_ACCOUNT);
+	if (!ceph_subvol_metric_entry_cachep)
+		return -ENOMEM;
+	return 0;
+}
+
+void ceph_subvolume_metrics_cache_destroy(void)
+{
+	kmem_cache_destroy(ceph_subvol_metric_entry_cachep);
+}
diff --git a/fs/ceph/subvolume_metrics.h b/fs/ceph/subvolume_metrics.h
new file mode 100644
index 000000000000..6f53ff726c75
--- /dev/null
+++ b/fs/ceph/subvolume_metrics.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _FS_CEPH_SUBVOLUME_METRICS_H
+#define _FS_CEPH_SUBVOLUME_METRICS_H
+
+#include <linux/types.h>
+#include <linux/rbtree.h>
+#include <linux/spinlock.h>
+#include <linux/ktime.h>
+#include <linux/atomic.h>
+
+struct seq_file;
+struct ceph_mds_client;
+struct ceph_inode_info;
+
+/**
+ * struct ceph_subvol_metric_snapshot - Point-in-time snapshot of subvolume metrics
+ * @subvolume_id: Subvolume identifier (inode number of subvolume root)
+ * @read_ops: Number of read operations since last snapshot
+ * @write_ops: Number of write operations since last snapshot
+ * @read_bytes: Total bytes read since last snapshot
+ * @write_bytes: Total bytes written since last snapshot
+ * @read_latency_us: Sum of read latencies in microseconds (for avg calculation)
+ * @write_latency_us: Sum of write latencies in microseconds (for avg calculation)
+ */
+struct ceph_subvol_metric_snapshot {
+	u64 subvolume_id;
+	u64 read_ops;
+	u64 write_ops;
+	u64 read_bytes;
+	u64 write_bytes;
+	u64 read_latency_us;
+	u64 write_latency_us;
+};
+
+/**
+ * struct ceph_subvolume_metrics_tracker - Tracks per-subvolume I/O metrics
+ * @lock: Protects @tree and @nr_entries during concurrent access
+ * @tree: Red-black tree of per-subvolume entries, keyed by subvolume_id
+ * @nr_entries: Number of entries currently in @tree
+ * @enabled: Whether collection is enabled (requires MDS feature support)
+ * @snapshot_attempts: Debug counter: total ceph_subvolume_metrics_snapshot() calls
+ * @snapshot_empty: Debug counter: snapshots that found no data to report
+ * @snapshot_failures: Debug counter: snapshots that failed to allocate memory
+ * @record_calls: Debug counter: total ceph_subvolume_metrics_record() calls
+ * @record_disabled: Debug counter: record calls skipped because disabled
+ * @record_no_subvol: Debug counter: record calls skipped (no subvolume_id)
+ * @total_read_ops: Cumulative read ops across all snapshots (never reset)
+ * @total_read_bytes: Cumulative bytes read across all snapshots (never reset)
+ * @total_write_ops: Cumulative write ops across all snapshots (never reset)
+ * @total_write_bytes: Cumulative bytes written across all snapshots (never reset)
+ */
+struct ceph_subvolume_metrics_tracker {
+	spinlock_t lock;
+	struct rb_root_cached tree;
+	u32 nr_entries;
+	bool enabled;
+	atomic64_t snapshot_attempts;
+	atomic64_t snapshot_empty;
+	atomic64_t snapshot_failures;
+	atomic64_t record_calls;
+	atomic64_t record_disabled;
+	atomic64_t record_no_subvol;
+	atomic64_t total_read_ops;
+	atomic64_t total_read_bytes;
+	atomic64_t total_write_ops;
+	atomic64_t total_write_bytes;
+};
+
+void ceph_subvolume_metrics_init(struct ceph_subvolume_metrics_tracker *tracker);
+void ceph_subvolume_metrics_destroy(struct ceph_subvolume_metrics_tracker *tracker);
+void ceph_subvolume_metrics_enable(struct ceph_subvolume_metrics_tracker *tracker,
+				   bool enable);
+void ceph_subvolume_metrics_record(struct ceph_subvolume_metrics_tracker *tracker,
+				   u64 subvol_id, bool is_write,
+				   size_t size, u64 latency_us);
+int ceph_subvolume_metrics_snapshot(struct ceph_subvolume_metrics_tracker *tracker,
+				    struct ceph_subvol_metric_snapshot **out,
+				    u32 *nr, bool consume);
+void ceph_subvolume_metrics_free_snapshot(struct ceph_subvol_metric_snapshot *snapshot);
+void ceph_subvolume_metrics_dump(struct ceph_subvolume_metrics_tracker *tracker,
+				 struct seq_file *s);
+
+void ceph_subvolume_metrics_record_io(struct ceph_mds_client *mdsc,
+				      struct ceph_inode_info *ci,
+				      bool is_write, size_t bytes,
+				      ktime_t start, ktime_t end);
+
+static inline bool ceph_subvolume_metrics_enabled(
+		const struct ceph_subvolume_metrics_tracker *tracker)
+{
+	return READ_ONCE(tracker->enabled);
+}
+
+int __init ceph_subvolume_metrics_cache_init(void);
+void ceph_subvolume_metrics_cache_destroy(void);
+
+#endif /* _FS_CEPH_SUBVOLUME_METRICS_H */
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index f6bf24b5c683..a60f99b5c68a 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -21,6 +21,7 @@
 #include "mds_client.h"
 #include "cache.h"
 #include "crypto.h"
+#include "subvolume_metrics.h"
 
 #include <linux/ceph/ceph_features.h>
 #include <linux/ceph/decode.h>
@@ -963,8 +964,14 @@ static int __init init_caches(void)
 	if (!ceph_wb_pagevec_pool)
 		goto bad_pagevec_pool;
 
+	error = ceph_subvolume_metrics_cache_init();
+	if (error)
+		goto bad_subvol_metrics;
+
 	return 0;
 
+bad_subvol_metrics:
+	mempool_destroy(ceph_wb_pagevec_pool);
 bad_pagevec_pool:
 	kmem_cache_destroy(ceph_mds_request_cachep);
 bad_mds_req:
@@ -1001,6 +1008,7 @@ static void destroy_caches(void)
 	kmem_cache_destroy(ceph_dir_file_cachep);
 	kmem_cache_destroy(ceph_mds_request_cachep);
 	mempool_destroy(ceph_wb_pagevec_pool);
+	ceph_subvolume_metrics_cache_destroy();
 }
 
 static void __ceph_umount_begin(struct ceph_fs_client *fsc)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index c0372a725960..a03c373efd52 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -167,6 +167,7 @@ struct ceph_fs_client {
 	struct dentry *debugfs_status;
 	struct dentry *debugfs_mds_sessions;
 	struct dentry *debugfs_metrics_dir;
+	struct dentry *debugfs_subvolume_metrics;
 #endif
 
 #ifdef CONFIG_CEPH_FSCACHE
-- 
2.34.1


