Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337AC59B5C3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 20:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiHUSEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiHUSEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:04:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC41D1D0C1;
        Sun, 21 Aug 2022 11:04:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gt3so4936538ejb.12;
        Sun, 21 Aug 2022 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SnhFAU92/LDV9kUU3gKzxKJbWQLSKVpEjj7raxC0lig=;
        b=pQQoM5ZNU2eBoou1JQdDKcmrM7WftSjPRuErPcwrv5kp0R9G35ugATUBSJBvMwMviQ
         7boEzFWSAbPAOx2ng94W0LE1zL4FqWVshVrE1pX+85rbjUPp9WhQCmVUS0muAI4D791r
         22ss3Zbb9tABhHeg+Z3CuiZzmOmHe4i5AwN0wMzwToodJpplRckiYOUzmVxAoPWOciu6
         myvO88+dReeSS29fiCmtFdfzin2XL6Ti3cU5GHfdFHThHSIs/2Na6McZKZhwl7/Vc2vZ
         QIFJLFP2B0aeD0gxDXRNqipkoe9QfrKe0I5GXNPD8cJI8/YN3wBI7+cek0UVyo2Brxmq
         l+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SnhFAU92/LDV9kUU3gKzxKJbWQLSKVpEjj7raxC0lig=;
        b=O2Qpu/HGnGP3YCUm25si9YjTET84e2v9jgkM1+OjnvkJeNBuMoNNsw0NsiikMuARB9
         4dJLQjsghTb/yzrHcfKgnLkhetdZCpN4TWh3YBj9Ly/zD4pI9Jj9Ex2tsgYo6EqWJeP/
         zPUAxQh09DMXCF9QNx5PyQM090aoeiwLdbQ3XB18MGHa+i1Yg/Bso6vhDJF5vUWTGpOT
         ZJ4CFbEpCZgYEL/mtK0a0DLLiPrBrFpum+Dulh/GrPN+4Eoza33SAiAy/UP3aNEjjSeP
         4gubQcjCJ+DRZSDSybS13Xc0u/o5Ke2Xuo0aR1Rd4QM4vz/ydxXw8qy74yiXrH5+IvwE
         2sgg==
X-Gm-Message-State: ACgBeo2m3R8DQfeQWY1oENmnXGYDSEKCG8P9zAb0Uj4lZS5QNhCRYx8G
        lzMoiJc8wTaaPdL+t7E3SQg=
X-Google-Smtp-Source: AA6agR4Ycs0/kntvbEa1LIUVO98PPIBWCulFiH7pyO9H7OXbKYw0CXiqMdavpTj1XXS9Wul36KVCtw==
X-Received: by 2002:a17:906:84ef:b0:731:82a8:ea03 with SMTP id zp15-20020a17090684ef00b0073182a8ea03mr10837945ejb.462.1661105046132;
        Sun, 21 Aug 2022 11:04:06 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b007317f017e64sm5125916ejg.134.2022.08.21.11.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:04:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jeff Layton <jlayton@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [RESEND PATCH 0/3] hfs: Replace kmap() with kmap_local_page()
Date:   Sun, 21 Aug 2022 20:03:57 +0200
Message-Id: <20220821180400.8198-1-fmdefrancesco@gmail.com>
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

Since its use in fs/hfs is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/hfs. Where
possible, use the suited standard helpers (memzero_page(), memcpy_page())
instead of open coding kmap_local_page() plus memset() or memcpy().

Fix a bug due to a page being not unmapped if the code jumps to the
"fail_page" label (1/3).

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

Few days ago Andrew requested a resend of this series. In the meantime
I'm also forwarding a "Reviewed-by" tag from Viacheslav Dubeyko.

Fabio M. De Francesco (3):
  hfs: Unmap the page in the "fail_page" label
  hfs: Replace kmap() with kmap_local_page() in bnode.c
  hfs: Replace kmap() with kmap_local_page() in btree.c

 fs/hfs/bnode.c | 32 ++++++++++++--------------------
 fs/hfs/btree.c | 29 ++++++++++++++++-------------
 2 files changed, 28 insertions(+), 33 deletions(-)

-- 
2.37.1

