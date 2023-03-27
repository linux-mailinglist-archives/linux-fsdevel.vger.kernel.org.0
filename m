Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C2E6CA57E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 15:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjC0NWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 09:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC0NWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:22:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762AE2115;
        Mon, 27 Mar 2023 06:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=fH4smwPHRiVa7TGs7DCKXtMMv1fgPx9ekgSrrULhXRw=; b=uJtQZbZtgUkFKAXzuTq24xuavA
        jkzSALXJgBKrW78KgAeA+B97AC7AegN8sbBoD2TM/OPLqCnjU6sRgskzcdw52DTU3S+M0nfJAimYN
        3jGt6MkRARRSetZcpBUE34lYQssP6if9quGEf1/WQQTrXrJPsembG4F5ORIRQ/1Yl4ucNjE6UobP9
        dXxonE/EyQBVl6BsUz3l9TC8MgY+u0P6wSe5e8bu1OIJR0AGBGxOaWJK2JSghEAx3H88kLxd8xaHZ
        RrypCILYHPqnHx5VxGSNpKmaS4EL9YRuC3Xz7xXfsi/AFutY1oHo43Rab4a7vwOybiZHAd6P3dhv5
        ZQb7SfrA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pgmoA-007QMi-7a; Mon, 27 Mar 2023 13:22:46 +0000
Date:   Mon, 27 Mar 2023 14:22:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v3] fs/aio: Replace kmap{,_atomic}() with
 kmap_local_page()
Message-ID: <ZCGYps2z5IlaEaxU@casper.infradead.org>
References: <20230119162055.20944-1-fmdefrancesco@gmail.com>
 <2114426.VsPgYW4pTa@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2114426.VsPgYW4pTa@suse>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 12:08:20PM +0200, Fabio M. De Francesco wrote:
> On giovedì 19 gennaio 2023 17:20:55 CEST Fabio M. De Francesco wrote:
> > The use of kmap() and kmap_atomic() are being deprecated in favor of
> > kmap_local_page().
> > 
> > There are two main problems with kmap(): (1) It comes with an overhead as
> > the mapping space is restricted and protected by a global lock for
> > synchronization and (2) it also requires global TLB invalidation when the
> > kmap’s pool wraps and it might block when the mapping space is fully
> > utilized until a slot becomes available.
> > 
> > With kmap_local_page() the mappings are per thread, CPU local, can take
> > page faults, and can be called from any context (including interrupts).
> > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > the tasks can be preempted and, when they are scheduled to run again, the
> > kernel virtual addresses are restored and still valid.
> > 
> > The use of kmap_local_page() in fs/aio.c is "safe" in the sense that the
> > code don't hands the returned kernel virtual addresses to other threads
> > and there are no nesting which should be handled with the stack based
> > (LIFO) mappings/un-mappings order. Furthermore, the code between the old
> > kmap_atomic()/kunmap_atomic() did not depend on disabling page-faults
> > and/or preemption, so that there is no need to call pagefault_disable()
> > and/or preempt_disable() before the mappings.
> > 
> > Therefore, replace kmap() and kmap_atomic() with kmap_local_page() in
> > fs/aio.c.

Or should we just stop allocating aio rings from HIGHMEM and remove
the calls to kmap()?  How much memory are we talking about here?
