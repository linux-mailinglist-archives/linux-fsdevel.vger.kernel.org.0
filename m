Return-Path: <linux-fsdevel+bounces-20172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EE98CF356
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 11:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1499282007
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 09:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756ABDF5C;
	Sun, 26 May 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUgz02pC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4FD37149;
	Sun, 26 May 2024 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716546; cv=none; b=Sj+a3pI/ps6rMcOgUuPvJZ6LKOzMGQFj08zULogPVbyujsukC4Sstx1HHyRvFk5v2iWe34D4cpnI1o/LtYt50k/2TSn8pmljIQZbeeAIEeCEHU9QIJyfMa0b6BBkojPQ9lCf6kLaYA4PG8Gc2fCuYursciD6i8GymJmN2U86xKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716546; c=relaxed/simple;
	bh=i7Z/G9cmpJj23HVhzDWePOJytogBSW+o5ky3OMJfc8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tuz+7DPSyXiA7uyvkxsVxbNPycpNrE9+rv4KsgcCbPuA6tha0iyCw98LXe3Jis4H0HX9C24rN5MOWEfFkq5WNUGhUZq4HxXAG/RKnsZEr9mxTJfIAoj8E8xFhEAAf1nRM7NnHeYs+A3jz6ZehZyyIKrrjG8pdKGQSPks9x7pjdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUgz02pC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB40C2BD10;
	Sun, 26 May 2024 09:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716546;
	bh=i7Z/G9cmpJj23HVhzDWePOJytogBSW+o5ky3OMJfc8o=;
	h=From:To:Cc:Subject:Date:From;
	b=JUgz02pCjOYaJOe20Kc663aOR6p7SeROyCAsoHsGmTwMenLDc4etdTHhsIvKk0xiu
	 YqbpTDolLBhA3QKNK0QGHo81u7QFtcpjwB29iLCYmExrCVQFj01FhK5tMezqNdGgau
	 SHkwRBvXc8z8jESEFeFCacQt8bM8FQRimIsdGTaFMfS/l9GBPKnv7Wa+oZi24Gh62T
	 vq2kL74LNXndMBan2vJ5mRpJhSs1sBfsIecw7Sl1HBglJhdQEps7v0GtG4hEuj3sa7
	 9Q3XYowc7+GXj1dfKrjKNQViMzJN0no32ET0Vd84XKlgOaZx84NY1U5FVTZTqUE9iP
	 mCu3czmWUPfYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kemeng Shi <shikemeng@huaweicloud.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 01/14] fs/writeback: bail out if there is no more inodes for IO and queued once
Date: Sun, 26 May 2024 05:42:06 -0400
Message-ID: <20240526094224.3412675-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.10
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
index 3d84fcc471c60..e89222ae285e9 100644
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


