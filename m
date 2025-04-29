Return-Path: <linux-fsdevel+bounces-47651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA9FAA3D58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 01:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A043AC768
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 23:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50F4276A63;
	Tue, 29 Apr 2025 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3b3i3sv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC23276A55;
	Tue, 29 Apr 2025 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970659; cv=none; b=Vo0k0rbazfYBx2eRTF/gvT2C5ay/Vd9r898VrXSKONANiaORe8rzFznylutFxcSo6qBG6zHlCzwY2nXp29wWN04d0wj9peF2qM7YHPZ4NFTTTaz7bxPIB1l+wSR/dzbo0sL8KpLL6Mq4GgPGO7Xo/DKpBAVJZCbOJGfwp1h+aDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970659; c=relaxed/simple;
	bh=pxXGYPAGiFocKGjyjMbcgXTk8gyp2xoyrCkB8vpczIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQNMEGZMbb1+oQwFozC56+SxhvNrZVdzApk8yi12X8XNVQd9TH7Q/Z5MG91udeaaV3ldrxG7fNn3q5sMsH/u23LY50SWsy41L8rZzMuEktlJPW5172bZuxbKfKtj881s+rUor32q7Hbl4D3SKShk5FMcrHNC5OOgXcvmxTiJCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3b3i3sv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A60BC4CEE3;
	Tue, 29 Apr 2025 23:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970658;
	bh=pxXGYPAGiFocKGjyjMbcgXTk8gyp2xoyrCkB8vpczIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3b3i3svlY1rSlKI/AUrei6keRzgsTeBZIbWVLO1fR2xkb2Rl7ltKp23EFhOOLe5H
	 du+UgilgZZUYITeuqqYQ3uM1zn5Cb3qQhglMpXtysKF7k3lNMZZuFb6689eq4yMT+8
	 NKxIl9znbYwdRq4wAbmOWLlQZExQEt7x/vDHeVWNkpxB+okSCwJdALMOUeiSnlvxPE
	 nGSIAwfG8q1b3aGA+IpKwnFCQamFRye9n0KruXadelDqsXtER62PB53rx7xLa5U/XG
	 MyhfmufwtgsG4l9bEqo/RnXDL+t1y7qLDVAH64MXHpqkBCoCRtXZrUk4dywqvhoIXs
	 6Dgji7JTo1LNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jan Kara <jack@suse.cz>,
	kdevops@lists.linux.dev,
	Luis Chamberlain <mcgrof@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	akpm@linux-foundation.org,
	josef@toxicpanda.com,
	mhocko@suse.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 27/39] fs/buffer: introduce sleeping flavors for pagecache lookups
Date: Tue, 29 Apr 2025 19:49:54 -0400
Message-Id: <20250429235006.536648-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Davidlohr Bueso <dave@stgolabs.net>

[ Upstream commit 2814a7d3d2ff5d2cdd22936f641f758fdb971fa0 ]

Add __find_get_block_nonatomic() and sb_find_get_block_nonatomic()
calls for which users will be converted where safe. These versions
will take the folio lock instead of the mapping's private_lock.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://kdevops.org/ext4/v6.15-rc2.html # [0]
Link: https://lore.kernel.org/all/aAAEvcrmREWa1SKF@bombadil.infradead.org/ # [1]
Link: https://lore.kernel.org/20250418015921.132400-3-dave@stgolabs.net
Tested-by: kdevops@lists.linux.dev
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/buffer.c                 | 9 +++++++++
 include/linux/buffer_head.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index a03c245022dcf..7981097c846d4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1414,6 +1414,15 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
 }
 EXPORT_SYMBOL(__find_get_block);
 
+/* same as __find_get_block() but allows sleeping contexts */
+struct buffer_head *
+__find_get_block_nonatomic(struct block_device *bdev, sector_t block,
+			   unsigned size)
+{
+	return find_get_block_common(bdev, block, size, false);
+}
+EXPORT_SYMBOL(__find_get_block_nonatomic);
+
 /**
  * bdev_getblk - Get a buffer_head in a block device's buffer cache.
  * @bdev: The block device.
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 932139c5d46f5..ffcd76d977703 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -223,6 +223,8 @@ void __wait_on_buffer(struct buffer_head *);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
 			unsigned size);
+struct buffer_head *__find_get_block_nonatomic(struct block_device *bdev,
+			sector_t block, unsigned size);
 struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
 		unsigned size, gfp_t gfp);
 void __brelse(struct buffer_head *);
@@ -398,6 +400,12 @@ sb_find_get_block(struct super_block *sb, sector_t block)
 	return __find_get_block(sb->s_bdev, block, sb->s_blocksize);
 }
 
+static inline struct buffer_head *
+sb_find_get_block_nonatomic(struct super_block *sb, sector_t block)
+{
+	return __find_get_block_nonatomic(sb->s_bdev, block, sb->s_blocksize);
+}
+
 static inline void
 map_bh(struct buffer_head *bh, struct super_block *sb, sector_t block)
 {
-- 
2.39.5


