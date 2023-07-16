Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16702754F1A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 16:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGPOwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGPOwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 10:52:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2E3137;
        Sun, 16 Jul 2023 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689519150; x=1721055150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7FhqY0BU1HUaPgWFw91cagayl/GC8Rb31al0fZzyCk=;
  b=WCcvQkr4jXSkl88LnViU6ixr7f+YwBYNXeJ+X2rhrzxdlbqSLkgw1aQd
   S8uTEJiLuFcepVQp4u3kSIFvNEaEJd55ad6G0Frt3qRrz9AnfiK/LUb0V
   AdWYpOihpKkWhX6n3VGA32nhVfIUdu5dO6wPjnAhSh/OcdfCqT450OHO2
   /MkvsGB1geC/VM573arow7dDeGhYsdm1PGnQ/jttCk7FJQGQaeK0l6a01
   tfdMRGH2i0khoIuGW8PO8g0r+Xf5w58nnoZMr19erZXscPHnO3NX8Fk8V
   5rudxjqOgPE4Ua6zXrTXIibrkor0A4Atpy0taLT0kivcjRo4qi7HIVF9e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="396580049"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="396580049"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 07:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="969573131"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="969573131"
Received: from linux-pnp-server-30.sh.intel.com ([10.239.146.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2023 07:52:27 -0700
From:   "Zhu, Lipeng" <lipeng.zhu@intel.com>
To:     akpm@linux-foundation.org
Cc:     lipeng.zhu@inte.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pan.deng@intel.com, tianyou.li@intel.com,
        tim.c.chen@linux.intel.com, viro@zeniv.linux.org.uk,
        yu.ma@intel.com, "Zhu, Lipeng" <lipeng.zhu@intel.com>
Subject: [PATCH v2] fs/address_space: add alignment padding for i_map and i_mmap_rwsem to mitigate a false sharing.
Date:   Sun, 16 Jul 2023 22:56:54 +0800
Message-Id: <20230716145653.20122-1-lipeng.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <PH7PR11MB6056EB3C6651A770BF0081699F3AA@PH7PR11MB6056.namprd11.prod.outlook.com>
References: <PH7PR11MB6056EB3C6651A770BF0081699F3AA@PH7PR11MB6056.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When running UnixBench/Shell Scripts, we observed high false sharing
for accessing i_mmap against i_mmap_rwsem.

UnixBench/Shell Scripts are typical load/execute command test scenarios,
which concurrently launch->execute->exit a lot of shell commands.
A lot of processes invoke vma_interval_tree_remove which touch
"i_mmap", the call stack:
----vma_interval_tree_remove
    |----unlink_file_vma
    |    free_pgtables
    |    |----exit_mmap
    |    |    mmput
    |    |    |----begin_new_exec
    |    |    |    load_elf_binary
    |    |    |    bprm_execve

Meanwhile, there are a lot of processes touch 'i_mmap_rwsem' to acquire
the semaphore in order to access 'i_mmap'.
In existing 'address_space' layout, 'i_mmap' and 'i_mmap_rwsem' are in
the same cacheline.

The patch places the i_mmap and i_mmap_rwsem in separate cache lines
to avoid this false sharing problem.

With this patch, based on kernel v6.4.0, on Intel Sapphire Rapids
112C/224T platform, the score improves by ~5.3%. And perf c2c tool
shows the false sharing is resolved as expected, the symbol
vma_interval_tree_remove disappeared in cache line 0 after this change.

Baseline:
=================================================
      Shared Cache Line Distribution Pareto
=================================================
-------------------------------------------------------------
    0    3729     5791        0        0  0xff19b3818445c740
-------------------------------------------------------------
   3.27%    3.02%    0.00%    0.00%   0x18     0       1  0xffffffffa194403b       604       483       389      692       203  [k] vma_interval_tree_insert    [kernel.kallsyms]  vma_interval_tree_insert+75      0  1
   4.13%    3.63%    0.00%    0.00%   0x20     0       1  0xffffffffa19440a2       553       413       415      962       215  [k] vma_interval_tree_remove    [kernel.kallsyms]  vma_interval_tree_remove+18      0  1
   2.04%    1.35%    0.00%    0.00%   0x28     0       1  0xffffffffa219a1d6      1210       855       460     1229       222  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+678    0  1
   0.62%    1.85%    0.00%    0.00%   0x28     0       1  0xffffffffa219a1bf       762       329       577      527       198  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+655    0  1
   0.48%    0.31%    0.00%    0.00%   0x28     0       1  0xffffffffa219a58c      1677      1476       733     1544       224  [k] down_write                  [kernel.kallsyms]  down_write+28                    0  1
   0.05%    0.07%    0.00%    0.00%   0x28     0       1  0xffffffffa219a21d      1040       819       689       33        27  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+749    0  1
   0.00%    0.05%    0.00%    0.00%   0x28     0       1  0xffffffffa17707db         0      1005       786     1373       223  [k] up_write                    [kernel.kallsyms]  up_write+27                      0  1
   0.00%    0.02%    0.00%    0.00%   0x28     0       1  0xffffffffa219a064         0       233       778       32        30  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+308    0  1
  33.82%   34.10%    0.00%    0.00%   0x30     0       1  0xffffffffa1770945       779       495       534     6011       224  [k] rwsem_spin_on_owner         [kernel.kallsyms]  rwsem_spin_on_owner+53           0  1
  17.06%   15.28%    0.00%    0.00%   0x30     0       1  0xffffffffa1770915       593       438       468     2715       224  [k] rwsem_spin_on_owner         [kernel.kallsyms]  rwsem_spin_on_owner+5            0  1
   3.54%    3.52%    0.00%    0.00%   0x30     0       1  0xffffffffa2199f84       881       601       583     1421       223  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+84     0  1

With this change:
-------------------------------------------------------------
   0      556      838        0        0  0xff2780d7965d2780
-------------------------------------------------------------
    0.18%    0.60%    0.00%    0.00%    0x8     0       1  0xffffffffafff27b8       503       453       569       14        13  [k] do_dentry_open              [kernel.kallsyms]  do_dentry_open+456               0  1
    0.54%    0.12%    0.00%    0.00%    0x8     0       1  0xffffffffaffc51ac       510       199       428       15        12  [k] hugepage_vma_check          [kernel.kallsyms]  hugepage_vma_check+252           0  1
    1.80%    2.15%    0.00%    0.00%   0x18     0       1  0xffffffffb079a1d6      1778       799       343      215       136  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+678    0  1
    0.54%    1.31%    0.00%    0.00%   0x18     0       1  0xffffffffb079a1bf       547       296       528       91        71  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+655    0  1
    0.72%    0.72%    0.00%    0.00%   0x18     0       1  0xffffffffb079a58c      1479      1534       676      288       163  [k] down_write                  [kernel.kallsyms]  down_write+28                    0  1
    0.00%    0.12%    0.00%    0.00%   0x18     0       1  0xffffffffafd707db         0      2381       744      282       158  [k] up_write                    [kernel.kallsyms]  up_write+27                      0  1
    0.00%    0.12%    0.00%    0.00%   0x18     0       1  0xffffffffb079a064         0       239       518        6         6  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+308    0  1
   46.58%   47.02%    0.00%    0.00%   0x20     0       1  0xffffffffafd70945       704       403       499     1137       219  [k] rwsem_spin_on_owner         [kernel.kallsyms]  rwsem_spin_on_owner+53           0  1
   23.92%   25.78%    0.00%    0.00%   0x20     0       1  0xffffffffafd70915       558       413       500      542       185  [k] rwsem_spin_on_owner         [kernel.kallsyms]  rwsem_spin_on_owner+5            0  1

v1->v2: change padding to exchange fields.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Lipeng Zhu <lipeng.zhu@intel.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 133f0640fb24..4a525ed17eab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -451,11 +451,11 @@ struct address_space {
 	atomic_t		nr_thps;
 #endif
 	struct rb_root_cached	i_mmap;
-	struct rw_semaphore	i_mmap_rwsem;
 	unsigned long		nrpages;
 	pgoff_t			writeback_index;
 	const struct address_space_operations *a_ops;
 	unsigned long		flags;
+	struct rw_semaphore	i_mmap_rwsem;
 	errseq_t		wb_err;
 	spinlock_t		private_lock;
 	struct list_head	private_list;
-- 
2.39.1

