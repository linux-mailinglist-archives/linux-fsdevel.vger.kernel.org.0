Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A542E7968
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Dec 2020 14:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgL3NI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Dec 2020 08:08:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgL3NFN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Dec 2020 08:05:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44F382251F;
        Wed, 30 Dec 2020 13:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609333456;
        bh=zalySSx7DbzBGWtwr3ORW40jKfdlWX2z7z2fB+j1pO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GpN84h2fjyO2E6dKjx81yD6ogBm0s5L3nt2xfoLfKAd/Xx5wRUy2PWv4LprUcakHR
         RkMFdgwS+kwlaILF6EXZPqIc6Hf0mit1rEqYQ0pMQXdBfgJBr/z2pkcMPYOJaHC5fs
         evobuHq5sWYwvXpI3R0e35C+u42lNRkRZPaEmNx7DkXfe/VapZEPHnfEEHoWdDbV83
         nmtQAAH0Gnvi2qWd3jSsCL1YvS15HOhKa7KP5aJqd1Utwsl2+w0RScV8IP6iQnGFkE
         ApCTXrYGJ+ncUESBcLWzcnUpx0LBoqGB2mtowSREPydPUerildl9OHJjkUXjfkYcut
         +tqmofyoknL3A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 13/17] fs/namespace.c: WARN if mnt_count has become negative
Date:   Wed, 30 Dec 2020 08:03:53 -0500
Message-Id: <20201230130357.3637261-13-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201230130357.3637261-1-sashal@kernel.org>
References: <20201230130357.3637261-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit edf7ddbf1c5eb98b720b063b73e20e8a4a1ce673 ]

Missing calls to mntget() (or equivalently, too many calls to mntput())
are hard to detect because mntput() delays freeing mounts using
task_work_add(), then again using call_rcu().  As a result, mnt_count
can often be decremented to -1 without getting a KASAN use-after-free
report.  Such cases are still bugs though, and they point to real
use-after-frees being possible.

For an example of this, see the bug fixed by commit 1b0b9cc8d379
("vfs: fsmount: add missing mntget()"), discussed at
https://lkml.kernel.org/linux-fsdevel/20190605135401.GB30925@xxxxxxxxxxxxxxxxxxxxxxxxx/T/#u.
This bug *should* have been trivial to find.  But actually, it wasn't
found until syzkaller happened to use fchdir() to manipulate the
reference count just right for the bug to be noticeable.

Address this by making mntput_no_expire() issue a WARN if mnt_count has
become negative.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 9 ++++++---
 fs/pnode.h     | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2adfe7b166a3e..76ea92994d26d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -156,10 +156,10 @@ static inline void mnt_add_count(struct mount *mnt, int n)
 /*
  * vfsmount lock must be held for write
  */
-unsigned int mnt_get_count(struct mount *mnt)
+int mnt_get_count(struct mount *mnt)
 {
 #ifdef CONFIG_SMP
-	unsigned int count = 0;
+	int count = 0;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
@@ -1123,6 +1123,7 @@ static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
 static void mntput_no_expire(struct mount *mnt)
 {
 	LIST_HEAD(list);
+	int count;
 
 	rcu_read_lock();
 	if (likely(READ_ONCE(mnt->mnt_ns))) {
@@ -1146,7 +1147,9 @@ static void mntput_no_expire(struct mount *mnt)
 	 */
 	smp_mb();
 	mnt_add_count(mnt, -1);
-	if (mnt_get_count(mnt)) {
+	count = mnt_get_count(mnt);
+	if (count != 0) {
+		WARN_ON(count < 0);
 		rcu_read_unlock();
 		unlock_mount_hash();
 		return;
diff --git a/fs/pnode.h b/fs/pnode.h
index 49a058c73e4c7..26f74e092bd98 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -44,7 +44,7 @@ int propagate_mount_busy(struct mount *, int);
 void propagate_mount_unlock(struct mount *);
 void mnt_release_group_id(struct mount *);
 int get_dominating_id(struct mount *mnt, const struct path *root);
-unsigned int mnt_get_count(struct mount *mnt);
+int mnt_get_count(struct mount *mnt);
 void mnt_set_mountpoint(struct mount *, struct mountpoint *,
 			struct mount *);
 void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp,
-- 
2.27.0

