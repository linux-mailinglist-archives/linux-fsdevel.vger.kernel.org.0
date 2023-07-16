Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1D8754F18
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGPOue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 10:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGPOud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 10:50:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAD61A1;
        Sun, 16 Jul 2023 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689519032; x=1721055032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7FhqY0BU1HUaPgWFw91cagayl/GC8Rb31al0fZzyCk=;
  b=hMbRwrrSTEIfTnLM5butoN/wWJl63bi8zfiTVRBBX/7pSfpTi2n8c4Hf
   /zjQYvH9ZHcT8WZzWED7TsAJrBIsRXPB/Vi4HPplIUiHH/YuSyCN6fw6O
   Pmo8xjD2n3DmG9WjMoEunCO5T8E5zO1OP0jw4bpHey70cq4OZn0YVQzmg
   VKt7U4Yd7ZgUPZRxLpOYVlydDsb6sJ9bfyCwkVEN2km+X1j0Qcy2dxjrp
   BoEQVzJQ7XfFYzuJ46rDeWmRJpATAA3EQfNmGx+eGIHP6vlSzT5BNxRo4
   suTC9bXQ17nRmH/XW40vXCMbeYCp1Q8xJQQyaT3DEwURz15khlPJ3czpc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="365804113"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="365804113"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 07:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="792955221"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="792955221"
Received: from linux-pnp-server-30.sh.intel.com ([10.239.146.163])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2023 07:50:29 -0700
From:   "Zhu, Lipeng" <lipeng.zhu@intel.com>
To:     lipeng.zhu@intel.com
Cc:     akpm@linux-foundation.org, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pan.deng@intel.com, tianyou.li@intel.com,
        tim.c.chen@linux.intel.com, viro@zeniv.linux.org.uk,
        yu.ma@intel.com
Subject: [PATCH v2] fs/address_space: add alignment padding for i_map and i_mmap_rwsem to mitigate a false sharing.
Date:   Sun, 16 Jul 2023 22:54:51 +0800
Message-Id: <20230716145450.20108-1-lipeng.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <PH7PR11MB6056EB3C6651A770BF0081699F3AA@PH7PR11MB6056.namprd11.prod.outlook.com>
References: <PH7PR11MB6056EB3C6651A770BF0081699F3AA@PH7PR11MB6056.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

