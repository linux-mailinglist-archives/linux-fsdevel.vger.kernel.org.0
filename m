Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F51A50AC62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 01:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442764AbiDUXvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 19:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382719AbiDUXvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:51:35 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C358142A1E;
        Thu, 21 Apr 2022 16:48:44 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b68so4762427qkc.4;
        Thu, 21 Apr 2022 16:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ko8zqzAqB5d7Fp7/0nrVZqCAzIhr0lHUR/A88GtSC5Y=;
        b=l/ioLSQ7oxcjJ9u8NsnHiqZPtzEN+z8iGG+o0oNfhiiMiOXiAuZzcp7vQnEePNJvC+
         w/1gcURYIodnzeYoD1kJKdI2E7pOPxGi1va15M8dqAY4QEBmmqVmcpHuWsi08au3mkDh
         hQSvOp6j2c5lKyQC0aot6CozNEgkASj6T+3gz5oT3Z9DLMzIo2+wh5KDW6bMHRJZq5j3
         8X7BScCJYwqmQVMbeQqf8kAVPG5N+Hp2uAD/0tno65hdX/MDv+OFx9vWsrUvsz2Eerw8
         IJuUDW+0j1gSbv3eCX+5wbbHD4egps6W+ZQ02zLqJX0fvm3ZWnmwYItO0fGtTd+oG1YT
         1nhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ko8zqzAqB5d7Fp7/0nrVZqCAzIhr0lHUR/A88GtSC5Y=;
        b=KXOLk1ysfUZo34g3vf+QrhUy83luo3tQ5wC3qO9ZgjONLU6vYILy1/i186Pl3Ikcft
         qbZoqpZ3eiCU+40s912yIQ8cokWJoOy3zjjfVkbGtB371U6yQnGq3JLSRGIl2o55D5Zt
         HIvbU9qWQ3LyJE2qptMe6fyUcHmm+WbzKsFoXdnb4/bWODcN28/cDJy3WOgwy5lPkNuX
         b3pT5IcfoYV+gMNHrmaya63Vv1TFbOA3BlNqRvrikbfHXxzNriqA6jK4pt+j+YDPCOKM
         Gc+doEM7lXhK9ZPhybVi1U9EoU84GyCuXBIFfEwfKu/iZBQNewAKpv/QUk7lbfM5/nKi
         uj1w==
X-Gm-Message-State: AOAM532P9JIjZXQBK0ziHU9m0cW2CDlESnrzjxhJzGjG7krkk0vLOSo4
        7rcWWQCjrGj/C2Guf19RejW5ytGFtbbT
X-Google-Smtp-Source: ABdhPJxXpcOr1vUtFtc8cimhxuD2ABHo/+1zw7PJoSEDxd14HkGvCDtsPXDf6FsZ+AxeqgGCN0kUVw==
X-Received: by 2002:a05:620a:4256:b0:67e:87a1:ffdd with SMTP id w22-20020a05620a425600b0067e87a1ffddmr1130019qko.647.1650584923406;
        Thu, 21 Apr 2022 16:48:43 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f342ccc1c5sm287372qtx.72.2022.04.21.16.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:48:42 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: [PATCH 0/4] Printbufs & shrinker OOM reporting
Date:   Thu, 21 Apr 2022 19:48:24 -0400
Message-Id: <20220421234837.3629927-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.35.2
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

Debugging OOMs has been one of my sources of frustration, so this patch series
is an attempt to do something about it.

The first patch in the series is something I've been slowly evolving in bcachefs
for years: simple heap allocated strings meant for appending to and building up
structured log/error messages. They make it easy and straightforward to write
pretty-printers for everything, which in turn makes good logging and error
messages something that just happens naturally.

We want it here because that means the reporting I'm adding to shrinkers can be
used by both OOM reporting, and for the sysfs (or is it debugfs now) interface
that Roman is adding.

This patch series also:
 - adds OOM reporting on shrinkers, reporting on top 10 shrinkers (in sorted
   order!)
 - changes slab reporting to be always-on, also reporting top 10 slabs in sorted
   order
 - starts centralizing OOM reporting in mm/show_mem.c
 
The last patch in the series is only a demonstration of how to implement the
shrinker .to_text() method, since bcachefs isn't upstream yet.

Kent Overstreet (4):
  lib/printbuf: New data structure for heap-allocated strings
  mm: Add a .to_text() method for shrinkers
  mm: Centralize & improve oom reporting in show_mem.c
  bcachefs: shrinker.to_text() methods

 fs/bcachefs/btree_cache.c     |  18 ++-
 fs/bcachefs/btree_key_cache.c |  18 ++-
 include/linux/printbuf.h      | 140 ++++++++++++++++++
 include/linux/shrinker.h      |   5 +
 lib/Makefile                  |   4 +-
 lib/printbuf.c                | 271 ++++++++++++++++++++++++++++++++++
 mm/Makefile                   |   2 +-
 mm/oom_kill.c                 |  23 ---
 {lib => mm}/show_mem.c        |  14 ++
 mm/slab.h                     |   6 +-
 mm/slab_common.c              |  53 ++++++-
 mm/vmscan.c                   |  75 ++++++++++
 12 files changed, 587 insertions(+), 42 deletions(-)
 create mode 100644 include/linux/printbuf.h
 create mode 100644 lib/printbuf.c
 rename {lib => mm}/show_mem.c (78%)

-- 
2.35.2

