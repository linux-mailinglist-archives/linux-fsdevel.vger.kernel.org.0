Return-Path: <linux-fsdevel+bounces-62093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3B1B83F98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9204A6DCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD2D2F2609;
	Thu, 18 Sep 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVOIaNja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1B2727EB;
	Thu, 18 Sep 2025 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190315; cv=none; b=Ayq1YYethstBimct9drr30l/ahPm1bq6ERDf7w0kfISCCjTS3hj7zRSGDw93BLlG88rqOaFxYBG9YU5JUilBvLrs5FrY198CkaBMI0+5g3jF16IJrsTJacgRD5XW73Uyjpy1LKUZ7KglN0Cyv1FOx//7dLw0iRXYwbHNQU615og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190315; c=relaxed/simple;
	bh=6R7ZdUPtKCxo+sBOy4vc6MsQGWAL2LbGrNP33Z5vnNA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UU6UEHxo9G5du8+Q5/rHd2CCa1HsZEnPEEQqL+z0Fp/m9yaylUvY2nXrZHg+aTYcgjciRqZPj+b5Mowy2GjCQp+ywb8PdQlMnpOc/q408rg9yWWZSdFyj1x8C0fjrvjYJyXsO71JuTjfPt12U4tbQ3xC8ShwEfe4XgGwRRuQzl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVOIaNja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFD9C4CEF1;
	Thu, 18 Sep 2025 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190315;
	bh=6R7ZdUPtKCxo+sBOy4vc6MsQGWAL2LbGrNP33Z5vnNA=;
	h=From:Subject:Date:To:Cc:From;
	b=TVOIaNjaXG6uusWkUkk4nm/NKcxJ6Zmfxu/hMLaX3XPCdohV1e+OLC8QVl4H5kLP6
	 XzgbV7d3ijG0FhvT4qqJ3vT/dL5A8xKJEgcD4YMxUNwcBoEYYQtR2oSx1RKhT7yiZb
	 U2WFCz8sFCmrh1D3LXXw+vuY/5GybQFv636wivOa/nGU+7XdzrSMWBqH5LEAGCi1YC
	 uFc/cj1+pt2aYfio+U78mtiInqy8U66O4fLBco/84f3LPDAO/YzgWnDxPa3IEl+S5q
	 bfsWX5bRVGGBcRsCTCmdP659YXJea554estEz8bSkvUEykgPa+8V6pwiOe0H+EQFZ7
	 KhIlzgax8fO+A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/14] ns: rework reference counting
Date: Thu, 18 Sep 2025 12:11:45 +0200
Message-Id: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOHay2gC/z3N0QrCMAyF4VcZuTZjrcyqrzJEshpdkLajARXG3
 t3MCy//A/mygHIVVjg3C1R+iUrJFm7XQJwoPxjlZg2+8313cgHfpT4xU2KdKTJmvVa+474P7uA
 jBaIj2O1so3x+7nCxHkkZx0o5Tpu2Ie0faQ2JJSX7vK5fC/rdu5IAAAA=
X-Change-ID: 20250917-work-namespace-ns_ref-357162ca7aa8
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6R7ZdUPtKCxo+sBOy4vc6MsQGWAL2LbGrNP33Z5vnNA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvXUkKn67pQW6dkhyx9GJ67tb9cJ+dG38oep37yGv
 SnMDt3WHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZLcLwz3b5HZ3if0yKHPFN
 a0PV+aY4iL/4UrBRQfek0Wu1OW9K/RgZzhX/NWy6HVv8g3dPcuzlvy65rvcO8dTqb53TV/t01qT
 NXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Stop open accesses to the reference counts and cargo-culting the same
code in all namespace. Use a set of dedicated helpers and make the
actual count private.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (14):
      ns: add reference count helpers
      mnt: port to ns_ref_*() helpers
      cgroup: port to ns_ref_*() helpers
      ipc: port to ns_ref_*() helpers
      pid: port to ns_ref_*() helpers
      time: port to ns_ref_*() helpers
      user: port to ns_ref_*() helpers
      net-sysfs: use check_net()
      net: use check_net()
      ipv4: use check_net()
      uts: port to ns_ref_*() helpers
      net: port to ns_ref_*() helpers
      nsfs: port to ns_ref_*() helpers
      ns: rename to __ns_ref

 fs/mount.h                       |  2 +-
 fs/namespace.c                   |  4 ++--
 fs/nsfs.c                        |  2 +-
 include/linux/cgroup_namespace.h |  4 ++--
 include/linux/ipc_namespace.h    |  4 ++--
 include/linux/ns_common.h        | 47 ++++++++++++++++++++++++++++++----------
 include/linux/pid_namespace.h    |  2 +-
 include/linux/time_namespace.h   |  4 ++--
 include/linux/user_namespace.h   |  4 ++--
 include/linux/uts_namespace.h    |  4 ++--
 include/net/net_namespace.h      |  8 +++----
 init/version-timestamp.c         |  2 +-
 ipc/msgutil.c                    |  2 +-
 ipc/namespace.c                  |  2 +-
 kernel/cgroup/cgroup.c           |  2 +-
 kernel/nscommon.c                |  2 +-
 kernel/pid.c                     |  2 +-
 kernel/pid_namespace.c           |  4 ++--
 kernel/time/namespace.c          |  2 +-
 kernel/user.c                    |  2 +-
 kernel/user_namespace.c          |  2 +-
 net/core/net-sysfs.c             |  6 ++---
 net/core/net_namespace.c         |  2 +-
 net/ipv4/inet_timewait_sock.c    |  4 ++--
 net/ipv4/tcp_metrics.c           |  2 +-
 25 files changed, 73 insertions(+), 48 deletions(-)
---
base-commit: 3f9cc273c16f63b5d584ec4e767918765c44316b
change-id: 20250917-work-namespace-ns_ref-357162ca7aa8


