Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31E26E24DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDNN4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 09:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjDNN4c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:56:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738F0B440;
        Fri, 14 Apr 2023 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uV+XYY5M3RiINYeFePo3Mw428wUkDdAGAuIh9HbihLU=; b=EY1gdrnuV8Pcz7OrjfDTgvAM5d
        ttQJHwwR29r08aEE1oa9hyYRfEDy1162MKZfVwuei3O6b+BEtXV2g1IOhnVljijREtZkF/HSymIB5
        Q0mzGPVprAu0AC/ELmNU6YK1v7wVIqhdjb0O76B3i/WHOiAXtq2XZvkIod3vBVuiTxDyVSnmmGGFt
        4z+seGjV7oNpriysatUUQCuO74I5F7NNvpZhwfcH/bVtg5pv5TtMWYcrvVer4ZtntbygqEWHm4754
        2F7/dArbgksI/ErOC6bCaE5fFlPRyDz2uLS9VxnO9sFMLP3kU4qDu8Jv4gF5KIQDtov3OPW97EjJK
        VKNrfEGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnJub-008naW-G2; Fri, 14 Apr 2023 13:56:25 +0000
Date:   Fri, 14 Apr 2023 14:56:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH] mm/filemap: allocate folios according to the blocksize
Message-ID: <ZDlbidnLtgYGMXie@casper.infradead.org>
References: <20230414134908.103932-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414134908.103932-1-hare@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 03:49:08PM +0200, Hannes Reinecke wrote:
> If the blocksize is larger than the pagesize allocate folios
> with the correct order.

I think you also need to get the one in page_cache_ra_unbounded()
and page_cache_ra_order() also needs some love?

It might help to put an assertion in __filemap_add_folio() to be sure
we're not doing something unacceptable.
