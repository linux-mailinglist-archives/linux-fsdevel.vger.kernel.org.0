Return-Path: <linux-fsdevel+bounces-52117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41709ADF814
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0017F18808F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B564C21ADA2;
	Wed, 18 Jun 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK8K1Ms5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175151B78F3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280029; cv=none; b=cZhXsVTSnMQCmDkigoGGn2qp15g9cc+CNVlv9IIFwR4410LBjEUxxXudmhiLe+0wLSm64IHl1Q9xLvvy8iZd+DWSItW6hyvTZZl+q7HnbTzDXM+AxHEHMw84ezfN2UgW+BIiVhpk2aBnR+ganXJjVCVu0DXwHbl0lyK9eJi7iz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280029; c=relaxed/simple;
	bh=f+x8CE09p9Tc6dmPtkUg/hPf87qNJGZ5eby641hBY2Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HcoyaNj0pqSxjo/IHV+HwO6mP9xPwUglLwFFK+DdpI5FVofBjdwkmXZIEHZrGGLFpMWGYPs4DYdILOYWhl3plVF8fgMeAJalexaL5W/eMwlRKzxDgiGKJoM6Skm9QFAPxBUXeSC5gkzCm/hP/sfuGlFEvMU5NH/CaD60R9Uw+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK8K1Ms5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B00C4CEE7;
	Wed, 18 Jun 2025 20:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280028;
	bh=f+x8CE09p9Tc6dmPtkUg/hPf87qNJGZ5eby641hBY2Q=;
	h=From:Subject:Date:To:Cc:From;
	b=jK8K1Ms5h3McKXDcUU5nGiLUYR9MAt1VMEcCfpobVqJnVRRhMuTE7zf3eay5YnRYO
	 2NqtxviUqMXou0vE1vx5KGE0CmEm0bHJ7PPQdOklElsarh5MzXrqIVtbkgnTcYCBJD
	 wGcUKcYZ8J6mUG5VbuisOYkauK/ZNX/FUbzpEG6gAzffhCSVTK6JozVFs9WX1EFzj7
	 RqbS8q+VUoRI2GAJkvfpYBXqOZnA+iLtQDAYR9a6vHMVApzTW0Li/GbWA5R5Z+TzPq
	 Ba9+BK+BTZn5bFRNkrQQpl3GoY1q1RWrv0ZbKJXDLez1BBcXhP7MGIxCnPIXOYvz+A
	 V1cWPs8ONsrMg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 00/16] pidfs: persistent info & xattrs
Date: Wed, 18 Jun 2025 22:53:34 +0200
Message-Id: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE4nU2gC/x3MQQqDMBBA0avIrDtiIgmlVyldJHFSh9IYZkQL4
 t2bdvkW/x+gJEwKt+4AoY2Vl9JgLx2kOZQnIU/NYAfrBm+uuC/ywspTVqwkyrpSWdE6k2lM2aU
 xQmurUObP/3t/NMeghFFCSfPv9g4tk37zvfEoycB5fgF2HZ73igAAAA==
X-Change-ID: 20250618-work-pidfs-persistent-251fe3cf5c3b
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=5498; i=brauner@kernel.org;
 h=from:subject:message-id; bh=f+x8CE09p9Tc6dmPtkUg/hPf87qNJGZ5eby641hBY2Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0dM3bu7MVo8sHjCnQjR7mqtJ+fvPWk0VHGN1Xi4r
 Ub1VhNrRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET+/WRkeBz2umf66evHnjzT
 tJdZrKolb9NXWcm28EnU8QRvZc6m94wM659Z+TpMvPc+6sTK2p8eYqov2utqRdO3JibN7vfaK+r
 GCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Persist exit and coredump information independent of whether anyone
currently holds a pidfd for the struct pid.

The current scheme allocated pidfs dentries on-demand repeatedly.
This scheme is reaching it's limits as it makes it impossible to pin
information that needs to be available after the task has exited or
coredumped and that should not be lost simply because the pidfd got
closed temporarily. The next opener should still see the stashed
information.

This is also a prerequisite for supporting extended attributes on
pidfds to allow attaching meta information to them.

