Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC629403B8D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 16:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351942AbhIHOaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 10:30:30 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:41500 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351936AbhIHOa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:30:29 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1mNyAO-0004r4-Px; Wed, 08 Sep 2021 10:03:08 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/9] coda: Avoid flagging NULL inodes
Date:   Wed,  8 Sep 2021 10:03:03 -0400
Message-Id: <20210908140308.18491-5-jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
References: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Somehow we hit a negative dentry in coda_rename even after checking
with d_really_is_positive. Maybe something raced and turned the
new_dentry negative while we were fixing up directory link counts.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/coda_linux.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index e7b27754ce78..3c2947bba5e5 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -83,6 +83,9 @@ static __inline__ void coda_flag_inode(struct inode *inode, int flag)
 {
 	struct coda_inode_info *cii = ITOC(inode);
 
+	if (!inode)
+		return;
+
 	spin_lock(&cii->c_lock);
 	cii->c_flags |= flag;
 	spin_unlock(&cii->c_lock);
-- 
2.25.1

