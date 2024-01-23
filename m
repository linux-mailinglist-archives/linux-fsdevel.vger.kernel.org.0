Return-Path: <linux-fsdevel+bounces-8547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F2E838FEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279811C24154
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46345FEED;
	Tue, 23 Jan 2024 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU+G7pSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F265FEE0;
	Tue, 23 Jan 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016425; cv=none; b=MVZtGunXsBq6bc3TrjzCdIpFuw2RC68p6E+r44uEf+1W6KtezXOFVGD2N8+oi/9cRdaM9ZDDzQ3DdI639U7sGCCd7OoiXXNLlHuhKDtjnyvNzGbqirgh9A5T8IkmM15yQpdsOuc1tZDfQI2w1+AaaQZH2oT07qnY9tAnJTbaNVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016425; c=relaxed/simple;
	bh=gG4KE/5Hbc+96mcF4/aysdPW9xaaW31xwP+pzWHxaSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQi+ASrovrHQLljwZaqroslPs8WCJAiv2Ev/Xgssd7jTurTSfmRVjNTsRONUlvXrEJ7mFEODBkzVLG9iL8VSy/QFlzY/IrLmu/6+tCm9sAQby1OUoq0uVCcgBWdywiF8KJIZ2EtL48kST0fBOimyrblCXwz5r6Aas2sR003F0eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU+G7pSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBB1C433A6;
	Tue, 23 Jan 2024 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016424;
	bh=gG4KE/5Hbc+96mcF4/aysdPW9xaaW31xwP+pzWHxaSo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bU+G7pSfpVbxZ0lMMsN3BObHDaUxvz8dce/XocrEXpRiLQgFQ2Bha86aOw+04Qb7T
	 C5qbmVAG6aWzaeQfKhMS7Zmal8gquae0m4MpGvr5q08j0xA+aCXEhHPqiKCVGjhZqp
	 oLV9CzY7d5YMprH280WwgfCP9uFbI7OaIIQyYjHdy5AL71bdyb1se5xVPM1Aq6HNq0
	 MSwGrUJoTWS/zXNCr0eCf/GtAnhLLjaWozc62dQH7qZcmcqLV99ITAOtq0mf8NKjnU
	 60zQLpdqglBjmdE2/xiWUOgNapoz0+tog/aN93jaa4vQXJC6wXK3wduVAWoWo2ZsPS
	 KVSX88DBCmVcw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:19 +0100
Subject: [PATCH v2 02/34] block/ioctl: port blkdev_bszset() to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-2-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gG4KE/5Hbc+96mcF4/aysdPW9xaaW31xwP+pzWHxaSo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zfvwgyDRV15fHv4y8Wtm5f6r//xfqmmb+XxKokNR
 lqz4t1WdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE8g7DP6XlRnn5qp9U3WWa
 nXJbBJm+739dEL/6s49nREq4wi+9IIb/1YLsS+NuvGi3mGMpordN+mf0k8Vcx1a84Zn73K7G35C
 FCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/ioctl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 9c73a763ef88..5d0619e02e4c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -471,7 +471,7 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 		int __user *argp)
 {
 	int ret, n;
-	struct bdev_handle *handle;
+	struct file *file;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -483,12 +483,11 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 	if (mode & BLK_OPEN_EXCL)
 		return set_blocksize(bdev, n);
 
-	handle = bdev_open_by_dev(bdev->bd_dev, mode, &bdev, NULL);
-	if (IS_ERR(handle))
+	file = bdev_file_open_by_dev(bdev->bd_dev, mode, &bdev, NULL);
+	if (IS_ERR(file))
 		return -EBUSY;
 	ret = set_blocksize(bdev, n);
-	bdev_release(handle);
-
+	fput(file);
 	return ret;
 }
 

-- 
2.43.0


