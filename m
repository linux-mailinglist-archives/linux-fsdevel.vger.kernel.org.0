Return-Path: <linux-fsdevel+bounces-37146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE9B9EE618
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F88167C35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B259C214A7D;
	Thu, 12 Dec 2024 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShQpLjPc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFFD212B0E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004575; cv=none; b=X8KsCuyf5ZRs9Xcw8VDjcOWUC5LWsbtad5LSQGkt/76MYoOwk9NJH4YEhSVKIPAY3A7HSoAI+LYaqcM0MA/y4fsTQf6TyAAs7/OwfyqjIb2liSuXczhTTRauUzY3sjwCuOLZ2vJg0/I/l5VEW/UHR8fINQabZiXvaEnN1d69lQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004575; c=relaxed/simple;
	bh=hKrc0+NpOJXguyEhzpSgTPb+aFRilAdZGS8IEyz+sfM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VuKqgk9SYChQn4g2NCFtnFFeppTQBlxe2aw32iO+T8pGSJ7uBGnetod9CP4A1f8ls8bnS//G/Qcf04BQkUYQ8XlWlTVMz4/jb885xFGiPA/KgbgcVBbgbts6ajYfxx1bKKENh1utTwaGUNqwV1A9MmbAMCx2qGAX+Y3w0ZMj4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShQpLjPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BABAC4CECE;
	Thu, 12 Dec 2024 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734004574;
	bh=hKrc0+NpOJXguyEhzpSgTPb+aFRilAdZGS8IEyz+sfM=;
	h=From:Subject:Date:To:Cc:From;
	b=ShQpLjPchqY5gIHLFTaWBsj2GZA66xw9PjOF5HBVzzJwEyLIsRlqBhaM0Dh+UALxI
	 uEe19u2z7T3Ye6ayPGvnKJLiGcXLvA1jnzY53wM6u8LVob/S5WK1sPe13xaIc9GcYn
	 5zSjjn84nyv+GsvY4EPRDya3feP3K4OHQt8OeP9DWEl5ru8rjv4i+STYP12EVEL9f0
	 M67NvUPYrV+uzOaa5RNMTAys7ZuwiRqswpzu/lj2lLdwzUCxyRZdcLmL7F4ZQuYysZ
	 yztTeyHx2vBW6mCgi5jTr816jl9sl/WHPJWxmsbKGw1VF6sklcroTA+ZT6vT+55P2c
	 piPgVqkjWdlrw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/8] fs: lockless mntns lookup
Date: Thu, 12 Dec 2024 12:55:59 +0100
Message-Id: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE/PWmcC/32OwQ6CMBAFf4X07JK2EIqe/A/DgcICDdiaba0aw
 r9biGePc3gzb2UeyaBnl2xlhNF442wCecpYN7V2RDB9Yia5LIXkCl6OZri7pw1AOhAiLK6bF/Q
 eVF9yJbQqB1GzJHgQDuZ9yG9NYt16BE2t7aZdeW99QMpjlYsCqBP7ZDI+OPocd6LYh7+y4P/KU
 QCHoqiLqtJnrbG8zkgWl9zRyJpt275rj9II6AAAAA==
X-Change-ID: 20241207-work-mount-rbtree-lockless-7d4071b74f18
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hKrc0+NpOJXguyEhzpSgTPb+aFRilAdZGS8IEyz+sfM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHnY+ZF/3L4fHb3WtmS1j77rqZ4s8UsuQ4o+LVBnVH+
 Td3GPcs7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI2HaGv6LWX4WChCyspjZv
 Yfl+axf7spkHH8j5MUn0Tvjsc3XT82iGv+JNkdOVi48z8VTNMv+y8KXuLIsSJqm1bkt6t4adm/H
 nCSMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

Currently we take the read lock when looking for a mount namespace to
list mounts in. We can make this lockless. The simple search case can
just use a sequence counter to detect concurrent changes to the rbtree.

For walking the list of mount namespaces sequentially via nsfs we keep a
separate rcu list as rb_prev() and rb_next() aren't usable safely with
rcu.

Since creating mount namespaces is a relatively rare event compared with
querying mounts in a foreign mount namespace this is worth it. Once
libmount and systemd pick up this mechanism to list mounts in foreign
mount namespaces this will be used very frequently.
doing.

Thanks!
Christian

---
Changes in v2:
- Remove mnt_ns_find_it_at() by switching to rb_find_rcu().
- Add separate list to lookup sequential mount namespaces.
- Link to v1: https://lore.kernel.org/r/20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org

---
Christian Brauner (8):
      mount: remove inlude/nospec.h include
      fs: add mount namespace to rbtree late
      fs: lockless mntns rbtree lookup
      rculist: add list_bidir_{del,prev}_rcu()
      fs: lockless mntns lookup for nsfs
      fs: simplify rwlock to spinlock
      selftests: remove unneeded include
      samples: add test-list-all-mounts

 fs/mount.h                            |  20 +--
 fs/namespace.c                        | 158 ++++++++++++++---------
 fs/nsfs.c                             |   5 +-
 include/linux/rculist.h               |  43 +++++++
 samples/vfs/.gitignore                |   1 +
 samples/vfs/Makefile                  |   2 +-
 samples/vfs/test-list-all-mounts.c    | 235 ++++++++++++++++++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd.h |   1 -
 8 files changed, 387 insertions(+), 78 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241207-work-mount-rbtree-lockless-7d4071b74f18


