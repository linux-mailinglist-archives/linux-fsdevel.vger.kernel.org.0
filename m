Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB5D40B703
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 20:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhINSit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 14:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhINSis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:38:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7356BC061574;
        Tue, 14 Sep 2021 11:37:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y8so124071pfa.7;
        Tue, 14 Sep 2021 11:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRa6HqUhQ+fdTXKvWXd36fRi3TX1WdardxQCBjScj6s=;
        b=d9dsOcWabdNkz5M6PlZuPYWhfmeeWroMMJAR5Caicpoe4HKehNsXf+y9LHNyjCTi73
         XRiNz4IBpGGyJhAlJRBKppO6OW0uUTf3nuiEU6JmZFb4fnCIhOQn366V8TKl/rqgRFsd
         wPaFWgY/cDnSh9VS5Vw4A9ikPyT21abYl2qgQCyUc5cNU6sxxFu5ZQXyj9TQlzNKkpHp
         U3h14HHBUHrZ8dP10GQ16pnIOU3g51930ImJEa3XohbY/iTHarAFAqTIyZu1gYey56TA
         cFHCwONBGUxs80q4ivm2u4SpEbYjSP4wdE6a4+DOgXEbz0xg8PyE1nbATJN4L50xPfyC
         AMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRa6HqUhQ+fdTXKvWXd36fRi3TX1WdardxQCBjScj6s=;
        b=UNBQeh3la83u0kF8WFpWC/jq43SvpMX5RSsSe5/n/vq5mbgShX5qd/s2cjfW0fmU0M
         C7Jlro46SRpatt3jyOR5zNOai0TCX/bTJSsyhi/QD1OAq1yCAMeHLfO98ZCCIIRr0p/J
         wpNQgpKvDwGlzC+dmiuWYxS+F0zgUd879zk719c98AYVM6zRUd1zz4ZdF6G7K1YdPz0p
         fU0QQ6tbqtKZ1M63s3WaGSTpzYhfUxnMHProd7ZW7O/MY2fvuAViOgyDeYhlFX+ubjS1
         3YnHpxOcGpQGuEAnBmuzYUSpBbX2HTEw2hrEcP7SES1+2wEuokLo0gaNFWK+bm6Kxr11
         ELDQ==
X-Gm-Message-State: AOAM5310Xj3lL3DSQDYuhAKWW1MqtFnq17WzRvodpcNU6rV1+khSvypd
        KZGofoYF0MMmEeR1C7OuAY2mt+KHXXQ=
X-Google-Smtp-Source: ABdhPJwp7U2LDZyKE5jo/rvBVtBlZqpa3nv4i6qbaczOFuJ1PuBeyWWrqMw7ryfd72rrBgg7Nacehw==
X-Received: by 2002:a65:508a:: with SMTP id r10mr16717565pgp.96.1631644651020;
        Tue, 14 Sep 2021 11:37:31 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y3sm12003965pge.44.2021.09.14.11.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:37:29 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] Solve silent data loss caused by poisoned page cache (shmem/tmpfs)
Date:   Tue, 14 Sep 2021 11:37:14 -0700
Message-Id: <20210914183718.4236-1-shy828301@gmail.com>
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

Patch #1 and #2: fix bugs in page fault and khugepaged.  And patch #2 also
                 did some preparation for the later patches.
Patch #3: keep the poisoned page in page cache and handle such case for all
          the paths.
Patch #4: the previous patches unblock page cache THP split, so this patch
          add page cache THP split support.


[1] https://lore.kernel.org/linux-mm/CAHbLzkqNPBh_sK09qfr4yu4WTFOzRy+MKj+PA7iG-adzi9zGsg@mail.gmail.com/T/#m0e959283380156f1d064456af01ae51fdff91265
[2] https://lore.kernel.org/lkml/20210318183350.GT3420@casper.infradead.org/

