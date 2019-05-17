Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D38D21D76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfEQShL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:11 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57644 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729376AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj3-0000pl-C4; Fri, 17 May 2019 14:37:01 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 17/22] coda: destroy mutex in put_super()
Date:   Fri, 17 May 2019 14:36:55 -0400
Message-Id: <f436f68908c467c5663bc6a9251b52cd7b95d2a5.1558117389.git.jaharkes@cs.cmu.edu>
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

we can safely destroy vc_mutex at the end of umount process.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 96d832ed23b5..321f56e487cb 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -236,6 +236,7 @@ static void coda_put_super(struct super_block *sb)
 	vcp->vc_sb = NULL;
 	sb->s_fs_info = NULL;
 	mutex_unlock(&vcp->vc_mutex);
+	mutex_destroy(&vcp->vc_mutex);
 
 	pr_info("Bye bye.\n");
 }
-- 
2.20.1

