Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E3941E37F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 23:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhI3VzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhI3VzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:55:00 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0406AC06176A;
        Thu, 30 Sep 2021 14:53:17 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r201so1651060pgr.4;
        Thu, 30 Sep 2021 14:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b91JNmgBs9FvxSHNJZlK8LCb6pIcgS0V6e/WL1ZeX70=;
        b=D+jiga5zkvtDM8pphyD7273sQkPhE155EYcr/nmh6p73psfFTYAS/NoXjjjuzttp//
         D3vI2Jx6LfuY/IHRLyUeWDeMuCAHu4y3FHVhnM3r+RzraASCO49dqtYQLi881elYt4k+
         OPlnbku361y7hzOBKJUKijPFd3N+C1v0RB0L8CrPEJv0TpUiyPsq4Az30ZHJCBT7wxOs
         rh/7OLyFnZ4RPeS6BsP+XASRwUR7PnUCvCdOb2/D/Ce1pekE8dTiqnuBtiGiix9XYlzy
         NbRgRf/NivfKMRtfpNfwm+8QncdwTt9DsN7mzL8t6rF2q/YM647Ej/os46jIhRyTFlDW
         rcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b91JNmgBs9FvxSHNJZlK8LCb6pIcgS0V6e/WL1ZeX70=;
        b=6TzQ2PHWnOLn7DNewprUbwDKJgwGsKlVQC0arLbgfMnuIM/Y7cwc9fBxax36IPfwGt
         SPR4JZRi/2JsYXxzpKDHBmau3ztF8KBX4c8dCsi2oEtQIuTXv+zfQwSiRCymS/aowgls
         s+9MJIRgPvzr6qEfNkbiE6MBZP3LvK3wGFL+TUGm40RQpfDXsIInYPDfwEKUDHhc/hJY
         xyeaapWA3zQR4k167ziRvdO9e+brair45Qg2JSj+Sa2apSCsZp0KkMbZq71pS2oEdkWk
         qllyoKAAe6qtSDqyJvxBzlFCMo5+6LOhXdJV8SXhZMBXu/WD6pjwr20NjTsoWWBCisey
         0g6w==
X-Gm-Message-State: AOAM531DtShQRVEK54QsagwZqvusfaJZjMuUkt3F9YAvhUfmmDF5cqW7
        +qZhXsR684+a+1QHpC7pDo6HvDXRvEI=
X-Google-Smtp-Source: ABdhPJxwj4Z9BwgO9J0ScgP/SgIfkjSrFfHVQW21v+uWYPmuQANXYFw1njf1wRrPK5erk7uwDMZLHw==
X-Received: by 2002:a65:6251:: with SMTP id q17mr6903883pgv.416.1633038796460;
        Thu, 30 Sep 2021 14:53:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id p17sm5647535pjg.54.2021.09.30.14.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 14:53:15 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v3 PATCH 0/5] Solve silent data loss caused by poisoned page cache (shmem/tmpfs)
Date:   Thu, 30 Sep 2021 14:53:06 -0700
Message-Id: <20210930215311.240774-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


When discussing the patch that splits page cache THP in order to offline the
poisoned page, Noaya mentioned there is a bigger problem [1] that prevents this
from working since the page cache page will be truncated if uncorrectable
errors happen.  By looking this deeper it turns out this approach (truncating
poisoned page) may incur silent data loss for all non-readonly filesystems if
the page is dirty.  It may be worse for in-memory filesystem, e.g. shmem/tmpfs
since the data blocks are actually gone.

To solve this problem we could keep the poisoned dirty page in page cache then
notify the users on any later access, e.g. page fault, read/write, etc.  The
clean page could be truncated as is since they can be reread from disk later on.

The consequence is the filesystems may find poisoned page and manipulate it as
healthy page since all the filesystems actually don't check if the page is
poisoned or not in all the relevant paths except page fault.  In general, we
need make the filesystems be aware of poisoned page before we could keep the
poisoned page in page cache in order to solve the data loss problem.

To make filesystems be aware of poisoned page we should consider:
- The page should be not written back: clearing dirty flag could prevent from
  writeback.
- The page should not be dropped (it shows as a clean page) by drop caches or
  other callers: the refcount pin from hwpoison could prevent from invalidating
  (called by cache drop, inode cache shrinking, etc), but it doesn't avoid
  invalidation in DIO path.
