Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BA0740F66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 12:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjF1K4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 06:56:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:49747 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbjF1K4J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687949769; x=1719485769;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WgvMUlURPSf3sLuU7HCU3MKlq0fqlttjYS4ABXRfEVQ=;
  b=Y90y69hPrFYoOqMjI9eJ8AsbNrP/Aq8IAbd69Qq0vkOzDN1NKw41XtON
   6jDtuZKkb5SIayYcCXPniQCtBn7DxRBAPvmBKztsZjhBOsa++vZItplTn
   O3sg6R02MA2qqcOgAz6rufTjgBWdpg9B/cyrzZlyQNTiOZaRG31x10h8V
   xiFi01iELfT5Ms3Up6WgbRvir93gEQ4KZThSN3PMLrPvM6tfzGO3z5uGP
   Wjmkh2ucwPLFatPJHQPnxfVnRdh5++5N72H9clCvkH2BDhxDle6uGYjVJ
   EyXlmei1Yz9OYVIh98kfUIaYJeMmRDr2dC+vEQnSJGHJokun/hFWvFqyd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427818562"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="427818562"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 03:54:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="752196704"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="752196704"
Received: from linux-pnp-server-30.sh.intel.com ([10.239.146.163])
  by orsmga001.jf.intel.com with ESMTP; 28 Jun 2023 03:54:27 -0700
From:   "Zhu, Lipeng" <lipeng.zhu@intel.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pan.deng@intel.com, yu.ma@intel.com,
        tianyou.li@intel.com, tim.c.chen@linux.intel.com,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>
Subject: [PATCH] fs/address_space: add alignment padding for i_map and i_mmap_rwsem to mitigate a false sharing.
Date:   Wed, 28 Jun 2023 18:56:25 +0800
Message-Id: <20230628105624.150352-1-lipeng.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When running UnixBench/Shell Scripts, we observed high false sharing
for accessing i_mmap against i_mmap_rwsem.

UnixBench/Shell Scripts are typical load/execute command test scenarios,
the i_mmap will be accessed frequently to insert/remove vma_interval_tree.
Meanwhile, the i_mmap_rwsem is frequently loaded. Unfortunately, they are
in the same cacheline.

The patch places the i_mmap and i_mmap_rwsem in separate cache lines to avoid
this false sharing problem.

With this patch, on Intel Sapphire Rapids 2 sockets 112c/224t platform, based
on kernel v6.4-rc4, the 224 parallel score is improved ~2.5% for
UnixBench/Shell Scripts case. And perf c2c tool shows the false sharing is
resolved as expected, the symbol vma_interval_tree_remove disappeared in
cache line 0 after this change.

Baseline:
=================================================
      Shared Cache Line Distribution Pareto
=================================================
  -------------------------------------------------------------
      0    13642    19392     9012       63  0xff1ddd3f0c8a3b00
  -------------------------------------------------------------
    9.22%    7.37%    0.00%    0.00%    0x0     0       1  0xffffffffab344052       518       334       354     5490       160  [k] vma_interval_tree_remove    [kernel.kallsyms]  vma_interval_tree_remove+18      0  1
    0.71%    0.73%    0.00%    0.00%    0x8     0       1  0xffffffffabb9a21f       574       338       458     1991       160  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+655    0  1
    0.52%    0.71%    5.34%    6.35%    0x8     0       1  0xffffffffabb9a236      1080       597       390     4848       160  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+678    0  1
    0.56%    0.47%   26.39%    6.35%    0x8     0       1  0xffffffffabb9a5ec      1327      1037       587     8537       160  [k] down_write                  [kernel.kallsyms]  down_write+28                    0  1
    0.11%    0.08%   15.72%    1.59%    0x8     0       1  0xffffffffab17082b      1618      1077       735     7303       160  [k] up_write                    [kernel.kallsyms]  up_write+27                      0  1
    0.01%    0.02%    0.08%    0.00%    0x8     0       1  0xffffffffabb9a27d      1594       593       512       53        43  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+749    0  1
    0.00%    0.01%    0.00%    0.00%    0x8     0       1  0xffffffffabb9a0c4         0       323       518       97        74  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+308    0  1
   44.74%   49.78%    0.00%    0.00%   0x10     0       1  0xffffffffab170995       609       344       430    26841       160  [k] rwsem_spin_on_owner         [kernel.kallsyms]  rwsem_spin_on_owner+53           0  1
   26.62%   22.39%    0.00%    0.00%   0x10     0       1  0xffffffffab170965       514       347       437    13364       160  [k] rwsem_spin_on_owner         [kernel.kallsyms]  rwsem_spin_on_owner+5            0  1

With this change:
  -------------------------------------------------------------
      0    12726    18554     9039       49  0xff157a0f25b90c40
  -------------------------------------------------------------
    0.90%    0.72%    0.00%    0.00%    0x0     1       1  0xffffffffa5f9a21f       532       353       461     2200       160  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+655    0  1
    0.53%    0.70%    5.16%    6.12%    0x0     1       1  0xffffffffa5f9a236      1196       670       403     4774       160  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+678    0  1
    0.68%    0.51%   25.91%    6.12%    0x0     1       1  0xffffffffa5f9a5ec      1049       807       540     8552       160  [k] down_write                  [kernel.kallsyms]  down_write+28                    0  1
    0.09%    0.06%   16.50%    2.04%    0x0     1       1  0xffffffffa557082b      1693      1351       758     7317       160  [k] up_write                    [kernel.kallsyms]  up_write+27                      0  1
    0.01%    0.00%    0.00%    0.00%    0x0     1       1  0xffffffffa5f9a0c4       543         0       491       89        68  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+308    0  1
    0.00%    0.01%    0.02%    0.00%    0x0     1       1  0xffffffffa5f9a27d         0       597       742       45        40  [k] rwsem_down_write_slowpath   [kernel.kallsyms]  rwsem_down_write_slowpath+749    0  1
   49.29%   53.01%    0.00%    0.00%    0x8     1       1  0xffffffffa5570995       580       310       413    27106       160  [k] rwsem_spin_on_owner         [kernel.kallsyms]  rwsem_spin_on_owner+53           0  1
   28.60%   24.12%    0.00%    0.00%    0x8     1       1  0xffffffffa5570965       490       321       419    13244       160  [k] rwsem_spin_on_owner         [kernel.kallsyms]  rwsem_spin_on_owner+5            0  1

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Lipeng Zhu <lipeng.zhu@intel.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..d3dd8dcc9b8b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -434,7 +434,7 @@ struct address_space {
 	atomic_t		nr_thps;
 #endif
 	struct rb_root_cached	i_mmap;
-	struct rw_semaphore	i_mmap_rwsem;
+	struct rw_semaphore	i_mmap_rwsem ____cacheline_aligned_in_smp;
 	unsigned long		nrpages;
 	pgoff_t			writeback_index;
 	const struct address_space_operations *a_ops;
-- 
2.39.1

