Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3573B33FE21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 05:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCRER7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 00:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhCRERh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:17:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEBFA64F10;
        Thu, 18 Mar 2021 04:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616041056;
        bh=FJTgW6lFuLi9Cr/pjHHZ+gvHiGshAaLz/kgfEaWR16U=;
        h=Date:From:To:Cc:Subject:From;
        b=oNAiroWZPr5r/+2FypqkNqjIBTjym8eZhG0FEIMa1/W+Q6vD9GxIqzhcD9o8EzZJm
         BJYd89TcIUp6Zy6WYKSbrg4PwISgWLsVpJy6ovFJhkEIZKLhxWFrVGUZ39me9pA6g4
         kb/TkDefd1Yjoii2f7h5DHkUOZcEYcVP7N1MX8P9C2I1jxK4lUsZ1X9bZPnIYd5sGp
         C8QctJPC0jiAfbfk+Dfd+dVZHwk6wbfv/rKFZhXb9NmpZn8mmP2HkvZwvPp07m4i8y
         eKUvwSYg4AL5brxDGE39qMh6wjQMdFcIzM3F59Xxsv3Jhz+DooxZh8p9UQqpPnp8Jb
         kgYMrQ2iKeXTw==
Date:   Wed, 17 Mar 2021 21:17:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: [PATCH] quota: report warning limits for realtime space quotas
Message-ID: <20210318041736.GB22094@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Report the number of warnings that a user will get for exceeding the
soft limit of a realtime volume.  This plugs a gap needed before we
can land a realtime quota implementation for XFS in the next cycle.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/quota/quota.c               |    1 +
 include/uapi/linux/dqblk_xfs.h |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 6d16b2be5ac4..6ad06727e8ea 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -471,6 +471,7 @@ static int quota_getstatev(struct super_block *sb, int type,
 	fqs->qs_rtbtimelimit = state.s_state[type].rt_spc_timelimit;
 	fqs->qs_bwarnlimit = state.s_state[type].spc_warnlimit;
 	fqs->qs_iwarnlimit = state.s_state[type].ino_warnlimit;
+	fqs->qs_rtbwarnlimit = state.s_state[type].rt_spc_warnlimit;
 
 	/* Inodes may be allocated even if inactive; copy out if present */
 	if (state.s_state[USRQUOTA].ino) {
diff --git a/include/uapi/linux/dqblk_xfs.h b/include/uapi/linux/dqblk_xfs.h
index c71d909addda..8cda3e62e0e7 100644
--- a/include/uapi/linux/dqblk_xfs.h
+++ b/include/uapi/linux/dqblk_xfs.h
@@ -219,7 +219,10 @@ struct fs_quota_statv {
 	__s32			qs_rtbtimelimit;/* limit for rt blks timer */
 	__u16			qs_bwarnlimit;	/* limit for num warnings */
 	__u16			qs_iwarnlimit;	/* limit for num warnings */
-	__u64			qs_pad2[8];	/* for future proofing */
+	__u16			qs_rtbwarnlimit;/* limit for rt blks warnings */
+	__u16			qs_pad3;
+	__u32			qs_pad4;
+	__u64			qs_pad2[7];	/* for future proofing */
 };
 
 #endif	/* _LINUX_DQBLK_XFS_H */
