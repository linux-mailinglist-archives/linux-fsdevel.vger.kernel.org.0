Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD18D509C1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 11:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387530AbiDUJVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 05:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387527AbiDUJVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:21:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DE911A09;
        Thu, 21 Apr 2022 02:18:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7EFF6212CA;
        Thu, 21 Apr 2022 09:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650532701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7eBoeABIzrU59GFjZQI069cJ6HARDP5/TtRlOQloOBo=;
        b=uaw03MuI4ElUFpe3+neihwPi2+k6evr5KXmuhswf5kzgAb7peR8yZVMpHk6W4JDml/wqfv
        OQy50xqoDcKdkuXbbPVjilWVuLL1LWLNfTjXThTiIJsWf5ewyRMAXvdIeFyAaGp2aGefmk
        lwKSi0+unRir7cS0PMk7z0kGCxX1YAg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F24C02C1AB;
        Thu, 21 Apr 2022 09:18:20 +0000 (UTC)
Date:   Thu, 21 Apr 2022 11:18:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 3/4] mm: Centralize & improve oom reporting in show_mem.c
Message-ID: <YmEhXG8C7msGvhqL@dhcp22.suse.cz>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
 <20220419203202.2670193-4-kent.overstreet@gmail.com>
 <Yl+vHJ3lSLn5ZkWN@dhcp22.suse.cz>
 <20220420165805.lg4k2iipnpyt4nuu@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420165805.lg4k2iipnpyt4nuu@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-04-22 12:58:05, Kent Overstreet wrote:
> On Wed, Apr 20, 2022 at 08:58:36AM +0200, Michal Hocko wrote:
> > On Tue 19-04-22 16:32:01, Kent Overstreet wrote:
> > > This patch:
> > >  - Moves lib/show_mem.c to mm/show_mem.c
> > 
> > Sure, why not. Should be a separate patch.
> > 
> > >  - Changes show_mem() to always report on slab usage
> > >  - Instead of reporting on all slabs, we only report on top 10 slabs,
> > >    and in sorted order
> > >  - Also reports on shrinkers, with the new shrinkers_to_text().
> > 
> > Why do we need/want this? It would be also great to provide an example
> > of why the new output is better (in which cases) than the existing one.
> 
> Did you read the cover letter to the patch series?

Nope, only this one made it into my inbox based on my filters. I usually
try to fish out other parts of the thread but I didn't this time.
Besides it is always better to have a full patch description explain not
only what has been changed but why as well.

> But sure, I can give you an example of the new output:

Calling out the changes would be really helpful, but I guess the crux 
is here.

> 00177 16644 pages reserved
> 00177 Unreclaimable slab info:
> 00177 9p-fcall-cache    total: 8.25 MiB active: 8.25 MiB
> 00177 kernfs_node_cache total: 2.15 MiB active: 2.15 MiB
> 00177 kmalloc-64        total: 2.08 MiB active: 2.07 MiB
> 00177 task_struct       total: 1.95 MiB active: 1.95 MiB
> 00177 kmalloc-4k        total: 1.50 MiB active: 1.50 MiB
> 00177 signal_cache      total: 1.34 MiB active: 1.34 MiB
> 00177 kmalloc-2k        total: 1.16 MiB active: 1.16 MiB
> 00177 bch_inode_info    total: 1.02 MiB active: 922 KiB
> 00177 perf_event        total: 1.02 MiB active: 1.02 MiB
> 00177 biovec-max        total: 992 KiB active: 960 KiB
> 00177 Shrinkers:
> 00177 super_cache_scan: objects: 127
> 00177 super_cache_scan: objects: 106
> 00177 jbd2_journal_shrink_scan: objects: 32
> 00177 ext4_es_scan: objects: 32
> 00177 bch2_btree_cache_scan: objects: 8
> 00177   nr nodes:          24
> 00177   nr dirty:          0
> 00177   cannibalize lock:  0000000000000000
> 00177 
> 00177 super_cache_scan: objects: 8
> 00177 super_cache_scan: objects: 1

How does this help to analyze this allocation failure?
-- 
Michal Hocko
SUSE Labs
