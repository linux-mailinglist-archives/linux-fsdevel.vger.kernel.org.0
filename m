Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E8050A847
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 20:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391499AbiDUSpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 14:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391497AbiDUSpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:45:07 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041404BFE8;
        Thu, 21 Apr 2022 11:42:17 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id b17so4328351qvp.6;
        Thu, 21 Apr 2022 11:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ILPYEi6EpMIBrPlORAyxArgIQC8qGPRB7ecYXue0XE=;
        b=qDmzbvel2H0KQCr02PQ03kcpCNG1E0o1whuTsEYnThkFJUJ3sNvJwvYgqQNIfs8nb2
         +uxVbcWINFlGgkA0JTlJ17pQPcwYqapj7+NXT+Vl1uRZwntc/MjFx/jQNWeui09wDO6I
         enMYLsEQYMMBazGc2rwLdSoHwjEA+d2O/26j3XPoaF6ZxCaHekns4iN8ZA97dOxIl0AM
         lxo81oYseH4u3QOktWkxdxYIi4eyezIegBO5RzwJtz6gQ10uA+wEbGa0J0VIuNC55sJR
         4wBB8ugemw65dSMTj2vi/ZTx44ijQ4ZpCRZSnKz+3QGyW1zQs7fdbetClU9+jUxoj4db
         58MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ILPYEi6EpMIBrPlORAyxArgIQC8qGPRB7ecYXue0XE=;
        b=jVJ523XDl7XVHLWLxqLVSfdT+/UynT26FkilOfTf50xqR2MjsLdsUL1dzbIqA9TvsP
         bqgKpAY6Wo2u1OC39XkmYVpGcDpRWA9Gz8Qf4+ShF11YzTVEIogM/t/yPCwshA2VVN0P
         CzSzwKAbEAP58/M6Ap/3rfAqNbKvBEUookQJprfPh4p5dEb60M4UA+3/FplepQU6HcQz
         1SvwdnGtWzpmUvNnVn3XeeMjMKI2ycLqv1OXaKn6k295Hp0jLY+eRUggGtAxBTLMkxJs
         NSPlBsVIzPAhaToR9JnU7NiKGUm/Ldi0Psfp6ch4Zke+d/Id1Ufo1s4A8qgFPpGeAtz/
         hyBw==
X-Gm-Message-State: AOAM533W13bM5m9w8MCkFDWRJopnvaYFPl6pq9X7hLKemki7ty8KByi0
        GyFewxbM3yDUCOA2bZxscpdWYOm9vw==
X-Google-Smtp-Source: ABdhPJzQJ3l45+fADcNjJxP40bzPfKP0UgQ3xjcQbrwZ3ZPLYX0JvwMaErQtwe4c7GeKvQgDEaE8Yw==
X-Received: by 2002:a05:6214:1ccd:b0:443:652e:69d with SMTP id g13-20020a0562141ccd00b00443652e069dmr681924qvd.114.1650566536135;
        Thu, 21 Apr 2022 11:42:16 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 9-20020a05620a070900b0069e60da45aasm3171683qkc.60.2022.04.21.11.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:42:15 -0700 (PDT)
Date:   Thu, 21 Apr 2022 14:42:13 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 3/4] mm: Centralize & improve oom reporting in show_mem.c
Message-ID: <20220421184213.tbglkeze22xrcmlq@moria.home.lan>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
 <20220419203202.2670193-4-kent.overstreet@gmail.com>
 <Yl+vHJ3lSLn5ZkWN@dhcp22.suse.cz>
 <20220420165805.lg4k2iipnpyt4nuu@moria.home.lan>
 <YmEhXG8C7msGvhqL@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmEhXG8C7msGvhqL@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:18:20AM +0200, Michal Hocko wrote:
> On Wed 20-04-22 12:58:05, Kent Overstreet wrote:
> > On Wed, Apr 20, 2022 at 08:58:36AM +0200, Michal Hocko wrote:
> > > On Tue 19-04-22 16:32:01, Kent Overstreet wrote:
> > > > This patch:
> > > >  - Moves lib/show_mem.c to mm/show_mem.c
> > > 
> > > Sure, why not. Should be a separate patch.
> > > 
> > > >  - Changes show_mem() to always report on slab usage
> > > >  - Instead of reporting on all slabs, we only report on top 10 slabs,
> > > >    and in sorted order
> > > >  - Also reports on shrinkers, with the new shrinkers_to_text().
> > > 
> > > Why do we need/want this? It would be also great to provide an example
> > > of why the new output is better (in which cases) than the existing one.
> > 
> > Did you read the cover letter to the patch series?
> 
> Nope, only this one made it into my inbox based on my filters. I usually
> try to fish out other parts of the thread but I didn't this time.
> Besides it is always better to have a full patch description explain not
> only what has been changed but why as well.
> 
> > But sure, I can give you an example of the new output:
> 
> Calling out the changes would be really helpful, but I guess the crux 
> is here.
> 
> > 00177 16644 pages reserved
> > 00177 Unreclaimable slab info:
> > 00177 9p-fcall-cache    total: 8.25 MiB active: 8.25 MiB
> > 00177 kernfs_node_cache total: 2.15 MiB active: 2.15 MiB
> > 00177 kmalloc-64        total: 2.08 MiB active: 2.07 MiB
> > 00177 task_struct       total: 1.95 MiB active: 1.95 MiB
> > 00177 kmalloc-4k        total: 1.50 MiB active: 1.50 MiB
> > 00177 signal_cache      total: 1.34 MiB active: 1.34 MiB
> > 00177 kmalloc-2k        total: 1.16 MiB active: 1.16 MiB
> > 00177 bch_inode_info    total: 1.02 MiB active: 922 KiB
> > 00177 perf_event        total: 1.02 MiB active: 1.02 MiB
> > 00177 biovec-max        total: 992 KiB active: 960 KiB
> > 00177 Shrinkers:
> > 00177 super_cache_scan: objects: 127
> > 00177 super_cache_scan: objects: 106
> > 00177 jbd2_journal_shrink_scan: objects: 32
> > 00177 ext4_es_scan: objects: 32
> > 00177 bch2_btree_cache_scan: objects: 8
> > 00177   nr nodes:          24
> > 00177   nr dirty:          0
> > 00177   cannibalize lock:  0000000000000000
> > 00177 
> > 00177 super_cache_scan: objects: 8
> > 00177 super_cache_scan: objects: 1
> 
> How does this help to analyze this allocation failure?

You asked for an example of the output, which was an entirely reasonable
request. Shrinkers weren't responsible for this OOM, so it doesn't help here -
are you asking me to explain why shrinkers are relevant to OOMs and memory
reclaim...?

Since shrinkers own and, critically, _are responsible for freeing memory_, a
shrinker not giving up memory when asked (or perhaps not being asked to give up
memory) can cause an OOM. A starting point - not an end - if we want to improve
OOM debugging is at least being able to see how much memory each shrinker owns.
Since we don't even have that, number of objects will have to do.

The reason for adding the .to_text() callback is that shrinkers have internal
state that affects whether they are able to give up objects when asked - the
primary example being object dirtyness.

If your system is using a ton of memory caching inodes, and something's wedged
writeback, and they're nearly all dirty - you're going to have a bad day.

The bcachefs btree node node shrinker included as an example of what we can do
with this: internally we may have to allocate new btree nodes by reclaiming from
our own cache, and we have a lock to prevent multiple threads from doing this at
the same time, and this lock also blocks the shrinker from freeing more memory
until we're done.

In filesystem land, debugging memory reclaim issues is a rather painful topic
that often comes up, this is a starting point...
