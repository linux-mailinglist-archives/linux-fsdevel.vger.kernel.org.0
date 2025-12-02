Return-Path: <linux-fsdevel+bounces-70464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D94C9C0D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 16:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D9824E3EE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB05A3242DB;
	Tue,  2 Dec 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MR1mpnrN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTTeoTFE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA05324707
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691080; cv=none; b=kaMoVbIzcXCxsD5r8jJ9SQf+VmHZhUsPMSGmfUZIP581lc7xcdDsKCGSGyF2DtJ0cklB1iwmG5fjrd/XPQOvWNRViorL5HlyuyUuOGriLdJaGQibfapRNHAehpq2atDYIR6FU64KBva1s64OK6+nw298ZMeSSNMSjgedyf84hOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691080; c=relaxed/simple;
	bh=rX2IgrIqcF6IEM7gSm025k9RsEr644ZeRcwFDAA/X3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aVKCnrNWd7li+Ze53NL5WV6s6C0jStpEfprOIpalolMbZRfmnBDp5bDG1UdckzXYVMPTBlB1PNPeXd0fqrbHdQAUuQ/C/Ro0GWHP++k88it6EvzrhIVxbRF+iidZU1BtUlCqx+zAw3nw+Nn8/tni0+w1yPwHoe7qlogstEgJoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MR1mpnrN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTTeoTFE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764691077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K+JZDDX0YSxfiuatTCZt13y1SraeSniBJJpMPYFkVF4=;
	b=MR1mpnrNYaLuIcclrBA1ybcBbJPbwRaKTGalfSVcdJP9UJhVnfQ3fCzLrxBSg3RXnSQ+ly
	Ey6+Wb/xtaKDo5cUXrXzkPupWaBnkf9XZntJxiEB7zbF1vUAKB1nDe/SBPLa2sAJNvVG5J
	4cwPDBZwxawkJYalN9idSSTFT0HiqCA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-FSuX9Y6xM_OwwDIPqJXJ1w-1; Tue, 02 Dec 2025 10:57:56 -0500
X-MC-Unique: FSuX9Y6xM_OwwDIPqJXJ1w-1
X-Mimecast-MFC-AGG-ID: FSuX9Y6xM_OwwDIPqJXJ1w_1764691075
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b72e06680d4so752675866b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 07:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764691075; x=1765295875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+JZDDX0YSxfiuatTCZt13y1SraeSniBJJpMPYFkVF4=;
        b=gTTeoTFEJwZhffMkG7/NaU5/eKG+I7H5Ns0FR66iOu3Vgsj89r66Hm8JsyEWW6N3Wj
         FGJG7ijQ34sRzHZhY1m6T77Q+eSCKT7TCMEH93CsltO1h5VMbDdeuvtWwgi7Tjz/7GGi
         NWJjUIMoZgjjYpQvoN/OHSz97t8br9U4+wQBTlI8rNZo+Fhvh8QgSHgrhsm1A8nb/Vi0
         JtuvpO6axSL5KU5wVpkWUsr+/iXIcXuvTMqjk2EqopRIsUkb46phC0alVlroduXkiTgL
         dhIZ5IkneDNg5jrVwg/ypjU//dfAnx4Kyi7SYt2aNQM0UztK4M4RPvG4gMVbLtDnFg4f
         ujQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764691075; x=1765295875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+JZDDX0YSxfiuatTCZt13y1SraeSniBJJpMPYFkVF4=;
        b=CjYKfSHKh4nwyMin/hGYb/j/y/8bkvAgLyE37eoiPnZuvPVd3FxRlrdLZXV+IkL780
         bZ7kVac5YCt31nsV+agvAanHyDx1+uDKs/AtlHqUCB+lRdtE+F1OkuIYTGsPV36F1kjE
         +yDexpad53W/8TSwmha9HmBniM5r6Oe0SU7jeDxvfbCCdhsChwMUF1pT48TM0c8axYKZ
         nF6axM/JhNNVvPUwwLHU6EEcqLiPukLhM4vRRC1im4gebJ1nx8NyGudvHff19g9FHXR1
         pdVetimMa0gxxvpeGVY/T5mioS9ZmgRggaG/MOTTqnCVMOmoY0pN84OxhQxppHuVshRW
         lzVA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ5vFK3oY4vyily4mk7gW+9XorxKj6TvWRpRxhbsgdIzKKxVehl0ACeIoAEsXkTZivfnYOSuro255fwHre@vger.kernel.org
X-Gm-Message-State: AOJu0YxRpmuLtn4nbRKI10pjM2hJFIagagolMBYX7d4DE7n51p6nxOnU
	hfiNQLD29fJ6Z4AXni0qa0kcJUf3zCuxE4mp7IaGERP6a3kk1tvzZ02H01uTNMjUw/i6PDz+iH2
	3mppBv3hTjMW0g+k2unud3FjAADyp+5nKlTL4nkBSdWKLoin+gZnxll5fCVlG+opB410=
