Return-Path: <linux-fsdevel+bounces-45256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2F1A7552E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 09:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9375D3B031C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 08:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134E91ACEAC;
	Sat, 29 Mar 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBT70bfy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71053149C55;
	Sat, 29 Mar 2025 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743237807; cv=none; b=e3Znn8quLNVhFdBIS6RYxvvJ9Uo0pzOcM9WqKaSIGkNH/ol4bw1fKo+MvZjPn/CVtqYHXhci5EfzBlEHJOxydu5O6Rbh8kZtgEfwBzmBjnyb8en3MjFVT7f3RBEe8LN0TxB/sDRb9/VBwO2L38wqEXb8YZMEHKZi5VQ23rT1Qy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743237807; c=relaxed/simple;
	bh=tXNgHPkpI1RYcg6+uolFMirXAFbH/6dKuJTHpZX5Tj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQLo6XaE5egBR2EOyPLdLKwzz2sWBsPM4uB7nJX+xHfVs3JdrEsQ3H5oFCaCZFLH+Su7jvfc38KdYD41cgDihdifl+6akFEAAER3GLPhcohII8dhlXLi2TVniywYZ2k33YVSLEmZ2yUobfhqNJpAL5ShbhTACxiwltL5mhrmBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBT70bfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9356EC4CEED;
	Sat, 29 Mar 2025 08:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743237806;
	bh=tXNgHPkpI1RYcg6+uolFMirXAFbH/6dKuJTHpZX5Tj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBT70bfyPaaA0fuSCeSOA7l5/riBIMNs4F3cyy+D3/IWg6BtYO3lilkhAwH2p5wZa
	 nDMKmhJkQqPH0ietrsR3Oam8WMRBKqq3itOyM1ommWHmQUh0XjWiIWSNfk7LEO5t58
	 cAdrdEa/hxe0M2FZB87Hs3ZxfDdBLahRH6bzYhvhtKKyiuNRMBdptq/fzvXgNxilZD
	 r7V9Qj0lPCPPPu13kBYmhz4b9qgkLdYHvVX2xfG4MJNCZ/9MQMVzcKJOayJeD2mOQL
	 n4sp8wYhvXhz+WhkmyAvrHsaZT4vWZ7jdMNdBwQIroXNlLX99SsUqUDy4r3fej9RMV
	 m0M7h0M40Qo2w==
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
Subject: [PATCH v2 1/6] super: remove pointless s_root checks
Date: Sat, 29 Mar 2025 09:42:14 +0100
Message-ID: <20250329-work-freeze-v2-1-a47af37ecc3d@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=brauner@kernel.org; h=from:subject:message-id; bh=tXNgHPkpI1RYcg6+uolFMirXAFbH/6dKuJTHpZX5Tj8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/31Sx6WxNfWNwUarTyhT9TJEezutRx3zrFtr943t+Q OftMqfrHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpsGNkeLKWM/bK78kd6fcC qg9//CS+xeZ1jgzH/kCn597v5gQs/s/wv9BW67jh8klZoY+jCidPX3f2sF1W/ncu92MuFgYJMhl RDAA=
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


