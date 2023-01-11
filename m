Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCCE66503E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 01:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjAKALy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 19:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjAKALx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:11:53 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C88158828;
        Tue, 10 Jan 2023 16:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=83/1hc4GIAzp3RRcp3O6STjFhrO/7VopQc76WMmclm0=; b=PPy3ABTUBloTVcNArOAlLVXBkd
        S20e/51Hrmi2Xz2wkvnlU2SuWqc4nGvrXqagL3hGiuaOcbCJGs2nkBLEM3KrwxSNf4bFJOTDhMYYk
        PNRu9Ul24E3yNeEIzCJ+xxLc/UBu5xD18ZUE4jwkYgnERmvsC3p++BsG+hdymAykvoE+sa4Y3tiEN
        hQXN94StCaZncBrh0OhAsnRcUrUM++iTQo0Dml1/+FFZyiPL5HzmnUXUHk5K+nuxeO8G9DpmBKWrE
        U0jUJ2iO0zK+RlZS9HYchVbbgqKcypJyRx7DIUQvlX16iZZvqXDB7TWJWfvO4EN5z2IMr9rlWz857
        BPKeIMUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFOia-0015h9-2Q;
        Wed, 11 Jan 2023 00:11:48 +0000
Date:   Wed, 11 Jan 2023 00:11:48 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v2] fs/aio: Replace kmap{,_atomic}() with
 kmap_local_page()
Message-ID: <Y73+xKXDELSd14p1@ZenIV>
References: <20230109175629.9482-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109175629.9482-1-fmdefrancesco@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 06:56:29PM +0100, Fabio M. De Francesco wrote:

> -	ring = kmap_atomic(ctx->ring_pages[0]);
> +	ring = kmap_local_page(ctx->ring_pages[0]);
>  	ring->nr = nr_events;	/* user copy */
>  	ring->id = ~0U;
>  	ring->head = ring->tail = 0;
> @@ -575,7 +575,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
>  	ring->compat_features = AIO_RING_COMPAT_FEATURES;
>  	ring->incompat_features = AIO_RING_INCOMPAT_FEATURES;
>  	ring->header_length = sizeof(struct aio_ring);
> -	kunmap_atomic(ring);
> +	kunmap_local(ring);
>  	flush_dcache_page(ctx->ring_pages[0]);

I wonder if it would be more readable as memcpy_to_page(), actually...
>  
>  	return 0;
> @@ -678,9 +678,9 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
>  					 * we are protected from page migration
>  					 * changes ring_pages by ->ring_lock.
>  					 */
> -					ring = kmap_atomic(ctx->ring_pages[0]);
> +					ring = kmap_local_page(ctx->ring_pages[0]);
>  					ring->id = ctx->id;
> -					kunmap_atomic(ring);
> +					kunmap_local(ring);

Incidentally, does it need flush_dcache_page()?
