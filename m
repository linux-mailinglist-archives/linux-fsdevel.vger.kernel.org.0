Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCA14C6309
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 07:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiB1Ggg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 01:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiB1Ggf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:36:35 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E63466C8A
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 22:35:57 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 132so10584217pga.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 22:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gir+3TzfRrR4lUGuNtpX6IanjDHuvIa4YBDHCeSrYTM=;
        b=U4WTDdkDu/m+18FZjAfoYKwWYSJgf2GebNR7tlo2J5Ws/MwDCFwh7rMXQx5q917ATJ
         Jh07wWkQO93U72bllHBrmsBQ6RJEd7VhhRdaHI+FhN2hPsYXosIZbd8EpBNACQeM4TsR
         P2XJgmJ6qtHKjNspVx3ECmiH3cUlA81aFGBo2+D0pztKHxbDuNdfWP72LyPgSB/d9k6P
         qCW/oe8t2+gdYmCj3hiNeSENb3ZGV+dLl8PIq1SDghR3oQvZd6Fv5wURkt0b1Jq85RQw
         k1sfseZYkW/L04DkmzQ8tv4Odm5PA+uN9diNyRVqnxNgYOaofM2G3IPfKok2I2CG73sG
         7WYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gir+3TzfRrR4lUGuNtpX6IanjDHuvIa4YBDHCeSrYTM=;
        b=NEkNuSzCtbX1dXM3I0xuqbOqyboYfyXTT7bO3lQjlVfI6f3k/sMJfjZvJgEIN53h0t
         diU9XAIzsHpCC8jgCcdSrlKgRp5ykrI2nVGUWauLjzISORgUEcpaffsA7bjjXMP7ii6A
         8hhA45zYigToVtOnk6WLixrifCe002L+nHIThRFOlB6tUFukbz+5Wyv3HAy14/CZqOLv
         UCfrfLB5Vn1KiGPeAvWWpKl75KZKSHUWO4Npf/rxD4Dgpg7KGaVjjixtSL+CE1mSfl8A
         VEqjVpPdhHta0YlBQJza72aIsnxUu+PK9Wo6vZHYh11lL/GkEwcCwB1Cn7Hd1toffMFx
         wl1A==
X-Gm-Message-State: AOAM533mwKnGVKVWXBxdztD3U6Vw+Jb8+bzczrlRS4auF3N+Zeeo/OSn
        BDGtjzz+5S3q8PVSuQ3Bj6AVJg==
X-Google-Smtp-Source: ABdhPJwmHsIW4ie8Q+S5U3vmmxqNz17eiRrlLlRl8QPqeQV/CdrZCVTHPizyx7mRkra580xz4wWnuA==
X-Received: by 2002:a63:517:0:b0:36c:6d37:55ae with SMTP id 23-20020a630517000000b0036c6d3755aemr16179228pgf.424.1646030157059;
        Sun, 27 Feb 2022 22:35:57 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b004f13804c100sm11126472pfg.165.2022.02.27.22.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 22:35:56 -0800 (PST)
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
Subject: [PATCH v3 0/6] Fix some bugs related to ramp and dax
Date:   Mon, 28 Feb 2022 14:35:30 +0800
Message-Id: <20220228063536.24911-1-songmuchun@bytedance.com>
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
 mm/page_vma_mapped.c |  4 +--
 mm/rmap.c            | 68 +++++++++++++++++++++++++++++++++++--------
 7 files changed, 88 insertions(+), 121 deletions(-)

-- 
2.11.0