- The page should be able to get truncated/hole punched/unlinked: it works as it
  is.
- Notify users when the page is accessed, e.g. read/write, page fault and other
  paths (compression, encryption, etc).

The scope of the last one is huge since almost all filesystems need do it once
a page is returned from page cache lookup.  There are a couple of options to
do it:

1. Check hwpoison flag for every path, the most straightforward way.
2. Return NULL for poisoned page from page cache lookup, the most callsites
   check if NULL is returned, this should have least work I think.  But the
   error handling in filesystems just return -ENOMEM, the error code will incur
   confusion to the users obviously.
3. To improve #2, we could return error pointer, e.g. ERR_PTR(-EIO), but this
   will involve significant amount of code change as well since all the paths
   need check if the pointer is ERR or not just like option #1.

I did prototype for both #1 and #3, but it seems #3 may require more changes
than #1.  For #3 ERR_PTR will be returned so all the callers need to check the
return value otherwise invalid pointer may be dereferenced, but not all callers
really care about the content of the page, for example, partial truncate which
just sets the truncated range in one page to 0.  So for such paths it needs
additional modification if ERR_PTR is returned.  And if the callers have their
own way to handle the problematic pages we need to add a new FGP flag to tell
FGP functions to return the pointer to the page.

It may happen very rarely, but once it happens the consequence (data corruption)
could be very bad and it is very hard to debug.  It seems this problem had been
slightly discussed before, but seems no action was taken at that time. [2]

As the aforementioned investigation, it needs huge amount of work to solve
the potential data loss for all filesystems.  But it is much easier for
in-memory filesystems and such filesystems actually suffer more than others
since even the data blocks are gone due to truncating.  So this patchset starts
from shmem/tmpfs by taking option #1.

Patch #1: cleanup, depended by patch #2
Patch #2: fix THP with hwpoisoned subpage(s) PMD map bug
Patch #2: refactor and preparation.
Patch #4: keep the poisoned page in page cache and handle such case for all
          the paths.
Patch #5: the previous patches unblock page cache THP split, so this patch
          add page cache THP split support.

I didn't receive too many comments for patch #3 ~ #5, so may consider separate
the bug fixes (patch #1 and #2) from others to make them merged sooner.  This
version still includes all 5 patches.


Changelog
v2 --> v3:
  * Incorporated the comments from Kirill.
  * Reordered the series to reflect the right dependency (patch #3 from v2
    is patch #1 in this revision, patch #1 from v2 is patch #2 in this
    revision).
  * After the reorder, patch #2 depends on patch #1 and both need to be
    backported to -stable.
v1 --> v2:
  * Incorporated the suggestion from Kirill to use a new page flag to
    indicate there is hwpoisoned subpage(s) in a THP. (patch #1)
  * Dropped patch #2 of v1.
  * Refctored the page refcount check logic of hwpoison per Naoya. (patch #2)
  * Removed unnecessary THP check per Naoya. (patch #3)
  * Incorporated the other comments for shmem from Naoya. (patch #4)


Yang Shi (5):
      mm: hwpoison: remove the unnecessary THP check
      mm: filemap: check if THP has hwpoisoned subpage for PMD page fault
      mm: hwpoison: refactor refcount check handling
      mm: shmem: don't truncate page if memory failure happens
      mm: hwpoison: handle non-anonymous THP correctly

 include/linux/page-flags.h |  19 +++++++++++
 mm/filemap.c               |  12 +++----
 mm/huge_memory.c           |   2 ++
 mm/memory-failure.c        | 129 +++++++++++++++++++++++++++++++++++++++++++--------------------------
 mm/memory.c                |   9 +++++
 mm/page_alloc.c            |   4 ++-
 mm/shmem.c                 |  31 +++++++++++++++--
 mm/userfaultfd.c           |   5 +++
 8 files changed, 153 insertions(+), 58 deletions(-)


[1] https://lore.kernel.org/linux-mm/CAHbLzkqNPBh_sK09qfr4yu4WTFOzRy+MKj+PA7iG-adzi9zGsg@mail.gmail.com/T/#m0e959283380156f1d064456af01ae51fdff91265
[2] https://lore.kernel.org/lkml/20210318183350.GT3420@casper.infradead.org/

