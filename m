Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1216245CF8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 23:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbhKXWHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 17:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343549AbhKXWHu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 17:07:50 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F15DC06173E
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 14:04:40 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id b67so5463820qkg.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 14:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wnb56ZlXImyESxNGtft70OqOtQf36rXcNYeS2LPN9Hw=;
        b=TI8Ja/xF0rPlSq0XbH+Z7yi5SswZbFWopo2KUC+FP/Iq/PcR2rlzmFLMIj4QV03dcF
         YFUYfCfagoudNqaumEWziKMiWQsVBe/nYWESt1ElhUaQH0p2TYtI+XXrWnFxDi4JPhkn
         J9IE4NuQF6CPpF6Ci1vk5p5mPw939HjAOacCQtJhelXJspwRORvL+V7PPRUjf2Risto8
         4BHcTy/AhBEV/9E1wBryWAoNy5lDrTYyo38hC4OwWqxQtqKZJNOijMyqb/KzruZRt+sQ
         PkQ+AiAtFXLi1/WQoI2Fzf6KIe4dEM3YVJ6C79I+lq6D360kEnRvX067qmAV0N2pUquu
         c7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wnb56ZlXImyESxNGtft70OqOtQf36rXcNYeS2LPN9Hw=;
        b=IG1b9U1fNG9ADaHG/bUFwhkriGJ9u7Dh0I2UtVMs8KF3QKpFeng56G56xsecU1it99
         LzfZNpVE0oPb12KMFy/0/jxLR2u7JtsuvQJXfMl+AXZev98UrXsQw7zwKFQWbyFsgZ8Q
         XSjdoSPlGMPtxNTR3K4avPnaRnmaRvpFCf47RFCP6kuqdnfiXGh16n6fB86ny/zVGFWU
         q5zsqQ86T1yjPRQWTD39d3s6pWMjR+QmK8WF43zp89XJl0wZoZGesY0I7nxkipKaCM8O
         3oHs0xCokSQS+p7w3OnllVAgGDkc59Ii+G6No6O3RS7lRvqpf2t7wWhXqchONabmUqdc
         b+nA==
X-Gm-Message-State: AOAM532BApE0NLOlYRvJ9dk/MUJQ4KBiJHjcVk5apqRknyiLaZgdjzjp
        ssSf8V8X/7Wq/Sw5+TXRNBSLc8LWuXkDVjuLAB+Rgg==
X-Google-Smtp-Source: ABdhPJyEaZfSCy9c2XfuDBLl28EATOu0ZCMDM9ldvjLGNLlmcFX5/ceoutE7bj1w59tq2T4LxJMGglhzfOaD2fWRpig=
X-Received: by 2002:a25:2f58:: with SMTP id v85mr407870ybv.487.1637791478911;
 Wed, 24 Nov 2021 14:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20211124193604.2758863-1-surenb@google.com> <YZ6wg9A5p5WUy7+k@cmpxchg.org>
In-Reply-To: <YZ6wg9A5p5WUy7+k@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 24 Nov 2021 14:04:28 -0800
Message-ID: <CAJuCfpGP3ZdeqfYZJ6SUCdnputU-sEOsNYx5Pd9ckL1-zuWC2w@mail.gmail.com>
Subject: Re: [PATCH 1/1] sysctl: change watermark_scale_factor max limit to 30%
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        dave.hansen@linux.intel.com, vbabka@suse.cz,
        mgorman@techsingularity.net, corbet@lwn.net, yi.zhang@huawei.com,
        xi.fengfei@h3c.com, rppt@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 1:37 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Nov 24, 2021 at 11:36:04AM -0800, Suren Baghdasaryan wrote:
> > For embedded systems with low total memory, having to run applications
> > with relatively large memory requirements, 10% max limitation for
> > watermark_scale_factor poses an issue of triggering direct reclaim
> > every time such application is started. This results in slow application
> > startup times and bad end-user experience.
> > By increasing watermark_scale_factor max limit we allow vendors more
> > flexibility to choose the right level of kswapd aggressiveness for
> > their device and workload requirements.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!

>
> No objection from me as this limit was always totally arbitrary. But I
> have to say I'm a bit surprised: The current maximum setting will wake
> kswapd when free memory drops below 10% and have it reclaim until
> 20%. This seems like quite a lot? Are there applications that really
> want kswapd to wake at 30% and target 60% of memory free?

The example I was given by a vendor was Camera application requiring
0.25G on 1GB device. Camera apps are notoriously memory hungry on
Android and on low-memory devices it can require more than 20% of
total memory to run.
