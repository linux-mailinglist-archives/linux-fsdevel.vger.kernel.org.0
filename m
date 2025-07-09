Return-Path: <linux-fsdevel+bounces-54383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9835AFF0A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 20:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D084A4A22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 18:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470BB23B633;
	Wed,  9 Jul 2025 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTck55RE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95223226CFE;
	Wed,  9 Jul 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084644; cv=none; b=S0v4ByF4v/u+IJQn0Im6cYCy/jB/+Xoxnp2PD91tSU+kEBr3F5ZitYVywbmvz9VlaVr7lIdARYmB9c/LzB+fOF4mIPunecAj60yI/ZoCRM1T+bGyPjeEExkNoDI8kJfEQ0iS5lD2c4Ac3yNWiWFIzXILI4vhabu6/1BiRxnp9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084644; c=relaxed/simple;
	bh=2FAxfnnf/wH32Rop4mxpdmZJ/DQjfkmofTwLRxQw7MA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hthh10H/L9xzzU8ZQFN3KyMVUPaSIDlmfS+FkcJQmlcJlHM6DTMnljqLP3+GhJ0DiuGBiPLT0fBqdyVRt+MbT3tDbnurumWYjo3H+uTMyW95+Qw/FqkQNHR4jSdt4E+HF/foYE8NVvSwo2Lv2ByaCLrcVculdCtFaPiS6oKSSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTck55RE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5648FC4CEEF;
	Wed,  9 Jul 2025 18:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084643;
	bh=2FAxfnnf/wH32Rop4mxpdmZJ/DQjfkmofTwLRxQw7MA=;
	h=From:To:Cc:Subject:Date:From;
	b=nTck55REhDJ7MwBOj2/mYSQZnQ1+9AgHPoEx5bHStwbGulYQdEV64dHc8ayCfEBdQ
	 fwHM5FlpCQCbtuWD6uFq3/kKUZ7AsV2lzQG73Va0jJ3qU+PxuzVG6inuEQkXNrbIv8
	 RRFGT+Fv3BEi55n90fGX6xYj3e2RS6F8cEdWU8qZXZJ7rcfo2QOI4AjSybeChTekpU
	 giUq5YNGL3rbDhOQolAYjORadiFOevAG4uvYPRaDD5YV6z/v26n+DsduSIJRIXEFvV
	 Kle2axFNzreaoI9nyA9WiFtBDhUvityJQ8Y8k/0EK9e41TCCuI8b6ZrA1F3mODsML9
	 HPq0bDX2MyVlA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Cc: ltp@lists.linux.it,
	dan.carpenter@linaro.org,
	benjamin.copeland@linaro.org,
	rbm@suse.com,
	Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()
Date: Wed,  9 Jul 2025 20:10:14 +0200
Message-Id: <20250709181030.236190-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Anders and Naresh found that the addition of the FS_IOC_GETLBMD_CAP
handling in the blockdev ioctl handler breaks all ioctls with
_IOC_NR==2, as the new command is not added to the switch but only
a few of the command bits are check.

Refine the check to also validate the direction/type/length bits,
but still allow all supported sizes for future extensions.

Move the new command to the end of the function to avoid slowing
down normal ioctl commands with the added branches.

Fixes: 9eb22f7fedfc ("fs: add ioctl to query metadata and protection info capabilities")
Link: https://lore.kernel.org/all/CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com/
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
It seems that we have a lot of drivers with the same bug, as the
large majority of all _IOC_NR() users in the kernel fail to also
check the other bits of the ioctl command code. There are currently
55 files referencing _IOC_NR, and they all need to be manually
checked for this problem.
---
 block/ioctl.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 9ad403733e19..5e5a422bd09f 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -567,9 +567,6 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 {
 	unsigned int max_sectors;
 
-	if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
-		return blk_get_meta_cap(bdev, cmd, argp);
-
 	switch (cmd) {
 	case BLKFLSBUF:
 		return blkdev_flushbuf(bdev, cmd, arg);
@@ -647,9 +644,16 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return blkdev_pr_preempt(bdev, mode, argp, true);
 	case IOC_PR_CLEAR:
 		return blkdev_pr_clear(bdev, mode, argp);
-	default:
-		return -ENOIOCTLCMD;
 	}
+
+	if (_IOC_DIR(cmd)  == _IOC_DIR(FS_IOC_GETLBMD_CAP) &&
+	    _IOC_TYPE(cmd) == _IOC_TYPE(FS_IOC_GETLBMD_CAP) &&
+	    _IOC_NR(cmd)   == _IOC_NR(FS_IOC_GETLBMD_CAP) &&
+	    _IOC_SIZE(cmd) >= LBMD_SIZE_VER0 &&
+	    _IOC_SIZE(cmd) <= _IOC_SIZE(FS_IOC_GETLBMD_CAP))
+		return blk_get_meta_cap(bdev, cmd, argp);
+
+	return -ENOIOCTLCMD;
 }
 
 /*
-- 
2.39.5


