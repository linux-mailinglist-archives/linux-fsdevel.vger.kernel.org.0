Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E1650C5B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 02:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiDWAaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 20:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiDWAao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:30:44 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3CD6D4E6;
        Fri, 22 Apr 2022 17:27:48 -0700 (PDT)
Date:   Fri, 22 Apr 2022 17:27:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650673667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XwFF1A7SiuFl1/Uh2mJXT54VhE2HR1r71xU373I5YNM=;
        b=l/XGEbFO7gqD24thsCKUb4MeMMbv4zsqVLfsR7ioqtnTCt61bZnF+V3lhM7Z0vGcL1qtkD
        osLaWYi8C2cz/4ONfCe8lr6w5zrLod/m6h6wE4MzYngrQezmGMjmNfr2U8LxNJ5Y4qUwlJ
        JgoRLDStU2Evm83C+zKg1Ck8FeOGO9w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2 8/8] mm: Centralize & improve oom reporting in
 show_mem.c
Message-ID: <YmNH/fh8OwTJ6ASC@carbon>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-14-kent.overstreet@gmail.com>
 <YmKma/1WUvjjbcO4@dhcp22.suse.cz>
 <YmLFPJTyoE4GYWp4@carbon>
 <20220422234820.plusgyixgybebfmi@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422234820.plusgyixgybebfmi@moria.home.lan>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 07:48:20PM -0400, Kent Overstreet wrote:
> On Fri, Apr 22, 2022 at 08:09:48AM -0700, Roman Gushchin wrote:
> > To add a concern: largest shrinkers are usually memcg-aware. Scanning
> > over the whole cgroup tree (with potentially hundreds or thousands of cgroups)
> > and over all shrinkers from the oom context sounds like a bad idea to me.
> 
> Why would we be scanning over the whole cgroup tree? We don't do that in the
> vmscan code, nor the new report. If the OOM is for a specific cgroup, we should
> probably only be reporting on memory usage for that cgroup (show_mem() is not
> currently cgroup aware, but perhaps it should be).

You're scanning over a small portion of all shrinker lists (on a machine with
cgroups), so the top-10 list has little value.
Global ->count_objects() return the number of objects on the system/root_mem_cgroup
level, not the shrinker's total.

> 
> > IMO it's more appropriate to do from userspace by oomd or a similar daemon,
> > well before the in-kernel OOM kicks in.
> 
> The reason I've been introducing printbufs and the .to_text() method was
> specifically to make this code general enough to be available from
> sysfs/debugfs - so I see no reasons why a userspace oomd couldn't make use of it
> as well.

Of course, I've nothing against adding .to_text().

> 
> > > Last but not least let me echo the concern from the other reply. Memory
> > > allocations are not really reasonable to be done from the oom context so
> > > the pr_buf doesn't sound like a good tool here.
> > 
> > +1
> 
> In my experience, it's rare to be _so_ out of memory that small kmalloc
> allocations are failing - we'll be triggering the show_mem() report before that
> happens.

I agree. However the OOM killer _has_ to make the progress even in such rare
circumstances.
