Return-Path: <linux-fsdevel+bounces-61703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C42DB5909F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 10:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503D93B2F18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 08:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747AA2EC0B9;
	Tue, 16 Sep 2025 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CH8ucOsR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE02EAD09
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011380; cv=none; b=c7LSogZbv/WbPFMw+JTcf1HrhFnGp37LuZxlM/Em489+9o4wS00H7oThj297tZVKrpHwOyTuACLkUvcNBoQWMrVqhzwsXifzUwP205OYfUwGk8gco2RQ+I+ihypWHCkTa4xagJeuzE0DZ4Z3o1Ssb6Y0URKuvEvFLfZZO+PZxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011380; c=relaxed/simple;
	bh=Ca5cuHls2De8O4x5QgFjuc/0o2El9m1et+yPC0DAuXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t1ck6f4BS8vRjTaNkV1R36FUT8RQc69/f/Ll+p2CvQGfWAcVb80l1IIo8vnsReUuouJc39Vuh2ovRdUsFoysCR+a7Jre41zGEATmG6tlkqSiLYdpdWLKBpyiv94Oara+6uvB+eEaQ2Btd9NUBAXyFefObzwvAI3LyeVlc/Hpu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CH8ucOsR; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso51963635e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 01:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758011377; x=1758616177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SV0YtCUL2jirmcZetLXeaBTlaiGJR4QMa3kB6D816sw=;
        b=CH8ucOsRw299MYTmM6YJKfQ14Izpsekd67Tw+qoBErtDG9Wv9Lg+ltXekOWkAeA1qc
         fi9OmljnESGXXJiqbRpt3oZ6vYl/PwJANSfB7oQIr/fBazPKcDVO+rNhoiBAMQsPJawq
         xAVMVlYmjD1YIIbOuc+y/+ESsAs7RPswJUN8G+ayqZMJzWyp3eh+8qagiai8AvI8hbPY
         fggTIUgkvEEGC54WeayFi5jSyyycD/2UqCqFesUqhEbIVhH2vBfIrMx7QE5ueiYLgFT+
         d97qwjsHLs5CZIa+ImQILkMaL+Oj84bf43e7B9AiV1Jmz6NYkAcKGfuOqRCQ0nIQQVBp
         z90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758011377; x=1758616177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV0YtCUL2jirmcZetLXeaBTlaiGJR4QMa3kB6D816sw=;
        b=bID4tCjW0BgYIC7ek+Qtb/OkIcSXS5rOyg9enMF/qbCoWWMVc/NfcnZ84ewZ/av4/x
         pX/dml51CSRCSjAoA0FmJkr3wigr+wYl7O6CLp+S5MH8pNKItaaZp7CZ8nY39jO6kCD1
         FllLLrLI3nFc+AlFGLFQB5nJm12qR5nWtioJfsMC6qXb88hLCeafUcJ3VIA4g6Kg699C
         /IXj8JKy5/oPysy+X7s6Kc6NnubSq6/lDKhs2vYgKz7rHRYrmhU+BKDdam0ShtX5b6ds
         nzuCkIuLULLsa2cCuyMso29lBLPtphyjqvewLiPihwOr4q1qrL2EeMaotdbvRIgO3vwt
         d6ug==
X-Forwarded-Encrypted: i=1; AJvYcCUyNIW5xk+aWUqBk+jRAY0uVUXJYR8lmW/H0Ikpj1s1vxSd1+T/I/uu/RvkQE0DpYjnRCQTAXD9EqmBga7w@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqxSZiBAQ4snjz2n1VPD5FmOV6YcUiVOpNbinvAbqyd/P9jev
	zi4kxBq994KiPs96l6fpGhlaKMlpY72moLc/LuDzi3STORYeVrRrjsIgGHCh3xOmfCw=
X-Gm-Gg: ASbGncuw81pPIg8gG9W7q/uOXtS9hgM5I/3myM/qRO7AQ/hRG0kcgD5ALykHs8OST19
	mxfXgc+O7LPN2WuaQnzcslMp/tFIZ9fkkYJ6Z3hCZpd17pWOx1m4DoOyDkXycvM7OIylYKpiHOq
	cQCA0eVJk5hq3xvkZDFeDybV6tl3LyxWgivIHXszyHte4ljU0SvX9dQ0MEHWVPyGVF6u7fu2IUh
	hpSiYu/nbQjREdO0NrpAMpUD+P3nyeEb4EiP/0+gjLmOhuV7J/v6kDTgtp3OYtCEmRDox4LDV6y
	4sg/jyk3vGm+OQepXqDeEO4Su/DeIhtyx5axj9SQQ4BbZGTvvMj6esOO3VtwLfA5diuHnQcadPq
	69cVR76jWo4PuThq6OMxErgdoRxdAtXJ4uB0WFEphfNU9VZQ=
