Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E6258DAF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 17:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244815AbiHIPUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbiHIPUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:20:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1669CB84;
        Tue,  9 Aug 2022 08:20:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r4so15512271edi.8;
        Tue, 09 Aug 2022 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d7RRjAnxfikyHGld3/JEOYUTGHyg/fp+s+oTsQmvKsM=;
        b=mJFUov3Zs5L2e1lIAAeUAPpbxubWVshnFXJ/gkmZEbZvqevzGPVmE0vQUMfD7JNMyJ
         1o06RogzOFDpZ9yiSwK8KBdd/4+5PgsUIqvW/fkhKQ9hiDBn1KdZ7WPYm6Dq1G7cpymp
         cGJG+8gwb20Ujd7Nd7pf+MEsKA3cHpw/QPuCDbuGbwmTk52XG67JrtFQ8BItKO8+BmmT
         ggPRsthYT7NaXcje/n03y3dCFekQ4vsS7bNOwmi7IFGFyydEhMB6HsklULeI5P4TGEJJ
         E0dZlkrO5H66zBIcww8fFDML32lsSO75fCjqYM1/W8cYk9QJ/PvbGFg5O05RlzYDAxHU
         ss3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d7RRjAnxfikyHGld3/JEOYUTGHyg/fp+s+oTsQmvKsM=;
        b=llY9VL5DIFPOntk9x+cosFkZIuoDipag8guh4IdY6lWFhElr6LHw4cABHxTPxRpoj7
         OieHVbPBsB/S3J6vwvMkNHLsyd15Muvfz+U0z/edATkM4mbbNZpfSQn789P5rAIVJUoS
         5qRdQ/SWYqEBXwT/zjC79fnACjUbNl5O7/Lfn+EQF/lBc121GwtTiPiq6XSRKpG4Pf1c
         L1pBXDG13Cbw9pnEni9P7EonfUycSRLFE08pVnGjVHYTw0bg58MmSiypAv2ZUXiPKeub
         bMbR9NO5bJF+3ZGjntVIRziQzm0GxXtqJJ6O8LPL/rX0HjuxRaewhDNPvhMgsye6hPOV
         73cA==
X-Gm-Message-State: ACgBeo0Bmzqj2/LnzvwilxGFMWQ3cjapJaIoram5VBb6NSic0PxV5LZE
        8JDp6ofVoPQyvc7bvu0Hwcs=
X-Google-Smtp-Source: AA6agR6KMIDSq3gpjzh+KhgHORwDn0QAR9jl7zm4zmR3GffoLHjTDv3BFicLOLjqQTzqZ1tfCbeJew==
X-Received: by 2002:a05:6402:13c1:b0:43b:e330:9bbf with SMTP id a1-20020a05640213c100b0043be3309bbfmr21968023edx.417.1660058413451;
        Tue, 09 Aug 2022 08:20:13 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id m21-20020a170906721500b0073093eaf53esm1222162ejk.131.2022.08.09.08.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 08:20:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] hfs: Replace kmap() with kmap_local_page()
Date:   Tue,  9 Aug 2022 17:20:01 +0200
Message-Id: <20220809152004.9223-1-fmdefrancesco@gmail.com>
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

Since its use in fs/hfs is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/hfs. Where
possible, use the suited standard helpers (memzero_page(), memcpy_page())
instead of open coding kmap_local_page() plus memset() or memcpy().

Fix a bug due to a page being not unmapped if the code jumps to the
"fail_page" label (1/3).

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

Fabio M. De Francesco (3):
  hfs: Unmap the page in the "fail_page" label
  hfs: Replace kmap() with kmap_local_page() in bnode.c
  hfs: Replace kmap() with kmap_local_page() in btree.c

 fs/hfs/bnode.c | 32 ++++++++++++--------------------
 fs/hfs/btree.c | 29 ++++++++++++++++-------------
 2 files changed, 28 insertions(+), 33 deletions(-)

-- 
2.37.1

