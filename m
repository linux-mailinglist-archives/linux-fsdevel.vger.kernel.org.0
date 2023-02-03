Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7070688B45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 01:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjBCABR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 19:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjBCABP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:01:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC5B841AB
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Feb 2023 16:01:00 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o16-20020a17090ad25000b00230759a8c06so448043pjw.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Feb 2023 16:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=87LqBY1cmxJIDzlBwcArixEGRBUdoaZyq1gL8jLOlBo=;
        b=DLV66Jzr/7xWnW/DB5gYUzwmub8DiPYt26/ICu8uqaIhyj/Y69zetvYZjUSTNA7JP4
         oVFIW77wI167XlBLdmGFDdBQltemXKC02tY+062ITt7Fz7d2TNa4f42A+jhli5StHy08
         4llhwpGMDi0YoGL3ASI82cb0n+Jneqd4L8TQs/k8Bl7K34gebF7CtuiqCdXKrXEMHzWG
         +78I7Fd6vJv9IAIj+P8oUAjNdRi92lx+gwfIj1aM6vDJk7BZXhxx+xsLu76rYXE4iMux
         BKyGx4MS/N9hjYr2+vYpvxDJcYByMMdDkUAB25zywwQdmKUb4WsI5MtyEeLjFgjw4eg+
         aFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87LqBY1cmxJIDzlBwcArixEGRBUdoaZyq1gL8jLOlBo=;
        b=QiNHSfZPoGGahzCJh0zrfZVPQT2MnstpVtwxmouspeAsy5Gy6fkLrOqkoUS76gXxXF
         IMMK9yVepuviF+ucefw/taYukm96Q0dAXWD7cPzORLtU3wDEx1pGcFr067w+VPG+QQGo
         0c7fJ3bNMN01GgSysOMhi2eDTGJAtGkxVfaSxwOnXZjdsQqj63WRKmNcCpCq0iaPCVWu
         yqTPPP5MrIyyevIHsw8oEmHPbRn5VhnbZ9Widju2IpTw6cpBqHh3yHj1nE3skHoxjdw/
         ikZCOlCK3r2mCCLEBqQ0tAJ3a9mnrqlaWTnUYzMEP0hEV3gCDUYIcxOA98PoxdOAfZLJ
         ho7A==
X-Gm-Message-State: AO0yUKUhYnLZoEIm5+8AVpL6KSoO60/tJtH4r42Dxvhg0rB2TPF2IiDj
        dxaOUoKaNTPJXdjtgyK3cRGqYg==
X-Google-Smtp-Source: AK7set9JaCKtnriracbwmug7u2ZHT3TTrBbzfIKwL1tiM1SyRqwMx3ca50uMJGBzPDJ4jy/LfeFDhg==
X-Received: by 2002:a17:902:f0d1:b0:198:dec0:c926 with SMTP id v17-20020a170902f0d100b00198dec0c926mr231076pla.21.1675382460437;
        Thu, 02 Feb 2023 16:01:00 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id x190-20020a6263c7000000b00593a1f7c3dbsm292980pfb.10.2023.02.02.16.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:00:59 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pNjVh-00AfBG-Cq; Fri, 03 Feb 2023 11:00:57 +1100
Date:   Fri, 3 Feb 2023 11:00:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/2] Ignore non-LRU-based reclaim in memcg reclaim
Message-ID: <20230203000057.GS360264@dread.disaster.area>
References: <20230202233229.3895713-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202233229.3895713-1-yosryahmed@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 02, 2023 at 11:32:27PM +0000, Yosry Ahmed wrote:
> Reclaimed pages through other means than LRU-based reclaim are tracked
> through reclaim_state in struct scan_control, which is stashed in
> current task_struct. These pages are added to the number of reclaimed
> pages through LRUs. For memcg reclaim, these pages generally cannot be
> linked to the memcg under reclaim and can cause an overestimated count
> of reclaimed pages. This short series tries to address that.

Can you explain why memcg specific reclaim is calling shrinkers that
are not marked with SHRINKER_MEMCG_AWARE?

i.e. only objects that are directly associated with memcg aware
shrinkers should be accounted to the memcg, right? If the cache is
global (e.g the xfs buffer cache) then they aren't marked with
SHRINKER_MEMCG_AWARE and so should only be called for root memcg
(i.e. global) reclaim contexts.

So if you are having accounting problems caused by memcg specific
reclaim on global caches freeing non-memcg accounted memory, isn't
the problem the way the shrinkers are being called?

> Patch 1 is just refactoring updating reclaim_state into a helper
> function, and renames reclaimed_slab to just reclaimed, with a comment
> describing its true purpose.
> 
> Patch 2 ignores pages reclaimed outside of LRU reclaim in memcg reclaim.
> 
> The original draft was a little bit different. It also kept track of
> uncharged objcg pages, and reported them only in memcg reclaim and only
> if the uncharged memcg is in the subtree of the memcg under reclaim.
> This was an attempt to make reporting of memcg reclaim even more
> accurate, but was dropped due to questionable complexity vs benefit
> tradeoff. It can be revived if there is interest.
> 
> Yosry Ahmed (2):
>   mm: vmscan: refactor updating reclaimed pages in reclaim_state
>   mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
> 
>  fs/inode.c           |  3 +--

Inodes and inode mapping pages are directly charged to the memcg
that allocated them and the shrinker is correctly marked as
SHRINKER_MEMCG_AWARE. Freeing the pages attached to the inode will
account them correctly to the related memcg, regardless of which
memcg is triggering the reclaim.  Hence I'm not sure that skipping
the accounting of the reclaimed memory is even correct in this case;
I think the code should still be accounting for all pages that
belong to the memcg being scanned that are reclaimed, not ignoring
them altogether...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
