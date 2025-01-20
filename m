Return-Path: <linux-fsdevel+bounces-39694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD2AA16FDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60C977A2377
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080371EB9F6;
	Mon, 20 Jan 2025 16:09:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6881E9919;
	Mon, 20 Jan 2025 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389386; cv=none; b=Lgt5KsdTfnHUGkxg3kRcTcLyjbzTscratqbDcE8/MixMBx3rQHpwpFap2aiNLWI8ZLeVAs35w5rJ+VUnykwS0YDXBI16TShLbqEGYx2gQH5U4xnRTHEp/XiaIWoiBPVJcU29KB+XfV86M2DGqniI6Z/zRnaDhyYVskUzLVQ4+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389386; c=relaxed/simple;
	bh=igENCtA9R8bhHeJmGcyg41lhuRUlTfQqaCUCXpXxlRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRbnNiL5gMrJzOleu+yxySoUKp6cCs38BUQo2L7yhoifNEGonAfiGF2mkm4KbDgcJ++9HHhfNw76/BRQptG/c6AvrWmGxXvzQwJI7eUtBWE+RsuHmcFX6YQX6BOwSTK05bsd+t76shIizjpD0hYk43CgaXE1bXZLcMGMVbjxuEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [220.197.236.33])
	by APP-03 (Coremail) with SMTP id rQCowAA3PAw8dY5ntKhtCA--.25804S2;
	Tue, 21 Jan 2025 00:09:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: djwong@kernel.org
Cc: chandanbabu@kernel.org,
	cem@kernel.org,
	brauner@kernel.org,
	dchinner@redhat.com,
	yi.zhang@huawei.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] xfs: Propagate errors from xfs_reflink_cancel_cow_range in xfs_dax_write_iomap_end
Date: Tue, 21 Jan 2025 00:09:06 +0800
Message-ID: <20250120160907.1751-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3PAw8dY5ntKhtCA--.25804S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyfXFyDKrW3WFy3AF13Jwb_yoWfXFc_ta
	1kKF4xW3W2vw17Aws3Ar9YyFnrGanrKFsxXrW8ta9xtryUCF1kGr4vyrZayry7W3ZI9F95
	Gw1q9rWftFy7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_
	GFylc2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
	9x0JUeq2_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsIA2eOHwO6JAAAss

In xfs_dax_write_iomap_end(), directly return the result of
xfs_reflink_cancel_cow_range() when !written, ensuring proper
error propagation and improving code robustness.

Fixes: ea6c49b784f0 ("xfs: support CoW in fsdax mode")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 fs/xfs/xfs_iomap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 50fa3ef89f6c..d61460309a78 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -976,10 +976,8 @@ xfs_dax_write_iomap_end(
 	if (!xfs_is_cow_inode(ip))
 		return 0;
 
-	if (!written) {
-		xfs_reflink_cancel_cow_range(ip, pos, length, true);
-		return 0;
-	}
+	if (!written)
+		return xfs_reflink_cancel_cow_range(ip, pos, length, true);
 
 	return xfs_reflink_end_cow(ip, pos, written);
 }
-- 
2.42.0.windows.2


