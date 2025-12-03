Return-Path: <linux-fsdevel+bounces-70570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A73C9FB1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 16:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 551BE308BD93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0EB3148D5;
	Wed,  3 Dec 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivFOiGfr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxDA+QCj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5E308F13
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776796; cv=none; b=graEUG9dG3VseGH/8SMbaW8y8dBu/esCB99g3FNCChJFzs++IRgLj02MBsrTuOE0Cl+otKCG2ckoYcJuqsShHehjJKpihuBWSTmCfUxgDoPuUlYMql/AM44AhGaJzigasro5j74tucC5/NNTAeW5mMDcL/D3Roa9lMNBteeWFLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776796; c=relaxed/simple;
	bh=bj2EwI61n9F2t+9IZTIICRBO44EJkPlt8/0ivYbXTho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LmdtXbfSv/hYqZGrKumyr9tSwRn902dik3QuYTz0psRJud0hVNbK3sDuvi9h4TfppkxQ+XiXqehQZR+5j0wTyNR/zpA/LceX/duFVN/dXkjuWnma3OsZ6hlhGiXt5HJTa8OnR82M7Dfm/PSV6CEYtwlPTSCxBd02d6yhOMft9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivFOiGfr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxDA+QCj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764776791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0iQO31qcw4QjDG40PDHPDzMgTgEG3pxt6R/E9VpcD+I=;
	b=ivFOiGfr4zAIiR2N1R9T2OsEtjSsk9OfQl+1X5OlNqFTNk2LE7Cykl0tBcxglNxzXytxbp
	1+Eta1L4blTZMc24r9itqnIXNKQkDy2UbwRDNSpJ/rgdcTkGPhS5UkjMwSavsWxOcuQunj
	qDjVada0LcAf+6aHbDrNaAtkLxjqlpo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-x7FJODsdMhaczwoRt14FRQ-1; Wed, 03 Dec 2025 10:46:30 -0500
X-MC-Unique: x7FJODsdMhaczwoRt14FRQ-1
X-Mimecast-MFC-AGG-ID: x7FJODsdMhaczwoRt14FRQ_1764776789
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64537824851so6482900a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 07:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764776789; x=1765381589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0iQO31qcw4QjDG40PDHPDzMgTgEG3pxt6R/E9VpcD+I=;
        b=QxDA+QCjvdXsR2lfKz9jpfEyk9vYhS2/2SsvDwS4K+HLYmWInMGTv2pH1ZuzcUS6J9
         +17flZVqmVDpk5LMqvSCIbgYyZajrC2GURco9I4f1OkURtc/GuHC+2gkGzruuqtg7n0g
         E/LxtIgWpFT0voCi3pms5WPjJJIJ+RVi6XTXcNaJqseJKnp8F8BCF8v7mDiQRuwRCmjl
         L6hNmPMXGgMMQDSOru8zbxyJz6uXL5iqZ1Q/rcArnqSn3AaCkmKM9sHG905MF3l5LC52
         mYqdK9VwE/c+fPwaeZaHSNCZ8R4DusWOJMp8KB6HdGSSuOdleLcGzsqlcET7yvlsg22A
         wv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764776789; x=1765381589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iQO31qcw4QjDG40PDHPDzMgTgEG3pxt6R/E9VpcD+I=;
        b=e/HQaiBtAgp6Lt9Q1C/rh8Rr/PnSvy7Sc4LQQQycCZgVaRPNy+mei1eg02NZPLivRY
         AOd5wKJLwHq/nks3HKKl6bkQ4SPmTaEnIza0EgL6jL04inaQIBNX9XrrgKWfwUJJD7u9
         jrg1ci1D7tk1RG9PhgizcZhnEnKs348aGU+65i6wCoTVL2p+gyasU7lrSBimJncBbd9b
         PYIPR0wEmNGVNV1XOog+B3B5gK5RFSAuIQU474gOqRbLJ6i5ik2yqtE6ZVxaxRDrcd9r
         g2x8dX0o8EsigjNfPTgjdj7ZJYTDvQsvD0qzbYrtvSBDrCNdY4CIRJcXTB1gbhMaXNu5
         zaTg==
X-Forwarded-Encrypted: i=1; AJvYcCWbero9Bnvyvd6QBufQqSuwykOGxRvKT6mX1VnDiOf0s3dc2/dJqYqxuTnE1Fp0LzUSnrLV6JkR6Je81Kdf@vger.kernel.org
X-Gm-Message-State: AOJu0YzrWlPXLEPjOJ0/DVZH49yhG6PnoaRj7UyuwmoIZxLRCJWrBL2J
	Uh/wFsq9E9IdPtxAvDxWiYED4ilDFtidU9kyG3LdCsBn7BqY+Vo0fYIMyWHk9n0hLgARuBO4vjV
	2f1E2aZa/cjDRX1YdSbjUpXtngAH+wh7LmG6xQzd48b9hJ49x2tULfgiQEFU3yCfjrMQ=
X-Gm-Gg: ASbGncsGXYvtnfoIYLI3m8I07gYahPhYTTZ1VfrHd0GGAccBRS8oczuyLdSyoEZQ7O0
	A4GjvT/JqcML/qVzzLXQQN8XZ3sjOR9EadBLGZ9TF7lQCa1PAmTvbtR/qgwmAy3fYUZSAPijYsh
	R3134fMV1ivZiABsT7J3Jnvo186kxDhqPviAEH0aKlfAnrEwE8b7MYFV84wugI98zw+xCj0qYkg
	DSVN49JhuBg2Xu782H6cmao9tRrtg04v15OF8XFuZsHpFJBc4b8WN+jMTz9l6bId/2pWIz07pTP
	SfDcElA8O81sEkEE1yFiy4Y8GVX8VrUoyRkflqs0SQ8yy1YXL95ih2nyrA3ZGKare7vPPUpodEG
	eF9cgThl/9Ka/RNB1e4C+gg4/fAIPBEyNlwabYmc/nVw=
X-Received: by 2002:a05:6402:440a:b0:640:6512:b9f with SMTP id 4fb4d7f45d1cf-6479c4ac547mr2708115a12.28.1764776788879;
        Wed, 03 Dec 2025 07:46:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMSQLz8/Ubp/hYcJgzQ5VVZewzvGKT01GpbwIIoYF/hCaDdY3/w0FT9wYq464vlfi31yebjg==
X-Received: by 2002:a05:6402:440a:b0:640:6512:b9f with SMTP id 4fb4d7f45d1cf-6479c4ac547mr2708081a12.28.1764776788483;
        Wed, 03 Dec 2025 07:46:28 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm18529786a12.29.2025.12.03.07.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 07:46:28 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v3 0/4] ceph: add subvolume metrics reporting support
Date: Wed,  3 Dec 2025 15:46:21 +0000
Message-Id: <20251203154625.2779153-1-amarkuze@redhat.com>
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

Patch 4 introduces CEPH_SUBVOLUME_ID_NONE constant and enforces
subvolume_id immutability. Following the FUSE client convention,
0 means unknown/unset. Once an inode has a valid (non-zero) subvolume_id,
it should not change during the inode's lifetime.

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

Alex Markuze (4):
  ceph: handle InodeStat v8 versioned field in reply parsing
  ceph: parse subvolume_id from InodeStat v9 and store in inode
  ceph: add subvolume metrics collection and reporting
  ceph: adding CEPH_SUBVOLUME_ID_NONE

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


