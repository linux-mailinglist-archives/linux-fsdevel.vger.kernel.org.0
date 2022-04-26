Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F337950F2DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 09:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbiDZHnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 03:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344275AbiDZHne (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:43:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEB6BB4;
        Tue, 26 Apr 2022 00:40:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1D235210FC;
        Tue, 26 Apr 2022 07:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650958826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wMAdxJZJ6A0n7iKNAeF0d/axVH6mYUkchW85fLcAB0I=;
        b=rOpfkgxOFp21qgWpq0YAojVkCTCU3fM7vqtzuV2Al7un1+Vk4WynSRLQWOMYOWFHXRpgv2
        FYW/QW9rrJdGaWTSJSVGw8UuH+1PC97ffapuceZA5eUO3xDoKwGgJ5ElcFI6ooeVhCym+4
        IVn5UYD4FHQqY5y0FDFN0ENWJ8QTNBo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A0A272C142;
        Tue, 26 Apr 2022 07:40:25 +0000 (UTC)
Date:   Tue, 26 Apr 2022 09:40:23 +0200
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
Message-ID: <Ymeh51L7XGTeCkDG@dhcp22.suse.cz>
References: <20220421234837.3629927-14-kent.overstreet@gmail.com>
 <YmKma/1WUvjjbcO4@dhcp22.suse.cz>
 <YmLFPJTyoE4GYWp4@carbon>
 <20220422234820.plusgyixgybebfmi@moria.home.lan>
 <YmNH/fh8OwTJ6ASC@carbon>
 <20220423004607.q4lbz2mplkhlbyhm@moria.home.lan>
 <YmZpuikkgWeF2RPt@dhcp22.suse.cz>
 <20220425152811.pg2dse4zybpnpaa4@moria.home.lan>
 <Ymeck8AaTwaB29KS@dhcp22.suse.cz>
 <20220426072612.7wgpzndigr4ybrh4@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426072612.7wgpzndigr4ybrh4@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-04-22 03:26:12, Kent Overstreet wrote:
[...]
> Anyways, the reason I think this allocation is fine is it's GFP_NOWAIT and it's
> completely fine if it fails - all we lose is some diagnostics, and also it's
> released right away.

I think you are still missing the PF_MEMALLOC point. Please have a look
how this leads to no reclaim recursion so GFP_NOWAIT has no meaning when
you are allocating from PF_MEMALLOC context (which the oom killer and
any reclaim path is). Also have a look at how __gfp_pfmemalloc_flags
makes the allocation request from that context ALLOC_NO_WATERMARKS.
See?
-- 
Michal Hocko
SUSE Labs
