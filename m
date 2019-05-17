Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188F121D71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfEQShF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:05 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57672 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726888AbfEQShD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:03 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj3-0000qD-KP; Fri, 17 May 2019 14:37:01 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 21/22] coda: remove sb test in coda_fid_to_inode()
Date:   Fri, 17 May 2019 14:36:59 -0400
Message-Id: <d2163b3136348faf83ba47dc2d65a5d0a9a135dd.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Fabian Frederick <fabf@skynet.be>

coda_fid_to_inode() is only called by coda_downcall() where
sb is already being tested.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/cnode.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/coda/cnode.c b/fs/coda/cnode.c
index 2e5badf67f98..e2dcf2addf3f 100644
--- a/fs/coda/cnode.c
+++ b/fs/coda/cnode.c
@@ -137,11 +137,6 @@ struct inode *coda_fid_to_inode(struct CodaFid *fid, struct super_block *sb)
 	struct inode *inode;
 	unsigned long hash = coda_f2i(fid);
 
-	if ( !sb ) {
-		pr_warn("%s: no sb!\n", __func__);
-		return NULL;
-	}
-
 	inode = ilookup5(sb, hash, coda_test_inode, fid);
 	if ( !inode )
 		return NULL;
-- 
2.20.1

