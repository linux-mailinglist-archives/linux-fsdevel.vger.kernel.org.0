Return-Path: <linux-fsdevel+bounces-70024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3A2C8E8ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1EC44E7F4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D653E2417DE;
	Thu, 27 Nov 2025 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USmr4w2h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oWcDJG6v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F901EB1A4
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251201; cv=none; b=phbFY8DJM0lbJpZg7yZYJCrBos7mNZtR6138D/LFkHKkf9/laEflzJM30V1C/97nfJVFJg1YYZo+XLMBdPiL5rVW0GgH5H8wvCM6TEEaFe0rv26Z891rjLPcIYBx7Oua4bb8o/ep313smpKPj8lQ/OE+pHAsG6l8MADxZHP25xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251201; c=relaxed/simple;
	bh=5dipwLKkDiBsRMZLfhAnVuPcmN43TKBFde0jxNTHluk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jhiRGYj5U0vJ5GjheDoBgF8szI4Elt8gmNxmBdZ/1Te9gFJBBA0sPaDi54GzRUZvr0nYWB2YPPlTEUVjxIoDFK3IJ4cts9iH3yJJTmsyJ5qN5JxMpPx8c4pfZ1K6ksOmy43SRSzmNMSBYyhzsscYW6YbsEbRy0LVTtG8+W7ue7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USmr4w2h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oWcDJG6v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764251197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qG4JU08EewP6ExK6olKFMFYTlaVeyVu1KHFPXyo0UwU=;
	b=USmr4w2h9XKboM4jJq17UzoNvm3jvtgqx0T0IANMCxMAmuftuDE3U/lA2/Dlp+Kp1T3Rwt
	sVrxBrXdop4lOpIl1FzCuyzgfnJs+m8tkypmwUCDlA3e3ZvYotiLkNpmMotTSF9548P3IV
	kyiDYvshKQzxcH0M0arV6ERhTgaSUFk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-7rTpmRLeMdm24hjvot0sSg-1; Thu, 27 Nov 2025 08:46:36 -0500
X-MC-Unique: 7rTpmRLeMdm24hjvot0sSg-1
X-Mimecast-MFC-AGG-ID: 7rTpmRLeMdm24hjvot0sSg_1764251195
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88236279bd9so19373236d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 05:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764251195; x=1764855995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qG4JU08EewP6ExK6olKFMFYTlaVeyVu1KHFPXyo0UwU=;
        b=oWcDJG6vQFHrTODJINMCOmXEApu3KuFGXkqw6qoVQg5bILzCJdfMWgBUrv6JO/C5Xi
         m9/ORPElBPQwNAgyXu7+JNCMHkXyZks2Y8+PXeKDJECrgEvIWhlaTHea9MFxFbWQgfgY
         c3iUloH9kIOkQ7SEZnp5M3Aqpzp2bAcDe5DYwf+3+L4MDp7XJJL4BOFP7qTT1O4+X464
         TZm3KabrlBWLJkMQz2+iK+t1PyjMXfJD7OviH4isjJvddHsoh39P9voiuUqTh0kT6sth
         LKJdF7IGfWuXsKDz68AG2y1PFzKcg4mzQ3eAZJp1ZGExARkSGuKs40v2BbAwJxfBIIpG
         cIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764251195; x=1764855995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qG4JU08EewP6ExK6olKFMFYTlaVeyVu1KHFPXyo0UwU=;
        b=pE0VEnTLMAQq9BUDBKn9IvFzToKGy2Vh3fc4H4IZMJ0x+0n0cBYRh7cGCLzlpgDzTO
         3vhm6Vh5zqWsi/2sZDfBaZiQz43tSYLv3wlJP1YCJ+4NNKQuCL6DbtSiJkp1a0qUOPsl
         bfJUon2+3p3OHuBsGp+0tHwg8vfreRFGfl1r5T7IcgmzGhQnECEFQklNSaAOna2ORNmI
         CY36LnhhnnvKSOVWGkFQ7y8ExJ4C9u+s1yYasiFAOT2of033UuX0h5LQ6Ah7teDshKzk
         b5FDWGIyPa/dayiswT4N0jU8lU3lhS+G9uPAMlZIDb3Fxl2EBg7OAGIQOxWCAuYBqJFh
         ZyIg==