X-Google-Smtp-Source: AGHT+IHc4ztcr3uenqG+UmGbkOx24X6GYfrC5VdAcjcEbEALZbfvM/mAUdMOfYMseaArX+lVLPNNLw==
X-Received: by 2002:a05:600c:c4b8:b0:45f:2919:5e6c with SMTP id 5b1f17b1804b1-45f29d33122mr105990335e9.16.1758011376679;
        Tue, 16 Sep 2025 01:29:36 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e95b111b68sm11006125f8f.32.2025.09.16.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:29:36 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/3] fs: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Tue, 16 Sep 2025 10:29:03 +0200
Message-ID: <20250916082906.77439-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1-2] Replace use of system_wq and system_unbound_wq

        system_wq is a per-CPU workqueue, but his name is not clear.
        system_unbound_wq is to be used when locality is not required.

        Because of that, system_wq has been renamed in system_percpu_wq, and
        system_unbound_wq has been renamed in system_dfl_wq.

2) [P 3] add WQ_PERCPU to remaining alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. This is actually enforced warning if both or none of them
        are present at the same time.

        WQ_UNBOUND will be removed in a next release cycle.

Thanks!

---
Changes in v2:
- rebased on 6.17-rc5
- removed the "For maintainers" section from the cover letter: patches are
  already merged, there are no prerequisites.


Marco Crivellari (3):
  fs: replace use of system_unbound_wq with system_dfl_wq
  fs: replace use of system_wq with system_percpu_wq
  fs: WQ_PERCPU added to alloc_workqueue users

 fs/afs/callback.c                |  4 ++--
 fs/afs/main.c                    |  4 ++--
 fs/afs/write.c                   |  2 +-
 fs/aio.c                         |  2 +-
 fs/bcachefs/btree_write_buffer.c |  2 +-
 fs/bcachefs/io_read.c            |  8 ++++----
 fs/bcachefs/journal_io.c         |  2 +-
 fs/bcachefs/super.c              | 10 +++++-----
 fs/btrfs/block-group.c           |  2 +-
 fs/btrfs/disk-io.c               |  2 +-
 fs/btrfs/extent_map.c            |  2 +-
 fs/btrfs/space-info.c            |  4 ++--
 fs/btrfs/zoned.c                 |  2 +-
 fs/ceph/super.c                  |  2 +-
 fs/coredump.c                    |  2 +-
 fs/dlm/lowcomms.c                |  2 +-
 fs/dlm/main.c                    |  2 +-
 fs/ext4/mballoc.c                |  2 +-
 fs/fs-writeback.c                |  4 ++--
 fs/fuse/dev.c                    |  2 +-
 fs/fuse/inode.c                  |  2 +-
 fs/gfs2/main.c                   |  5 +++--
 fs/gfs2/ops_fstype.c             |  6 ++++--
 fs/netfs/misc.c                  |  2 +-
 fs/netfs/objects.c               |  2 +-
 fs/nfs/namespace.c               |  2 +-
 fs/nfs/nfs4renewd.c              |  2 +-
 fs/nfsd/filecache.c              |  2 +-
 fs/notify/mark.c                 |  4 ++--
 fs/ocfs2/dlm/dlmdomain.c         |  3 ++-
 fs/ocfs2/dlmfs/dlmfs.c           |  3 ++-
 fs/quota/dquot.c                 |  2 +-
 fs/smb/client/cifsfs.c           | 16 +++++++++++-----
 fs/smb/server/ksmbd_work.c       |  2 +-
 fs/smb/server/transport_rdma.c   |  3 ++-
 fs/super.c                       |  3 ++-
 fs/verity/verify.c               |  2 +-
 fs/xfs/xfs_log.c                 |  3 +--
 fs/xfs/xfs_mru_cache.c           |  3 ++-
 fs/xfs/xfs_super.c               | 15 ++++++++-------
 40 files changed, 79 insertions(+), 65 deletions(-)

-- 
2.51.0


