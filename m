Return-Path: <linux-fsdevel+bounces-51910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42463ADD21D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A719617D3F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F542ECD2B;
	Tue, 17 Jun 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODz5LSl8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6232820F090
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174752; cv=none; b=MDpngrTZB/sBdx8jlQ/f1ALg/k/nQuUbRmrn66sTtalrcTovdAMo4g3kaWgDLOsH5Ddv67ps7RPqBPleXDafmsk4QyTPRYo7g6DfDX3fmQGVypIT84zD9FV660eDjIgW/bBDrmYJNVEjUpoTfFm1v1+4m1Vx3r6FVEzRNigfpyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174752; c=relaxed/simple;
	bh=ycnqO27G+i01caKOho72IO/PreqWHzzf+3vmqZdwBas=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DIyizcJuj/TfdKxIJmHP1Ii8xUM6PwXpW9vykUaen2Sd7tL7Tk4yKhxmlNGhjH9pDFr5qjoDHkbS5RVB89oq/MobgoteGBFB0usMRGK/5EenwDgYZwq0SrSgnoqtUoKZjtnyAFjPKK5kfo3JgOAUTpOrvUlNahIr05vg2pH2azY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODz5LSl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68947C4CEF1;
	Tue, 17 Jun 2025 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750174752;
	bh=ycnqO27G+i01caKOho72IO/PreqWHzzf+3vmqZdwBas=;
	h=From:Subject:Date:To:Cc:From;
	b=ODz5LSl8ofhECIzHOYdXumRRZrI5FYWdxLJ/gMJkXpg6f+qZUvCdheEnVAR4a0qsM
	 ehU94fBSD5hweicyxxZDqtJ14XwkE2d0C1cw8e3eGmXz5MKYdSfwmal2v6bG7TYv0F
	 ljJzuAYUGwa9DGM/E4U5bfeidX2RHO2PieCWQZeTnhJvKPI2NOgqUOJBGomktm3mfy
	 WjlF2b1YFv2+MFJ/wrldEKD6Z9O9HTMvigSuj/47Xr4d9a0T6OwL8u2Cuci6XTz/Wt
	 tcuM2m2XeyhqiVQi02cSKOwq6T7j7ePop3lsJiOyvfElNohquVhvNuzucsvTF/mAc8
	 5rk6kX4nesH0A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v2 0/2] pidfs: keep pidfs dentry stashed once created
Date: Tue, 17 Jun 2025 17:39:02 +0200
Message-Id: <20250617-work-pidfs-v2-0-529ca1990401@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABaMUWgC/02OwQrCMBBEf0X2bEqTYrCeBMEP8Co9bNJtG6pJ2
 ZSolP67bfHgcQbem5kgEjuKcNpNwJRcdMEvQe13YDv0LQlXLxlUrg65loV4Be7F4OomCqVLVSi
 LWMoGFmBgatx7k93hdr1AtZQGIwnD6G23ep4YR+Is6UxqwVauXOfiGPizfUhyo39z+n8uSZELL
 Awae0TUypx7Yk+PLHAL1TzPX1sb99zNAAAA
X-Change-ID: 20250613-work-pidfs-269232caa91f
To: Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=6145; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ycnqO27G+i01caKOho72IO/PreqWHzzf+3vmqZdwBas=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQE9si5/LkYEGTVl+gmMDt2A6fXdeX4C8L6P8+emSr4d
 U/Blk1MHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZdYfhn2Lg7vT37gI/9FxN
 Xu5YeHGvNs+dIA2/t8FWVtK37p7/EMbIsDyr7sPF2b+uXl6wo/DNxiZvs0uH3u961Xx+m9MtEyb
 +32wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Keep pidfs dentries around after a pidfd has been created for it. The
pidfs dentry will only be cleaned up once the struct pid gets reaped.

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

So if 10 callers create a pidfs for the same struct pid sequentially,
i.e., each closing the pidfd before the other creates a new one then a
new pidfs dentry is allocated every time.

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

That's great expect that it's buggy. If a pidfs dentry is stashed in
pid->stashed after pidfs_exit() but before __unhash_process() is called
we will return a pidfd for a reaped task without exit information being
available.

