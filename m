Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D56C745097
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 21:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjGBTkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 15:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGBTjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:39:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A56A1739;
        Sun,  2 Jul 2023 12:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F006260C7B;
        Sun,  2 Jul 2023 19:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84407C433CB;
        Sun,  2 Jul 2023 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326729;
        bh=lH81V+e1g5EfbTI/NE8A3NH8x3Ti+bohd12L6Xzo+bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ro48bdgvFjJ2286gFQMYt1aVbtB8NzpJ6xiSRBtxjtfs20hcBnGVy21lrmLQfhDVv
         uFrMm02/SkrdexHQlsZpXKiE1ekcz2gtjo/PNjfUyoDLaPkfc2A+mTxzOWmf569k/D
         zILeIkkrew37lFnptnild90eAWgUoy1lFAgEdWzluOyE7/Eyg0NMj/tmpd6Bn1NRqM
         7VK34M1Dv/bVPPB1e8KbRpL4JqNd9IGrtvhqyxOWV88CNLfjzb0ywe4D/ien35fwOX
         iAUTG1scu8Nc1z1RRsguPFjvr4/I9c9hIukDRPIXzZYTJjcDD6RusjbU3PLbkUd745
         zbVVT6q92moVQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     chenzhiyin <zhiyin.chen@intel.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 12/16] fs.h: Optimize file struct to prevent false sharing
Date:   Sun,  2 Jul 2023 15:38:11 -0400
Message-Id: <20230702193815.1775684-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: chenzhiyin <zhiyin.chen@intel.com>

[ Upstream commit a7bc2e8ddf3c8e1f5bfeb401f7ee112956cea259 ]

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
Message-Id: <20230601092400.27162-1-zhiyin.chen@intel.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fs.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 133f0640fb241..6f96f99ab9511 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -956,29 +956,35 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
 		index <  ra->start + ra->size);
 }
 
+/*
+ * f_{lock,count,pos_lock} members can be highly contended and share
+ * the same cacheline. f_{lock,mode} are very frequently used together
+ * and so share the same cacheline as well. The read-mostly
+ * f_{path,inode,op} are kept on a separate cacheline.
+ */
 struct file {
 	union {
 		struct llist_node	f_llist;
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
2.39.2

