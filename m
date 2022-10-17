Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EC360130E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 17:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiJQP4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 11:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJQP4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:56:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B7C5F127;
        Mon, 17 Oct 2022 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2vk4i5KDs+xhL9RL/prStipv82/5xCos0ckR6/mPo+o=; b=mkPEvM7rzQdNNDo31xw8Y6OxZk
        lpFKq0VgEJENhd+31JfDc8e2WKl8zTZ/9oWiNn9kEBgwXN4uifVfUKHdE77ELhL7ySFemwUJFADPM
        LKtYoPfakztqEu3KcdbxEN12BF3OGuWeLGD8qOIRO0dmaf0+OekQEAj66+RVavqFk7b8tsxMd9f8G
        FiCTjhnyGj/yBnNbvfpNl9V0cUFG4JOxti4ZRVI8se9YEWwnKjAiMTWDwZXmbCQEIZTXdniBwOOH8
        gP7jDTHXq9XqJN4y1sQzb+h/zBnTeX76gFxdTVVNRun1hyX4xliuo6GZd0qs49k0GXhR4zl5th4Lz
        4FoseLjw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okSSz-009xFa-M3; Mon, 17 Oct 2022 15:55:49 +0000
Date:   Mon, 17 Oct 2022 16:55:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <Y017BeC64GDb3Kg7@casper.infradead.org>
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org>
 <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 01:34:13PM +0800, Zhaoyang Huang wrote:
> On Fri, Oct 14, 2022 at 8:12 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Oct 14, 2022 at 01:30:48PM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Bellowing RCU stall is reported where kswapd traps in a live lock when shrink
> > > superblock's inode list. The direct reason is zombie page keeps staying on the
> > > xarray's slot and make the check and retry loop permanently. The root cause is unknown yet
> > > and supposed could be an xa update without synchronize_rcu etc. I would like to
> > > suggest skip this page to break the live lock as a workaround.
> >
> > No, the underlying bug should be fixed.

    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> OK, could I move the xas like below?
> 
> +     if (!folio_try_get_rcu(folio)) {
> +             xas_next_offset(xas);
>               goto reset;
> +     }
