Return-Path: <linux-fsdevel+bounces-71979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9232BCD94E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 13:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B6D9304B002
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49047338925;
	Tue, 23 Dec 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLK/B+Xz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rt8hrrf7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6837133859B
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493322; cv=none; b=l9Z0UW2FdK9ve3sukgNLlwfrVXxYYld/QgWspWz0rAFlr629horuWEtlrl1VOk6YZqGv5/ipgAwFDUwiV7fr5M15pMTPGHOGCsdMIlsl5vOg5C7d/buT2abEpTAqrCVT1mO4GYejtC7p3eeW3rjE4HZOvEwIdS6SabdptDDx8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493322; c=relaxed/simple;
	bh=Zp7ZrL2wpTgCqD6NJHJeQG5+50UDDeLVh65DlTT+dUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B4kLuF+jh7eZJYO/OfDMN6TE6I6k4beBBH48ud+0viWc/X5OCtGVRkMuX+JJ1dy2xGHEjz7Vn6p17ZezLK4f0CSwM6D4CnyahMJP+l67xcgNp+bLvGKszFNUXirQmHKEOebK9BpnUlFj+LJr+mnDN1Oiq7vxTqpwEcu0Urorob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLK/B+Xz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rt8hrrf7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766493318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DSdWHgvhJGn7RbB2GAuzD8Ky9Z74RCwiMxPz6+Zvz2U=;
	b=ZLK/B+Xzdl80bzf63HzfvC0t3sncmYUjZAx+C+4EUUMaT82xw+QMEBXiqAaMh/ZdAdZEHW
	oaJWlQNIbAwjIwsXQ66GRpLkvNYFw6wmIQ8p/W44EFZIYKWqZ41S6vUep8tvFS6HUp07v5
	BMFPMXKnE0DC+t7b6b4/CP53w7CPrOA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340--pCF-Tf4PNy5EROKE8dNKA-1; Tue, 23 Dec 2025 07:35:17 -0500
X-MC-Unique: -pCF-Tf4PNy5EROKE8dNKA-1
X-Mimecast-MFC-AGG-ID: -pCF-Tf4PNy5EROKE8dNKA_1766493316
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b70b1778687so448317566b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 04:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766493316; x=1767098116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DSdWHgvhJGn7RbB2GAuzD8Ky9Z74RCwiMxPz6+Zvz2U=;
        b=rt8hrrf7PLm77ZeJfJ87texmXEvLxlenHVaIn/mc5oRoBO7PvM+YdRCw5iWx/wOQnM
         HwmBXEgYD9+Uh+UP+G5yd3NKmI1n2mrdHsgLksl72FYtVmJL530GDzkRRWxvdDMBWKUT
         Ae36yUgElKj6bWQ1m1OM/A47NJ0Mysf4JBE1g5TsDC8e+Lmh4hB2Zn4f6eO2xP8x+gw2
         kXWt5zFX3quGNcycO0CS+3Rx97yTCoNrWdTDU/VAIZqFl1XwtHBrBYEdB2GPdDlLCR4z
         6dLohAK7CTbWxVynzFLc2bL0KKrBImjkPhuIk9136L3dtG7kzBVqSfRqxuSxfAPGbWmh
         TQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766493316; x=1767098116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSdWHgvhJGn7RbB2GAuzD8Ky9Z74RCwiMxPz6+Zvz2U=;
        b=ALB6qcF8TPaHfKXLTfUbyNMwAbamvzZaMqFNEIlkEAP/cdbpP78MP07gQ7KPFytDj5
         so9A5LTX0HZ/Mj26qHYFX/rqH3VG8brY3tOn9d73CaanfbhtVFzy9skBEwFP0Qjmrx7e
         8gzr6Ez09fBBMSTkzuZQhl1Dji0tRwOXGOXKBMGvMtocSF/taZwsynJf9UpqkxiuN8EJ
         uThEObc4xBJHc9B1Z5clf5OwZAH3Qn1rfBbz6QV+GzScvUp3bMurxPnpDcZkTARyYisH
         qzPbN30jIPTnhm98ld6FQGbo6mr2Xindds4WvzSJHodntwPX0mUbERK7NJexJEFkeHP7
         TNvA==
