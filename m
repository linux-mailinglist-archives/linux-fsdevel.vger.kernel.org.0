Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE684EAEBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 15:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbiC2NvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 09:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiC2NvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:51:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB6731368
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 06:49:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so2919879pjf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdqwlImXrfao84vCHBrZYdsfDtapi0otjvjw/TD7gAs=;
        b=iqmBctwaR3RnMvlGbfAY9TefMgdpgPs5uTFnScOMAg7WCye0WWGUkpPFAhBNOx6r7X
         7xbZLOsB1kf93MKkXiauUeHte6cMJQCWg8asM67oms0HaCmzDyQIXBOb84j+6oJthZNW
         NGw3IQOqZD0a3q/6QqOXLCTkJC5iXA/i1gb4icEhNapcEGT4XYNP3m4EWTCdI4dHz2Vk
         wyxu0v8qqP24AnkXN9DxEJdRfba89K846CIvOrB94f/L5wC4PKYmrr+1/BcyhjNlHdlT
         7YOMNiaENUWkeJEkji8G+ikHaeuCX17BWmjKWjOjM4F5ReBHm5idgE8oiFkBuBnH1aXZ
         yk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdqwlImXrfao84vCHBrZYdsfDtapi0otjvjw/TD7gAs=;
        b=mIkt6lpZDVsx3/DdGSGoprZrPE1Fpx2QhHWGcc0Frx7tptHWbTeDe706+SU3BhSFp1
         XqymZBh/M110zZM4s9jCbzfRUoPSYzHluPbNPDj+kIWHf0y+c/tG7KmmnkGCDGe+TQUj
         8mvPtiIQeZtyV6izMkP6DcXJg7kfvv3lNxP//cDpthflny70P4qJdMfW87RULf8GNT1l
         Bdp0rZqlETXJdI3vmbCTb+sL/PUZBPEG6qwtqa3N2d6mQofmKx5D+vsLZ5FFtAHmjydD
         LKst0zZ/swq7Nr4J1/F0NxgBGXNWXWWhKVB7R6kZo1cjyZNRfT6NKMnCZVjyIrNxfgdW
         ElBA==
X-Gm-Message-State: AOAM53191QV8FlQpnhi0Y12RTfWaxVsM9Y9BVYV0dEsI/+GOMmGb8Ix9
        PNgY2N6eK76fqiSJGePimNbJlQ==
X-Google-Smtp-Source: ABdhPJxpMRY/A3rB7g8dnvTTe8NY23xQXPqq1uhJ9JnzOsx7Vi++6ue4mirhtJluGTHkVJDk33bdkA==
X-Received: by 2002:a17:902:e5cc:b0:154:1c96:2e5b with SMTP id u12-20020a170902e5cc00b001541c962e5bmr30655333plf.94.1648561774945;
        Tue, 29 Mar 2022 06:49:34 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id o14-20020a056a0015ce00b004fab49cd65csm20911293pfu.205.2022.03.29.06.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:49:34 -0700 (PDT)
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
Subject: [PATCH v6 0/6] Fix some bugs related to ramp and dax
Date:   Tue, 29 Mar 2022 21:48:47 +0800
Message-Id: <20220329134853.68403-1-songmuchun@bytedance.com>
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
 mm/page_vma_mapped.c | 16 ++++-----
 mm/rmap.c            | 68 +++++++++++++++++++++++++++++-------
 7 files changed, 119 insertions(+), 176 deletions(-)

-- 
2.11.0

