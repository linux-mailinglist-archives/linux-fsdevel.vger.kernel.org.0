Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A067196D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjFAJYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjFAJYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:24:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C597;
        Thu,  1 Jun 2023 02:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685611458; x=1717147458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Ymm/6OWObb7Kf1VIHZ9ZMQKmwWlMpFwhEfUVyzgGx4=;
  b=a/0o6/NT2eCWAPZMxcqYC7YnHIL6uHNqxst6n6TV4Ur9na+EHo527SyM
   U6Dd6EyIzgzsH6ElSidZ8XBL0g+qRjnyPy0EJBrjLne8w5FqfZIZGIAQ4
   zyOv5TTCgqG/wzBcHtvZS/PjtUaIvXu2IRsMnELTWHPIhpuN4g1Y01vpI
   7ykwnbsoB8CM6NeQp2XeKXof1/8LagU8ZZc3qvq3q2tIxggkB455UGIL1
   phG0BiEOkin5v8exXIQpfVRHeqsEraryfG9EC3CVrbNKz6FnyR6PhLN87
   dMm9itF5bYe4b+57CUu8/CRDT0BfP55Pbx5QJ7m38tQMVHquExaSC9vcA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="340108023"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="340108023"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 02:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="819691220"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="819691220"
Received: from crt-e302.sh.intel.com (HELO localhost.localdomain) ([10.239.45.181])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2023 02:24:16 -0700
From:   chenzhiyin <zhiyin.chen@intel.com>
To:     zhiyin.chen@intel.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nanhai.zou@intel.com
Subject: [PATCH] fs.h: Optimize file struct to prevent false sharing
Date:   Thu,  1 Jun 2023 05:24:00 -0400
Message-Id: <20230601092400.27162-1-zhiyin.chen@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230531-wahlkabine-unantastbar-9f73a13262c0@brauner>
References: <20230531-wahlkabine-unantastbar-9f73a13262c0@brauner>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the syscall test of UnixBench, performance regression occurred due
to false sharing.

The lock and atomic members, including file::f_lock, file::f_count and
file::f_pos_lock are highly contended and frequently updated in the
high-concurrency test scenarios. perf c2c indentified one affected
read access, file::f_op.
To prevent false sharing, the layout of file struct is changed as
following
(A) f_lock, f_count and f_pos_lock are put together to share the same
cache line.
(B) The read mostly members, including f_path, f_inode, f_op are put
into a separate cache line.
(C) f_mode is put together with f_count, since they are used frequently
 at the same time.
Due to '__randomize_layout' attribute of file struct, the updated layout
only can be effective when CONFIG_RANDSTRUCT_NONE is 'y'.

The optimization has been validated in the syscall test of UnixBench.
performance gain is 30~50%. Furthermore, to confirm the optimization
effectiveness on the other codes path, the results of fsdisk, fsbuffer
and fstime are also shown.

Here are the detailed test results of unixbench.

Command: numactl -C 3-18 ./Run -c 16 syscall fsbuffer fstime fsdisk

Without Patch
------------------------------------------------------------------------
File Copy 1024 bufsize 2000 maxblocks   875052.1 KBps  (30.0 s, 2 samples)
File Copy 256 bufsize 500 maxblocks     235484.0 KBps  (30.0 s, 2 samples)
File Copy 4096 bufsize 8000 maxblocks  2815153.5 KBps  (30.0 s, 2 samples)
System Call Overhead                   5772268.3 lps   (10.0 s, 7 samples)

System Benchmarks Partial Index         BASELINE       RESULT    INDEX
File Copy 1024 bufsize 2000 maxblocks     3960.0     875052.1   2209.7
File Copy 256 bufsize 500 maxblocks       1655.0     235484.0   1422.9
File Copy 4096 bufsize 8000 maxblocks     5800.0    2815153.5   4853.7
System Call Overhead                     15000.0    5772268.3   3848.2
                                                              ========
System Benchmarks Index Score (Partial Only)                    2768.3

With Patch
------------------------------------------------------------------------
File Copy 1024 bufsize 2000 maxblocks  1009977.2 KBps  (30.0 s, 2 samples)
File Copy 256 bufsize 500 maxblocks     264765.9 KBps  (30.0 s, 2 samples)
File Copy 4096 bufsize 8000 maxblocks  3052236.0 KBps  (30.0 s, 2 samples)
System Call Overhead                   8237404.4 lps   (10.0 s, 7 samples)

System Benchmarks Partial Index         BASELINE       RESULT    INDEX
File Copy 1024 bufsize 2000 maxblocks     3960.0    1009977.2   2550.4
File Copy 256 bufsize 500 maxblocks       1655.0     264765.9   1599.8
File Copy 4096 bufsize 8000 maxblocks     5800.0    3052236.0   5262.5
System Call Overhead                     15000.0    8237404.4   5491.6
                                                              ========
System Benchmarks Index Score (Partial Only)                    3295.3

Signed-off-by: chenzhiyin <zhiyin.chen@intel.com>
---
 include/linux/fs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 133f0640fb24..cf1388e4dad0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -962,23 +962,23 @@ struct file {
 		struct rcu_head 	f_rcuhead;
 		unsigned int 		f_iocb_flags;
 	};
-	struct path		f_path;
-	struct inode		*f_inode;	/* cached value */
-	const struct file_operations	*f_op;
 
 	/*
 	 * Protects f_ep, f_flags.
 	 * Must not be taken from IRQ context.
 	 */
 	spinlock_t		f_lock;
-	atomic_long_t		f_count;
-	unsigned int 		f_flags;
 	fmode_t			f_mode;
+	atomic_long_t		f_count;
 	struct mutex		f_pos_lock;
 	loff_t			f_pos;
+	unsigned int		f_flags;
 	struct fown_struct	f_owner;
 	const struct cred	*f_cred;
 	struct file_ra_state	f_ra;
+	struct path		f_path;
+	struct inode		*f_inode;	/* cached value */
+	const struct file_operations	*f_op;
 
 	u64			f_version;
 #ifdef CONFIG_SECURITY
-- 
2.39.1

