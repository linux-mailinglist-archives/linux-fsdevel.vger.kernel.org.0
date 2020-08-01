Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEFB235311
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 17:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHAPrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 11:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgHAPrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 11:47:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E03C06174A;
        Sat,  1 Aug 2020 08:47:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g19so6148737plq.0;
        Sat, 01 Aug 2020 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mntg9taWes2IQ/63EyCAMBFQrt4r0EuOq++DeO6vhCU=;
        b=pCTnwJf3v3CtEPpkp/TmvlpTE5l3PmW5NUc45HZbvb18erR72HOH9vChUUZ3YypEyO
         pOEn+Y6kYFg12fDAXLjxmkkbrloT5baTLdylazRVuGcWyWbHNplhBTFGsHBS3CfSY+2K
         ZBbY7lcT6b3XDrGT6F4ErIzfUi1DslpZzJhhJT80tMKqGOFgZq3fHliRCoxY3j0MTrwH
         xaHWwOOL97SXN96TpJXkBVLs1QileWyBIrDM2KDZMp70zWezI8KETWo+zVKFUctCfd7M
         ZN07e0MHPDGZyxiugOuJhANAGjWuw5kdtYehMPA6KE05ot7lAQKCMW9zrb812vnxcSZF
         qKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mntg9taWes2IQ/63EyCAMBFQrt4r0EuOq++DeO6vhCU=;
        b=nPLRmvz1sDtn+gXZQT3vQzghV7/0I7KUNrrpJ5PZvXi/ITc+mXfsKGJw7WHAyI6OTx
         guYvVr7/TTr24l0wFPrOEw/ilnuez0Nk8m00GCiWSaulSrePkfg5Vy4D/9gQ7Zen1nxa
         sxjHkzWZ6FyfFWKwEMEcF7PSWGr480knDO5n6pv9Avw+wf3QRiHI6za88TVpFU6vcTPq
         TVFsBtoHLUwoEBbyG758rKgqrMbB+R9CykEAGFWlZlWADhvCoM5rpUEI9sPCfwVSIHso
         Pou5J8JMeLQf3iJwZ7Khg5NylRfKr1bFgzLMp6RKcA/XpF1X+CmdLBYg3SBAopPmdh9M
         lNbg==
X-Gm-Message-State: AOAM53386x19cUH5jZ8slaGYbtbQUuLTUuvBLUKeIf51mbrTj3y4vl8i
        gl4u9cItP74TcgcDz0q6uWY=
X-Google-Smtp-Source: ABdhPJzMVdJHi1GV+1Q4tvZMc/xr8ImvgRh9hFVdynekX3JhUv9ic2u08w6+W3V3yISXmtC/v+MQDw==
X-Received: by 2002:a17:902:8bc3:: with SMTP id r3mr8070864plo.112.1596296828074;
        Sat, 01 Aug 2020 08:47:08 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id j26sm13717331pfe.200.2020.08.01.08.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 08:47:07 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        mhocko@kernel.org, willy@infradead.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <shaoyafang@didiglobal.com>
Subject: [PATCH v4 1/2] xfs: avoid double restore PF_MEMALLOC_NOFS if transaction reservation fails
Date:   Sat,  1 Aug 2020 11:46:31 -0400
Message-Id: <20200801154632.866356-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200801154632.866356-1-laoar.shao@gmail.com>
References: <20200801154632.866356-1-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yafang Shao <shaoyafang@didiglobal.com>

In xfs_trans_alloc(), if xfs_trans_reserve() fails, it will call
xfs_trans_cancel(), in which it will restore the flag PF_MEMALLOC_NOFS.
However this flags has been restored in xfs_trans_reserve(). Although
this behavior doesn't introduce any obvious issue, we'd better improve it.

Signed-off-by: Yafang Shao <shaoyafang@didiglobal.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 fs/xfs/xfs_trans.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 3c94e5ff4316..9ff41970d0c7 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -162,10 +162,9 @@ xfs_trans_reserve(
 	 */
 	if (blocks > 0) {
 		error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
-		if (error != 0) {
-			current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+		if (error != 0)
 			return -ENOSPC;
-		}
+
 		tp->t_blk_res += blocks;
 	}
 
@@ -240,8 +239,6 @@ xfs_trans_reserve(
 		tp->t_blk_res = 0;
 	}
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
-
 	return error;
 }
 
@@ -972,6 +969,7 @@ xfs_trans_roll(
 	struct xfs_trans	**tpp)
 {
 	struct xfs_trans	*trans = *tpp;
+	struct xfs_trans        *tp;
 	struct xfs_trans_res	tres;
 	int			error;
 
@@ -1005,5 +1003,10 @@ xfs_trans_roll(
 	 * the prior and the next transactions.
 	 */
 	tres.tr_logflags = XFS_TRANS_PERM_LOG_RES;
-	return xfs_trans_reserve(*tpp, &tres, 0, 0);
+	tp = *tpp;
+	error = xfs_trans_reserve(tp, &tres, 0, 0);
+	if (error)
+		current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+
+	return error;
 }
-- 
2.18.1