X-Forwarded-Encrypted: i=1; AJvYcCUaIJ0+WGQ7cODUbuflrKQ/HYxmHn6oLv/LA8vmCgCDDKVNzzqSZMvMo4Qga6lOPxJAMhRobGS4AYfnnaOp@vger.kernel.org
X-Gm-Message-State: AOJu0YyfaC6GljOc1ALRiXELxznGkz/p7dtzqHAw6w/UBF4ez1NqcR5X
	aVT1oYNAeHMyOHsXbwFS6eESEuSn/Q1tF6UQ8jM83qegxjsZjJi/pBIm1rd9iQx1V4b0Od/aOFq
	8c00ghz3lmF8Rp+1ZKqHyEqcoXtJ8WwllxblJ7lkwKKxWxxsPSsoYJ8cDuTyIGyuVLrE=
X-Gm-Gg: ASbGncsbgWGYs4PvDPheN06hTCwhVgeBwgF2aNGwYBH5C2Z6MshCLvgoKbwqfP6hI+D
	wPiLej+Y/KrxbFpttw9Acd+x4BDzh9Nj85xG0faoeuTsLcgTyjWMAd2QadRJyIlXIXAYckGoIJo
	QT6tbbuPkaMbE+YhByw40ht3Zb1CSD7W3YUkWavOcx7tvJHvScUlp3uhlnsupKb/246tJXb5Uv/
	P4swDh183yOvcX5brT69eMNRtj/+4Z1Ox2DPsHU2NrrIQJPbN+71yTgWmpcMgT3Rc9gUVhHOJEb
	yDlhKwVsIhDNJRKjrNCUVC49hFCJ/El0ea6wkDOEO4xMO9wH9msX0pVzGDpSUH60SE1tn8HMCGV
	9aOOlu1rlLm6jDFpQ2G0Bf4K3VOn5bLhtYKPKBjRKcOM=
X-Received: by 2002:a05:6214:4a92:b0:880:5042:e38c with SMTP id 6a1803df08f44-8847c489835mr334184136d6.2.1764251195603;
        Thu, 27 Nov 2025 05:46:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqWeHXCjb/kCGdMUdI6ewfC9LvuQ759Fj3jgY7OAEH5ltonEXOAax4cuy5Kt1MRIRZFCCJbQ==
X-Received: by 2002:a05:6214:4a92:b0:880:5042:e38c with SMTP id 6a1803df08f44-8847c489835mr334183756d6.2.1764251195230;
        Thu, 27 Nov 2025 05:46:35 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524fd33fsm9932946d6.24.2025.11.27.05.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 05:46:34 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 0/3] ceph: add subvolume metrics reporting support
Date: Thu, 27 Nov 2025 13:46:17 +0000
Message-Id: <20251127134620.2035796-1-amarkuze@redhat.com>
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

Alex Markuze (3):
  ceph: handle InodeStat v8 versioned field in reply parsing
  ceph: parse subvolume_id from InodeStat v9 and store in inode
  ceph: add subvolume metrics collection and reporting

 fs/ceph/Makefile            |   2 +-
 fs/ceph/addr.c              |  10 +
 fs/ceph/debugfs.c           | 153 ++++++++++++++
 fs/ceph/file.c              |  58 ++++-
 fs/ceph/inode.c             |  19 ++
 fs/ceph/mds_client.c        |  89 ++++++--
 fs/ceph/mds_client.h        |  14 +-
 fs/ceph/metric.c            | 172 ++++++++++++++-
 fs/ceph/metric.h            |  27 ++-
 fs/ceph/subvolume_metrics.c | 407 ++++++++++++++++++++++++++++++++++++
 fs/ceph/subvolume_metrics.h |  68 ++++++
 fs/ceph/super.c             |   1 +
 fs/ceph/super.h             |   3 +
 13 files changed, 997 insertions(+), 26 deletions(-)
 create mode 100644 fs/ceph/subvolume_metrics.c
 create mode 100644 fs/ceph/subvolume_metrics.h

-- 
2.34.1