The pidfds_pid_valid() check does not guard against this race as it
doens't sync at all with pidfs_exit(). The pid_has_task() check might be
successful simply because we're before __unhash_process() but after
pidfs_exit().

This switches to a scheme were pidfs entries are retained after a pidfd
was created for the struct pid. So when allocating a pidfds dentry an
extra reference is retained that is owned by the exit path and that will
be put once the task does get reaped. In the new model pidfs dentries
are still allocated on-demand but then kept until the task gets reaped.

The synchronization mechanism uses the pid->wait_pidfd.lock in struct
pid to synchronize with pidfs_exit() called when the task is reaped. If
the path_from_stashed() fastpath fails, a new pidfs dentry is allocated
and afterwards the pid->wait_pidfd.lock is taken. If no other task
managed to stash its dentry there the callers will be stashed.

When the task is reaped and calls pidfs_exit() the pid->wait_pidfd.lock
is taken. Once pidfs_exit() holds the pid->wait_pidfd.lock and sees that
no pidfs dentry is available in pid->stashed it knows that no new dentry
can be stashed while it holds the pid->wait_pidfd.lock. It thus sets a
ERR_PTR(-ESRCH) sentinel in pid->stashed. That sentinel allows
pidfs_stash_dentry() to detect that the struct pid has already been
reaped and refuse to stash a new dentry in pid->stashed. That works both
in the fast- and slowpath.

This in turn allows us to fix the bug mentioned earlier where we hand
out a pidfd for a reaped task without having exit information set as we
now sync with pidfs_exit() and thus release_task().

This also has some subtle interactions with the path_from_stashed()
fastpath that need to be considered. The path_from_stashed() fast path
will try go get a reference to an already existing pidfs dentry in
pid->stashed to avoid having to allocate and stash a pidfs dentry. If it
finds a dentry in there it will return it.

To not confuse path_from_stashed() pidfs_exit() must not replace a pidfs
dentry stashed in pid->stashed with the ERR_PTR(-ESRCH) sentinel as
path_from_stashed() could legitimately obtain another reference before
pidfs_exit() was able to call dput() to put the final pidfs dentry
reference. If it were to put the sentinel into pid->stashed it would
invalidate a struct pid even though a pidfd was just created for it.

So if a pidfs dentry is stashed in pid->stashed pidfs_exit() must leave
clearing out pid->stashed to dentry->d_prune::pidfs_dentry_prune(). When
pruning a dentry we must take care to not take the pid->wait_pidfd.lock
as this would cause a lock inversion with dentry->d_lock in
pidfs_stash_dentry(). This should fortunately not at all be necessary as
by the time we call pidfs_dentry_prune() we know that the struct pid is
dead as the task is reaped and that anyone concurrently trying to get a
reference to the stashed dentry will fail to do so.

IOW, it doesn't matter whether the path_from_stashed() fast path sees
NULL, a dead dentry, or the ERR_PTR(-ESRCH) sentinel in pid->stashed.
Any of those forces path_from_stashed() into the slowpath at which point
pid->wait_pidfd.lock must be acquired. The slowpath will then see either
a dead dentry or the ERR_PTR(-ESRCH) sentinel but never NULL and thus
fail the creation of a new pidfs dentry.

path_from_stashed() must take care to not try and take a reference on
the ERR_PTR(-ESRCH) sentinel. So stashed_dentry_get() must be prepared
to see a ERR_PTR(-ESRCH) sentinel in pid->stashed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Fix lock inversion.
- Link to v1: https://lore.kernel.org/20250616-work-pidfs-v1-0-a3babc8aa62b@kernel.org

---
Christian Brauner (2):
      pidfs: keep pidfs dentry stashed once created
      pidfs: remove pidfs_pid_valid()

 fs/internal.h |   2 +
 fs/libfs.c    |  22 +++++--
 fs/pidfs.c    | 191 ++++++++++++++++++++++++++++++++++++++--------------------
 kernel/pid.c  |   2 +-
 4 files changed, 147 insertions(+), 70 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250613-work-pidfs-269232caa91f


