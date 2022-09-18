Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D72C5BBB9F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Sep 2022 06:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIREfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 00:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIREfF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 00:35:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218B613D5E
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 21:35:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso3140595pjm.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 21:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=i1zDof6OtvGZP5SPndoQ1fuuVqZzAR4cxcPoesi3UZQ=;
        b=LXQbGXSnCu1RB9u7uebnc9Z0LaBzCWIEB/4qpF887O03nW02QEWF/azLZaiU9xfarr
         9deDlOP6adhCM/Y58+MSjvXnuN4LLdvpncUTRoyxPgwWyzey9uarYsrh+RjQtNo5Di3y
         nyhWnSubU15bSHOrKdQRtjLObKZioWl7yL/PiueXpSk9E4p2bwNp8H+EQV3OvM+WwmVW
         MTx3KaNpaWGtmCasoChP+CJi57On5fQlVyXp5KEgKIaQDRunYMe5iBqypbiqqosI7A6D
         L7qqd+2LcmLRs+vz8DSlZ64bpppcmXyFbhQGreAZO75DNBqtlm9NqOa85jeTc3g4Xlq6
         XFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=i1zDof6OtvGZP5SPndoQ1fuuVqZzAR4cxcPoesi3UZQ=;
        b=Eucn5JzNvPqvRHgfR6Sszgj53TyeJWYCZ2X2Tq2Wo888+h8R8n7cGY392/5ycaw6UQ
         sEXi4PO3ARyGlIzFtPSvu0EgMQTc7BAneNpucH1RAgCprWyY8miEs58mlD+4uwxU4jy7
         qKpMqps4IBR7atqxQBzkp8SeArmyidZDVjiAt9W0grjmRFlA/wBU5rnF/Hie+m8dCqCf
         d1PL+Xk4A7JC/Atej1QdQFonSEvz/nEkONVNx4NEglZOCUXf/ptPselfwhPpKf1c9sZ8
         Qe0pmdNtBV0z18BRvZx1r3A0R5BQvHg0brhVrPkzeOD870NMEAMuO75gh6U2Dgu/NMJg
         QNSg==
X-Gm-Message-State: ACrzQf1r+PR7CYeZa9K1IEaOHtE8y1VmrbjrtEEFDCtOuMFZEmPtyrZC
        9S6TofbYM/zfJq/ncZC1XoqaailgvsInDi5d
X-Google-Smtp-Source: AMsMyM57wriUwliO2AXNIEA0PUT6e6XYJXVTf8ub390eTWLi8xe1z7AMtFfvlz6UW/1FyXxKosxPRA==
X-Received: by 2002:a17:90a:e60d:b0:201:6b28:5406 with SMTP id j13-20020a17090ae60d00b002016b285406mr23615945pjy.228.1663475703591;
        Sat, 17 Sep 2022 21:35:03 -0700 (PDT)
Received: from localhost.localdomain ([111.201.134.95])
        by smtp.gmail.com with ESMTPSA id l63-20020a622542000000b0054b5239f7fesm3955248pfl.210.2022.09.17.21.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 21:35:03 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V6 0/6] Introduce erofs shared domain
Date:   Sun, 18 Sep 2022 12:34:50 +0800
Message-Id: <20220918043456.147-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Kernel Patchset]
===============
Git tree:
	https://github.com/userzj/linux.git zhujia/shared-domain-v6
Git web:
	https://github.com/userzj/linux/tree/zhujia/shared-domain-v6

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
V4: https://lore.kernel.org/all/20220915124213.25767-1-zhujia.zj@bytedance.com/
V5: https://lore.kernel.org/all/20220916085940.89392-1-zhujia.zj@bytedance.com/

Jia Zhu (6):
  erofs: use kill_anon_super() to kill super in fscache mode
  erofs: code clean up for fscache
  erofs: introduce fscache-based domain
  erofs: introduce a pseudo mnt to manage shared cookies
  erofs: Support sharing cookies in the same domain
  erofs: introduce 'domain_id' mount option

 fs/erofs/fscache.c  | 263 ++++++++++++++++++++++++++++++++++++++------
 fs/erofs/internal.h |  32 ++++--
 fs/erofs/super.c    |  73 +++++++++---
 fs/erofs/sysfs.c    |  19 +++-
 4 files changed, 324 insertions(+), 63 deletions(-)

-- 
2.20.1

