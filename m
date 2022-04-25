Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289F850DCB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbiDYJcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 05:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiDYJbc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:31:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF88224BDC;
        Mon, 25 Apr 2022 02:28:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7D8111F383;
        Mon, 25 Apr 2022 09:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650878907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJL7zOUPuNZbvSE5//FwsrKzEzvOELetv4Ge89BtuA0=;
        b=VG4XYrO3nQfUEqfTNJeoropkEgsIJ4SE83/etN9dphG2T+NFvfF/WhEGJkcg1PdHefBV1B
        lcBTrQWDcl54rpTEXSoTGOR6UTwTygtZiyVdkWEApTAxe74pOwdn1nW1AiJH00L9v7WMG0
        7ybbHu/wZj5vkTLsj9XjBNAOL5SXTWs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E6FC12C141;
        Mon, 25 Apr 2022 09:28:26 +0000 (UTC)
Date:   Mon, 25 Apr 2022 11:28:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH v2 8/8] mm: Centralize & improve oom reporting in
 show_mem.c
Message-ID: <YmZpuikkgWeF2RPt@dhcp22.suse.cz>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-14-kent.overstreet@gmail.com>
 <YmKma/1WUvjjbcO4@dhcp22.suse.cz>
 <YmLFPJTyoE4GYWp4@carbon>
 <20220422234820.plusgyixgybebfmi@moria.home.lan>
 <YmNH/fh8OwTJ6ASC@carbon>
 <20220423004607.q4lbz2mplkhlbyhm@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423004607.q4lbz2mplkhlbyhm@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 22-04-22 20:46:07, Kent Overstreet wrote:
> On Fri, Apr 22, 2022 at 05:27:41PM -0700, Roman Gushchin wrote:
[...]
> > > In my experience, it's rare to be _so_ out of memory that small kmalloc
> > > allocations are failing - we'll be triggering the show_mem() report before that
> > > happens.
> > 
> > I agree. However the OOM killer _has_ to make the progress even in such rare
> > circumstances.

Absolutely agreed!

> Oh, and the concern is allocator recursion? Yeah, that's a good point.

No, not really. The oom killer is running with PF_MEMALLOC context so no
reclaim recursion is allowed. As I've already pointed out in other
reply the context will have access to memory reserves without any
constrains so it could deplete them completely resulting in other issues
during the recovery.

> Do you know if using memalloc_noreclaim_(save|restore) is sufficient for that,
> or do we want GFP_ATOMIC? I'm already using GFP_ATOMIC for allocations when we
> generate the report on slabs, since we're taking the slab mutex there.

No it's not. You simply _cannot_ allocate from the oom context.
-- 
Michal Hocko
SUSE Labs