X-Gm-Gg: ASbGncvJklT+SJTp8T4VheJnfZBd9ggmvk8ljMAg9K3O7gG3FPGJ2ShYSoLDUcEpkPJ
	4CcchUYFYsbxv4hWCDz/DuQrQ7IT7LzjPj4sGIo53BHWmJvY2n88jpuCS9H/R0hE+IAUrY9ip+n
	E/r7D0C2szsmVwHKxWdjQENIUfDaWc1dh+ExYzCE6ScbCqN5sNSmCByIioFUHMhm9/mAaSm2//e
	7rqPRHjx+rRUigkHCCf43elrRBTlhNZxivbV4ooXkxxYzPOpo1IOSWVf9QUZeS4qjU1j8lWDFXL
	hAKN3vM7hzZUgYBdkOTiOdneuLqEbUfTkGPF2InH/aSCQiOtuBiDqC7IpR7a4NA1xloWuTf1T/h
	R68v1EhCkN2mC4G6saMkZRAKnhLdHixY+eAyBaeYklPE=
X-Received: by 2002:a17:907:dab:b0:b73:4fbb:37a2 with SMTP id a640c23a62f3a-b7671514106mr4644535866b.5.1764691074761;
        Tue, 02 Dec 2025 07:57:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5ff5Bo0B6oODeYs3rbb9HOcwAKRRqHzyGe5AJPxl7y2wdD/DgKiLMe7eRGyww7j929rXNTg==
X-Received: by 2002:a17:907:dab:b0:b73:4fbb:37a2 with SMTP id a640c23a62f3a-b7671514106mr4644532866b.5.1764691074313;
        Tue, 02 Dec 2025 07:57:54 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59eb3f6sm1520702366b.55.2025.12.02.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:57:53 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v2 0/3] ceph: add subvolume metrics reporting support
Date: Tue,  2 Dec 2025 15:57:47 +0000
Message-Id: <20251202155750.2565696-1-amarkuze@redhat.com>
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
encoding added a versioned "optmetadata" field (this is the actual field
name in the MDS C++ code - short for "optional metadata"). This field
contains optional inode metadata such as charmap for case-insensitive/
case-preserving file systems. The kernel client does not currently
support case-insensitive lookups, so this field is skipped rather than
parsed. This ensures forward compatibility with newer MDS servers
without requiring the full case-insensitivity feature implementation.

Patch 2 adds support for parsing the subvolume_id field from InodeStat
v9 and storing it in the inode structure for later use. Following the
FUSE client convention, subvolume_id of 0 indicates unknown/unset
(the MDS only sends non-zero subvolume IDs for inodes within subvolumes).

Patch 3 adds the complete subvolume metrics infrastructure:
- CEPHFS_FEATURE_SUBVOLUME_METRICS feature flag for MDS negotiation
- Red-black tree based metrics tracker for efficient per-subvolume
  aggregation
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

Changes since v1:
- Fixed unused variable warnings in patch 1 (v8_struct_v, v8_struct_compat)
  reported by kernel test robot. Now uses ceph_decode_skip_8() instead of
  ceph_decode_8_safe() since we only need to skip the versioned field header.
- Added comprehensive comment explaining InodeStat encoding versions v1-v9.
- Clarified that "optmetadata" is the actual field name in MDS C++ code.
- Added comments documenting that subvolume_id of 0 means unknown/unset,
  following the FUSE client convention.
- Fixed smatch warning in subvolume_metrics_show() where mdsc was assumed
  to potentially be NULL but later dereferenced unconditionally.

Alex Markuze (3):
  ceph: handle InodeStat v8 versioned field in reply parsing
  ceph: parse subvolume_id from InodeStat v9 and store in inode
  ceph: add subvolume metrics collection and reporting

 fs/ceph/Makefile            |   2 +-
 fs/ceph/addr.c              |  10 +
 fs/ceph/debugfs.c           | 153 ++++++++++++++
 fs/ceph/file.c              |  58 ++++-
 fs/ceph/inode.c             |  23 ++
 fs/ceph/mds_client.c        |  97 +++++++--
 fs/ceph/mds_client.h        |  14 +-
 fs/ceph/metric.c            | 172 ++++++++++++++-
 fs/ceph/metric.h            |  27 ++-
 fs/ceph/subvolume_metrics.c | 408 ++++++++++++++++++++++++++++++++++++
 fs/ceph/subvolume_metrics.h |  68 ++++++
 fs/ceph/super.c             |   1 +
 fs/ceph/super.h             |   3 +
 13 files changed, 1010 insertions(+), 26 deletions(-)
 create mode 100644 fs/ceph/subvolume_metrics.c
 create mode 100644 fs/ceph/subvolume_metrics.h

-- 
2.34.1


