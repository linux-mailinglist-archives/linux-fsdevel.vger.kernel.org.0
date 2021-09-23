Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30444155FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 05:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbhIWDaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 23:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbhIWDaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:30:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC48C061574;
        Wed, 22 Sep 2021 20:28:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t4so3165599plo.0;
        Wed, 22 Sep 2021 20:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ki6pkYMnfOAScz3q1SGd96OuCB2AYCYHs3PdlWGy2M=;
        b=efR/57wxxOzBQ+rSB4cPkVOlyrX8uZig3qLozrZRNonIybdqpcjAEN4KFFcDPipJiC
         wxASo3FRXk1ekHoBikPE+cbSSo2Y2f7TR8cdHlACSsnyAqhCciGHfYV7jgJxUer4l6D0
         cHtj0MmVH3WPv5HLUo+EGCXHMIVbgDJonnoLldp3VycSAqOX+PLsFg/X4Lj1M1PomU2R
         do+kwEIlu1A9ZvZXrAwrD9xE9IL8I6hvkQX+FdLcXTIF5fcE1Z9GCkcwhT26zMvQIBL1
         GRubOtubSAPHJa7NsjF2PZKRljYgOuab9lBv0Wxj6VXmxKfDp5A7fyKPPDae7xbGnnBg
         tUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ki6pkYMnfOAScz3q1SGd96OuCB2AYCYHs3PdlWGy2M=;
        b=I8+QPTlkBTCZsx7JSN2A3TkZ/mjbxpCz0a35WR6HA+AkIFjlJIdHkITD+hbfPfRvyE
         CA5wsVWuFFFBAx46+tJY7UePMpip6+usFLlCpIytwcQWJkFJFnmJnWyeos+voHfz03Rv
         MEucRwUawhQSN+8jknX5M7PPfusp/QmxZU70BalY3zBwm6oR8Qpshb3toEwdo3fU+UOE
         1cCvcedcdmClPtKvMVyxmtpFQh0nTu36QYvIXPW5LNYbb2aXQgbl/ymHHabk5kFqC+nf
         pDMxGuAUuqpnZDgb51Ut+efQtnBHVI15g9I+Qzi/cpLqTYYEFnpj91UFKh9G++/e33F7
         +GLg==
X-Gm-Message-State: AOAM533LRHq61efhAYY10eXfA65a8H5QumI0WiJiJ2u3unEnuB7wXF+u
        zx61XlnwKJf0lqNWBeq7yyc=
X-Google-Smtp-Source: ABdhPJy1rUDMwQ5o/PbV3Mjy4wZ2nZOlypgylHA3NsHqudKF/jXoHx26oW+maHH8y0pW0LN6TFdhPw==
X-Received: by 2002:a17:902:bb94:b0:13c:9113:5652 with SMTP id m20-20020a170902bb9400b0013c91135652mr2003926pls.70.1632367726840;
        Wed, 22 Sep 2021 20:28:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x8sm3699696pfq.131.2021.09.22.20.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 20:28:45 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 PATCH 0/5] Solve silent data loss caused by poisoned page cache (shmem/tmpfs)
Date:   Wed, 22 Sep 2021 20:28:25 -0700
Message-Id: <20210923032830.314328-1-shy828301@gmail.com>
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

Patch #1: fix bugs in page fault and khugepaged.
Patch #2 and #3: refactor, cleanup and preparation.
Patch #4: keep the poisoned page in page cache and handle such case for all
          the paths.
Patch #5: the previous patches unblock page cache THP split, so this patch
          add page cache THP split support.

Changelog v1 --> v2:
  * Incorporated the suggestion from Kirill to use a new page flag to
    indicate there is hwpoisoned subpage(s) in a THP. (patch #1)
  * Dropped patch #2 of v1.
  * Refctored the page refcount check logic of hwpoison per Naoya. (patch #2)
  * Removed unnecessary THP check per Naoya. (patch #3)
  * Incorporated the other comments for shmem from Naoya. (patch #4)


Yang Shi (5):
      mm: filemap: check if THP has hwpoisoned subpage for PMD page fault
      mm: hwpoison: refactor refcount check handling
      mm: hwpoison: remove the unnecessary THP check
      mm: shmem: don't truncate page if memory failure happens
      mm: hwpoison: handle non-anonymous THP correctly

 include/linux/page-flags.h |  19 ++++++++++
 mm/filemap.c               |  15 ++++----
 mm/huge_memory.c           |   2 ++
 mm/memory-failure.c        | 130 ++++++++++++++++++++++++++++++++++++++++++---------------------------
 mm/memory.c                |   9 +++++
 mm/page_alloc.c            |   4 ++-
 mm/shmem.c                 |  31 +++++++++++++++--
 mm/userfaultfd.c           |   5 +++
 8 files changed, 156 insertions(+), 59 deletions(-)


[1] https://lore.kernel.org/linux-mm/CAHbLzkqNPBh_sK09qfr4yu4WTFOzRy+MKj+PA7iG-adzi9zGsg@mail.gmail.com/T/#m0e959283380156f1d064456af01ae51fdff91265
[2] https://lore.kernel.org/lkml/20210318183350.GT3420@casper.infradead.org/

