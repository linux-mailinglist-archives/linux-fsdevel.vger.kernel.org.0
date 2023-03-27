Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6386CA5B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 15:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjC0NY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 09:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjC0NYj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:24:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F1D5FE1;
        Mon, 27 Mar 2023 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=RLzmFr8AmbjIY1B1jEN0btaao1pVMqT2Dh1OkNlg1IM=; b=kZE665LhpJ3pAkpkQurCtqXGr3
        3ns14crmk1+cSV3MbJ381mXQgOVruGRvb0wNz6zz0OWOrD+mymMFNQhzD5qB4YlOKjyklu6nqm6N1
        OxJAHqaBZAGvOYqhVubOZ0pQci0Fe2P6ntLZp0+G3hrS4oTPKlM4IvDxW06wGHxhfnZL0rgIXKcGQ
        u0EQovuNQNfH3oZ91DVUoB3NR5BlFDVzTwTCpTwaQ6AspmC/PimietJjPZLnOYbp3WfRffIO/BQI+
        /4tfsenPBcqrfX3Z9vjvbnuRBHhlGKiwgZ6XNUAYUvGFlCl2mau/rw+73gPHEBvbxRWHsvCaPq+oV
        bYib1JZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pgmp3-007QOk-NL; Mon, 27 Mar 2023 13:23:41 +0000
Date:   Mon, 27 Mar 2023 14:23:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] fs/ufs: Replace kmap() with kmap_local_page
Message-ID: <ZCGY3c5avRefahms@casper.infradead.org>
References: <20221229225100.22141-1-fmdefrancesco@gmail.com>
 <11383508.F0gNSz5aLb@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11383508.F0gNSz5aLb@suse>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 12:13:08PM +0200, Fabio M. De Francesco wrote:
> On giovedì 29 dicembre 2022 23:50:56 CEST Fabio M. De Francesco wrote:
> > kmap() is being deprecated in favor of kmap_local_page().
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
> > Since its use in fs/ufs is safe everywhere, it should be preferred.
> > 
> > Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
> > requires the mapping address, so return that address from ufs_get_page()
> > to be used in ufs_put_page().
> 
> Hi Al,
> 
> I see that this series is here since Dec 29, 2022.
> Is there anything that prevents its merging? 
> Can you please its four patches in your tree?

I'm pretty sure UFS directories should simply be allocated from lowmem.
There's really no reason to put them in highmem these days.
