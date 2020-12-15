Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A232DAD62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 13:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgLOMky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 07:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgLOMkx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:40:53 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8F0C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 04:40:13 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id ga15so27454186ejb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 04:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cg7Gn7dAZDw1ehWTCIK8wOa7MiG0DcwcKiNrTya0UkM=;
        b=NWyfwITlkuwr1CV1nsn0yOQJnM7y+4/l5Rw0QZtR1YBieaanbHXzPxGPqVai/DIkkZ
         N/qRivbDfWdGqR1iV6BtAxZh0iTH56AJ1uv3iaCDkexTblRk7oBnmfcfzZMtSBJF5XUE
         w3Vg0zZMZA0ksWQnTP71e6LXikB1KJTKIcW04qMix7k9Khks+POW9oe2OQluBaInbJ6h
         6jPv+f4gKJGkORXQnAfkZMCSHNMPgPfuLKLp8//YdLZFOX21+VS4E3ZsZ+D9jHmBHN9k
         GxXOdvu52l01iTfn8ztlyo80SiKcK1pcIzNYw4svthSFsDjBXx+zdMTEbQCnqudHY4cd
         DyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cg7Gn7dAZDw1ehWTCIK8wOa7MiG0DcwcKiNrTya0UkM=;
        b=Ze7FLmYd02NJuPQnl91LBl/gUSNaxq8pqndUqV05/RugzKCKEmzstSJGkI9xXK6W9Y
         aaZztx+SP7fB1St2ti4Y9n2bTHkEmua1EtGpoSdEqNJ222xS15Lf+SEEHbCTLpy6ZzLw
         jyy1voD0bb1rjs8/VgD6ETL1FBUTOx17MJPSambAe7D9zilbTgd70a+/cKhXMiHrPBRf
         6IyzjkA/a83tvh2veIrqxVi/Wri7EjLF5VyV3N0gTl0IUxyecp5HEKe1vq81XjCKCI2j
         r32d+RJnEGzhFpNZynF08yn+7R+5ph7NM5yTojs9yGyYb5Ve8gUGFzDEkjYGT+LGHC7t
         HvRQ==
X-Gm-Message-State: AOAM532B7DQJZKtOrafecXuN1IpEesAq3PpSGn6our1AbQzzZiSZy+aB
        CORSyg8p3G97k9Qwiae/Hf1xig==
X-Google-Smtp-Source: ABdhPJyE6KUU3W+/Z3Rw/dn2XgvoPAuWslONYs5DZze7rIGq07IUkKI8m/0uBv7lGH13Kk33wZkQ7g==
X-Received: by 2002:a17:906:d62:: with SMTP id s2mr27036601ejh.61.1608036011994;
        Tue, 15 Dec 2020 04:40:11 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:d6dd])
        by smtp.gmail.com with ESMTPSA id x20sm1276312ejv.66.2020.12.15.04.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 04:40:10 -0800 (PST)
Date:   Tue, 15 Dec 2020 13:38:02 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 3/9] mm: vmscan: guarantee shrinker_slab_memcg() sees
 valid shrinker_maps for online memcg
Message-ID: <20201215123802.GA379720@cmpxchg.org>
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
> 
> So the memory ordering could be guaranteed by smp_wmb()/smp_rmb() pair.
> 
> The memory barriers pair will guarantee the ordering between shrinker_deferred and CSS_ONLINE
> for the following patches as well.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

As per previous feedback, please move the misplaced shrinker
allocation callback from .css_online to .css_alloc. This will get you
the necessary ordering guarantees from the cgroup core code.

Thanks
