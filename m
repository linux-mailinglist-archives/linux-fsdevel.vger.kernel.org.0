Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0E77BEBFE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 22:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378042AbjJIUxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 16:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378014AbjJIUxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:53:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3591CA3;
        Mon,  9 Oct 2023 13:53:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3226cc3e324so4909128f8f.3;
        Mon, 09 Oct 2023 13:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696884813; x=1697489613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Us15zo8nGUmOlyk9vDcAmDiwdx4iJiZpKEJ1GTzA2B4=;
        b=Lj/0yJkiqcEX/UXaoQhrC/oQYTRw3tc/Ush7vlbSN4hfAqfcR7p5pbUmj2CEJDLCJT
         v0DkVNUExBDbCUH1DvsXd5EIU/PcV+krAvsasj0SiOLDNQSsZja0ysmRL3tuhEMvbfYs
         pa+ZYi87p93JwVXh3o7zQLyF6LqToI6Q6J94hG17Kd8qOowEVUUGc50nINM7/5RPuLCT
         WT3MIQNgyV3CadqDcgmJTP1brs6M1zu2xrYgWmsIGT/BBaZ8ThJeHgjc8eQHH8K7ZXg7
         5AHNyYzJQBhs0aWA+XnkdIU6nKuHKZ44IbwJtczXpDNFd1qSZIp5BMSJGsCtsrGTC1Fs
         W9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696884813; x=1697489613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Us15zo8nGUmOlyk9vDcAmDiwdx4iJiZpKEJ1GTzA2B4=;
        b=EoQIAq6GvBQp623f7YXfShcrg8a+4BbqVxSXtOTrA92asdKQ9Z0RqJRjhGV/buU/Mt
         Db/n0I3zpBaaoI8u+2nTu60uDr46kdZ4hULgi3ZLE9y9yVE9c64c1w3Ii3+ePuUuB/9x
         JIhYv4UTsDTIZHgKVYMPxMeJoInvtNkGj+AsJaFu+79xxatph22qmjsqkz4GMdhY6DJU
         9SD+9es4SR/Nif/UMH5vIfnfq48nI0Fq8Hg9/Dqc/QF5/8u2hsK7PlwN2lW9iO8dK7QU
         Hle+t7DiSrJNuMsbEjoJPVM3PN0sqv0DGNCmvuYeAw7vpa5GhbYU7IiUeQ3Ubk1FZW57
         wyTA==
X-Gm-Message-State: AOJu0YypYv9Q8rDn7Ce8SnKy8KpJ399VGlWtnAxf8zg8GoJQiZjZRsOX
        +6dv7o8eXOv0nygB/O6CTsI=
X-Google-Smtp-Source: AGHT+IGDaRtGngfMceHEuNgbt1g4utdKAaZZhswlmGa50KFFUZN8yWub9TMmqHRfEB7VzWUkEOrU5Q==
X-Received: by 2002:a05:6000:1a50:b0:314:1b4d:bb27 with SMTP id t16-20020a0560001a5000b003141b4dbb27mr14222708wry.64.1696884813218;
        Mon, 09 Oct 2023 13:53:33 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id l2-20020a5d4802000000b0031fe0576460sm10578130wrq.11.2023.10.09.13.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:53:32 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 0/5]  Abstract vma_merge() and split_vma()
Date:   Mon,  9 Oct 2023 21:53:15 +0100
Message-ID: <cover.1696884493.git.lstoakes@gmail.com>
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
central interface where anything might happen we can untangle the brittle
and confusing vma_merge() implementation into something more workable.

For mprotect()-like cases we introduce vma_modify() which performs the
vma_merge()/split_vma() pattern, returning a pointer or an ERR_PTR(err) if
the splits fail.

We provide a number of inline helper functions to make things even clearer:-

* vma_modify_flags()      - Prepare to modify the VMA's flags.
* vma_modify_flags_name() - Prepare to modify the VMA's flags/anon_vma_name
* vma_modify_policy()     - Prepare to modify the VMA's mempolicy.
* vma_modify_flags_uffd() - Prepare to modify the VMA's flags/uffd context.

For cases where a new VMA is attempted to be merged with adjacent VMAs we
add:-

* vma_merge_new_vma() - Prepare to merge a new VMA.
* vma_merge_extend()  - Prepare to extend the end of a new VMA.

v2:
* Correct mistake where error cases would have been treated as success as
  pointed out by Vlastimil.
* Move vma_policy() define to mm_types.h.
* Move anon_vma_name(), anon_vma_name_alloc() and anon_vma_name_free() to
  mm_types.h from mm_inline.h.
* These moves make it possible to implement the vma_modify_*() helpers as
  static inline declarations, so do so.
* Spelling corrections and clarifications.

v1:
https://lore.kernel.org/all/cover.1696795837.git.lstoakes@gmail.com/

Lorenzo Stoakes (5):
  mm: move vma_policy() and anon_vma_name() decls to mm_types.h
  mm: abstract the vma_merge()/split_vma() pattern for mprotect() et al.
  mm: make vma_merge() and split_vma() internal
  mm: abstract merge for new VMAs into vma_merge_new_vma()
  mm: abstract VMA merge and extend into vma_merge_extend() helper

 fs/userfaultfd.c          |  69 ++++++++----------------
 include/linux/mempolicy.h |   4 --
 include/linux/mm.h        |  69 ++++++++++++++++++++----
 include/linux/mm_inline.h |  20 +------
 include/linux/mm_types.h  |  27 ++++++++++
 mm/internal.h             |   7 +++
 mm/madvise.c              |  32 ++++-------
 mm/mempolicy.c            |  22 ++------
 mm/mlock.c                |  27 +++-------
 mm/mmap.c                 | 111 +++++++++++++++++++++++++++++++-------
 mm/mprotect.c             |  35 ++++--------
 mm/mremap.c               |  30 +++++------
 mm/nommu.c                |   4 +-
 13 files changed, 255 insertions(+), 202 deletions(-)

--
2.42.0
