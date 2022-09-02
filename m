Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3695AACD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 12:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiIBKyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 06:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIBKyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:54:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8178CC8892
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Sep 2022 03:54:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q3so1662783pjg.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Sep 2022 03:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=vT4GD3+/0MzbbBEdOSGt98w+JvqU9hw4JCyFBULPEdA=;
        b=5RX14LCU/zE20jlyYS+jNVKQQY9uCRNuM5U94KDBQRnMPdv/BHlAUQKGHnpHxtYgPt
         YUC3gSidU4Ur8dKx1aE1Q39Pl1kU0Sc9F350a4+d8tRlMnGjCwrjlp1fF9xb38kQpzK4
         8rVNcFKvZdeU+5qqa1gtZoz4qq91WYBrw0clTb3l1kCU1RENsFuy+cZRf6m82kjXwxH+
         fUXq4nkVHXTHH8R/i1iasX0iwxtcQi1zp+kB8DAVoxpEI3K2+pNNvY8eGKO/Twl+mR0j
         VUk9OQDPCA2VSsoVmrc3o1F7PJLe/9cWfIiIml7/qFkWRTI3tDGFFDFhGZiPcXR8J/1F
         N9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vT4GD3+/0MzbbBEdOSGt98w+JvqU9hw4JCyFBULPEdA=;
        b=K/wOOlQV6x3qPO/ernol6cC90KdQndtJFdVyGF2sagOQRmgqbJ2u8m8ottj/yeCbdT
         X7rptFlUhqMvFiq4adtRZni5ms0vforgGPY0ahUkrMNKCovRM9CFOW0qh9vQ4anj6muG
         /F62AJB2fhSmys2yVGb8SsTIL9KwFzW6wsro2d6b3eAsMTFN7F+/xMd2UpehocXHh3Xl
         zcC/V90PFnxHi7i/cDx1asff4fM+jVPSqJG0weOHoy3t3j10emjT4Nyj+8vE4goZ9VHK
         TaKTdVT74iccuosITPYiDMyENJeJXMduQaXm/qW1JMOEelIM+C+epnEKGWSRidYuIs4J
         tANQ==
X-Gm-Message-State: ACgBeo3PXarq8Dm8r+AnyxYicTHWGGTDjW8Yn8iUkNAJn4SeacKUqB1X
        M11hH2+Awjk9JXqHsH7rKgZBBw==
X-Google-Smtp-Source: AA6agR6kEeWww8j05ZFcDdob4i78cy50JnfDQIPezSnmR418EyvU4bI8yHEHQdn5r9dIeRz74989RQ==
X-Received: by 2002:a17:90b:4d12:b0:1f5:59e1:994f with SMTP id mw18-20020a17090b4d1200b001f559e1994fmr4142105pjb.217.1662116047024;
        Fri, 02 Sep 2022 03:54:07 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id e4-20020a63d944000000b0041b29fd0626sm1128681pgj.88.2022.09.02.03.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 03:54:06 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V2 0/5] Introduce erofs shared domain
Date:   Fri,  2 Sep 2022 18:53:00 +0800
Message-Id: <20220902105305.79687-1-zhujia.zj@bytedance.com>
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

Changes since V1:
0. Only initialize one pseudo fs to manage anonymous inodes(cookies).
1. Remove ctx's 'ref' field and replace it with inode's i_count.
2. Add lock in erofs_fscache_unregister_cookie() to avoid race condition
   between cookie's get/put/search.
3. Remove useless blank lines.

[Kernel Patchset]
===============
Git tree:
	https://github.com/userzj/linux.git zhujia/shared-domain-v2
Git web:
	https://github.com/userzj/linux/tree/zhujia/shared-domain-v2

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
Git web:
	https://github.com/userzj/demand-read-cachefilesd/tree/shared-domain
More test cases will be added to:
	https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests-fscache 

RFC: https://lore.kernel.org/all/YxAlO%2FDHDrIAafR2@B-P7TQMD6M-0146.local/
V1: https://lore.kernel.org/all/20220902034748.60868-1-zhujia.zj@bytedance.com/


Jia Zhu (5):
  erofs: add 'domain_id' mount option for on-demand read sementics
  erofs: introduce fscache-based domain
  erofs: add 'domain_id' prefix when register sysfs
  erofs: remove duplicated unregister_cookie
  erofs: support fscache based shared domain

 fs/erofs/fscache.c  | 168 +++++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/internal.h |  31 +++++++-
 fs/erofs/super.c    |  94 +++++++++++++++++++------
 fs/erofs/sysfs.c    |  11 ++-
 4 files changed, 278 insertions(+), 26 deletions(-)

-- 
2.20.1

