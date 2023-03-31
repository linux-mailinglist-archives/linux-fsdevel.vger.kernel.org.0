Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA566D218F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 15:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjCaNmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 09:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjCaNmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:42:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773E9B459;
        Fri, 31 Mar 2023 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5I4KJmBZJA/j7wJDLeyLVxjH0xULgErbT1T9v7RMqcs=; b=J/R1MzB9Wucb7Y6h+C/8TofVal
        hbhTT7g+hEVNm07PTNpHSf2Du4f34BaxCv43dkaCIAFZNVLIAdvUgF+Lqcb9h/MwsXqmTMWnZyJgM
        nDrGhAf8V4j8Np89cjjY8HFZxl8gSOL1hTkM4SH5yItR6AaN+g+O09BX+TUxpGjKY920nIXIuCe0m
        SZRbZcHvbXlGqyhMcCA6uQ7a/95YZq1h/Mo7eLK2W3h4SkQM/4ppupkR59gw5PkRaqluZun0O3eBn
        jAyDFK9BTcd2lY6+YqDbpuC+u+XBpI+2GCLkpoWg67lhHKo3hh7glr7YiRNqXMDJv6OBBtCzhwkBo
        i7Sk8wIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1piF1S-00BSqh-9A; Fri, 31 Mar 2023 13:42:30 +0000
Date:   Fri, 31 Mar 2023 14:42:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     david@redhat.com, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        viacheslav.dubeyko@bytedance.com, dan.j.williams@intel.com,
        seungjun.ha@samsung.com, wj28.lee@samsung.com
Subject: Re: RE: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Message-ID: <ZCbjRsmoy1acVN0Z@casper.infradead.org>
References: <7c7933df-43da-24e3-2144-0551cde05dcd@redhat.com>
 <CGME20230331114220epcas2p2d5734efcbdd8956f861f8e7178cd5288@epcas2p2.samsung.com>
 <20230331114220.400297-1-ks0204.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331114220.400297-1-ks0204.kim@samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 31, 2023 at 08:42:20PM +0900, Kyungsan Kim wrote:
> Given our experiences/design and industry's viewpoints/inquiries,
> I will prepare a few slides in the session to explain 
>   1. Usecase - user/kernespace memory tiering for near/far placement, memory virtualization between hypervisor/baremetal OS
>   2. Issue - movability(movable/unmovable), allocation(explicit/implicit), migration(intented/unintended)
>   3. HW - topology(direct, switch, fabric), feature(pluggability,error-handling,etc)

I think you'll find everybody else in the room understands these issues
rather better than you do.  This is hardly the first time that we've
talked about CXL, and CXL is not the first time that people have
proposed disaggregated memory, nor heterogenous latency/bandwidth
systems.  All the previous attempts have failed, and I expect this
one to fail too.  Maybe there's something novel that means this time
it really will work, so any slides you do should focus on that.

A more profitable discussion might be:

1. Should we have the page allocator return pages from CXL or should
   CXL memory be allocated another way?
2. Should there be a way for userspace to indicate that it prefers CXL
   memory when it calls mmap(), or should it always be at the discretion
   of the kernel?
3. Do we continue with the current ZONE_DEVICE model, or do we come up
   with something new?