If someone opens a pidfd for a struct pid a pidfs dentry is allocated
and stashed in pid->stashed. Once the last pidfd for the struct pid is
closed the pidfs dentry is released and removed from pid->stashed.

So if 10 callers create a pidfs dentry for the same struct pid
sequentially, i.e., each closing the pidfd before the other creates a
new one then a new pidfs dentry is allocated every time.

Because multiple tasks acquiring and releasing a pidfd for the same
struct pid can race with each another a task may still find a valid
pidfs entry from the previous task in pid->stashed and reuse it. Or it
might find a dead dentry in there and fail to reuse it and so stashes a
new pidfs dentry. Multiple tasks may race to stash a new pidfs dentry
but only one will succeed, the other ones will put their dentry.

The current scheme aims to ensure that a pidfs dentry for a struct pid
can only be created if the task is still alive or if a pidfs dentry
already existed before the task was reaped and so exit information has
been was stashed in the pidfs inode.

That's great except that it's buggy. If a pidfs dentry is stashed in
pid->stashed after pidfs_exit() but before __unhash_process() is called
we will return a pidfd for a reaped task without exit information being
available.

The pidfds_pid_valid() check does not guard against this race as it
doens't sync at all with pidfs_exit(). The pid_has_task() check might be
successful simply because we're before __unhash_process() but after
pidfs_exit().

Introduce a new scheme where the lifetime of information associated with
a pidfs entry (coredump and exit information) isn't bound to the
lifetime of the pidfs inode but the struct pid itself.

The first time a pidfs dentry is allocated for a struct pid a struct
pidfs_attr will be allocated which will be used to store exit and
coredump information.

If all pidfs for the pidfs dentry are closed the dentry and inode can be
cleaned up but the struct pidfs_attr will stick until the struct pid
itself is freed. This will ensure minimal memory usage while persisting
relevant information.

The new scheme has various advantages. First, it allows to close the
race where we end up handing out a pidfd for a reaped task for which no
exit information is available. Second, it minimizes memory usage.
Third, it allows to remove complex lifetime tracking via dentries when
registering a struct pid with pidfs. There's no need to get or put a
reference. Instead, the lifetime of exit and coredump information
associated with a struct pid is bound to the lifetime of struct pid
itself.

Now that we have a way to persist information for pidfs dentries we can
start supporting extended attributes on pidfds. This will allow
userspace to attach meta information to tasks.

One natural extension would be to introduce a custom pidfs.* extended
attribute space and allow for the inheritance of extended attributes
across fork() and exec().

The first simple scheme will allow privileged userspace to set trusted
extended attributes on pidfs inodes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (16):
      pidfs: raise SB_I_NODEV and SB_I_NOEXEC
      libfs: massage path_from_stashed() to allow custom stashing behavior
      libfs: massage path_from_stashed()
      pidfs: move to anonymous struct
      pidfs: persist information
      pidfs: remove unused members from struct pidfs_inode
      pidfs: remove custom inode allocation
      pidfs: remove pidfs_{get,put}_pid()
      pidfs: remove pidfs_pid_valid()
      libfs: prepare to allow for non-immutable pidfd inodes
      pidfs: make inodes mutable
      pidfs: support xattrs on pidfds
      selftests/pidfd: test extended attribute support
      selftests/pidfd: test extended attribute support
      selftests/pidfd: test setattr support
      pidfs: add some CONFIG_DEBUG_VFS asserts

 fs/coredump.c                                      |   6 -
 fs/internal.h                                      |   3 +
 fs/libfs.c                                         |  34 +-
 fs/pidfs.c                                         | 422 ++++++++++++---------
 include/linux/pid.h                                |  14 +-
 include/linux/pidfs.h                              |   3 +-
 kernel/pid.c                                       |   2 +-
 net/unix/af_unix.c                                 |   5 -
 tools/testing/selftests/pidfd/.gitignore           |   2 +
 tools/testing/selftests/pidfd/Makefile             |   3 +-
 tools/testing/selftests/pidfd/pidfd_setattr_test.c |  69 ++++
 tools/testing/selftests/pidfd/pidfd_xattr_test.c   | 132 +++++++
 12 files changed, 480 insertions(+), 215 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250618-work-pidfs-persistent-251fe3cf5c3b


