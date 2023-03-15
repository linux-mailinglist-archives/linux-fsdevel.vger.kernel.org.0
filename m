Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0326E6BB90A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 17:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCOQG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 12:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCOQGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:06:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AEA87A19;
        Wed, 15 Mar 2023 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LemH/L8r2JaTZW4Kj2EjaBRWtIOBQhwvYigOva+l0PM=; b=a9CDszIpr2YISddgNRMXQAn4xA
        MJf6XCK9PumL5aatchYlNFQqp9ILg7TZ3w5eNBee+5MyBZvIu/LQsZUAg/1m66B93T39k+CanOJ5L
        GM4tUup3okoF1a7ZGAWu70KS9HRn8WoN1o9t8yz0amg9nfhFE022O87lOxbyy3bkrvQvuKLnU3BG2
        9cPvXsOfZ4uVh+8rx7WKzt6gW7hIjX5/wuqb21KjP3PGNh6Vgy2ytTZM5XxRDVu05DwD2yy1tYWCb
        jJ5pcU+271Bs6PnaLVRnjSAbIraDYq/8OklpvVzme75x7fJGgIKmI6UT0KoXG2G6rNFzF8sf7nm9Q
        PfPIQV3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcTd0-00DyFu-Rk; Wed, 15 Mar 2023 16:05:26 +0000
Date:   Wed, 15 Mar 2023 16:05:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     hubcap@omnibond.com, senozhatsky@chromium.org, martin@omnibond.com,
        minchan@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        axboe@kernel.dk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, mcgrof@kernel.org, devel@lists.orangefs.org
Subject: Re: [RFC PATCH 3/3] orangefs: use folio in orangefs_readahead()
Message-ID: <ZBHsxjjXUrgLhrWo@casper.infradead.org>
References: <20230315123233.121593-1-p.raghav@samsung.com>
 <CGME20230315123236eucas1p1116e1b8537191310bd03dd267b9f8eb8@eucas1p1.samsung.com>
 <20230315123233.121593-4-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315123233.121593-4-p.raghav@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 15, 2023 at 01:32:33PM +0100, Pankaj Raghav wrote:
> Use folio and its corresponding function in orangefs_readahead() so that
> folios can be directly passed to the folio_endio().

This is wrong; you need to drop the call to folio_put().

>  	/* clean up. */
> -	while ((page = readahead_page(rac))) {
> -		folio_endio(page_folio(page), false, ret);
> -		put_page(page);
> +	while ((folio = readahead_folio(rac))) {
> +		folio_endio(folio, false, ret);
> +		folio_put(folio);
>  	}
