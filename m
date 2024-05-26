Return-Path: <linux-fsdevel+bounces-20174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CCA8CF37B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 11:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567E71C20491
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96931427B;
	Sun, 26 May 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHHtIDdd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08954BEF;
	Sun, 26 May 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716574; cv=none; b=L4WBllRmztY8MrzYzrP7q2Jr9ZJWm2v414XJ/d+9Wt7UX/qDBAS3RYj7mUUqOMg/GNwKyoPY5HnkPFKTdiGNfVNpZATd5EKb5M2u/LmCKJuRphOvn7z2oT9+L2BcZqbbxwYNCETEf2ROEJmyRxQ7vm645Jb5F49Td7t363DyDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716574; c=relaxed/simple;
	bh=edFG/DHNhRambl9sDHNZy9/rK2n6CttbpYK3hY/YZ64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdejdijN826l9sSkKDeNQ8t4+z4mhch1U89EowOUbDVN5PhCZuEhJ2aiha5WzyY7I6RXGcC/R9yKwnOtGIadGmnd1iuZiIquEwImR1yJNsetBI0x15M4wux5iqooSEACefeK2KH5Opz+yjBbNYbzOHZXeLs8/YS4SSlzCmC3CXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHHtIDdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32804C2BD10;
	Sun, 26 May 2024 09:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716574;
	bh=edFG/DHNhRambl9sDHNZy9/rK2n6CttbpYK3hY/YZ64=;
	h=From:To:Cc:Subject:Date:From;
	b=fHHtIDddyEMw5kCg6dZaoZyjDQx8XjU4cjfuYfQDlkG3fKHBeWNWN5jwRj1KEMli9
	 t4d2xBFC7zuFVWjYoo4vZHNcXlu+VZj4KUclcTgYXBqilnQPwfVKsRRFV8GQxkykru
	 ojnAGXOrWguCRtL1LOiAiqYxUldfDdpCwVvffzXz6ZTngH/yYcCnPPDRUodQS4u0M9
	 h2cL/blix0ia9Z6GKuytbTwcC+5yaoxbHPKRzOKcItb5e+WTGZzenadWVgbv0611r4
	 5ErA/8SMUwutuDF3pfspD0iJrbQ9cMl1yaEJNXWEyR6UClygvro3UelzURIAXJ29Qp
	 J4hEo64OA51IA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kemeng Shi <shikemeng@huaweicloud.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/11] fs/writeback: bail out if there is no more inodes for IO and queued once
Date: Sun, 26 May 2024 05:42:39 -0400
Message-ID: <20240526094251.3413178-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.31
Content-Transfer-Encoding: 8bit

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit d92109891f21cf367caa2cc6dff11a4411d917f4 ]

For case there is no more inodes for IO in io list from last wb_writeback,
We may bail out early even there is inode in dirty list should be written
back. Only bail out when we queued once to avoid missing dirtied inode.

This is from code reading...

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Link: https://lore.kernel.org/r/20240228091958.288260-3-shikemeng@huaweicloud.com
Reviewed-by: Jan Kara <jack@suse.cz>
[brauner@kernel.org: fold in memory corruption fix from Jan in [1]]
Link: https://lore.kernel.org/r/20240405132346.bid7gibby3lxxhez@quack3 [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fs-writeback.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 1767493dffda7..0a498bc60f557 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2044,6 +2044,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 	struct inode *inode;
 	long progress;
 	struct blk_plug plug;
+	bool queued = false;
 
 	blk_start_plug(&plug);
 	for (;;) {
@@ -2086,8 +2087,10 @@ static long wb_writeback(struct bdi_writeback *wb,
 			dirtied_before = jiffies;
 
 		trace_writeback_start(wb, work);
-		if (list_empty(&wb->b_io))
+		if (list_empty(&wb->b_io)) {
 			queue_io(wb, work, dirtied_before);
+			queued = true;
+		}
 		if (work->sb)
 			progress = writeback_sb_inodes(work->sb, wb, work);
 		else
@@ -2102,7 +2105,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 		 * mean the overall work is done. So we keep looping as long
 		 * as made some progress on cleaning pages or inodes.
 		 */
-		if (progress) {
+		if (progress || !queued) {
 			spin_unlock(&wb->list_lock);
 			continue;
 		}
-- 
2.43.0


