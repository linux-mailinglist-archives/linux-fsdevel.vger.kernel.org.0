Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5ED359B5CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 20:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiHUSKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 14:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHUSKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:10:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB5A1F610;
        Sun, 21 Aug 2022 11:10:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w19so17373242ejc.7;
        Sun, 21 Aug 2022 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=L12r2miMmRENnE3qrJCDishyANVg+HH0YJBgFOticpo=;
        b=QVvG4ZpKaZbeDCe7fJOeF4CirRa5XybStrjHo6YRcMe4DVb7aoV/EH4RRnllP228ml
         QtLSaJ2MvEISXovgt8+694LQzGa+dXQOx/pMt4LQXranRXyZBB8nbVsdo0q1X8Srf+kH
         G1V3Hs7i3udVltFPsrkiGetVQ8ZN1fPVJVnbt/YNRq73h8ugy08/UX4jgSG2p7mFS1Dl
         Lth1/FJs77/k2lmV2gud+BA2EKRZHJqPdRGaGPB1SuTS5CDlfugNPUN9/jOWwURj+2De
         cH5JnbR9GXgSvMiya905Ak0g/CThJt0jjXHafi6o3KRWlp9juDbHyV/NUR+kN7eP0dU7
         eFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=L12r2miMmRENnE3qrJCDishyANVg+HH0YJBgFOticpo=;
        b=nwbgi8Ur+98l63WL+EFUDS8WBZ6HUAnbrrwmWL8HAWlN+/pUVEleX4U/8OK4yX1ycU
         Jq0eTUzl3pDo3lSqgT3LWd1ZFB55ISkvv85JjEaNY1dfkBFEaJYyeBp/EkELSjWCLbNO
         5PRGw5Ct7ifUMKpQgvj7FFkfpGuLUXeTUu3cHgYxceEXTPhNR0r56Pe7wPE/DqpFiv4l
         g8wFQAcz6thMeQRQs7IgDzIdbrLGrRYeAaFKjmgJ+W0Xksj5IkBS0j8XP71w3qBHHFZ1
         oyem5UEbELPTJ5utBLbYoUX1lthbqSQ0iYKsR+J3lStK132hmbBfRYXrK/C1OOCMyXFk
         6wYA==
X-Gm-Message-State: ACgBeo1wiaX1+X39f8ANbAezuP2IE4M2Mp6Nlv7yd8YIeX4kqeLqbtIR
        b88rdmQqMEyLL+T/uBOJ7H0=
X-Google-Smtp-Source: AA6agR6QVKRy4SVBb5ka331ynHVLGNwBGQNlDh+xze5rbwaS6JCk9rmmOl6oIenXDC220A6idg6pyA==
X-Received: by 2002:a17:906:98d4:b0:73d:7f33:98a8 with SMTP id zd20-20020a17090698d400b0073d7f3398a8mr1373581ejb.90.1661105450231;
        Sun, 21 Aug 2022 11:10:50 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id g12-20020a056402114c00b004404e290e7esm6854178edw.77.2022.08.21.11.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:10:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jeff Layton <jlayton@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [RESEND PATCH 0/4] hfsplus: Replace kmap() with kmap_local_page()
Date:   Sun, 21 Aug 2022 20:10:41 +0200
Message-Id: <20220821181045.8528-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as 
mapping space is restricted and protected by a global lock for 
synchronization and (2) it also requires global TLB invalidation when the 
kmap’s pool wraps and it might block when the mapping space is fully 
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in fs/hfsplus is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/hfsplus. Where
possible, use the suited standard helpers (memzero_page(), memcpy_page())
instead of open coding kmap_local_page() plus memset() or memcpy().

Fix a bug due to a page being not unmapped if the code jumps to the
"fail_page" label (1/4).

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

Some days ago Andrew requested a resend of this series. In the meantime
I'm also forwarding a "Reviewed-by" tag from Viacheslav Dubeyko.

Fabio M. De Francesco (4):
  hfsplus: Unmap the page in the "fail_page" label
  hfsplus: Convert kmap() to kmap_local_page() in bnode.c
  hfsplus: Convert kmap() to kmap_local_page() in bitmap.c
  hfsplus: Convert kmap() to kmap_local_page() in btree.c

 fs/hfsplus/bitmap.c |  20 ++++-----
 fs/hfsplus/bnode.c  | 105 ++++++++++++++++++++------------------------
 fs/hfsplus/btree.c  |  27 ++++++------
 3 files changed, 72 insertions(+), 80 deletions(-)

-- 
2.37.1

