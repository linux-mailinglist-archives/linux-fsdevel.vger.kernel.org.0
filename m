Return-Path: <linux-fsdevel+bounces-47652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C58AA3D5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 01:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03581B63CDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 23:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28076276A7E;
	Tue, 29 Apr 2025 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XljJ/yOK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE85276A6D;
	Tue, 29 Apr 2025 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970660; cv=none; b=sdFJfyezIAVeu91zgk2upMn58ByuXkxvSZw4qScOXpWo5t5unYeLAwL9PqaghvUhCk1NwuGCSq6kUFJ6j1R/Tzr8Dg9YxC/uXEcvwBxT4e1060hV3u8MH6NC+5LWqJe0Ka8Vg9jk6sZBFojYcGztKqNF2Vb435IF0rdPBgmbAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970660; c=relaxed/simple;
	bh=SQ7K3XBgemfN3MGF8QNgaaqu44GQqwIGTU2BN0A3ax8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fBFhrXE2vWlbyN2Gyu62QNTno9Mj1gjjlSMV82R24N+7NH8Dl+h6R51+5+h+Jbe3axcOOtkLzUeOZ2+fZ9TMuuES27DpJs+OeLg9rxO/WG6fCI0rfn1aKdN/BLYBGvws74v07gST7FShAjHGNNKRSBNlDIZ2a6B3or9/xDrCUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XljJ/yOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD1CC4CEEB;
	Tue, 29 Apr 2025 23:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970660;
	bh=SQ7K3XBgemfN3MGF8QNgaaqu44GQqwIGTU2BN0A3ax8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XljJ/yOKeDPBQRUGf4pi8Hghg/RuPyZHAaQF0KsbnP8HU6yd13b3QgAxqL2rpJqJB
	 lprGUaZpYK6KNfYbDfBRPBZFmURGgTMrmpLGvRcMJoyZLQisMaC7vRo0rhywoEmOHq
	 54cgXUN2eQZVEZRsucc2HbzbOZpl3rkXgpK2N4wVEFx7F7gARER6xPike2m2c8W50B
	 LWbtbSrOarKdqyIKIme/56chf61f/pwkrhoPyCJ0r/6DQZ7yg9IsG/OQRlOPoEWygJ
	 y+OdpU2LarYB/JJHDILLre1cUBESlAleH8LIWL6vIt+v5I0kQdm8Yy0TKsbri8mtqP
	 dmAyK4sDrDbqQ==
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 28/39] fs/buffer: use sleeping version of __find_get_block()
Date: Tue, 29 Apr 2025 19:49:55 -0400
Message-Id: <20250429235006.536648-28-sashal@kernel.org>
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

[ Upstream commit 5b67d43976828dea2394eae2556b369bb7a61f64 ]

Convert to the new nonatomic flavor to benefit from potential performance
benefits and adapt in the future vs migration such that semantics
are kept.

Convert write_boundary_block() which already takes the buffer
lock as well as bdev_getblk() depending on the respective gpf flags.
There are no changes in semantics.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://kdevops.org/ext4/v6.15-rc2.html # [0]
Link: https://lore.kernel.org/all/aAAEvcrmREWa1SKF@bombadil.infradead.org/ # [1]
Link: https://lore.kernel.org/20250418015921.132400-4-dave@stgolabs.net
Tested-by: kdevops@lists.linux.dev # [0] [1]
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/buffer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 7981097c846d4..2494fe3a5e69e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -658,7 +658,9 @@ EXPORT_SYMBOL(generic_buffers_fsync);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize)
 {
-	struct buffer_head *bh = __find_get_block(bdev, bblock + 1, blocksize);
+	struct buffer_head *bh;
+
+	bh = __find_get_block_nonatomic(bdev, bblock + 1, blocksize);
 	if (bh) {
 		if (buffer_dirty(bh))
 			write_dirty_buffer(bh, 0);
@@ -1440,7 +1442,12 @@ EXPORT_SYMBOL(__find_get_block_nonatomic);
 struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
 		unsigned size, gfp_t gfp)
 {
-	struct buffer_head *bh = __find_get_block(bdev, block, size);
+	struct buffer_head *bh;
+
+	if (gfpflags_allow_blocking(gfp))
+		bh = __find_get_block_nonatomic(bdev, block, size);
+	else
+		bh = __find_get_block(bdev, block, size);
 
 	might_alloc(gfp);
 	if (bh)
-- 
2.39.5


