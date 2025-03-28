Return-Path: <linux-fsdevel+bounces-45224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6CEA74E61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 17:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED2C1895872
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD411DDC07;
	Fri, 28 Mar 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyhuXGf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C551DD0E7;
	Fri, 28 Mar 2025 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178579; cv=none; b=iL/I6M/lthvJryKc9ZNpSUv2FKwqHUCKmRhAf6DRvC/H9UCJ8obbB+syVkPAijWOtyjHlKxebrP5BfVRdWLI0NrkRTAAmQ+AWku/jbXYsMbUWDQmIPfJuWevzXRVtm1z0iPMymzX2srvdtMV/GyvyylTecn7vbabw8QT4Kb3LNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178579; c=relaxed/simple;
	bh=tXNgHPkpI1RYcg6+uolFMirXAFbH/6dKuJTHpZX5Tj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5P4NIeb9YbL9Qi/GCN7Mb9vxfSQoTynPHuCS8j0Dj6vH8HbaPO8pxIcnmYBV1BkJ5fGrk2U7jPzBNfWbqdNPeJm3SHlYKrUKYm/ufeCg3/WlVyHo9C7tLJMtaC77FScWX8EI1qvUMJdJT0Fk0xH2OvyvGDtOaSKk2DNDh+CJGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyhuXGf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE676C4CEE5;
	Fri, 28 Mar 2025 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743178578;
	bh=tXNgHPkpI1RYcg6+uolFMirXAFbH/6dKuJTHpZX5Tj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EyhuXGf281TnYATQKatubpErzYkG1h+BNwDsUshE4fPss+QazVEBqi2jufIopsnwj
	 ZcstGZ20IjlCt0ski02ckI3ZnkYTvE+NBhNTF73N6wimaU3fHUIZkmMRKvhOm8VKJL
	 PapxbW+5scJo5si76/dM5PSJg8ZceQfVJJ7LdzmyPL7G/UW0SRWX+TZsja3PigKbrm
	 Eg/mAJUhAHeKwYvtScxCGed3GJJGJC9eyj71h63c1nSBKROZFYIpvGL/9TYsE2jT/0
	 vSlpOKQlZsycslyhn2pYZirTHp7+GgDsmgXf7i39BE/ZC6OA9A2cB+ZvLBjr9jOIrc
	 gBlPHHT7bOS7g==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH 1/6] super: remove pointless s_root checks
Date: Fri, 28 Mar 2025 17:15:53 +0100
Message-ID: <20250328-work-freeze-v1-1-a2c3a6b0e7a6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
References: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=brauner@kernel.org; h=from:subject:message-id; bh=tXNgHPkpI1RYcg6+uolFMirXAFbH/6dKuJTHpZX5Tj8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/O+1od56r/YvzzdI/Ep2qs91n3hEM0jgc9Oi+wCnT1 bN81yfndpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEcj3DL+bH72Y/nPdru6jP 8S7JGc91xFX9Kjstj9Tejitd7WSoU87wV4bL/YLBiecHHiR+5pjEX744mnXyRI9Thcfv9VVPZ2h 6zQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The locking guarantees that the superblock is alive and sb->s_root is
still set. Remove the pointless check.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 97a17f9d9023..dc14f4bf73a6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -930,8 +930,7 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 
 		locked = super_lock_shared(sb);
 		if (locked) {
-			if (sb->s_root)
-				f(sb, arg);
+			f(sb, arg);
 			super_unlock_shared(sb);
 		}
 
@@ -967,11 +966,8 @@ void iterate_supers_type(struct file_system_type *type,
 		spin_unlock(&sb_lock);
 
 		locked = super_lock_shared(sb);
-		if (locked) {
-			if (sb->s_root)
-				f(sb, arg);
-			super_unlock_shared(sb);
-		}
+		if (locked)
+			f(sb, arg);
 
 		spin_lock(&sb_lock);
 		if (p)
@@ -991,18 +987,15 @@ struct super_block *user_get_super(dev_t dev, bool excl)
 
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
-		if (sb->s_dev ==  dev) {
+		if (sb->s_dev == dev) {
 			bool locked;
 
 			sb->s_count++;
 			spin_unlock(&sb_lock);
 			/* still alive? */
 			locked = super_lock(sb, excl);
-			if (locked) {
-				if (sb->s_root)
-					return sb;
-				super_unlock(sb, excl);
-			}
+			if (locked)
+				return sb; /* caller will drop */
 			/* nope, got unmounted */
 			spin_lock(&sb_lock);
 			__put_super(sb);

-- 
2.47.2


