Return-Path: <linux-fsdevel+bounces-56604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71D5B1964F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 23:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D2174753
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 21:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702A122AE5D;
	Sun,  3 Aug 2025 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYxFRGrN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EBB221FB6;
	Sun,  3 Aug 2025 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256172; cv=none; b=MqQdwRYZbfIdXhjqcKIcJN9E+Y4uIZFJg/p/f10jN+RWtYXG3FUjJdTazf56dnNh15VT+q9m0AHHbCx5FudoRF5JLFjvNJTduJOZpIVdqZzjidTi0BgfOfuJlMP+hH0m2pu2bausOYBHuuxKP/v/Yt+FKoFAtI21+5XeO3oHp9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256172; c=relaxed/simple;
	bh=FeQx/a8qB4EqgL1AWcOtbTg4+ZFIkB+rHKSP7FqZqlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lS6yNihnaS5Vh2VdX+VxfZeLpVoT1yJpYHcYpf2n6nTwicDk6SEE5pj10imKnwCPUMiMQjfIzeoRpbHmeiaIjc/eIrO31B7BdomXclR+OtAaJggZ9SNMSRujaTU6PEXqrgus+Z8YIEDFhs7D4Xw7NWMPJ7LE/P+pvhz+T7UJ4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYxFRGrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267F2C4CEEB;
	Sun,  3 Aug 2025 21:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256172;
	bh=FeQx/a8qB4EqgL1AWcOtbTg4+ZFIkB+rHKSP7FqZqlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYxFRGrNpnVf17t1QLTTmkxfjlacwRUZzmkBOM4ug7V1E44cfBvHUOofH/heO5Ne7
	 d2qgvxFvgV2qqFC1TNRjoXQNPxYZ5+Grvdltmh2x5IFec2HWOlFo1KDwSv/7/Cu2Cp
	 VxH1np6FPH0AFp2SGWytV7JxK1vaOfsSp3EuWo0FPf3DnEJWIJneuAGHnfd3gWSYtS
	 oKTYLMe2FvIk+n9jRqfHvNWKTrgsR6ZbBte4R6OHkj8Rc7bYjbl+vAeYYilPJ+HqCc
	 nqmbUawBh6BoHthqzAPHNK5DCXEReU2bjk+Q4WOuzndaEGSWAZw1Y3A/Wm+c/cdvo4
	 uB3MXlEPgPjVQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+1107451c16b9eb9d29e6@syzkaller.appspotmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 04/11] hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()
Date: Sun,  3 Aug 2025 17:22:34 -0400
Message-Id: <20250803212242.3549318-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212242.3549318-1-sashal@kernel.org>
References: <20250803212242.3549318-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.240
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit c7c6363ca186747ebc2df10c8a1a51e66e0e32d9 ]

When the volume header contains erroneous values that do not reflect
the actual state of the filesystem, hfsplus_fill_super() assumes that
the attributes file is not yet created, which later results in hitting
BUG_ON() when hfsplus_create_attributes_file() is called. Replace this
BUG_ON() with -EIO error with a message to suggest running fsck tool.

Reported-by: syzbot <syzbot+1107451c16b9eb9d29e6@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/7b587d24-c8a1-4413-9b9a-00a33fbd849f@I-love.SAKURA.ne.jp
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a Critical Bug**: The commit replaces a `BUG_ON()` that could
   crash the entire system with proper error handling. The original code
   at line 175 had `BUG_ON(i_size_read(attr_file) != 0);` which would
   trigger a kernel panic when the HFS+ filesystem metadata is corrupted
   or inconsistent.

2. **Real-World Issue**: This was reported by syzbot (a kernel fuzzer),
   indicating it's a reachable code path that can be triggered with
   malformed filesystem data. The bug report link confirms this is a
   reproducible issue.

3. **Simple and Contained Fix**: The change is minimal - it replaces the
   BUG_ON with:
  ```c
  if (i_size_read(attr_file) != 0) {
  err = -EIO;
  pr_err("detected inconsistent attributes file, running fsck.hfsplus is
  recommended.\n");
  goto end_attr_file_creation;
  }
  ```
  This is a straightforward conversion that maintains the same logic but
  handles the error gracefully.

4. **Prevents System Crashes**: BUG_ON() causes a kernel panic, which is
   particularly severe. Converting it to return -EIO allows the system
   to continue running and provides users with actionable guidance (run
   fsck.hfsplus).

5. **Low Risk of Regression**: The change only affects error handling
   when filesystem corruption is detected. It doesn't alter normal
   operation paths and follows established error handling patterns in
   the kernel.

6. **Follows Stable Tree Rules**: This is a classic example of a stable-
   worthy fix:
   - Fixes a real bug (system crash on corrupted filesystem)
   - Small, easily reviewable change
   - No new features or architectural changes
   - High benefit (prevents crashes) with minimal risk

The commit message clearly indicates this addresses filesystem
corruption scenarios where "the volume header contains erroneous values
that do not reflect the actual state of the filesystem," making it an
important robustness improvement for stable kernels.

 fs/hfsplus/xattr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index d91f76ef18d9..2438cd759620 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -172,7 +172,11 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 		return PTR_ERR(attr_file);
 	}
 
-	BUG_ON(i_size_read(attr_file) != 0);
+	if (i_size_read(attr_file) != 0) {
+		err = -EIO;
+		pr_err("detected inconsistent attributes file, running fsck.hfsplus is recommended.\n");
+		goto end_attr_file_creation;
+	}
 
 	hip = HFSPLUS_I(attr_file);
 
-- 
2.39.5


