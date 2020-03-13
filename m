Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94513185295
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgCMXyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:54:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50202 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgCMXyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:08 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7y-00B6el-BN; Fri, 13 Mar 2020 23:54:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 65/69] open_last_lookups(): don't abuse complete_walk() when all we want is unlazy
Date:   Fri, 13 Mar 2020 23:53:53 +0000
Message-Id: <20200313235357.2646756-65-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a86ee06e637d..7269da642391 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3146,15 +3146,11 @@ static const char *open_last_lookups(struct nameidata *nd,
 		BUG_ON(nd->flags & LOOKUP_RCU);
 	} else {
 		/* create side of things */
-		/*
-		 * This will *only* deal with leaving RCU mode - LOOKUP_JUMPED
-		 * has been cleared when we got to the last component we are
-		 * about to look up
-		 */
-		error = complete_walk(nd);
-		if (unlikely(error))
-			return ERR_PTR(error);
-
+		if (nd->flags & LOOKUP_RCU) {
+			error = unlazy_walk(nd);
+			if (unlikely(error))
+				return ERR_PTR(error);
+		}
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
 		/* trailing slashes? */
 		if (unlikely(nd->last.name[nd->last.len]))
-- 
2.11.0

