Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EBE6BFEAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 01:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCSAdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 20:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCSAdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 20:33:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3057132CF;
        Sat, 18 Mar 2023 17:32:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z21so34013796edb.4;
        Sat, 18 Mar 2023 17:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679185928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oBdvoOvvbPl4lveIHMcEslRaUIrEiN+QjBIu6nhpMoI=;
        b=N5eLnzAVbZmL/4cbCNMTLe2G3qFwhJzToVV6VQZv3lddLSgRPanEVgyyT0Goc86oTE
         MKHvwnFGbvI+YH/LxlVMvVhu4LvlPLH6uX4KHpEAJ+p3L8dKZL/2GIffw02Cnm2QgLBM
         yptEf3knmoAXeFJuGlBlcK8g0ZciHB0KqNhsEeSNXa7UWEcW54Wyp10bcZsNCY90KexY
         Pz/tHJcsE6u7bVK3ZF4g2i19kBgQv3tjpAZxs3SHW4D+k6ekWZwW9kKZtyBWASqPZQG5
         vP7fBqVzr5r8qtiESFqvCy5OueK8KEYuLmRzjaiDvUqOG3xx8w0exFYMrK6dnxWCLsXR
         oZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679185928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBdvoOvvbPl4lveIHMcEslRaUIrEiN+QjBIu6nhpMoI=;
        b=oZfHu+Lf5knKAQrBnLEKpTVE8gXaC7urQA22Kno4KMpZoM9PORGhye1ortQjFgxU7A
         Agc2x3fDAa/NHNYUoFR1qnYweHZBxLDeaqJtTPLN8yqfw56nVHBKDYVAPzDu/A3Vi7hL
         MhMLSGhM5TF+0A5WbzZScGC51IIWLAm1WHNM8NQ/x5rofRo5VKKflLgvWMLJgWmbqZ5V
         Ez17lBwLMEq2wYFNbHqnxtWZOAlz04W+R3hdnr64tXDOTAUcxILdEfbiNggl/PuKuu19
         5rvpVOTmVPr8lPgIkCn9y0i5zxFVlcu/+qwkvvmd7RS2mABS1Cjweu1BSCV65jAzJSV/
         p6BA==
X-Gm-Message-State: AO0yUKV55acBxeKlgCiOZKYdi/rxgSTLdbFHtHsJJ6KXkRBp9U1RaDhv
        VQ1ZUQfeMCEg4L0A4y5GYgY2HhQoNzw=
X-Google-Smtp-Source: AK7set9YsshU0VAPpOI+4C85JEEyd1pQ0Y7jXTJ+bnt0arMtIaqwA6i93AcsSdqs0lXaAFCI3eV+5g==
X-Received: by 2002:a05:6000:110a:b0:2ce:a93d:41a7 with SMTP id z10-20020a056000110a00b002cea93d41a7mr10132635wrw.40.1679185215658;
        Sat, 18 Mar 2023 17:20:15 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id x14-20020adfdd8e000000b002cff0c57b98sm5399639wrl.18.2023.03.18.17.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 17:20:14 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 0/4] convert read_kcore(), vread() to use iterators
Date:   Sun, 19 Mar 2023 00:20:08 +0000
Message-Id: <cover.1679183626.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While reviewing Baoquan's recent changes to permit vread() access to
vm_map_ram regions of vmalloc allocations, Willy pointed out [1] that it
would be nice to refactor vread() as a whole, since its only user is
read_kcore() and the existing form of vread() necessitates the use of a
bounce buffer.

This patch series does exactly that, as well as adjusting how we read the
kernel text section to avoid the use of a bounce buffer in this case as
well.

This patch series necessarily changes the locking used in vmalloc, however
tests indicate that this has very little impact on allocation performance
(test results are shown in the relevant patch).

This has been tested against the test case which motivated Baoquan's
changes in the first place [2] which continues to function correctly, as
do the vmalloc self tests.

[1] https://lore.kernel.org/all/Y8WfDSRkc%2FOHP3oD@casper.infradead.org/
[2] https://lore.kernel.org/all/87ilk6gos2.fsf@oracle.com/T/#u

Lorenzo Stoakes (4):
  fs/proc/kcore: Avoid bounce buffer for ktext data
  mm: vmalloc: use rwsem, mutex for vmap_area_lock and vmap_block->lock
  fs/proc/kcore: convert read_kcore() to read_kcore_iter()
  mm: vmalloc: convert vread() to vread_iter()

 fs/proc/kcore.c         |  84 +++++++------------
 include/linux/vmalloc.h |   3 +-
 mm/vmalloc.c            | 178 +++++++++++++++++++++-------------------
 3 files changed, 125 insertions(+), 140 deletions(-)

--
2.39.2
