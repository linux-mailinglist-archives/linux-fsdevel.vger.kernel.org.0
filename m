Return-Path: <linux-fsdevel+bounces-51762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE82ADB2E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4600516978F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397911C5D59;
	Mon, 16 Jun 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPpim8bt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7264818871F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082578; cv=none; b=AFC59TbzZ1CzChb3kfTd1z/fekn+nNtKPVDFJ/MIxrWAYmfIb+wmPgunnokBxkJ66j+4axYhVesEouOvIoqK7Mjfe1ojElXVJVjKPNcbqjIVbVsGbQoO6LJhx6c8IlAChjv/VaGuk8E4fT+scyJsA8KLBlgW+VW576cLPYn/XCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082578; c=relaxed/simple;
	bh=93qLzCFJFtm95RtDqsuqRsWq/1FkTjfqQoFSej2RcL0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CWpxCJQJ29JTklxur7f1uMfDtN8mrP0yoOYVOQMhcwhFA3dvB8pNgihzvM5sRwPcoLM281XGYIM8fm/RQaQftvVJZcF7D+HyRxUtY4Po5H9fLvCAyquHENsm54aznjTyoPf3e4uSAAAMt/cOhf20yG4a9FgEEsSeU6Q3282Jbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPpim8bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3050AC4CEED;
	Mon, 16 Jun 2025 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750082578;
	bh=93qLzCFJFtm95RtDqsuqRsWq/1FkTjfqQoFSej2RcL0=;
	h=From:Subject:Date:To:Cc:From;
	b=DPpim8btkFEh7duMjgCMqJo9wCrisj1pqogIvKjClgfGDF3oxzCxBN1yHA2vFcL9q
	 aIClt5X6pytPYOD0oWaquCPsmJsoGfSXBcC8LDagqFAqjrU+BMuhrGXtF2Jnt/gkxK
	 pL//FNoQVHHMcZ7Qr4Q8MHF32Xo3nIfBTozYAN0hBg0E4LmQyv29xgPtzgHeiS4OsK
	 cRmXeWyKR1Mz2Mmifj35KuimPkDGku8ywNq5cJH4TSEJI4maIkkJ1spy4Sd3yQVl0F
	 wNm5cwwOaxRISMmty8X1q01IbbZT6zELN8qbaUUmmq3kSEdYBMxI0eSxPbmGHlRzSa
	 WYzNSjRx0/ZDA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/2] pidfs: keep pidfs dentry stashed once created
Date: Mon, 16 Jun 2025 16:02:46 +0200
Message-Id: <20250616-work-pidfs-v1-0-a3babc8aa62b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAYkUGgC/x2MQQrCMBAAv1L27JYmxUC9Cj6gV/GwTTd2EdOyK
 1Uo/bvR4wzMbGCswganagPlVUzmXMAdKogT5TujjIXBN/7YBNfie9YHLjImQx863/pI1LkEJVi
 Uk3z+syv0lzPcihzIGAelHKff50n2Yq3XULuAGh3s+xeXIoPYhAAAAA==
X-Change-ID: 20250613-work-pidfs-269232caa91f
To: Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=5373; i=brauner@kernel.org;
 h=from:subject:message-id; bh=93qLzCFJFtm95RtDqsuqRsWq/1FkTjfqQoFSej2RcL0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEqAiUPbh8MPaotfr2Rq01M5W4tSwsd319ILfiksXjn
 YwBsYqeHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNxamP4p3rK5LtxZ46acdz1
 PaofHab6c66eKRL/NILrffR9PkZRd4b/uZwlPPvyQhYJ3vp9R3SdiA0bg/hvvuTzCn9e2qlyNS3
 mBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Keep pidfs dentries around after a pidfd has been created for it.
Such pidfs dentry will only be cleaned up once the struct pid gets
reaped. This also allows us to fix a race condition that currently
exists in the code.

The current scheme allocated pidfs dentries on-demand repeatedly.

If someone opens a pidfd for a struct pid a pidfs dentry is allocated
and stashed in pid->stashed. Once the last pidfd for the struct pid is
closed the pidfs dentry is released and removed from pid->stashed.

So if 10 callers create a pidfs for the same struct pid sequentially,
i.e., each closing the pidfd before the other creates a new one then a
new pidfs dentry is allocated every time.

