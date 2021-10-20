Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D098A4354EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 23:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhJTVKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 17:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJTVKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:10:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22A5C06161C;
        Wed, 20 Oct 2021 14:07:59 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so3318125pjb.5;
        Wed, 20 Oct 2021 14:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtFIOcHZXEdXz4a0xv0RYtbOt6pCuT2dAaCUX4NEfxo=;
        b=EPKYCU7y3AtwW+T1sWraaEB3JH9ROrH4cNZo5uwoPSsVuC57IG2cQJWnD1up7wOES6
         72N4Pne58ADtXy1NIdmpKyzgiTNkCvnklNHV5bc4cvyuy+IGdxq2pm9jEkpF3JVB7NHx
         MahxbVnCLwzrk3yJiSL72wP3hZVXQ2ufP8SS+LQZTfua8aou09re08UQhrQew2Lvfk+O
         3B300CWBD+jI1OfyuEqJVoVNC3QyRyk3MdVzZyfKxaXWofMKWrxyVQMSXM3GWUnW7xWd
         IsxxuJ4Kb9rTpsqWBq7rZiThStjTtjwuZnbNlMcDrmOIdTV+Xxs4nbjVw2CsBjoU+ijd
         8E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtFIOcHZXEdXz4a0xv0RYtbOt6pCuT2dAaCUX4NEfxo=;
        b=0PsSjw8ZfrbgCST6ZZ8U8Wqj7UbN87gHBRME4UiXFiLNXO5eNWr6Blq7lOPxUm+EgL
         44kSMoPzukU3i5FP9pu+iI9Zt+bc2qBmnE79YjJZACLlaV51HWPMv1BBntM2PpEUuzmM
         Z0CVfYsNVtWp65vg93Oa+DOqyhDWNPI5Dmgkt/iI7o0XJHzoBy1Ac9ifNSWYFV+KViNj
         eefuMnrMo3neEIwv7QAFM8xWxTsyiRGdjgU0jooH1z2506Zon5uLiGqvyHjPzr6X3d+I
         V+/RFkej5A0kdKf4lJqKKEfqb/CYDJ2WtNiDSpDPB/6hI4jE/yXu7HkfoLhE9sWBIUkv
         tf1w==
X-Gm-Message-State: AOAM533QETtaRlT3kFPQ0r08h/osLfMLeOn2X9kY2SUBlnjOQQqBtb2t
        DcWhMDtpik2icglyDOUuH5g=
X-Google-Smtp-Source: ABdhPJyu2Dh+p0Q/qvkHygEZcjjVVlNyzjRVt7VobDnghQqJnflZezgL8DnoIOi1VqFf++m/HvRndw==
X-Received: by 2002:a17:902:8bc4:b029:12b:8470:e29e with SMTP id r4-20020a1709028bc4b029012b8470e29emr1389606plo.2.1634764079076;
        Wed, 20 Oct 2021 14:07:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id i8sm3403143pfo.117.2021.10.20.14.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:07:58 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 0/6] Solve silent data loss caused by poisoned page cache (shmem/tmpfs)
Date:   Wed, 20 Oct 2021 14:07:49 -0700
Message-Id: <20211020210755.23964-1-shy828301@gmail.com>
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

TODO:
* The unpoison has been broken since commit 0ed950d1f281 ("mm,hwpoison: make
  get_hwpoison_page() call get_any_page()"), and this patch series make
  refcount check for unpoisoning shmem page fail.
* Expand to other filesystems.  But I haven't heard feedback from filesystem
  developers yet.

Patch breakdown:
Patch #1: cleanup, depended by patch #2
Patch #2: fix THP with hwpoisoned subpage(s) PMD map bug
Patch #3: coding style cleanup
Patch #4: refactor and preparation.
Patch #5: keep the poisoned page in page cache and handle such case for all
          the paths.
Patch #6: the previous patches unblock page cache THP split, so this patch
          add page cache THP split support.


Changelog
v4 --> v5:
  * Fixed the typos (patch 2/6) per Naoya.
  * Coding style clean up (patch 5/6) per Naoya.
  * Fixed missed put_page() in shmem_file_read_iter().
  * Collected review tags from Naoya.
v3 --> v4:
  * Separated coding style cleanup from patch 2/5 by adding a new patch
    (patch 3/6) per Kirill.
  * Moved setting PageHasHWPoisoned flag to proper place (patch 2/6) per
    Peter Xu.
  * Elaborated why soft offline doesn't need to set this flag in the commit
    message (patch 2/6) per Peter Xu.
  * Renamed "dec" parameter to "extra_pins" for has_extra_refcount() (patch 4/6)
    per Peter Xu.
  * Adopted the suggestions for comment and coding style (patch 5/6) per
    Naoya.
  * Checked if page is hwpoison or not for shmem_get_link() (patch 5/6) per
    Peter Xu.
  * Collected acks.
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


Yang Shi (6):
      mm: hwpoison: remove the unnecessary THP check
      mm: filemap: check if THP has hwpoisoned subpage for PMD page fault
      mm: filemap: coding style cleanup for filemap_map_pmd()
      mm: hwpoison: refactor refcount check handling
      mm: shmem: don't truncate page if memory failure happens
      mm: hwpoison: handle non-anonymous THP correctly

 include/linux/page-flags.h |  23 ++++++++++++
 mm/filemap.c               |  12 +++----
 mm/huge_memory.c           |   2 ++
 mm/memory-failure.c        | 136 ++++++++++++++++++++++++++++++++++++++++++++-------------------------
 mm/memory.c                |   9 +++++
 mm/page_alloc.c            |   4 ++-
 mm/shmem.c                 |  37 +++++++++++++++++--
 mm/userfaultfd.c           |   5 +++
 8 files changed, 170 insertions(+), 58 deletions(-)


[1] https://lore.kernel.org/linux-mm/CAHbLzkqNPBh_sK09qfr4yu4WTFOzRy+MKj+PA7iG-adzi9zGsg@mail.gmail.com/T/#m0e959283380156f1d064456af01ae51fdff91265
[2] https://lore.kernel.org/lkml/20210318183350.GT3420@casper.infradead.org/

