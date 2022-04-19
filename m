Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFD8507B00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 22:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357642AbiDSUe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 16:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346295AbiDSUez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:34:55 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B73C49B;
        Tue, 19 Apr 2022 13:32:12 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id j9so7032715qkg.1;
        Tue, 19 Apr 2022 13:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ko8zqzAqB5d7Fp7/0nrVZqCAzIhr0lHUR/A88GtSC5Y=;
        b=hxxc3aXDI1szfhMi/u4O7o6ofPImpu0MGdJNdtkvoouyMZHSreIgkWcr6xha3MM/eB
         B7b75LCgIPkwvhryS0UoU5RAP8oj56g5A+SJKyHAC9Qv7guscyQQY5ge1RFu1pkZihQu
         uvGQNZHSClE9EQYgAR+lcbpGADr/JfghO88Evj5cQbWdjaLLDWlaVQb5+fX3hVS+Au7l
         Rk/aN9fl1Yk6cptw+KsyACYtrZ/xY10X7mwyPTladyl6lIPNCVoapu6n2ANZAxAer6Jb
         cxfPp7GmZe4/v+kBmlj1lAIWij/rXjYtLnjw6Z1SaIf/8LrK7E5CyePzy3wqV4Sz4uYt
         ZcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ko8zqzAqB5d7Fp7/0nrVZqCAzIhr0lHUR/A88GtSC5Y=;
        b=b1Al63/Set0WbLOGlNLPTzmCgkm7hyoP4QftLt96WKcMReGXrJqgMZeP4j5dbE9XTs
         Dz+BVXVmr5rpL48/alMfY/b5e+Cjb5E3P4ZBg2krwKWrZXUV1C+FFpJnvtKx3/0ej0Kq
         +Wk0ryKxb0XE9Zz0QmfCu5ND7uTKcGksooaDa8PB/2VlltHfKni028bAqc1dQa3GBqpp
         8WJqs2+2N+8rFHJz6/l0p9v1hB6tdI78mqzYGqnJVOXjWqmlBarprAxDvalcxUpN3TzD
         bRWdv6wJkSuBYL0TZZodfVlrlnPoAVuiXEWICUa3YE7+9wCNhj70QLsFBwRJ8R8hop0/
         kAug==
X-Gm-Message-State: AOAM533Nve1NA0kMq5o9DPBWtuRIR6lAnv8kctJH38p9p5vgnVNAALbj
        zfTWWtC3b1R42aokebFVzQ8l/l7BRLQA
X-Google-Smtp-Source: ABdhPJyxqQvJSU2BAXCqksNbmRp+iJ3c6ty/AqIcDXt7a31XO4Ee/I3Vl7wFKwADBpD0yIXu2C7tbg==
X-Received: by 2002:a05:620a:b92:b0:67e:b7a2:dabd with SMTP id k18-20020a05620a0b9200b0067eb7a2dabdmr10941225qkh.106.1650400330998;
        Tue, 19 Apr 2022 13:32:10 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id e9-20020ac84e49000000b002f1fcda1ac7sm611180qtw.82.2022.04.19.13.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:32:10 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: [PATCH 0/4] Printbufs & shrinker OOM reporting
Date:   Tue, 19 Apr 2022 16:31:58 -0400
Message-Id: <20220419203202.2670193-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
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

