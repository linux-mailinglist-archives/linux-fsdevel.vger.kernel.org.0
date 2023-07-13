Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BC57517AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 06:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjGMEqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 00:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbjGMEqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:46:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A225210A;
        Wed, 12 Jul 2023 21:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9471F61A21;
        Thu, 13 Jul 2023 04:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A7CC433C8;
        Thu, 13 Jul 2023 04:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689223559;
        bh=CVdaU3qbMuVNwFTXmDG9OBUnultd43nLJ7Ze2Guc+xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ina4QbF8y8iptModPQTMHaixEG0sLH7vCDGVO2RhvdlG+8YLxGVj1JZVAt49l7h4M
         TvSri7XtDKiSyCSQt4+HLHYYnX1OSEZvR6aqh2sLn8ADAPR4TCYjR5xh/qhR8RKpoY
         C5DKKnFa7gp09v2wUwJEwppOV+k7uQo7VHV5ZNmV1NCaDFoU/S2wt4PC/kL5gLWTVA
         lY/19ZQ74RSjtFive+jPgRBJ8rGRwKTfR0/QkullftSs3RTuqkC4s179V/PXODrnT8
         H3G2oFWzHHzvyyCbd48HtKyj1/hz8CgrBf1KDzNEpK3OF/SJODrv+rUD5DmHqCuzJ1
         xalnb1nwDZSQQ==
Date:   Wed, 12 Jul 2023 21:45:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 5/9] iomap: Remove unnecessary test from
 iomap_release_folio()
Message-ID: <20230713044558.GJ108251@frogsfrogsfrogs>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710130253.3484695-6-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[add ritesh]

On Mon, Jul 10, 2023 at 02:02:49PM +0100, Matthew Wilcox (Oracle) wrote:
> The check for the folio being under writeback is unnecessary; the caller
> has checked this and the folio is locked, so the folio cannot be under
> writeback at this point.
> 
> The comment is somewhat misleading in that it talks about one specific
> situation in which we can see a dirty folio.  There are others, so change
> the comment to explain why we can't release the iomap_page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 1cb905140528..7aa3009f907f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -483,12 +483,11 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
>  			folio_size(folio));
>  
>  	/*
> -	 * mm accommodates an old ext3 case where clean folios might
> -	 * not have had the dirty bit cleared.  Thus, it can send actual
> -	 * dirty folios to ->release_folio() via shrink_active_list();
> -	 * skip those here.
> +	 * If the folio is dirty, we refuse to release our metadata because
> +	 * it may be partially dirty.  Once we track per-block dirty state,
> +	 * we can release the metadata if every block is dirty.

Ritesh: I'm assuming that implementing this will be part of your v12 series?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  	 */
> -	if (folio_test_dirty(folio) || folio_test_writeback(folio))
> +	if (folio_test_dirty(folio))
>  		return false;
>  	iomap_page_release(folio);
>  	return true;
> -- 
> 2.39.2
> 
