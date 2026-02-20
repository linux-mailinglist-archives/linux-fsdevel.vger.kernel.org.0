Return-Path: <linux-fsdevel+bounces-77764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBo8IYz3l2k4+wIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 06:56:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC6F164DD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 06:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D07D630363A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 05:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2896832E14C;
	Fri, 20 Feb 2026 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4ja4f0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B632FFF90
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771566909; cv=none; b=MmMmRxjgQd8JyWBnSWCsYARl1Gvu0u70cyJWGihednF+FkbKhK0I+qR6VV0WA27Sf3Cq7PI3SubM7stKGgfbM0KXQ7jos0OYHiotSsHhoCrBc30sSdx+F3n0GjXZaWMzR3W6QOuPIUQhCz0lMfJFb1rdNuMK71ty0hizMK5waOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771566909; c=relaxed/simple;
	bh=SETEcec1D+mm0BU0dgNl2Gb3HG9APdLtZ19G+u8CMQc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c96SyqSIgHBAoXC6qbs1fyoHr+Lvoo10mTRD+2zalSsg0wcLnonTa2Oj1uzTxh8pq14JOjYDJ80Aww6SWdJWUG2/NI9ltlHyZktaIJDjTPBR2A2WOjadfkylblKyIo5O6jVhRUdAB1SRaVkBQ7o3YySRSeV84/DCB6B4nnitrXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4ja4f0L; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3561f5bd22eso1499755a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 21:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771566908; x=1772171708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PhOr9xc8hsjU1exlkJ9o+lRZ6CwgWrB0En0qqwGcrsk=;
        b=I4ja4f0LlfshNDN7PredsaOvaI4MSfe7fyNx7Z5nCKc6eVnE0pLROUbjX/FKA93rTG
         SiJL9HkpuaKQzP2UO6X7TIrDKvl28KeKYHFz+Wz3kd52ygj2K6vQjmaNoFfyd1Ax6+Jk
         M0xAYnn0DPVM2372e3Pd9CnjA6MziZ7Z8/lNv3IXn3St2NxpQo5a5NAmyUs6ozELbO86
         /XxJE6iSMHcv8hV/b0BPNQSgI2RMmtn0vXvOkgQQa22bSYb9XuSiwVHSAKzpPp+2D8WY
         3Avsga2DUGOWica3gKQ+wzNITJW5r4Xuu3Cl4IXxZRFPyvNeMXVEpK0uHzvIrFh/4tdt
         Fazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771566908; x=1772171708;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhOr9xc8hsjU1exlkJ9o+lRZ6CwgWrB0En0qqwGcrsk=;
        b=MUY5VrMuuJ73ya+Wb0LTpBCJodu2uG0lFCQ3ijy48Mroxu4KrEy58F63zskeAnVsvn
         O9wVEXvjbAzydthFLSoG1YI0h/H0B81cRExxe7zcWNEOjHjpR56EhqcTAShsuSfJECSU
         8XTASiMD2I98h1oJHJ7qV7UMN4uBlAUCSiwQoF5UqL5UWM2GeQNYT+C/xmMbnj7buy1X
         SJtgy2HleIewgQO4zg5rjC203ii1LZ1uYpYAQciELcHKb6OPark5uSY3XinOVYUMrlC/
         PvYU/GafHXx/sAmuMIu5ixkEyPf4jWLbHFofZ+zhuAVVynbJoXhqGJzABKdE3mwKcxdq
         O55w==
X-Forwarded-Encrypted: i=1; AJvYcCW8z8HdjDZ8Soti8gaNUfnjWyIun8dDt77zBtkbAb/bmFUJqPtIDkVdtvxqFG4t54vBUk8LyW3nmklPr7/n@vger.kernel.org
X-Gm-Message-State: AOJu0YzEEs4XxawIMuylUAZwakuCzFy3EmL0cdgZ9XsGQeEHyfSPmGgm
	HklrtZtuBWfui66yH8/uAeBTr3bm6npIyQ3/4Nga4i5q0Z48BSiDbsgPafxhh3UFZto+2evlFaZ
	YCaPuKzKuin8+M8pmRQ==
X-Received: from pjbsj6.prod.google.com ([2002:a17:90b:2d86:b0:34e:90d2:55c0])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:da86:b0:354:a9f3:68bc with SMTP id 98e67ed59e1d1-358891cb92bmr6358367a91.30.1771566907697;
 Thu, 19 Feb 2026 21:55:07 -0800 (PST)
Date: Thu, 19 Feb 2026 21:54:45 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260220055449.3073-1-tjmercier@google.com>
Subject: [PATCH v4 0/3] kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED support
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
	TAGGED_FROM(0.00)[bounces-77764-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCC6F164DD7
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

 fs/kernfs/dir.c                               |  32 ++++-
 fs/kernfs/inode.c                             |   2 +-
 .../selftests/cgroup/test_memcontrol.c        | 112 ++++++++++++++++++
 3 files changed, 144 insertions(+), 2 deletions(-)


base-commit: ba268514ea14b44570030e8ed2aef92a38679e85
-- 
2.53.0.414.gf7e9f6c205-goog


