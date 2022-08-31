Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1355A7D57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiHaMcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 08:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiHaMcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:32:00 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498C1D1E14
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:31:58 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q15so8889653pfn.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ombG7QermoyUpZgeZmIaVZjDmMrCYL6rBQrF3G0foVY=;
        b=zSQ0FSkWy57Sy7IjyvRbxCrlzP0H9P73QhEFc9sf4E8opP3ffkYx+tkgzgRuqhbGYw
         iAKwLn5unY7thm2wGQZe81wR5yQwvdI3bxtCrUEOst5mRMfy529/0qfiMPxkcf1Mpi2z
         fSEjtO2WWUX8L8PWXSd6fNtU1OSLo0UF9CQ473f9yB++Wc/sv1Wh5pQPGnWvLTuVuBR3
         QczQMJaCsYxFxfLzD4GjEn8+1UdQXjXhw+33ZkTowMwHLMFJsR+eNVe4vuVbV63mJRpy
         6OSFMLdRw2pkFkQGk4+vH7MBGrGgEhKQ2NCjO6OVfsoDZAsKi3tUuxlOCn5j9FCPX0r3
         YTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ombG7QermoyUpZgeZmIaVZjDmMrCYL6rBQrF3G0foVY=;
        b=1Fzyvf9qxCITtcLZLZCxtid8QjzoHK5GtkcQcM+qZB2xcIsZiJW8xyMbfAsWF6xV8K
         JXalqrFG+cRETFSVOVXvhGEus0uG6EkH4z9umpDGcF01s+Nitz07YL4f5voHNizU3Mzc
         dyfDHIq3lZoU/lD75V5CFdMYmSSpXm/D6sDfjfQDFkK0LP8QUZQWLwduOkQuQUIlan/b
         jBv5k5CQDxGO/YOLIl099qgEVVcHEzUnaohF9rodGKzGt/yzRpZiGjFoB+hsDeGQM2ug
         KmeOxfJ2B1o0j+g2v4dl1NxIKPtrhvBtfqTEFzzBOoisUwYDGl835sKtzrSv/qXN/r1s
         SfZA==
X-Gm-Message-State: ACgBeo0xvZ1U0lpdTiYBHZmoC0RqhYZy5J6XfRPVr0S5jBIn+KOm9Q0g
        /NkM527PmQ1WjDVP9rA5Q4JA3w==
X-Google-Smtp-Source: AA6agR4spfWbHnX22P3rGo45qaymewHk53IiWwFvdv38QVAYNh20XM9p0B1NcDUd0UHatSUqXoE+mg==
X-Received: by 2002:a63:525a:0:b0:42b:28a9:8a34 with SMTP id s26-20020a63525a000000b0042b28a98a34mr21320226pgl.269.1661949117772;
        Wed, 31 Aug 2022 05:31:57 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b0016efad0a63csm11769896plf.100.2022.08.31.05.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:31:57 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [RFC PATCH 0/5] Introduce erofs shared domain
Date:   Wed, 31 Aug 2022 20:31:20 +0800
Message-Id: <20220831123125.68693-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Kernel Patchset]
===============
Git tree:
	https://github.com/userzj/linux.git zhujia/shared-domain-v1
Git web:
	https://github.com/userzj/linux/tree/zhujia/shared-domain-v1

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

[Test]
======
Git web: (More test cases will be added.)
	https://github.com/userzj/demand-read-cachefilesd/tree/shared-domain

Jia Zhu (5):
  erofs: add 'domain_id' mount option for on-demand read sementics
  erofs: introduce fscache-based domain
  erofs: add 'domain_id' prefix when register sysfs
  erofs: remove duplicated unregister_cookie
  erofs: support fscache based shared domain

 fs/erofs/Makefile   |   2 +-
 fs/erofs/domain.c   | 175 ++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/fscache.c  |  17 ++++-
 fs/erofs/internal.h |  34 ++++++++-
 fs/erofs/super.c    |  45 +++++++++---
 fs/erofs/sysfs.c    |  11 ++-
 6 files changed, 270 insertions(+), 14 deletions(-)
 create mode 100644 fs/erofs/domain.c

-- 
2.20.1

