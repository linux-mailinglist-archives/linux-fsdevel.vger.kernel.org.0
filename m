Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E524C9C38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 04:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiCBDkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 22:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiCBDkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:40:00 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825A24614E
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 19:39:18 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gb39so1019528ejc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Mar 2022 19:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=p8cJQgKKnOHkxJteaJVI28Wmpb4nsJV6bMQfmU2TxLU=;
        b=WruBke7ifrqm2rmf1V3w2WBkdmJK9KIBYhQ96AqMwMS/upKOhQVHlF+dLIUyTdjTDN
         rg5WJFWTbxqhIjKTTE6kK6Ll2iqPVY1uwgRVYcV+1t4nHIlOTrWdDF/TUDrh9TM0GtS0
         GqiWlG/nHU+/ddEtBBAOGvz1CJ5UqpGw5Qhe/gPnwOnbT672gRk0A3ZX9P7IzkStOSFK
         0njtBt4aO/VkDU4F+rlL1AtcbVxFPSnTbbXDgRciu0nCV80dSgQ3p2vRERshWBvfd8ND
         iHmiOheNBEISEDrMBY4kVE+uHOJGPZSkZJfnMne5uGnkd9rgWsPGxzOKbY2GmGFrvDFP
         lmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=p8cJQgKKnOHkxJteaJVI28Wmpb4nsJV6bMQfmU2TxLU=;
        b=2CGgUpxi47cL4eXxlukFzlxKis0teG0OoUaR7xDy4QDXbzqf0QeCTZhhqGKT3Zz2yi
         l324Z5fwMMZozbUwss+gPLuzrcEzk/C1manUQBy2IoxJtHomNAwb4Fg3cVvTzp2xDQyY
         65U/P6fEEgUVklu0JvH5LWuBQvAUH21iw3R1TgrsgmiWkHfBsDdk9l6LRfZq6PbfRaP1
         CYdM/k+OF1KaSljqG6cZ5ao4wBt0oLw5bHg1ICRr9ur7jmJGnAYk4nN1F939qzDOJTap
         KOmj5nS0cbtKI60klJf7MobRn7fEgX4i3zi4InJaXWZGUi5sWLb72wARzDpw7tPWdbSZ
         ufvw==
X-Gm-Message-State: AOAM530gID9EKU1RRcv+GlC4oTt/iYEwNXTJ+A1zyayHwS9GgvM1o0g/
        VI3pzyclzMmXnLWDk0erwmv55c30P14dNeBm0yCMHKUoC5EA/Q==
X-Google-Smtp-Source: ABdhPJzG8DSs1ZZOpMGNy3UqImbtOTkMfdWoYSpGUoyRH1BJW4AGuV0PtKZMinDdmAtA863aZX1L900eEKbrXRAfE6E=
X-Received: by 2002:a17:907:7e9c:b0:6d6:da36:35f4 with SMTP id
 qb28-20020a1709077e9c00b006d6da3635f4mr7073500ejc.764.1646192356557; Tue, 01
 Mar 2022 19:39:16 -0800 (PST)
MIME-Version: 1.0
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Mar 2022 19:39:04 -0800
Message-ID: <CAHbLzkp0PomtRoSmdv=waWTHtVUPZvTBGt1v7ynirGyw4iPFQw@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Potential silent data loss caused by hwpoisoned
 page cache
To:     lsf-pc@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I did fill out the google form but forgot to email to the lists.


When discussing the patch that splits page cache THP in order to offline the
poisoned page, Noaya mentioned there is a bigger problem [1] that prevents this
from working since the page cache page will be truncated if uncorrectable
errors happen.  By looking this deeper it turns out this approach (truncating
poisoned page) may incur silent data loss for all non-readonly filesystems if
the page is dirty. And it may be worse for in-memory filesystem, e.g.
shmem/tmpfs
since the data blocks are actually gone.

To solve this problem we could keep the poisoned dirty page in page cache then
notify the users on any later access, e.g. page fault, read/write, etc.  The
clean page could be truncated as is since they can be reread from disk later on.

The consequence is the filesystems may find poisoned page and manipulate it as
healthy page since all the filesystems actually don't check if the page is
poisoned or not in all the relevant paths except page fault.  In general, we
need to make the filesystems be aware of poisoned page before we could keep the
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

The scope of the last one is huge since almost all filesystems need to
do it once
a page is returned from page cache lookup by checking hwpoison flag
for every possible path.

This problem had been slightly discussed before, but seems no action
was taken at that time. [2]

I already converted shmem/tmpfs [3] since it seems more severe for
in-memory filesystem. The hugetlbfs is in-memory filesystem as well,
but it depends on double mapping support for hugeltbfs in order to set
hwpoisoned flag on subpage per the discussion with hugetlb folks.

Regular filesystems are definitely on the list as well. I understand
the problem may be very rare, but it is quite subtle so even if data
corruption is met it is very hard to root to it. So I'd like to
suggest this topic. It is related to both MM and FS, although the
heavy lift is on the FS side.

[1] https://lore.kernel.org/linux-mm/CAHbLzkqNPBh_sK09qfr4yu4WTFOzRy+MKj+PA7iG-adzi9zGsg@mail.gmail.com/T/#m0e959283380156f1d064456af01ae51fdff91265

[2] https://lore.kernel.org/lkml/20210318183350.GT3420@casper.infradead.org/

[3] https://lore.kernel.org/linux-mm/20211020210755.23964-1-shy828301@gmail.com/
