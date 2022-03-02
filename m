Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684BE4C9F25
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 09:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbiCBI3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 03:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiCBI3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:29:48 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970BD38DA7
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 00:29:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso1139885pjo.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Mar 2022 00:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nhj2UYDv6lhlSNPLYeAs8t7voAVPXKimrviFdjCHzWM=;
        b=DApuqsEmjJNLujancfXfCthOkTnRIUPq28/r6tOxkHmRYgOlkugPPK0h8zAh8enpIU
         HfkQBBHhLbFz8qxRq7E2RLuHrElDGGUHS9Y244UdqIirJhWbIHaCrn4YF7xafhgTecpu
         x6OH95W7ts5LUCdSkrPRN+VLxTqzK7oKM7OtnhOIOVkuakDHhP+07oAY8HWOUrVKWwpS
         DnRwLDlUAcWgA1CnWdFtO0QOL8kLiRQ+vjGLe4BEgo4v9XJAX76t8Q0sNmUSx1tdL1/b
         w7Y2MRd1la+tiYmu/lVxcH6LXEof0W4BIhpWEx+hwGiQJUbmqWHEmQaFjYs8VD1Hu04i
         l7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nhj2UYDv6lhlSNPLYeAs8t7voAVPXKimrviFdjCHzWM=;
        b=QogVHgZo3r5cf3C0RqgahznKK2928lsF0uJQuo61ax95J4mmK1fITy36s7Rlry43w3
         p9qDdbnVm4NeczxQtrTIZrnZzlqlGq34gaHS6xD43YVXpMEWCCiqLceBZmMS+J4FzfJG
         ueoeRoLLukoLAPRcoFD7Jgcf1MuvEMTOUfZd9q+pzCEInaaBIT52mogK9ygvHGj5+7Co
         Le7ot7SYtjzu44cRcq8kXYLu00KnzU2cShLHiAxJCxGspKuHIG2qldUP9Ldc8L6qcPAb
         Msysaq9sAQBLgKVaKoSRaj75CcaMa1BwxNqd7HzXKLwWZzzbKJUBjsx8BN7bKFz/eKZQ
         MkXA==
X-Gm-Message-State: AOAM5337KztmTHzlzQdkAIM3SWWCisKBBQ6EMJLxNM1mr3MukVdnsASD
        bAOeXwEhnAyfkr/AQmChdcKz9A==
X-Google-Smtp-Source: ABdhPJw2Snc+gQoBgYJzFskUkuKAvbAT2RF7i6kPMEQuXqdEKU1ZjuWSi3E8iJ7UVQPqE+7d8aedhQ==
X-Received: by 2002:a17:902:e5c4:b0:151:9bf6:f47f with SMTP id u4-20020a170902e5c400b001519bf6f47fmr635388plf.110.1646209745090;
        Wed, 02 Mar 2022 00:29:05 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f396b965a9sm20922228pfv.49.2022.03.02.00.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:29:04 -0800 (PST)
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
Subject: [PATCH v4 0/6] Fix some bugs related to ramp and dax
Date:   Wed,  2 Mar 2022 16:27:12 +0800
Message-Id: <20220302082718.32268-1-songmuchun@bytedance.com>
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
  mm: remove range parameter from follow_invalidate_pte()

 fs/dax.c             | 82 +++++-----------------------------------------------
 include/linux/mm.h   |  3 --
 include/linux/rmap.h |  3 ++
 mm/internal.h        | 26 +++++++++++------
 mm/memory.c          | 23 ++-------------
 mm/page_vma_mapped.c |  5 ++--
 mm/rmap.c            | 68 +++++++++++++++++++++++++++++++++++--------
 7 files changed, 89 insertions(+), 121 deletions(-)

-- 
2.11.0

