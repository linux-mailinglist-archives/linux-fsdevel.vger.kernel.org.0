Return-Path: <linux-fsdevel+bounces-76828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPbrICD1imkNPAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 10:06:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9041188D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 10:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F388B301285F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EFE33F370;
	Tue, 10 Feb 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZT/zzA2v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nr50O9hJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B833EB17
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714396; cv=none; b=XLDZENTYIh1pLB+sl6zc0aROURWEPH460Ha/YpqkC2O+Vh8dWtBH5zmWgumFvE1a6rd5lrEb41uSu9Ia4IxM4SZmsLBpOu+i+Qyc98nO3Sk2E4i/lJJjs4EywoZuh/h2aaiNyQxi5E57WVVqnCQhRZUCI6QXCCSV53lMlDiIl1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714396; c=relaxed/simple;
	bh=jEtPD7lEnKueCK3nWUUFtqX+R3ZXhj/ui/f2Y34tw2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OREQgqDIuQBoMId+3dtvySGrGbkCBJJ/keMWn99bQU/VTNi4BbyjoYnhneikAOLg71lR/+CdH963dJ5V6sQqpXNF2U7Ln33cq+n8+kCDLXBy56x4xaJmRM5kw8uo0nSEInB6IzNXzft17XWNbXcUnBJWdMdiXOb6bfIqWl+X454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZT/zzA2v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nr50O9hJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770714393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1yS0XvdNLyxbdctac2U/Q3VqlV341oNKdWppclXcS7c=;
	b=ZT/zzA2vki1FCjhufvZpSz+2dYvAxMYlpC9yLKz8KWMRV1SSzfn6tyzFJiTcDLH5C8Mzu8
	wzOHdHfcDiot6DiyiQfr00W2hqb9nszv7omli/0XObKxnwV+uBaIdyRMcV5luU+Hzua6wx
	a2g7YNLidPHO8PlUrICW99x3CfQYSMw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-XougA2uJORuFVqIG6vUJ6A-1; Tue, 10 Feb 2026 04:06:32 -0500
X-MC-Unique: XougA2uJORuFVqIG6vUJ6A-1
X-Mimecast-MFC-AGG-ID: XougA2uJORuFVqIG6vUJ6A_1770714391
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70cff1da5so1343406285a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 01:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770714391; x=1771319191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1yS0XvdNLyxbdctac2U/Q3VqlV341oNKdWppclXcS7c=;
        b=Nr50O9hJdkZpq0fcxXFe4Camq2VcZkSvG/sKHVgxDYS7K4AW/Ru0dSk52gf9EE/eqm
         ILSUCe0dgRNZY8COBj5rCAMGDwSdLSHT3EhLodqRZGuVKFHpQcu+H3Qch1xdsJP/NMF0
         8okkWcQkYJTulS5rMFVKQRZ7OPXYh67r5Q624qzQxiy51J6na57iZLV0iZdocgbuiaMf
         x/WlOERMEIN2Dz3U1aT7/ILHlwOQupoHM9hYB7NB7Waq1xksDEdRqlq6yEKF2jXIDV17
         eVbFyp/KmH+JQiQRztS9isvoUsS1qVjobGimrQEtmAH+16+AvbxZ62YGMeEzuTpi+QMw
         SSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770714391; x=1771319191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yS0XvdNLyxbdctac2U/Q3VqlV341oNKdWppclXcS7c=;
        b=BgHGpm6hs7NbfThfkO0f7tTmrqes4tVyarCAPMIFcGHFoYMdFj05+0+QywFQH2CCyP
         yiJHCykmWGLI8jkdNgHnFdQra1Fgc7hP06S2TIZqfryWFVRPhhShPkUwvSb4jrSLkAi5
         2BdlpjvoPX0JwA5A7rFPh7xHVxOr7A2fJ0pPwMcR6tbKrT/H25MM5yQNq2MecBz+2y2V
         ol1x4qvZzUrf6jDfbKIexk917BD8Lny4zR01ZioZw5ko7+eXjhxn4ChsTq4B8gBxXBDI
         8PiMLawJgPiJDmwmDUex6IJ7syNvBbc0tTYx4y+o5i22E6H2WM7iM2p69PafoQzeGFqV
         ZUyg==
X-Forwarded-Encrypted: i=1; AJvYcCXcAFZCShFILCNkE/xtuKOaLJ8zr8DI2wc1s0em8G1EHiX1cnsnGSMu92RaAoGH/FEDFK7iJZc9VHZL8XLk@vger.kernel.org
X-Gm-Message-State: AOJu0YxnlgJianSDhs6HAQJqJu290huMBCsim2tqvCFNj41W5Vn4mP3S
	pEl2Ahs+g4WvbW4UV5GhkP9ZJpe0+UShLnaP7Q/8UihrNppCxWa+GV4gR8sTjJ2J7WEa9FvTrUO
	FLh2XmFOX6dw9lVJNK+wDcZ3eS62+56KwtnKLeYsh93UyREjowTyYp8QdCVPaEFX0qII=