X-Forwarded-Encrypted: i=1; AJvYcCValPGx1xzX5GFUCICc3zqQJkusL3UVzpsv4hrWOaJe0YEeIG3xmvTmN8BMRvBTBsaQNXDlVZBCeV5f4TVp@vger.kernel.org
X-Gm-Message-State: AOJu0YwutT02VoQ1KeZPjpcLnYC0mj5MeGGUzlYtvT3VeMP2cQhOuWHJ
	5KFHWqwgT1d1MtgVqpyewxgFdo38mPAAQ4PW4fy9Ui1o54Q19w8vH3rvdUGd8XSR+8DQz0lWrxt
	fIZJSA5ddI9gZXb/HhdedDJKDNbxQTlXTdnrSmDu6DpA4LwBC6MEH8NbeHFU9tkS4wso=
X-Gm-Gg: AY/fxX6pm55kFMQR3+30oHPngO87UNNn/u3oRVvFaJrrFB7p4JOaoUKnnc+Xod5TsRZ
	zf8Mz087t1LIduYHBvCGNeeE1k78XoCqZQIN+25tTh++k7ggRpxC9IuJnaQeHyQtkTkicijD8Ay
	dmQzl1vGnKRgDqIwN79hNurWCmN/Nzfd7AR1jwI3KMXceb44SftqSv2P0A0LLBWcwxiSB+PdVHe
	h/uIXhKEDSzVQvEMGj+IK3hjsr5taJv9aEOqkRi6PS2yoFl9RadGBec7gajJKsc/dJdTTAN39MZ
	p1yTs/xmDzlNos/6n+G2pgH/ursp6l/SZPgWiQU0zxY4TZW0LmFw51iXZ9+UrBypexW1YGYj9QL
	jJPu6TaR8Yv0NDZkmkzjZMCJCb4f6qOidpLlkJYaupBk=
X-Received: by 2002:a17:907:1b1d:b0:b76:5393:758d with SMTP id a640c23a62f3a-b8037155d9bmr1284616166b.34.1766493315690;
        Tue, 23 Dec 2025 04:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCy7k4ESHeDFd6TWUY2NNtfU0x+/Yhc1CTnCq/hakeZ5Idg+9TpsHj8IPpnNy89S/S1lnDrw==
X-Received: by 2002:a17:907:1b1d:b0:b76:5393:758d with SMTP id a640c23a62f3a-b8037155d9bmr1284614366b.34.1766493315210;
        Tue, 23 Dec 2025 04:35:15 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1353357366b.57.2025.12.23.04.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:35:14 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v4 0/3]  ceph: add subvolume metrics reporting support
Date: Tue, 23 Dec 2025 12:35:07 +0000
Message-Id: <20251223123510.796459-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for per-subvolume I/O metrics collection
and reporting to the MDS. This enables administrators to monitor I/O
patterns at the subvolume granularity, which is useful for multi-tenant
CephFS deployments where different subvolumes may be allocated to
different users or applications.

The implementation requires protocol changes to receive the subvolume_id
from the MDS (InodeStat v9), and introduces a new metrics type
(CLIENT_METRIC_TYPE_SUBVOLUME_METRICS) for reporting aggregated I/O
statistics back to the MDS.

Patch 1 adds forward-compatible handling for InodeStat v8. The MDS v8
encoding added a versioned optmetadata field containing optional inode
metadata such as charmap (for case-insensitive/case-preserving file
systems). The kernel client does not currently support case-insensitive
lookups, so this field is skipped rather than parsed. This ensures
forward compatibility with newer MDS servers without requiring the
full case-insensitivity feature implementation.

