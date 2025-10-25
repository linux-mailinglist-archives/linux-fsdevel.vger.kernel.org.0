Return-Path: <linux-fsdevel+bounces-65631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9333BC09C53
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 18:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4F9424715
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299083126B2;
	Sat, 25 Oct 2025 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Erabh20A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D230C609;
	Sat, 25 Oct 2025 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409737; cv=none; b=JA5rFwi8776Z43DMUf0Sj4cSiKULnFoOZFaq9+ce3MOA/0PiKERUj+DJiMhn1Wx8T6jmvuOZ3vWnZNNLMcHaUqYGbQnoGxCrpfhWXCzA3c8B/77AODvEWA59GFOd2Wga9srHAc1UGAjiqws5U0GzS2WUBcZhjyWc8DUNuZRu9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409737; c=relaxed/simple;
	bh=NBzBBqfdDX3ER7q56c+eTh28BN4lKPjJ15k8LfFyso8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0YrXUvVSqMPyp8jag5dUJ2mErKYljf9i+i2nC6QVRzyGxV9uaaTd3A/YmjbZL+GJSekDNv3S5Z2Hdf3Z5RnYaZUx5jgEQjzQFZ9c/UYMeOzB77M3xurbAPEIHf9AOCAalnWJqY+FC9dgcgQjd5XdZ6XS0porGXpboOAXIW0wgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Erabh20A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613FFC4CEFB;
	Sat, 25 Oct 2025 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409737;
	bh=NBzBBqfdDX3ER7q56c+eTh28BN4lKPjJ15k8LfFyso8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Erabh20AyiTZfse63dZH3/58b6Fcow3KU2QleCF5REb6+qoR1fFl7+VAO1k4hLB85
	 hjYjt21oF8Qsg9g9H6LI9kd5kfiAnhJRZF2XopUYv7ZxGUtXGCtYkuZngvg4qlf0vl
	 IfP23/HVz1ZdYzvYAovxCNP6PpaHOk9uJ5YL/4C78vIad2FykA0POjRnCPYE5v79rT
	 9wBjv8pIwBDnEejEr2Y9ezXKZ0pgqOfWQvBubc7IjW+Txky56MRX1Cxhm9lFiSJWQe
	 bhePpepM/1qAWeh81N+6htyVdkcUg970Lk9q9+yyOxzX7MTo1btsmkOPK6cb+tkG1m
	 d9G30zOUOypHA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] move_mount(2): take sanity checks in 'beneath' case into do_lock_mount()
Date: Sat, 25 Oct 2025 12:01:14 -0400
Message-ID: <20251025160905.3857885-443-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit d29da1a8f119130e6fc7d5d71029d402dabe2cb0 ]

We want to mount beneath the given location.  For that operation to
make sense, location must be the root of some mount that has something
under it.  Currently we let it proceed if those requirements are not met,
with rather meaningless results, and have that bogosity caught further
down the road; let's fail early instead - do_lock_mount() doesn't make
sense unless those conditions hold, and checking them there makes
things simpler.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What it fixes
  - Prevents nonsensical MOVE_MOUNT_BENEATH operations from proceeding
    when the destination is not a mount root or when the topmost mount
    has no parent (i.e., namespace root). Previously this could “proceed
    with meaningless results” and fail later; now it fails early with
    -EINVAL as intended.

- Key changes
  - Early validation in do_lock_mount():
    - Adds `if (unlikely(beneath) && !path_mounted(path)) return
      -EINVAL;` so non-mount-root targets are rejected immediately
      (fs/namespace.c:do_lock_mount()).
    - Adds a parent check under `mount_lock` in the ‘beneath’ path: `if
      (unlikely(!mnt_has_parent(m))) { ... return -EINVAL; }` to reject
      attempts beneath a namespace root before proceeding
      (fs/namespace.c:do_lock_mount()).
  - De-duplication: Removes the equivalent checks from
    can_move_mount_beneath(), centralizing them where the mountpoint and
    parent are actually determined
    (fs/namespace.c:can_move_mount_beneath()).

- Context in current tree
  - The tree already performs an early `beneath && !path_mounted(path)`
    rejection in do_lock_mount (see `fs/namespace.c:2732`), so
    moving/keeping this check in do_lock_mount is aligned with the
    patch’s intent.
  - The explicit `mnt_has_parent()` guard is not currently enforced at
    lock acquisition time in do_lock_mount; adding it there (while
    holding `mount_lock`) closes a race and ensures the operation only
    proceeds when a real parent exists.
  - can_move_mount_beneath in this tree already focuses on
    propagation/relationship checks and does not contain those
    path/parent assertions (see around `fs/namespace.c:3417`), so
    consolidating sanity checks into do_lock_mount is consistent and low
    risk.

- Why it’s a good stable candidate
  - Bug fix: Enforces semantic preconditions for MOVE_MOUNT_BENEATH,
    avoiding misleading or late failures.
  - Small and contained: Changes are limited to fs/namespace.c, mostly
    simple condition checks and code movement.
  - No feature or architectural change: Just earlier, clearer
    validation; the end result remains a failure for invalid usage.
  - Concurrency-safe: Parent check is done while holding `mount_lock`,
    reducing race windows between `mount_lock` and `namespace_sem`.

- Regression risk
  - Low. Users attempting invalid MOVE_MOUNT_BENEATH operations will now
    get -EINVAL earlier rather than later. Valid usages are unaffected.

 fs/namespace.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c8c2376bb2424..fa7c034ac4a69 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2785,12 +2785,19 @@ static int do_lock_mount(struct path *path, struct pinned_mountpoint *pinned, bo
 	struct path under = {};
 	int err = -ENOENT;
 
+	if (unlikely(beneath) && !path_mounted(path))
+		return -EINVAL;
+
 	for (;;) {
 		struct mount *m = real_mount(mnt);
 
 		if (beneath) {
 			path_put(&under);
 			read_seqlock_excl(&mount_lock);
+			if (unlikely(!mnt_has_parent(m))) {
+				read_sequnlock_excl(&mount_lock);
+				return -EINVAL;
+			}
 			under.mnt = mntget(&m->mnt_parent->mnt);
 			under.dentry = dget(m->mnt_mountpoint);
 			read_sequnlock_excl(&mount_lock);
@@ -3462,8 +3469,6 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
  * @to:   mount under which to mount
  * @mp:   mountpoint of @to
  *
- * - Make sure that @to->dentry is actually the root of a mount under
- *   which we can mount another mount.
  * - Make sure that nothing can be mounted beneath the caller's current
  *   root or the rootfs of the namespace.
  * - Make sure that the caller can unmount the topmost mount ensuring
@@ -3485,12 +3490,6 @@ static int can_move_mount_beneath(const struct path *from,
 		     *mnt_to = real_mount(to->mnt),
 		     *parent_mnt_to = mnt_to->mnt_parent;
 
-	if (!mnt_has_parent(mnt_to))
-		return -EINVAL;
-
-	if (!path_mounted(to))
-		return -EINVAL;
-
 	if (IS_MNT_LOCKED(mnt_to))
 		return -EINVAL;
 
-- 
2.51.0


