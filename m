Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B08421D81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfEQShZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:25 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57566 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729352AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj2-0000oB-O4; Fri, 17 May 2019 14:37:00 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/22] coda: don't try to print names that were considered too long
Date:   Fri, 17 May 2019 14:36:45 -0400
Message-Id: <582ae759a4fdfa31a64c35de489fa4efabac09d6.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Probably safer to just show the unexpected length and debug it from
the userspace side.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 00876ddadb43..7e103eb8ffcd 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -47,8 +47,8 @@ static struct dentry *coda_lookup(struct inode *dir, struct dentry *entry, unsig
 	int type = 0;
 
 	if (length > CODA_MAXNAMLEN) {
-		pr_err("name too long: lookup, %s (%*s)\n",
-		       coda_i2s(dir), (int)length, name);
+		pr_err("name too long: lookup, %s %zu\n",
+		       coda_i2s(dir), length);
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 
-- 
2.20.1

