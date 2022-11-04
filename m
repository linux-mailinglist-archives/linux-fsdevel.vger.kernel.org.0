Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC5E618F36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 04:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKDDla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 23:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiKDDlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:41:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356766462;
        Thu,  3 Nov 2022 20:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oBraij3g5ji43elo3yXvyW32eRnryWmjdGGzmQZla2I=; b=b0cyMAOUC7DP1K2wtWFd64GoOZ
        SFAxMPr05E2eg1plVgVM7tiWDS+/yAT8F590izey5nxGa3aRemXypXT3Dn0Adm/2t+XDX4BLuvLU/
        sw4YLZy9fO6xhcTlR+riD22/1Sv+8wKXimy8AC14BXH1/EfZEyWChHwEteTmY88yuCTjC3VO9sxAI
        xWB0V67+mxhJDAOq4NTL/eEB9aSsyi8d5WkWZNjRCSJk/K/0qucxPLNQHGJ+drLXNVkpIOzS0PzUZ
        2bsCyJiwkggjR/FmnHz2Wt8zvbADnI0CE4rSwOA2oA/+w+WbLTb0kMfuhTTV9zch/OWM6QJu2oe2z
        eVaTPXuw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqnZb-0072RF-Cu; Fri, 04 Nov 2022 03:40:51 +0000
Date:   Fri, 4 Nov 2022 03:40:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     George Law <glaw@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix missing xas_retry() calls in xarray iteration
Message-ID: <Y2SJw7w1IsIik3nb@casper.infradead.org>
References: <166751120808.117671.15797010154703575921.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166751120808.117671.15797010154703575921.stgit@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 09:33:28PM +0000, David Howells wrote:
> +++ b/fs/netfs/buffered_read.c
> @@ -46,10 +46,15 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
>  
>  	rcu_read_lock();
>  	xas_for_each(&xas, folio, last_page) {
> -		unsigned int pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
> -		unsigned int pgend = pgpos + folio_size(folio);
> +		unsigned int pgpos, pgend;

"unsigned int" assumes that the number of bytes isn't going to exceed 32
bits.  I tend to err on the side of safety here and use size_t.

>  		bool pg_failed = false;
>  
> +		if (xas_retry(&xas, folio))
> +			continue;
> +
> +		pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
> +		pgend = pgpos + folio_size(folio);

What happens if start_page is somewhere inside folio?  Seems to me
that pgend ends up overhanging into the next folio?
