Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A378658E11E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 22:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbiHIUbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 16:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiHIUbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:31:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58615F5A;
        Tue,  9 Aug 2022 13:31:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso49617wme.0;
        Tue, 09 Aug 2022 13:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CID0IdgrKKISQZ4HfB0HGTXjuSNTuXBArnoCKfXPU88=;
        b=G2tf2hY4EMSTX70WzcEyymWRM2qyLLMDKiMT+3y8OhMY3u5r++WoiS0Mr+SMW21sBD
         s8GtPXt4S/UANW8H1R7TDt2clSi47sMB9NhnpzKFUbS1OqGR6mMiHDliB4L361J+dkRe
         itLHz2YYdrkF5JfQK1zMYS2BhOsFT8woJfTLiDLjFHFI/OmfaI0AQvT3jvOZzDzHgkZ+
         XqoH1PPpG7MVP9ilCehYxzMmU6bYO6yqi7FSXm88ynhGue8AGrVT2zN0ytyRgaZ8AfMT
         WFMqdcWs3gUs4r71t+nTI5j/KETtZkni+s+rO2PhL7pkftjfGp5ihLA75KWev+f38RNv
         ZeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CID0IdgrKKISQZ4HfB0HGTXjuSNTuXBArnoCKfXPU88=;
        b=3qOBflKeI2IN0KYxRiL03FTysHTD1XxZR/nDaqzi+7ZMrMWTJ25PTR7LICq4Fzf9fZ
         7aUg6P3H1UnykijQ1t36b8X04Th2UsMK3yITUpi306MJB5vcrbHVWy6jmFs1J2KfCJtw
         uImlu3jobOfrkWrJjCHBPlWJqWK8oHEwOg6viQQgSQOBUclqUD2emf5XGdx5wZ8c0yER
         F7YLm/g+xqYAg21c6pC+oXGtLgDRjKi70ewkoWT7tg/Itlcg1dyZFgaVF7muT1qNGKwy
         SbYytXt71VKD9tRdWXCVRFcsP9frDNQjt6D9hTWpUi4Gp8ASuzOIh54aNmpywaYXGkWU
         dWmA==
X-Gm-Message-State: ACgBeo2/oCjV21EUKgFVYvvSrG0T31gcfPZMw3ITCz9Q0xq3XuX3KhNd
        SKOnpiCR7o4DbrIRgl2PRKU=
X-Google-Smtp-Source: AA6agR6yFpsRBNPEc8kndGMHzCjMoMILMS7EOpOXajtP5tK2hNR958Ec7yI088GsAFWJMqvP81VdWg==
X-Received: by 2002:a1c:7c18:0:b0:3a5:aaae:d203 with SMTP id x24-20020a1c7c18000000b003a5aaaed203mr144906wmc.2.1660077072088;
        Tue, 09 Aug 2022 13:31:12 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id ck15-20020a5d5e8f000000b002205f0890eesm15085263wrb.77.2022.08.09.13.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:31:10 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] hfsplus: Replace kmap() with kmap_local_page()
Date:   Tue,  9 Aug 2022 22:31:01 +0200
Message-Id: <20220809203105.26183-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
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

