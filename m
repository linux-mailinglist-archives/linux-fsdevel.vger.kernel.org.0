Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BACE50BB64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 17:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448834AbiDVPN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 11:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449230AbiDVPMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:12:54 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB1F1083;
        Fri, 22 Apr 2022 08:09:58 -0700 (PDT)
Date:   Fri, 22 Apr 2022 08:09:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650640196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FuSilkQrD0XHypF9NHM/iQufTOifJtoJtKA0QjM80gQ=;
        b=ogvZvMz0qmRqn6QDbBgi2ylHy0TQA3uWaXlbE2Qr5PhovLBd6Wn+NU6jdRIreeLszV8F0T
        6vKrZZb2n1v73UODttDRnOV+VFz4bTzSb5v8lROD6lWxhYq1rSkVWs2ELGwxEOI0lkMR0a
        /6VVGN0zpZMKdJS97D22pC8bfMik1wM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 8/8] mm: Centralize & improve oom reporting in
 show_mem.c
Message-ID: <YmLFPJTyoE4GYWp4@carbon>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-14-kent.overstreet@gmail.com>
 <YmKma/1WUvjjbcO4@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmKma/1WUvjjbcO4@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 02:58:19PM +0200, Michal Hocko wrote:
> On Thu 21-04-22 19:48:37, Kent Overstreet wrote:
> > This patch:
> >  - Changes show_mem() to always report on slab usage
> >  - Instead of reporting on all slabs, we only report on top 10 slabs,
> >    and in sorted order
> 
> As I've already pointed out in the email thread for the previous
> version, this would be better in its own patch explaining why we want to
> make this unconditional and why to limit the number caches to print.
> Why the trashold shouldn't be absolute size based?
> 
> >  - Also reports on shrinkers, with the new shrinkers_to_text().
> >    Shrinkers need to be included in OOM/allocation failure reporting
> >    because they're responsible for memory reclaim - if a shrinker isn't
> >    giving up its memory, we need to know which one and why.
>
> Again, I do agree that information about shrinkers can be useful but
> there are two main things to consider. Do we want to dump that
> information unconditionaly? E.g. does it make sense to print for all
> allocation requests (even high order, GFP_NOWAIT...)? Should there be
> any explicit trigger when to dump this data (like too many shrinkers
> failing etc)?

To add a concern: largest shrinkers are usually memcg-aware. Scanning
over the whole cgroup tree (with potentially hundreds or thousands of cgroups)
and over all shrinkers from the oom context sounds like a bad idea to me.

IMO it's more appropriate to do from userspace by oomd or a similar daemon,
well before the in-kernel OOM kicks in.

> 
> Last but not least let me echo the concern from the other reply. Memory
> allocations are not really reasonable to be done from the oom context so
> the pr_buf doesn't sound like a good tool here.

+1
