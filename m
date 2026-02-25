Return-Path: <linux-fsdevel+bounces-78403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDwLDCB5n2nScAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:35:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C79AD19E535
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05D65308ED75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 22:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5144933C1A5;
	Wed, 25 Feb 2026 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKEZUy34"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C2733BBA4
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058850; cv=none; b=W2xe4TjtROxJwaEIKQH1VpZpNZNPICqcthkgXRw+6VdHH54Ig0dpMgY+ejwASnrIvRFt7K8xoTzEnaQZw5+/UIcrpfmPp7uluOr7p2Qpn0ut4EXMser+TbvVCP9Dxj1gDfNUv6yf+vzeNxExI7gtUcUOQF4aHfWtnrXe2TdmMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058850; c=relaxed/simple;
	bh=vFBhJxCAsIAwYNZ/g3MViZPMIkoQrogOPMTX+aObVJo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LLfffqn4harHSmYShZSvFxlB18idtl9B6tlLIGfx3pDUEOl+EXM8+focGHsSGCaJjCMqKFnsrkliw99Pyl7k2MMcoHVi6O9UThReKquJkwrr2DOijPPJ+7rHamnFuk4kUKDdlc++ZG0cKlYTHZCCvWnRBb/IMWnzvoCd4l1xD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LKEZUy34; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8273855525aso242596b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 14:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772058849; x=1772663649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HB0CfyRs1BRb9GE8lihqLejpd0gkHTcJItDcn1kg/F8=;
        b=LKEZUy34jaPUjF9MWzfk3bnuXTEnsamM2bHOn7MkF0TLl1Z3RJR1bdx+AIT4C7arvR
         hEwDAYCYoXwbgODyWpZa1JhHj60BgO2BddY5ScrzD8vNZDyvk3xr4RnIK2w/Fd1Isthi
         PnLrOcuJ9QYQ+O2o4OYLkOtgvVZDFXKr5XCW72wMaIXgC9AGbnc6zk8BOaLw8DQ1Todq
         hIbgXBO3pyef6CmjquAfRyXT3ctIx3Bf6VYq9rN1HqE17utNxI2V/tnypHku97SM+dfb
         UtlMFtSCxsmvpoblc+ZtS3a/skpi0MON+xZ8he3w1iWIlW960y8KD4oaJQ/yHNV91y7f
         hw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058849; x=1772663649;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HB0CfyRs1BRb9GE8lihqLejpd0gkHTcJItDcn1kg/F8=;
        b=XQ47qIElHBWK5ASEOEmXMGtH0GkRk9JYhZIB+NG/AylJHQOLJEyJI/0p3raIGElE7D
         uvBhIkyfEH0n6sxc0vBfUpPYFqL65s/2Y0pG/aZT9z2H5QTVcyIZiGoFnb4FShTO3Hf2
         9zqlTZ11esx08I3bhhBzaBfVxhJq1UlNochZu7uA38/EtRX7vHRuhXDImLc2Y0HRiHZJ
         3jyhABIQbhRuKsVHo0Bapl+9iYe3sZMa2GbJobqkQCVLDK9rVsMSCbL6B0p9/EP+AXR/
         3GSk79ouU0n2f/L4JPSLdaSCwo2TocwhQZpL2DSc6scfndn5exyMRKKRAyu60Unjg3/v
         NN2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUHy9N814kKprwz+ek8U0Hu4+rihVFLJ0pAb1wvjvGPxpQyuTAp9oHO3uyFhKHZR7eGKBQcvRX+rv47r0p@vger.kernel.org
X-Gm-Message-State: AOJu0YzhNvQ7IOhf//upHejvvJkIqpjZfk61pBvO5ML50L+jvLytedth
	wzncbCfjCzir7EEtScHblBdlqAI/TrpMMYsHqMVR6XYcvgOUTOW17n92gNTyHqAJ7Hm5rkwL01c
	8VhT2gSdC9tpYWX6MPw==
X-Received: from pfbbk2.prod.google.com ([2002:aa7:8302:0:b0:7fa:f279:2d1d])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:cc8:b0:827:2b7f:e1d0 with SMTP id d2e1a72fcca58-82739827658mr536889b3a.24.1772058848945;
 Wed, 25 Feb 2026 14:34:08 -0800 (PST)
Date: Wed, 25 Feb 2026 14:34:01 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225223404.783173-1-tjmercier@google.com>
Subject: [PATCH v5 0/3] kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED support
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78403-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C79AD19E535
X-Rspamd-Action: no action

This series adds support for IN_DELETE_SELF and IN_IGNORED inotify
events to kernfs files and directories.

Currently, kernfs (used by cgroup and others) supports IN_MODIFY events
but fails to notify watchers when the file is removed (e.g. during
cgroup destruction). This forces userspace monitors to maintain resource
intensive side-channels like pidfds, procfs polling, or redundant
directory watches to detect when a cgroup dies and a watched file is
removed.

By generating IN_DELETE_SELF events on destruction, we allow watchers to
rely on a single watch descriptor for the entire lifecycle of the
monitored file, reducing resource usage (file descriptors, CPU cycles)
and complexity in userspace.

The series is structured as follows:
Patch 1 preemptively addresses a race to set/clear i_nlink that would
        arise in patch 2.
Patch 2 implements the logic to generate DELETE_SELF and IGNORED events
        on file / dir removal.
Patch 3 adds selftests to verify the new behavior.

---
Changes in v5:
Add comment about inotify, and fanotify limitataions per Tejun
Add Tejun's Ack to new patch 2
Fix circular locking reported by syzbot in patch 2
https://lore.kernel.org/all/CABdmKX3jMS5ha2s5FMpnAMW0c9+Wmpmyc+8=D-24KyhVjBJvYg@mail.gmail.com/
Add Tested-by: for syzbot as requested

Changes in v4:
Clear inode i_nlink upon kernfs removal instead of calling fsnotify
from kernfs per Jan. This adds support for directories.
Abandon support for files removed from vfs_writes.
Add selftest for directory watch per Amir.
Add Amir's Ack to selftests.

Changes in v3:
Remove parent IN_DELETE notification per Amir.
  Refactored kernfs_notify_workfn to avoid grabbing parent when
  unnecessary for DELETE events as a result.
Use notify_event for fsnotify_inode call per Amir
Initialize memcg pointers to NULL in selftests
Add Amir's Ack
Add Tejun's Acks to the series

Changes in v2:
Remove unused variables from new selftests per kernel test robot
Fix kernfs_type argument per Tejun
Inline checks for FS_MODIFY, FS_DELETE in kernfs_notify_workfn per Tejun

T.J. Mercier (3):
  kernfs: Don't set_nlink for directories being removed
  kernfs: Send IN_DELETE_SELF and IN_IGNORED
  selftests: memcg: Add tests for IN_DELETE_SELF and IN_IGNORED

 fs/kernfs/dir.c                               |  56 ++++++++-
 fs/kernfs/inode.c                             |   2 +-
 .../selftests/cgroup/test_memcontrol.c        | 112 ++++++++++++++++++
 3 files changed, 165 insertions(+), 5 deletions(-)


base-commit: ba268514ea14b44570030e8ed2aef92a38679e85
-- 
2.53.0.414.gf7e9f6c205-goog


