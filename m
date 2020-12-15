Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CA72DB261
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 18:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgLORR3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 12:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgLORR3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 12:17:29 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A6FC0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 09:16:48 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id ce23so28796874ejb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 09:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yKB5P3mmMeccCVq/i2dQ6a1JB3M5e9Un7Ow5i/UnWnM=;
        b=zA5A/pRfIGe07vij4DySDUNXt3hgH73LPDdRgKaBBAACVFoNgxY22zOM7GP3MmMhYB
         2FQnEUV0TsjZkJ3s4aWTOvRVinmxuDRMe7n7ShuAoxTviyZUA6qf218W7cq3WzXeQIfF
         TDbPmUP7swZqJXRGQ+LJX3ygthciPd9sbzqcF+q6PgW5PhMAo+36mjNAb+EO1t0jhUdy
         eMqS18FNCvjazQYxVQ0DEtmAqRe/6zoEUN22fLXP1oWbxT4kzEUnaJKzePjcYmgoDHyu
         PA9wSgVvbHJi720EjncVezvahEqjjBnRT6GCDHFkG9uMWoIu8KzrwLdbhqBx4iFYv+/s
         pD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKB5P3mmMeccCVq/i2dQ6a1JB3M5e9Un7Ow5i/UnWnM=;
        b=czidJpLP6k/gz6g0ZF07ZtQQRirbv4cgXPzNr/ZqGmGggRWXSxxu0FKpZ6PqUlH82K
         TFogr8IUfrPhdKUlK4XzA9i3MOUP7K0wnSB2eyqHx5qOkNo+xVX1jdSC3uv4T6Jzxj3c
         ghNAxWFKwEyJbLHuTArMX6Rb7Gu3o3khAJ5X55V/FnOQCd6SBYF4LtqzjvVQgtkp1Ybo
         A3w/Gz6eDZDmMPhafA0D41Q+IxXKpaHVXFKn8OxcVSFojEX+0uqUJFeUnsHaUC/nDhrp
         VzeDvMjHoMCiyFVDre60G/jed19mgJzYhs+x51gAtlXrNvn3MHI3SMf+T0fzMdXtEyxe
         uqKQ==
X-Gm-Message-State: AOAM530YeMW22oAd8wbOSU/xwjwWdQoUlhLglI8Xn0LR+n87rytW6jAA
        /wQefEvclkv6Rk7pE9rzJqrUbQ==
X-Google-Smtp-Source: ABdhPJx9oFI8c9NRCINhaYG2c8gjCFS/T3A9/B5lRKTP1ltaeZSxYbQLlICQTj8j2vsLhSYLIbYb1A==
X-Received: by 2002:a17:906:a181:: with SMTP id s1mr14149482ejy.60.1608052607054;
        Tue, 15 Dec 2020 09:16:47 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:d6dd])
        by smtp.gmail.com with ESMTPSA id z24sm18899199edr.9.2020.12.15.09.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 09:16:46 -0800 (PST)
Date:   Tue, 15 Dec 2020 18:14:39 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 3/9] mm: vmscan: guarantee shrinker_slab_memcg() sees
 valid shrinker_maps for online memcg
Message-ID: <20201215171439.GC385334@cmpxchg.org>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-4-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214223722.232537-4-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 02:37:16PM -0800, Yang Shi wrote:
> The shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
> in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that we will see
> memcg->nodeinfo[nid]->shrinker_maps != NULL.  This may occur because of processor reordering
> on !x86.
> 
> This seems like the below case:
> 
>            CPU A          CPU B
> store shrinker_map      load CSS_ONLINE
> store CSS_ONLINE        load shrinker_map

But we have a separate check on shrinker_maps, so it doesn't matter
that it isn't guaranteed, no?

The only downside I can see is when CSS_ONLINE isn't visible yet and
we bail even though we'd be ready to shrink. Although it's probably
unlikely that there would be any objects allocated already...

Can somebody remind me why we check mem_cgroup_online() at all?

If shrinker_map is set, we can shrink: .css_alloc is guaranteed to be
complete, and by using RCU for the shrinker_map pointer, the map is
also guaranteed to be initialized. There is nothing else happening
during onlining that you may depend on.

If shrinker_map isn't set, we cannot iterate the bitmap. It does not
really matter whether CSS_ONLINE is reordered and visible already.

Agreed with Dave: if we need that synchronization around onlining, it
needs to happen inside the cgroup core. But I wouldn't add that until
somebody actually required it.
