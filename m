Return-Path: <linux-fsdevel+bounces-76735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMOIMyowimm3IAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:06:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4778B113EEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28BC53018C00
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70440FDB8;
	Mon,  9 Feb 2026 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ai7p2fc9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CEB40757A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663975; cv=none; b=la40oEa8qZSkVMYDkwBnBeu6/GHZeDFYyjVwuvgFIaFEYNsZI6HcYtoRn4vdaOHwgnIYIZxjVlEai9EOrZ3Gt3C+W4xSPtrDtg6XEuqDuG1ySmdvjnHiKlicxnbo0U4PGIGTq+Ql0pZXZk8Vb0lg6rKqgKZ1CnQEiEBoaXn98ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663975; c=relaxed/simple;
	bh=DZVBNSCZecWtVt9S9CVhMglkHjyyUM0vOF+GWDSxvVs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TiJSue6592p46dKp3eFqm7paTV51kZXc/3WXrAO0MiNag7HBwndY03K6RwVCacM7nijVWjRFnJQRACLO79Y4c7E9SoZBexi2nGq48Zz9NnPrFFMRNLi4rQP0fsmI11/4bBUG8FZs4gFOtWd/PzA8LoSkAF1TsD7CdmB53f23R9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ai7p2fc9; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-663005f0997so9643281eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 11:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770663974; x=1771268774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e2HpgCh3GJlzMEOowH+0CKxCLu/yx8DsmALRhJjlfYc=;
        b=Ai7p2fc9S86474P/UfyA89IoupNp/3tSF6rt3bBtxFmcjDPWlLf27xXgRqC2xo9rJ6
         b4OjI3LuICRDs5vWagMvJgxWYBlK5M8JFlbCniXl05iQ6f2dbyLVNclRlC9SJBwRBoiM
         AHAUi5pwFpa3u6+X9jiEzpdC8HUFQLUouQ9GnOZicGiJZmXyWCSYHnF/65N35J9OjXBy
         UznBeLWsJgaEH2qJInU3NuwUY1kmKcnqTigX7XDRbeTI9dHSIF5pE2LoYCUNYpZ8JydC
         gBSENqEV1lKRoDxD84i4Wbch2ommU+2sxv9oqqbNeRQMVcTnSmolKB+mtxzmM8efGp4k
         FX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770663974; x=1771268774;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2HpgCh3GJlzMEOowH+0CKxCLu/yx8DsmALRhJjlfYc=;
        b=Nu36khmjb2dMF2wHty4u1H0TQ3d28wiJIOLPnEQMMfpznXRfgpSAVqSMv6QY7I+7S7
         N00AJh7/konxX6ZPERI91zrnOE0H2NJe79raeitvyfdIr6vX/fb6na4B/HJxbgZOBImp
         3W9Dl3vTLEx3zf5ETvOhxFeAPNlv8vLo+IM4h1hPZZ4r+f+MMzqlYLgszlNb8SxGUrNs
         1OM9wbXEC5yi4GGER+3Nb62S+UbN771IGOCnSH9ZWEppOpjEqO8uhMpWpLdffYBydY2P
         VfhryTT96R5fjMgMXDnX+IqWXfc2M3Jyx7sXgcHZQQ1cQSAQc6qrHID5n7Ihc0iYsbO7
         5VLg==
X-Forwarded-Encrypted: i=1; AJvYcCUmoy6kOlZleLNn0lRqocC63NMAT54wmpvZCKEUkRnCKzv40uYld84uOoelkg46WnNMb/5iMhBX2tjuaNNL@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUrqeYwLgxd4H8iVUIO+56oodPWBL4qeAthCFQx8MqlbmpWPG
	7mRoQn0YUh+rNiXeCycsLy/fhDF/kTHp0NXfTqAN47fZxFPCTxVj2d7W3YsXN+RpsDLT61EQ+Pb
	bCfzfuw==
X-Received: from japv18.prod.google.com ([2002:a02:cbb2:0:b0:5ce:5b3c:f8c3])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:6ae6:b0:663:8c6:97a1
 with SMTP id 006d021491bc7-66d0c85409bmr5061261eaf.61.1770663974501; Mon, 09
 Feb 2026 11:06:14 -0800 (PST)
Date: Mon,  9 Feb 2026 19:06:01 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209190605.1564597-1-avagin@google.com>
Subject: [PATCH 0/4 v3] exec: inherit HWCAPs from the parent process
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-76735-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xmission.com:email,oracle.com:email,lkml.org:url,suse.com:email,huawei.com:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: 4778B113EEC
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

v3: synchronize saved_auxv access with arg_lock

v1: https://lkml.org/lkml/2025/12/5/65
v2: https://lkml.org/lkml/2026/1/8/219

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


