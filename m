Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0DC7BD00C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Oct 2023 22:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344570AbjJHUXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 16:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344467AbjJHUXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 16:23:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F64F99;
        Sun,  8 Oct 2023 13:23:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40566f8a093so35599125e9.3;
        Sun, 08 Oct 2023 13:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696796600; x=1697401400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAlFt19XSPitoEhPZtTBItR7ZhRoBTV71rlHM3x983M=;
        b=hGqkYvHPDPFWQwn9y6Ifhzej8Fv/3iDcbFBKhvSV9C0sTgYibov9KiMW2KzmexCDO+
         KyPwRn096MXlm9QHdz/pqKzq4azxxQ665HmNuKC1WH7tMHlyQGlVitmQLbNh6GZYHEdU
         STVyZqychOSZIIn3YxsySFd8jZpdVQfhWH243Uhhkmo2IEvYCWR9n3Sp4UbdH2cqoBGE
         uf8LaK4SnjB1IU5aFDuY0sCXL/pAbBfOBPiLhNFJZ7QRO2WlJMvF6A7ZC7SPtAIDwDDs
         iZkvv3VudK3xY3uXnIQa2Jgf9iNWPYQ/KHKgvI3IeRV02Nzbzl2gkb2RT4Djo/fzu62k
         5OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696796600; x=1697401400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAlFt19XSPitoEhPZtTBItR7ZhRoBTV71rlHM3x983M=;
        b=jsoRD7+RjPBYJCSuFATsU4CbY2d4EBE5fGfKUBmj27g07c+4RcDfKFI/r2zmP2T6BP
         IF8Zv4BriShpRz4I18SduRbrDmeWmounJgoUwuaJXgaIU7gMxQiISgQTXhOuKiAbo3Y2
         g2qGe6oVurFAkjJmAJC+bqcxKNdDneD1gq7r4BR5yDYJQ9iDLRoKIuIolZj25C1E8KrS
         O4YDgSsSs30eqr+1niDZCWJ3DuZyumtPv3QTVAGXoYeTCmBAy/7L+7ogBe6ugq2NxVZ2
         9rRf5ky/MIEw7tpMv7sZLhcCORp6JTyGeeeSbVu+RlNn20w9JZH+jDKpr1MBbvhuBNwC
         C7zw==
X-Gm-Message-State: AOJu0YyG07GNKa2+gU77Wx285abgTUR2utBvdg2m4R6qdx8DqOycGUFJ
        VJttyCgy0FelpBaFzqkDD+8=
X-Google-Smtp-Source: AGHT+IEKXIM2JzbB/++nhZ/TA/gEwzRYuFkvk6v+COl+Htl+x4F+7inAR6yDfVh+8rq4JdKFK6K5Uw==
X-Received: by 2002:a05:600c:cc:b0:405:3955:5872 with SMTP id u12-20020a05600c00cc00b0040539555872mr11841823wmm.18.1696796599599;
        Sun, 08 Oct 2023 13:23:19 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id c5-20020a05600c0ac500b0040586360a36sm11474879wmr.17.2023.10.08.13.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 13:23:18 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 0/4] Abstract vma_merge() and split_vma()
Date:   Sun,  8 Oct 2023 21:23:12 +0100
Message-ID: <cover.1696795837.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The vma_merge() interface is very confusing and its implementation has led
to numerous bugs as a result of that confusion.

In addition there is duplication both in invocation of vma_merge(), but
also in the common mprotect()-style pattern of attempting a merge, then if
this fails, splitting the portion of a VMA about to have its attributes
changed.

This pattern has been copy/pasted around the kernel in each instance where
such an operation has been required, each very slightly modified from the
last to make it even harder to decipher what is going on.

Simplify the whole thing by dividing the actual uses of vma_merge() and
split_vma() into specific and abstracted functions and de-duplicate the
vma_merge()/split_vma() pattern altogether.

Doing so also opens the door to changing how vma_merge() is implemented -
by knowing precisely what cases a caller is invoking rather than having a
central interface where anything might happen, we can untangle the brittle
and confusing vma_merge() implementation into something more workable.

For mprotect()-like cases we introduce vma_modify() which performs the
vma_merge()/split_vma() pattern, returning a pointer or an ERR_PTR(err) if
the splits fail.

This is an internal interface, as it is confusing having a number of
different parameters available for fields that can be changed. Instead we
split the kernel interface into four functions:-

* vma_modify_flags()      - Prepare to modify the VMA's flags.
* vma_modify_flags_name() - Prepare to modify the VMA's flags/anon_vma_name
* vma_modify_policy()     - Prepare to modify the VMA's mempolicy.
* vma_modify_uffd()       - Prepare to modify the VMA's flags/uffd context.

For cases where a new VMA is attempted to be merged with adjacent VMAs we
add:-

* vma_merge_new_vma() - Prepare to merge a new VMA.
* vma_merge_extend()  - Prepare to extend the end of a new VMA.

Lorenzo Stoakes (4):
  mm: abstract the vma_merge()/split_vma() pattern for mprotect() et al.
  mm: make vma_merge() and split_vma() internal
  mm: abstract merge for new VMAs into vma_merge_new_vma()
  mm: abstract VMA extension and merge into vma_merge_extend() helper

 fs/userfaultfd.c   |  53 +++++----------
 include/linux/mm.h |  32 ++++++---
 mm/internal.h      |   7 ++
 mm/madvise.c       |  25 ++-----
 mm/mempolicy.c     |  20 +-----
 mm/mlock.c         |  24 ++-----
 mm/mmap.c          | 160 ++++++++++++++++++++++++++++++++++++++++-----
 mm/mprotect.c      |  27 ++------
 mm/mremap.c        |  30 ++++-----
 mm/nommu.c         |   4 +-
 10 files changed, 228 insertions(+), 154 deletions(-)

--
2.42.0
