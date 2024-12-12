Return-Path: <linux-fsdevel+bounces-37240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B86D9EFFC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 00:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729BE1684F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 23:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021CF1DE893;
	Thu, 12 Dec 2024 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4M5Cl1/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69E1D7E5F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 23:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044637; cv=none; b=ZIHbI44jhDMNAM0Kii2JbiGX0dnyf2YwmOIJvhT89QGU0OfB35qZaxQmh5B0b/dtyTfGXmU/oh84i1mEAU4MDvCun9x8fZvzdNfOUu1HYm9umWhWNCk+C5nEviJukA666yzVEPldFT9EeKkA79Ugn/pHJo1psbWoGFFhpe6KSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044637; c=relaxed/simple;
	bh=UbdOFLWvW5smbLL4qTCq4dIYkiOsrVYVOH0L2NEpdio=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fhstARbg+Fwk4u+GOvsfi89LVfLjwNouA446FVad8mKQMW6k7lLBv5p+PTOw64PgZ+NwiCnj1+9Alv8DxwXqLmR0hDH/rsmxNp8MGKhgHwTsN4X81Vj5wHRZcfscBRpPnU1t1EIiA+OKvzz47XJn05dSq1AUFU6JZz4Y5kBKh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4M5Cl1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F774C4CECE;
	Thu, 12 Dec 2024 23:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734044636;
	bh=UbdOFLWvW5smbLL4qTCq4dIYkiOsrVYVOH0L2NEpdio=;
	h=From:Subject:Date:To:Cc:From;
	b=g4M5Cl1/Pze9kOxFL/yCjR2q5qFtkMyggJnrgfAbq+zfkO7mX2TczMEEphx8gK502
	 Q7du618KcpynIyaGdYifF4Nu2nHtENA308+tbUpVzOfiTx81YlbWuYA+kbnCj3H8Z7
	 vCVYRREQR7ZgtXNM0pemV4PGRBa5QXYKPOmOZJhIVYEja73xSVWegjhh1yofUxdKpV
	 4nPrdgX8wEmzpVy36moTCc+9BgfPSwLJY5XxQSBFny0k/g3e7E67sS+IwtCR4yyDGz
	 nT7vnLhmogj6oOezWWxf7r42yMyH7he20NwvH7yNwt9fN8Ilk9nNyivBs9RYq/7BgY
	 k443wKcMh4Flw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 00/10] fs: lockless mntns lookup
Date: Fri, 13 Dec 2024 00:03:39 +0100
Message-Id: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMtrW2cC/33OzQ6CMBAE4FcxPbukf4J68j2MB1oXacDWbLFqD
 O9uIR70wnEO8828WURyGNl+9WaEyUUXfA5qvWK2rf0FwZ1zZpJLLSSv4BGog2u4+wHIDIQIfbB
 djzFCdda8EqbSjdiyDNwIG/ec8eMpZ1NHBEO1t+1EXus4IBWpLIQCsmKqtC4OgV7znSSm4ndZ8
 KXlJICDUltVlmZnDOpDh+SxLwJd2DSd5K8lFy2ZLd1gabHhcqP+rXEcP0yq48Q0AQAA
X-Change-ID: 20241207-work-mount-rbtree-lockless-7d4071b74f18
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3099; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UbdOFLWvW5smbLL4qTCq4dIYkiOsrVYVOH0L2NEpdio=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHZ9+qEczcK+X9tLhmy5HiwJ/c4au4qrQ07ugbWEwpO
 LGm2Xl2RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQkORkZVk3g8a/UDJPqn6Fy
 T4DfT9ZqXc/PRaErT23K2qi578ev3Qz/vVZGzTolsJS7/LfLpHvFWe7rV//nUMm7vT0jJCFG71I
 cOwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

This now also includes selftests for iterating mount namespaces both
backwards and forwards.

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

Thanks!
Christian

---
Changes in v3:
- Add selftests.
- Put list_head into a union with the wait_queue_head_t for poll instead
  of the mnt_ns_tree_node which would've risked breaking rbtree
  traversal.
- Handle insertion into the mount namespace list correctly by making use
  of the rbtree position information after the mount namespace has been
  added to it.
- Improve the documentation for the new list_bidir_{del,prev}_rcu().
- Link to v2: https://lore.kernel.org/r/20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org

Changes in v2:
- Remove mnt_ns_find_it_at() by switching to rb_find_rcu().
- Add separate list to lookup sequential mount namespaces.
- Link to v1: https://lore.kernel.org/r/20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org

---
Christian Brauner (10):
      mount: remove inlude/nospec.h include
      fs: add mount namespace to rbtree late
      fs: lockless mntns rbtree lookup
      rculist: add list_bidir_{del,prev}_rcu()
      fs: lockless mntns lookup for nsfs
      fs: simplify rwlock to spinlock
      seltests: move nsfs into filesystems subfolder
      selftests: add tests for mntns iteration
      selftests: remove unneeded include
      samples: add test-list-all-mounts

 fs/mount.h                                         |  18 +-
 fs/namespace.c                                     | 163 ++++++++------
 fs/nsfs.c                                          |   5 +-
 include/linux/rculist.h                            |  47 +++++
 samples/vfs/.gitignore                             |   1 +
 samples/vfs/Makefile                               |   2 +-
 samples/vfs/test-list-all-mounts.c                 | 235 +++++++++++++++++++++
 .../selftests/{ => filesystems}/nsfs/.gitignore    |   1 +
 .../selftests/{ => filesystems}/nsfs/Makefile      |   4 +-
 .../selftests/{ => filesystems}/nsfs/config        |   0
 .../selftests/filesystems/nsfs/iterate_mntns.c     | 149 +++++++++++++
 .../selftests/{ => filesystems}/nsfs/owner.c       |   0
 .../selftests/{ => filesystems}/nsfs/pidns.c       |   0
 tools/testing/selftests/pidfd/pidfd.h              |   1 -
 14 files changed, 546 insertions(+), 80 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241207-work-mount-rbtree-lockless-7d4071b74f18


