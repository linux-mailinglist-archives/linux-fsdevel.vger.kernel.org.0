Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70A77C0353
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjJJSXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 14:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJJSXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:23:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82221AC;
        Tue, 10 Oct 2023 11:23:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32d3755214dso725781f8f.0;
        Tue, 10 Oct 2023 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696962195; x=1697566995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MYdUcr6LWnDZrnnkem7MG80UUlLo7ehwo0Ax7lmWvGc=;
        b=SYu7PFZXdcRqnZxfIQ4s+oKIOCHNZlcP7dEK9PV2+s1ENCCJ6O379kcxX0s//Fdpwj
         1NpRzgrmJPPzhyEx85tlvGSQ6qxc6pqHkcyU2FPrKnwDmEmj8lE3Xt5aU4sZAmgGUgZY
         tYL8W8rRPaTKQI8+shBOZeBjo8RKhSL28IRNKhuX2PW2mEWvcUW6mXKYRcwGaAUlwizL
         bF5F9g8MlqGctANm20tJ5+nCbvI0iAQABY8Y5anZIdmib33hkPFEgXpSlhcWeOqZ6OS7
         SKwFjvxg/KSywqVvu/4lxadas/mL3GTywONf3zCSgq7ikE2TuH6iDI1otwn2Pdx6IYod
         xqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696962195; x=1697566995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYdUcr6LWnDZrnnkem7MG80UUlLo7ehwo0Ax7lmWvGc=;
        b=fslcZGLW1k6Wi0016h3agZ/H600+gHz+6V0cOXG9pK0/gY/Yf1iBVwVlZaS8D0Fbht
         W5NRG7sPpMfkawo8kRIWo/MW1uJiS9UXUaJ4RSEGQ2MFjWnC3e4JXgDg/i4n1LipA1Q6
         0m0MN6PLNDD03WM/5WWZW0ERaY6ZkRdCNs7rhw1T+CegsZtS5iA9L/bcAqSODayKDpA6
         qiHdSVwLnZewcN3UQ4OUienwpr3tdAaQ+1oFFoBH5l2ouU9bdlRC4v4G8pawlvYDwXh+
         vGbeH8U+R4TViZX8InUJ91E2MWWN5GwezkJrqISdrFTKDWPJWhDXXwDoyMO/HrNFVl7R
         eOAw==
X-Gm-Message-State: AOJu0Yz7I7mK7U9sVfKZRm5X+8IDLlvR3bcsbPlcQIiwdaAumSpNzzZO
        7ZcFnETTL+rH4cnzAoB+wqU=
X-Google-Smtp-Source: AGHT+IFy9nLGihsg0SD0URTc98BCX55JjX+6ATRlDYUzqh5HxVJ4aY8tFC5Zw1tuvOto/68hD1xqFQ==
X-Received: by 2002:a05:6000:136e:b0:31f:f664:d87 with SMTP id q14-20020a056000136e00b0031ff6640d87mr16088629wrz.20.1696962194557;
        Tue, 10 Oct 2023 11:23:14 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id j16-20020a5d6190000000b003217cbab88bsm13225312wru.16.2023.10.10.11.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:23:12 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 0/5] Abstract vma_merge() and split_vma()
Date:   Tue, 10 Oct 2023 19:23:03 +0100
Message-ID: <cover.1696929425.git.lstoakes@gmail.com>
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
vma_merge()/split_vma() pattern, returning a pointer to either the merged
or split VMA or an ERR_PTR(err) if the splits fail.

We provide a number of inline helper functions to make things even clearer:-

* vma_modify_flags()      - Prepare to modify the VMA's flags.
* vma_modify_flags_name() - Prepare to modify the VMA's flags/anon_vma_name
* vma_modify_policy()     - Prepare to modify the VMA's mempolicy.
* vma_modify_flags_uffd() - Prepare to modify the VMA's flags/uffd context.

For cases where a new VMA is attempted to be merged with adjacent VMAs we
add:-

* vma_merge_new_vma() - Prepare to merge a new VMA.
* vma_merge_extend()  - Prepare to extend the end of a new VMA.

v3:
* Drop unnecessary VM_WARN_ON().
* Implement excellent suggestion from Vlastimil to simply have vma_modify()
  return the vma if merge fails (and no error occurs on split), as all
  callers really only need to deal with either the merged VMA or the
  original one if split. This simplifies things even further.

v2:
* Correct mistake where error cases would have been treated as success as
  pointed out by Vlastimil.
* Move vma_policy() define to mm_types.h.
* Move anon_vma_name(), anon_vma_name_alloc() and anon_vma_name_free() to
  mm_types.h from mm_inline.h.
* These moves make it possible to implement the vma_modify_*() helpers as
  static inline declarations, so do so.
* Spelling corrections and clarifications.
https://lore.kernel.org/all/cover.1696884493.git.lstoakes@gmail.com/

v1:
https://lore.kernel.org/all/cover.1696795837.git.lstoakes@gmail.com/

Lorenzo Stoakes (5):
  mm: move vma_policy() and anon_vma_name() decls to mm_types.h
  mm: abstract the vma_merge()/split_vma() pattern for mprotect() et al.
  mm: make vma_merge() and split_vma() internal
  mm: abstract merge for new VMAs into vma_merge_new_vma()
  mm: abstract VMA merge and extend into vma_merge_extend() helper

 fs/userfaultfd.c          |  71 +++++++-----------------
 include/linux/mempolicy.h |   4 --
 include/linux/mm.h        |  69 ++++++++++++++++++++---
 include/linux/mm_inline.h |  20 +------
 include/linux/mm_types.h  |  27 +++++++++
 mm/internal.h             |   7 +++
 mm/madvise.c              |  26 ++-------
 mm/mempolicy.c            |  26 +--------
 mm/mlock.c                |  25 ++-------
 mm/mmap.c                 | 114 ++++++++++++++++++++++++++++++++------
 mm/mprotect.c             |  29 ++--------
 mm/mremap.c               |  30 +++++-----
 mm/nommu.c                |   4 +-
 13 files changed, 240 insertions(+), 212 deletions(-)

--
2.42.0
