Return-Path: <linux-fsdevel+bounces-20170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DE28CF32E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 11:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F4D1F21EA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 09:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F475AD51;
	Sun, 26 May 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7bArF6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D598BFA;
	Sun, 26 May 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716515; cv=none; b=hme4FW92LhWL0Y5uwRBeO13CVloAIMMvNHw1XsDUE1NjhmPRkO5VIsvVC3n7hWlgisLE1eu54BPaW9bTXVOwNvyA7eZnEWLuAk/L/LMV4J5XnDl0GrYvzrppxjvlOrrOBR5fSLOvb9R+2GthhaMv+aZw9s+K92lrG3pqONmxINQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716515; c=relaxed/simple;
	bh=S2RStSnL+ZuHwDxLhADz//Rm4j2YtGbAYc1Mf+XV6h4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+BBeVOqaTsWZ2T++GIwgsBbZI+RIuvs96RXgUdOZzDnerGxtQilAfm1D6kISdHpOSJGpDFOdU3zlBkBqwNhs9Y0XzOPvpww7gXG8+TeLD2KUd9th0u744wXxGPLvZe8WSwyYmCRkYaPPfWWFAhvFyIjxXdXV5yjEabraqXyySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7bArF6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D3EC2BD10;
	Sun, 26 May 2024 09:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716515;
	bh=S2RStSnL+ZuHwDxLhADz//Rm4j2YtGbAYc1Mf+XV6h4=;
	h=From:To:Cc:Subject:Date:From;
	b=t7bArF6+fz5WHREY17OYj1k9bzGreSUbXzp6njZaSmYo7AeZCUwqxgfEY6Z0DVqBP
	 3iACUF854xcRz0v9DJzX07EWeu5xFfWAv5TuQtDVpnraPJCYJtU667+cEuAM2QLI3+
	 MhtrJYmJrP6lQk6DlNleBR6C0iHbjkXWLfSUmFNzMZK+Qqv2iWXVslWmCaxUyVgmpM
	 uI+kBhjnqY5HXbKNsfakZlLiuMQtCYG7xFqdQC1jwQAGUUjMOZghxekHCFbOEcNOI+
	 8mRxRtot7J6Vzv6RtZl/eohmy8DkDsbyMJcpNa9fh4PbT7pIRDQLAYC8W9WzwvckLY
	 MNgBdnaD1EzRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kemeng Shi <shikemeng@huaweicloud.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 01/15] fs/writeback: bail out if there is no more inodes for IO and queued once
Date: Sun, 26 May 2024 05:41:33 -0400
Message-ID: <20240526094152.3412316-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.1
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
index e4f17c53ddfcf..d31853032a931 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2069,6 +2069,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 	struct inode *inode;
 	long progress;
 	struct blk_plug plug;
+	bool queued = false;
 
 	blk_start_plug(&plug);
 	for (;;) {
@@ -2111,8 +2112,10 @@ static long wb_writeback(struct bdi_writeback *wb,
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
@@ -2127,7 +2130,7 @@ static long wb_writeback(struct bdi_writeback *wb,
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


