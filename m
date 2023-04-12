Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880016DFA78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDLPlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 11:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjDLPlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:41:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05087DBF;
        Wed, 12 Apr 2023 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S+JPhOC4mHSW7Yql8JWRNkc2K96tHyEjqwlM7RJtLSE=; b=gBzCukKQ4bWrpsCivmFA++zJi4
        JcoxoSh6eWewNUxaf+yEnzSFEhTStPhSsVyeAAfKsN6nSt0yYBFl/xNDDmSmk6OhLOB3ZfLVRKS/G
        k33+gTJZGBlELnVWBJfX1g4EhDg+7nHzPLepSNyJx98qz2q2RsrNkabH4FL2wfANj7LEcbCEJX4pU
        NND3HRha2bVsuYStdRRds3OVQq+2qpvaErKjQVtMlCitmiZStDSYb3uA8lLB47SAleeD/es2HFom2
        t5iULsH9MbGQifwgz1foqKxttSo5MTPulBQOgyCRrlroPSfF6uMycsiFhPmageHcszhEhcCBoZIhc
        BHy6Bkhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmca4-006zfX-GL; Wed, 12 Apr 2023 15:40:20 +0000
Date:   Wed, 12 Apr 2023 16:40:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     david@redhat.com, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        viacheslav.dubeyko@bytedance.com, dan.j.williams@intel.com,
        seungjun.ha@samsung.com, wj28.lee@samsung.com
Subject: Re: FW: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL memory
Message-ID: <ZDbQ5O7LAmGbhqFw@casper.infradead.org>
References: <f4f9eedf-c514-3388-29ad-dcb497a19303@redhat.com>
 <CGME20230412111034epcas2p1b46d2a26b7d3ac5db3b0e454255527b0@epcas2p1.samsung.com>
 <20230412111033.434644-1-ks0204.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412111033.434644-1-ks0204.kim@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 12, 2023 at 08:10:33PM +0900, Kyungsan Kim wrote:
> Pinning and plubbability is mutual exclusive so it can not happen at the same time.
> What we argue is ZONE_EXMEM does not "confine movability". an allocation context can determine the movability attribute.
> Even one unmovable allocation will make the entire CXL DRAM unpluggable. 
> When you see ZONE_EXMEM just on movable/unmoable aspect, we think it is the same with ZONE_NORMAL,
> but ZONE_EXMEM works on an extended memory, as of now CXL DRAM.
> 
> Then why ZONE_EXMEM is, ZONE_EXMEM considers not only the pluggability aspect, but CXL identifier for user/kenelspace API, 
> the abstraction of multiple CXL DRAM channels, and zone unit algorithm for CXL HW characteristics.
> The last one is potential at the moment, though.
> 
> As mentioned in ZONE_EXMEM thread, we are preparing slides to explain experiences and proposals.
> It it not final version now[1].
> [1] https://github.com/OpenMPDK/SMDK/wiki/93.-%5BLSF-MM-BPF-TOPIC%5D-SMDK-inspired-MM-changes-for-CXL

The problem is that you're starting out with a solution.  Tell us what
your requirements are, at a really high level, then walk us through
why ZONE_EXMEM is the best way to satisfy those requirements.

Also, those slides are terrible.  Even at 200% zoom, the text is tiny.

There is no MAP_NORMAL argument to mmap(), there are no GFP flags to
sys_mmap() and calling mmap() does not typically cause alloc_page() to
be called.  I'm not sure that putting your thoughts onto slides is
making them any better organised.
