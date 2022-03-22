Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFCC4E44A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 18:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiCVRG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 13:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiCVRG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:06:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D5E59;
        Tue, 22 Mar 2022 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e6u86QrrFQ7usesxm14f5416orKnbME+ZYyiXSDZccc=; b=oUZGH4/ColHKYt58ouWBYR/4qU
        DhTlw/fWf0BNLcfnWfLjOP+lwol/8i6f5MNDd4mZafk6PyH9wgmQ8u1ftnM8agWwcFyXl0tYNMHZh
        OSr1iOyEqQ1eJG572qgYt10ILN9c73UAgCBM9HjqB5veGHx0yVxZqPt3lnFZyLu2VlOZy3Xg7pINk
        YwFf2fVflEnxfZJA2sSrtB4XVXFW52O4dA0dyW/1pB53BMaqueAlgP7mM/fQChooMiVhiOoOcwc1z
        UKWf8Erh46pysIHK/KcwMN3zbaf+sP4OmqYTzyxLMA1g7uedqSZH0Qz0m+2xpu9QZL9NHU6F+bwbU
        a8GlfK9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWhvy-00BmKW-HY; Tue, 22 Mar 2022 17:04:38 +0000
Date:   Tue, 22 Mar 2022 17:04:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Message-ID: <YjoBpm8mUHX/w/rK@casper.infradead.org>
References: <YjiX5oXYkmN6WrA3@casper.infradead.org>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <YjiAVezd5B9auhcP@casper.infradead.org>
 <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com>
 <YjiLACenpRV4XTcs@casper.infradead.org>
 <adb957da-8909-06d8-1b2c-b8a293b37930@linux.alibaba.com>
 <1035025.1647876652@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035025.1647876652@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 21, 2022 at 03:30:52PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > Absolutely; just use xa_lock() to protect both setting & testing the
> > flag.
> 
> How should Jeffle deal with xarray dropping the lock internally in order to do
> an allocation and then taking it again (actually in patch 5)?

There are a number of ways to handle this.  I'll outline two; others
are surely possible.

option 1:

add side:

xa_lock();
if (!DEAD)
	xa_store(GFP_KERNEL);
	if (DEAD)
		xa_erase();
xa_unlock();

destroy side:

xa_lock();
set DEAD;
xa_for_each()
	xa_erase();
xa_unlock();

That has the problem (?) that it might be temporarily possible to see
a newly-added entry in a DEAD array.

If that is a problem, you can use xa_reserve() on the add side, followed
by overwriting it or removing it, depending on the state of the DEAD flag.

If you really want to, you can decompose the add side so that you always
check the DEAD flag before doing the store, ie:

do {
	xas_lock();
	if (DEAD)
		xas_set_error(-EINVAL);
	else
		xas_store();
	xas_unlock();
} while (xas_nomem(GFP_KERNEL));

