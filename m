Return-Path: <linux-fsdevel+bounces-74317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C639ED3990F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 19:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7875A3009119
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E53002DF;
	Sun, 18 Jan 2026 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9d6lnp8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jqGA+qUb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37F323D7F0
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760696; cv=none; b=Bot6V7NQHBb3NhW1sirHmHMLBtTt5+FBg9HNCZ/emkXpWphhHllmdewQ8010E5qtpPRVgRsaDvkTNbKBRAYlUsgTGoXuwISTFLv2mDDqFbtMF+WhRzc+KxgJTLl4OLl/P7CFmG5RdEkSqRwLpVnUEFC1uCjUcESH/Oi+MLLDLQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760696; c=relaxed/simple;
	bh=nPEhPkD10hC+GpsZeDFNJSEYHmw8sFy68AY4FhVYwR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VnZ6VAqY/IsqMV/eNa/yNA53o3feLp+9XrBahSNbuTyOp/ffrtRVtzIgcGe0J3299P7w26lpwg85+lXRdSHc6QYF7dj83mfHytSWqr8MnOa8GoElNMQyj5VQNrCqw74snDrUoEARbL6yQ3Bv1zr8JQTgnx+jmUaT+PNmiZp/wkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9d6lnp8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jqGA+qUb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768760692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w1+GT9EQxbeHPApupCoRMAMRZESisIrjFxYmz2JRtDA=;
	b=J9d6lnp8uJgP9nIB1eiQRLd+uoAWgtJoD2aRLmovtaM+MRMI3faGDc4D0avxvLydGMvH12
	3VrclLreinqAL3LlCix9ierTq2HXFclc41DIFAFlCLKKW2MdzQlWd8ErHf0QfoXzg31xNw
	ryGpXbDVjd0bgLUIc7mF19FWSkAttW4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-mxwpZ7jhNaCdy58QlxeyVg-1; Sun, 18 Jan 2026 13:24:51 -0500
X-MC-Unique: mxwpZ7jhNaCdy58QlxeyVg-1
X-Mimecast-MFC-AGG-ID: mxwpZ7jhNaCdy58QlxeyVg_1768760690
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8749dd495dso333963866b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 10:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768760690; x=1769365490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w1+GT9EQxbeHPApupCoRMAMRZESisIrjFxYmz2JRtDA=;
        b=jqGA+qUbZ1z8Z+tCXOusGqfTwxzIfTSFFVnNUCRSq5KDrIAlOVtQ+OWer/keV+iHki
         xwnYPjx3NEriAfSUzGkiRAHYh5h02xFz4N1erVjqT9+oSSMZyjHEUFcgbfDh5uqRT4ml
         EaUlbE0mQ/EUBnDtgCh4WQGsbGiOmOqVNBAXn2f3YY0QC8gHm/ScG0MaUS9mmB73/E7E
         EZzX7MNH1KztBOrllNrqWLFbRiI8jcl/BbCTy26hoLFKAykLVliM5zgndOBqPEiDcY/f
         jyWx0Q7Te9PR0P0lwt4o2z7lx8DdifrEhhw/AcSPq5Oh4g9Wke9++rq78nx6HSFTBR7b
         CT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760690; x=1769365490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1+GT9EQxbeHPApupCoRMAMRZESisIrjFxYmz2JRtDA=;
        b=I+qFjm/SUfyPce3Ucp2IjpFYJr+bVIownA9ekw/ZG9DqEmvZK1iwJrHP7CLGFsYI1b
         OqMqXfk0yTF1vzeRDvEYHpgzyUnpPbwdt8QqcR/5QKdrvozykYG0ge72rTXt1eD36BrX
         0cVRfkULlQTTtAYVqlCka+v3Ul31P36DrXfQ9X6uqgxVLK0e/OMhS2BZPvdxrBaPZ2s8
         Kf0ycyarInh/lw6AHUDYvZOVk4K0+I8aQAnbuMuYpBvGBHB4GsFktlR33x5/YVO63jKr
         So/0q6MRHVNlLRkWr1dFTIbl2i6qW8yLl9pushfKVAjfiwyJm9Ojepw+HM3tobPsckWw
         i9IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNFjamCbbEzNwz6NNS7wIR5t2m24gREaUFLotFCN3s8lGpVkTTlWC0NWWGzQYuDO5kAOtRWapWeVaDFudr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+crLZFIKqHCS0e58Z2zhcdm6SEyAHNi1zpxDXSmro0Q1KjKt
	HVo8Jtuz1bRfctybPImMyA1+nyjv7kiAHQXnBJ3OpxXqQLGUL6UIyaLdTemq05qikl0a6G6Tlo3
	dTZKpzUQfmlprfzyIWfKPHvxp7MPazr9sXetxP55oV58QoEI9lJceSJmuT38xaWQrneA=
