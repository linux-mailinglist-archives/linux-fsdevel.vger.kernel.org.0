Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC37297167
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750661AbgJWOhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 10:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372730AbgJWOhN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:37:13 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50526C0613CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2020 07:37:13 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o14so1541722otj.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2020 07:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ue1eoYp/rV3X5fZ+14rS63RmMW1v9BsYmIiuPRkgMlc=;
        b=M8kF83YM7xkRfHNyf/imBorp00wSjhbgh/S8X7DXov96K6NtfkVZ7v9QVfIAfZA9H9
         O7EQwr6GuFK75XbpMbj/wQE2MrtKGKUaELIbUX3Dj3BYu3iF0wd3dYl4sruBBDTnyJgg
         Zx8zI5CS4WAbjTeKFiU1Htb5hwRJFgP2ypNP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ue1eoYp/rV3X5fZ+14rS63RmMW1v9BsYmIiuPRkgMlc=;
        b=a5XeckBUDNzgNrlkEzwiMH/w+S0Ap7dwyXX0u3QUPgHOQ46U89ORb1aZ/KFdd865lK
         mNZqZXaFIWg8VGo8h4fRb8/TrsHlGvcQSQE6IQDyYnEIPJA3Dwd02x9RTWgAov4t/7nz
         Y46utRP+/ATQjJHQlJnURZtpZk1gYAJ9YMhmS5j0jdmowSAQFZXRa2i8x7MftSz0wQ6v
         xCwpw2S/9gNUHHADRzmskDnX4bEk8cYtI27NKNNqSfoNqv+4MKzWZ2FdrWZKH6+yWusp
         X0yBETslMRbjJss95Yf0t8N8q2z5ggVk6Fnnx8mB2/7cS+UOMmNiiMxJKLqEkHp6DHQE
         LfZA==
X-Gm-Message-State: AOAM533L6FRf2wVcGURy2td0kcdKj1XZk3ciaSRy1y2dHEjRuE2Z0gWh
        pcfaXdROBQ4FA1+/aAJ5Xx5zBEEW6kA0Yzlfvna6/g==
X-Google-Smtp-Source: ABdhPJyi58HmdEa7AIVzkzyqQTfTPkHR4zZzgTo7KlLhbs3gCVZsj5F1oZVA2pGhIrfdST5nhUdlVgXIJM7T0/Qt6U4=
X-Received: by 2002:a05:6830:1647:: with SMTP id h7mr1951924otr.281.1603463832695;
 Fri, 23 Oct 2020 07:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201021163242.1458885-1-daniel.vetter@ffwll.ch>
 <20201023122216.2373294-1-daniel.vetter@ffwll.ch> <20201023122216.2373294-4-daniel.vetter@ffwll.ch>
 <20201023141619.GC20115@casper.infradead.org>
In-Reply-To: <20201023141619.GC20115@casper.infradead.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 23 Oct 2020 16:37:01 +0200
Message-ID: <CAKMK7uESHHHzEC2U3xVKQEBZqS5xwQJeYFpwMz3b8OaoFEYcUQ@mail.gmail.com>
Subject: Re: [PATCH 04/65] mm: Extract might_alloc() debug check
To:     Matthew Wilcox <willy@infradead.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michel Lespinasse <walken@google.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>, Qian Cai <cai@lca.pw>,
        linux-xfs@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 23, 2020 at 4:16 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Oct 23, 2020 at 02:21:15PM +0200, Daniel Vetter wrote:
> > Note that unlike fs_reclaim_acquire/release gfpflags_allow_blocking
> > does not consult the PF_MEMALLOC flags. But there is no flag
> > equivalent for GFP_NOWAIT, hence this check can't go wrong due to
> > memalloc_no*_save/restore contexts.
>
> I have a patch series that adds memalloc_nowait_save/restore.

tbh this was a typoed git send-email, but thanks for the heads-up,
I'll adjust the patch accordingly.

Cheers, Daniel

> https://lore.kernel.org/linux-mm/20200625113122.7540-7-willy@infradead.org/



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
