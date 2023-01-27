Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD5D67F25B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jan 2023 00:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjA0Xlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 18:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA0Xlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:41:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D0E39BA2;
        Fri, 27 Jan 2023 15:41:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 764A761DDA;
        Fri, 27 Jan 2023 23:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB59C433D2;
        Fri, 27 Jan 2023 23:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674862894;
        bh=RbVGajs8rZXEWNrRSlxeJ7fwrlT9Dgw5+K1Rp9h+h4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ro+uKYmshrZ8CiYOEUAYY+duHGCJ0qckwiDm1l0S0dMwYcfdRcg9uLSmWl2zzshrZ
         /xlSJuqHQJHoyuE3IgYYpKnOwBlalhEYnKrZd5O+eOUVRHc746CM/v1e8hNcZrCIHw
         P5iuONiKJWREQlOVJ+Mm4cNELWfZciPyxY1M/4QMvi0w0ZABMGqUkrodi8S0pC04O7
         PT77P+wibsw5OrEW8d3FiqD6mTBL/Qtzw1eYsMR2JNO0jb3S8MBD97YCfRRYlnW+yO
         c2SIYT8jv8t9T19zLvzZQAnBm8+rzAWG3agEz3pNIpeQp9vxLkTeoFbJVQxBhQODBe
         na7wKnbhPOaKg==
Date:   Fri, 27 Jan 2023 15:41:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fscrypt: support decrypting data from large folios
Message-ID: <Y9RhIwSzUE0/tbo/@sol.localdomain>
References: <20230127224202.355629-1-ebiggers@kernel.org>
 <Y9RfZaGoQ07UkD6w@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9RfZaGoQ07UkD6w@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:33:57PM +0000, Matthew Wilcox wrote:
> On Fri, Jan 27, 2023 at 02:42:02PM -0800, Eric Biggers wrote:
> > +++ b/fs/buffer.c
> > @@ -307,8 +307,8 @@ static void decrypt_bh(struct work_struct *work)
> >  	struct buffer_head *bh = ctx->bh;
> >  	int err;
> >  
> > -	err = fscrypt_decrypt_pagecache_blocks(bh->b_page, bh->b_size,
> > -					       bh_offset(bh));
> > +	err = fscrypt_decrypt_pagecache_blocks(page_folio(bh->b_page),
> > +					       bh->b_size, bh_offset(bh));
> 
> FYI, Andrew's been carrying "buffer: add b_folio as an alias of b_page"
> in his tree since mid-December.  buffer_heads always point to the
> head page, aka folio.
> 
> This all looks good to me.
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Indeed, but it's not upstream yet, so I decided to use page_folio() for now to
avoid a cross-tree dependency.

- Eric
