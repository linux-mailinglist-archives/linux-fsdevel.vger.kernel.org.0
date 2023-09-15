Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF44A7A26DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 21:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjIOTEC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 15:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbjIOTDn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:03:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6504BB2;
        Fri, 15 Sep 2023 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DFFZh6035wvtRcIoOVwiEivYJp4WLElf/LkEGCccAuY=; b=qis9C4C42q4PXv0Y8mijuIrGJ8
        eL/+ltxOleMFDTZMsHDEkMTfMcmjwlVfRCljoxKsiGDbU44p35poIZc9NCMFng5gLawCnYZk5wvBS
        M3pSisA0y7eiQ/d7P31tXJHfk87IayXbpxQkHI+y3wpSw60dxRVqQatMUcvlkMgqkyuTdbxwJLKJF
        aCsFmhb0R8gIavgA5Xqln2EQibbmmtpOQGnx8Thbib2xYjMxaCOSNXVcDNwKPJLYH1RmR3G2O1D1G
        ZjR0akbrdkJMCX9dfh9GaV5qjFNIRA5OcEbxAYtEY4t7UArbD8wRpLaFu0PMbyVtQWU6mSdCUKK3o
        hcojstjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhE5y-00BUiD-2B; Fri, 15 Sep 2023 19:03:14 +0000
Date:   Fri, 15 Sep 2023 20:03:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <kernel@pankajraghav.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        mcgrof@kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 01/23] fs: Allow fine-grained control of folio sizes
Message-ID: <ZQSqctT6k7uKQHmF@casper.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <20230915183848.1018717-2-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915183848.1018717-2-kernel@pankajraghav.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:38:26PM +0200, Pankaj Raghav wrote:
> +static inline void mapping_set_folio_orders(struct address_space *mapping,
> +					    unsigned int min, unsigned int max)
> +{
> +	/*
> +	 * XXX: max is ignored as only minimum folio order is supported
> +	 * currently.
> +	 */

I think we need some sanity checking ...

	if (min == 1)
		min = 2;
	if (max < min)
		max = min;
	if (max > MAX_PAGECACHE_ORDER)
		max = MAX_PAGECACHE_ORDER;

> +	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
> +			 (min << AS_FOLIO_ORDER_MIN) |
> +			 (MAX_PAGECACHE_ORDER << AS_FOLIO_ORDER_MAX);
> +}
