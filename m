Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4064E75E4F7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jul 2023 22:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGWUzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jul 2023 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWUzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:55:12 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6388FAD
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jul 2023 13:55:11 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d07c535377fso1729992276.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jul 2023 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690145710; x=1690750510;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TY4oWT4BmzbCLpoTbP8uqzxOpbbEPhs/d55O6L9hwVM=;
        b=vRkNNrSTcfhE/l1bOMFJ73ZeZD3Cg0OJYqHLVgN6sa7frN9TEH5M9lx17RdpXOPnDX
         r2ii4Q5a2GlLxpuaywcH4oi535gMtHBWmcokk4JWEGW4gyNwxepVLK9YKcXHw7/yxUyP
         qZGsVxrX/ncJTNoIkpijEyzVKP5AhmM5rnE+js8hlhOsUERNX+xXzOKxia0listxcOKe
         0CoIxtYa2fio4TzzjiJUr2JxwEXo9Tb2nOuL2FWeboNf3b1OL+TwxUrsw13KVq4x4ERn
         YDa0aMbL5MeVyBmjTVOhJoYCTet7tzOKKpLGqGv0T861jBvf5JcfqNiQhXjQmgl4s+wL
         l68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690145710; x=1690750510;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TY4oWT4BmzbCLpoTbP8uqzxOpbbEPhs/d55O6L9hwVM=;
        b=RW1e3GD/BAP7e8KDYbGM7pEUtlebOzCtIzBK6futoXDBwy5sKlvZoQcRPpxHUoYvYf
         VIQB2T+UvWWATzr0yYd01porhCtPaydkt1Zthp1Wpoqm1vNxPk1B09JElcMyXF4H33Ht
         rbeRFuS95bKftpsRbIBwrofwtXtIKORIoomAGW3PrYIzEmZMhSGj9P2GEDE0FG4RMm2c
         TSRs5bJCkLphsz3fh8URKuzlAr6zm9NS7NnuWd/8I8bPME27dM4RBwycanghKEndanG4
         Gly6yEI78iTNqJ5J1cM5ZAcTFZ11NepPgHXZ5TETEYKAAv2KA86ytnpfJJlJ0lfooSOx
         dVQg==
X-Gm-Message-State: ABy/qLZIzjzgRVLzCEfrJ42TT9MbxSlk/4Wsg1K3ZWr1a9utqbavaANo
        N8M0lVpi+42DI9fT+WqPuFjTUn4QD07BDjsOg3Bkqw==
X-Google-Smtp-Source: APBJJlHVODtrgl3ATBbSeYuloyXNj+A+wOCcfh07rcSah/7KcVkNUk/mksbD/CHakBHII4RTtjs8eQ==
X-Received: by 2002:a25:34d5:0:b0:d10:a134:addd with SMTP id b204-20020a2534d5000000b00d10a134adddmr625722yba.55.1690145710413;
        Sun, 23 Jul 2023 13:55:10 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 8-20020a250108000000b00cc567b3a869sm2023917ybb.6.2023.07.23.13.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 13:55:09 -0700 (PDT)
Date:   Sun, 23 Jul 2023 13:55:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH mm-hotfixes] tmpfs: fix Documentation of noswap and huge
 mount options
Message-ID: <986cb0bf-9780-354-9bb-4bf57aadbab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The noswap mount option is surely not one of the three options for sizing:
move its description down.

The huge= mount option does not accept numeric values: those are just in
an internal enum.  Delete those numbers, and follow the manpage text more
closely (but there's not yet any fadvise() or fcntl() which applies here).

/sys/kernel/mm/transparent_hugepage/shmem_enabled is hard to describe, and
barely relevant to mounting a tmpfs: just refer to transhuge.rst (while
still using the words deny and force, to help as informal reminders).

Fixes: d0f5a85442d1 ("shmem: update documentation")
Fixes: 2c6efe9cf2d7 ("shmem: add support to ignore swap")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 Documentation/filesystems/tmpfs.rst | 45 ++++++++++++-----------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index f18f46be5c0c..28aeaeea47d0 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -84,8 +84,6 @@ nr_inodes  The maximum number of inodes for this instance. The default
            is half of the number of your physical RAM pages, or (on a
            machine with highmem) the number of lowmem RAM pages,
            whichever is the lower.
-noswap     Disables swap. Remounts must respect the original settings.
-           By default swap is enabled.
 =========  ============================================================
 
 These parameters accept a suffix k, m or g for kilo, mega and giga and
@@ -99,36 +97,31 @@ mount with such options, since it allows any user with write access to
 use up all the memory on the machine; but enhances the scalability of
 that instance in a system with many CPUs making intensive use of it.
 
+tmpfs blocks may be swapped out, when there is a shortage of memory.
+tmpfs has a mount option to disable its use of swap:
+
+======  ===========================================================
+noswap  Disables swap. Remounts must respect the original settings.
+        By default swap is enabled.
+======  ===========================================================
+
 tmpfs also supports Transparent Huge Pages which requires a kernel
 configured with CONFIG_TRANSPARENT_HUGEPAGE and with huge supported for
 your system (has_transparent_hugepage(), which is architecture specific).
 The mount options for this are:
 
-======  ============================================================
-huge=0  never: disables huge pages for the mount
-huge=1  always: enables huge pages for the mount
-huge=2  within_size: only allocate huge pages if the page will be
-        fully within i_size, also respect fadvise()/madvise() hints.
-huge=3  advise: only allocate huge pages if requested with
-        fadvise()/madvise()
-======  ============================================================
+===========  ==============================================================
+huge=never   Do not allocate huge pages.  This is the default.
+huge=always  Attempt to allocate huge page every time a new page is needed.
+huge=within_size Only allocate huge page if it will be fully within i_size.
+             Also respect madvise(2) hints.
+huge=advise  Only allocate huge page if requested with madvise(2).
+===========  ==============================================================
 
-There is a sysfs file which you can also use to control system wide THP
-configuration for all tmpfs mounts, the file is:
-
-/sys/kernel/mm/transparent_hugepage/shmem_enabled
-
-This sysfs file is placed on top of THP sysfs directory and so is registered
-by THP code. It is however only used to control all tmpfs mounts with one
-single knob. Since it controls all tmpfs mounts it should only be used either
-for emergency or testing purposes. The values you can set for shmem_enabled are:
-
-==  ============================================================
--1  deny: disables huge on shm_mnt and all mounts, for
-    emergency use
--2  force: enables huge on shm_mnt and all mounts, w/o needing
-    option, for testing
-==  ============================================================
+See also Documentation/admin-guide/mm/transhuge.rst, which describes the
+sysfs file /sys/kernel/mm/transparent_hugepage/shmem_enabled: which can
+be used to deny huge pages on all tmpfs mounts in an emergency, or to
+force huge pages on all tmpfs mounts for testing.
 
 tmpfs has a mount option to set the NUMA memory allocation policy for
 all files in that instance (if CONFIG_NUMA is enabled) - which can be
-- 
2.35.3

