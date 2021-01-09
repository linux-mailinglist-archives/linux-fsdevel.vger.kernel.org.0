Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3212EFE84
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 09:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbhAIIBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 03:01:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbhAIIBF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:01:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48D5023A79;
        Sat,  9 Jan 2021 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610179186;
        bh=HlkfW2Zd+8gbGgRYWpPKUKO7Wsu0D0Ym2jm7ngGDK6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TiFXWSyfmbsN3BDcG7PKa2lenBUufiTlI+s5eLmHeooUDodCaYvgbrC0t8ZxpN/zN
         JbsWlpl0uq3xkj5uqtZv+Bo4odDb3qTVPjpPtDmhmn5Wd7nmW3THFhIGqFy82BMiGx
         tp9i8kbwvNKQviYzrZG0WbLWcr5XJbqWSAXXjQI5TJr7DmZT9dJgYsscxWr94zZu1U
         29llfMrMr/uxGRdZ2bUSuC0QnTZLXzMy4tbITGOnHX9r67IwEncVqVlvh887GdAWF9
         1Joi3ciGc+t2Xqd3h4Ez1iZELXUZYaXEfHjEQS13fBBYIrW/L91+G0qYr3wVEK2oYu
         c0nd4I5Kgqq7A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 08/12] fs: drop redundant check from __writeback_single_inode()
Date:   Fri,  8 Jan 2021 23:58:59 -0800
Message-Id: <20210109075903.208222-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210109075903.208222-1-ebiggers@kernel.org>
References: <20210109075903.208222-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

wbc->for_sync implies wbc->sync_mode == WB_SYNC_ALL, so there's no need
to check for both.  Just check for WB_SYNC_ALL.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 80ee9816d9df5..cee1df6e3bd43 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1479,7 +1479,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	 * change I_DIRTY_TIME into I_DIRTY_SYNC.
 	 */
 	if ((inode->i_state & I_DIRTY_TIME) &&
-	    (wbc->sync_mode == WB_SYNC_ALL || wbc->for_sync ||
+	    (wbc->sync_mode == WB_SYNC_ALL ||
 	     time_after(jiffies, inode->dirtied_time_when +
 			dirtytime_expire_interval * HZ))) {
 		trace_writeback_lazytime(inode);
-- 
2.30.0

