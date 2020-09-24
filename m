Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2677227689F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 08:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgIXGAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 02:00:06 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41129 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726799AbgIXGAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:00:06 -0400
X-IronPort-AV: E=Sophos;i="5.77,296,1596470400"; 
   d="scan'208";a="99567075"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Sep 2020 14:00:02 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 0A1AF48990E8;
        Thu, 24 Sep 2020 14:00:01 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 24 Sep 2020 13:59:58 +0800
Received: from localhost.localdomain (10.167.225.206) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 24 Sep 2020 13:59:58 +0800
From:   Hao Li <lihao2018.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <david@fromorbit.com>, <ira.weiny@intel.com>,
        <linux-xfs@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <y-goto@fujitsu.com>, <lihao2018.fnst@cn.fujitsu.com>
Subject: [PATCH v2] fs: Kill DCACHE_DONTCACHE dentry even if DCACHE_REFERENCED is set
Date:   Thu, 24 Sep 2020 13:59:58 +0800
Message-ID: <20200924055958.825515-1-lihao2018.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0A1AF48990E8.ADB91
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If DCACHE_REFERENCED is set, fast_dput() will return true, and then
retain_dentry() have no chance to check DCACHE_DONTCACHE. As a result,
the dentry won't be killed and the corresponding inode can't be evicted.
In the following example, the DAX policy can't take effects unless we
do a drop_caches manually.

  # DCACHE_LRU_LIST will be set
  echo abcdefg > test.txt

  # DCACHE_REFERENCED will be set and DCACHE_DONTCACHE can't do anything
  xfs_io -c 'chattr +x' test.txt

  # Drop caches to make DAX changing take effects
  echo 2 > /proc/sys/vm/drop_caches

What this patch does is preventing fast_dput() from returning true if
DCACHE_DONTCACHE is set. Then retain_dentry() will detect the
DCACHE_DONTCACHE and will return false. As a result, the dentry will be
killed and the inode will be evicted. In this way, if we change per-file
DAX policy, it will take effects automatically after this file is closed
by all processes.

I also add some comments to make the code more clear.

Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
---
v1 is split into two standalone patch as discussed in [1], and the first
patch has been reviewed in [2]. This is the second patch.

[1]: https://lore.kernel.org/linux-fsdevel/20200831003407.GE12096@dread.disaster.area/
[2]: https://lore.kernel.org/linux-fsdevel/20200906214002.GI12131@dread.disaster.area/

 fs/dcache.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ea0485861d93..97e81a844a96 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -793,10 +793,17 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * a reference to the dentry and change that, but
 	 * our work is done - we can leave the dentry
 	 * around with a zero refcount.
+	 *
+	 * Nevertheless, there are two cases that we should kill
+	 * the dentry anyway.
+	 * 1. free disconnected dentries as soon as their refcount
+	 *    reached zero.
+	 * 2. free dentries if they should not be cached.
 	 */
 	smp_rmb();
 	d_flags = READ_ONCE(dentry->d_flags);
-	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED;
+	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST |
+			DCACHE_DISCONNECTED | DCACHE_DONTCACHE;
 
 	/* Nothing to do? Dropping the reference was all we needed? */
 	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
-- 
2.28.0



