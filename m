Return-Path: <linux-fsdevel+bounces-35613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B29E9D6619
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 00:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1C0285498
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 23:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997E01C8776;
	Fri, 22 Nov 2024 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWOEKMBe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00CD185935;
	Fri, 22 Nov 2024 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732316415; cv=none; b=pnqhGczc9fQlyM5ABRx/Tps0WECUCY/apfFo0hQU9xCG4DlKe8yL/z+qczDnd7m2XRQ7Q1lfW/7AcO15ZFU96U7J1mdvO4PC4hkOgq7SiqrUmzRK8/x63QKGO0ZTJBUOuSeBnSWwHJzJMkZF1I1/z63//Hp2IO0zuhjGrTcJeRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732316415; c=relaxed/simple;
	bh=mYyvNCwltqY/fLuBN/nF24u6tj4DXTz633vpbTM+X8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pP1HOBeHBdAx6FxA5V2yXv4pAtaO6lePe8z5CIoLTAYJuStsTtwneue16zEzB2ssX0hF+cFHA3hHgYdvcf1z25R7xdi1Xnf+e8SfbB24+cL5xfyJE5MMZ/Mbpdu5BuTUTcW+OUN8+Zzih+lp2tWpL6oLTZFCuCLkfdgKLhTkpF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWOEKMBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AE2C4CECE;
	Fri, 22 Nov 2024 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732316414;
	bh=mYyvNCwltqY/fLuBN/nF24u6tj4DXTz633vpbTM+X8g=;
	h=From:To:Cc:Subject:Date:From;
	b=pWOEKMBeG9/qnsTCZcRDxjFwgkY4x6oIRnm2AronqaWfnUkTz8U+hv4JLux7SCjeN
	 /DNvyUHKUQLpJJR4UX4pHJMvpjeomlt29Hn7OrGqxavTNJfZo9RQnQV2St2KKDHskO
	 P8hg4zR2Cro+7FXx6ReqDmswImcnA9oAcYJLnqg5eVnFTMMXR6Ig29812PtdmrQ5Ku
	 iP0ITblXqeLXgwfpCQkFEDUVduiaaiqLxx9TPwqXwG3od4O5z2B+Wx542BbEDbXYgw
	 vHVnxefMCh7LyNrguR1AMUye+MJPQvtBpO0OcjVtkG1CnrFFD1nGIWyZoiiy+EA7TL
	 027GpQd30kxZQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 fanotify 0/2] Fanotify in kernel filter
Date: Fri, 22 Nov 2024 14:59:56 -0800
Message-ID: <20241122225958.1775625-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the first part of v2.

Changes v2 => v3:
1. v3 is the fanotify part of v2.
2. Rebrand as fanotify in kernel filter (instead of fastpath handler).
3. Fix logic and add sample for permission mmode.

[v2]: https://lore.kernel.org/linux-fsdevel/20241114084345.1564165-1-song@kernel.org/

Changes v1 => v2:
1. Add sysfs entries for fastpath handler.
2. Rewrite the sample and bpf selftest to handle subtree monitoring.
   This requires quite some work from BPF side to properly handle
   inode, dentry, etc.
3. Add CONFIG_FANOTIFY_FASTPATH.
4. Add more documents.

From v1 RFC:

This RFC set introduces in-kernel fastpath handler for fanotify. The
fastpath handler can be used to handle/filter some events without going
through userspace.

In LPC 2024, multiple talks covered use cases of monitoring a subtree in
the VFS (fanotify: [1], bpf/lsm: [2]). This work is inspired by these
discussions. Reliably monitoring of a subtree with low overhead is a hard
problem. We do not claim this set fully solves problem. But we think this
work can be a very useful building block of the solution to this problem.

The fastpath handler can be implemented with built-in logic, in a kernel
module, or a bpf program. The fastpath handler is attached to a fsnotify
group. With current implementation, the multiple fastpath handlers are
maintained in a global list. Only users with CAP_SYS_ADMIN can add
fastpath handlers to the list by loading a kernel module. User without
CAP_SYS_ADMIN can attach a loaded fastpath handler to fanotify instances.
During the attach operation, the fastpath handler can take an argument.
This enables non-CAP_SYSADMIN users to customize/configure the fastpath
handler, for example, with a specific allowlist/denylist.

As the patchset grows to 1000+ lines (including samples and tests), I
would like some feedback before pushing it further.

[1] https://lpc.events/event/18/contributions/1717/
[2] https://lpc.events/event/18/contributions/1940/

Song Liu (2):
  fanotify: Introduce fanotify filter
  samples/fanotify: Add a sample fanotify fiter

 MAINTAINERS                          |   1 +
 fs/notify/fanotify/Kconfig           |  13 ++
 fs/notify/fanotify/Makefile          |   1 +
 fs/notify/fanotify/fanotify.c        |  44 +++-
 fs/notify/fanotify/fanotify_filter.c | 289 +++++++++++++++++++++++++++
 fs/notify/fanotify/fanotify_user.c   |   7 +
 include/linux/fanotify.h             | 128 ++++++++++++
 include/linux/fsnotify_backend.h     |   6 +-
 include/uapi/linux/fanotify.h        |  36 ++++
 samples/Kconfig                      |  20 +-
 samples/Makefile                     |   2 +-
 samples/fanotify/.gitignore          |   1 +
 samples/fanotify/Makefile            |   5 +-
 samples/fanotify/filter-mod.c        | 105 ++++++++++
 samples/fanotify/filter-user.c       | 131 ++++++++++++
 samples/fanotify/filter.h            |  19 ++
 16 files changed, 801 insertions(+), 7 deletions(-)
 create mode 100644 fs/notify/fanotify/fanotify_filter.c
 create mode 100644 samples/fanotify/filter-mod.c
 create mode 100644 samples/fanotify/filter-user.c
 create mode 100644 samples/fanotify/filter.h

--
2.43.5

