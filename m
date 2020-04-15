Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0691AAA3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 16:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636682AbgDOOie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 10:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394081AbgDOOdD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:33:03 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 989B821D7F;
        Wed, 15 Apr 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961171;
        bh=23W1yG2qd23ktTEijZVV4o1Pn9RiSi+sd+ontuQcaUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/6Ky7ulpaMQzAvg6L1uWqpqwxH1ebX+25NRicM8wfSkZivdFaRd3rqI4zkp7pxtN
         eUUGumB8pAiNPQoY9tOGNR+gaL41mvffwk3TH4RiGaRce/zuapmqpGag+vQmmAcG/Z
         dONKFtid4G8rVbhAe5CGmG6IBZsqeVlNjttMakXc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5t-006kPR-QP; Wed, 15 Apr 2020 16:32:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/34] docs: filesystems: rename path-lookup.txt file
Date:   Wed, 15 Apr 2020 16:32:35 +0200
Message-Id: <ddee231f968fcf8a9558ff39f251fdd7b2357ff2.1586960617.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586960617.git.mchehab+huawei@kernel.org>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are two files called "patch-lookup", with different contents:
one is a ReST file, the other one is the text.

As we'll be finishing the conversion of filesystem documents,
let's fist rename the text one, in order to avoid messing with
the existing ReST file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{path-lookup.txt => path-walking.txt}       | 0
 Documentation/filesystems/porting.rst                       | 2 +-
 fs/dcache.c                                                 | 6 +++---
 fs/namei.c                                                  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename Documentation/filesystems/{path-lookup.txt => path-walking.txt} (100%)

diff --git a/Documentation/filesystems/path-lookup.txt b/Documentation/filesystems/path-walking.txt
similarity index 100%
rename from Documentation/filesystems/path-lookup.txt
rename to Documentation/filesystems/path-walking.txt
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 26c093969573..8f7d25acf326 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -404,7 +404,7 @@ the callback.  It used to be necessary to clean it there, but not anymore
 
 vfs now tries to do path walking in "rcu-walk mode", which avoids
 atomic operations and scalability hazards on dentries and inodes (see
-Documentation/filesystems/path-lookup.txt). d_hash and d_compare changes
+Documentation/filesystems/path-walking.txt). d_hash and d_compare changes
 (above) are examples of the changes required to support this. For more complex
 filesystem callbacks, the vfs drops out of rcu-walk mode before the fs call, so
 no changes are required to the filesystem. However, this is costly and loses
diff --git a/fs/dcache.c b/fs/dcache.c
index b280e07e162b..cf8d5893bd0e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2191,7 +2191,7 @@ static inline bool d_same_name(const struct dentry *dentry,
  *
  * __d_lookup_rcu is the dcache lookup function for rcu-walk name
  * resolution (store-free path walking) design described in
- * Documentation/filesystems/path-lookup.txt.
+ * Documentation/filesystems/path-walking.txt.
  *
  * This is not to be used outside core vfs.
  *
@@ -2239,7 +2239,7 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 	 * false-negative result. d_lookup() protects against concurrent
 	 * renames using rename_lock seqlock.
 	 *
-	 * See Documentation/filesystems/path-lookup.txt for more details.
+	 * See Documentation/filesystems/path-walking.txt for more details.
 	 */
 	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
 		unsigned seq;
@@ -2362,7 +2362,7 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 	 * false-negative result. d_lookup() protects against concurrent
 	 * renames using rename_lock seqlock.
 	 *
-	 * See Documentation/filesystems/path-lookup.txt for more details.
+	 * See Documentation/filesystems/path-walking.txt for more details.
 	 */
 	rcu_read_lock();
 	
diff --git a/fs/namei.c b/fs/namei.c
index a320371899cf..d1b53fea83d8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -645,7 +645,7 @@ static bool legitimize_root(struct nameidata *nd)
 
 /*
  * Path walking has 2 modes, rcu-walk and ref-walk (see
- * Documentation/filesystems/path-lookup.txt).  In situations when we can't
+ * Documentation/filesystems/path-walking.txt).  In situations when we can't
  * continue in RCU mode, we attempt to drop out of rcu-walk mode and grab
  * normal reference counts on dentries and vfsmounts to transition to ref-walk
  * mode.  Refcounts are grabbed at the last known good point before rcu-walk
-- 
2.25.2

