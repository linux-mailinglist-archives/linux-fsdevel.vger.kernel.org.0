Return-Path: <linux-fsdevel+bounces-45343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC435A7663A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343EB3AAFE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587FE202C3B;
	Mon, 31 Mar 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la0zqWTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDAD1E7660;
	Mon, 31 Mar 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743424952; cv=none; b=qXkqpvUJYAgun8M/ZAVGL8qLmomU189mKaOSlJ4zEfN8NhT36Slnfi5M9yM9m73IczzS3AO5sUfbx6bYD4xzuDhU8kDCPFXRZohCxk5861bikGmxDIAiGUpFTFAU/1IWwtD5q3TNqvFasMgo697WqADUWxJjzWoHgeyIjEqJz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743424952; c=relaxed/simple;
	bh=G1tW6bBjlEEZxTPn/NqO/ELwRn80Wgaw87UEotcwe4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toBw+SR8CSUIE9tPMaST1U+oqM10MEuMDx9Ipm3iMz63/lzHNwMU1WQODMv5kWqSyjy+9BxW9Rlvs4mHEOXQXJQMGdM8bIcp+HyCpP67Gr8tCb7fTSCeJtKR31dEkg5TD8ub6sYg3jmkT40l6sToyhZSgFqq+i5r8oDkJV7yMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la0zqWTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684BEC4CEF0;
	Mon, 31 Mar 2025 12:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743424952;
	bh=G1tW6bBjlEEZxTPn/NqO/ELwRn80Wgaw87UEotcwe4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=la0zqWTmWSoOcQVSR9jhViafleqGP00pfI9A6FO/BrqYWV/K3cjV2fnebaB3TQxxh
	 ReBulTHeZmXSjnDU1kSHLOB54Ix0hAsZfqK9lX6wy3Wce2GaWo2XkrCTiTX7SDiVk+
	 MxY2ZVHPFXCI0ssUEaipOPcn5Xwf1TRsaLDDks2MbCQ2PEkBQ1pSDS9vokbK/E5GO7
	 gNl7S/MkajrNiTpwHw5lCrjzf00qitdhUuBwb2BLRq0nqxaiBM7xCFXLGbvVlzblB7
	 ymRJ8xk/XOmrrd+Esxw4NqfVThlSTBfM55OdqtGwAFqb/SFtkYstqWBGPIeB5O7ifl
	 F597/RBqph/5Q==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-efi@vger.kernel.org,
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
Subject: [PATCH 1/2] libfs: export find_next_child()
Date: Mon, 31 Mar 2025 14:42:11 +0200
Message-ID: <20250331-work-freeze-v1-1-6dfbe8253b9f@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; i=brauner@kernel.org; h=from:subject:message-id; bh=G1tW6bBjlEEZxTPn/NqO/ELwRn80Wgaw87UEotcwe4o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/6l1a8eaZdoXKb/3PNRLn/3zUbAo0l/thGj/nlMqX+ T+tEk+u7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIkjHDb9Zn85Qcg2dnMJx9 uMGkOfJt0DeBViaHOpbgJfk+rUtTLzAyvHpzqPVhUtyyyT9yXk9PefTxaYOCXubzr98tZ1grnZ9 9kh8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Export find_next_child() so it can be used by efivarfs.
Keep it internal for now. There's no reason to advertise this
kernel-wide.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/internal.h | 1 +
 fs/libfs.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/internal.h b/fs/internal.h
index b9b3e29a73fd..b9949707a152 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -343,3 +343,4 @@ static inline bool path_mounted(const struct path *path)
 void file_f_owner_release(struct file *file);
 bool file_seek_cur_needs_f_lock(struct file *file);
 int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, bool uid_map);
+struct dentry *find_next_child(struct dentry *parent, struct dentry *prev);
diff --git a/fs/libfs.c b/fs/libfs.c
index 6393d7c49ee6..f2ef377d2665 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -583,7 +583,7 @@ const struct file_operations simple_offset_dir_operations = {
 	.fsync		= noop_fsync,
 };
 
-static struct dentry *find_next_child(struct dentry *parent, struct dentry *prev)
+struct dentry *find_next_child(struct dentry *parent, struct dentry *prev)
 {
 	struct dentry *child = NULL, *d;
 
@@ -603,6 +603,7 @@ static struct dentry *find_next_child(struct dentry *parent, struct dentry *prev
 	dput(prev);
 	return child;
 }
+EXPORT_SYMBOL(find_next_child);
 
 void simple_recursive_removal(struct dentry *dentry,
                               void (*callback)(struct dentry *))

-- 
2.47.2


