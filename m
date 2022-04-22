Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1821D50B729
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447278AbiDVMYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447391AbiDVMYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:24:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA60E56770;
        Fri, 22 Apr 2022 05:21:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0DDE3212B7;
        Fri, 22 Apr 2022 12:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650630107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QUoGjQVg/gKwE2jcF+F4y++onpzGvazarbd0xM/LAk4=;
        b=SuNEDHULF+Y11ebVN3hJaCb9EKfm4mdnr353vh83vrm+EanCvB1hRP3nINICq9Lhthrb2A
        wZfQsgJw6EJeakU9H1WGDI3TiiZtp0zacRu8Esc+u7vmwEVtYK0u9Ihlj68adoOqwD+Gq4
        1FAKWqL+AFplDInvwUHRrsQ9PlaYvs4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B25212C142;
        Fri, 22 Apr 2022 12:21:46 +0000 (UTC)
Date:   Fri, 22 Apr 2022 14:21:46 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 2/4] mm: Add a .to_text() method for shrinkers
Message-ID: <YmKd2iHTHuzaTkE6@dhcp22.suse.cz>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-3-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421234837.3629927-3-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-04-22 19:48:26, Kent Overstreet wrote:
> This adds a new callback method to shrinkers which they can use to
> describe anything relevant to memory reclaim about their internal state,
> for example object dirtyness.
> 
> This uses the new printbufs to output to heap allocated strings, so that
> the .to_text() methods can be used both for messages logged to the
> console, and also sysfs/debugfs.
> 
> This patch also adds shrinkers_to_text(), which reports on the top 10
> shrinkers - by object count - in sorted order, to be used in OOM
> reporting.

Let's put aside whether doing the sorting is useful or not for a moment.
The primary concern I have here is that pr_buf is internally relying on
memory allocations. This makes it really risky to use from the OOM path
which is the primary motivation here AFAICS.

Especially the oom killer path where we _know_ the memory is depleted.
The only way to pursue the allocation is to rely on PF_MEMALLOC and
memory reserves.

If you want to have a generic way to dump shrinker's internal state then
those would really need a prellocated buffer and .to_text would need to
be documented to not depend on any locking that could be directly or
indirectly depending on memory allocations.

> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  include/linux/shrinker.h |  5 +++
>  mm/vmscan.c              | 75 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
-- 
Michal Hocko
SUSE Labs
