Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3383350B7C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447664AbiDVNBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 09:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiDVNBO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:01:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B68357178;
        Fri, 22 Apr 2022 05:58:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DB2B41F37F;
        Fri, 22 Apr 2022 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650632299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttueTufraI8o+nOH58tUB2QJPrzh4JNYOp+IJirkuvA=;
        b=YT4zeOCamq4IRrxGBDYOeDUQRJJaxapLMlJ2EGoaucQjpphuIf/+yafGsEdXPff4s31Lp2
        8FbOPH0RgFB2x89OTcLwqnfaCb1Mobh4Qf3O086ueI5IJnODHS7kkU8fpeZHLOAOa+Cx/5
        nHqMLobx1WdUD1azZx6Zzyru/glg+A0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A5FAB2C142;
        Fri, 22 Apr 2022 12:58:19 +0000 (UTC)
Date:   Fri, 22 Apr 2022 14:58:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        roman.gushchin@linux.dev
Subject: Re: [PATCH v2 8/8] mm: Centralize & improve oom reporting in
 show_mem.c
Message-ID: <YmKma/1WUvjjbcO4@dhcp22.suse.cz>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-14-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421234837.3629927-14-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-04-22 19:48:37, Kent Overstreet wrote:
> This patch:
>  - Changes show_mem() to always report on slab usage
>  - Instead of reporting on all slabs, we only report on top 10 slabs,
>    and in sorted order

As I've already pointed out in the email thread for the previous
version, this would be better in its own patch explaining why we want to
make this unconditional and why to limit the number caches to print.
Why the trashold shouldn't be absolute size based?

>  - Also reports on shrinkers, with the new shrinkers_to_text().
>    Shrinkers need to be included in OOM/allocation failure reporting
>    because they're responsible for memory reclaim - if a shrinker isn't
>    giving up its memory, we need to know which one and why.

Again, I do agree that information about shrinkers can be useful but
there are two main things to consider. Do we want to dump that
information unconditionaly? E.g. does it make sense to print for all
allocation requests (even high order, GFP_NOWAIT...)? Should there be
any explicit trigger when to dump this data (like too many shrinkers
failing etc)?

Last but not least let me echo the concern from the other reply. Memory
allocations are not really reasonable to be done from the oom context so
the pr_buf doesn't sound like a good tool here.

Also please make sure to provide an example of the output and _explain_
how the new output is better than the existing one.
-- 
Michal Hocko
SUSE Labs
