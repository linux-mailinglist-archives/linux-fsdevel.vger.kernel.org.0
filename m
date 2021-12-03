Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5052F467DB3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 20:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbhLCTFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 14:05:02 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43200 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243519AbhLCTE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:04:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A7A6FCE281F;
        Fri,  3 Dec 2021 19:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6A4C53FAD;
        Fri,  3 Dec 2021 19:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638558089;
        bh=GXmPIgE0ZwJRB34/l3vEoqjm/LJssxrqvmuSzxhl6T4=;
        h=From:To:Cc:Subject:Date:From;
        b=GI6w2zd6ydzo8kmQeVrUOX7aiHrQN9WKYxJJrnc3NnRdEzR2q6BkrsR4Iqsgc/fj2
         Ew5ZsQMrr9j6MeXOvRdE0LteRod2CrCJckKHVLbT7gAtdM82Ty6saH+SdublBYAU7z
         paHkUYvQ3mhnpEGd3LeBmzSoudtrCHZs/zMxiDMXEPIkK5G73vPxA8Zeq/9aaphzXT
         tswtpWnMZwSYWdS8HbeJZ11t2TUMvzyf7/nJbdAtmBF0ZSnPjuGV6FMy72IoIZKAg0
         BL9WjC07vYVzSsn8UuDvqtYSZCFCYrPy2qpLfIUB14WMq7TDmBu5C3tmqvIYy2JpNE
         HnqIQw3yOAz+A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>,
        James Morris <jamorris@linux.microsoft.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fs/inode: avoid unused-variable warning
Date:   Fri,  3 Dec 2021 20:01:01 +0100
Message-Id: <20211203190123.874239-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Now that 'inodes_stat' is marked 'static', it causes a harmless warning
whenever it is unused:

fs/inode.c:73:29: error: 'inodes_stat' defined but not used [-Werror=unused-variable]
   73 | static struct inodes_stat_t inodes_stat;

Move it into the #ifdef that guards its only references.

Fixes: 245314851782 ("fs: move inode sysctls to its own file")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index bef6ba9b8eb4..63324df6fa27 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -67,11 +67,6 @@ const struct address_space_operations empty_aops = {
 };
 EXPORT_SYMBOL(empty_aops);
 
-/*
- * Statistics gathering..
- */
-static struct inodes_stat_t inodes_stat;
-
 static DEFINE_PER_CPU(unsigned long, nr_inodes);
 static DEFINE_PER_CPU(unsigned long, nr_unused);
 
@@ -106,6 +101,11 @@ long get_nr_dirty_inodes(void)
  * Handle nr_inode sysctl
  */
 #ifdef CONFIG_SYSCTL
+/*
+ * Statistics gathering..
+ */
+static struct inodes_stat_t inodes_stat;
+
 static int proc_nr_inodes(struct ctl_table *table, int write, void *buffer,
 			  size_t *lenp, loff_t *ppos)
 {
-- 
2.29.2

