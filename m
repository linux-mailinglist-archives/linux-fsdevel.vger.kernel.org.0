Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899456C6547
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 11:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjCWKjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 06:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCWKic (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:38:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659683757A;
        Thu, 23 Mar 2023 03:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HBrCuNH4R5xVEUODXfgFvseYVrpNbKOLURA5BAjbAEs=; b=nWqyk/EtC9rse1gAdHYp4M8ESS
        Z7Y5w49+4TDL9y3/5lTTaPWGhh7CgpiGCWXi6DtQlXOZ06TYKSd9LJvdXO4ni7mb6mn2re/JUof9J
        8mgZM1/jgPcsd7lyXn8PJrMfBjxuut+uRyJj88Rqomtvo9cVs5/S0ZyI2wO2IobLbqLIQ/hMvWPMA
        aYL+FYr4CA5H9EbkWlre4jdMIsVgacLp6OmLcOTtng8XcOdr6OEveylnTVkF6PnOfkFymhDN0ZuSo
        EV947OC+1f+JCYcZ3b02bBYCDMe0IIDXMftx1qYl0pK97z3OFXdAwHJfiihd2e6FMBFxxX/xAAv0x
        mElzawHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfIII-001aoD-02;
        Thu, 23 Mar 2023 10:35:42 +0000
Date:   Thu, 23 Mar 2023 03:35:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     senozhatsky@chromium.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        willy@infradead.org, brauner@kernel.org, akpm@linux-foundation.org,
        minchan@kernel.org, hubcap@omnibond.com, martin@omnibond.com,
        mcgrof@kernel.org, devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC v2 1/5] zram: remove zram_page_end_io function
Message-ID: <ZBwrfT8TA5GC5+RH@infradead.org>
References: <20230322135013.197076-1-p.raghav@samsung.com>
 <CGME20230322135015eucas1p1bd186e83b322213cc852c4ad6eb47090@eucas1p1.samsung.com>
 <20230322135013.197076-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322135013.197076-2-p.raghav@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 02:50:09PM +0100, Pankaj Raghav wrote:
> -	if (!parent)
> -		bio->bi_end_io = zram_page_end_io;
> -	else
> +	if (parent)

I don't think a non-chained bio without and end_io handler can work.
This !parent case seems to come from writeback_store, and as far as
I can tell is broken already in the current code as it just fires
off an async read without ever waiting for it, using an on-stack bio
just to make things complicated.

The bvec reading code in zram is a mess, but I have an idea how
to clean it up with a little series that should also help with
this issue.
