Return-Path: <linux-fsdevel+bounces-62561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC7AB99989
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F294C59E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5B02FDC4A;
	Wed, 24 Sep 2025 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jk1hnEN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F972FC011;
	Wed, 24 Sep 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713652; cv=none; b=Kg5E8fc4aXpruKnxASVPdvc5zyzH3dTiZbY7Q3jFAposNjUzYuP7DaaNGw2GwU2ZIKio2/558jHai5ffA8tTiZbTI2Gsgr0O0pSxiR9l3m1+bqEFjAnExoAVk5mZh6hWS8jmcSgiYNFQuhf3g+95R4Lid96UIqO+cUYYMI7dvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713652; c=relaxed/simple;
	bh=/ezYUcqnip5J6jqaTEpaDvjUfR7giuaSikKG8yRZwBc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cBe+oZv7Btp3eV1DYUbLS/1XXwJvUti70qARZYIPxLXCFXlmYl9Cs3b/EcUmRXafFOZlDplpYMF19+Po3YpFK2qU0ES2Z7p0mWMyZiTgNIy53E+oFh+39j/Qp+dVKkle9l0Gh12xDxiPQauJTcNCbZxh4CxQ27hI3tyLX60Tk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jk1hnEN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8268C19422;
	Wed, 24 Sep 2025 11:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758713651;
	bh=/ezYUcqnip5J6jqaTEpaDvjUfR7giuaSikKG8yRZwBc=;
	h=From:Subject:Date:To:Cc:From;
	b=jk1hnEN8qankoJ/FNrwmre+6GPzRS4KY13pRpnEIjo9dc01ZDY8Ww3pT6I0OTXz2d
	 pqfDAjRfQo4gAn93M7toNw5ttyW8DyEITN6r0CLyC1xVvIP8sfQW7E4Bo5i0iZNp3g
	 2cijDCcMBRwLaXfnueMsIDTt7jpNi6LYO8V7/gFyvvHQwgb84HlCBDyiyZg29A7aSH
	 rqKvtmcZ5qJSWpYTJSKS6Sv7kzpQfAzvR6Ab551CvR3Eai900z7JaNKspkz58ZyJp4
	 BjqZQANaUcwvkaUq1ANrZN7JAjWwMQq7FtnRSkjbdrVCfe2c7ULvi1AXMDzzQQjKQf
	 iYjfnRauM4RMQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] ns: tweak ns common handling
Date: Wed, 24 Sep 2025 13:33:57 +0200
Message-Id: <20250924-work-namespaces-fixes-v1-0-8fb682c8678e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACXX02gC/z2MQQrCMBBFr1Jm7WgTtDReRVxMk7EdrEmZgAqld
 3d04ebD4/PeCpVVuMK5WUH5KVVKNnC7BuJEeWSUZAy+9ac2+CO+it4x04PrQpEr3uRtG0Jqo4v
 sU9+BuYvy7zD1cjUeqDIOSjlO31pRGSUjzfPhn8Ju73rYtg9tKdwrkwAAAA==
X-Change-ID: 20250924-work-namespaces-fixes-99d0c1ce2d86
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/ezYUcqnip5J6jqaTEpaDvjUfR7giuaSikKG8yRZwBc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcvq6vtnv3jc8Ll6qoL709dZvGwXSrYGOWuRnMKgvF0
 pLk6pbt7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgIdzwjwycxxRlxpnIKOzxN
 n6+fsl1qQRzbvOq3+00Dtsy6+1vq6U9GhmtKPkUiDmmcC048Mft9oDR6psbiBeHXpBdFZN1xZtC
 azg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This contains three minor tweaks for namespace handling:

* Make struct ns_tree private. There's no need for anything to access
  that directly.

* Drop a debug assert that would trigger in conditions that are benign.

* Move the type of the namespace out of struct proc_ns_operations and
  into struct ns_common. This eliminates a pointer dereference and also
  allows assertions to work when the namespace type is disabled and the
  operations field set to NULL.

"Trust me, just one more fixes series, bro. Just one more, bro."

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      nstree: make struct ns_tree private
      ns: move ns type into struct ns_common
      ns: drop assert

 fs/namespace.c            |  6 +++---
 fs/nsfs.c                 | 18 +++++++++---------
 include/linux/ns_common.h | 30 +++++++++++++++++++++++++-----
 include/linux/nstree.h    | 13 -------------
 include/linux/proc_ns.h   |  1 -
 init/version-timestamp.c  |  1 +
 ipc/msgutil.c             |  1 +
 ipc/namespace.c           |  1 -
 kernel/cgroup/cgroup.c    |  1 +
 kernel/cgroup/namespace.c |  1 -
 kernel/nscommon.c         |  7 +++----
 kernel/nsproxy.c          |  4 ++--
 kernel/nstree.c           | 21 +++++++++++++++++----
 kernel/pid.c              |  1 +
 kernel/pid_namespace.c    |  2 --
 kernel/time/namespace.c   |  3 +--
 kernel/user.c             |  1 +
 kernel/user_namespace.c   |  1 -
 kernel/utsname.c          |  1 -
 net/core/net_namespace.c  |  1 -
 20 files changed, 65 insertions(+), 50 deletions(-)
---
base-commit: d969328c513c6679b4be11a995ffd4d184c25b34
change-id: 20250924-work-namespaces-fixes-99d0c1ce2d86