X-Gm-Gg: AY/fxX6dxIB5/79RVQ7pvuM3v9CM7umJhRh/5hCN9IEJskzrWvQ8Acl5If8/sJYFxuu
	Six7xKyY1EQ80kAqCmHWt2kk/qpE/pZRPYynyH0K3bJq9Zqb1cn9KcoF/0wxm4C6muN+J08zzju
	7Nmms2y/RNIUzm5KCnbSNW4ZKgB007VgJuyVq03vddHw/vc5WyWlny6u44XI5+lbozCBqHBStV2
	UKrUekEA3/+ElF6qcf0ESCBmFmeH8r85QDaMF2C44GSFyvCNd72q/3WvPA2QYtTMzOlQ/sUiQjo
	tfCSRgaRaOfrvvOTscFX5s/RTIrw+n3+quz6d2BTGQRVeUExdOtEA965utkM5aDFsaMO8/KYTEw
	wiSruYnIdXlD0PwEqfjisjz5VwUYPYjax8gFUgYZft7I=
X-Received: by 2002:a17:907:d8f:b0:b87:d44:81d with SMTP id a640c23a62f3a-b8793035657mr715401566b.45.1768760690000;
        Sun, 18 Jan 2026 10:24:50 -0800 (PST)
X-Received: by 2002:a17:907:d8f:b0:b87:d44:81d with SMTP id a640c23a62f3a-b8793035657mr715399666b.45.1768760689451;
        Sun, 18 Jan 2026 10:24:49 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e8d1sm907624666b.2.2026.01.18.10.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:24:49 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v5 0/2] ceph: add subvolume metrics reporting support
Date: Sun, 18 Jan 2026 18:24:43 +0000
Message-Id: <20260118182446.3514417-1-amarkuze@redhat.com>
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

Note: The InodeStat v8 handling patch (forward-compatible handling for
the versioned optmetadata field) is now in the base tree, so this series
starts with v9 parsing.

Patch 1 adds support for parsing the subvolume_id field from InodeStat
v9 and storing it in the inode structure for later use. This patch also
introduces CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset
state and enforces subvolume_id immutability with WARN_ON_ONCE if
attempting to change an already-set subvolume_id.

Patch 2 adds the complete subvolume metrics infrastructure:
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

Debugfs additions in Patch 2:
- metrics/subvolumes: displays last sent and pending subvolume metrics
- metrics/metric_features: displays MDS session feature negotiation
  status, showing which metric-related features are enabled (including
  METRIC_COLLECT and SUBVOLUME_METRICS)

Changes since v4:
- Merged CEPH_SUBVOLUME_ID_NONE and WARN_ON_ONCE immutability check
  into patch 1 (previously split across patches 2 and 3)
- Removed unused 'cl' variable from parse_reply_info_in() that would
  cause compiler warning
- Added read I/O recording in finish_netfs_read() for netfs read path
- Simplified subvolume_metrics_dump() to use direct rb-tree iteration
  instead of intermediate snapshot allocation
- InodeStat v8 patch now in base tree, reducing series from 3 to 2
  patches

Changes since v3:
- merged CEPH_SUBVOLUME_ID_NONE patch into its predecessor

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


Alex Markuze (2):
  ceph: parse subvolume_id from InodeStat v9 and store in inode
  ceph: add subvolume metrics collection and reporting

 fs/ceph/Makefile            |   2 +-
 fs/ceph/addr.c              |  14 ++
 fs/ceph/debugfs.c           | 157 +++++++++++++++++
 fs/ceph/file.c              |  68 +++++++-
 fs/ceph/inode.c             |  41 +++++
 fs/ceph/mds_client.c        |  72 ++++++--
 fs/ceph/mds_client.h        |  14 +-
 fs/ceph/metric.c            | 183 ++++++++++++++++++-
 fs/ceph/metric.h            |  39 ++++-
 fs/ceph/subvolume_metrics.c | 416 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/subvolume_metrics.h |  97 +++++++++++
 fs/ceph/super.c             |   8 +
 fs/ceph/super.h             |  11 ++
 13 files changed, 1094 insertions(+), 28 deletions(-)
 create mode 100644 fs/ceph/subvolume_metrics.c
 create mode 100644 fs/ceph/subvolume_metrics.h

--
2.34.1


