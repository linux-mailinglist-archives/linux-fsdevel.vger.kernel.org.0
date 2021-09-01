Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5394D3FD5D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 10:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbhIAIpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 04:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbhIAIpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:45:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE7C061575
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 01:44:05 -0700 (PDT)
Date:   Wed, 1 Sep 2021 10:44:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630485844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=OwL2APOLnIyQcQBEN8N4jEMDGymfTJoCkh6LF+zjW0M=;
        b=NZ85PSlDD9PRWdLIWjtqhxPz32LkILrDXNpwvQsZ94VI5gcRG5064edezY/eKpBV7N4p37
        WGqK/ONvbOedNAVTgmmkSZ2XjFhcqpzBTfcm+jH1qcywifSF3wHq2E9o3gkzftYdue1hos
        0q4HOSTbTXIAzvuKKVVUBcCnKMcYmqCEUO3kYwbRLnzvLSY41ta+bCpXfY9RX7lDi8fw2+
        wsiAZUg2xWx3m+xi5QG4zjrbR/aGlsPI+YFC8asPVAEDqTVjQxOPuSJWsky+HjEC3KkQ9D
        dd4z/QLXnlVSoHy8x2tGZ9kxkgf38DptCTiUWPZnecJSi5wGqxG7csp5IfmNdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630485844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=OwL2APOLnIyQcQBEN8N4jEMDGymfTJoCkh6LF+zjW0M=;
        b=00opB2rOP6i/KRLtnpqFCaKhCtENhdg28Yhz3e6x7ZJTcGBpF3V4lx5TenBb7kPNJyeJJ9
        rh5gdJ79kEZAk/CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] mm: Fully initialize invalidate_lock, amend lock class later
Message-ID: <20210901084403.g4fezi23cixemlhh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function __init_rwsem() is not part of the official API, it just a helper
function used by init_rwsem().
Changing the lock's class and name should be done by using
lockdep_set_class_and_name() after the has been fully initialized. The overhead
of the additional class struct and setting it twice is negligible and it works
across all locks.

Fully initialize the lock with init_rwsem() and then set the custom class and
name for the lock.

Fixes: 730633f0b7f95 ("mm: Protect operations adding pages to page cache with invalidate_lock")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index cb41f02d8cedf..a49695f57e1ea 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -190,8 +190,10 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
 	mapping->private_data = NULL;
 	mapping->writeback_index = 0;
-	__init_rwsem(&mapping->invalidate_lock, "mapping.invalidate_lock",
-		     &sb->s_type->invalidate_lock_key);
+	init_rwsem(&mapping->invalidate_lock);
+	lockdep_set_class_and_name(&mapping->invalidate_lock,
+				   &sb->s_type->invalidate_lock_key,
+				   "mapping.invalidate_lock");
 	inode->i_private = NULL;
 	inode->i_mapping = mapping;
 	INIT_HLIST_HEAD(&inode->i_dentry);	/* buggered by rcu freeing */
-- 
2.33.0

