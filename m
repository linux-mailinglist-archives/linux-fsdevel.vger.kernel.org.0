Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5AF4DD56F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 08:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiCRHsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 03:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiCRHsh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:48:37 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048332BAE5D
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 00:47:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a5so8849267pfv.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 00:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i2Kxzfqa17JeX6zvSFdcAC9AxQ0uSV/1LhJKBQM+dBo=;
        b=UaEE+RkmBrZgxg3Qvjtn9RTTC4YPIXWjUW3Bx10IPJLn++s9nnBXRZniYrNY6COzIK
         IWkHYHzSzSedHDyCgxfuemUSGpOTx5zN1JmXRIf53whpuiafHr/G2sS4UNAIPiCXouCX
         f7NU6IrexwNDdBmpVYRxBti1K01eoKRwavqtWnUNoWhKtBI3epsNz0UTwPO8TZNuRlwc
         rP7AVwj8FBWqc8Z4X6K04uw11sUXFWJGOw0tKuSKZ36JJTwHaE+ZqQywCT0hkJ+t3rCz
         dzFLUASMTSnQiZLWAimXIDIH94ns8HwpLb+C1q7OsjG3Mg72Y/9acnbkxQYG62WGtgNm
         i8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i2Kxzfqa17JeX6zvSFdcAC9AxQ0uSV/1LhJKBQM+dBo=;
        b=De3Gu91UbRPVN36rpKoqUvpkYPstazX9luGyJReuXFPGTqgezYZtwYZZKgmfoG3Wpn
         5t18ehblRSVvLGkoXJwsi035vsyioqwgH7na4OEp8t2tOAg66hky18je7lDykC10N1HH
         drGcSlcMI9JkpdaZidUvXoGBme7e+/HUhH6MhJLPgSZbPPW0knhXYiokWS+Y5b7aY+kB
         fsPeS/H1F760YaHXQWhHeo9ALIUqXfZV4hANk/nrslPo+OUauiwubRjpvMGx9+cUZl+0
         Z88q4CAjDbeXwquc0NkmLNXNPSJu8YbQf9iVMrk6F/xiNhI4nbdgGKuvEDqoaCxI0aWU
         eA7A==
X-Gm-Message-State: AOAM530Efgb9uzDukyG/xxPZgBAylF3nw+KEmbTCyY21l/izEYVxmtVP
        J+WbfFkuz/hnN0tHZlv1AOpUQw==
X-Google-Smtp-Source: ABdhPJzB6PRnA27+IVJTkfrLIjmVsbIVOijMyvlx7Btwx9xnKrLpV9UgKC2XAfpJ48RfsZJJk7x5bQ==
X-Received: by 2002:a62:684:0:b0:4f7:803:d1b0 with SMTP id 126-20020a620684000000b004f70803d1b0mr8966912pfg.10.1647589638495;
        Fri, 18 Mar 2022 00:47:18 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm8770941pfx.81.2022.03.18.00.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 00:47:18 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 0/6] Fix some bugs related to ramp and dax
Date:   Fri, 18 Mar 2022 15:45:23 +0800
Message-Id: <20220318074529.5261-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series is based on next-20220225.

Patch 1-2 fix a cache flush bug, because subsequent patches depend on
those on those changes, there are placed in this series.  Patch 3-4
are preparation for fixing a dax bug in patch 5.  Patch 6 is code cleanup
since the previous patch remove the usage of follow_invalidate_pte().

v5:
- Collect Reviewed-by from Dan Williams.
- Fix panic reported by kernel test robot <oliver.sang@intel.com>.
- Remove pmdpp parameter from follow_invalidate_pte() and fold it into follow_pte().

v4:
- Fix compilation error on riscv.

v3:
- Based on next-20220225.

v2:
- Avoid the overly long line in lots of places suggested by Christoph.
- Fix a compiler warning reported by kernel test robot since pmd_pfn()
  is not defined when !CONFIG_TRANSPARENT_HUGEPAGE on powerpc architecture.
- Split a new patch 4 for preparation of fixing the dax bug.

Muchun Song (6):
  mm: rmap: fix cache flush on THP pages
  dax: fix cache flush on PMD-mapped pages
  mm: rmap: introduce pfn_mkclean_range() to cleans PTEs
  mm: pvmw: add support for walking devmap pages
  dax: fix missing writeprotect the pte entry
  mm: simplify follow_invalidate_pte()

 fs/dax.c             | 82 +++++-----------------------------------------------
 include/linux/mm.h   |  3 --
 include/linux/rmap.h |  3 ++
 mm/internal.h        | 26 +++++++++++------
 mm/memory.c          | 81 +++++++++++++++------------------------------------
 mm/page_vma_mapped.c | 16 +++++-----
 mm/rmap.c            | 68 +++++++++++++++++++++++++++++++++++--------
 7 files changed, 114 insertions(+), 165 deletions(-)

-- 
2.11.0

