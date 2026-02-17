Return-Path: <linux-fsdevel+bounces-77379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKbzGPmslGl7GQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:01:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE4414ED5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 745893042771
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF381E5718;
	Tue, 17 Feb 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i78fBFrm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920881A9F91
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351273; cv=none; b=uYhCrr67wjXAxSn/tIIQ+1p1Sxj6Say1IMy28v7ZbBsvoyfbzJM2LlzajIHjBcdkZguAYUwyVhymmf6Wyv0LHvIG72VUyUBO6AY9hQ2TPsrRuJWGXeGtnyYpMFrr+zFz6Jv43puxIaBka3yts7Z8wkcxmU9fCYe/NAWnJRXFaeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351273; c=relaxed/simple;
	bh=TcYoluka6Sotp+G8vXS56Hmvkko0fKSIU6lURxuEfEw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c44EFGJNbmisLq577QuJaWSPe/U1JQ1gtEqw5/xK8u9uyZ+aKgK0KTDypszJh4x0sBN9/3jsRLa1KtO2D7w6polFSyM9ePEfAU2N1iLIGxlQbpf+LoDHW+vBs1nPT7rKtkc6pxHh3MCxh/Y4AKkJRQtOLvRBFMVNFN8i2nGtRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i78fBFrm; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-40a57a34dc2so40879713fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 10:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771351271; x=1771956071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gd7itJdvcuV3R3SwarzHanDdlNFzzeUJJAZS/H40Dc8=;
        b=i78fBFrmR7SHG86z7EtozFkgsLiXECJVopoOZDoixGgrFUhXkE4IGIieUu55C/AIfx
         7D3MY93W4VRIm5jkDjDujZVVUJ3c18ECTZCdWxvm+i94CoqzA9sGqfiHz/iIAb7Uj58C
         tizBgiIRx7hF9kEtdPOeeVGQ0Ap+6/OxaT0HbOZW92TmrPJOMNeBPgJbr5PcUFtpPnf8
         hpdfyVtLVInuMgWxOJkdkBRRpLwNA1g5IbMHeeG1bm1cWfxt0TxC06UIirbltFWMe0kz
         1HojP6pY65VzXWkgtr2m1mXFYnY4mLfPXXtZ26Y4Wc6h1RdWoWhiiHWCmyzdS8uuLlWP
         3h5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771351271; x=1771956071;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gd7itJdvcuV3R3SwarzHanDdlNFzzeUJJAZS/H40Dc8=;
        b=GSZztWwvfF7U8p0o3yNuWnZpASFg4z253KzU2Gll1zeLzCQS0wHLckBKzj2oaRM3Un
         Umub0TT13IL0z/fIj0GyESW8YLe7on3vgVji7q6c1+G1SMxS45dxySLTpfY484l12Tqg
         UskUW3wGNdYwz+Z2QyD3Lcrgw9Rrq947aW07vQMdyhRwqlwYcIHcZKbDS9Sg7v0RkRQK
         Q7F0D6bcttmr+aOkuz0pcw9cbrEZyeYK6SXHFOORnVR4/5EsTldukCqxnNs+X5icbgGD
         iME4E9bdzTELZ6TeMJPJXVCDU2lU7PuM5VNXeM5xNCJBXumaZ27Wj+1sdjAJTaBLP/bA
         9rPg==
X-Forwarded-Encrypted: i=1; AJvYcCXr2XTgdM9L+krZ2Sfyiqe8rKIsraNowV2/+iy6JG92xlrWlrzEnV+qa/dSeTLpr/Y4eCxUcLFnG3ET+Q83@vger.kernel.org
X-Gm-Message-State: AOJu0YxowmwOgqz8b3sCMrhUab3yvyG4JJkhs6m5uwbv8BWYVjpwZDn+
	0mPGz0XzP2uPghbfX3fav3/QfDJY4ozoega8V4IW3La9MW0ex8UwFmYfNQD74lqb7gHBH/WvtMY
	Ks1GPXg==
X-Received: from jabki4.prod.google.com ([2002:a05:6638:a804:b0:5ca:ff1f:79f])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:4b01:b0:679:a4bc:9f8f
 with SMTP id 006d021491bc7-679a4bca251mr287501eaf.61.1771351271099; Tue, 17
 Feb 2026 10:01:11 -0800 (PST)
Date: Tue, 17 Feb 2026 18:01:04 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217180108.1420024-1-avagin@google.com>
Subject: [PATCH 0/4 v4] exec: inherit HWCAPs from the parent process
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[huawei.com:query timed out,oracle.com:query timed out];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77379-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RSPAMD_EMAILBL_FAIL(0.00)[kees.kernel.org:server fail,ebiederm.xmission.com:server fail];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,huawei.com:email,xmission.com:email,linux-foundation.org:email,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lkml.org:url]
X-Rspamd-Queue-Id: 1BE4414ED5B
X-Rspamd-Action: no action

This patch series introduces a mechanism to inherit hardware capabilities
(AT_HWCAP, AT_HWCAP2, etc.) from a parent process when they have been
modified via prctl.

To support C/R operations (snapshots, live migration) in heterogeneous
clusters, we must ensure that processes utilize CPU features available
on all potential target nodes. To solve this, we need to advertise a
common feature set across the cluster.

Initially, a cgroup-based approach was considered, but it was decided
that inheriting HWCAPs from a parent process that has set its own
auxiliary vector via prctl is a simpler and more flexible solution.

This implementation adds a new mm flag MMF_USER_HWCAP, which is set when the
auxiliary vector is modified via prctl(PR_SET_MM_AUXV). When execve() is
called, if the current process has MMF_USER_HWCAP set, the HWCAP values are
extracted from the current auxiliary vector and inherited by the new process.

The first patch fixes AUXV size calculation for ELF_HWCAP3 and ELF_HWCAP4
in binfmt_elf_fdpic and updates AT_VECTOR_SIZE_BASE.

The second patch implements the core inheritance logic in execve().

The third patch adds a selftest to verify that HWCAPs are correctly
inherited across execve().

v4: minor fixes based on feedback from the previous version.
v3: synchronize saved_auxv access with arg_lock

v1: https://lkml.org/lkml/2025/12/5/65
v2: https://lkml.org/lkml/2026/1/8/219
v3: https://lkml.org/lkml/2026/2/9/1233

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Chen Ridong <chenridong@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Michal Koutny <mkoutny@suse.com>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>

Andrei Vagin (3):
  binfmt_elf_fdpic: fix AUXV size calculation for ELF_HWCAP3 and ELF_HWCAP4
  exec: inherit HWCAPs from the parent process
  mm: synchronize saved_auxv access with arg_lock
  selftests/exec: add test for HWCAP inheritance

 fs/binfmt_elf.c                              |   8 +-
 fs/binfmt_elf_fdpic.c                        |  14 ++-
 fs/exec.c                                    |  64 ++++++++++++
 fs/proc/base.c                               |  12 ++-
 include/linux/auxvec.h                       |   2 +-
 include/linux/binfmts.h                      |  11 ++
 include/linux/mm_types.h                     |   2 +
 kernel/fork.c                                |   8 ++
 kernel/sys.c                                 |  30 +++---
 tools/testing/selftests/exec/.gitignore      |   1 +
 tools/testing/selftests/exec/Makefile        |   1 +
 tools/testing/selftests/exec/hwcap_inherit.c | 104 +++++++++++++++++++
 12 files changed, 231 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/exec/hwcap_inherit.c

-- 
2.52.0.351.gbe84eed79e-goog