X-Gm-Gg: AZuq6aLTbwOYYPUV2tw2o4SoEKI81IBFMkRHodl1NNaeKPdQa8r0OjX+CZq1qBzmf7Q
	ePYMeQrm5FnTM8vhMVshaTZPTr7a/WZ84hBmDy+mDrN94hFO8pRSWlkK7gHztjnFzqjn0P5LfeK
	V5Asb5JSIngbkAEYY1U5iCir4rzn3szVtVG7WErZ6XdmSv81f29CDS7XLUFtekJHRx1t4qTTW4n
	Ydp7TsQbg0CMODknM/EiKBr5T/jk+0B7mBabsLDWRUsf+rCuQFk8AJtqU0JJ81WrsYjoHtOWmpY
	r7/N6HkDBrdZ92w58tmXkYGLJJDAJX8Kz4LQb3YzfRPtqwCvNBEThHJdFW8DCvzeNdgyldCRD2Y
	QmGbJ2sIo5VxqXWZdbDaLoJzUfn4FxceFSjp7MHNsMFLReW2NeKH09Vo=
X-Received: by 2002:a05:620a:44cc:b0:8ca:4288:b178 with SMTP id af79cd13be357-8cb1f74d6c1mr137810185a.56.1770714391466;
        Tue, 10 Feb 2026 01:06:31 -0800 (PST)
X-Received: by 2002:a05:620a:44cc:b0:8ca:4288:b178 with SMTP id af79cd13be357-8cb1f74d6c1mr137808385a.56.1770714391019;
        Tue, 10 Feb 2026 01:06:31 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c068292sm108053326d6.45.2026.02.10.01.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 01:06:30 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v6 0/3] ceph: add subvolume metrics reporting support
Date: Tue, 10 Feb 2026 09:06:23 +0000
Message-Id: <20260210090626.1835644-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76828-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[amarkuze@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A9041188D4
X-Rspamd-Action: no action

This patch series adds support for per-subvolume I/O metrics collection
and reporting to the MDS. This enables administrators to monitor I/O
patterns at the subvolume granularity, which is useful for multi-tenant
CephFS deployments where different subvolumes may be allocated to
different users or applications.

The implementation requires protocol changes to receive the subvolume_id
from the MDS (InodeStat v9), and introduces a new metrics type
(CLIENT_METRIC_TYPE_SUBVOLUME_METRICS) for reporting aggregated I/O
statistics back to the MDS.

Patch 1 adds forward-compatible handling for InodeStat v8, which
introduces the versioned optmetadata field. The kernel client doesn't
use this field but must skip it properly to parse subsequent fields.

Patch 2 adds support for parsing the subvolume_id field from InodeStat
v9 and storing it in the inode structure for later use. This patch also
introduces CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset
state and enforces subvolume_id immutability with WARN_ON_ONCE if
attempting to change an already-set subvolume_id.

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

Changes since v5:
- Rebased onto latest kernel (resolved conflict with inode_state_read_once()
  accessor change in fs/ceph/inode.c)
- Re-added InodeStat v8 handling patch (patch 1) as it was not actually
  in the base tree, making this a 3-patch series again

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

Alex Markuze (3):
  ceph: handle InodeStat v8 versioned field in reply parsing
  ceph: parse subvolume_id from InodeStat v9 and store in inode
  ceph: add subvolume metrics collection and reporting

 fs/ceph/Makefile            |   2 +-
 fs/ceph/addr.c              |  14 ++
 fs/ceph/debugfs.c           | 157 ++++++++++++++
 fs/ceph/file.c              |  68 +++++-
 fs/ceph/inode.c             |  41 ++++
 fs/ceph/mds_client.c        |  92 ++++++--
 fs/ceph/mds_client.h        |  14 +-
 fs/ceph/metric.c            | 183 +++++++++++++++-
 fs/ceph/metric.h            |  39 +++-
 fs/ceph/subvolume_metrics.c | 416 ++++++++++++++++++++++++++++++++++++
 fs/ceph/subvolume_metrics.h |  97 +++++++++
 fs/ceph/super.c             |   8 +
 fs/ceph/super.h             |  11 +
 13 files changed, 1114 insertions(+), 28 deletions(-)
 create mode 100644 fs/ceph/subvolume_metrics.c
 create mode 100644 fs/ceph/subvolume_metrics.h

--
2.34.1


