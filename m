Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5221442E1E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 21:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhJNTS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 15:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhJNTS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:18:27 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC7C061570;
        Thu, 14 Oct 2021 12:16:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so5476907pjb.5;
        Thu, 14 Oct 2021 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HTDYZolZ+ivgi1kzX7EW6yg+2PCzOZV/wqf9pSIfFwo=;
        b=nzmuf/eLBYEesOVRL8UTHmHlrYBmZnwfqXs4QJiSYz6oGx+X28femQo7IvEwrOTYTp
         JWL7ezJhF9CampIb31e2YbTBYtYqrUWHUP3pfwpEKRF7mzUbT5dkUbTskjWU7w0cSf8X
         jJtJ0la2N5gMfdQYuoFMSIsC4iuhs9EnLw8plFAyNA5yIBIcEXZYC2p73/m5XsMKWwFs
         FfJlUiPwcdGs0+ZaazvbAy7o63u0Xy/qXGAaDUoV56AcX9Ss+L+fPqREZPPDnKzvXz59
         R9F5m8E2rc5EMnhRwkKHB8Re0Jw5rpTZYu0U8Zff1OjaNuol3V3rMm8W9fVZ9OuFKSpI
         mQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HTDYZolZ+ivgi1kzX7EW6yg+2PCzOZV/wqf9pSIfFwo=;
        b=s2W3icAQG/aHK+Asz5jqN0+TFvJzrj53xIZfPsymfqP8VF09mKJ9z5jNJhaD6MI+VQ
         UoJV5Aw2jHBd4jI1rxCn5rrxyOjfrx5V+nC9Y8uqPtLcpo13+2yLGJtDCyp9A7ljIY19
         7DVGLuwpsuDaQSf6dwokRM6U3Tl3rFw9kEvr0iUNZVfYQVOuu4twOfw54I0JiSoG/fqq
         5Ig+Mgd1i+GykQUsbXMdPND+YWPUCzQEnwsSAqsJA1fPhrskOauqBXiYUcbHB/lsIjc2
         1U6aaaLhXUDvcDB18OTjq4AizrnKzDRj8g+nczXQpBws6ToZuPuMA9L6W61wB7XIfSo1
         Gf/A==
X-Gm-Message-State: AOAM530+UrCtqbHK8riTkE1UWm5yJaanotwgD6VuTzJsZ/Nmas/AFX5j
        NE5oOMLy+XNmp6XRItN5AjU=
X-Google-Smtp-Source: ABdhPJwn/bv58JfObtM5eYcTND2o1mZYEdMu4OHOizTN8mhnPpHgm9GqE55IsFRCEexFIOoFc2C1Dw==
X-Received: by 2002:a17:903:41c1:b0:13e:fe56:e42a with SMTP id u1-20020a17090341c100b0013efe56e42amr6559027ple.52.1634238981683;
        Thu, 14 Oct 2021 12:16:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x129sm3253922pfc.140.2021.10.14.12.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 12:16:20 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v4 PATCH 0/6] Solve silent data loss caused by poisoned page cache (shmem/tmpfs)
Date:   Thu, 14 Oct 2021 12:16:09 -0700
Message-Id: <20211014191615.6674-1-shy828301@gmail.com>
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