Patch 2 adds support for parsing the subvolume_id field from InodeStat
v9 and storing it in the inode structure for later use.

Patch 3 adds the complete subvolume metrics infrastructure:
- CEPHFS_FEATURE_SUBVOLUME_METRICS feature flag for MDS negotiation
- Red-black tree based metrics tracker for efficient per-subvolume
  aggregation with kmem_cache for entry allocations
- Wire format encoding matching the MDS C++ AggregatedIOMetrics struct
- Integration with the existing CLIENT_METRICS message
- Recording of I/O operations from file read/write and writeback paths
- Debugfs interfaces for monitoring

Metrics tracked per subvolume include:
- Read/write operation counts
- Read/write byte counts
- Read/write latency sums (for average calculation)

The metrics are periodically sent to the MDS as part of the existing
metrics reporting infrastructure when the MDS advertises support for
the SUBVOLUME_METRICS feature.

Debugfs additions in Patch 3:
- metrics/subvolumes: displays last sent and pending subvolume metrics
- metrics/metric_features: displays MDS session feature negotiation
  status, showing which metric-related features are enabled (including
  METRIC_COLLECT and SUBVOLUME_METRICS)

Patch 3 introduces CEPH_SUBVOLUME_ID_NONE constant and enforces
subvolume_id immutability. Following the FUSE client convention,
0 means unknown/unset. Once an inode has a valid (non-zero) subvolume_id,
it should not change during the inode's lifetime.

Changes since v3:
- merged CEPH_SUBVOLUME_ID_NONE patch into its prediseccor

Changes since v2:
- Add CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset state
- Add WARN_ON_ONCE if attempting to change already-set subvolume_id
- Add documentation for struct ceph_session_feature_desc ('bit' field)
- Change pr_err() to pr_info() for "metrics disabled" message
- Use pr_warn_ratelimited() instead of manual __ratelimit()
- Add documentation comments to ceph_subvol_metric_snapshot and
  ceph_subvolume_metrics_tracker structs
- Use kmemdup_array() instead of kmemdup() for overflow checking
- Add comments explaining ret > 0 checks for read metrics (EOF handling)
- Use kmem_cache for struct ceph_subvol_metric_rb_entry allocations
- Add comment explaining seq_file error handling in dump function

Changes since v1:
- Fixed unused variable warnings (v8_struct_v, v8_struct_compat) by
  using ceph_decode_skip_8() instead of ceph_decode_8_safe()
- Added detailed comment explaining InodeStat encoding versions v1-v9
- Clarified that "optmetadata" is the actual field name in MDS C++ code
- Aligned subvolume_id handling with FUSE client convention (0 = unknown)


Alex Markuze (3):
  ceph: handle InodeStat v8 versioned field in reply parsing
  ceph: parse subvolume_id from InodeStat v9 and store in inode
  ceph: add subvolume metrics collection and reporting

 fs/ceph/Makefile            |   2 +-
 fs/ceph/addr.c              |  10 +
 fs/ceph/debugfs.c           | 159 +++++++++++++
 fs/ceph/file.c              |  68 +++++-
 fs/ceph/inode.c             |  41 ++++
 fs/ceph/mds_client.c        |  94 ++++++--
 fs/ceph/mds_client.h        |  14 +-
 fs/ceph/metric.c            | 173 ++++++++++++++-
 fs/ceph/metric.h            |  27 ++-
 fs/ceph/subvolume_metrics.c | 432 ++++++++++++++++++++++++++++++++++++
 fs/ceph/subvolume_metrics.h |  97 ++++++++
 fs/ceph/super.c             |   8 +
 fs/ceph/super.h             |  11 +
 13 files changed, 1108 insertions(+), 28 deletions(-)
 create mode 100644 fs/ceph/subvolume_metrics.c
 create mode 100644 fs/ceph/subvolume_metrics.h

-- 
2.34.1


