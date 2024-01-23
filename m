Return-Path: <linux-fsdevel+bounces-8567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1738883901B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1CA29394D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0BA5FF1A;
	Tue, 23 Jan 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U28o1Ggn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D35F843;
	Tue, 23 Jan 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016472; cv=none; b=G8ZFCFDX8sKrwvgDma3uuLBpK4s5wCUufdpn8lP7c+XekaMiGUOUiUBOSZi9gYLo3o9LPzE0K3phN/cYz3qcJdJW9Gs5lhOI+04dJyfbb4OIhhuN20C0IJSiHlG6KZOt4TXWQxPQPVvOdUxEBJODJJF15vDOYFu53cIWFZcDAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016472; c=relaxed/simple;
	bh=i6aO18RTWhUJCanwYwwb+SifDuAtGqkymO2qMUZLcDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XyEjEhE50AYf4S69nHDsvFJSxzG+PwoCIsX2luveq1lPi1jxSaadDr8mkzMDkt4OBQ5knge+C9xQyp1YdvrRw/8QzPkBFjJcdcHwluBeVIEjXvfAYKxFduMtUaNrvtzFyqzWBSKEFtD9i8CTjIAdjjHCBojHBMsEESqh21xLsE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U28o1Ggn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4630AC43394;
	Tue, 23 Jan 2024 13:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016472;
	bh=i6aO18RTWhUJCanwYwwb+SifDuAtGqkymO2qMUZLcDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U28o1Ggnz9fa/LNq/Fp+WIVHJhPWdecxtQrJeZyDT11JrNLQpeDHPuEOGMxWg/Ooj
	 ztzZhJ8SqxWsXWl5DwrlAj8NheV1xcnHy6N9XpjljLBLLGyX/zXgrVGtiHrek8yUZd
	 bfK+/msQ+SyJeykMST4aLydmig4A3LZovf9lm/8+TbZFI+8Vo/dxchPoMclRe2GW1N
	 eh91cQqlw/hcl1gTI1YmW/WLuWlR6LgUDLcC9A0KlP0k9hVsFXJc0GWk3Jlc/STXDE
	 znGDx7xBM4+ijK6p60vYhrRJ+IcuHnzz75C1sfyqBD0+YiyoKDbaMjSPaZscPtD68L
	 HFGiEq2ZEoSMg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:39 +0100
Subject: [PATCH v2 22/34] f2fs: port block device access to files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-22-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983; i=brauner@kernel.org;
 h=from:subject:message-id; bh=i6aO18RTWhUJCanwYwwb+SifDuAtGqkymO2qMUZLcDY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37fgxkk7Z2U9do6rudd2cu77ksueYnO9YY+04bWZr
 l9jVk6X7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIZStGhlmcO9+xTLpu6dzT
 ICnCrbyLe82cp0eZ9c60abM9/jKx3ZeRYcZs67fPu08vbmrOW5f7a720bIDTk4zDUoKTbx2NvrI
 wnRUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/f2fs/f2fs.h  |  2 +-
 fs/f2fs/super.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 65294e3b0bef..6fc172c99915 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1239,7 +1239,7 @@ struct f2fs_bio_info {
 #define FDEV(i)				(sbi->devs[i])
 #define RDEV(i)				(raw_super->devs[i])
 struct f2fs_dev_info {
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	struct block_device *bdev;
 	char path[MAX_PATH_LEN];
 	unsigned int total_segments;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ea94c148fee5..557ea5c6c926 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1605,7 +1605,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
 		if (i > 0)
-			bdev_release(FDEV(i).bdev_handle);
+			fput(FDEV(i).bdev_file);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
 #endif
@@ -4247,7 +4247,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < max_devices; i++) {
 		if (i == 0)
-			FDEV(0).bdev_handle = sb_bdev_handle(sbi->sb);
+			FDEV(0).bdev_file = sbi->sb->s_bdev_file;
 		else if (!RDEV(i).path[0])
 			break;
 
@@ -4267,14 +4267,14 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 				FDEV(i).end_blk = FDEV(i).start_blk +
 					(FDEV(i).total_segments <<
 					sbi->log_blocks_per_seg) - 1;
-				FDEV(i).bdev_handle = bdev_open_by_path(
+				FDEV(i).bdev_file = bdev_file_open_by_path(
 					FDEV(i).path, mode, sbi->sb, NULL);
 			}
 		}
-		if (IS_ERR(FDEV(i).bdev_handle))
-			return PTR_ERR(FDEV(i).bdev_handle);
+		if (IS_ERR(FDEV(i).bdev_file))
+			return PTR_ERR(FDEV(i).bdev_file);
 
-		FDEV(i).bdev = FDEV(i).bdev_handle->bdev;
+		FDEV(i).bdev = file_bdev(FDEV(i).bdev_file);
 		/* to release errored devices */
 		sbi->s_ndevs = i + 1;
 

-- 
2.43.0


