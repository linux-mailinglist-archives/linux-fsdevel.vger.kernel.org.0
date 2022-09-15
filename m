Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378555B9B20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 14:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiIOMmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 08:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiIOMma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:42:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA419031
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 05:42:29 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y127so17932342pfy.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7R+j7wZtr6PMHfqjiv3nkV/a0UcoizsRKOwYLocOZGY=;
        b=ZcehTf+g6XANFF260jYKGNH1MHnPD/8e3qg1uMSIVbEZsbO2mQ1a91g5+kBrfmMc8D
         df95AQ58en4aIwU8Cqhuws2yBIc7M/pgkzQsOMajpAkm1AcrX8fZYCzBPukSqShDiQEc
         1HTxogrPOBliLkhrNXxnbyz2NGS3F1sXZBaPguGlVZoNAzv62yCkgrgCMWb653glMssm
         LI4nQUt6aoXUVur2AGuLWJ3JiaIgS3/mejYmAWKit/XKdLLxB9kagZBBdo0JgrPZzLvf
         PGmZj+14574uE00vgdJIuCMlXssnh0COFDE8xHpiSGmt3AE+Q77VdYews3P6Zr4tIp5n
         r9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7R+j7wZtr6PMHfqjiv3nkV/a0UcoizsRKOwYLocOZGY=;
        b=PN7p5RZTe3rNGwN2ci7QXlmKnBHBqMP0F/30Njz8CUF9TY2oMU+tLMHfZRtAiC4lEW
         oEMMjLjJgBZGa9Au3Njniuc6tl0kYSfWk+xPpFOEy9eB4XqP9/gVWMxAGPpCHlMMBbWk
         K/rnlnoksHwxa5CDiEtZX3koY0mDhMA4cRTMDG/nEVuS1EKhvgYd6pxGyI/HQj2ZH+iI
         ATUqx4XLD8xSxLjbf2RddP+jWcl/U9/7LSPZSlLd7PJLu5FBrFzTSraOaRi6zsj5eAKO
         wRtplfcWloauIbSrk6r3nNzXEmEXKgy0QyDuNHku28xl93c2MKbB1q9oEyzCXh9zVL3+
         9taA==
X-Gm-Message-State: ACgBeo2K4ytdw6lrhCeeoPzHzFEGg7NmYbPQwvhEiQkKRY/7YUT6Lx5d
        571kkeGVVD03c1wARP2jpZC4aIjI+18R3g==
X-Google-Smtp-Source: AA6agR48s/xjOTWg6C4e0X1Y+joB/hhyF2EiMG4yEQMB7vlw4rdRJ/Bd2KRlsLAK79QiVzKyVXdXEQ==
X-Received: by 2002:a05:6a00:1149:b0:53e:62c8:10bc with SMTP id b9-20020a056a00114900b0053e62c810bcmr41667054pfm.49.1663245748645;
        Thu, 15 Sep 2022 05:42:28 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001637529493esm12721906pll.66.2022.09.15.05.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:42:27 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V4 0/6] Introduce erofs shared domain
Date:   Thu, 15 Sep 2022 20:42:07 +0800
Message-Id: <20220915124213.25767-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes since V3:
1. Avoid race condition.
   1.1. Relinquish the volume before removing the domain from list. 
   1.2. Hold erofs_domain_list_lock before dec the refcnt of domain.
2. Relinquish previously registered erofs_fscache in
	erofs_fscache_domain_init_cookie()'s error handling path.
3. Some code cleanups without logic change.

[Kernel Patchset]
===============
Git tree:
	https://github.com/userzj/linux.git zhujia/shared-domain-v4
Git web:
	https://github.com/userzj/linux/tree/zhujia/shared-domain-v4

[User Daemon for Quick Test]
============================
Git web:
	https://github.com/userzj/demand-read-cachefilesd/tree/shared-domain
More test cases will be added to:
	https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests-fscache 

[E2E Container Demo for Quick Test]
===================================
[Issue]
	https://github.com/containerd/nydus-snapshotter/issues/161
[PR]
	https://github.com/containerd/nydus-snapshotter/pull/162

[Background]
============
In ondemand read mode, we use individual volume to present an erofs
mountpoint, cookies to present bootstrap and data blobs.

In which case, since cookies can't be shared between fscache volumes,
even if the data blobs between different mountpoints are exactly same,
they can't be shared.

[Introduction]
==============
Here we introduce erofs shared domain to resolve above mentioned case.
Several erofs filesystems can belong to one domain, and data blobs can
be shared among these erofs filesystems of same domain.

[Usage]
Users could specify 'domain_id' mount option to create or join into a
domain which reuses the same cookies(blobs).

[Design]
========
1. Use pseudo mnt to manage domain's lifecycle.
2. Use a linked list to maintain & traverse domains.
3. Use pseudo sb to create anonymous inode for recording cookie's info
   and manage cookies lifecycle.

[Flow Path]
===========
1. User specify a new 'domain_id' in mount option.
   1.1 Traverse domain list, compare domain_id with existing domain.[Miss]
   1.2 Create a new domain(volume), add it to domain list.
   1.3 Traverse pseudo sb's inode list, compare cookie name with
       existing cookies.[Miss]
   1.4 Alloc new anonymous inodes and cookies.

2. User specify an existing 'domain_id' in mount option and the data
   blob is existed in domain.
   2.1 Traverse domain list, compare domain_id with existing domain.[Hit]
   2.2 Reuse the domain and increase its refcnt.
   2.3 Traverse pseudo sb's inode list, compare cookie name with
   	   existing cookies.[Hit]
   2.4 Reuse the cookie and increase its refcnt.

RFC: https://lore.kernel.org/all/YxAlO%2FDHDrIAafR2@B-P7TQMD6M-0146.local/
V1: https://lore.kernel.org/all/20220902034748.60868-1-zhujia.zj@bytedance.com/
V2: https://lore.kernel.org/all/20220902105305.79687-1-zhujia.zj@bytedance.com/
V3: https://lore.kernel.org/all/20220914105041.42970-1-zhujia.zj@bytedance.com/

Jia Zhu (6):
  erofs: use kill_anon_super() to kill super in fscache mode
  erofs: code clean up for fscache
  erofs: introduce fscache-based domain
  erofs: introduce a pseudo mnt to manage shared cookies
  erofs: Support sharing cookies in the same domain
  erofs: introduce 'domain_id' mount option

 fs/erofs/fscache.c  | 253 ++++++++++++++++++++++++++++++++++++++------
 fs/erofs/internal.h |  30 ++++--
 fs/erofs/super.c    |  72 ++++++++++---
 fs/erofs/sysfs.c    |  19 +++-
 4 files changed, 317 insertions(+), 57 deletions(-)

-- 
2.20.1

