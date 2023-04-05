Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9366D72AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 05:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbjDEDLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 23:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjDEDLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 23:11:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CB42D6D;
        Tue,  4 Apr 2023 20:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5OMR/DemraSw2hx3UAvYwKTMUItmtQlsxgGJIH9tmko=; b=sngL0nSC9ueDyLjO5W0PXcKLuq
        Yga2ovC7tImUrPpGqysnibDPeIOwv7vxW2iYk2ivm/56k94r5BIZcEqjIuBUkVXiipDpqTDz98cJf
        9uQOiJ6Z0+fsfle7yghxgJ7V8Z2GCOXuTOIw0K30rxroysvFbhu+W4LrMP4XWkW9zZ01SVhmQKht/
        qJR+OY/kR5xWfunwDyRNTOaUyTzP7l3iL98S9oCsQIEkqkKsLgkvSJ7GWKiiiRYal7VeA9UGfEC+8
        FlBHYSYsRRRE1hYavBMfLESq3bwtyFenSrjGKuxYYR7iC8BbuBmkojrQDKvZ7kBZDrHB8Jo5PyCyF
        azkbklCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjtYI-00FzSa-1Y; Wed, 05 Apr 2023 03:11:14 +0000
Date:   Wed, 5 Apr 2023 04:11:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: Re: Re: RE: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Message-ID: <ZCzm0oeXXQKpuwQy@casper.infradead.org>
References: <ZCbjRsmoy1acVN0Z@casper.infradead.org>
 <CGME20230405020121epcas2p2d9d39c151b6c5ab9e568ab9e2ab826ce@epcas2p2.samsung.com>
 <20230405020121.413658-1-ks0204.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405020121.413658-1-ks0204.kim@samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 05, 2023 at 11:01:21AM +0900, Kyungsan Kim wrote:
> >1. Should we have the page allocator return pages from CXL or should
> >   CXL memory be allocated another way?
> I think yes. Using CXL DRAM as System RAM interface would be the primary use case in real-world application in regards to compatibility.
> So, on the System RAM interface, we think it should be managed by Linux MM subsystem. (Node - Zonelist - buddy page allocator)

I don't think this is the right approach.

> >2. Should there be a way for userspace to indicate that it prefers CXL
> >   memory when it calls mmap(), or should it always be at the discretion
> >   of the kernel?
> I think yes. Both implcit and explict ways are meaningful for users on a different purpose.
> The dynamic performance variation of CXL DRAM is likely bigger than other memory types due to the topology expansion and link negotiation.
> I think it strengthens the needs.

I also disagree with your answer here.

> >3. Do we continue with the current ZONE_DEVICE model, or do we come up
> >   with something new?
> In fact, ZONE_DEVICE was the our first candidate for CXL DRAM.
> But because ZONE_DEVICE is not managed by buddy, we thought it does not fit to provide System RAM interface.

But what you're proposing (separate GFP_EXMEM, ZONE_EXMEM, etc) doesn't
let the buddy allocator satisfy GFP_KERNEL allocations from CXL.  So
what's the point?

