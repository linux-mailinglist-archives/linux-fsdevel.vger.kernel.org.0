Return-Path: <linux-fsdevel+bounces-56585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988A0B19613
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 23:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A287ABCA1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 21:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF20C2264A9;
	Sun,  3 Aug 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czHGulkZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272FA2040A8;
	Sun,  3 Aug 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256045; cv=none; b=C3FmezNXprqEqLszGMTvpfpyB5ZIdxkPwuW1dG+GzCHGtGF7XGDyN3bfiva+EB6gyez+RsPNJygGs8YSA17R/JygpgCVkrjQfWTSWhajNnmuIonnk5SOiWJN7Zj5lhNWZ7sVPKKBm2wg8JbAxoVLAqzdJ3bxENiT2Jj1SiYHS+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256045; c=relaxed/simple;
	bh=2LK/g5UpKAcQvdGs5mw3rovHeY79/5O62YuslKEy0lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bV/N5z5qnM3VStCKE32144GrzZCUENmg2vZ1h4QIvZogRr/rWqI/3Fsm6r+/+u9rEnS1VdXfoNhMm3IOlUr4EtKB48tuF9xj4QgbnvXURyO3SsTHui70H/B6Rx1JyAUquG+u6/ep+wY9wU1p9FXmSzqElU6W014Pze+t9/lT4Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czHGulkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F626C4CEF8;
	Sun,  3 Aug 2025 21:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256045;
	bh=2LK/g5UpKAcQvdGs5mw3rovHeY79/5O62YuslKEy0lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czHGulkZlI2Ow5T9AOhqD69SFd6EQA02fcuwu2960qeGueSdJas8fawXcsA7XXTnD
	 f1JZLhssiiWdiTUPKfoOER1q0XhPCpc6h67+EALxv9fL88DL/FXRy1z28s+lwK9Gx4
	 HdkmXb/gPn6um9ZsaOY7UvOqoU1Y+cc45/YX3c3vDQuNNkTyFhbKQ0tDUh1JYXdlgG
	 VrN2YU7Rh+dOhOVqChg9BhOhksYtE/MFut2YCQteCbslftUQqsF+uZJC/CtZbTUQe0
	 EaJtIxCU2dxT2kas1VAZtgjLBq8+K5PBi/bFr22tVwdirfZE+cVC8xKLNCZnS7cnYM
	 TxfFG38UBQ6Tw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+1107451c16b9eb9d29e6@syzkaller.appspotmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/23] hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()
Date: Sun,  3 Aug 2025 17:20:12 -0400
Message-Id: <20250803212031.3547641-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212031.3547641-1-sashal@kernel.org>
References: <20250803212031.3547641-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.101
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
index f7f9d0889df3..d5fd8e068486 100644
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


