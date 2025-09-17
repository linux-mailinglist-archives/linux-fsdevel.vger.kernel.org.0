Return-Path: <linux-fsdevel+bounces-61900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B1B7EB2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5501C0314A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 10:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E432DF71E;
	Wed, 17 Sep 2025 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txxfI2C8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D6306498;
	Wed, 17 Sep 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104915; cv=none; b=CIpWOh+XUzgPIm5w2nlJwdLLGa8+CYQ5X6xXbV7BHD3pUGb4Lj60GiYqcRE14XLddAasXoqZCbso7MRydrbJNog7snWIAy3X2BdOwlRGV4LU0b01SAYcRe90HbJ+A5iteW2ShwVmYqlM7FmKdJYIKTBI6C/77Jrl+CfeE9o0cFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104915; c=relaxed/simple;
	bh=6Fbk1AWCJkKzgSUrfIvCQZYtZjMyGsGaw3a7FOb//jc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xbx3hoqQYwnI80p1kRIoyTIeltL6Nnj5gPsgCZKGXkR7WL7ou3Zqbc9mKYlZkMe2QsDmEfg0HvlQO2APSpfQly4P9/B4hW5x2qF/lPzgLaqt6M4lSOzVdcgPDTgG9QX7Z3i6SY5c2n8fYdazPqxc8jvzoZehZ7KD0F7DADBvQl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txxfI2C8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1FDC4CEF0;
	Wed, 17 Sep 2025 10:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104915;
	bh=6Fbk1AWCJkKzgSUrfIvCQZYtZjMyGsGaw3a7FOb//jc=;
	h=From:Subject:Date:To:Cc:From;
	b=txxfI2C8t9zqn/W6qoRHRsg9YVf+acGtNqdRHEb735n9avqnFj/OnWflHYRI5zujJ
	 LP7lzkakqsah4XdI3DOIwvjWZmD3z0MBfkLsOJylm5JwwmqsrZtomxw/+i8X176jLN
	 HcdeCrixaN2qziTTw1+p/it42cuexxbmmc7k8ayaqU5neYpasjr3bWBkaCv5u+We8Y
	 w+ZEWm5ZjPnTkRoZLA23JMyzVVZ9Q4vcsaGVWRXPb12Qf+8ggIjGf5JXZNX7MuuDIL
	 hcYVOxrHwI6LGeEi0snKBvdviv0i6MLMi5XmhrcZkLUaQzLmOa0TsKbMoeVe5ZHZYM
	 RUbGybX1p0uDw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/9] ns: rework common initialization
Date: Wed, 17 Sep 2025 12:27:59 +0200
Message-Id: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADCNymgC/0WNQQ6CMBAAv0J6dpESisWvGEOWssDGsiVtoiaEv
 1u9eJzDzOwqUWRK6lrsKtKTEwfJoE+FcgvKTMBjZlVXtak6fYFXiA8QXClt6Agk9S6saxAw1nR
 Na6lxxqisb5Emfv/St3vmARPBEFHc8g2GyDMLoPfnf60ttS0n9tTn9+izfBwfSuxwbKMAAAA=
X-Change-ID: 20250917-work-namespace-ns_common-5859468e4c55
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6Fbk1AWCJkKzgSUrfIvCQZYtZjMyGsGaw3a7FOb//jc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc6vWNbnF/+9Yg77h7kTXXB3Ym/ea313JzGpeLJOc0n
 jsT8+JsRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETelzD8Uym6IFzs6r0gkofh
 xBlFXe7Db38+OCTS/Vjr5YZ3rAXMiQz/q4sXba/ZVbDqaK25rIJSS4m8CePqL5tsrruWiu0WD87
 lAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The current scheme still involves a lot of open-coding and copy-pasing
and bleeds a lot of unnecessary details into actual namespace
implementers. Encapsulate it in the common helpers and simplify it all.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (9):
      uts: split namespace into separate header
      mnt: expose pointer to init_mnt_ns
      nscommon: move to separate file
      cgroup: split namespace into separate header
      nsfs: add inode number for anon namespace
      mnt: simplify ns_common_init() handling
      net: centralize ns_common initialization
      nscommon: simplify initialization
      ns: add ns_common_free()

 fs/namespace.c                   | 16 ++++++----
 include/linux/cgroup.h           | 51 +------------------------------
 include/linux/cgroup_namespace.h | 56 ++++++++++++++++++++++++++++++++++
 include/linux/mnt_namespace.h    |  2 ++
 include/linux/ns_common.h        | 43 ++++++++++++++++++++++++++
 include/linux/proc_ns.h          | 21 -------------
 include/linux/uts_namespace.h    | 65 ++++++++++++++++++++++++++++++++++++++++
 include/linux/utsname.h          | 58 +----------------------------------
 include/uapi/linux/nsfs.h        |  3 ++
 ipc/namespace.c                  |  6 ++--
 kernel/Makefile                  |  2 +-
 kernel/cgroup/namespace.c        |  4 +--
 kernel/nscommon.c                | 25 ++++++++++++++++
 kernel/pid_namespace.c           |  6 ++--
 kernel/time/namespace.c          |  4 +--
 kernel/user_namespace.c          |  6 ++--
 kernel/utsname.c                 |  4 +--
 net/core/net_namespace.c         | 23 ++------------
 18 files changed, 225 insertions(+), 170 deletions(-)
---
base-commit: bf56a464f4ad7143c6e4b581b411f682f345a344
change-id: 20250917-work-namespace-ns_common-5859468e4c55


