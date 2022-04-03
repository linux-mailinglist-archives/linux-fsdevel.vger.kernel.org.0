Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63004F07CE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Apr 2022 07:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbiDCFnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Apr 2022 01:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiDCFnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:43:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A23033E92
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Apr 2022 22:41:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so8657109pjb.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Apr 2022 22:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wvujdoj+rXf8TntjDreBsLKKbh2J4gp+Ud8xZlie1p0=;
        b=TCwPLuOIkV9+38cDLkpS9nuHTn65VZXSagGE6TWoOmUkruIu5+qF3NuNmWAfItBIZD
         sXdedXicM713G2Gaq+ubx4DWik03Qcj/3gAF0jV7yUwqCGnR/cGdjiNUTr5HBiMoaWBL
         l5HMCf7TtzZK2fclBrR9rIhfV7zRzydnFm0chT0bjmPlqWlnmz3pul9UnvWP7EAVQBK9
         fgIeSdi7V8f0YcbmyjkPmQRNFerDaidkAzMo5vRBGQcwx+qxsDNJPpCWnY8wbDTmNV1j
         f9YLHSrBCv8R2lu/h1BrOd9a342SdGQ7Ase0xNRvLlS+K3/Kjnk33gdqXgNMhoNeZrLX
         T9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wvujdoj+rXf8TntjDreBsLKKbh2J4gp+Ud8xZlie1p0=;
        b=Eio2XKS7W6DswqElVThyNflmblU6hdWbXHmwNN8kIZP6t5+ljsS2M2q0+41k13LFd3
         db4QumkVCt1722tvIrcUiJNJydVpWkppqPlk/4O0mtP/Wg3F4L1Y7sFJrbq8k4RxAaWi
         /6vE7F+6dmhmBZHzEYsX7rUIPNXcR96/F++fugfisQRgmX2OU8EyF8j6Ej2z2Jab1Hd/
         yzQeOw6cFW/cDYoKw5x6873I+sY7mPDg+DK4VpGVhoKFlc59AriLb52Fgy2xuLgI+GOu
         CUgN+JzIfGRBmggl/KTqPPvx5f3Yewy9MISMg9ViLvdypB6hPctW2vxWWcndfN2LsNMz
         xOgw==
X-Gm-Message-State: AOAM532X9d77yFyb6wVHvCDpUS/HgOBzYpgK3ORUJiaEn3cknUC1FKVJ
        EgTJviCuoQpj1Swc+0zSDEoxdw==
X-Google-Smtp-Source: ABdhPJyUkVA34KXhqdWAtjVviE8uqiNT/qpXOuafZYF1Nio1ft2L3/3huAbiQqZd1DwmC0Hw+XJQHQ==
X-Received: by 2002:a17:90b:3447:b0:1c6:fe01:675c with SMTP id lj7-20020a17090b344700b001c6fe01675cmr19568783pjb.59.1648964469978;
        Sat, 02 Apr 2022 22:41:09 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm8262479pfx.34.2022.04.02.22.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 22:41:09 -0700 (PDT)
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
Subject: [PATCH v7 0/6] Fix some bugs related to ramp and dax
Date:   Sun,  3 Apr 2022 13:39:51 +0800
Message-Id: <20220403053957.10770-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

v7:
- Remove redurant "*" above vma_address() reported by Christoph.
- Fix oops (reported by Qian) on arm64 by using "pmd_present() && pmd_devmap()"
  to workaround the bug in pmd_leaf() on arm64, which is fixed in another
  patch [1].

[1] https://lore.kernel.org/all/20220403024928.4125-1-songmuchun@bytedance.com/

v6:
- Collect Reviewed-by from Christoph Hellwig.
- Fold dax_entry_mkclean() into dax_writeback_one().

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

 fs/dax.c             | 98 +++++++---------------------------------------------
 include/linux/mm.h   |  3 --
 include/linux/rmap.h |  3 ++
 mm/internal.h        | 26 +++++++++-----
 mm/memory.c          | 81 ++++++++++++-------------------------------
 mm/page_vma_mapped.c | 17 ++++-----
 mm/rmap.c            | 68 +++++++++++++++++++++++++++++-------
 7 files changed, 120 insertions(+), 176 deletions(-)

-- 
2.11.0