Because multiple tasks acquiring and releasing a pidfd for the same
struct pid can race with each other a task may still find a valid pidfs
entry from the previous task in pid->stashed and reuse it. Or it might
find a dead dentry in there and fail to reuse it and so stashes a new
pidfs dentry. Multiple tasks may race to stash a new pidfs dentry but
only one will succeed, the other ones will put their dentry.

The current scheme ensures that a reference to a struct pid can only be
taken if the task is still alive or if a pidfs dentry already existed
and exit information has been stashed in the pidfs inode.

Except that it's also buggy. If a pidfs dentry is stashed in
pid->stashed after pidfs_exit() but before __unhash_process() is called
we will return a pidfd for a reaped task without exit information being
available.

The pidfds_pid_valid() check does not guard against this race as it
doens't sync at all with pidfs_exit(). The pid_has_task() check might be
successful simply because we're before __unhash_process() but after
pidfs_exit().

The current scheme also makes it impossible to pin information that
needs to be available after the task has exited or coredumped and that
should not be lost simply because the pidfd got closed. The next opened
should still see the stashed information.

This switches to a scheme were pidfs entries are retained after a pidfd
was created for the struct pid. So retain a reference is retained that
belongs to the exit path and that will be put once the task does get
reaped. In the new model pidfs dentries are still allocated on-demand
but then kept until the task gets reaped.

The synchronization mechanism used the pid->wait_pidfd.lock in struct
pid. If the path_from_stashed() fastpath fails a new pidfs dentry is
allocated and afterwards the pid->wait_pidfd.lock is taken. If no other
task managed to stash its dentry there the callers will be stashed.

Similarly when a pidfs dentry is pruned via
dentry->d_prune::pidfs_dentry_prune() the pid->wait_pidfd.lock is also
taken.

And finally the pid->wait_pidfd.lock is taken during pidfs_exit(). This
allows us to fix the bug mentioned earlier where we hand out a pidfd for
a reaped task without having exit information set.

Once pidfs_exit() holds the pid->wait_pidfd.lock and sees that no pidfs
dentry is available in pid->stashed it knows that no new dentry can be
stashed while it holds the pid->wait_pidfd.lock. It thus sets a
ERR_PTR(-ESRCH) sentinel in pid->stashed. That sentinel allows
pidfs_stash_dentry() to detect that the struct pid has already been
reaped and refuse to stash a new dentry in pid->stashed.

This also has some subtle interactions with the path_from_stashed()
fastpath that need to be considered. The path_from_stashed() fast path
will try go get a reference to the pidfs dentry in pid->stashed to avoid
having to allocate and stash a pidfs dentry. If it finds dentry in there
it will return it.

To not confuse path_from_stashed() pidfs_exit() must not replace a pidfs
dentry stashed in pid->stashed with the ERR_PTR(-ESRCH) sentinel as
path_from_stashed() could legitimately obtain another reference before
pidfs_exit() was able to call dput() to put the final pidfs dentry
reference. If it were to put the sentinel into pid->stashed it would
invalidate a struct pid even though a pidfd was just created for it.

So if a pidfs dentry is stashed in pid->stashed pidfs_exit() must leave
clearing out pid->stashed to dentry->d_prune::pidfs_dentry_prune().
Concurrent calls to path_from_stashed() will see a dead dentry in there
and will be forced into the slowpath.

Inversely, path_from_stashed() must take care to not try and take a
reference on the ERR_PTR(-ESRCH) sentinel. So stashed_dentry_get() must
be prepared to see a ERR_PTR(-ESRCH) sentinel in pid->stashed.

Note that it doesn't matter whether the path_from_stashed() fast path
sees NULL, a dead dentry, or the ERR_PTR(-ESRCH) sentinel in
pid->stashed. Any of those forces path_from_stashed() into the slowpath
at which point pid->wait_pidfd.lock must be acquired serializing against
pidfs_exit() and pidfs_dentry_prune().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      pidfs: keep pidfs dentry stashed once created
      pidfs: remove pidfs_pid_valid()

 fs/internal.h |   2 +
 fs/libfs.c    |  22 ++++++--
 fs/pidfs.c    | 169 ++++++++++++++++++++++++++++++++++++----------------------
 3 files changed, 124 insertions(+), 69 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250613-work-pidfs-269232caa91f


