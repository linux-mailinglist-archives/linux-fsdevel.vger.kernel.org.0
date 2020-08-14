Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87022244684
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 10:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHNIfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 04:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgHNIfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:35:51 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01681C061384
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2020 01:35:50 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id x2so4778761ybf.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2020 01:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdqxtBBzE8zkm3kxwd6M5EQuKDKvTyliTVOnv4Gy5lw=;
        b=oqVy0fpsXt6mcaf8A0SC3B/hbz8tbu1sLp+p2pRxvv8AbXvXwBHIFsfkMCRqNri3GF
         qJ5LaxL7IMvfVknso37KHelMIw8Dd2z7cxXhdshfuODzyH2Xseg89iJdaKUlQjvHq7Hq
         lhVM/0EfF59L/acBDsdGpzOFVzg978mH+5YR0Xnus5a+hauEXlwXVyH0k/uzyUQXeOV+
         GoD9sItD5ZTLV2cb+jVfv+1qVPtgrDmNyETiLEcVRayEQDHThAdY1wjwZE3Exe3WMAGf
         B0CMyWrcmpON8PTov2dXTjRTU6wL6B8HVQWcoUhp+BuAHQUBWllyB0qzr6niC+D7+S2F
         fxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdqxtBBzE8zkm3kxwd6M5EQuKDKvTyliTVOnv4Gy5lw=;
        b=r8dgaYVreA2ShYgFSJDES0Muc/hcvWi8/BD+DyFDoNQe+E+427POae+NHgLHs/5yQ4
         NGkdfDL1RhHslVlA7iSQV2IogGdQOXm5FHU5s34+prRbLa5RsocTJ/LxuaIp3Zx6SW2l
         II3PVzvtbnpx7CuSDi7GRuggijtqcSrPJK8neOO8CrgDWadlHTlkTQiw07AbhzbV5U6f
         mW+eLkGQ/zt9r0O0RNcWAn9QAxufkbYx+gnBOuO9OzdAwNgzSGOQctpZJGt0WhpE11y8
         eY1+4a6m1wDZdmnJObTSsTIm9UWaTUgS99iUqdrg6F2BnlhDw/Uvgszixv1u47SozB69
         b5Cg==
X-Gm-Message-State: AOAM531ugYWFI07jlpqlv8kWwhGPPlk/sbyEz4JSSkrlNKWso4fyDm1X
        4DhtQq6q1YDKUJS9q8emKvN0xDVGFcwILk4UhBllkQ==
X-Google-Smtp-Source: ABdhPJy4hZxzSJG2zp9/9fyOvZB1bpfPoOKRLt/YSmrRg6wSBSlJmdqUtSRvhcYGxO1/TjNY1yNIgU0oMFRVQUhfajs=
X-Received: by 2002:a25:7455:: with SMTP id p82mr2121422ybc.287.1597394149918;
 Fri, 14 Aug 2020 01:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com> <1597284810-17454-3-git-send-email-chinwen.chang@mediatek.com>
In-Reply-To: <1597284810-17454-3-git-send-email-chinwen.chang@mediatek.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 14 Aug 2020 01:35:37 -0700
Message-ID: <CANN689FtCsC71cjAjs0GPspOhgo_HRj+diWsoU1wr98YPktgWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: proc: smaps_rollup: do not stall write
 attempts on mmap_lock
To:     Chinwen Chang <chinwen.chang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Price <steven.price@arm.com>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 7:13 PM Chinwen Chang
<chinwen.chang@mediatek.com> wrote:
> smaps_rollup will try to grab mmap_lock and go through the whole vma
> list until it finishes the iterating. When encountering large processes,
> the mmap_lock will be held for a longer time, which may block other
> write requests like mmap and munmap from progressing smoothly.
>
> There are upcoming mmap_lock optimizations like range-based locks, but
> the lock applied to smaps_rollup would be the coarse type, which doesn't
> avoid the occurrence of unpleasant contention.
>
> To solve aforementioned issue, we add a check which detects whether
> anyone wants to grab mmap_lock for write attempts.

I think your retry mechanism still doesn't handle all cases. When you
get back the mmap lock, the address where you stopped last time could
now be in the middle of a vma. I think the consistent thing to do in
that case would be to retry scanning from the address you stopped at,
even if it's not on a vma boundary anymore. You may have to change
smap_gather_stats to support that, though.
